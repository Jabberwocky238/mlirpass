use alloc::vec::Vec;

use alloc::boxed::Box;

use mlirformat::spirv_types::SpirvType;
use mlirformat::{Attribute, Type};

use super::memslot::{Deletion, Destructurable, DestructurableMemorySlot, MemorySlot, Promotable, Slots};
use crate::{Body, OpData, OpId, Rewriter, Use, ValueId};

/// `spirv.Variable` inside a function (always `Function` storage) read and written only by whole
/// `spirv.Load` / `spirv.Store`.
pub struct SpirvSlots;

#[derive(Clone, Copy, PartialEq, Eq)]
enum Access {
    Load,
    Store,
}

impl Access {
    const TABLE: &[(&str, Access)] = &[("spirv.Load", Access::Load), ("spirv.Store", Access::Store)];

    fn of(b: &Body<'_>, op: OpId) -> Option<Self> {
        Self::TABLE.iter().find(|(n, _)| *n == b[op].name).map(|(_, k)| *k)
    }
}

impl SpirvSlots {
    const VARIABLE: &str = "spirv.Variable";
    const UNDEF: &str = "spirv.Undef";
    const ACCESS_CHAIN: &str = "spirv.AccessChain";
    /// Composites with more parts than this stay in memory.
    const MAX_PARTS: u32 = 64;

    /// The parts of an array, matrix or struct, keyed by their constant index.
    fn parts<'a>(t: &Type<'a>) -> Option<Vec<Type<'a>>> {
        match SpirvType::try_from(t).ok()? {
            SpirvType::Array { len, elem, .. } if len <= Self::MAX_PARTS => Some(alloc::vec![*elem; len as usize]),
            SpirvType::Matrix { cols, column } if cols <= Self::MAX_PARTS => Some(alloc::vec![*column; cols as usize]),
            SpirvType::Struct { members: Some(m), .. } if m.len() <= Self::MAX_PARTS as usize => Some(m.into_iter().map(|m| m.ty).collect()),
            _ => None,
        }
    }

    fn index<'a>(k: usize) -> Attribute<'a> {
        Attribute::i32(i64::try_from(k).unwrap_or(i64::MAX))
    }

    /// The constant first index of an access chain on `ptr`.
    fn first_index<'a>(b: &Body<'a>, op: OpId, ptr: ValueId) -> Option<Attribute<'a>> {
        let o = &b[op].operands;
        (b[op].name == Self::ACCESS_CHAIN && o.len() >= 2 && o[0] == ptr).then_some(())?;
        let k = usize::try_from(b.const_int(o[1])?.unsigned()).ok()?;
        Some(Self::index(k))
    }

    fn pointee<'a>(t: &Type<'a>) -> Option<Type<'a>> {
        match SpirvType::try_from(t) {
            Ok(SpirvType::Ptr { pointee, .. }) => Some(*pointee),
            _ => None,
        }
    }

    /// The pointer and, for a store, the stored value.
    fn access(b: &Body<'_>, op: OpId) -> Option<(ValueId, Option<ValueId>)> {
        let o = &b[op].operands;
        match Access::of(b, op)? {
            Access::Load => Some((o[0], None)),
            Access::Store => Some((o[0], Some(o[1]))),
        }
    }
}

impl Promotable for SpirvSlots {
    fn dialect(&self) -> &str {
        "spirv"
    }

    fn promotable_slots<'a>(&self, b: &Body<'a>, op: OpId) -> Option<Vec<MemorySlot<'a>>> {
        (b[op].name == Self::VARIABLE).then_some(())?;
        let ptr = b[op].results[0];
        Some(Self::pointee(&b[ptr].ty).map(|elem| MemorySlot { ptr, elem }).into_iter().collect())
    }

    fn default_value<'a>(&self, rw: &mut Rewriter<'_, 'a>, alloc: OpId, slot: &MemorySlot<'a>) -> ValueId {
        if let Some(init) = rw.body[alloc].operands.first().copied() {
            return init;
        }
        let data = OpData { loc: rw.body[alloc].loc.clone(), ..OpData::build(Self::UNDEF) };
        let u = rw.create(data, core::slice::from_ref(&slot.elem));
        rw.body[u].results[0]
    }

    fn handle_promotion_complete<'a>(&self, rw: &mut Rewriter<'_, 'a>, alloc: OpId, _: &MemorySlot<'a>, default: Option<ValueId>) -> Option<OpId> {
        let init = rw.body[alloc].operands.first().copied();
        rw.erase_op(alloc);
        if let Some(d) = default.filter(|d| Some(*d) != init && rw.body[*d].uses.is_empty()).and_then(|d| rw.body.def_op(d)) {
            rw.erase_op(d);
        }
        None
    }

    fn is_mem_op(&self, b: &Body<'_>, op: OpId) -> bool {
        Access::of(b, op).is_some()
    }

    fn loads_from<'a>(&self, b: &Body<'a>, op: OpId, slot: &MemorySlot<'a>) -> bool {
        Self::access(b, op).is_some_and(|(p, v)| v.is_none() && p == slot.ptr)
    }

    fn stores_to<'a>(&self, b: &Body<'a>, op: OpId, slot: &MemorySlot<'a>) -> bool {
        Self::access(b, op).is_some_and(|(p, v)| v.is_some() && p == slot.ptr)
    }

    fn stored<'a>(&self, rw: &mut Rewriter<'_, 'a>, op: OpId, _: &MemorySlot<'a>, _: ValueId) -> ValueId {
        Self::access(rw.body, op).and_then(|(_, v)| v).expect("only a spirv.Store stores")
    }

    fn can_uses_be_removed<'a>(&self, b: &Body<'a>, op: OpId, slot: Option<&MemorySlot<'a>>, blocking: &[Use], _: &mut Vec<Use>) -> Option<bool> {
        let ((ptr, stored), slot) = (Self::access(b, op)?, slot?);
        let moved = stored.unwrap_or_else(|| b[op].results[0]);
        let [u] = blocking else { return Some(false) };
        Some(b[u.op].operands[u.index as usize] == slot.ptr && ptr == slot.ptr && moved != slot.ptr && b[moved].ty == slot.elem)
    }

    fn remove_blocking_uses<'a>(&self, rw: &mut Rewriter<'_, 'a>, op: OpId, _: Option<&MemorySlot<'a>>, _: &[Use], reaching: Option<ValueId>) -> Deletion {
        if Access::of(rw.body, op) == Some(Access::Load) {
            let r = rw.body[op].results[0];
            rw.replace_all_uses(r, reaching.expect("a load has a reaching definition"));
        }
        Deletion::Delete
    }
}

impl Destructurable for SpirvSlots {
    fn dialect(&self) -> &str {
        "spirv"
    }

    fn subelements<'a>(&self, ty: &Type<'a>) -> Option<Vec<(Attribute<'a>, Type<'a>)>> {
        Some(Self::parts(ty)?.into_iter().enumerate().map(|(k, t)| (Self::index(k), t)).collect())
    }

    fn type_at<'a>(&self, ty: &Type<'a>, index: &Attribute<'a>) -> Option<Type<'a>> {
        self.subelements(ty)?.into_iter().find(|(i, _)| i == index).map(|(_, t)| t)
    }

    fn destructurable_slots<'a>(&self, cx: Slots<'_>, b: &Body<'a>, op: OpId) -> Option<Vec<DestructurableMemorySlot<'a>>> {
        (b[op].name == Self::VARIABLE && b[op].operands.is_empty()).then_some(())?;
        let ptr = b[op].results[0];
        let elem = Self::pointee(&b[ptr].ty)?;
        Some(cx.subelements(&elem).map(|subelements| DestructurableMemorySlot { slot: MemorySlot { ptr, elem }, subelements }).into_iter().collect())
    }

    fn destructure<'a>(&self, _: Slots<'_>, rw: &mut Rewriter<'_, 'a>, alloc: OpId, slot: &DestructurableMemorySlot<'a>, used: &[Attribute<'a>], allocators: &mut Vec<OpId>) -> Vec<(Attribute<'a>, MemorySlot<'a>)> {
        let Ok(SpirvType::Ptr { storage, .. }) = SpirvType::try_from(&rw.body[slot.slot.ptr].ty) else { unreachable!("a spirv.Variable is a pointer") };
        rw.set_after(alloc);
        let mut out = Vec::new();
        for index in used {
            let elem = slot.subelements.iter().find(|(i, _)| i == index).expect("a used index is a part").1.clone();
            let ptr: Type<'a> = SpirvType::Ptr { pointee: Box::new(elem.clone()), storage: storage.clone() }.into();
            let data = OpData { loc: rw.body[alloc].loc.clone(), ..OpData::build(Self::VARIABLE) };
            let data = match rw.body[alloc].get("storage_class").cloned() {
                Some(c) => data.with("storage_class", c),
                None => data,
            };
            let v = rw.create(data, &[ptr]);
            allocators.push(v);
            out.push((index.clone(), MemorySlot { ptr: rw.body[v].results[0], elem }));
        }
        out
    }

    fn handle_destructuring_complete<'a>(&self, rw: &mut Rewriter<'_, 'a>, alloc: OpId, _: &DestructurableMemorySlot<'a>) -> Option<OpId> {
        rw.erase_op(alloc);
        None
    }

    fn is_accessor(&self, b: &Body<'_>, op: OpId) -> bool {
        b[op].name == Self::ACCESS_CHAIN
    }

    fn can_rewire<'a>(&self, _: Slots<'_>, b: &Body<'a>, op: OpId, slot: &DestructurableMemorySlot<'a>, used: &mut Vec<Attribute<'a>>, _: &mut Vec<MemorySlot<'a>>) -> bool {
        let Some(index) = Self::first_index(b, op, slot.slot.ptr).filter(|i| slot.subelements.iter().any(|(k, _)| k == i)) else { return false };
        if !used.contains(&index) {
            used.push(index);
        }
        true
    }

    fn rewire<'a>(&self, _: Slots<'_>, rw: &mut Rewriter<'_, 'a>, op: OpId, slot: &DestructurableMemorySlot<'a>, subslots: &[(Attribute<'a>, MemorySlot<'a>)]) -> Deletion {
        let index = Self::first_index(rw.body, op, slot.slot.ptr).expect("checked by can_rewire");
        let ptr = subslots.iter().find(|(i, _)| *i == index).expect("a used index").1.ptr;
        let result = rw.body[op].results[0];
        let rest: Vec<ValueId> = rw.body[op].operands[2..].to_vec();
        let to = if rest.is_empty() {
            ptr
        } else {
            let mut operands = alloc::vec![ptr];
            operands.extend(rest);
            let ty = rw.body[result].ty.clone();
            rw.set_before(op);
            let data = OpData { loc: rw.body[op].loc.clone(), ..OpData::build(Self::ACCESS_CHAIN).operands(&operands) };
            let c = rw.create(data, &[ty]);
            rw.body[c].results[0]
        };
        rw.replace_all_uses(result, to);
        Deletion::Delete
    }
}
