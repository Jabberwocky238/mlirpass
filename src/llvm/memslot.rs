//! The `llvm` dialect's memory-slot interfaces, as `LLVMMemorySlot.cpp`: `llvm.alloca` allocates,
//! loads, stores and the memory intrinsics read and write, casts, no-op GEPs and the lifetime /
//! invariant / debug intrinsics only need their uses gone.

use alloc::borrow::Cow;
use alloc::format;
use alloc::vec::Vec;

use mlirformat::llvm_types::LlvmType;
use mlirformat::{llvm, Attribute, ShapedKind, Type};

use crate::transforms::{Deletion, LlvmSlots, MemorySlot, Promotable};
use crate::{Body, DataLayout, OpId, Rewriter, TypedOp, Use, ValueId};

/// How an op takes part in promotion.
#[derive(Clone, Copy, PartialEq, Eq)]
enum Role {
    Alloca,
    Load,
    Store,
    Memset,
    /// `memcpy`-like: memcpy, memcpy.inline, memmove.
    Memcpy,
    /// Deleted once its results' uses are (`forwardToUsers`).
    Forward,
    /// Deleted outright.
    Drop,
    DbgValue,
}

impl Role {
    fn of(b: &Body<'_>, op: OpId) -> Option<Self> {
        Some(match &*b[op].name {
            "llvm.alloca" => Self::Alloca,
            "llvm.load" => Self::Load,
            "llvm.store" => Self::Store,
            "llvm.intr.memset" | "llvm.intr.memset.inline" => Self::Memset,
            "llvm.intr.memcpy" | "llvm.intr.memcpy.inline" | "llvm.intr.memmove" => Self::Memcpy,
            "llvm.bitcast" | "llvm.addrspacecast" | "llvm.intr.launder.invariant.group" | "llvm.intr.strip.invariant.group" => Self::Forward,
            "llvm.getelementptr" if b.dense_i64(op, "rawConstantIndices").iter().all(|i| *i == 0) => Self::Forward,
            "llvm.intr.lifetime.start" | "llvm.intr.lifetime.end" | "llvm.intr.invariant.start" | "llvm.intr.invariant.end" | "llvm.intr.dbg.declare" => Self::Drop,
            "llvm.intr.dbg.value" => Self::DbgValue,
            _ => return None,
        })
    }

    fn mem(self) -> bool {
        matches!(self, Self::Load | Self::Store | Self::Memset | Self::Memcpy)
    }
}

/// Type facts the conversions need.
struct Ty;

impl Ty {
    fn is_ptr(t: &Type<'_>) -> bool {
        matches!(LlvmType::try_from(t), Ok(LlvmType::Ptr(_)))
    }

    /// `isSupportedTypeForConversion`.
    fn convertible(t: &Type<'_>) -> bool {
        match t {
            Type::Shaped(s) if s.kind == ShapedKind::Vector => !Self::is_ptr(&s.elem) && !s.shape.iter().flatten().any(|d| matches!(d, mlirformat::Dim::Scalable(_))),
            _ => !matches!(LlvmType::try_from(t), Ok(LlvmType::Struct { .. } | LlvmType::Array(..))),
        }
    }

    /// `areConversionCompatible`.
    fn compatible(dl: &DataLayout, target: &Type<'_>, src: &Type<'_>, narrowing: bool) -> bool {
        if target == src {
            return true;
        }
        if !Self::convertible(target) || !Self::convertible(src) {
            return false;
        }
        let (t, s) = (dl.size(target), dl.size(src));
        if Self::is_ptr(target) && Self::is_ptr(src) {
            return t == s;
        }
        if narrowing { t <= s } else { t >= s }
    }

    fn int(bits: u64) -> Type<'static> {
        Type::int(bits as u32)
    }

    /// An integer attribute of integer type `ty` holding the low bits of `v`, as MLIR prints it.
    fn int_attr<'a>(v: u128, ty: &Type<'a>) -> Attribute<'a> {
        let Type::Integer { width: bits, .. } = ty else { unreachable!("an integer type") };
        let shift = 128 - bits;
        Attribute::Int { lit: Cow::Owned(format!("{}", ((v << shift) as i128) >> shift)), ty: Some(ty.clone()) }
    }

    fn width(t: &Type<'_>) -> Option<u64> {
        match t {
            Type::Integer { width, .. } => Some(u64::from(*width)),
            Type::Float(_) => t.bit_width().map(u64::from),
            _ => None,
        }
    }
}

impl<'a> Rewriter<'_, 'a> {
    /// `createOrFold` of a typed op; its result.
    fn slot_fold(&mut self, op: &impl TypedOp) -> ValueId {
        let (data, types) = op.split();
        self.create_or_fold(data, &types)[0]
    }

    /// `create` of a typed op; its first result.
    fn slot_emit(&mut self, op: &impl TypedOp) -> ValueId {
        let o = self.emit(op);
        self.body[o].results[0]
    }

    fn ty(&self, v: ValueId) -> Type<'a> {
        self.body[v].ty.clone()
    }

    /// `castToSameSizedInt`.
    fn to_same_sized_int(&mut self, dl: &DataLayout, v: ValueId) -> ValueId {
        let t = self.ty(v);
        if matches!(t, Type::Integer { .. }) {
            return v;
        }
        let int = Ty::int(dl.size_in_bits(&t));
        if Ty::is_ptr(&t) { self.slot_fold(&llvm::PtrToIntOp::new(v.into(), t, int)) } else { self.slot_fold(&llvm::BitcastOp::new(v.into(), t, int)) }
    }

    /// `castIntValueToSameSizedType`.
    fn int_to(&mut self, v: ValueId, target: &Type<'a>) -> ValueId {
        let t = self.ty(v);
        if &t == target {
            return v;
        }
        if Ty::is_ptr(target) { self.slot_fold(&llvm::IntToPtrOp::new(v.into(), None, t, target.clone())) } else { self.slot_fold(&llvm::BitcastOp::new(v.into(), t, target.clone())) }
    }

    /// `castSameSizedTypes`.
    fn same_sized(&mut self, dl: &DataLayout, v: ValueId, target: &Type<'a>) -> ValueId {
        let t = self.ty(v);
        if &t == target {
            return v;
        }
        if Ty::is_ptr(&t) && Ty::is_ptr(target) {
            return self.slot_fold(&llvm::AddrSpaceCastOp::new(v.into(), t, target.clone()));
        }
        let int = self.to_same_sized_int(dl, v);
        self.int_to(int, target)
    }

    /// `createExtractAndCast`: the low (little endian) or high (big endian) bits of `v`.
    fn extract_and_cast(&mut self, dl: &DataLayout, v: ValueId, target: &Type<'a>) -> ValueId {
        let vt = self.ty(v);
        let (src, dst) = (dl.size_in_bits(&vt), dl.size_in_bits(target));
        if src == dst {
            return self.same_sized(dl, v, target);
        }
        let mut int = self.to_same_sized_int(dl, v);
        if dl.big_endian() {
            // As upstream: the shift applies to `v` itself, typed as `v`.
            let by = self.slot_emit(&llvm::ConstantOp::new(Ty::int_attr(u128::from(src - dst), &vt), vt.clone()));
            int = self.slot_fold(&llvm::LShrOp::new(v.into(), by.into(), false, vt));
        }
        let it = self.ty(int);
        let trunc = self.slot_emit(&llvm::TruncOp::new(int.into(), Ty::int_attr(0, &Type::int(32)), it, Ty::int(dst)));
        self.int_to(trunc, target)
    }

    /// `createInsertAndCast`: `v` into the bits of `reaching` a store to its address writes.
    fn insert_and_cast(&mut self, dl: &DataLayout, v: ValueId, reaching: ValueId) -> ValueId {
        let rt = self.ty(reaching);
        let (value_bits, slot_bits) = (dl.size_in_bits(&self.ty(v)), dl.size_in_bits(&rt));
        if value_bits == slot_bits {
            return self.same_sized(dl, v, &rt);
        }
        let def = self.to_same_sized_int(dl, reaching);
        let value = self.to_same_sized_int(dl, v);
        let (dt, vt) = (self.ty(def), self.ty(value));
        let mut value = self.slot_fold(&llvm::ZExtOp::new(value.into(), false, vt, dt.clone()));
        let diff = slot_bits - value_bits;
        let mask = if dl.big_endian() {
            let by = self.slot_emit(&llvm::ConstantOp::new(Ty::int_attr(u128::from(diff), &dt), dt.clone()));
            value = self.slot_fold(&llvm::ShlOp::new(value.into(), by.into(), Ty::int_attr(0, &Type::int(32)), dt.clone()));
            (1u128 << diff) - 1
        } else {
            !((1u128 << value_bits) - 1)
        };
        let mask = self.slot_emit(&llvm::ConstantOp::new(Ty::int_attr(mask, &dt), dt.clone()));
        let masked = self.slot_fold(&llvm::AndOp::new(def.into(), mask.into(), dt.clone()));
        let combined = self.slot_fold(&llvm::OrOp::new(masked.into(), value.into(), false, dt));
        self.int_to(combined, &rt)
    }

    /// `llvm.intr.dbg.value` of `v` for the variable `declare` describes.
    fn dbg_value(&mut self, declare: OpId, v: ValueId) {
        let var = self.body[declare].get("varInfo").cloned().expect("a declared variable");
        let expr = self.body[declare].get("locationExpr").cloned();
        let t = self.ty(v);
        self.emit(&llvm::DbgValueOp::new(v.into(), var, expr, t));
    }

    /// `memsetGetStored`: the slot's value after a memset of its whole size.
    fn memset_value(&mut self, op: OpId, slot: &MemorySlot<'a>) -> ValueId {
        let val = self.body[op].operands[1];
        let width = Ty::width(&slot.elem).expect("checked by canUsesBeRemoved");
        let int = Ty::int(width);
        let v = if let Some(byte) = self.body.const_index(val) {
            let byte = (byte as u128) & 0xff;
            let pattern = (0..width / 8).fold(0u128, |acc, k| acc | (byte << (8 * k)));
            self.slot_emit(&llvm::ConstantOp::new(Ty::int_attr(pattern, &int), int.clone()))
        } else if width == 8 {
            val
        } else {
            let mut cur = self.slot_emit(&llvm::ZExtOp::new(val.into(), false, Type::int(8), int.clone()));
            let mut covered = 8;
            while covered < width {
                let by = self.slot_emit(&llvm::ConstantOp::new(Ty::int_attr(u128::from(covered), &int), int.clone()));
                let shifted = self.slot_emit(&llvm::ShlOp::new(cur.into(), by.into(), Ty::int_attr(0, &Type::int(32)), int.clone()));
                cur = self.slot_emit(&llvm::OrOp::new(cur.into(), shifted.into(), false, int.clone()));
                covered *= 2;
            }
            cur
        };
        if matches!(slot.elem, Type::Float(_)) { self.slot_emit(&llvm::BitcastOp::new(v.into(), int, slot.elem.clone())) } else { v }
    }
}

impl Body<'_> {
    /// The single blocking use is of the slot pointer.
    fn only_slot_use(&self, slot: &MemorySlot<'_>, blocking: &[Use]) -> bool {
        matches!(blocking, [u] if self[u.op].operands[u.index as usize] == slot.ptr)
    }
}

impl Promotable for LlvmSlots {
    fn dialect(&self) -> &str {
        "llvm"
    }

    fn promotable_slots<'a>(&self, b: &Body<'a>, op: OpId) -> Option<Vec<MemorySlot<'a>>> {
        if Role::of(b, op)? != Role::Alloca {
            return None;
        }
        let block = b[op].parent?;
        if b[block].parent.map(|r| b[r].blocks[0]) != Some(block) {
            return Some(Vec::new());
        }
        let Some(Attribute::Type(elem)) = b[op].get("elem_type") else { return Some(Vec::new()) };
        Some(alloc::vec![MemorySlot { ptr: b[op].results[0], elem: elem.clone() }])
    }

    fn default_value<'a>(&self, rw: &mut Rewriter<'_, 'a>, _alloc: OpId, slot: &MemorySlot<'a>) -> ValueId {
        rw.slot_emit(&llvm::UndefOp::new(slot.elem.clone()))
    }

    fn handle_block_argument<'a>(&self, rw: &mut Rewriter<'_, 'a>, alloc: OpId, _slot: &MemorySlot<'a>, arg: ValueId) {
        let r = rw.body[alloc].results[0];
        let declares: Vec<OpId> = rw.body[r].uses.iter().rev().map(|u| u.op).filter(|o| rw.body[*o].name == "llvm.intr.dbg.declare").collect();
        for d in declares {
            rw.dbg_value(d, arg);
        }
    }

    fn handle_promotion_complete<'a>(&self, rw: &mut Rewriter<'_, 'a>, alloc: OpId, _slot: &MemorySlot<'a>, default: Option<ValueId>) -> Option<OpId> {
        if let Some(d) = default.filter(|d| rw.body[*d].uses.is_empty())
            && let Some(o) = rw.body.def_op(d)
        {
            rw.body.erase(o);
        }
        rw.body.drop_result_uses(alloc);
        rw.body.erase(alloc);
        None
    }

    fn is_mem_op(&self, b: &Body<'_>, op: OpId) -> bool {
        Role::of(b, op).is_some_and(Role::mem)
    }

    fn loads_from<'a>(&self, b: &Body<'a>, op: OpId, slot: &MemorySlot<'a>) -> bool {
        match Role::of(b, op) {
            Some(Role::Load) => b[op].operands[0] == slot.ptr,
            Some(Role::Memcpy) => b[op].operands[1] == slot.ptr,
            _ => false,
        }
    }

    fn stores_to<'a>(&self, b: &Body<'a>, op: OpId, slot: &MemorySlot<'a>) -> bool {
        match Role::of(b, op) {
            Some(Role::Store) => b[op].operands[1] == slot.ptr,
            Some(Role::Memset | Role::Memcpy) => b[op].operands[0] == slot.ptr,
            _ => false,
        }
    }

    fn stored<'a>(&self, rw: &mut Rewriter<'_, 'a>, op: OpId, slot: &MemorySlot<'a>, reaching: ValueId) -> ValueId {
        match Role::of(rw.body, op) {
            Some(Role::Store) => {
                let v = rw.body[op].operands[0];
                let dl = DataLayout::closest(rw.body, op);
                rw.insert_and_cast(&dl, v, reaching)
            }
            Some(Role::Memset) => rw.memset_value(op, slot),
            Some(Role::Memcpy) => {
                let src = rw.body[op].operands[1];
                let st = rw.ty(src);
                rw.slot_emit(&llvm::LoadOp::new(src.into(), None, false, false, false, false, llvm::AtomicOrdering::NotAtomic, None, None, None, None, None, None, st, slot.elem.clone()))
            }
            _ => unreachable!("not a storing op"),
        }
    }

    fn can_uses_be_removed<'a>(&self, b: &Body<'a>, op: OpId, slot: Option<&MemorySlot<'a>>, blocking: &[Use], new_blocking: &mut Vec<Use>) -> Option<bool> {
        let role = Role::of(b, op)?;
        let forward = |new: &mut Vec<Use>| {
            for r in &b[op].results {
                new.extend(b[*r].uses.iter().rev().copied());
            }
            true
        };
        let dl = DataLayout::closest(b, op);
        Some(match (role, slot) {
            (Role::Forward, None) => forward(new_blocking),
            (Role::Drop, None) => true,
            (Role::DbgValue, None) => matches!(blocking, [u] if u.index == 0),
            (Role::Load, Some(s)) => b.only_slot_use(s, blocking) && b[op].operands[0] == s.ptr && Ty::compatible(&dl, &b[b[op].results[0]].ty, &s.elem, true) && b[op].get("volatile_").is_none(),
            (Role::Store, Some(s)) => {
                let (value, addr) = (b[op].operands[0], b[op].operands[1]);
                b.only_slot_use(s, blocking) && addr == s.ptr && value != s.ptr && Ty::compatible(&dl, &s.elem, &b[value].ty, false) && b[op].get("volatile_").is_none()
            }
            (Role::Memset, Some(s)) => Ty::width(&s.elem).is_some_and(|w| w % 8 == 0 && w > 0) && !b.is_volatile(op) && b.mem_intr_len(op) == Some(dl.size(&s.elem)),
            (Role::Memcpy, Some(_)) if b[op].operands[0] == b[op].operands[1] => false,
            (Role::Memcpy, Some(s)) => !b.is_volatile(op) && b.mem_intr_len(op) == Some(dl.size(&s.elem)),
            _ => return None,
        })
    }

    fn remove_blocking_uses<'a>(&self, rw: &mut Rewriter<'_, 'a>, op: OpId, slot: Option<&MemorySlot<'a>>, _blocking: &[Use], reaching: Option<ValueId>) -> Deletion {
        match Role::of(rw.body, op) {
            Some(Role::Load) => {
                let (r, def) = (rw.body[op].results[0], reaching.expect("a reaching definition"));
                let t = rw.ty(r);
                let dl = DataLayout::closest(rw.body, op);
                let new = rw.extract_and_cast(&dl, def, &t);
                rw.replace_all_uses(r, new);
                Deletion::Delete
            }
            Some(Role::Memcpy) => {
                let slot = slot.expect("a memory op's slot");
                if self.loads_from(rw.body, op, slot) {
                    let (def, dst) = (reaching.expect("a reaching definition"), rw.body[op].operands[0]);
                    let (vt, dt) = (rw.ty(def), rw.ty(dst));
                    rw.emit(&llvm::StoreOp::new(def.into(), dst.into(), None, false, false, false, llvm::AtomicOrdering::NotAtomic, None, None, None, None, None, vt, dt));
                }
                Deletion::Delete
            }
            Some(Role::DbgValue) => {
                // An undef keeps the variable's debug info: "optimized out".
                let v = rw.body[op].operands[0];
                rw.set_before(op);
                let t = rw.ty(v);
                let undef = rw.slot_emit(&llvm::UndefOp::new(t));
                rw.body.set_operand(op, 0, undef);
                Deletion::Keep
            }
            _ => Deletion::Delete,
        }
    }

    fn requires_replaced_values(&self, b: &Body<'_>, op: OpId) -> bool {
        b[op].name == "llvm.intr.dbg.declare"
    }

    fn visit_replaced_values<'a>(&self, rw: &mut Rewriter<'_, 'a>, op: OpId, replaced: &[(OpId, ValueId)]) {
        for (at, v) in replaced {
            rw.set_after(*at);
            rw.dbg_value(op, *v);
        }
    }
}

