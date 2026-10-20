//! The `llvm` dialect's memory-slot interfaces, as `LLVMMemorySlot.cpp`: `llvm.alloca` allocates,
//! loads, stores and the memory intrinsics read and write, casts, no-op GEPs and the lifetime /
//! invariant / debug intrinsics only need their uses gone.

use alloc::borrow::Cow;
use alloc::format;
use alloc::vec::Vec;

use mlirformat::llvm::{AllocaOp, ConstantOp, GEPOp, MemcpyInlineOp, MemcpyOp, MemmoveOp, MemsetInlineOp, MemsetOp};
use mlirformat::llvm_types::LlvmType;
use mlirformat::{llvm, Attribute, ShapedKind, Type, Value};

use crate::transforms::{Deletion, Destructurable, DestructurableMemorySlot, LlvmSlots, MemorySlot, Promotable, Slots};
use crate::{Body, Const, DataLayout, OpData, OpId, Rewriter, TypedOp, Use, ValueId};

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

// ---- the `llvm` dialect's destructuring interfaces (`LLVMMemorySlot.cpp`) -----------------

/// A memory intrinsic `Ty` from its operands, none of the optional attributes.
macro_rules! intr {
    ($ty:ident($a:expr, $b:expr, $len:expr, $vol:expr; $($t:expr),*)) => {
        $ty::new(Value::from($a), Value::from($b), $len, $vol, None, None, None, None, None, None, $($t),*)
    };
}

/// How an op takes part in destructuring (`Role`: in promotion).
#[derive(Clone, Copy, PartialEq, Eq)]
enum Access {
    Alloca,
    Load,
    Store,
    Gep,
    Memset,
    MemsetInline,
    Memcpy,
    MemcpyInline,
    Memmove,
}

impl Access {
    fn of(b: &Body<'_>, op: OpId) -> Option<Self> {
        Some(match &*b[op].name {
            "llvm.alloca" => Self::Alloca,
            "llvm.load" => Self::Load,
            "llvm.store" => Self::Store,
            "llvm.getelementptr" => Self::Gep,
            "llvm.intr.memset" => Self::Memset,
            "llvm.intr.memset.inline" => Self::MemsetInline,
            "llvm.intr.memcpy" => Self::Memcpy,
            "llvm.intr.memcpy.inline" => Self::MemcpyInline,
            "llvm.intr.memmove" => Self::Memmove,
            _ => return None,
        })
    }

    fn memset(self) -> bool {
        matches!(self, Self::Memset | Self::MemsetInline)
    }

    /// The length is the `len` attribute, not an operand.
    fn inline(self) -> bool {
        matches!(self, Self::MemsetInline | Self::MemcpyInline)
    }
}

/// `LLVM::kGEPConstantBitWidth`.
const GEP_CONSTANT_BITS: u32 = 29;

/// `SubslotAccessInfo`: the parent slot's index an access falls into, and its offset in there.
struct SubslotAccess {
    index: u64,
    offset: u64,
}

impl<'a> Body<'a> {
    /// An integer constant (`m_ConstantInt`) of at most 64 bits.
    fn int_of(a: &Attribute<'_>) -> Option<u64> {
        let i = Const::try_from(a).ok().filter(|c| !c.elements)?.as_int()?;
        (i.width <= 64).then(|| i.unsigned() as u64)
    }

    fn type_attr(&self, op: OpId, name: &str) -> Option<Type<'a>> {
        match self[op].get(name)? {
            Attribute::Type(t) => Some(t.clone()),
            _ => None,
        }
    }

    fn is_llvm_ptr(&self, v: ValueId) -> bool {
        matches!(LlvmType::try_from(&self[v].ty), Ok(LlvmType::Ptr(_)))
    }

    /// A memory intrinsic's length, as an attribute (`createMemsetLenAttr`).
    fn intr_len(&self, op: OpId) -> Option<Attribute<'a>> {
        match Access::of(self, op)?.inline() {
            true => self[op].get("len").cloned(),
            false => self.constant_of(self[op].operands[2]),
        }
    }

    /// `definitelyWritesOnlyWithinSlot`.
    fn writes_within(&self, dl: &DataLayout, op: OpId, slot: &MemorySlot<'_>) -> bool {
        self.is_llvm_ptr(slot.ptr) && self[op].operands[0] == slot.ptr && self.mem_intr_len(op).is_some_and(|l| l <= dl.size(&slot.elem))
    }

    /// `gepToByteOffset`.
    fn gep_offset(&self, dl: &DataLayout, op: OpId) -> Option<u64> {
        let raw = self[op].get("rawConstantIndices").and_then(Attribute::dense_values).unwrap_or_default();
        // A dynamic index (`kDynamicIndex`) is negative too.
        let indices: Vec<u64> = raw.into_iter().map(|i: i64| u64::try_from(i).ok()).collect::<Option<_>>()?;
        let mut ty = self.type_attr(op, "elem_type")?;
        let mut offset = indices[0] * dl.size(&ty);
        for &i in &indices[1..] {
            ty = match LlvmType::try_from(&ty).ok()? {
                LlvmType::Array(_, et) => {
                    offset += i * dl.size(&et);
                    *et
                }
                LlvmType::Struct { packed, body: Some(body), .. } => {
                    for e in &body[..=i as usize] {
                        if !packed {
                            offset = offset.next_multiple_of(dl.abi_align(e));
                        }
                        offset += dl.size(e);
                    }
                    let e = body.into_iter().nth(i as usize)?;
                    offset -= dl.size(&e);
                    e
                }
                _ => return None,
            };
        }
        Some(offset)
    }

    /// `getSubslotAccessInfo`: `None` when out of bounds or into padding.
    fn subslot_access(&self, dl: &DataLayout, slot: &MemorySlot<'_>, op: OpId) -> Option<SubslotAccess> {
        let offset = self.gep_offset(dl, op)?;
        let in_bounds = |index: u64, offset| (index < 1 << GEP_CONSTANT_BITS).then_some(SubslotAccess { index, offset });
        if offset >= dl.size(&slot.elem) {
            return None;
        }
        match LlvmType::try_from(&slot.elem).ok()? {
            LlvmType::Array(_, et) => {
                let size = dl.size(&et);
                in_bounds(offset / size, offset % size)
            }
            LlvmType::Struct { packed, body: Some(body), .. } => {
                let mut start = 0u64;
                for (index, e) in body.iter().enumerate() {
                    if !packed {
                        start = start.next_multiple_of(dl.abi_align(e));
                        if offset < start {
                            return None;
                        }
                    }
                    if offset < start + dl.size(e) {
                        return in_bounds(index as u64, offset - start);
                    }
                    start += dl.size(e);
                }
                None
            }
            _ => None,
        }
    }
}

/// The `i32` index of a struct field or array element.
impl<'a> From<u64> for Subslot<'a> {
    fn from(i: u64) -> Self {
        Subslot(Attribute::integer(i128::from(i), Type::int(32)))
    }
}

/// An index into an `llvm` aggregate: an `i32` integer attribute.
struct Subslot<'a>(Attribute<'a>);

impl<'a> Subslot<'a> {
    fn find<'s, T>(&self, in_: &'s [(Attribute<'a>, T)]) -> Option<&'s T> {
        in_.iter().find(|(k, _)| *k == self.0).map(|(_, t)| t)
    }

    /// Inserts into `usedIndices`.
    fn use_in(self, used: &mut Vec<Attribute<'a>>) {
        if !used.contains(&self.0) {
            used.push(self.0);
        }
    }
}

impl<'r, 'a> Rewriter<'r, 'a> {
    /// `memsetRewire`.
    fn memset_rewire(&mut self, dl: &DataLayout, op: OpId, slot: &DestructurableMemorySlot<'a>, subslots: &[(Attribute<'a>, MemorySlot<'a>)]) {
        let b = &*self.body;
        let inline = Access::of(b, op).is_some_and(Access::inline);
        let len_attr = b.intr_len(op).expect("a constant length");
        let len_ty = match &len_attr {
            Attribute::Int { ty: Some(t), .. } => t.clone(),
            _ => unreachable!("an integer length"),
        };
        let len = Body::int_of(&len_attr).expect("an integer length");
        let packed = matches!(LlvmType::try_from(&slot.slot.elem), Ok(LlvmType::Struct { packed: true, .. }));
        let (val, vol) = (b[op].operands[1], b[op].get("isVolatile").cloned().unwrap_or(Attribute::Bool(false)));
        let mut covered = 0u64;
        for (i, (_, elem)) in slot.subelements.iter().enumerate() {
            if !packed {
                covered = covered.next_multiple_of(dl.abi_align(elem));
            }
            if covered >= len {
                break;
            }
            if let Some(sub) = Subslot::from(i as u64).find(subslots) {
                let n = Attribute::integer(i128::from((len - covered).min(dl.size(elem))), len_ty.clone());
                let (ptr_ty, val_ty) = (self.body[sub.ptr].ty.clone(), self.body[val].ty.clone());
                if inline {
                    self.emit(&intr!(MemsetInlineOp(sub.ptr, val, n, vol.clone(); ptr_ty, val_ty)));
                } else {
                    let c = self.emit(&ConstantOp::new(n, len_ty.clone()));
                    let c = Value::from(self.body[c].results[0]);
                    self.emit(&intr!(MemsetOp(sub.ptr, val, c, vol.clone(); ptr_ty, val_ty, len_ty.clone())));
                }
            }
            covered += dl.size(elem);
        }
    }

    /// `memcpyRewire`: one copy per subslot, through a gep into the other side.
    fn memcpy_rewire(&mut self, dl: &DataLayout, op: OpId, slot: &DestructurableMemorySlot<'a>, subslots: &[(Attribute<'a>, MemorySlot<'a>)]) {
        let b = &*self.body;
        let role = Access::of(b, op).expect("a memcpy-like op");
        let (dst, src) = (b[op].operands[0], b[op].operands[1]);
        let is_dst = slot.slot.ptr == dst;
        let other = if is_dst { src } else { dst };
        let vol = b[op].get("isVolatile").cloned().unwrap_or(Attribute::Bool(false));
        let len_ty = match b.intr_len(op) {
            Some(Attribute::Int { ty: Some(t), .. }) => t,
            _ => b[b[op].operands[2]].ty.clone(),
        };
        let ptr = LlvmType::ptr();
        for i in 0..slot.subelements.len() as u64 {
            let Some(sub) = Subslot::from(i).find(subslots) else { continue };
            let gep = GEPOp::new(Value::from(other), Vec::new(), Attribute::dense_i32(&[0, i]), Attribute::Type(slot.slot.elem.clone()), Attribute::integer(0, Type::int(32)), ptr.clone(), Vec::new(), ptr.clone());
            let gep = self.emit(&gep);
            let in_other = self.body[gep].results[0];
            let (d, s) = if is_dst { (sub.ptr, in_other) } else { (in_other, sub.ptr) };
            let n = Attribute::integer(i128::from(dl.size(&sub.elem)), len_ty.clone());
            if role == Access::MemcpyInline {
                self.emit(&intr!(MemcpyInlineOp(d, s, n, vol.clone(); ptr.clone(), ptr.clone())));
                continue;
            }
            let c = self.emit(&ConstantOp::new(n, len_ty.clone()));
            let c = Value::from(self.body[c].results[0]);
            match role {
                Access::Memcpy => self.emit(&intr!(MemcpyOp(d, s, c, vol.clone(); ptr.clone(), ptr.clone(), len_ty.clone()))),
                _ => self.emit(&intr!(MemmoveOp(d, s, c, vol.clone(); ptr.clone(), ptr.clone(), len_ty.clone()))),
            };
        }
    }
}

impl Destructurable for LlvmSlots {
    fn dialect(&self) -> &str {
        "llvm"
    }

    fn subelements<'a>(&self, ty: &Type<'a>) -> Option<Vec<(Attribute<'a>, Type<'a>)>> {
        let index = |(i, t)| (Subslot::from(i as u64).0, t);
        match LlvmType::try_from(ty).ok()? {
            LlvmType::Struct { body, .. } => Some(body.unwrap_or_default().into_iter().enumerate().map(index).collect()),
            // `maxArraySizeForDestructuring`.
            LlvmType::Array(n, _) if n > 16 => None,
            LlvmType::Array(n, et) => Some((0..n as usize).map(|i| index((i, (*et).clone()))).collect()),
            _ => None,
        }
    }

    fn type_at<'a>(&self, ty: &Type<'a>, at: &Attribute<'a>) -> Option<Type<'a>> {
        if !matches!(at, Attribute::Int { ty: Some(t), .. } if *t == Type::int(32)) {
            return None;
        }
        let i = usize::try_from(Const::try_from(at).ok()?.as_int()?.signed()).ok()?;
        match LlvmType::try_from(ty).ok()? {
            LlvmType::Struct { body, .. } => body.unwrap_or_default().into_iter().nth(i),
            LlvmType::Array(n, et) => (i < n as usize).then_some(*et),
            _ => None,
        }
    }

    fn destructurable_slots<'a>(&self, cx: Slots<'_>, b: &Body<'a>, op: OpId) -> Option<Vec<DestructurableMemorySlot<'a>>> {
        (Access::of(b, op)? == Access::Alloca).then_some(())?;
        let slot = || {
            let one = b.constant_of(b[op].operands[0]).and_then(|a| Body::int_of(&a)) == Some(1);
            let elem = b.type_attr(op, "elem_type").filter(|_| one)?;
            Some(DestructurableMemorySlot { subelements: cx.subelements(&elem)?, slot: MemorySlot { ptr: b[op].results[0], elem } })
        };
        Some(slot().into_iter().collect())
    }

    fn destructure<'a>(&self, cx: Slots<'_>, rw: &mut Rewriter<'_, 'a>, alloc: OpId, slot: &DestructurableMemorySlot<'a>, used: &[Attribute<'a>], allocators: &mut Vec<OpId>) -> Vec<(Attribute<'a>, MemorySlot<'a>)> {
        rw.set_after(alloc);
        let n = rw.body[alloc].operands[0];
        let n_ty = rw.body[n].ty.clone();
        let mut sub = |at: &Attribute<'a>| {
            let elem = cx.type_at(&slot.slot.elem, at).expect("used index must exist");
            let op = rw.emit(&AllocaOp::new(Value::from(n), None, Attribute::Type(elem.clone()), false, n_ty.clone(), LlvmType::ptr()));
            allocators.push(op);
            (at.clone(), MemorySlot { ptr: rw.body[op].results[0], elem })
        };
        used.iter().map(&mut sub).collect()
    }

    fn handle_destructuring_complete<'a>(&self, rw: &mut Rewriter<'_, 'a>, alloc: OpId, _: &DestructurableMemorySlot<'a>) -> Option<OpId> {
        rw.erase_op(alloc);
        None
    }

    fn ensure_only_safe_accesses<'a>(&self, cx: Slots<'_>, b: &Body<'a>, op: OpId, slot: &MemorySlot<'a>, must_be_safe: &mut Vec<MemorySlot<'a>>) -> Option<bool> {
        let (dl, ops) = (cx.layout, &b[op].operands);
        Some(match Access::of(b, op)? {
            Access::Alloca => return None,
            Access::Load => ops[0] != slot.ptr || dl.size(&b[b[op].results[0]].ty) <= dl.size(&slot.elem),
            Access::Store => ops[1] != slot.ptr || dl.size(&b[ops[0]].ty) <= dl.size(&slot.elem),
            Access::Gep if ops[0] != slot.ptr => true,
            Access::Gep => {
                let size = dl.size(&slot.elem);
                let Some(offset) = b.gep_offset(dl, op).filter(|o| *o < size) else { return Some(false) };
                must_be_safe.push(MemorySlot { ptr: b[op].results[0], elem: LlvmType::array(size - offset, Type::int(8)) });
                true
            }
            _ => b.writes_within(dl, op, slot),
        })
    }

    fn is_accessor(&self, b: &Body<'_>, op: OpId) -> bool {
        Access::of(b, op).is_some_and(|r| r != Access::Alloca)
    }

    fn can_rewire<'a>(&self, cx: Slots<'_>, b: &Body<'a>, op: OpId, slot: &DestructurableMemorySlot<'a>, used: &mut Vec<Attribute<'a>>, must_be_safe: &mut Vec<MemorySlot<'a>>) -> bool {
        let (dl, ops, ptr) = (cx.layout, &b[op].operands, slot.slot.ptr);
        let Some(role) = Access::of(b, op) else { return false };
        match role {
            Access::Alloca => false,
            Access::Load | Access::Store => {
                // Storing the pointer itself cannot be dealt with.
                if b.is_volatile(op) || (role == Access::Store && ops[0] == ptr) {
                    return false;
                }
                // A load or store always accesses the first element of the destructured slot.
                let first = Subslot::from(0);
                let accessed = if role == Access::Load { &b[b[op].results[0]].ty } else { &b[ops[0]].ty };
                let fits = cx.subelements(&slot.slot.elem).and_then(|s| first.find(&s).map(|t| dl.size(accessed) <= dl.size(t)));
                fits == Some(true) && {
                    first.use_in(used);
                    true
                }
            }
            Access::Gep => {
                let Some(access) = (b.is_llvm_ptr(ops[0]) && ops[0] == ptr).then(|| b.subslot_access(dl, &slot.slot, op)).flatten() else { return false };
                let at = Subslot::from(access.index);
                let size = dl.size(at.find(&slot.subelements).expect("index in the slot"));
                at.use_in(used);
                // The rest of the subslot is accessed in bounds: a dummy slot of that size.
                must_be_safe.push(MemorySlot { ptr: b[op].results[0], elem: LlvmType::array(size - access.offset, Type::int(8)) });
                true
            }
            _ => {
                let all_i32 = slot.subelements.iter().all(|(k, _)| matches!(k, Attribute::Int { ty: Some(t), .. } if *t == Type::int(32)));
                if (role.memset() && LlvmType::try_from(&slot.slot.elem).is_err()) || b.is_volatile(op) || cx.subelements(&slot.slot.elem).is_none() || !all_i32 {
                    return false;
                }
                if role.memset() {
                    return b.writes_within(dl, op, &slot.slot);
                }
                // Only full copies are supported.
                if b.mem_intr_len(op) != Some(dl.size(&slot.slot.elem)) {
                    return false;
                }
                if ops[1] == ptr {
                    slot.subelements.iter().for_each(|(k, _)| Subslot(k.clone()).use_in(used));
                }
                true
            }
        }
    }

    fn rewire<'a>(&self, cx: Slots<'_>, rw: &mut Rewriter<'_, 'a>, op: OpId, slot: &DestructurableMemorySlot<'a>, subslots: &[(Attribute<'a>, MemorySlot<'a>)]) -> Deletion {
        let dl = cx.layout;
        match Access::of(rw.body, op).expect("an accessor") {
            role @ (Access::Load | Access::Store) => {
                let ptr = Subslot::from(0).find(subslots).expect("subslot 0").ptr;
                let at = usize::from(role == Access::Store);
                rw.modify(op, |b| b.set_operand(op, at, ptr));
                return Deletion::Keep;
            }
            Access::Gep => {
                let access = rw.body.subslot_access(dl, &slot.slot, op).expect("checked by can_rewire");
                let new = Subslot::from(access.index).find(subslots).expect("subslot").ptr;
                let res = rw.body[op].results[0];
                let flags = rw.body[op].get("noWrapFlags").cloned().unwrap_or(Attribute::integer(0, Type::int(32)));
                let gep = GEPOp::new(Value::from(new), Vec::new(), Attribute::dense_i32(&[access.offset]), Attribute::Type(Type::int(8)), flags, rw.body[new].ty.clone(), Vec::new(), rw.body[res].ty.clone());
                let (data, types) = OpData::of(&gep).expect("a gep has no regions");
                let to = rw.create_or_fold(data, &types)[0];
                rw.replace_all_uses(res, to);
            }
            r if r.memset() => rw.memset_rewire(dl, op, slot, subslots),
            _ if subslots.is_empty() => {}
            _ => rw.memcpy_rewire(dl, op, slot, subslots),
        }
        Deletion::Delete
    }
}
