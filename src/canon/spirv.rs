//! `spirv` folds and canonicalization patterns, as `SPIRVCanonicalization.cpp` (and its DRR
//! patterns, `SPIRVCanonicalization.td`).

use alloc::vec::Vec;

use mlirformat::spirv_types::SpirvType;
use mlirformat::{ApInt, Attribute, Const, Scalar, Type};

use crate::{Body, Fold, Folded, OpData, OpId, PatternSet, Rewriter, ValueId};

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
        if let Some(p) = self.poison() {
            return p;
        }
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

    /// A poison operand makes the result poison (`constFoldBinaryOp` / `constFoldUnaryOp`).
    fn poison(&self) -> Option<Fold<'a>> {
        self.c.iter().flatten().find(|a| a.is_poison()).map(|a| Self::attr(a.clone()))
    }

    fn unary(&self, f: impl Fn(ApInt) -> ApInt) -> Fold<'a> {
        if let Some(p) = self.poison() {
            return p;
        }
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

    pub fn fold(&mut self) -> Fold<'a> {
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
                None => self.select_elements(),
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
            "Bitcast" => self.bitcast_chain(),
            "CompositeExtract" => self.composite_extract(),
            _ => Fold::Failed,
        }
    }
}

impl<'a> Folder<'_, 'a> {
    /// `SelectOp::fold` of three dense constants, element by element (a splat when all agree,
    /// as `DenseElementsAttr::get`).
    fn select_elements(&self) -> Fold<'a> {
        let (Some(c), Some(t), Some(f)) = (self.cst(0), self.cst(1), self.cst(2)) else { return Fold::Failed };
        if !(c.elements && t.elements && f.elements) {
            return Fold::Failed;
        }
        let Some(n) = t.ty.element_count() else { return Fold::Failed };
        let mut values = Vec::with_capacity(n);
        for i in 0..n {
            let Some(cond) = c.at(i).int() else { return Fold::Failed };
            values.push(if cond.is_zero() { f.at(i) } else { t.at(i) });
        }
        if values.windows(2).all(|w| w[0] == w[1]) {
            values.truncate(1);
        }
        Self::attr(Const { ty: t.ty.clone(), values, elements: true }.into())
    }

    /// `BitcastOp::fold` through a bitcast: back to its input's type folds to the input, else
    /// the outer cast reads the inner one's input.
    fn bitcast_chain(&mut self) -> Fold<'a> {
        let Some(prev) = self.b.def_op(self.v(0)).filter(|d| self.b[*d].name == "spirv.Bitcast") else { return Fold::Failed };
        let input = self.b[prev].operands[0];
        if self.b[input].ty == self.ty() {
            return Fold::Results(alloc::vec![Folded::Value(input)]);
        }
        self.b.set_operand(self.op, 0, input);
        Fold::InPlace
    }

    /// `CompositeExtractOp::fold`: through inserts of other indices to an insert of the same,
    /// a full single-index construct's constituent, or the constant's element.
    fn composite_extract(&self) -> Fold<'a> {
        let Some(Attribute::Array(idx)) = self.b[self.op].get("indices") else { return Fold::Failed };
        let idx: Vec<i64> = idx.iter().filter_map(|a| Const::try_from(a).ok()?.as_int().map(|i| i.signed() as i64)).collect();
        let mut composite = self.v(0);
        while let Some(ins) = self.b.def_op(composite).filter(|d| self.b[*d].name == "spirv.CompositeInsert") {
            if self.b[ins].get("indices") == self.b[self.op].get("indices") {
                return Fold::Results(alloc::vec![Folded::Value(self.b[ins].operands[0])]);
            }
            composite = self.b[ins].operands[1];
        }
        if let Some(cons) = self.b.def_op(composite).filter(|d| self.b[*d].name == "spirv.CompositeConstruct")
            && let [i] = idx[..]
        {
            let parts = &self.b[cons].operands;
            let ty = &self.b[self.b[cons].results[0]].ty;
            let n = match SpirvType::try_from(ty) {
                Ok(SpirvType::Array { len, .. }) => Some(len as usize),
                Ok(SpirvType::Struct { members: Some(ms), .. }) => Some(ms.len()),
                Ok(_) => None,
                Err(()) => ty.element_count(),
            };
            if n == Some(parts.len()) && (i as usize) < parts.len() {
                return Fold::Results(alloc::vec![Folded::Value(parts[i as usize])]);
            }
        }
        match self.c.first().cloned().flatten().and_then(|a| Self::element(a, &idx)) {
            Some(a) => Self::attr(a),
            None => Fold::Failed,
        }
    }

    /// `extractCompositeElement`.
    fn element(composite: Attribute<'a>, idx: &[i64]) -> Option<Attribute<'a>> {
        let Some((&i, rest)) = idx.split_first() else { return Some(composite) };
        match composite {
            Attribute::Array(es) => Self::element(es.get(i as usize)?.clone(), rest),
            a => {
                let c = Const::try_from(&a).ok()?;
                if !c.elements || !rest.is_empty() {
                    return None;
                }
                let elem = c.ty.element_type().clone();
                Some(match c.at(i as usize) {
                    Scalar::Int(v) if elem == Type::I1 => Attribute::Bool(!v.is_zero()),
                    v => Const::scalar(v, elem).into(),
                })
            }
        }
    }
}

/// A constant operand: its `Const` (a bool as `i1`).
fn constant<'a>(b: &Body<'a>, v: ValueId) -> Option<Const<'a>> {
    match b.constant_of(v)? {
        Attribute::Bool(x) => Some(Const::int(ApInt::new(1, i128::from(x)), Type::I1)),
        a => Const::try_from(&a).ok(),
    }
}

/// `m_Zero` / `m_One`: a scalar or splat integer `v`.
fn is_int(b: &Body<'_>, v: ValueId, want: i128) -> bool {
    constant(b, v).is_some_and(|c| c.is_splat() && c.at(0).int().is_some_and(|i| i.signed() == want || (want == 1 && i.bits() == 1)))
}

/// `constFoldBinaryOp<IntegerAttr>` of two constants, as the attribute for `ty`.
fn fold_binary<'a>(a: &Const<'a>, b: &Const<'a>, ty: &Type<'a>, f: impl Fn(ApInt, ApInt) -> ApInt) -> Option<Attribute<'a>> {
    let n = a.values.len().max(b.values.len());
    let values = (0..n).map(|i| Some(Scalar::Int(f(a.at(i).int()?, b.at(i).int()?)))).collect::<Option<Vec<_>>>()?;
    Some(Const { ty: ty.clone(), values, elements: a.elements || b.elements }.into())
}

/// A pair of constituents as the op's struct: `spirv.CompositeConstruct`.
fn construct<'a>(rw: &mut Rewriter<'_, 'a>, op: OpId, parts: &[ValueId]) {
    let ty = rw.body[rw.body[op].results[0]].ty.clone();
    rw.replace_with(op, OpData::build("spirv.CompositeConstruct").operands(parts), &[ty]);
}

/// The two constituents inserted into an undef of the op's struct, the second replacing it.
fn insert_pair<'a>(rw: &mut Rewriter<'_, 'a>, op: OpId, first: Attribute<'a>, second: Attribute<'a>) {
    rw.set_before(op);
    let ty = rw.body[rw.body[op].results[0]].ty.clone();
    let ct = rw.body[rw.body[op].operands[0]].ty.clone();
    let c0 = rw.create(OpData::build("spirv.Constant").with("value", first), core::slice::from_ref(&ct));
    let c1 = rw.create(OpData::build("spirv.Constant").with("value", second), core::slice::from_ref(&ct));
    let undef = rw.create(OpData::build("spirv.Undef"), core::slice::from_ref(&ty));
    let (c0, c1, undef) = (rw.body[c0].results[0], rw.body[c1].results[0], rw.body[undef].results[0]);
    let index = |i: i128| Attribute::Array(alloc::vec![Attribute::integer(i, Type::int(32))]);
    let mid = rw.create(OpData::build("spirv.CompositeInsert").operands(&[c0, undef]).with("indices", index(0)), core::slice::from_ref(&ty));
    let mid = rw.body[mid].results[0];
    rw.replace_with(op, OpData::build("spirv.CompositeInsert").operands(&[c1, mid]).with("indices", index(1)), &[ty]);
}

/// `MulExtendedFold`: a zero rhs gives zeros; constants fold to the low and high halves.
fn mul_extended(rw: &mut Rewriter<'_, '_>, op: OpId, signed: bool) -> bool {
    rw.set_before(op);
    let (lhs, rhs) = (rw.body[op].operands[0], rw.body[op].operands[1]);
    let ct = rw.body[lhs].ty.clone();
    if is_int(rw.body, rhs, 0) {
        let zero = match &ct {
            Type::Shaped(s) => Const::splat(Scalar::Int(ApInt::zero(s.elem.bit_width().unwrap_or(32))), ct.clone()).into(),
            t => Attribute::integer(0, t.clone()),
        };
        let z = rw.create(OpData::build("spirv.Constant").with("value", zero), core::slice::from_ref(&ct));
        let z = rw.body[z].results[0];
        construct(rw, op, &[z, z]);
        return true;
    }
    let (Some(a), Some(b)) = (constant(rw.body, lhs), constant(rw.body, rhs)) else { return false };
    let Some(low) = fold_binary(&a, &b, &ct, |x, y| x.mul(y)) else { return false };
    let high = fold_binary(&a, &b, &ct, |x, y| {
        let w = x.width;
        if signed { ApInt::new(w, (x.signed() * y.signed()) >> w) } else { ApInt::from_bits(w, (x.unsigned() * y.unsigned()) >> w) }
    });
    let Some(high) = high else { return false };
    insert_pair(rw, op, low, high);
    true
}

/// The DRR `LogicalNot` rewrites: the negated comparison.
fn negate_compare(rw: &mut Rewriter<'_, '_>, op: OpId, from: &str, to: &str) -> bool {
    let Some(cmp) = rw.body.def_op(rw.body[op].operands[0]).filter(|d| rw.body[*d].name == from) else { return false };
    let ops = rw.body[cmp].operands.clone();
    let ty = rw.body[rw.body[op].results[0]].ty.clone();
    rw.replace_with(op, OpData::build(to).operands(&ops), &[ty]);
    true
}

/// The DRR clamp rewrites: `select(cmp(select(cmp(min, x), x, min), max), .., max)` and
/// `select(cmp(max, x), max, select(cmp(x, min), min, x))` as `spirv.GL.*Clamp(x, min, max)`.
#[cfg_attr(not(feature = "spirv"), allow(dead_code))]
fn clamp(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
    const PAIRS: [(&str, &str); 6] = [
        ("spirv.FOrdLessThan", "spirv.GL.FClamp"),
        ("spirv.FOrdLessThanEqual", "spirv.GL.FClamp"),
        ("spirv.SLessThan", "spirv.GL.SClamp"),
        ("spirv.SLessThanEqual", "spirv.GL.SClamp"),
        ("spirv.ULessThan", "spirv.GL.UClamp"),
        ("spirv.ULessThanEqual", "spirv.GL.UClamp"),
    ];
    let b = &*rw.body;
    let def = |v: ValueId, name: &str| b.def_op(v).filter(|d| b[*d].name == name);
    let [c, t, f] = b[op].operands[..] else { return false };
    let found = PAIRS.iter().find_map(|(cmp, clamp)| {
        let outer = def(c, cmp)?;
        let [l, r] = b[outer].operands[..] else { return None };
        // `$min < $input`, `$input < $max`.
        let first = (|| {
            let inner = def(l, "spirv.Select")?;
            let [ic, it, if_] = b[inner].operands[..] else { return None };
            let icmp = def(ic, cmp)?;
            let [min, input] = b[icmp].operands[..] else { return None };
            (it == input && if_ == min && r == f && t == l).then_some([input, min, f])
        })();
        // `$input < $min`, `$max < $input`.
        let second = || {
            let inner = def(f, "spirv.Select")?;
            let [ic, it, if_] = b[inner].operands[..] else { return None };
            let icmp = def(ic, cmp)?;
            let [input, min] = b[icmp].operands[..] else { return None };
            (l == t && r == input && it == min && if_ == input).then_some([input, min, t])
        };
        Some((*clamp, first.or_else(second)?))
    });
    let Some((name, args)) = found else { return false };
    let ty = rw.body[rw.body[op].results[0]].ty.clone();
    rw.replace_with(op, OpData::build(name).operands(&args), &[ty]);
    true
}

rewrites! {
    /// `CombineChainedAccessChain`.
    CombineChainedAccessChain("spirv.AccessChain", 1) |rw, op| {
        let Some(parent) = rw.body.def_op(rw.body[op].operands[0]).filter(|d| rw.body[*d].name == "spirv.AccessChain") else { return false };
        let mut ops = rw.body[parent].operands.clone();
        ops.extend_from_slice(&rw.body[op].operands[1..]);
        let ty = rw.body[rw.body[op].results[0]].ty.clone();
        rw.replace_with(op, OpData::build("spirv.AccessChain").operands(&ops), &[ty]);
        true
    }

    /// `IAddCarryFold`: a zero rhs is no carry; constants fold.
    IAddCarryFold("spirv.IAddCarry", 1) |rw, op| {
        let (lhs, rhs) = (rw.body[op].operands[0], rw.body[op].operands[1]);
        if is_int(rw.body, rhs, 0) {
            construct(rw, op, &[rhs, lhs]);
            return true;
        }
        let (Some(a), Some(b)) = (constant(rw.body, lhs), constant(rw.body, rhs)) else { return false };
        let ct = rw.body[lhs].ty.clone();
        let Some(sum) = fold_binary(&a, &b, &ct, |x, y| x.add(y)) else { return false };
        let Ok(s) = Const::try_from(&sum) else { return false };
        let Some(carry) = fold_binary(&s, &a, &ct, |x, y| ApInt::new(x.width, i128::from(x.unsigned() < y.unsigned()))) else { return false };
        insert_pair(rw, op, sum, carry);
        true
    }

    /// `MulExtendedFold<SMulExtendedOp>`.
    SMulExtendedFold("spirv.SMulExtended", 1) |rw, op| {
        mul_extended(rw, op, true)
    }

    /// `MulExtendedFold<UMulExtendedOp>`.
    UMulExtendedFold("spirv.UMulExtended", 1) |rw, op| {
        mul_extended(rw, op, false)
    }

    /// `UMulExtendedOpXOne`: times one is the lhs, no high bits.
    UMulExtendedOpXOne("spirv.UMulExtended", 1) |rw, op| {
        let (lhs, rhs) = (rw.body[op].operands[0], rw.body[op].operands[1]);
        if !is_int(rw.body, rhs, 1) {
            return false;
        }
        rw.set_before(op);
        let ct = rw.body[lhs].ty.clone();
        let zero = match &ct {
            Type::Shaped(s) => Const::splat(Scalar::Int(ApInt::zero(s.elem.bit_width().unwrap_or(32))), ct.clone()).into(),
            t => Attribute::integer(0, t.clone()),
        };
        let z = rw.create(OpData::build("spirv.Constant").with("value", zero), core::slice::from_ref(&ct));
        let z = rw.body[z].results[0];
        construct(rw, op, &[lhs, z]);
        true
    }

    /// `UModSimplification`: `(x % a) % b` is `x % b` when `b` divides `a`.
    UModSimplification("spirv.UMod", 1) |rw, op| {
        let b = &*rw.body;
        let Some(prev) = b.def_op(b[op].operands[0]).filter(|d| b[*d].name == "spirv.UMod") else { return false };
        let (Some(p), Some(c)) = (constant(b, b[prev].operands[1]), constant(b, b[op].operands[1])) else { return false };
        let n = p.values.len().max(c.values.len());
        if !(0..n).all(|i| matches!((p.at(i).int(), c.at(i).int()), (Some(x), Some(y)) if x.urem(y).is_some_and(ApInt::is_zero))) {
            return false;
        }
        let ops = [b[prev].operands[0], b[op].operands[1]];
        let ty = b[b[op].results[0]].ty.clone();
        rw.replace_with(op, OpData::build("spirv.UMod").operands(&ops), &[ty]);
        true
    }

    ConvertLogicalNotOfIEqual("spirv.LogicalNot", 2) |rw, op| {
        negate_compare(rw, op, "spirv.IEqual", "spirv.INotEqual")
    }

    ConvertLogicalNotOfINotEqual("spirv.LogicalNot", 2) |rw, op| {
        negate_compare(rw, op, "spirv.INotEqual", "spirv.IEqual")
    }

    ConvertLogicalNotOfLogicalEqual("spirv.LogicalNot", 2) |rw, op| {
        negate_compare(rw, op, "spirv.LogicalEqual", "spirv.LogicalNotEqual")
    }

    ConvertLogicalNotOfLogicalNotEqual("spirv.LogicalNot", 2) |rw, op| {
        negate_compare(rw, op, "spirv.LogicalNotEqual", "spirv.LogicalEqual")
    }

    #[cfg_attr(not(feature = "spirv"), allow(dead_code))]
    ConvertComparisonIntoClamp("spirv.Select", 4) |rw, op| {
        clamp(rw, op)
    }

    /// `ConvertSelectionOpToSelect`: a diamond storing one of two values to the same pointer is
    /// a store of a `spirv.Select`.
    ConvertSelectionOpToSelect("spirv.mlir.selection", 1) |rw, op| {
        let b = &*rw.body;
        let Some(&region) = b[op].regions.first() else { return false };
        let blocks = &b[region].blocks;
        if blocks.len() != 4 {
            return false;
        }
        let (header, merge) = (blocks[0], blocks[3]);
        let [br] = b[header].ops[..] else { return false };
        if b[br].name != "spirv.BranchConditional" {
            return false;
        }
        let [tb, fb] = b[br].successors[..] else { return false };
        let arm = |blk: crate::BlockId| {
            let [store, jump] = b[blk].ops[..] else { return None };
            (b[store].name == "spirv.Store" && b[jump].name == "spirv.Branch" && b[jump].successors.first() == Some(&merge)).then_some(store)
        };
        let (Some(ts), Some(fs)) = (arm(tb), arm(fb)) else { return false };
        let (ptr, tv, fv) = (b[ts].operands[0], b[ts].operands[1], b[fs].operands[1]);
        let ty = b[tv].ty.clone();
        let scalar_or_vector = matches!(&ty, Type::Integer { .. } | Type::Float(_)) || matches!(&ty, Type::Shaped(s) if s.kind == mlirformat::ShapedKind::Vector);
        if ptr != b[fs].operands[0] || b[ts].all_attrs() != b[fs].all_attrs() || !scalar_or_vector {
            return false;
        }
        let attrs = b[ts].all_attrs();
        let cond = b[br].operands[0];
        rw.set_before(op);
        let sel = rw.create(OpData::build("spirv.Select").operands(&[cond, tv, fv]), core::slice::from_ref(&ty));
        let sel = rw.body[sel].results[0];
        let mut store = OpData::build("spirv.Store").operands(&[ptr, sel]);
        for a in attrs {
            store.set(&a.name, a.value.unwrap_or(Attribute::Unit));
        }
        rw.create(store, &[]);
        rw.erase_op(op);
        true
    }
}

/// The spirv canonicalization patterns, in op registration order.
pub fn patterns(set: &mut PatternSet) {
    set.add(CombineChainedAccessChain);
    set.add(IAddCarryFold);
    set.add(SMulExtendedFold);
    set.add(UMulExtendedFold);
    set.add(UMulExtendedOpXOne);
    set.add(UModSimplification);
    set.add(ConvertLogicalNotOfIEqual);
    set.add(ConvertLogicalNotOfINotEqual);
    set.add(ConvertLogicalNotOfLogicalEqual);
    set.add(ConvertLogicalNotOfLogicalNotEqual);
    set.add(ConvertSelectionOpToSelect);
}

/// `populateSPIRVGLCanonicalizationPatterns`: the clamp patterns.
#[cfg(feature = "spirv")]
pub fn gl_patterns(set: &mut PatternSet) {
    set.add(ConvertComparisonIntoClamp);
}

/// `SPIRVDialect::materializeConstant`: a `spirv.Constant`.
pub fn materialize<'a>(value: &Attribute<'a>, _: &Type<'a>) -> Option<OpData<'a>> {
    if value.is_poison() {
        return Some(OpData::build("ub.poison").with("value", value.clone()));
    }
    Some(OpData::build("spirv.Constant").with("value", value.clone()))
}
