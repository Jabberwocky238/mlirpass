//! `sroa`, as `SROA.cpp`: memory slots of aggregates split into one slot per used subelement.
//!
//! The dialects answer through [`Destructurable`] (`memslot.rs`): `llvm`'s at the end of this
//! file (`LLVMMemorySlot.cpp`), `memref`'s in `memref_slots.rs` (`MemRefMemorySlot.cpp`).
//!
//! Orders follow MLIR's: a value's uses are visited most recent first (its use list), and
//! `usedIndices` keeps the order indices were first inserted in (a small `SmallPtrSet`).

use alloc::collections::BTreeSet;
use alloc::vec::Vec;

use mlirpass_macros::pass;
use mlirformat::llvm::{AllocaOp, ConstantOp, GEPOp, MemcpyInlineOp, MemcpyOp, MemmoveOp, MemsetInlineOp, MemsetOp};
use mlirformat::llvm_types::LlvmType;
use mlirformat::{Attribute, Error, Type, Value};

use super::memref_slots::TestSlots;
use super::memslot::{Deletion, Destructurable, DestructurableMemorySlot, LlvmSlots, MemorySlot, MemrefSlots, Promotable, Slots};
use crate::{Body, Const, DataLayout, OpData, OpId, Quiet, Rewriter, Use, ValueId};

/// `MemorySlotDestructuringInfo`.
#[derive(Default)]
struct Info<'a> {
    /// `usedIndices`.
    used: Vec<Attribute<'a>>,
    /// `userToBlockingUses`, each user's uses ordered by operand.
    blocking: Vec<(OpId, Vec<Use>)>,
    /// Accessors that will rewire their uses.
    accessors: Vec<OpId>,
}

impl Info<'_> {
    fn block(&mut self, u: Use) {
        match self.blocking.iter_mut().find(|(op, _)| *op == u.op) {
            Some((_, uses)) => {
                if let Err(i) = uses.binary_search_by_key(&u.index, |x| x.index) {
                    uses.insert(i, u);
                }
            }
            None => self.blocking.push((u.op, alloc::vec![u])),
        }
    }
}

/// `tryToDestructureMemorySlots` and what it asks with.
struct Destructurer<'s> {
    cx: Slots<'s>,
    promotable: &'s [&'s dyn Promotable],
}

impl<'s> Destructurer<'s> {
    /// `computeDestructuringInfo`; `None` when `slot` cannot be destructured or nothing uses it.
    fn info<'a>(&self, b: &Body<'a>, slot: &DestructurableMemorySlot<'a>) -> Option<Info<'a>> {
        let ptr = slot.slot.ptr;
        if b[ptr].uses.is_empty() {
            return None;
        }
        let mut info = Info::default();
        let mut must_be_safe = Vec::new();
        for u in b.use_list(ptr) {
            if let Some(d) = b.destructurable(self.cx.dialects, u.op).filter(|d| d.is_accessor(b, u.op))
                && d.can_rewire(self.cx, b, u.op, slot, &mut info.used, &mut must_be_safe)
            {
                info.accessors.push(u.op);
                continue;
            }
            info.block(u);
        }

        let mut visited = BTreeSet::new();
        while let Some(sub) = must_be_safe.pop() {
            for u in b.use_list(sub.ptr) {
                if !visited.insert((u.op, u.index)) {
                    continue;
                }
                let safe = b.destructurable(self.cx.dialects, u.op).and_then(|d| d.ensure_only_safe_accesses(self.cx, b, u.op, &sub, &mut must_be_safe));
                if safe != Some(true) {
                    info.block(u);
                }
            }
        }

        for user in b.forward_slice(ptr) {
            let Some(at) = info.blocking.iter().position(|(op, _)| *op == user) else { continue };
            let p = b.promotable(self.promotable, user)?;
            let mut new_blocking = Vec::new();
            if p.can_uses_be_removed(b, user, None, &info.blocking[at].1, &mut new_blocking) != Some(true) {
                return None;
            }
            new_blocking.into_iter().for_each(|u| info.block(u));
        }
        Some(info)
    }

    /// `destructureSlot`.
    fn destructure<'a>(&self, b: &mut Body<'a>, alloc: OpId, d: &dyn Destructurable, slot: &DestructurableMemorySlot<'a>, info: &Info<'a>, allocators: &mut Vec<OpId>) {
        let mut q = Quiet;
        let mut rw = Rewriter::new(b, &mut q);
        let block = rw.body.value_block(slot.slot.ptr).expect("slot pointer is placed");
        rw.set_start(block);
        let subslots = d.destructure(self.cx, &mut rw, alloc, slot, &info.used, allocators);

        let mut users: Vec<OpId> = info.blocking.iter().map(|(op, _)| *op).collect();
        info.accessors.iter().for_each(|a| if !users.contains(a) { users.push(*a) });
        let users = rw.body.topological_sort(&users);

        let mut erase = Vec::new();
        for op in users.into_iter().rev() {
            rw.set_after(op);
            let deletion = match rw.body.destructurable(self.cx.dialects, op).filter(|d| d.is_accessor(rw.body, op)) {
                Some(acc) => acc.rewire(self.cx, &mut rw, op, slot, &subslots),
                None => {
                    let p = rw.body.promotable(self.promotable, op).expect("blocking user is promotable");
                    let blocking = &info.blocking.iter().find(|(o, _)| *o == op).expect("blocking user").1;
                    p.remove_blocking_uses(&mut rw, op, None, blocking, None)
                }
            };
            if deletion == Deletion::Delete {
                erase.push(op);
            }
        }
        erase.into_iter().for_each(|op| rw.erase_op(op));
        debug_assert!(rw.body[slot.slot.ptr].uses.is_empty(), "after destructuring, the original slot pointer should no longer be used");

        allocators.extend(d.handle_destructuring_complete(&mut rw, alloc, slot));
    }

    /// `tryToDestructureMemorySlots`: whether anything was destructured.
    fn run(&self, b: &mut Body<'_>, allocators: Vec<OpId>) -> bool {
        let mut any = false;
        let mut work = allocators;
        loop {
            let mut next = Vec::with_capacity(work.len());
            let mut changed = false;
            for alloc in work {
                let d = b.destructurable(self.cx.dialects, alloc).expect("allocator has interfaces");
                let slots = d.destructurable_slots(self.cx, b, alloc).unwrap_or_default();
                // Destructuring a slot may invalidate the allocator's other slots.
                match slots.iter().find_map(|slot| Some((slot, self.info(b, slot)?))) {
                    Some((slot, info)) => {
                        self.destructure(b, alloc, d, slot, &info, &mut next);
                        changed = true;
                    }
                    None => next.push(alloc),
                }
            }
            if !changed {
                return any;
            }
            any = true;
            work = next;
        }
    }
}

#[pass("sroa", ty = Sroa)]
pub fn sroa<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let dialects: [&dyn Destructurable; 3] = [&LlvmSlots, &MemrefSlots, &TestSlots];
    let promotable: [&dyn Promotable; 3] = [&LlvmSlots, &MemrefSlots, &TestSlots];
    let layout = DataLayout::closest(body, op);
    let sroa = Destructurer { cx: Slots { dialects: &dialects, layout: &layout }, promotable: &promotable };
    for region in body[op].regions.clone() {
        if body[region].blocks.is_empty() {
            continue;
        }
        // `region.walk`: post-order.
        let mut allocators = Vec::new();
        for blk in body[region].blocks.clone() {
            for o in body[blk].ops.clone() {
                body.walk_post(o, &mut |x| {
                    if body.destructurable(&dialects, x).is_some_and(|d| d.destructurable_slots(sroa.cx, body, x).is_some()) {
                        allocators.push(x);
                    }
                });
            }
        }
        sroa.run(body, allocators);
    }
    Ok(())
}

// ---- the `llvm` dialect's destructuring interfaces (`LLVMMemorySlot.cpp`) -----------------

/// A memory intrinsic `Ty` from its operands, none of the optional attributes.
macro_rules! intr {
    ($ty:ident($a:expr, $b:expr, $len:expr, $vol:expr; $($t:expr),*)) => {
        $ty::new(Value::from($a), Value::from($b), $len, $vol, None, None, None, None, None, None, $($t),*)
    };
}

/// How an op takes part in destructuring.
#[derive(Clone, Copy, PartialEq, Eq)]
enum Role {
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

impl Role {
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
        match Role::of(self, op)?.inline() {
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
        let inline = Role::of(b, op).is_some_and(Role::inline);
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
        let role = Role::of(b, op).expect("a memcpy-like op");
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
            if role == Role::MemcpyInline {
                self.emit(&intr!(MemcpyInlineOp(d, s, n, vol.clone(); ptr.clone(), ptr.clone())));
                continue;
            }
            let c = self.emit(&ConstantOp::new(n, len_ty.clone()));
            let c = Value::from(self.body[c].results[0]);
            match role {
                Role::Memcpy => self.emit(&intr!(MemcpyOp(d, s, c, vol.clone(); ptr.clone(), ptr.clone(), len_ty.clone()))),
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
        (Role::of(b, op)? == Role::Alloca).then_some(())?;
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
        Some(match Role::of(b, op)? {
            Role::Alloca => return None,
            Role::Load => ops[0] != slot.ptr || dl.size(&b[b[op].results[0]].ty) <= dl.size(&slot.elem),
            Role::Store => ops[1] != slot.ptr || dl.size(&b[ops[0]].ty) <= dl.size(&slot.elem),
            Role::Gep if ops[0] != slot.ptr => true,
            Role::Gep => {
                let size = dl.size(&slot.elem);
                let Some(offset) = b.gep_offset(dl, op).filter(|o| *o < size) else { return Some(false) };
                must_be_safe.push(MemorySlot { ptr: b[op].results[0], elem: LlvmType::array(size - offset, Type::int(8)) });
                true
            }
            _ => b.writes_within(dl, op, slot),
        })
    }

    fn is_accessor(&self, b: &Body<'_>, op: OpId) -> bool {
        Role::of(b, op).is_some_and(|r| r != Role::Alloca)
    }

    fn can_rewire<'a>(&self, cx: Slots<'_>, b: &Body<'a>, op: OpId, slot: &DestructurableMemorySlot<'a>, used: &mut Vec<Attribute<'a>>, must_be_safe: &mut Vec<MemorySlot<'a>>) -> bool {
        let (dl, ops, ptr) = (cx.layout, &b[op].operands, slot.slot.ptr);
        let Some(role) = Role::of(b, op) else { return false };
        match role {
            Role::Alloca => false,
            Role::Load | Role::Store => {
                // Storing the pointer itself cannot be dealt with.
                if b.is_volatile(op) || (role == Role::Store && ops[0] == ptr) {
                    return false;
                }
                // A load or store always accesses the first element of the destructured slot.
                let first = Subslot::from(0);
                let accessed = if role == Role::Load { &b[b[op].results[0]].ty } else { &b[ops[0]].ty };
                let fits = cx.subelements(&slot.slot.elem).and_then(|s| first.find(&s).map(|t| dl.size(accessed) <= dl.size(t)));
                fits == Some(true) && {
                    first.use_in(used);
                    true
                }
            }
            Role::Gep => {
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
        match Role::of(rw.body, op).expect("an accessor") {
            role @ (Role::Load | Role::Store) => {
                let ptr = Subslot::from(0).find(subslots).expect("subslot 0").ptr;
                let at = usize::from(role == Role::Store);
                rw.modify(op, |b| b.set_operand(op, at, ptr));
                return Deletion::Keep;
            }
            Role::Gep => {
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
