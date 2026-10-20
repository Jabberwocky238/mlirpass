//! Folding, as `Operation::fold` and `Dialect::materializeConstant`.
//!
//! An op folds through its own hook (per dialect, in [`crate::canon`]) and, when that fails or
//! folds to the op itself, through its traits' (`IsCommutative`, `IsInvolution`, `IsIdempotent`).

use alloc::vec::Vec;

use mlirformat::{Attribute, Extended, Type};

use crate::{Body, OpData, OpId, Trait, ValueId};

/// One folded result: an existing value, or a constant still to be materialized.
#[derive(Debug, Clone, PartialEq)]
pub enum Folded<'a> {
    Value(ValueId),
    Attr(Attribute<'a>),
}

/// What a fold hook did.
#[derive(Debug, Clone, PartialEq)]
pub enum Fold<'a> {
    Failed,
    /// The op changed in place.
    InPlace,
    Results(Vec<Folded<'a>>),
}

impl<'a> From<Folded<'a>> for Fold<'a> {
    fn from(f: Folded<'a>) -> Self {
        Fold::Results(alloc::vec![f])
    }
}

impl<'a> From<Option<Folded<'a>>> for Fold<'a> {
    fn from(f: Option<Folded<'a>>) -> Self {
        f.map_or(Fold::Failed, Fold::from)
    }
}

impl<'a> From<ValueId> for Folded<'a> {
    fn from(v: ValueId) -> Self {
        Folded::Value(v)
    }
}

impl<'a> From<Attribute<'a>> for Folded<'a> {
    fn from(a: Attribute<'a>) -> Self {
        Folded::Attr(a)
    }
}

impl<'a> Body<'a> {
    /// `m_Constant`: the value of a `ConstantLike` op.
    pub fn constant_value(&self, op: OpId) -> Option<Attribute<'a>> {
        if !self.has(op, Trait::ConstantLike) {
            return None;
        }
        let d = &self[op];
        let ext = |name: &str| Attribute::Extended { ext: Extended { name: alloc::string::String::from(name).into(), body: None, params: Vec::new() }, ty: None };
        match &*d.name {
            "ub.poison" => Some(d.get("value").cloned().unwrap_or_else(|| ext("ub.poison"))),
            // `ZeroOp::fold`: a builtin zero where the type has one.
            "llvm.mlir.zero" => Some(match &self[d.results[0]].ty {
                t @ (Type::Integer { .. } | Type::Index) => Attribute::Int { lit: "0".into(), ty: Some(t.clone()) },
                t @ Type::Float(_) => Attribute::Float { lit: "0.000000e+00".into(), ty: Some(t.clone()) },
                _ => ext("llvm.zero"),
            }),
            "llvm.mlir.undef" => Some(ext("llvm.undef")),
            "llvm.mlir.poison" => Some(ext("llvm.poison")),
            "shape.const_shape" => d.get("shape").cloned(),
            "shape.const_witness" => d.get("passing").cloned(),
            "tosa.const" | "tosa.const_shape" => d.get("values").cloned(),
            _ => d.get("value").cloned(),
        }
    }

    /// The constant behind `v`, if its defining op is one.
    pub fn constant_of(&self, v: ValueId) -> Option<Attribute<'a>> {
        self.def_op(v).and_then(|o| self.constant_value(o))
    }

    /// Each operand's constant value, as fold hooks receive them.
    pub fn operand_constants(&self, op: OpId) -> Vec<Option<Attribute<'a>>> {
        self[op].operands.iter().map(|v| self.constant_of(*v)).collect()
    }

    /// ⭐ `Operation::fold`.
    pub fn fold(&mut self, op: OpId) -> Fold<'a> {
        if !self.registered(op) {
            return Fold::Failed;
        }
        let consts = self.operand_constants(op);
        self.fold_with(op, &consts)
    }

    /// `Operation::fold(operands)`: folding with the given operand constants.
    pub fn fold_with(&mut self, op: OpId, consts: &[Option<Attribute<'a>>]) -> Fold<'a> {
        if !self.registered(op) {
            return Fold::Failed;
        }
        let consts = consts.to_vec();
        let own = crate::canon::fold(self, op, &consts);
        let to_self = matches!(&own, Fold::Results(r) if self[op].results.len() == 1 && r.first() == Some(&Folded::Value(self[op].results[0])));
        match own {
            Fold::Failed => self.fold_traits(op, &consts),
            _ if to_self => match self.fold_traits(op, &consts) {
                Fold::Failed => Fold::InPlace,
                f => f,
            },
            f => f,
        }
    }

    /// The traits' folds, in trait order: the first that succeeds wins.
    fn fold_traits(&mut self, op: OpId, consts: &[Option<Attribute<'a>>]) -> Fold<'a> {
        let traits = self.ctx.0.op_info(&self[op].name).map_or(&[][..], |i| i.traits);
        for t in traits {
            let f = match t {
                Trait::IsCommutative => self.fold_commutative(op, consts),
                Trait::IsInvolution => self.fold_involution(op),
                Trait::IsIdempotent => self.fold_idempotent(op),
                Trait::CastOpInterface => self.fold_cast(op),
                _ => Fold::Failed,
            };
            if f != Fold::Failed {
                return f;
            }
        }
        Fold::Failed
    }

    /// Constant operands move to the end, keeping their order.
    fn fold_commutative(&mut self, op: OpId, consts: &[Option<Attribute<'a>>]) -> Fold<'a> {
        let operands = self[op].operands.clone();
        if operands.len() < 2 {
            return Fold::Failed;
        }
        let first = consts.iter().position(Option::is_some).unwrap_or(operands.len());
        let (head, tail) = operands.split_at(first);
        let tail_consts = &consts[first..];
        let mut moved: Vec<ValueId> = head.to_vec();
        moved.extend(tail.iter().zip(tail_consts).filter(|(_, c)| c.is_none()).map(|(v, _)| *v));
        moved.extend(tail.iter().zip(tail_consts).filter(|(_, c)| c.is_some()).map(|(v, _)| *v));
        if moved == operands {
            return Fold::Failed;
        }
        self.set_operands(op, moved);
        Fold::InPlace
    }

    /// `foldCastInterfaceOp`: a cast whose operand types are its result types is a no-op.
    fn fold_cast(&self, op: OpId) -> Fold<'a> {
        let d = &self[op];
        if d.operands.is_empty() || self.types(&d.operands) != self.types(&d.results) {
            return Fold::Failed;
        }
        Fold::Results(d.operands.iter().map(|v| Folded::Value(*v)).collect())
    }

    /// `op(op(x)) = x`.
    fn fold_involution(&self, op: OpId) -> Fold<'a> {
        let [x] = self[op].operands[..] else { return Fold::Failed };
        match self.def_op(x) {
            Some(inner) if self[inner].name == self[op].name => Folded::Value(self[inner].operands[0]).into(),
            _ => Fold::Failed,
        }
    }

    /// `op(op(x)) = op(x)` (and `op(x, x) = x` for two operands).
    fn fold_idempotent(&self, op: OpId) -> Fold<'a> {
        match self[op].operands[..] {
            [x] => match self.def_op(x) {
                Some(inner) if self[inner].name == self[op].name => Folded::Value(x).into(),
                _ => Fold::Failed,
            },
            [x, y] if x == y => Folded::Value(x).into(),
            _ => Fold::Failed,
        }
    }

    /// ⭐ `Dialect::materializeConstant` for the dialect of op `of`: the op to build, if the
    /// dialect can hold `value` as a `ty`.
    pub fn materialize(&self, of: &str, value: &Attribute<'a>, ty: &Type<'a>) -> Option<OpData<'a>> {
        crate::canon::materialize(of.split_once('.').map_or(of, |(ns, _)| ns), value, ty)
    }
}
