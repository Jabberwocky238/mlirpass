//! `memref`'s memory slots, as `MemRefMemorySlot.cpp`: `memref.alloca` allocates them,
//! `memref.load` / `memref.store` access them, and a small static memref splits into its elements.
//! Both [`Promotable`] (`mem2reg`) and [`Destructurable`] (`sroa`) of [`MemrefSlots`], and of
//! [`TestSlots`] (`test.multi_slot_alloca`, whose slots are memrefs too).

use alloc::vec::Vec;

use mlirformat::{Attribute, Shaped, ShapedKind, Type};

use super::memslot::{Deletion, Destructurable, DestructurableMemorySlot, MemorySlot, MemrefSlots, Promotable, Slots};
use crate::{Body, Const, OpData, OpId, Rewriter, Use, ValueId};

/// `memref.load` / `memref.store` taken apart: the memref, its indices, and the value stored.
struct Access<'o> {
    memref: ValueId,
    indices: &'o [ValueId],
    stored: Option<ValueId>,
}

impl<'o> TryFrom<&'o OpData<'_>> for Access<'o> {
    type Error = ();

    fn try_from(d: &'o OpData<'_>) -> Result<Self, ()> {
        let o = &d.operands;
        match &*d.name {
            "memref.load" => Ok(Self { memref: o[0], indices: &o[1..], stored: None }),
            "memref.store" => Ok(Self { memref: o[1], indices: &o[2..], stored: Some(o[0]) }),
            _ => Err(()),
        }
    }
}

impl<'a> Body<'a> {
    fn memref_access(&self, op: OpId) -> Option<Access<'_>> {
        Access::try_from(&self[op]).ok()
    }

    /// `getAttributeIndexFromIndexOperands`: an access's indices as a coordinate array, when
    /// each is a constant within its dim (uniqued in C++, so built anew here).
    fn memref_index(&self, op: OpId) -> Option<Attribute<'a>> {
        let a = self.memref_access(op)?;
        let dims = self[a.memref].ty.dims()?;
        let coord = |(v, d): (&ValueId, &i64)| {
            let n = Const::try_from(&self.constant_of(*v)?).ok().filter(|c| !c.elements)?.as_int()?.unsigned();
            (n < *d as u128).then(|| Attribute::index(n as i64))
        };
        a.indices.iter().zip(&dims).map(coord).collect::<Option<_>>().map(Attribute::Array)
    }
}

impl MemrefSlots {
    /// A static memref's dims and element type.
    fn static_memref<'a>(ty: &Type<'a>) -> Option<(Vec<i64>, Type<'a>)> {
        let Type::Shaped(s) = ty else { return None };
        (s.kind == ShapedKind::MemRef).then_some(())?;
        ty.element_count()?;
        Some((s.dims()?, (*s.elem).clone()))
    }

    /// `destructure`'s new allocators: an op `name` of one `memref<T>` per used index, after
    /// `alloc`, in `used`'s order, `T` being `slot`'s type at the index.
    fn sub_allocators<'a>(rw: &mut Rewriter<'_, 'a>, name: &str, alloc: OpId, slot: &DestructurableMemorySlot<'a>, used: &[Attribute<'a>], allocators: &mut Vec<OpId>) -> Vec<(Attribute<'a>, MemorySlot<'a>)> {
        rw.set_after(alloc);
        let loc = rw.body[alloc].loc.clone();
        let mut sub = |index: &Attribute<'a>| {
            let elem = slot.subelements.iter().find(|(i, _)| i == index).expect("a used index is a subelement").1.clone();
            let ty = Type::Shaped(Shaped { kind: ShapedKind::MemRef, shape: Some(Vec::new()), elem: elem.clone().into(), extras: Vec::new() });
            let data = OpData { loc: loc.clone(), ..OpData::build(name) };
            let op = rw.create(if name == "memref.alloca" { data.segments(&[0, 0]) } else { data }, &[ty]);
            allocators.push(op);
            (index.clone(), MemorySlot { ptr: rw.body[op].results[0], elem })
        };
        used.iter().map(&mut sub).collect()
    }

    /// `handlePromotionComplete`'s first step: the default value goes if unused.
    fn drop_default(rw: &mut Rewriter<'_, '_>, default: Option<ValueId>) {
        if let Some(d) = default.filter(|d| rw.body[*d].uses.is_empty()).and_then(|d| rw.body.def_op(d)) {
            rw.erase_op(d);
        }
    }
}

impl Promotable for MemrefSlots {
    fn dialect(&self) -> &str {
        "memref"
    }

    /// `AllocaOp::getPromotableSlots`: a static memref of one element.
    fn promotable_slots<'a>(&self, b: &Body<'a>, op: OpId) -> Option<Vec<MemorySlot<'a>>> {
        (b[op].name == "memref.alloca").then_some(())?;
        let ptr = b[op].results[0];
        let one = Self::static_memref(&b[ptr].ty).filter(|(dims, _)| dims.iter().product::<i64>() == 1);
        Some(one.map(|(_, elem)| MemorySlot { ptr, elem }).into_iter().collect())
    }

    /// `AllocaOp::getDefaultValue`: `ub.poison`.
    fn default_value<'a>(&self, rw: &mut Rewriter<'_, 'a>, alloc: OpId, slot: &MemorySlot<'a>) -> ValueId {
        let data = OpData { loc: rw.body[alloc].loc.clone(), ..OpData::build("ub.poison").with("value", Attribute::dialect("ub.poison", "")) };
        let p = rw.create(data, core::slice::from_ref(&slot.elem));
        rw.body[p].results[0]
    }

    /// `AllocaOp::handlePromotionComplete`: the default value goes if unused, then the alloca.
    fn handle_promotion_complete<'a>(&self, rw: &mut Rewriter<'_, 'a>, alloc: OpId, _: &MemorySlot<'a>, default: Option<ValueId>) -> Option<OpId> {
        Self::drop_default(rw, default);
        rw.erase_op(alloc);
        None
    }

    fn is_mem_op(&self, b: &Body<'_>, op: OpId) -> bool {
        b.memref_access(op).is_some()
    }

    fn loads_from<'a>(&self, b: &Body<'a>, op: OpId, slot: &MemorySlot<'a>) -> bool {
        b.memref_access(op).is_some_and(|a| a.stored.is_none() && a.memref == slot.ptr)
    }

    fn stores_to<'a>(&self, b: &Body<'a>, op: OpId, slot: &MemorySlot<'a>) -> bool {
        b.memref_access(op).is_some_and(|a| a.stored.is_some() && a.memref == slot.ptr)
    }

    fn stored<'a>(&self, rw: &mut Rewriter<'_, 'a>, op: OpId, _: &MemorySlot<'a>, _: ValueId) -> ValueId {
        rw.body.memref_access(op).and_then(|a| a.stored).expect("getStored is only asked of a memref.store")
    }

    /// `canUsesBeRemoved`: the one blocking use is the slot pointer as the accessed memref, and
    /// the value moved has the slot's type (a store must not store the pointer itself).
    fn can_uses_be_removed<'a>(&self, b: &Body<'a>, op: OpId, slot: Option<&MemorySlot<'a>>, blocking: &[Use], _: &mut Vec<Use>) -> Option<bool> {
        let (a, slot) = (b.memref_access(op)?, slot?);
        let moved = a.stored.unwrap_or_else(|| b[op].results[0]);
        let [u] = blocking else { return Some(false) };
        Some(b[u.op].operands[u.index as usize] == slot.ptr && a.memref == slot.ptr && moved != slot.ptr && b[moved].ty == slot.elem)
    }

    /// `removeBlockingUses`: a load's result becomes the reaching definition; both go.
    fn remove_blocking_uses<'a>(&self, rw: &mut Rewriter<'_, 'a>, op: OpId, _: Option<&MemorySlot<'a>>, _: &[Use], reaching: Option<ValueId>) -> Deletion {
        if rw.body[op].name == "memref.load" {
            let r = rw.body[op].results[0];
            rw.replace_all_uses(r, reaching.expect("a load has a reaching definition"));
        }
        Deletion::Delete
    }
}

impl Destructurable for MemrefSlots {
    fn dialect(&self) -> &str {
        "memref"
    }

    /// `MemRefDestructurableTypeExternalModel::getSubelementIndexMap`: up to 16 elements, each
    /// coordinate an `[i : index, ...]` array in `walkIndicesAsAttr`'s order (the first dim
    /// fastest; an empty shape still yields its zero coordinate).
    fn subelements<'a>(&self, ty: &Type<'a>) -> Option<Vec<(Attribute<'a>, Type<'a>)>> {
        let (dims, elem) = Self::static_memref(ty)?;
        let n: i64 = dims.iter().product();
        (n <= 16 && n != 1).then_some(())?;
        let at = |mut k: i64| {
            let coord = |d: &i64| {
                let d = (*d).max(1);
                let c = k % d;
                k /= d;
                Attribute::index(c)
            };
            (Attribute::Array(dims.iter().map(coord).collect()), elem.clone())
        };
        Some((0..n.max(1)).map(at).collect())
    }

    /// `MemRefDestructurableTypeExternalModel::getTypeAtIndex`: the element type at an in-bounds
    /// `index`-typed coordinate.
    fn type_at<'a>(&self, ty: &Type<'a>, index: &Attribute<'a>) -> Option<Type<'a>> {
        let ((dims, elem), Attribute::Array(coords)) = (Self::static_memref(ty)?, index) else { return None };
        let valid = |(c, d): (&Attribute<'a>, &i64)| matches!(c, Attribute::Int { ty: Some(Type::Index), .. }) && Const::try_from(c).ok().and_then(|c| c.as_int()).is_some_and(|v| (0..*d as i128).contains(&v.signed()));
        (coords.len() == dims.len() && coords.iter().zip(&dims).all(valid)).then_some(elem)
    }

    /// `AllocaOp::getDestructurableSlots`: the memref itself is the slot's type.
    fn destructurable_slots<'a>(&self, cx: Slots<'_>, b: &Body<'a>, op: OpId) -> Option<Vec<DestructurableMemorySlot<'a>>> {
        (b[op].name == "memref.alloca").then_some(())?;
        let ptr = b[op].results[0];
        let ty = &b[ptr].ty;
        Some(cx.subelements(ty).map(|subelements| DestructurableMemorySlot { slot: MemorySlot { ptr, elem: ty.clone() }, subelements }).into_iter().collect())
    }

    /// `AllocaOp::destructure`: one `memref<T>` alloca per used index, after `alloc`, in
    /// `used`'s order.
    fn destructure<'a>(&self, _: Slots<'_>, rw: &mut Rewriter<'_, 'a>, alloc: OpId, slot: &DestructurableMemorySlot<'a>, used: &[Attribute<'a>], allocators: &mut Vec<OpId>) -> Vec<(Attribute<'a>, MemorySlot<'a>)> {
        Self::sub_allocators(rw, "memref.alloca", alloc, slot, used, allocators)
    }

    fn handle_destructuring_complete<'a>(&self, rw: &mut Rewriter<'_, 'a>, alloc: OpId, _: &DestructurableMemorySlot<'a>) -> Option<OpId> {
        rw.erase_op(alloc);
        None
    }

    fn is_accessor(&self, b: &Body<'_>, op: OpId) -> bool {
        b.memref_access(op).is_some()
    }

    /// `canRewire`: an access to the slot (a store not storing the pointer itself) at a
    /// constant, in-bounds index, so one of the slot's subelements.
    fn can_rewire<'a>(&self, _: Slots<'_>, b: &Body<'a>, op: OpId, slot: &DestructurableMemorySlot<'a>, used: &mut Vec<Attribute<'a>>, _: &mut Vec<MemorySlot<'a>>) -> bool {
        let ptr = slot.slot.ptr;
        let Some(index) = b.memref_access(op).filter(|a| a.memref == ptr && a.stored != Some(ptr)).and_then(|_| b.memref_index(op)) else { return false };
        if !used.contains(&index) {
            used.push(index);
        }
        true
    }

    /// `rewire`: the access moves to the subslot of its index, with no indices left.
    fn rewire<'a>(&self, _: Slots<'_>, rw: &mut Rewriter<'_, 'a>, op: OpId, _: &DestructurableMemorySlot<'a>, subslots: &[(Attribute<'a>, MemorySlot<'a>)]) -> Deletion {
        let index = rw.body.memref_index(op).expect("canRewire checked the index");
        let ptr = subslots.iter().find(|(i, _)| *i == index).expect("a used index").1.ptr;
        let keep = usize::from(rw.body[op].name == "memref.store");
        let operands = rw.body[op].operands[..keep].iter().copied().chain([ptr]).collect();
        rw.modify(op, |b| b.set_operands(op, operands));
        Deletion::Keep
    }
}

/// `test.multi_slot_alloca`'s interfaces (`TestOpDefs.cpp`): one slot per result.
pub struct TestSlots;

impl TestSlots {
    const ALLOCA: &str = "test.multi_slot_alloca";

    /// `createNewMultiAllocaWithoutSlot`: `alloc` built again before itself without result
    /// `ptr` (the other results' uses moving over), or nothing when `ptr` was its last.
    fn without<'a>(rw: &mut Rewriter<'_, 'a>, alloc: OpId, ptr: ValueId) -> Option<OpId> {
        let rest: Vec<ValueId> = rw.body[alloc].results.iter().copied().filter(|r| *r != ptr).collect();
        let (ip, loc, types) = (rw.ip, rw.body[alloc].loc.clone(), rw.body.types(&rest));
        let new = (!rest.is_empty()).then(|| {
            rw.set_before(alloc);
            let new = rw.create(OpData { loc, ..OpData::build(Self::ALLOCA) }, &types);
            for (old, new) in rest.iter().zip(rw.body[new].results.clone()) {
                rw.replace_all_uses(*old, new);
            }
            new
        });
        rw.ip = ip;
        rw.erase_op(alloc);
        new
    }
}

impl Promotable for TestSlots {
    fn dialect(&self) -> &str {
        "test"
    }

    fn promotable_slots<'a>(&self, b: &Body<'a>, op: OpId) -> Option<Vec<MemorySlot<'a>>> {
        (b[op].name == Self::ALLOCA).then_some(())?;
        Some(b[op].results.iter().map(|r| MemorySlot { ptr: *r, elem: b[*r].ty.element_type().clone() }).collect())
    }

    /// `test.constant 42 : i32`.
    fn default_value<'a>(&self, rw: &mut Rewriter<'_, 'a>, alloc: OpId, slot: &MemorySlot<'a>) -> ValueId {
        let data = OpData { loc: rw.body[alloc].loc.clone(), ..OpData::build("test.constant").with("value", Attribute::integer(42, Type::int(32))) };
        let c = rw.create(data, core::slice::from_ref(&slot.elem));
        rw.body[c].results[0]
    }

    fn handle_promotion_complete<'a>(&self, rw: &mut Rewriter<'_, 'a>, alloc: OpId, slot: &MemorySlot<'a>, default: Option<ValueId>) -> Option<OpId> {
        MemrefSlots::drop_default(rw, default);
        Self::without(rw, alloc, slot.ptr)
    }
}

impl Destructurable for TestSlots {
    fn dialect(&self) -> &str {
        "test"
    }

    fn destructurable_slots<'a>(&self, cx: Slots<'_>, b: &Body<'a>, op: OpId) -> Option<Vec<DestructurableMemorySlot<'a>>> {
        (b[op].name == Self::ALLOCA).then_some(())?;
        let slot = |r: &ValueId| cx.subelements(&b[*r].ty).map(|subelements| DestructurableMemorySlot { slot: MemorySlot { ptr: *r, elem: b[*r].ty.clone() }, subelements });
        Some(b[op].results.iter().filter_map(slot).collect())
    }

    fn destructure<'a>(&self, _: Slots<'_>, rw: &mut Rewriter<'_, 'a>, alloc: OpId, slot: &DestructurableMemorySlot<'a>, used: &[Attribute<'a>], allocators: &mut Vec<OpId>) -> Vec<(Attribute<'a>, MemorySlot<'a>)> {
        MemrefSlots::sub_allocators(rw, Self::ALLOCA, alloc, slot, used, allocators)
    }

    fn handle_destructuring_complete<'a>(&self, rw: &mut Rewriter<'_, 'a>, alloc: OpId, slot: &DestructurableMemorySlot<'a>) -> Option<OpId> {
        Self::without(rw, alloc, slot.slot.ptr)
    }
}
