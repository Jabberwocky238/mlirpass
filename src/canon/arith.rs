//! `arith`: folds and canonicalization patterns, as `ArithOps.cpp` and
//! `ArithCanonicalization.td`.

use alloc::vec;
use alloc::vec::Vec;
use core::cmp::Ordering;

use mlirformat::{arith, Attribute, FloatKind, Type};

use super::AttrExt;
use crate::{ApFloat, ApInt, Body, Const, Fold, Folded, OpData, OpId, PatternSet, Rewriter, Scalar, ValueId, attr};

/// `CmpIPredicate`, by case value.
const EQ: i64 = 0;
const NE: i64 = 1;
const SLT: i64 = 2;
const SLE: i64 = 3;
const SGT: i64 = 4;
const SGE: i64 = 5;
const ULT: i64 = 6;
const ULE: i64 = 7;
const UGT: i64 = 8;
const UGE: i64 = 9;

/// `ConstantOp::materialize` (poison becomes `ub.poison`).
pub fn materialize<'a>(value: &Attribute<'a>, ty: &Type<'a>) -> Option<OpData<'a>> {
    if crate::is_poison(value) {
        return Some(OpData::build("ub.poison").with("value", value.clone()));
    }
    // `isBuildableWith`: a typed int, float or elements attribute of exactly `ty`, signless.
    let typed = match value {
        Attribute::Bool(_) => Some(Type::I1),
        Attribute::Int { ty, .. } | Attribute::Float { ty, .. } => ty.clone(),
        Attribute::Builtin { name, ty, .. } if matches!(&**name, "dense" | "dense_resource" | "sparse") => ty.clone(),
        _ => None,
    }?;
    if typed != *ty || matches!(ty, Type::Integer { signedness, .. } if *signedness != mlirformat::Signedness::Signless) {
        return None;
    }
    Some(OpData::build("arith.constant").with("value", value.clone()))
}

/// Integer overflow flags (`#arith.overflow<nsw, nuw>`) as bits: nsw = 1, nuw = 2.
fn overflow(a: Option<&Attribute<'_>>) -> u8 {
    let Some(Attribute::Extended { ext, .. }) = a else { return 0 };
    let body = ext.body.as_deref().unwrap_or("");
    u8::from(body.contains("nsw")) | (u8::from(body.contains("nuw")) << 1)
}

fn overflow_attr<'a>(bits: u8) -> Attribute<'a> {
    let body = match bits {
        0 => "<none>",
        1 => "<nsw>",
        2 => "<nuw>",
        _ => "<nsw, nuw>",
    };
    Attribute::dialect("arith.overflow", body)
}

/// Whether fastmath flags `a` include every flag named.
fn fastmath_has(a: Option<&Attribute<'_>>, flags: &[&str]) -> bool {
    let Some(Attribute::Extended { ext, .. }) = a else { return false };
    let body = ext.body.as_deref().unwrap_or("");
    let inner = body.trim_start_matches('<').trim_end_matches('>');
    let set: Vec<&str> = inner.split(',').map(str::trim).collect();
    set.contains(&"fast") || flags.iter().all(|f| set.contains(f))
}

fn pred_of(a: Option<&Attribute<'_>>) -> Option<i64> {
    match a? {
        Attribute::Int { lit, .. } => lit.parse().ok(),
        _ => None,
    }
}

fn cmpi(pred: i64, l: ApInt, r: ApInt) -> bool {
    match pred {
        EQ => l == r,
        NE => l != r,
        SLT => l.scmp(r) == Ordering::Less,
        SLE => l.scmp(r) != Ordering::Greater,
        SGT => l.scmp(r) == Ordering::Greater,
        SGE => l.scmp(r) != Ordering::Less,
        ULT => l.ucmp(r) == Ordering::Less,
        ULE => l.ucmp(r) != Ordering::Greater,
        UGT => l.ucmp(r) == Ordering::Greater,
        _ => l.ucmp(r) != Ordering::Less,
    }
}

fn cmpf(pred: i64, l: ApFloat, r: ApFloat) -> bool {
    let c = l.compare(r);
    let (lt, eq, gt, un) = (c == Some(Ordering::Less), c == Some(Ordering::Equal), c == Some(Ordering::Greater), c.is_none());
    match pred {
        0 => false,
        1 => eq,
        2 => gt,
        3 => gt || eq,
        4 => lt,
        5 => lt || eq,
        6 => !un && !eq,
        7 => !un,
        8 => un || eq,
        9 => un || gt,
        10 => un || gt || eq,
        11 => un || lt,
        12 => un || lt || eq,
        13 => !eq,
        14 => un,
        _ => true,
    }
}

/// `llvm::maximum` / `minimum` (NaN wins) and `maxnum` / `minnum` (NaN loses); -0 < +0.
fn minmax(a: ApFloat, b: ApFloat, max: bool, nan_wins: bool) -> ApFloat {
    if a.is_nan() || b.is_nan() {
        if nan_wins {
            return if a.is_nan() { a.quieted() } else { b.quieted() };
        }
        return if a.is_nan() { b } else { a };
    }
    if a.is_zero() && b.is_zero() && a.is_negative() != b.is_negative() {
        return if a.is_negative() == max { b } else { a };
    }
    let less = a.compare(b) == Some(Ordering::Less);
    if max { if less { b } else { a } } else if b.compare(a) == Some(Ordering::Less) { b } else { a }
}

/// One fold: the op, its operands' constants, and the body.
pub struct Folder<'x, 'a> {
    pub b: &'x mut Body<'a>,
    pub op: OpId,
    pub c: &'x [Option<Attribute<'a>>],
}

impl<'x, 'a> Folder<'x, 'a> {
    fn v(&self, i: usize) -> ValueId {
        self.b[self.op].operands[i]
    }

    fn res(&self) -> ValueId {
        self.b[self.op].results[0]
    }

    fn ty(&self) -> Type<'a> {
        self.b[self.res()].ty.clone()
    }

    fn cst(&self, i: usize) -> Option<Const<'a>> {
        self.c.get(i)?.as_ref().and_then(|a| Const::try_from(a).ok())
    }

    /// `m_ConstantInt`.
    fn int(&self, i: usize) -> Option<ApInt> {
        self.cst(i)?.as_int()
    }

    fn zero(&self, i: usize) -> bool {
        self.int(i).is_some_and(ApInt::is_zero)
    }

    fn one(&self, i: usize) -> bool {
        self.int(i).is_some_and(ApInt::is_one)
    }

    fn float(&self, i: usize) -> Option<ApFloat> {
        self.cst(i)?.as_float()
    }

    fn poison(&self, i: usize) -> bool {
        self.c.get(i).and_then(Option::as_ref).is_some_and(crate::is_poison)
    }

    fn prop(&self, name: &str) -> Option<&Attribute<'a>> {
        self.b[self.op].get(name)
    }

    fn def(&self, i: usize, name: &str) -> Option<OpId> {
        self.b.def_named(self.v(i), name)
    }

    /// `constFoldBinaryOp`: poison passes through; scalars, splats and elements fold
    /// element-wise into `ty` (default: the operands' type).
    fn binary(&self, ty: Option<Type<'a>>, f: impl Fn(Scalar, Scalar) -> Option<Scalar>) -> Option<Attribute<'a>> {
        for i in 0..2 {
            if self.poison(i) {
                return self.c[i].clone();
            }
        }
        let (l, r) = (self.cst(0)?, self.cst(1)?);
        if l.ty != r.ty || l.elements != r.elements {
            return None;
        }
        let ty = ty.unwrap_or_else(|| l.ty.clone());
        let n = if l.is_splat() && r.is_splat() { 1 } else { l.values.len().max(r.values.len()) };
        let values = (0..n).map(|i| f(l.at(i), r.at(i))).collect::<Option<Vec<_>>>()?;
        Some(Const { ty, values, elements: l.elements }.into())
    }

    fn int_binary(&self, f: impl Fn(ApInt, ApInt) -> Option<ApInt>) -> Fold<'a> {
        self.binary(None, |a, b| Some(Scalar::Int(f(a.int()?, b.int()?)?))).map(Folded::Attr).into()
    }

    fn float_binary(&self, f: impl Fn(ApFloat, ApFloat) -> ApFloat) -> Fold<'a> {
        self.binary(None, |a, b| Some(Scalar::Float(f(a.float()?, b.float()?)))).map(Folded::Attr).into()
    }

    /// `constFoldUnaryOp` / `constFoldCastOp` into `ty`.
    fn unary(&self, ty: Type<'a>, f: impl Fn(Scalar) -> Option<Scalar>) -> Fold<'a> {
        if self.poison(0) {
            return self.c[0].clone().map(Folded::Attr).into();
        }
        let Some(c) = self.cst(0) else { return Fold::Failed };
        let elem = attr::element_type(&ty).clone();
        let ty = if c.elements { ty } else { elem };
        c.map(ty, f).map(|c| Folded::Attr(c.into())).into()
    }

    fn value(v: ValueId) -> Fold<'a> {
        Folded::Value(v).into()
    }

    fn attr(a: Option<Attribute<'a>>) -> Fold<'a> {
        a.map(Folded::Attr).into()
    }

    /// `Builder::getZeroAttr`.
    fn zero_attr(ty: &Type<'a>) -> Option<Attribute<'a>> {
        let elem = attr::element_type(ty);
        let z = match elem {
            Type::Float(k) => Scalar::Float(ApFloat::from_f64(*k, 0.0)?),
            t => Scalar::Int(ApInt::zero(attr::int_width(t)?.0)),
        };
        Some(match ty {
            Type::Shaped(s) if s.kind != mlirformat::ShapedKind::MemRef => Const::splat(z, ty.clone()).into(),
            Type::Shaped(_) => return None,
            t => Const::scalar(z, t.clone()).into(),
        })
    }

    /// `getBoolAttribute`.
    fn bool_attr(ty: &Type<'a>, v: bool) -> Attribute<'a> {
        match ty {
            Type::Shaped(_) => Const::splat(Scalar::Int(ApInt::new(1, i128::from(v))), ty.clone()).into(),
            _ => Attribute::Bool(v),
        }
    }

    fn width_of(&self, v: ValueId) -> Option<u32> {
        attr::int_width(attr::element_type(&self.b[v].ty)).map(|w| w.0)
    }

    /// The fold of the op.
    pub fn fold(&mut self) -> Fold<'a> {
        let name = self.b[self.op].name.clone();
        let Some(op) = name.strip_prefix("arith.") else { return Fold::Failed };
        match op {
            "constant" => Self::attr(self.prop("value").cloned()),
            "addi" => self.addi(),
            "subi" => self.subi(),
            "muli" => {
                if self.zero(1) {
                    return Self::value(self.v(1));
                }
                if self.one(1) {
                    return Self::value(self.v(0));
                }
                self.int_binary(|a, b| Some(a.mul(b)))
            }
            "divui" | "divsi" => self.div(op == "divsi"),
            "ceildivui" => {
                if self.one(1) {
                    return Self::value(self.v(0));
                }
                self.int_binary(|a, b| {
                    let q = a.udiv(b)?;
                    if a.urem(b)?.is_zero() {
                        return Some(q);
                    }
                    let (r, ov) = q.uadd_ov(ApInt::new(a.width, 1));
                    (!ov).then_some(r)
                })
            }
            "ceildivsi" => {
                if self.one(1) {
                    return Self::value(self.v(0));
                }
                self.int_binary(Self::ceildivsi)
            }
            "floordivsi" => {
                if self.one(1) {
                    return Self::value(self.v(0));
                }
                self.int_binary(|a, b| {
                    let (q, ov) = a.sdiv_ov(b)?;
                    if ov {
                        return None;
                    }
                    // Round toward negative infinity.
                    let r = a.srem(b)?;
                    Some(if !r.is_zero() && (r.is_negative() != b.is_negative()) { q.sub(ApInt::new(a.width, 1)) } else { q })
                })
            }
            "remui" | "remsi" => {
                if self.one(1) {
                    return Self::attr(Self::zero_attr(&self.ty()));
                }
                let signed = op == "remsi";
                self.int_binary(|a, b| if signed { a.srem(b) } else { a.urem(b) })
            }
            "andi" => self.andi(),
            "ori" => self.ori(),
            "xori" => self.xori(),
            "negf" => {
                if let Some(inner) = self.def(0, "arith.negf") {
                    return Self::value(self.b[inner].operands[0]);
                }
                let ty = self.ty();
                self.unary(ty, |a| Some(Scalar::Float(a.float()?.neg())))
            }
            "addf" => {
                if self.float(1).is_some_and(|f| f.is_zero() && f.is_negative()) {
                    return Self::value(self.v(0));
                }
                self.float_binary(ApFloat::add)
            }
            "subf" => {
                if self.float(1).is_some_and(|f| f.is_zero() && !f.is_negative()) {
                    return Self::value(self.v(0));
                }
                self.float_binary(ApFloat::sub)
            }
            "maximumf" | "minimumf" | "maxnumf" | "minnumf" => {
                if self.v(0) == self.v(1) {
                    return Self::value(self.v(1));
                }
                let max = op.starts_with("max");
                let nan_wins = op.ends_with("imumf");
                let skip = self.float(1).is_some_and(|f| if nan_wins { f.is_inf() && f.is_negative() == max } else { f.is_nan() });
                if skip {
                    return Self::value(self.v(0));
                }
                self.float_binary(move |a, b| minmax(a, b, max, nan_wins))
            }
            "maxsi" | "maxui" | "minsi" | "minui" => self.int_minmax(op),
            "mulf" => {
                if self.float(1).is_some_and(|f| f.to_f64() == 1.0) {
                    return Self::value(self.v(0));
                }
                if fastmath_has(self.prop("fastmath"), &["nnan", "nsz"]) && self.float(1).is_some_and(ApFloat::is_zero) {
                    return Self::value(self.v(1));
                }
                self.float_binary(ApFloat::mul)
            }
            "divf" => {
                if self.float(1).is_some_and(|f| f.to_f64() == 1.0) {
                    return Self::value(self.v(0));
                }
                self.float_binary(ApFloat::div)
            }
            "remf" => self.float_binary(|a, b| a.binary(b, |x, y| x % y, |x, y| x % y)),
            "extui" | "extsi" => {
                if let Some(inner) = self.def(0, &name) {
                    let src = self.b[inner].operands[0];
                    self.b.set_operand(self.op, 0, src);
                    return Self::value(self.res());
                }
                let ty = self.ty();
                let Some(w) = attr::int_width(attr::element_type(&ty)).map(|w| w.0) else { return Fold::Failed };
                let signed = op == "extsi";
                self.unary(ty, move |a| Some(Scalar::Int(if signed { a.int()?.sext(w) } else { a.int()?.zext(w) })))
            }
            "trunci" => self.trunci(),
            "extf" => self.extf(),
            "truncf" => self.truncf(),
            "uitofp" | "sitofp" => {
                let ty = self.ty();
                let Type::Float(k) = *attr::element_type(&ty) else { return Fold::Failed };
                let signed = op == "sitofp";
                self.unary(ty, move |a| {
                    let i = a.int()?;
                    let x = if signed { i.signed() as f64 } else { i.unsigned() as f64 };
                    let f = if k == FloatKind::F32 {
                        let y = if signed { i.signed() as f32 } else { i.unsigned() as f32 };
                        ApFloat::from_bits(k, y.to_bits() as u64)?
                    } else {
                        ApFloat::from_f64(k, x)?
                    };
                    Some(Scalar::Float(f))
                })
            }
            "fptoui" | "fptosi" => {
                let ty = self.ty();
                let Some(w) = attr::int_width(attr::element_type(&ty)).map(|w| w.0) else { return Fold::Failed };
                let signed = op == "fptosi";
                self.unary(ty, move |a| {
                    let x = a.float()?.to_f64();
                    if !x.is_finite() {
                        return None;
                    }
                    let t = x.trunc();
                    let (lo, hi) = if signed { (-(2f64.powi(w as i32 - 1)), 2f64.powi(w as i32 - 1)) } else { (0.0, 2f64.powi(w as i32)) };
                    if t < lo || t >= hi {
                        return None;
                    }
                    Some(Scalar::Int(ApInt::new(w, t as i128)))
                })
            }
            "index_cast" | "index_castui" => {
                let ty = self.ty();
                let w = attr::int_width(attr::element_type(&ty)).map_or(64, |w| w.0);
                let signed = op == "index_cast";
                self.unary(ty, move |a| {
                    let i = a.int()?;
                    Some(Scalar::Int(if signed { i.sext(w.max(i.width)).trunc(w) } else { i.zext(w.max(i.width)).trunc(w) }))
                })
            }
            "bitcast" => self.bitcast(),
            "cmpi" => self.cmpi(),
            "cmpf" => {
                let (mut l, mut r) = (self.c[0].as_ref().and_then(|a| Const::try_from(a).ok()).filter(|c| !c.elements).and_then(|c| c.as_float()), self.c[1].as_ref().and_then(|a| Const::try_from(a).ok()).filter(|c| !c.elements).and_then(|c| c.as_float()));
                if l.is_some_and(ApFloat::is_nan) {
                    r = l;
                }
                if r.is_some_and(ApFloat::is_nan) {
                    l = r;
                }
                let (Some(l), Some(r), Some(p)) = (l, r, pred_of(self.prop("predicate"))) else { return Fold::Failed };
                Self::attr(Some(Attribute::Bool(cmpf(p, l, r))))
            }
            "select" => self.select(),
            "shli" | "shrui" | "shrsi" => {
                if self.zero(1) {
                    return Self::value(self.v(0));
                }
                let kind = op;
                self.int_binary(move |a, b| {
                    if b.ucmp(ApInt::new(b.width, b.width as i128)) != Ordering::Less {
                        return None;
                    }
                    let by = b.unsigned() as u32;
                    Some(match kind {
                        "shli" => a.shl(by),
                        "shrui" => a.lshr(by),
                        _ => a.ashr(by),
                    })
                })
            }
            "addui_extended" => self.addui_extended(),
            "mulsi_extended" | "mului_extended" => self.mul_extended(op == "mulsi_extended"),
            _ => Fold::Failed,
        }
    }

    fn addi(&mut self) -> Fold<'a> {
        if self.zero(1) {
            return Self::value(self.v(0));
        }
        if let Some(sub) = self.def(0, "arith.subi")
            && self.v(1) == self.b[sub].operands[1]
        {
            return Self::value(self.b[sub].operands[0]);
        }
        if let Some(sub) = self.def(1, "arith.subi")
            && self.v(0) == self.b[sub].operands[1]
        {
            return Self::value(self.b[sub].operands[0]);
        }
        self.int_binary(|a, b| Some(a.add(b)))
    }

    fn subi(&mut self) -> Fold<'a> {
        if self.v(0) == self.v(1) {
            let ty = self.ty();
            let dynamic = matches!(&ty, Type::Shaped(_)) && attr::element_count(&ty).is_none();
            if !dynamic {
                return Self::attr(Self::zero_attr(&ty));
            }
        }
        if self.zero(1) {
            return Self::value(self.v(0));
        }
        if let Some(add) = self.def(0, "arith.addi") {
            let (x, y) = (self.b[add].operands[0], self.b[add].operands[1]);
            if self.v(1) == y {
                return Self::value(x);
            }
            if self.v(1) == x {
                return Self::value(y);
            }
        }
        self.int_binary(|a, b| Some(a.sub(b)))
    }

    /// `foldDivMul`, then the constant fold; division by zero (or `MIN / -1`) does not fold.
    fn div(&mut self, signed: bool) -> Fold<'a> {
        if self.one(1) {
            return Self::value(self.v(0));
        }
        if let Some(mul) = self.def(0, "arith.muli") {
            let need = if signed { 1 } else { 2 };
            if overflow(self.b[mul].get("overflowFlags")) & need == need {
                let (x, y) = (self.b[mul].operands[0], self.b[mul].operands[1]);
                if x == self.v(1) {
                    return Self::value(y);
                }
                if y == self.v(1) {
                    return Self::value(x);
                }
            }
        }
        self.int_binary(|a, b| if signed { a.sdiv_ov(b).filter(|(_, ov)| !ov).map(|(q, _)| q) } else { a.udiv(b) })
    }

    fn ceildivsi(a: ApInt, b: ApInt) -> Option<ApInt> {
        if b.is_zero() {
            return None;
        }
        if a.is_zero() {
            return Some(a);
        }
        let w = a.width;
        let (zero, one) = (ApInt::zero(w), ApInt::new(w, 1));
        let pos = |x: ApInt| x.scmp(zero) == Ordering::Greater;
        // `signedCeilNonnegInputs`: (a - 1) / b + 1, overflow checked.
        let ceil = |a: ApInt, b: ApInt| -> (ApInt, bool) {
            let (s, o1) = a.ssub_ov(one);
            let (q, o2) = s.sdiv_ov(b).unwrap_or((s, true));
            let (r, o3) = q.sadd_ov(one);
            (r, o1 || o2 || o3)
        };
        let (res, ov) = match (pos(a), pos(b)) {
            (true, true) => ceil(a, b),
            (false, false) => {
                let (pa, o1) = zero.ssub_ov(a);
                let (pb, o2) = zero.ssub_ov(b);
                let (r, o3) = ceil(pa, pb);
                (r, o1 || o2 || o3)
            }
            (false, true) => {
                let (pa, o1) = zero.ssub_ov(a);
                let (d, o2) = pa.sdiv_ov(b)?;
                let (r, o3) = zero.ssub_ov(d);
                (r, o1 || o2 || o3)
            }
            (true, false) => {
                let (pb, o1) = zero.ssub_ov(b);
                let (d, o2) = a.sdiv_ov(pb)?;
                let (r, o3) = zero.ssub_ov(d);
                (r, o1 || o2 || o3)
            }
        };
        (!ov).then_some(res)
    }

    fn andi(&mut self) -> Fold<'a> {
        if self.zero(1) {
            return Self::value(self.v(1));
        }
        if self.int(1).is_some_and(ApInt::is_all_ones) {
            return Self::value(self.v(0));
        }
        // x & ~x = 0.
        for (x, other) in [(0, 1), (1, 0)] {
            if let Some(xor) = self.def(other, "arith.xori")
                && self.b[xor].operands[0] == self.v(x)
                && self.b.constant_of(self.b[xor].operands[1]).and_then(|a| Const::try_from(&a).ok()).and_then(|c| c.as_int()).is_some_and(ApInt::is_all_ones)
            {
                return Self::attr(Self::zero_attr(&self.ty()));
            }
        }
        // `foldAndIofAndI`.
        for (prev, other) in [(0, 1), (1, 0)] {
            if let Some(p) = self.def(prev, "arith.andi")
                && self.b[p].operands.contains(&self.v(other))
            {
                return Self::value(self.b[p].results[0]);
            }
        }
        self.int_binary(|a, b| Some(a.and(b)))
    }

    fn ori(&mut self) -> Fold<'a> {
        if let Some(r) = self.int(1) {
            if r.is_zero() {
                return Self::value(self.v(0));
            }
            if r.is_all_ones() {
                return Self::attr(self.c[1].clone());
            }
        }
        for (x, other) in [(0, 1), (1, 0)] {
            if let Some(xor) = self.def(other, "arith.xori")
                && self.b[xor].operands[0] == self.v(x)
                && self.b.constant_of(self.b[xor].operands[1]).and_then(|a| Const::try_from(&a).ok()).and_then(|c| c.as_int()).is_some_and(ApInt::is_all_ones)
            {
                return Self::value(self.b[xor].operands[1]);
            }
        }
        self.int_binary(|a, b| Some(a.or(b)))
    }

    fn xori(&mut self) -> Fold<'a> {
        if self.zero(1) {
            return Self::value(self.v(0));
        }
        if self.v(0) == self.v(1) {
            return Self::attr(Self::zero_attr(&self.ty()));
        }
        for (prev, other) in [(0, 1), (1, 0)] {
            if let Some(p) = self.def(prev, "arith.xori") {
                let (pl, pr) = (self.b[p].operands[0], self.b[p].operands[1]);
                if pr == self.v(other) {
                    return Self::value(pl);
                }
                if pl == self.v(other) {
                    return Self::value(pr);
                }
            }
        }
        self.int_binary(|a, b| Some(a.xor(b)))
    }

    fn int_minmax(&mut self, op: &str) -> Fold<'a> {
        if self.v(0) == self.v(1) {
            return Self::value(self.v(1));
        }
        let signed = op.ends_with("si");
        let max = op.starts_with("max");
        if let Some(r) = self.int(1) {
            let w = r.width;
            let (lo, hi) = if signed { (ApInt::signed_min(w), ApInt::signed_max(w)) } else { (ApInt::zero(w), ApInt::all_ones(w)) };
            // max(x, MAX) = MAX, max(x, MIN) = x; min the other way round.
            if r == (if max { hi } else { lo }) {
                return Self::value(self.v(1));
            }
            if r == (if max { lo } else { hi }) {
                return Self::value(self.v(0));
            }
        }
        self.int_binary(move |a, b| {
            let o = if signed { a.scmp(b) } else { a.ucmp(b) };
            Some(if o == (if max { Ordering::Greater } else { Ordering::Less }) { a } else { b })
        })
    }

    fn trunci(&mut self) -> Fold<'a> {
        let res_w = self.width_of(self.res());
        for ext in ["arith.extui", "arith.extsi"] {
            if let Some(e) = self.def(0, ext) {
                let src = self.b[e].operands[0];
                let src_w = self.width_of(src);
                if src_w > res_w {
                    self.b.set_operand(self.op, 0, src);
                    return Self::value(self.res());
                }
                if attr::element_type(&self.b[src].ty) == attr::element_type(&self.ty()) {
                    return Self::value(src);
                }
            }
        }
        if let Some(t) = self.def(0, "arith.trunci") {
            let src = self.b[t].operands[0];
            self.b.set_operand(self.op, 0, src);
            return Self::value(self.res());
        }
        let ty = self.ty();
        let Some(w) = res_w else { return Fold::Failed };
        self.unary(ty, move |a| Some(Scalar::Int(a.int()?.trunc(w))))
    }

    fn float_kind(&self, v: ValueId) -> Option<FloatKind> {
        match attr::element_type(&self.b[v].ty) {
            Type::Float(k) => Some(*k),
            _ => None,
        }
    }

    fn extf(&mut self) -> Fold<'a> {
        if let Some(t) = self.def(0, "arith.truncf") {
            let src = self.b[t].operands[0];
            if self.b[src].ty == self.ty() && fastmath_has(self.b[t].get("fastmath"), &["contract"]) && fastmath_has(self.prop("fastmath"), &["contract"]) {
                return Self::value(src);
            }
        }
        self.float_convert()
    }

    /// `convertFloatValue`: only conversions that lose nothing fold.
    fn float_convert(&self) -> Fold<'a> {
        let ty = self.ty();
        let Some(k) = self.float_kind(self.res()) else { return Fold::Failed };
        self.unary(ty, move |a| {
            let f = a.float()?;
            let to = f.convert(k)?;
            let back = to.convert(f.kind)?;
            let exact = if f.is_nan() { to.is_nan() } else { back.bits == f.bits && to.is_inf() == f.is_inf() };
            exact.then_some(Scalar::Float(to))
        })
    }

    fn truncf(&mut self) -> Fold<'a> {
        if let Some(e) = self.def(0, "arith.extf") {
            let src = self.b[e].operands[0];
            let (s, mid, res) = (self.float_kind(src), self.float_kind(self.b[e].results[0]), self.float_kind(self.res()));
            if let (Some(s), Some(mid), Some(res)) = (s, mid, res)
                && representable_by(s, mid)
            {
                let (sw, rw) = (attr::bit_width(&Type::Float(s)), attr::bit_width(&Type::Float(res)));
                if sw > rw {
                    self.b.set_operand(self.op, 0, src);
                    return Self::value(self.res());
                }
                if s == res {
                    return Self::value(src);
                }
            }
        }
        self.float_convert()
    }

    fn bitcast(&self) -> Fold<'a> {
        let ty = self.ty();
        let Some(a) = self.c[0].as_ref() else { return Fold::Failed };
        if crate::is_poison(a) && !matches!(ty, Type::Shaped(_)) {
            return Self::attr(Some(a.clone()));
        }
        let Ok(c) = Const::try_from(a) else { return Fold::Failed };
        if !c.elements && matches!(ty, Type::Shaped(_)) {
            return Fold::Failed;
        }
        let elem = attr::element_type(&ty).clone();
        let target = if c.elements { ty.clone() } else { elem.clone() };
        c.map(target, |s| {
            let bits = match s {
                Scalar::Int(i) => i.bits(),
                Scalar::Float(f) => f.bits as u128,
            };
            Some(match &elem {
                Type::Float(k) => Scalar::Float(ApFloat::from_bits(*k, bits as u64)?),
                t => Scalar::Int(ApInt::from_bits(attr::int_width(t)?.0, bits)),
            })
        })
        .map(|c| Folded::Attr(c.into()))
        .into()
    }

    fn cmpi(&mut self) -> Fold<'a> {
        let Some(pred) = pred_of(self.prop("predicate")) else { return Fold::Failed };
        let ty = self.ty();
        if self.v(0) == self.v(1) {
            return Self::attr(Some(Self::bool_attr(&ty, matches!(pred, EQ | SLE | SGE | ULE | UGE))));
        }
        if self.zero(1) {
            for ext in ["arith.extsi", "arith.extui"] {
                // `getIntegerWidth`: an integer, or a vector of them.
                let src = self.def(0, ext).map(|e| self.b[e].operands[0]);
                let width1 = src.is_some_and(|v| match &self.b[v].ty {
                    Type::Integer { width: 1, .. } => true,
                    Type::Shaped(s) if s.kind == mlirformat::ShapedKind::Vector => matches!(*s.elem, Type::Integer { width: 1, .. }),
                    _ => false,
                });
                if let Some(e) = self.def(0, ext)
                    && width1
                    && pred == NE
                {
                    return Self::value(self.b[e].operands[0]);
                }
            }
            if self.width_of(self.v(0)) == Some(1) && matches!(attr::element_type(&self.b[self.v(0)].ty), Type::Integer { .. }) && pred == NE {
                return Self::value(self.v(0));
            }
        }
        if self.one(1) && self.width_of(self.v(0)) == Some(1) && matches!(attr::element_type(&self.b[self.v(0)].ty), Type::Integer { .. }) && pred == EQ {
            return Self::value(self.v(0));
        }
        if self.c[0].is_some() && self.c[1].is_none() {
            let swapped = match pred {
                SLT => SGT,
                SGT => SLT,
                SLE => SGE,
                SGE => SLE,
                ULT => UGT,
                UGT => ULT,
                ULE => UGE,
                UGE => ULE,
                p => p,
            };
            let (l, r) = (self.v(0), self.v(1));
            self.b[self.op].set("predicate", Attribute::i64(swapped));
            self.b.set_operands(self.op, vec![r, l]);
            return Self::value(self.res());
        }
        let Some(lhs) = self.cst(0) else { return Fold::Failed };
        let i1 = attr::with_element(&lhs.ty, Type::I1);
        self.binary(Some(i1), |a, b| Some(Scalar::Int(ApInt::new(1, i128::from(cmpi(pred, a.int()?, b.int()?)))))).map(Folded::Attr).into()
    }

    fn select(&mut self) -> Fold<'a> {
        let (cond, t, f) = (self.v(0), self.v(1), self.v(2));
        if t == f {
            return Self::value(t);
        }
        if self.one(0) {
            return Self::value(t);
        }
        if self.zero(0) {
            return Self::value(f);
        }
        if self.poison(1) {
            return Self::value(f);
        }
        if self.poison(2) {
            return Self::value(t);
        }
        if matches!(self.ty(), Type::Integer { width: 1, signedness: mlirformat::Signedness::Signless }) && self.one(1) && self.zero(2) {
            return Self::value(cond);
        }
        if let Some(cmp) = self.b.def_named(cond, "arith.cmpi")
            && let Some(p @ (EQ | NE)) = pred_of(self.b[cmp].get("predicate"))
        {
            let (cl, cr) = (self.b[cmp].operands[0], self.b[cmp].operands[1]);
            if (cl == t && cr == f) || (cr == t && cl == f) {
                return Self::value(if p == NE { t } else { f });
            }
        }
        let (Some(c), Some(l), Some(r)) = (self.cst(0), self.cst(1), self.cst(2)) else { return Fold::Failed };
        if !(c.elements && l.elements && r.elements) {
            return Fold::Failed;
        }
        let n = attr::element_count(&l.ty).unwrap_or(1);
        let values = (0..n).map(|i| if c.at(i).int().is_some_and(|b| !b.is_zero()) { l.at(i) } else { r.at(i) }).collect();
        Self::attr(Some(Const { ty: l.ty.clone(), values, elements: true }.into()))
    }

    fn addui_extended(&mut self) -> Fold<'a> {
        let overflow_ty = self.b[self.b[self.op].results[1]].ty.clone();
        if self.zero(1) {
            let Some(z) = Self::zero_attr(&overflow_ty) else { return Fold::Failed };
            return Fold::Results(vec![Folded::Value(self.v(0)), Folded::Attr(z)]);
        }
        let Some(sum) = self.binary(None, |a, b| Some(Scalar::Int(a.int()?.add(b.int()?)))) else { return Fold::Failed };
        let (Ok(s), Some(l)) = (Const::try_from(&sum), self.cst(0)) else { return Fold::Failed };
        let i1 = attr::with_element(&s.ty, Type::I1);
        let n = s.values.len().max(l.values.len());
        let values = (0..n).map(|i| Scalar::Int(ApInt::new(1, i128::from(s.at(i).int().zip(l.at(i).int()).is_some_and(|(x, y)| x.ucmp(y) == Ordering::Less))))).collect();
        Fold::Results(vec![Folded::Attr(sum), Folded::Attr(Const { ty: i1, values, elements: s.elements }.into())])
    }

    fn mul_extended(&mut self, signed: bool) -> Fold<'a> {
        if self.zero(1) {
            let z = self.c[1].clone().expect("constant");
            return Fold::Results(vec![Folded::Attr(z.clone()), Folded::Attr(z)]);
        }
        if !signed && self.one(1) {
            let Some(z) = Self::zero_attr(&self.b[self.v(0)].ty.clone()) else { return Fold::Failed };
            return Fold::Results(vec![Folded::Value(self.v(0)), Folded::Attr(z)]);
        }
        let Some(low) = self.binary(None, |a, b| Some(Scalar::Int(a.int()?.mul(b.int()?)))) else { return Fold::Failed };
        let high = self.binary(None, |a, b| {
            let (a, b) = (a.int()?, b.int()?);
            let w = a.width;
            if w > 64 {
                return None;
            }
            let full = if signed { (a.signed() * b.signed()) >> w } else { ((a.unsigned() * b.unsigned()) >> w) as i128 };
            Some(Scalar::Int(ApInt::new(w, full)))
        });
        let Some(high) = high else { return Fold::Failed };
        Fold::Results(vec![Folded::Attr(low), Folded::Attr(high)])
    }
}

/// `APFloatBase::isRepresentableBy(a, b)`: every value of `a` is one of `b`.
fn representable_by(a: FloatKind, b: FloatKind) -> bool {
    use FloatKind::*;
    let rank = |k: FloatKind| match k {
        F16 => Some((5, 11)),
        BF16 => Some((8, 8)),
        TF32 => Some((8, 11)),
        F32 => Some((8, 24)),
        F64 => Some((11, 53)),
        F80 => Some((15, 64)),
        F128 => Some((15, 113)),
        _ => None,
    };
    match (rank(a), rank(b)) {
        (Some((ea, pa)), Some((eb, pb))) => ea <= eb && pa <= pb,
        _ => a == b,
    }
}

impl<'a> Rewriter<'_, 'a> {
    /// An `arith.constant` of `value` at the insertion point.
    fn constant(&mut self, value: Attribute<'a>, ty: Type<'a>) -> ValueId {
        let c = self.emit(&arith::Constant::new(value, ty));
        self.body[c].results[0]
    }

    /// A new op replacing `op` (built before it, with `op`'s result types).
    fn replace_new(&mut self, op: OpId, data: OpData<'a>) -> bool {
        let types = self.body.types(&self.body[op].results.clone());
        self.replace_with(op, data, &types);
        true
    }

    /// A new op before `op`, its result of type `ty`.
    fn make(&mut self, op: OpId, data: OpData<'a>, ty: Type<'a>) -> ValueId {
        self.set_before(op);
        let n = self.create(data, &[ty]);
        self.body[n].results[0]
    }
}

impl<'a> Body<'a> {
    /// `ConstantLikeMatcher APIntAttr`: a scalar integer constant (not a splat).
    fn int_attr(&self, v: ValueId) -> Option<(ApInt, Type<'a>)> {
        let c = Const::try_from(&self.constant_of(v)?).ok()?;
        (!c.elements).then(|| Some((c.as_int()?, c.ty)))?
    }

    /// `getIntOrSplatIntValue`.
    fn int_or_splat(&self, v: ValueId) -> Option<ApInt> {
        Const::try_from(&self.constant_of(v)?).ok()?.as_int()
    }

    fn operands2(&self, op: OpId) -> (ValueId, ValueId) {
        (self[op].operands[0], self[op].operands[1])
    }

    /// The width of a scalar or element int / float type, `-1` otherwise.
    fn elem_width(&self, v: ValueId) -> i64 {
        attr::bit_width(&self[v].ty).map_or(-1, i64::from)
    }
}

/// The constant-combining DRR patterns: `root(inner(x, c0), c1)` into
/// `new_root(x, constant(c0 ⊕ c1))` (or with the constant first).
macro_rules! combine {
    ($($name:ident: $root:literal($inner:literal $(, $inner_const_first:tt)?) => $new:literal($($order:tt)*) [$fold:ident] $flags:ident;)*) => {
        rewrites! {$(
            $name($root, 2) |rw, op| {
                let b = &*rw.body;
                let (lhs, rhs) = b.operands2(op);
                // `$root(inner, c1)`, or `$root(c1, inner)` for the `LHS` forms.
                let (inner_v, c1_v) = combine!(@root_order b, lhs, rhs, $root, $($order)*);
                let Some(inner) = b.def_named(inner_v, $inner) else { return false };
                let (il, ir) = b.operands2(inner);
                let (x, c0_v) = combine!(@inner_order il, ir $(, $inner_const_first)?);
                let (Some((c0, _)), Some((c1, _))) = (b.int_attr(c0_v), b.int_attr(c1_v)) else { return false };
                let res_ty = b[b[op].results[0]].ty.clone();
                let value: ApInt = combine!(@fold $fold, c0, c1);
                let flags = combine!(@flags $flags, b, op, inner);
                rw.set_before(op);
                let c = rw.constant(Const::int(value, res_ty.clone()).into(), res_ty);
                let operands = combine!(@new_operands x, c, $($order)*);
                rw.replace_new(op, OpData::build($new).operands(&operands).with("overflowFlags", flags))
            }
        )*}
    };
    (@root_order $b:ident, $lhs:ident, $rhs:ident, $root:literal, x c) => { ($lhs, $rhs) };
    (@root_order $b:ident, $lhs:ident, $rhs:ident, $root:literal, c x) => { ($lhs, $rhs) };
    (@root_order $b:ident, $lhs:ident, $rhs:ident, $root:literal, lc x c) => { ($rhs, $lhs) };
    (@root_order $b:ident, $lhs:ident, $rhs:ident, $root:literal, lc c x) => { ($rhs, $lhs) };
    (@inner_order $l:ident, $r:ident) => { ($l, $r) };
    (@inner_order $l:ident, $r:ident, first) => { ($r, $l) };
    (@fold add, $a:ident, $b:ident) => { $a.add($b) };
    (@fold sub01, $a:ident, $b:ident) => { $a.sub($b) };
    (@fold sub10, $a:ident, $b:ident) => { $b.sub($a) };
    (@fold mul, $a:ident, $b:ident) => { $a.mul($b) };
    (@flags merge, $b:ident, $op:ident, $inner:ident) => { overflow_attr(overflow($b[$inner].get("overflowFlags")) & overflow($b[$op].get("overflowFlags"))) };
    (@flags none, $b:ident, $op:ident, $inner:ident) => { overflow_attr(0) };
    (@new_operands $x:ident, $c:ident, x c) => { [$x, $c] };
    (@new_operands $x:ident, $c:ident, c x) => { [$c, $x] };
    (@new_operands $x:ident, $c:ident, lc x c) => { [$x, $c] };
    (@new_operands $x:ident, $c:ident, lc c x) => { [$c, $x] };
}

combine! {
    AddIAddConstant: "arith.addi"("arith.addi") => "arith.addi"(x c) [add] merge;
    AddISubConstantRHS: "arith.addi"("arith.subi") => "arith.addi"(x c) [sub10] merge;
    AddISubConstantLHS: "arith.addi"("arith.subi", first) => "arith.subi"(c x) [add] merge;
    MulIMulIConstant: "arith.muli"("arith.muli") => "arith.muli"(x c) [mul] merge;
    SubIRHSAddConstant: "arith.subi"("arith.addi") => "arith.addi"(x c) [sub01] none;
    SubILHSAddConstant: "arith.subi"("arith.addi") => "arith.subi"(lc c x) [sub10] merge;
    SubIRHSSubConstantRHS: "arith.subi"("arith.subi") => "arith.subi"(x c) [add] merge;
    SubIRHSSubConstantLHS: "arith.subi"("arith.subi", first) => "arith.subi"(c x) [sub01] merge;
    SubILHSSubConstantRHS: "arith.subi"("arith.subi") => "arith.subi"(lc c x) [add] merge;
    SubILHSSubConstantLHS: "arith.subi"("arith.subi", first) => "arith.addi"(lc x c) [sub10] merge;
}

/// `ExtOp(x) op ExtOp(y)` into `ExtOp(x op y)` when `x` and `y` have the same type.
macro_rules! hoist_ext {
    ($($name:ident: $root:literal, $ext:literal;)*) => {
        rewrites! {$(
            $name($root, 3) |rw, op| {
                let b = &*rw.body;
                let (l, r) = b.operands2(op);
                let (Some(el), Some(er)) = (b.def_named(l, $ext), b.def_named(r, $ext)) else { return false };
                let (x, y) = (b[el].operands[0], b[er].operands[0]);
                if b[x].ty != b[y].ty {
                    return false;
                }
                let ty = b[x].ty.clone();
                let inner = rw.make(op, OpData::build($root).operands(&[x, y]), ty);
                rw.replace_new(op, OpData::build($ext).operands(&[inner]))
            }
        )*}
    };
}

hoist_ext! {
    XOrIOfExtUI: "arith.xori", "arith.extui";
    XOrIOfExtSI: "arith.xori", "arith.extsi";
    AndOfExtUI: "arith.andi", "arith.extui";
    AndOfExtSI: "arith.andi", "arith.extsi";
    OrOfExtUI: "arith.ori", "arith.extui";
    OrOfExtSI: "arith.ori", "arith.extsi";
}

/// `outer(inner(x))` into `new(x)`, or into `x` itself (`same`: when the types agree).
macro_rules! collapse {
    ($($name:ident: $outer:literal($inner:literal) => $new:tt;)*) => {
        rewrites! {$(
            $name($outer, 2) |rw, op| {
                let b = &*rw.body;
                let Some(inner) = b.def_named(b[op].operands[0], $inner) else { return false };
                let x = b[inner].operands[0];
                collapse!(@to rw, op, x, $new)
            }
        )*}
    };
    (@to $rw:ident, $op:ident, $x:ident, same) => {{
        if $rw.body[$rw.body[$op].results[0]].ty != $rw.body[$x].ty {
            return false;
        }
        $rw.replace_op($op, &[$x]);
        true
    }};
    (@to $rw:ident, $op:ident, $x:ident, $new:literal) => {
        $rw.replace_new($op, OpData::build($new).operands(&[$x]))
    };
}

collapse! {
    IndexCastOfIndexCast: "arith.index_cast"("arith.index_cast") => same;
    IndexCastOfExtSI: "arith.index_cast"("arith.extsi") => "arith.index_cast";
    IndexCastUIOfIndexCastUI: "arith.index_castui"("arith.index_castui") => same;
    IndexCastUIOfExtUI: "arith.index_castui"("arith.extui") => "arith.index_castui";
    BitcastOfBitcast: "arith.bitcast"("arith.bitcast") => "arith.bitcast";
    ExtSIOfExtUI: "arith.extsi"("arith.extui") => "arith.extui";
}

rewrites! {
    AddIMulNegativeOneRhs("arith.addi", 2) |rw, op| {
        let b = &*rw.body;
        let (x, m) = b.operands2(op);
        let Some(mul) = b.def_named(m, "arith.muli") else { return false };
        let (y, c) = b.operands2(mul);
        if !b.int_or_splat(c).is_some_and(ApInt::is_all_ones) {
            return false;
        }
        rw.replace_new(op, OpData::build("arith.subi").operands(&[x, y]))
    }

    AddIMulNegativeOneLhs("arith.addi", 2) |rw, op| {
        let b = &*rw.body;
        let (m, y) = b.operands2(op);
        let Some(mul) = b.def_named(m, "arith.muli") else { return false };
        let (x, c) = b.operands2(mul);
        if !b.int_or_splat(c).is_some_and(ApInt::is_all_ones) {
            return false;
        }
        rw.replace_new(op, OpData::build("arith.subi").operands(&[y, x]))
    }

    SubISubILHSRHSLHS("arith.subi", 2) |rw, op| {
        let b = &*rw.body;
        let (s, x2) = b.operands2(op);
        let Some(sub) = b.def_named(s, "arith.subi") else { return false };
        let (x, y) = b.operands2(sub);
        if x != x2 {
            return false;
        }
        let ty = b[y].ty.clone();
        let Some(zero) = Folder::zero_attr(&ty) else { return false };
        let flags = overflow_attr(overflow(b[sub].get("overflowFlags")) & overflow(b[op].get("overflowFlags")));
        rw.set_before(op);
        let c = rw.constant(zero, ty);
        rw.replace_new(op, OpData::build("arith.subi").operands(&[c, y]).with("overflowFlags", flags))
    }

    AddUIExtendedToAddI("arith.addui_extended", 1) |rw, op| {
        extended_to_plain(rw, op, "arith.addi")
    }

    MulSIExtendedToMulI("arith.mulsi_extended", 1) |rw, op| {
        extended_to_plain(rw, op, "arith.muli")
    }

    MulUIExtendedToMulI("arith.mului_extended", 1) |rw, op| {
        extended_to_plain(rw, op, "arith.muli")
    }

    MulSIExtendedRHSOne("arith.mulsi_extended", 1) |rw, op| {
        let b = &*rw.body;
        let (x, c) = b.operands2(op);
        if !b.int_or_splat(c).is_some_and(|v| v.is_one() && !v.is_negative() && v.width > 1) {
            return false;
        }
        let ty = b[x].ty.clone();
        let Some(zero) = Folder::zero_attr(&ty) else { return false };
        let i1 = attr::with_element(&ty, Type::I1);
        rw.set_before(op);
        let z = rw.constant(zero, ty.clone());
        let cmp = rw.make(op, OpData::build("arith.cmpi").operands(&[x, z]).with("predicate", Attribute::i64(SLT)), i1);
        let ext = rw.make(op, OpData::build("arith.extsi").operands(&[cmp]), ty);
        rw.replace_op(op, &[x, ext]);
        true
    }

    XOrINotCmpI("arith.xori", 2) |rw, op| {
        let b = &*rw.body;
        let (l, r) = b.operands2(op);
        let Some(cmp) = b.def_named(l, "arith.cmpi") else { return false };
        if !b.int_attr(r).is_some_and(|(v, t)| v.is_one() && matches!(t, Type::Integer { width: 1, .. })) {
            return false;
        }
        let Some(p) = pred_of(b[cmp].get("predicate")) else { return false };
        let inverted = match p {
            EQ => NE,
            NE => EQ,
            SLT => SGE,
            SLE => SGT,
            SGT => SLE,
            SGE => SLT,
            ULT => UGE,
            ULE => UGT,
            UGT => ULE,
            _ => ULT,
        };
        let (a, c) = b.operands2(cmp);
        rw.replace_new(op, OpData::build("arith.cmpi").operands(&[a, c]).with("predicate", Attribute::i64(inverted)))
    }

    CmpIExtSI("arith.cmpi", 3) |rw, op| {
        cmpi_of_ext(rw, op, "arith.extsi")
    }

    CmpIExtUI("arith.cmpi", 3) |rw, op| {
        cmpi_of_ext(rw, op, "arith.extui")
    }

    SelectNotCond("arith.select", 2) |rw, op| {
        let b = &*rw.body;
        let (c, t, f) = (b[op].operands[0], b[op].operands[1], b[op].operands[2]);
        let Some(xor) = b.def_named(c, "arith.xori") else { return false };
        let (p, ones) = b.operands2(xor);
        if !b.int_attr(ones).is_some_and(|(v, _)| v.is_all_ones()) {
            return false;
        }
        rw.replace_new(op, OpData::build("arith.select").operands(&[p, f, t]))
    }

    RedundantSelectFalse("arith.select", 2) |rw, op| {
        let b = &*rw.body;
        let (p, a, s) = (b[op].operands[0], b[op].operands[1], b[op].operands[2]);
        let Some(inner) = b.def_named(s, "arith.select") else { return false };
        if b[inner].operands[0] != p {
            return false;
        }
        let c = b[inner].operands[2];
        rw.replace_new(op, OpData::build("arith.select").operands(&[p, a, c]))
    }

    RedundantSelectTrue("arith.select", 2) |rw, op| {
        let b = &*rw.body;
        let (p, s, c) = (b[op].operands[0], b[op].operands[1], b[op].operands[2]);
        let Some(inner) = b.def_named(s, "arith.select") else { return false };
        if b[inner].operands[0] != p {
            return false;
        }
        let a = b[inner].operands[1];
        rw.replace_new(op, OpData::build("arith.select").operands(&[p, a, c]))
    }

    SelectI1ToNot("arith.select", 1) |rw, op| {
        let b = &*rw.body;
        let (p, t, f) = (b[op].operands[0], b[op].operands[1], b[op].operands[2]);
        let i1 = |v: ValueId, want: bool| b.int_attr(v).is_some_and(|(x, ty)| matches!(ty, Type::Integer { width: 1, .. }) && x.is_one() == want);
        if !i1(t, false) || !i1(f, true) {
            return false;
        }
        rw.set_before(op);
        let one = rw.constant(Attribute::Bool(true), Type::I1);
        rw.replace_new(op, OpData::build("arith.xori").operands(&[p, one]))
    }

    SelectToExtUI("arith.select", 1) |rw, op| {
        let b = &*rw.body;
        let ty = b[b[op].results[0]].ty.clone();
        if !matches!(ty, Type::Integer { width, .. } if width != 1) {
            return false;
        }
        let (c, t, f) = (b[op].operands[0], b[op].operands[1], b[op].operands[2]);
        let is = |v: ValueId, one: bool| b.int_or_splat(v).is_some_and(|x| if one { x.is_one() } else { x.is_zero() });
        if is(t, true) && is(f, false) {
            return rw.replace_new(op, OpData::build("arith.extui").operands(&[c]));
        }
        if is(t, false) && is(f, true) {
            let cty = b[c].ty.clone();
            rw.set_before(op);
            let one = rw.constant(Const::int(ApInt::new(1, 1), cty.clone()).into(), cty.clone());
            let x = rw.make(op, OpData::build("arith.xori").operands(&[c, one]), cty);
            return rw.replace_new(op, OpData::build("arith.extui").operands(&[x]));
        }
        false
    }

    TruncIExtSIToExtSI("arith.trunci", 2) |rw, op| {
        trunc_of_ext(rw, op, "arith.extsi")
    }

    TruncIExtUIToExtUI("arith.trunci", 2) |rw, op| {
        trunc_of_ext(rw, op, "arith.extui")
    }

    TruncIShrSIToTrunciShrUI("arith.trunci", 2) |rw, op| {
        let b = &*rw.body;
        let Some(shr) = b.def_named(b[op].operands[0], "arith.shrsi") else { return false };
        let (x, c) = b.operands2(shr);
        let Some(attr) = b.constant_of(c) else { return false };
        let Some(amount) = b.int_or_splat(c) else { return false };
        if b.elem_width(x) - b.elem_width(b[op].results[0]) != amount.signed() as i64 {
            return false;
        }
        let exact = b[shr].get("isExact").is_some();
        let flags = b[op].get("overflowFlags").cloned();
        let (xty, cty) = (b[x].ty.clone(), b[c].ty.clone());
        rw.set_before(op);
        let c2 = rw.constant(attr, cty);
        let mut shr_data = OpData::build("arith.shrui").operands(&[x, c2]);
        if exact {
            shr_data = shr_data.flag("isExact");
        }
        let s = rw.make(op, shr_data, xty);
        let mut t = OpData::build("arith.trunci").operands(&[s]);
        if let Some(f) = flags {
            t = t.with("overflowFlags", f);
        }
        rw.replace_new(op, t)
    }

    TruncFSIToFPToSIToFP("arith.truncf", 2) |rw, op| {
        truncf_of_itofp(rw, op, "arith.sitofp")
    }

    TruncFUIToFPToUIToFP("arith.truncf", 2) |rw, op| {
        truncf_of_itofp(rw, op, "arith.uitofp")
    }

    MulFOfNegF("arith.mulf", 3) |rw, op| {
        negf_pair(rw, op, "arith.mulf")
    }

    DivFOfNegF("arith.divf", 3) |rw, op| {
        negf_pair(rw, op, "arith.divf")
    }

    CmpFIntToFPConst("arith.cmpf", 1) |rw, op| {
        cmpf_int_to_fp_const(rw, op)
    }
}

/// `addui_extended` / `mul*_extended` whose high half is unused: the plain op.
fn extended_to_plain(rw: &mut Rewriter<'_, '_>, op: OpId, plain: &str) -> bool {
    let b = &*rw.body;
    if !b[b[op].results[1]].uses.is_empty() {
        return false;
    }
    let (x, y) = b.operands2(op);
    let ty = b[b[op].results[0]].ty.clone();
    let n = rw.make(op, OpData::build(plain).operands(&[x, y]), ty);
    rw.replace_op(op, &[n, x]);
    true
}

fn cmpi_of_ext(rw: &mut Rewriter<'_, '_>, op: OpId, ext: &str) -> bool {
    let b = &*rw.body;
    let (l, r) = b.operands2(op);
    let (Some(el), Some(er)) = (b.def_named(l, ext), b.def_named(r, ext)) else { return false };
    let (a, c) = (b[el].operands[0], b[er].operands[0]);
    let pred = b[op].get("predicate").cloned();
    if b[a].ty != b[c].ty || !matches!(pred_of(pred.as_ref()), Some(EQ | NE)) {
        return false;
    }
    rw.replace_new(op, OpData::build("arith.cmpi").operands(&[a, c]).with("predicate", pred.expect("predicate")))
}

fn trunc_of_ext(rw: &mut Rewriter<'_, '_>, op: OpId, ext: &str) -> bool {
    let b = &*rw.body;
    let Some(e) = b.def_named(b[op].operands[0], ext) else { return false };
    let x = b[e].operands[0];
    let (we, wt, wx) = (b.elem_width(b[e].results[0]), b.elem_width(b[op].results[0]), b.elem_width(x));
    if !(we > wt && wt > 0 && wt > wx && wx > 0) {
        return false;
    }
    rw.replace_new(op, OpData::build(ext).operands(&[x]))
}

fn truncf_of_itofp(rw: &mut Rewriter<'_, '_>, op: OpId, itofp: &str) -> bool {
    let b = &*rw.body;
    let Some(fp) = b.def_named(b[op].operands[0], itofp) else { return false };
    if b[op].get("roundingmode").is_some() {
        return false;
    }
    let x = b[fp].operands[0];
    rw.replace_new(op, OpData::build(itofp).operands(&[x]))
}

fn negf_pair(rw: &mut Rewriter<'_, '_>, op: OpId, name: &str) -> bool {
    let b = &*rw.body;
    let (l, r) = b.operands2(op);
    let (Some(nl), Some(nr)) = (b.def_named(l, "arith.negf"), b.def_named(r, "arith.negf")) else { return false };
    let (x, y) = (b[nl].operands[0], b[nr].operands[0]);
    if b[x].ty != b[y].ty {
        return false;
    }
    let fmf = b[op].get("fastmath").cloned();
    let mut d = OpData::build(name).operands(&[x, y]);
    if let Some(f) = fmf {
        d = d.with("fastmath", f);
    }
    rw.replace_new(op, d)
}

/// `CmpFIntToFPConst`: `cmpf(itofp(x), c)` as an integer comparison, or a constant.
fn cmpf_int_to_fp_const(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
    let b = &*rw.body;
    let (l, r) = b.operands2(op);
    let Some(rc) = b.constant_of(r).and_then(|a| Const::try_from(&a).ok()).filter(|c| !c.elements) else { return false };
    let Some(rhs) = rc.as_float() else { return false };
    if rhs.is_nan() {
        return false;
    }
    let Type::Float(fk) = b[r].ty else { return false };
    let mantissa: i32 = match fk {
        FloatKind::F16 => 11,
        FloatKind::BF16 => 8,
        FloatKind::TF32 => 11,
        FloatKind::F32 => 24,
        FloatKind::F64 => 53,
        _ => return false,
    };
    let (unsigned, x) = if let Some(si) = b.def_named(l, "arith.sitofp") {
        (false, b[si].operands[0])
    } else if let Some(ui) = b.def_named(l, "arith.uitofp") {
        (true, b[ui].operands[0])
    } else {
        return false;
    };
    let Type::Integer { width, .. } = b[x].ty else { return false };
    if width > 64 {
        return false;
    }
    let value_bits = if unsigned { width } else { width - 1 } as i32;
    if width as i32 > mantissa {
        let v = rhs.to_f64();
        if v.is_infinite() {
            let max_exp = match fk {
                FloatKind::F16 => 15,
                FloatKind::BF16 | FloatKind::TF32 | FloatKind::F32 => 127,
                _ => 1023,
            };
            if max_exp < value_bits {
                return false;
            }
        } else if v != 0.0 {
            let exp = v.abs().log2().floor() as i32;
            if mantissa <= exp && exp <= value_bits {
                return false;
            }
        }
    }
    let Some(fpred) = pred_of(b[op].get("predicate")) else { return false };
    let constant = |rw: &mut Rewriter<'_, '_>, v: bool| {
        let t = rw.replace_by(op, &arith::Constant::new(Attribute::Bool(v), Type::I1));
        let _ = t;
        true
    };
    let mut pred = match fpred {
        7 => return constant(rw, true),
        14 => return constant(rw, false),
        1 | 8 => EQ,
        2 | 9 => if unsigned { UGT } else { SGT },
        3 | 10 => if unsigned { UGE } else { SGE },
        4 | 11 => if unsigned { ULT } else { SLT },
        5 | 12 => if unsigned { ULE } else { SLE },
        6 | 13 => NE,
        _ => return false,
    };
    let to_f = |i: ApInt, signed: bool| -> f64 {
        let x = if signed { i.signed() as f64 } else { i.unsigned() as f64 };
        ApFloat::from_f64(fk, x).map_or(x, ApFloat::to_f64)
    };
    let rv = rhs.to_f64();
    let w = width;
    if !unsigned {
        if to_f(ApInt::signed_max(w), true) < rv {
            return constant(rw, matches!(pred, NE | SLT | SLE));
        }
        if to_f(ApInt::signed_min(w), true) > rv {
            return constant(rw, matches!(pred, NE | SGT | SGE));
        }
    } else {
        if to_f(ApInt::all_ones(w), false) < rv {
            return constant(rw, matches!(pred, NE | ULT | ULE));
        }
        if 0.0 > rv {
            return constant(rw, matches!(pred, NE | UGT | UGE));
        }
    }
    let t = rv.trunc();
    let fits = if unsigned { t >= 0.0 && t < 2f64.powi(w as i32) } else { t >= -(2f64.powi(w as i32 - 1)) && t < 2f64.powi(w as i32 - 1) };
    if !fits {
        return false;
    }
    let rhs_int = ApInt::new(w, t as i128);
    if rv != 0.0 && to_f(rhs_int, !unsigned) != rv {
        let neg = rhs.is_negative();
        match pred {
            NE => return constant(rw, true),
            EQ => return constant(rw, false),
            ULE if neg => return constant(rw, false),
            SLE if neg => pred = SLT,
            ULT if neg => return constant(rw, false),
            ULT => pred = ULE,
            SLT if !neg => pred = SLE,
            UGT if neg => return constant(rw, true),
            SGT if neg => pred = SGE,
            UGE if neg => return constant(rw, true),
            UGE => pred = UGT,
            SGE if !neg => pred = SGT,
            _ => {}
        }
    }
    let ity = b[x].ty.clone();
    rw.set_before(op);
    let c = rw.constant(Const::int(rhs_int, ity.clone()).into(), ity);
    rw.replace_new(op, OpData::build("arith.cmpi").operands(&[x, c]).with("predicate", Attribute::i64(pred)))
}

/// The patterns, op by op, in `getCanonicalizationPatterns` order.
pub fn patterns(set: &mut PatternSet) {
    set.add(AddIAddConstant).add(AddISubConstantRHS).add(AddISubConstantLHS).add(AddIMulNegativeOneRhs).add(AddIMulNegativeOneLhs);
    set.add(AddUIExtendedToAddI);
    set.add(SubIRHSAddConstant).add(SubILHSAddConstant).add(SubIRHSSubConstantRHS).add(SubIRHSSubConstantLHS).add(SubILHSSubConstantRHS).add(SubILHSSubConstantLHS).add(SubISubILHSRHSLHS);
    set.add(MulIMulIConstant);
    set.add(MulSIExtendedToMulI).add(MulSIExtendedRHSOne);
    set.add(MulUIExtendedToMulI);
    set.add(XOrINotCmpI).add(XOrIOfExtUI).add(XOrIOfExtSI);
    set.add(MulFOfNegF);
    set.add(DivFOfNegF);
    set.add(ExtSIOfExtUI);
    set.add(TruncIExtSIToExtSI).add(TruncIExtUIToExtUI).add(TruncIShrSIToTrunciShrUI);
    set.add(TruncFSIToFPToSIToFP).add(TruncFUIToFPToUIToFP);
    set.add(AndOfExtUI).add(AndOfExtSI);
    set.add(OrOfExtUI).add(OrOfExtSI);
    set.add(IndexCastOfIndexCast).add(IndexCastOfExtSI);
    set.add(IndexCastUIOfIndexCastUI).add(IndexCastUIOfExtUI);
    set.add(BitcastOfBitcast);
    set.add(CmpIExtSI).add(CmpIExtUI);
    set.add(CmpFIntToFPConst);
    set.add(RedundantSelectFalse).add(RedundantSelectTrue).add(SelectNotCond).add(SelectI1ToNot).add(SelectToExtUI);
}
