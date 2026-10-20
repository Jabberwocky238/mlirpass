//! `memref`'s memory slots, as `MemRefMemorySlot.cpp`: `memref.alloca` allocates them,
//! `memref.load` / `memref.store` access them, and a small static memref splits into its elements.
//! Both [`Promotable`] (`mem2reg`) and [`Destructurable`] (`sroa`) of [`MemrefSlots`].

use alloc::vec::Vec;

use mlirformat::{Attribute, Dim, Shaped, ShapedKind, Type};

use super::memslot::{Deletion, Destructurable, DestructurableMemorySlot, MemorySlot, MemrefSlots, Promotable, Slots};
use crate::{Body, Const, OpData, OpId, Rewriter, Use, ValueId};

/// A ranked `MemRefType`, as `MemRefDestructurableTypeExternalModel` sees it.
struct MemRefType<'t, 'a>(&'t Shaped<'a>);

impl<'t, 'a> TryFrom<&'t Type<'a>> for MemRefType<'t, 'a> {
    type Error = ();

    fn try_from(t: &'t Type<'a>) -> Result<Self, ()> {
        match t {
            Type::Shaped(s) if s.kind == ShapedKind::MemRef && s.shape.is_some() => Ok(Self(s)),
            _ => Err(()),
        }
    }
}

impl<'a> MemRefType<'_, 'a> {
    /// `maxMemrefSizeForDestructuring`.
    const MAX_DESTRUCTURED: usize = 16;

    /// `getShape` when `hasStaticShape`.
    fn static_shape(&self) -> Option<Vec<i64>> {
        self.0.shape.as_ref()?.iter().map(|d| if let Dim::Static(n) = d { Some(*n) } else { None }).collect()
    }

    fn elem(&self) -> Type<'a> {
        (*self.0.elem).clone()
    }

    /// `MemRefType::get({}, elem)`.
    fn scalar(elem: Type<'a>) -> Type<'a> {
        Type::Shaped(Shaped { kind: ShapedKind::MemRef, shape: Some(Vec::new()), elem: elem.into(), extras: Vec::new() })
    }

    /// `getSubelementIndexMap`: each coordinate as an `[i : index, ...]` array, in
    /// `walkIndicesAsAttr`'s order (the first dim fastest).
    fn subelements(&self) -> Option<Vec<(Attribute<'a>, Type<'a>)>> {
        let shape = self.static_shape()?;
        let n: usize = shape.iter().map(|d| *d as usize).product();
        if n > Self::MAX_DESTRUCTURED || n == 1 {
            return None;
        }
        let mut at = alloc::vec![0i64; shape.len()];
        let mut out = Vec::with_capacity(n);
        loop {
            out.push((Attribute::Array(at.iter().map(|c| Attribute::index(*c)).collect()), self.elem()));
            // `nextIndex`: the first dim that does not wrap around, or the walk is over.
            let wrapped = |(c, d): (&mut i64, &i64)| {
                *c += 1;
                *c == *d && {
                    *c = 0;
                    true
                }
            };
            if at.iter_mut().zip(&shape).all(wrapped) {
                break;
            }
        }
        Some(out)
    }

    /// `getTypeAtIndex`: the element type when `index` is a coordinate within the shape.
    fn type_at(&self, index: &Attribute<'a>) -> Option<Type<'a>> {
        let Attribute::Array(coords) = index else { return None };
        let dims = self.0.dims()?;
        (coords.len() == dims.len()).then_some(())?;
        coords
            .iter()
            .zip(&dims)
            .all(|(c, d)| matches!(c, Attribute::Int { ty: Some(Type::Index), .. }) && Const::try_from(c).ok().and_then(|c| c.as_int()).is_some_and(|v| (0..*d as i128).contains(&v.signed())))
            .then(|| self.elem())
    }
}

/// `memref.load` / `memref.store` taken apart: the memref, its indices, and the value stored.
struct Access<'o> {
    memref: ValueId,
    indices: &'o [ValueId],
    stored: Option<ValueId>,
}

impl<'a> Body<'a> {
    fn memref_access(&self, op: OpId) -> Option<Access<'_>> {
        let o = &self[op].operands;
        match &*self[op].name {
            "memref.load" => Some(Access { memref: o[0], indices: &o[1..], stored: None }),
            "memref.store" => Some(Access { memref: o[1], indices: &o[2..], stored: Some(o[0]) }),
            _ => None,
        }
    }

    /// `getAttributeIndexFromIndexOperands`: the indices of an access as a coordinate array,
    /// when each is a constant within its dim.
    fn memref_index(&self, op: OpId) -> Option<Attribute<'a>> {
        let a = self.memref_access(op)?;
        let dims = self[a.memref].ty.dims()?;
        a.indices
            .iter()
            .zip(&dims)
            .map(|(v, d)| {
                let c = self.constant_of(*v)?;
                let n = Const::try_from(&c).ok().filter(|c| !c.elements)?.as_int()?.unsigned();
                // Uniqued in C++: the same coordinate is the same attribute.
                (n < *d as u128).then(|| Attribute::index(n as i64))
            })
            .collect::<Option<Vec<_>>>()
            .map(Attribute::Array)
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
        let t = MemRefType::try_from(&b[ptr].ty).ok()?;
        Some(match t.static_shape() {
            Some(s) if s.iter().product::<i64>() == 1 => alloc::vec![MemorySlot { ptr, elem: t.elem() }],
            _ => Vec::new(),
        })
    }

    /// `AllocaOp::getDefaultValue`: `ub.poison`.
    fn default_value<'a>(&self, rw: &mut Rewriter<'_, 'a>, alloc: OpId, slot: &MemorySlot<'a>) -> ValueId {
        let mut data = OpData::build("ub.poison").with("value", Attribute::dialect("ub.poison", ""));
        data.loc = rw.body[alloc].loc.clone();
        let p = rw.create(data, core::slice::from_ref(&slot.elem));
        rw.body[p].results[0]
    }

    /// `AllocaOp::handlePromotionComplete`: the default value goes if unused, then the alloca.
    fn handle_promotion_complete<'a>(&self, rw: &mut Rewriter<'_, 'a>, alloc: OpId, _: &MemorySlot<'a>, default: Option<ValueId>) -> Option<OpId> {
        if let Some(d) = default.filter(|d| rw.body[*d].uses.is_empty()) {
            let def = rw.body.def_op(d).expect("the default value is an op result");
            rw.erase_op(def);
        }
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

    /// `MemRefDestructurableTypeExternalModel::getSubelementIndexMap`.
    fn subelements<'a>(&self, ty: &Type<'a>) -> Option<Vec<(Attribute<'a>, Type<'a>)>> {
        MemRefType::try_from(ty).ok()?.subelements()
    }

    /// `MemRefDestructurableTypeExternalModel::getTypeAtIndex`.
    fn type_at<'a>(&self, ty: &Type<'a>, index: &Attribute<'a>) -> Option<Type<'a>> {
        MemRefType::try_from(ty).ok()?.type_at(index)
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
    fn destructure<'a>(&self, cx: Slots<'_>, rw: &mut Rewriter<'_, 'a>, alloc: OpId, slot: &DestructurableMemorySlot<'a>, used: &[Attribute<'a>], allocators: &mut Vec<OpId>) -> Vec<(Attribute<'a>, MemorySlot<'a>)> {
        rw.set_after(alloc);
        used.iter()
            .map(|index| {
                let elem = cx.type_at(&slot.slot.elem, index).expect("a used index is valid");
                let mut data = OpData::build("memref.alloca").segments(&[0, 0]);
                data.loc = rw.body[alloc].loc.clone();
                let sub = rw.create(data, &[MemRefType::scalar(elem.clone())]);
                allocators.push(sub);
                (index.clone(), MemorySlot { ptr: rw.body[sub].results[0], elem })
            })
            .collect()
    }

    fn handle_destructuring_complete<'a>(&self, rw: &mut Rewriter<'_, 'a>, alloc: OpId, _: &DestructurableMemorySlot<'a>) -> Option<OpId> {
        rw.erase_op(alloc);
        None
    }

    fn is_accessor(&self, b: &Body<'_>, op: OpId) -> bool {
        b.memref_access(op).is_some()
    }

    /// `canRewire`: the access's index, when constant, in bounds and (for a store) a subelement
    /// of the slot that does not store the pointer itself.
    fn can_rewire<'a>(&self, _: Slots<'_>, b: &Body<'a>, op: OpId, slot: &DestructurableMemorySlot<'a>, used: &mut Vec<Attribute<'a>>, _: &mut Vec<MemorySlot<'a>>) -> bool {
        let Some(a) = b.memref_access(op) else { return false };
        if a.memref != slot.slot.ptr || a.stored == Some(slot.slot.ptr) {
            return false;
        }
        let Some(index) = b.memref_index(op).filter(|i| a.stored.is_none() || slot.subelements.iter().any(|(s, _)| s == i)) else { return false };
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
        let mut operands = rw.body[op].operands[..keep].to_vec();
        operands.push(ptr);
        rw.modify(op, |b| b.set_operands(op, operands));
        Deletion::Keep
    }
}
