//! `ptr` folds (`PtrDialect.cpp`).

use mlirformat::{Attribute, Const, Type};

use crate::{Body, Fold, Folded, OpId, ValueId};

/// The `ptr` ops that fold.
#[derive(Clone, Copy)]
enum Op {
    Constant,
    FromPtr,
    ToPtr,
    PtrAdd,
}

impl Op {
    const TABLE: [(&str, Op); 4] = [("ptr.constant", Op::Constant), ("ptr.from_ptr", Op::FromPtr), ("ptr.to_ptr", Op::ToPtr), ("ptr.ptr_add", Op::PtrAdd)];

    fn of(name: &str) -> Option<Self> {
        Self::TABLE.iter().find(|(n, _)| *n == name).map(|(_, k)| *k)
    }
}

/// `ptr`'s folds.
pub struct PtrCanon;

impl PtrCanon {
    /// `PtrLikeTypeInterface::hasPtrMetadata`: all but `!ptr.ptr` (a memref has metadata).
    fn has_metadata(ty: &Type<'_>) -> bool {
        !matches!(ty, Type::Extended(e) if e.name == "ptr.ptr")
    }

    /// `FromPtrOp::fold`: through `to_ptr` / `from_ptr` round trips, the metadata taken from
    /// the same value.
    fn from_ptr(b: &Body<'_>, op: OpId) -> Option<ValueId> {
        let mut like = None;
        let mut from = Some(op);
        while let Some(f) = from {
            let Some(to) = b.def_named(b[f].operands[0], "ptr.to_ptr") else { return like };
            let src = b[to].operands[0];
            let ty = &b[b[f].results[0]].ty;
            if &b[src].ty != ty {
                return like;
            }
            if !Self::has_metadata(ty) {
                like = Some(src);
            } else if let Some(md) = b[f].operands.get(1)
                && b.def_named(*md, "ptr.get_metadata").is_some_and(|m| b[m].operands[0] == src)
            {
                like = Some(src);
            }
            from = like.and_then(|v| b.def_named(v, "ptr.from_ptr"));
        }
        like
    }

    /// `ToPtrOp::fold`: through `from_ptr` / `to_ptr` chains.
    fn to_ptr(b: &Body<'_>, op: OpId) -> Option<ValueId> {
        let mut ptr = None;
        let mut to = Some(op);
        while let Some(t) = to {
            let Some(from) = b.def_named(b[t].operands[0], "ptr.from_ptr") else { return ptr };
            let p = b[from].operands[0];
            ptr = Some(p);
            to = b.def_named(p, "ptr.to_ptr");
        }
        ptr
    }

    pub fn fold<'a>(b: &mut Body<'a>, op: OpId, c: &[Option<Attribute<'a>>]) -> Fold<'a> {
        let Some(k) = Op::of(&b[op].name) else { return Fold::Failed };
        let found = match k {
            Op::Constant => return b[op].get("value").cloned().map_or(Fold::Failed, |a| Folded::Attr(a).into()),
            Op::FromPtr => Self::from_ptr(b, op),
            Op::ToPtr => Self::to_ptr(b, op),
            Op::PtrAdd => {
                let zero = c.get(1).cloned().flatten().and_then(|a| Const::try_from(&a).ok()).and_then(|k| k.as_int()).is_some_and(|i| i.is_zero());
                zero.then(|| b[op].operands[0])
            }
        };
        found.map_or(Fold::Failed, |v| Folded::Value(v).into())
    }
}
