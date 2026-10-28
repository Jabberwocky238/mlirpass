//! `spirv` folds, as `SPIRVCanonicalization.cpp`'s `fold` methods.

use alloc::vec::Vec;

use mlirformat::{ApInt, Attribute, Const, Scalar, Type};

use crate::{Body, Fold, Folded, OpData, OpId, ValueId};

/// Folds one `spirv` op with its operands' constants `c`.
pub struct Folder<'x, 'a> {
    pub b: &'x mut Body<'a>,
    pub op: OpId,
    pub c: &'x [Option<Attribute<'a>>],
}

impl<'x, 'a> Folder<'x, 'a> {
    fn v(&self, i: usize) -> ValueId {
        self.b[self.op].operands[i]
    }

    fn ty(&self) -> Type<'a> {
        self.b[self.b[self.op].results[0]].ty.clone()
    }

    fn cst(&self, i: usize) -> Option<Const<'a>> {
        match self.c.get(i)?.as_ref()? {
            Attribute::Bool(v) => Some(Const::int(ApInt::new(1, i128::from(*v)), Type::I1)),
            a => Const::try_from(a).ok(),
        }
    }

    /// `m_ConstantInt` / `m_Zero` / `m_One` on operand `i`: a scalar or splat integer.
    fn int(&self, i: usize) -> Option<ApInt> {
        let c = self.cst(i)?;
        if !c.is_splat() && c.values.len() != 1 {
            return None;
        }
        c.at(0).int()
    }

    fn value(&self, i: usize) -> Fold<'a> {
        Fold::Results(alloc::vec![Folded::Value(self.v(i))])
    }

    fn attr(a: Attribute<'a>) -> Fold<'a> {
        Fold::Results(alloc::vec![Folded::Attr(a)])
    }

    /// `getZeroAttr` / a bool splat of the result type.
    fn splat(&self, f: impl Fn(&Type<'a>) -> ApInt) -> Fold<'a> {
        let ty = self.ty();
        if ty == Type::I1 {
            return Self::attr(Attribute::Bool(!f(&ty).is_zero()));
        }
        match &ty {
            Type::Shaped(s) => Self::attr(Const::splat(Scalar::Int(f(&s.elem)), ty.clone()).into()),
            t => Self::attr(Attribute::integer(f(t).signed(), t.clone())),
        }
    }

    fn zero(&self) -> Fold<'a> {
        self.splat(|t| ApInt::new(t.bit_width().unwrap_or(32), 0))
    }

    fn bool_(&self, v: bool) -> Fold<'a> {
        self.splat(|_| ApInt::new(1, i128::from(v)))
    }

    /// `constFoldBinaryOp<IntegerAttr>`: element by element; `None` from `f` gives up.
    fn binary(&self, result_bool: bool, f: impl Fn(ApInt, ApInt) -> Option<ApInt>) -> Fold<'a> {
        let (Some(a), Some(b)) = (self.cst(0), self.cst(1)) else { return Fold::Failed };
        let n = a.values.len().max(b.values.len());
        let mut out = Vec::new();
        for i in 0..n {
            let (Some(x), Some(y)) = (a.at(i).int(), b.at(i).int()) else { return Fold::Failed };
            let Some(r) = f(x, y) else { return Fold::Failed };
            out.push(Scalar::Int(r));
        }
        self.result(out, result_bool, a.elements || b.elements)
    }

    fn unary(&self, f: impl Fn(ApInt) -> ApInt) -> Fold<'a> {
        let Some(a) = self.cst(0) else { return Fold::Failed };
        let mut out = Vec::new();
        for i in 0..a.values.len() {
            let Some(x) = a.at(i).int() else { return Fold::Failed };
            out.push(Scalar::Int(f(x)));
        }
        self.result(out, false, a.elements)
    }

    fn result(&self, values: Vec<Scalar>, _bool: bool, elements: bool) -> Fold<'a> {
        let ty = self.ty();
        if ty == Type::I1 {
            return Self::attr(Attribute::Bool(matches!(values[0], Scalar::Int(i) if !i.is_zero())));
        }
        Self::attr(Const { ty, values, elements }.into())
    }

    fn cmp(&self, same: bool, f: impl Fn(ApInt, ApInt) -> bool) -> Fold<'a> {
        if self.v(0) == self.v(1) {
            return self.bool_(same);
        }
        self.binary(true, |a, b| Some(ApInt::new(1, i128::from(f(a, b)))))
    }

    fn shift(&self, f: impl Fn(ApInt, u32) -> ApInt) -> Fold<'a> {
        if self.int(1).is_some_and(ApInt::is_zero) {
            return self.value(0);
        }
        self.binary(false, |a, b| (b.bits() < u128::from(a.width)).then(|| f(a, b.bits() as u32)))
    }

    pub fn fold(&self) -> Fold<'a> {
        let one = |i: Option<ApInt>| i.is_some_and(|x| x.bits() == 1 || (x.width == 1 && x.bits() == 1));
        let zero = |i: Option<ApInt>| i.is_some_and(ApInt::is_zero);
        let w = |a: &ApInt| a.width;
        match self.b[self.op].name.strip_prefix("spirv.").unwrap_or("") {
            "Constant" => self.b[self.op].get("value").cloned().map_or(Fold::Failed, Self::attr),
            "IAdd" if zero(self.int(1)) => self.value(0),
            "IAdd" => self.binary(false, |a, b| Some(ApInt::new(w(&a), a.signed().wrapping_add(b.signed())))),
            "IMul" if zero(self.int(1)) => self.value(1),
            "IMul" if one(self.int(1)) => self.value(0),
            "IMul" => self.binary(false, |a, b| Some(ApInt::from_bits(w(&a), a.bits().wrapping_mul(b.bits())))),
            "ISub" if self.v(0) == self.v(1) => self.zero(),
            "ISub" => self.binary(false, |a, b| Some(ApInt::new(w(&a), a.signed().wrapping_sub(b.signed())))),
            "SDiv" | "UDiv" if one(self.int(1)) => self.value(0),
            "SDiv" => self.binary(false, |a, b| (!b.is_zero() && !(a == ApInt::signed_min(w(&a)) && b.signed() == -1)).then(|| ApInt::new(w(&a), a.signed() / b.signed()))),
            "UDiv" => self.binary(false, |a, b| (!b.is_zero()).then(|| ApInt::from_bits(w(&a), a.bits() / b.bits()))),
            "SMod" | "SRem" | "UMod" if one(self.int(1)) => self.zero(),
            "SRem" => self.binary(false, |a, b| (!b.is_zero() && !(a == ApInt::signed_min(w(&a)) && b.signed() == -1)).then(|| ApInt::new(w(&a), a.signed() % b.signed()))),
            "SMod" => self.binary(false, |a, b| {
                if b.is_zero() || (a == ApInt::signed_min(w(&a)) && b.signed() == -1) {
                    return None;
                }
                let c = a.signed().unsigned_abs() % b.signed().unsigned_abs();
                let c = c as i128;
                let r = if c == 0 {
                    0
                } else if b.signed() < 0 {
                    if a.signed() < 0 { -c } else { b.signed() + c }
                } else if a.signed() < 0 {
                    b.signed() - c
                } else {
                    c
                };
                Some(ApInt::new(w(&a), r))
            }),
            "UMod" => self.binary(false, |a, b| (!b.is_zero()).then(|| ApInt::from_bits(w(&a), a.bits() % b.bits()))),
            "SNegate" | "Not" | "LogicalNot" if self.b.def_op(self.v(0)).is_some_and(|d| self.b[d].name == self.b[self.op].name) => {
                let d = self.b.def_op(self.v(0)).expect("defined");
                Fold::Results(alloc::vec![Folded::Value(self.b[d].operands[0])])
            }
            "SNegate" => self.unary(|a| ApInt::new(a.width, a.signed().wrapping_neg())),
            "Not" => self.unary(|a| ApInt::from_bits(a.width, !a.bits())),
            "LogicalNot" => self.unary(|a| ApInt::new(1, i128::from(a.is_zero()))),
            "LogicalAnd" => match self.int(1) {
                Some(b) if !b.is_zero() => self.value(0),
                Some(_) => self.c[1].clone().map_or(Fold::Failed, Self::attr),
                None => Fold::Failed,
            },
            "LogicalOr" => match self.int(1) {
                Some(b) if !b.is_zero() => self.c[1].clone().map_or(Fold::Failed, Self::attr),
                Some(_) => self.value(0),
                None => Fold::Failed,
            },
            "LogicalNotEqual" if self.int(1).is_some_and(ApInt::is_zero) => self.value(0),
            "LogicalNotEqual" | "INotEqual" => self.cmp(false, |a, b| a != b),
            "LogicalEqual" | "IEqual" => self.cmp(true, |a, b| a == b),
            "SGreaterThan" => self.cmp(false, |a, b| a.signed() > b.signed()),
            "SGreaterThanEqual" => self.cmp(true, |a, b| a.signed() >= b.signed()),
            "SLessThan" => self.cmp(false, |a, b| a.signed() < b.signed()),
            "SLessThanEqual" => self.cmp(true, |a, b| a.signed() <= b.signed()),
            "UGreaterThan" => self.cmp(false, |a, b| a.bits() > b.bits()),
            "UGreaterThanEqual" => self.cmp(true, |a, b| a.bits() >= b.bits()),
            "ULessThan" => self.cmp(false, |a, b| a.bits() < b.bits()),
            "ULessThanEqual" => self.cmp(true, |a, b| a.bits() <= b.bits()),
            "Select" if self.v(1) == self.v(2) => self.value(1),
            "Select" => match self.int(0) {
                Some(c) => self.value(if c.is_zero() { 2 } else { 1 }),
                None => Fold::Failed,
            },
            "ShiftLeftLogical" => self.shift(|a, s| ApInt::from_bits(a.width, a.bits() << s)),
            "ShiftRightArithmetic" => self.shift(|a, s| ApInt::new(a.width, a.signed() >> s)),
            "ShiftRightLogical" => self.shift(|a, s| ApInt::from_bits(a.width, a.bits() >> s)),
            "BitwiseAnd" | "BitwiseOr" if self.v(0) == self.v(1) => self.value(0),
            "BitwiseAnd" => match self.int(1) {
                Some(m) if m.is_zero() => self.value(1),
                Some(m) if m.bits() == ApInt::all_ones(m.width).bits() => self.value(0),
                Some(m) if self.b.def_op(self.v(0)).is_some_and(|d| self.b[d].name == "spirv.UConvert" && {
                    let bits = self.b[self.b[d].operands[0]].ty.element_type().bit_width().unwrap_or(0);
                    bits < 128 && m.bits() & ((1u128 << bits) - 1) == (1u128 << bits) - 1
                }) => self.value(0),
                _ => self.binary(false, |a, b| Some(ApInt::from_bits(a.width, a.bits() & b.bits()))),
            },
            "BitwiseOr" => match self.int(1) {
                Some(m) if m.is_zero() => self.value(0),
                Some(m) if m.bits() == ApInt::all_ones(m.width).bits() => self.value(1),
                _ => self.binary(false, |a, b| Some(ApInt::from_bits(a.width, a.bits() | b.bits()))),
            },
            "BitwiseXor" if zero(self.int(1)) => self.value(0),
            "BitwiseXor" if self.v(0) == self.v(1) => self.zero(),
            "BitwiseXor" => self.binary(false, |a, b| Some(ApInt::from_bits(a.width, a.bits() ^ b.bits()))),
            "Bitcast" if self.b[self.v(0)].ty == self.ty() => self.value(0),
            _ => Fold::Failed,
        }
    }
}

/// `SPIRVDialect::materializeConstant`: a `spirv.Constant`.
pub fn materialize<'a>(value: &Attribute<'a>, _: &Type<'a>) -> Option<OpData<'a>> {
    Some(OpData::build("spirv.Constant").with("value", value.clone()))
}
