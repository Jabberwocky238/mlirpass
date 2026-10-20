//! `complex` ⇒ `arith` + `math`, as `ComplexToStandard.cpp` (and the division algorithms of
//! `ComplexCommon/DivisionConverter.cpp`).

use alloc::vec::Vec;

use mlirformat::{Attribute, FloatKind, Type};

use super::Lowering;
use crate::canon::AttrExt;
use crate::{ApFloat, Const, ConversionPatterns, ConversionRewriter, OpData, OpId, Scalar, ValueId};

/// `arith::FastMathFlags`, as bits in their enum order.
#[derive(Clone, Copy, PartialEq, Eq)]
struct Fmf(u8);

impl Fmf {
    const NAMES: [&'static str; 7] = ["reassoc", "nnan", "ninf", "nsz", "arcp", "contract", "afn"];
    const NONE: Fmf = Fmf(0);
    const NNAN_NINF: u8 = 0b110;

    fn of(cr: &ConversionRewriter<'_, '_, '_>, op: OpId) -> Self {
        let Some(Attribute::Extended { ext, .. }) = cr.rw.body[op].get("fastmath") else { return Self::NONE };
        let body = ext.body.as_deref().unwrap_or("<none>");
        let mut bits = 0u8;
        for f in body.trim_matches(|c| c == '<' || c == '>').split(',').map(str::trim) {
            if f == "fast" {
                bits = 0x7f;
            } else if let Some(i) = Self::NAMES.iter().position(|n| *n == f) {
                bits |= 1 << i;
            }
        }
        Self(bits)
    }

    /// `bitEnumClear(fmf, nnan | ninf)`.
    fn without_nan_inf(self) -> Self {
        Self(self.0 & !Self::NNAN_NINF)
    }

    /// `bitEnumContainsAll(fmf, nnan | ninf)`.
    fn finite(self) -> bool {
        self.0 & Self::NNAN_NINF == Self::NNAN_NINF
    }

    fn attr<'a>(self) -> Attribute<'a> {
        let body = match self.0 {
            0 => alloc::string::String::from("<none>"),
            0x7f => alloc::string::String::from("<fast>"),
            b => alloc::format!("<{}>", Self::NAMES.iter().enumerate().filter(|(i, _)| b & (1 << i) != 0).map(|(_, n)| *n).collect::<Vec<_>>().join(",")),
        };
        Attribute::dialect("arith.fastmath", &body)
    }
}

/// `arith::CmpFPredicate`.
#[derive(Clone, Copy)]
enum P {
    Oeq = 1,
    Ogt = 2,
    Oge = 3,
    Olt = 4,
    Ole = 5,
    One = 6,
    Ord = 7,
    Une = 13,
    Uno = 14,
}

/// An `ImplicitLocOpBuilder` over complex values of element type `et`.
struct Cx<'c, 'r, 'a, 'p> {
    cr: &'c mut ConversionRewriter<'r, 'a, 'p>,
    et: Type<'a>,
    ct: Type<'a>,
    /// Build `llvm` ops (`ComplexToLLVM`) instead of `arith` / `math`.
    llvm: bool,
}

impl<'a> Cx<'_, '_, 'a, '_> {
    fn new<'c, 'r, 'p>(cr: &'c mut ConversionRewriter<'r, 'a, 'p>, ct: Type<'a>) -> Cx<'c, 'r, 'a, 'p> {
        let et = match &ct {
            Type::Complex(e) => (**e).clone(),
            t => t.clone(),
        };
        Cx { cr, et, ct, llvm: false }
    }

    fn mk(&mut self, data: OpData<'a>, ty: Type<'a>) -> ValueId {
        self.cr.build(data, ty)
    }

    /// An element-typed op with fast-math flags.
    fn f(&mut self, name: &str, ops: &[ValueId], fmf: Fmf) -> ValueId {
        let ty = self.et.clone();
        if self.llvm {
            let name = match name {
                "arith.addf" => "llvm.fadd",
                "arith.subf" => "llvm.fsub",
                "arith.mulf" => "llvm.fmul",
                "arith.divf" => "llvm.fdiv",
                "math.absf" => "llvm.intr.fabs",
                "math.copysign" => "llvm.intr.copysign",
                "math.sqrt" => "llvm.intr.sqrt",
                n => n,
            };
            return self.mk(OpData::build(name).operands(ops).with("fastmathFlags", super::llvm_fastmath(Some(&fmf.attr()))), ty);
        }
        self.mk(OpData::build(name).operands(ops).with("fastmath", fmf.attr()), ty)
    }

    fn kind(&self) -> FloatKind {
        match self.et {
            Type::Float(k) => k,
            _ => FloatKind::F32,
        }
    }

    fn cst(&mut self, v: f64) -> ValueId {
        let k = self.kind();
        self.float(ApFloat::from_f64(k, v).expect("a float"))
    }

    fn float(&mut self, v: ApFloat) -> ValueId {
        let ty = self.et.clone();
        let attr: Attribute<'a> = Const::scalar(Scalar::Float(v), ty.clone()).into();
        let name = if self.llvm { "llvm.mlir.constant" } else { "arith.constant" };
        self.mk(OpData::build(name).with("value", attr), ty)
    }

    fn inf(&mut self, negative: bool) -> ValueId {
        self.cst(if negative { f64::NEG_INFINITY } else { f64::INFINITY })
    }

    fn nan(&mut self) -> ValueId {
        let k = self.kind();
        self.float(ApFloat::nan(k))
    }

    fn re(&mut self, c: ValueId) -> ValueId {
        let ty = self.et.clone();
        self.mk(OpData::build("complex.re").operands(&[c]), ty)
    }

    fn im(&mut self, c: ValueId) -> ValueId {
        let ty = self.et.clone();
        self.mk(OpData::build("complex.im").operands(&[c]), ty)
    }

    fn create(&mut self, re: ValueId, im: ValueId) -> ValueId {
        let ty = self.ct.clone();
        self.mk(OpData::build("complex.create").operands(&[re, im]), ty)
    }

    /// A complex op of the complex type.
    fn c(&mut self, name: &str, ops: &[ValueId], fmf: Fmf) -> ValueId {
        let ty = self.ct.clone();
        self.mk(OpData::build(name).operands(ops).with("fastmath", fmf.attr()), ty)
    }

    fn cmp(&mut self, p: P, a: ValueId, b: ValueId, fmf: Fmf) -> ValueId {
        if self.llvm {
            return self.mk(OpData::build("llvm.fcmp").operands(&[a, b]).with("predicate", Attribute::i64(p as i64)), Type::int(1));
        }
        self.mk(OpData::build("arith.cmpf").operands(&[a, b]).with("predicate", Attribute::i64(p as i64)).with("fastmath", fmf.attr()), Type::int(1))
    }

    fn bit(&mut self, name: &str, a: ValueId, b: ValueId) -> ValueId {
        let ty = self.cr.rw.body[a].ty.clone();
        self.mk(OpData::build(name).operands(&[a, b]), ty)
    }

    fn and(&mut self, a: ValueId, b: ValueId) -> ValueId {
        self.bit(if self.llvm { "llvm.and" } else { "arith.andi" }, a, b)
    }

    fn or(&mut self, a: ValueId, b: ValueId) -> ValueId {
        self.bit(if self.llvm { "llvm.or" } else { "arith.ori" }, a, b)
    }

    fn select(&mut self, c: ValueId, a: ValueId, b: ValueId) -> ValueId {
        let ty = self.cr.rw.body[a].ty.clone();
        self.mk(OpData::build(if self.llvm { "llvm.select" } else { "arith.select" }).operands(&[c, a, b]), ty)
    }

    /// `ComplexStructBuilder`: field `i` of the struct `v`.
    fn field(&mut self, v: ValueId, i: i64) -> ValueId {
        let ty = self.et.clone();
        self.mk(OpData::build("llvm.extractvalue").operands(&[v]).with("position", Attribute::DenseArray { ty: Type::int(64), values: alloc::vec![alloc::format!("{i}").into()] }), ty)
    }

    /// `ComplexStructBuilder::poison` with both fields set.
    fn pack(&mut self, st: Type<'a>, re: ValueId, im: ValueId) -> ValueId {
        let v = self.mk(OpData::build("llvm.mlir.poison"), st);
        self.insert(v, re, im)
    }

    /// `setReal`, then `setImaginary`.
    fn insert(&mut self, mut v: ValueId, re: ValueId, im: ValueId) -> ValueId {
        let st = self.cr.rw.body[v].ty.clone();
        for (i, x) in [re, im].into_iter().enumerate() {
            let p = Attribute::DenseArray { ty: Type::int(64), values: alloc::vec![alloc::format!("{i}").into()] };
            v = self.mk(OpData::build("llvm.insertvalue").operands(&[v, x]).with("position", p), st.clone());
        }
        v
    }

    fn add(&mut self, a: ValueId, b: ValueId, f: Fmf) -> ValueId {
        self.f("arith.addf", &[a, b], f)
    }

    fn sub(&mut self, a: ValueId, b: ValueId, f: Fmf) -> ValueId {
        self.f("arith.subf", &[a, b], f)
    }

    fn mul(&mut self, a: ValueId, b: ValueId, f: Fmf) -> ValueId {
        self.f("arith.mulf", &[a, b], f)
    }

    fn div(&mut self, a: ValueId, b: ValueId, f: Fmf) -> ValueId {
        self.f("arith.divf", &[a, b], f)
    }

    fn m(&mut self, name: &str, a: ValueId, f: Fmf) -> ValueId {
        self.f(&alloc::format!("math.{name}"), &[a], f)
    }

    /// `computeAbs`.
    fn abs(&mut self, real: ValueId, imag: ValueId, fmf: Fmf, fun: AbsFn) -> ValueId {
        let one = self.cst(1.0);
        let ar = self.m("absf", real, fmf);
        let ai = self.m("absf", imag, fmf);
        let mut max = self.f("arith.maximumf", &[ar, ai], fmf);
        let mut min = self.f("arith.minimumf", &[ar, ai], fmf);
        let f2 = fmf.without_nan_inf();
        let ratio = self.div(min, max, f2);
        let sq = self.mul(ratio, ratio, f2);
        let mut sq1 = self.add(sq, one, f2);
        if fun == AbsFn::Rsqrt {
            sq1 = self.m("rsqrt", sq1, f2);
            min = self.m("rsqrt", min, f2);
            max = self.m("rsqrt", max, f2);
        }
        let result = if fun == AbsFn::Sqrt {
            let quarter = self.cst(0.25);
            let s = self.m("sqrt", max, f2);
            let p = self.f("math.powf", &[sq1, quarter], f2);
            self.mul(s, p, f2)
        } else {
            let s = self.m("sqrt", sq1, f2);
            self.mul(max, s, f2)
        };
        let nan = self.cmp(P::Uno, result, result, f2);
        self.select(nan, min, result)
    }

    /// `evaluatePolynomial`.
    fn poly(&mut self, arg: ValueId, coeffs: &[f64], fmf: Fmf) -> ValueId {
        let mut p = self.cst(coeffs[0]);
        for c in &coeffs[1..] {
            let k = self.cst(*c);
            p = self.f("math.fma", &[p, arg, k], fmf);
        }
        p
    }

    /// `convertDivToStandardUsingAlgebraic`.
    fn div_algebraic(&mut self, lr: ValueId, li: ValueId, rr: ValueId, ri: ValueId, f: Fmf) -> (ValueId, ValueId) {
        let a = self.mul(rr, rr, f);
        let b = self.mul(ri, ri, f);
        let norm = self.add(a, b, f);
        let a = self.mul(lr, rr, f);
        let b = self.mul(li, ri, f);
        let rnum = self.add(a, b, f);
        let a = self.mul(li, rr, f);
        let b = self.mul(lr, ri, f);
        let inum = self.sub(a, b, f);
        (self.div(rnum, norm, f), self.div(inum, norm, f))
    }

    /// `convertDivToStandardUsingRangeReduction`.
    fn div_range_reduction(&mut self, lr: ValueId, li: ValueId, rr: ValueId, ri: ValueId, f: Fmf) -> (ValueId, ValueId) {
        let n = Fmf::NONE;
        let ratio1 = self.div(rr, ri, f);
        let t = self.mul(ratio1, rr, f);
        let denom1 = self.add(ri, t, f);
        let t = self.mul(lr, ratio1, f);
        let rn1 = self.add(t, li, f);
        let r1 = self.div(rn1, denom1, f);
        let t = self.mul(li, ratio1, f);
        let in1 = self.sub(t, lr, f);
        let i1 = self.div(in1, denom1, f);
        let ratio2 = self.div(ri, rr, f);
        let t = self.mul(ratio2, ri, f);
        let denom2 = self.add(rr, t, f);
        let t = self.mul(li, ratio2, f);
        let rn2 = self.add(lr, t, f);
        let r2 = self.div(rn2, denom2, f);
        let t = self.mul(lr, ratio2, f);
        let in2 = self.sub(li, t, f);
        let i2 = self.div(in2, denom2, f);
        let zero = self.cst(0.0);
        let rra = self.m("absf", rr, f);
        let rrz = self.cmp(P::Oeq, rra, zero, n);
        let ria = self.m("absf", ri, f);
        let riz = self.cmp(P::Oeq, ria, zero, n);
        let lrn = self.cmp(P::Ord, lr, zero, n);
        let lin = self.cmp(P::Ord, li, zero, n);
        let lnn = self.or(lrn, lin);
        let bz = self.and(rrz, riz);
        let is_inf = self.and(lnn, bz);
        let inf = self.inf(false);
        let infs = self.f("math.copysign", &[inf, rr], n);
        let infr = self.mul(infs, lr, f);
        let infi = self.mul(infs, li, f);
        let rrf = self.cmp(P::One, rra, inf, n);
        let rif = self.cmp(P::One, ria, inf, n);
        let rf = self.and(rrf, rif);
        let lra = self.m("absf", lr, f);
        let lri = self.cmp(P::Oeq, lra, inf, n);
        let lia = self.m("absf", li, f);
        let lii = self.cmp(P::Oeq, lia, inf, n);
        let linf = self.or(lri, lii);
        let inf_fin = self.and(linf, rf);
        let one = self.cst(1.0);
        let s = self.select(lri, one, zero);
        let lris = self.f("math.copysign", &[s, lr], n);
        let s = self.select(lii, one, zero);
        let liis = self.f("math.copysign", &[s, li], n);
        let a = self.mul(lris, rr, f);
        let b = self.mul(liis, ri, f);
        let t = self.add(a, b, f);
        let r3 = self.mul(inf, t, f);
        let a = self.mul(lris, ri, f);
        let b = self.mul(liis, rr, f);
        let t = self.sub(b, a, f);
        let i3 = self.mul(inf, t, f);
        let lrf = self.cmp(P::One, lra, inf, n);
        let lif = self.cmp(P::One, lia, inf, n);
        let lf = self.and(lrf, lif);
        let rri = self.cmp(P::Oeq, rra, inf, n);
        let rii = self.cmp(P::Oeq, ria, inf, n);
        let rinf = self.or(rri, rii);
        let fin_inf = self.and(lf, rinf);
        let s = self.select(rri, one, zero);
        let rris = self.f("math.copysign", &[s, rr], n);
        let s = self.select(rii, one, zero);
        let riis = self.f("math.copysign", &[s, ri], n);
        let a = self.mul(lr, rris, f);
        let b = self.mul(li, riis, f);
        let t = self.add(a, b, f);
        let r4 = self.mul(zero, t, f);
        let a = self.mul(li, rris, f);
        let b = self.mul(lr, riis, f);
        let t = self.sub(a, b, f);
        let i4 = self.mul(zero, t, f);
        let smaller = self.cmp(P::Olt, rra, ria, n);
        let r5 = self.select(smaller, r1, r2);
        let i5 = self.select(smaller, i1, i2);
        let rs3 = self.select(fin_inf, r4, r5);
        let is3 = self.select(fin_inf, i4, i5);
        let rs2 = self.select(inf_fin, r3, rs3);
        let is2 = self.select(inf_fin, i3, is3);
        let rs1 = self.select(is_inf, infr, rs2);
        let is1 = self.select(is_inf, infi, is2);
        let rn = self.cmp(P::Uno, r5, zero, n);
        let inn = self.cmp(P::Uno, i5, zero, n);
        let both = self.and(rn, inn);
        (self.select(both, rs1, r5), self.select(both, is1, i5))
    }

    /// `powOpConversionImpl`.
    fn pow(&mut self, lhs: ValueId, c: ValueId, d: ValueId, fmf: Fmf) -> ValueId {
        let a = self.re(lhs);
        let b = self.im(lhs);
        let et = self.et.clone();
        let abs = self.mk(OpData::build("complex.abs").operands(&[lhs]).with("fastmath", fmf.attr()), et);
        let abs_c = self.f("math.powf", &[abs, c], fmf);
        let neg_d = self.f("arith.negf", &[d], fmf);
        let arg = self.f("math.atan2", &[b, a], fmf);
        let t = self.mul(neg_d, arg, fmf);
        let e = self.m("exp", t, fmf);
        let coeff = self.mul(abs_c, e, fmf);
        let ln = self.m("log", abs, fmf);
        let carg = self.mul(c, arg, fmf);
        let dln = self.mul(d, ln, fmf);
        let q = self.add(carg, dln, fmf);
        let cq = self.m("cos", q, fmf);
        let sq = self.m("sin", q, fmf);
        let inf = self.inf(false);
        let zero = self.cst(0.0);
        let one = self.cst(1.0);
        let c_one = self.create(one, zero);
        let c_zero = self.create(zero, zero);
        let c_inf = self.create(inf, zero);
        let abs0 = self.cmp(P::Oeq, abs, zero, fmf);
        let d0 = self.cmp(P::Oeq, d, zero, fmf);
        let c0 = self.cmp(P::Oeq, c, zero, fmf);
        let b0 = self.cmp(P::Oeq, b, zero, fmf);
        let zle = self.cmp(P::Ole, zero, c, fmf);
        let ccos = self.mul(coeff, cq, fmf);
        let csin = self.mul(coeff, sq, fmf);
        let one_or_zero = self.select(c0, c_one, c_zero);
        let cs = self.create(ccos, csin);
        let t = self.and(abs0, d0);
        let t = self.and(t, zle);
        let cut0 = self.select(t, one_or_zero, cs);
        let rhs0 = self.and(c0, d0);
        let cut1 = self.select(rhs0, c_one, cut0);
        let t = self.cmp(P::Oeq, a, one, fmf);
        let lhs1 = self.and(t, b0);
        let cut2 = self.select(lhs1, c_one, cut1);
        let t = self.cmp(P::Oeq, a, inf, fmf);
        let lhs_inf = self.and(t, b0);
        let t = self.cmp(P::Ogt, c, zero, fmf);
        let gt0 = self.and(d0, t);
        let t = self.and(lhs_inf, gt0);
        let cut3 = self.select(t, c_inf, cut2);
        let t = self.cmp(P::Olt, c, zero, fmf);
        let lt0 = self.and(d0, t);
        let t = self.and(lhs_inf, lt0);
        self.select(t, c_zero, cut3)
    }
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum AbsFn {
    Abs,
    Sqrt,
    Rsqrt,
}

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

/// The complex ⇒ standard patterns.
pub struct ComplexToStd;

impl ComplexToStd {
    fn operand_ty<'a>(cr: &Cr<'_, 'a, '_>, op: OpId) -> Type<'a> {
        cr.rw.body[cr.rw.body[op].operands[0]].ty.clone()
    }

    fn result_ty<'a>(cr: &Cr<'_, 'a, '_>, op: OpId) -> Type<'a> {
        cr.rw.body[cr.rw.body[op].results[0]].ty.clone()
    }

    fn done(cr: &mut Cr<'_, '_, '_>, op: OpId, v: ValueId) -> bool {
        cr.replace_values(op, &[v]);
        true
    }

    fn abs(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let (fmf, ty) = (Fmf::of(cr, op), Self::operand_ty(cr, op));
        let mut b = Cx::new(cr, ty);
        let (re, im) = (b.re(o[0][0]), b.im(o[0][0]));
        let v = b.abs(re, im, fmf, AbsFn::Abs);
        Self::done(cr, op, v)
    }

    fn angle(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let (fmf, ty) = (Fmf::of(cr, op), Self::operand_ty(cr, op));
        let mut b = Cx::new(cr, ty);
        let (re, im) = (b.re(o[0][0]), b.im(o[0][0]));
        let v = b.f("math.atan2", &[im, re], fmf);
        Self::done(cr, op, v)
    }

    fn atan2(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let (fmf, ty) = (Fmf::of(cr, op), Self::result_ty(cr, op));
        let mut b = Cx::new(cr, ty);
        let (lhs, rhs) = (o[0][0], o[1][0]);
        let r2 = b.c("complex.mul", &[rhs, rhs], fmf);
        let l2 = b.c("complex.mul", &[lhs, lhs], fmf);
        let s = b.c("complex.add", &[r2, l2], fmf);
        let sq = b.c("complex.sqrt", &[s], fmf);
        let zero = b.cst(0.0);
        let one = b.cst(1.0);
        let i = b.create(zero, one);
        let il = b.c("complex.mul", &[i, lhs], fmf);
        let ril = b.c("complex.add", &[rhs, il], fmf);
        let d = b.c("complex.div", &[ril, sq], fmf);
        let l = b.c("complex.log", &[d], fmf);
        let neg_one = b.cst(-1.0);
        let ni = b.create(zero, neg_one);
        let v = b.c("complex.mul", &[ni, l], fmf);
        Self::done(cr, op, v)
    }

    fn binary(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let (fmf, ty) = (Fmf::of(cr, op), Self::operand_ty(cr, op));
        let name = if cr.rw.body[op].name == "complex.add" { "arith.addf" } else { "arith.subf" };
        let mut b = Cx::new(cr, ty);
        let (lr, rr) = (b.re(o[0][0]), b.re(o[1][0]));
        let r = b.f(name, &[lr, rr], fmf);
        let (li, ri) = (b.im(o[0][0]), b.im(o[1][0]));
        let i = b.f(name, &[li, ri], fmf);
        let v = b.create(r, i);
        Self::done(cr, op, v)
    }

    fn compare(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let ty = Self::operand_ty(cr, op);
        let eq = cr.rw.body[op].name == "complex.eq";
        let mut b = Cx::new(cr, ty);
        let (lr, li, rr, ri) = (b.re(o[0][0]), b.im(o[0][0]), b.re(o[1][0]), b.im(o[1][0]));
        let p = if eq { P::Oeq } else { P::Une };
        let rc = b.cmp(p, lr, rr, Fmf::NONE);
        let ic = b.cmp(p, li, ri, Fmf::NONE);
        let v = if eq { b.and(rc, ic) } else { b.or(rc, ic) };
        Self::done(cr, op, v)
    }

    fn conj(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let ty = Self::operand_ty(cr, op);
        let mut b = Cx::new(cr, ty);
        let (re, im) = (b.re(o[0][0]), b.im(o[0][0]));
        let ni = b.f("arith.negf", &[im], Fmf::NONE);
        let v = b.create(re, ni);
        Self::done(cr, op, v)
    }

    /// `TrigonometricOpConversion`: `cos` or `sin`.
    fn trig(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let (fmf, ty) = (Fmf::of(cr, op), Self::operand_ty(cr, op));
        let cos_op = cr.rw.body[op].name == "complex.cos";
        let mut b = Cx::new(cr, ty);
        let (re, im) = (b.re(o[0][0]), b.im(o[0][0]));
        let half = b.cst(0.5);
        let e = b.m("exp", im, fmf);
        let se = b.mul(half, e, fmf);
        let re_e = b.div(half, e, fmf);
        let sin = b.m("sin", re, fmf);
        let cos = b.m("cos", re, fmf);
        let (r, i) = if cos_op {
            let s = b.add(re_e, se, fmf);
            let r = b.mul(s, cos, fmf);
            let d = b.sub(re_e, se, fmf);
            (r, b.mul(d, sin, fmf))
        } else {
            let s = b.add(se, re_e, fmf);
            let r = b.mul(s, sin, fmf);
            let d = b.sub(se, re_e, fmf);
            (r, b.mul(d, cos, fmf))
        };
        let v = b.create(r, i);
        Self::done(cr, op, v)
    }

    fn exp(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let (fmf, ty) = (Fmf::of(cr, op), Self::operand_ty(cr, op));
        let mut b = Cx::new(cr, ty);
        let (x, y) = (b.re(o[0][0]), b.im(o[0][0]));
        let zero = b.cst(0.0);
        let half = b.cst(0.5);
        let inf = b.inf(false);
        let exp = b.m("exp", x, fmf);
        let xh = b.mul(x, half, fmf);
        let eh = b.m("exp", xh, fmf);
        let cos = b.m("cos", y, fmf);
        let sin = b.m("sin", y, fmf);
        let ei = b.cmp(P::Oeq, exp, inf, fmf);
        let yz = b.cmp(P::Oeq, y, zero, Fmf::NONE);
        let rn = b.mul(exp, cos, fmf);
        let t = b.mul(eh, cos, fmf);
        let ro = b.mul(t, eh, fmf);
        let r = b.select(ei, ro, rn);
        let in_ = b.mul(exp, sin, fmf);
        let t = b.mul(eh, sin, fmf);
        let io = b.mul(t, eh, fmf);
        let inz = b.select(ei, io, in_);
        let i = b.select(yz, zero, inz);
        let v = b.create(r, i);
        Self::done(cr, op, v)
    }

    fn expm1(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let (fmf, ty) = (Fmf::of(cr, op), Self::result_ty(cr, op));
        let mut b = Cx::new(cr, ty);
        let (re, im) = (b.re(o[0][0]), b.im(o[0][0]));
        let zero = b.cst(0.0);
        let one = b.cst(1.0);
        let em1 = b.m("expm1", re, fmf);
        let er = b.add(em1, one, fmf);
        let si = b.m("sin", im, fmf);
        // `emitCosm1`.
        let neg_half = b.cst(-0.5);
        let neg_one = b.cst(-1.0);
        const K: [f64; 7] = [4.7377507964246204691685E-14, -1.1470284843425359765671E-11, 2.0876754287081521758361E-9, -2.7557319214999787979814E-7, 2.4801587301570552304991E-5, -1.3888888888888872993737E-3, 4.1666666666666666609054E-2];
        let cos = b.m("cos", im, fmf);
        let large = b.add(cos, neg_one, fmf);
        let p2 = b.mul(im, im, fmf);
        let p4 = b.mul(p2, p2, fmf);
        let poly = b.poly(p2, &K, fmf);
        let a = b.mul(p4, poly, fmf);
        let c = b.mul(neg_half, p2, fmf);
        let small = b.add(a, c, Fmf::NONE);
        let pi4 = b.cst(0.61685);
        let cond = b.cmp(P::Oge, p2, pi4, fmf);
        let cm1 = b.select(cond, large, small);
        let ci = b.add(cm1, one, fmf);
        let t = b.mul(em1, ci, fmf);
        let r = b.add(t, cm1, fmf);
        let iz = b.cmp(P::Oeq, im, zero, fmf);
        let t = b.mul(er, si, fmf);
        let i = b.select(iz, zero, t);
        let v = b.create(r, i);
        Self::done(cr, op, v)
    }

    fn log(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let (fmf, ty) = (Fmf::of(cr, op), Self::operand_ty(cr, op));
        let mut b = Cx::new(cr, ty);
        let et = b.et.clone();
        let abs = b.mk(OpData::build("complex.abs").operands(&[o[0][0]]).with("fastmath", fmf.attr()), et);
        let r = b.m("log", abs, fmf);
        let (re, im) = (b.re(o[0][0]), b.im(o[0][0]));
        let i = b.f("math.atan2", &[im, re], fmf);
        let v = b.create(r, i);
        Self::done(cr, op, v)
    }

    fn log1p(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let (fmf, ty) = (Fmf::of(cr, op), Self::operand_ty(cr, op));
        let mut b = Cx::new(cr, ty);
        let (re, im) = (b.re(o[0][0]), b.im(o[0][0]));
        let half = b.cst(0.5);
        let one = b.cst(1.0);
        let rp1 = b.add(re, one, fmf);
        let arp1 = b.m("absf", rp1, fmf);
        let ai = b.m("absf", im, fmf);
        let max = b.f("arith.maximumf", &[arp1, ai], fmf);
        let min = b.f("arith.minimumf", &[arp1, ai], fmf);
        let use_re = b.cmp(P::Ogt, rp1, ai, fmf);
        let mm1 = b.sub(max, one, fmf);
        let m = b.select(use_re, re, mm1);
        let f2 = fmf.without_nan_inf();
        let ratio = b.div(min, max, f2);
        let lm = b.m("log1p", m, fmf);
        let t = b.mul(ratio, ratio, f2);
        let ls = b.m("log1p", t, f2);
        let t = b.mul(half, ls, f2);
        let r = b.add(t, lm, f2);
        let nan = b.cmp(P::Uno, r, r, f2);
        let rr = b.select(nan, min, r);
        let i = b.f("math.atan2", &[im, rp1], fmf);
        let v = b.create(rr, i);
        Self::done(cr, op, v)
    }

    fn mul(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let (fmf, ty) = (Fmf::of(cr, op), Self::operand_ty(cr, op));
        let mut b = Cx::new(cr, ty);
        let (lr, li, rr, ri) = (b.re(o[0][0]), b.im(o[0][0]), b.re(o[1][0]), b.im(o[1][0]));
        let a = b.mul(lr, rr, fmf);
        let c = b.mul(li, ri, fmf);
        let r = b.sub(a, c, fmf);
        let a = b.mul(li, rr, fmf);
        let c = b.mul(lr, ri, fmf);
        let i = b.add(a, c, fmf);
        let v = b.create(r, i);
        Self::done(cr, op, v)
    }

    fn neg(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let ty = Self::operand_ty(cr, op);
        let mut b = Cx::new(cr, ty);
        let (re, im) = (b.re(o[0][0]), b.im(o[0][0]));
        let nr = b.f("arith.negf", &[re], Fmf::NONE);
        let ni = b.f("arith.negf", &[im], Fmf::NONE);
        let v = b.create(nr, ni);
        Self::done(cr, op, v)
    }

    fn sign(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let (fmf, ty) = (Fmf::of(cr, op), Self::operand_ty(cr, op));
        let mut b = Cx::new(cr, ty);
        let (re, im) = (b.re(o[0][0]), b.im(o[0][0]));
        let zero = b.cst(0.0);
        let rz = b.cmp(P::Oeq, re, zero, Fmf::NONE);
        let iz = b.cmp(P::Oeq, im, zero, Fmf::NONE);
        let z = b.and(rz, iz);
        let et = b.et.clone();
        let abs = b.mk(OpData::build("complex.abs").operands(&[o[0][0]]).with("fastmath", fmf.attr()), et);
        let rs = b.div(re, abs, fmf);
        let is = b.div(im, abs, fmf);
        let s = b.create(rs, is);
        let v = b.select(z, o[0][0], s);
        Self::done(cr, op, v)
    }

    fn sqrt(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let (fmf, ty) = (Fmf::of(cr, op), Self::result_ty(cr, op));
        let mut b = Cx::new(cr, ty);
        let zero = b.cst(0.0);
        let half = b.cst(0.5);
        let (re, im) = (b.re(o[0][0]), b.im(o[0][0]));
        let abs = b.abs(re, im, fmf, AbsFn::Sqrt);
        let arg = b.f("math.atan2", &[im, re], fmf);
        let sa = b.mul(arg, half, fmf);
        let cos = b.m("cos", sa, fmf);
        let sin = b.m("sin", sa, fmf);
        let sz = b.cmp(P::Oeq, sin, zero, fmf);
        let mut r = b.mul(abs, cos, fmf);
        let t = b.mul(abs, sin, fmf);
        let mut i = b.select(sz, zero, t);
        if !fmf.finite() {
            let inf = b.inf(false);
            let ninf = b.inf(true);
            let nan = b.nan();
            let ai = b.m("absf", im, fmf);
            let aii = b.cmp(P::Oeq, ai, inf, fmf);
            let ain = b.cmp(P::One, ai, inf, fmf);
            let ri = b.cmp(P::Oeq, re, inf, fmf);
            let rni = b.cmp(P::Oeq, re, ninf, fmf);
            let t = b.and(rni, ain);
            r = b.select(t, zero, r);
            let t = b.or(aii, ri);
            r = b.select(t, inf, r);
            let isi = b.f("math.copysign", &[inf, im], fmf);
            let t = b.cmp(P::Uno, abs, abs, Fmf::NONE);
            i = b.select(t, nan, i);
            let t = b.or(aii, rni);
            i = b.select(t, isi, i);
        }
        let z = b.cmp(P::Oeq, abs, zero, fmf);
        r = b.select(z, zero, r);
        i = b.select(z, zero, i);
        let v = b.create(r, i);
        Self::done(cr, op, v)
    }

    /// `TanTanhOpConversion`.
    fn tan_tanh(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let (fmf, ty) = (Fmf::of(cr, op), Self::operand_ty(cr, op));
        let tan = cr.rw.body[op].name == "complex.tan";
        let mut b = Cx::new(cr, ty);
        let (mut re, mut im) = (b.re(o[0][0]), b.im(o[0][0]));
        let neg_one = b.cst(-1.0);
        if tan {
            core::mem::swap(&mut re, &mut im);
            re = b.mul(re, neg_one, fmf);
        }
        let inf = b.inf(false);
        let four = b.cst(4.0);
        let two_re = b.add(re, re, fmf);
        let neg_two_re = b.mul(neg_one, two_re, fmf);
        let e1 = b.m("expm1", two_re, fmf);
        let e2 = b.m("expm1", neg_two_re, fmf);
        let rnum = b.sub(e1, e2, fmf);
        let ci = b.m("cos", im, fmf);
        let ci2 = b.mul(ci, ci, fmf);
        let two_cos = b.mul(ci2, four, fmf);
        let si = b.m("sin", im, fmf);
        let t = b.mul(ci, si, fmf);
        let inum = b.mul(four, t, fmf);
        let esum = b.add(e1, e2, fmf);
        let denom = b.add(esum, two_cos, fmf);
        let is_inf = b.cmp(P::Oeq, esum, inf, fmf);
        let limit = b.f("math.copysign", &[neg_one, re], fmf);
        let t = b.div(rnum, denom, fmf);
        let mut r = b.select(is_inf, limit, t);
        let mut i = b.div(inum, denom, fmf);
        if !fmf.finite() {
            let ar = b.m("absf", re, fmf);
            let zero = b.cst(0.0);
            let nan = b.nan();
            let ari = b.cmp(P::Oeq, ar, inf, fmf);
            let iz = b.cmp(P::Oeq, im, zero, fmf);
            let t = b.mk(OpData::build("arith.constant").with("value", Attribute::Bool(true)), Type::int(1));
            let arni = b.bit("arith.xori", ari, t);
            let inn = b.cmp(P::Uno, inum, inum, fmf);
            let rnan = b.and(inn, arni);
            let t = b.and(ari, inn);
            let izero = b.or(iz, t);
            r = b.select(rnan, nan, r);
            i = b.select(izero, zero, i);
        }
        if tan {
            core::mem::swap(&mut r, &mut i);
            i = b.mul(i, neg_one, fmf);
        }
        let v = b.create(r, i);
        Self::done(cr, op, v)
    }

    fn powi(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let (fmf, ty) = (Fmf::of(cr, op), Self::result_ty(cr, op));
        let mut b = Cx::new(cr, ty);
        let et = b.et.clone();
        let fe = b.mk(OpData::build("arith.sitofp").operands(&[o[1][0]]), et);
        let zero = b.cst(0.0);
        let ce = b.create(fe, zero);
        let v = b.c("complex.pow", &[o[0][0], ce], fmf);
        Self::done(cr, op, v)
    }

    fn pow(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let (fmf, ty) = (Fmf::of(cr, op), Self::operand_ty(cr, op));
        let mut b = Cx::new(cr, ty);
        let (c, d) = (b.re(o[1][0]), b.im(o[1][0]));
        let v = b.pow(o[0][0], c, d, fmf);
        Self::done(cr, op, v)
    }

    fn rsqrt(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let (fmf, ty) = (Fmf::of(cr, op), Self::operand_ty(cr, op));
        let mut b = Cx::new(cr, ty);
        let zero = b.cst(0.0);
        let inf = b.inf(false);
        let neg_half = b.cst(-0.5);
        let nan = b.nan();
        let (re, im) = (b.re(o[0][0]), b.im(o[0][0]));
        let abs = b.abs(re, im, fmf, AbsFn::Rsqrt);
        let arg = b.f("math.atan2", &[im, re], fmf);
        let ra = b.mul(arg, neg_half, fmf);
        let cos = b.m("cos", ra, fmf);
        let sin = b.m("sin", ra, fmf);
        let mut r = b.mul(abs, cos, fmf);
        let mut i = b.mul(abs, sin, fmf);
        if !fmf.finite() {
            let neg_one = b.cst(-1.0);
            let rsz = b.f("math.copysign", &[zero, re], fmf);
            let isz = b.f("math.copysign", &[zero, im], fmf);
            let nisz = b.mul(neg_one, isz, fmf);
            let ar = b.m("absf", re, fmf);
            let ai = b.m("absf", im, fmf);
            let aii = b.cmp(P::Oeq, ai, inf, fmf);
            let rn = b.cmp(P::Uno, re, re, fmf);
            let ri = b.cmp(P::Oeq, ar, inf, fmf);
            let t = b.and(aii, rn);
            let z = b.or(t, ri);
            r = b.select(z, rsz, r);
            i = b.select(z, nisz, i);
        }
        let rz = b.cmp(P::Oeq, re, zero, fmf);
        let iz = b.cmp(P::Oeq, im, zero, fmf);
        let z = b.and(rz, iz);
        r = b.select(z, inf, r);
        i = b.select(z, nan, i);
        let v = b.create(r, i);
        Self::done(cr, op, v)
    }

    fn div(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>], improved: bool) -> bool {
        let (fmf, ty) = (Fmf::of(cr, op), Self::operand_ty(cr, op));
        let mut b = Cx::new(cr, ty);
        let (lr, li, rr, ri) = (b.re(o[0][0]), b.im(o[0][0]), b.re(o[1][0]), b.im(o[1][0]));
        let (r, i) = if improved { b.div_range_reduction(lr, li, rr, ri, fmf) } else { b.div_algebraic(lr, li, rr, ri, fmf) };
        let v = b.create(r, i);
        Self::done(cr, op, v)
    }

    fn div_improved(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        Self::div(cr, op, o, true)
    }

    fn div_basic(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        Self::div(cr, op, o, false)
    }

    /// `populateComplexToStandardConversionPatterns`; `improved`: `complex-range=improved`.
    pub fn populate(patterns: &mut ConversionPatterns<'_>, improved: bool) {
        let table: [(&'static str, super::LowerFn); 24] = [
            ("complex.abs", Self::abs),
            ("complex.angle", Self::angle),
            ("complex.atan2", Self::atan2),
            ("complex.add", Self::binary),
            ("complex.sub", Self::binary),
            ("complex.eq", Self::compare),
            ("complex.neq", Self::compare),
            ("complex.conj", Self::conj),
            ("complex.cos", Self::trig),
            ("complex.exp", Self::exp),
            ("complex.expm1", Self::expm1),
            ("complex.log1p", Self::log1p),
            ("complex.log", Self::log),
            ("complex.mul", Self::mul),
            ("complex.neg", Self::neg),
            ("complex.sign", Self::sign),
            ("complex.sin", Self::trig),
            ("complex.sqrt", Self::sqrt),
            ("complex.tan", Self::tan_tanh),
            ("complex.tanh", Self::tan_tanh),
            ("complex.powi", Self::powi),
            ("complex.pow", Self::pow),
            ("complex.rsqrt", Self::rsqrt),
            ("complex.div", if improved { Self::div_improved } else { Self::div_basic }),
        ];
        for (root, f) in table {
            patterns.add(Lowering { root, benefit: 1, f });
        }
    }
}

/// `complex` ⇒ `llvm`, as `ComplexToLLVM.cpp`.
pub struct ComplexToLlvm;

impl ComplexToLlvm {
    /// The element type, the struct type, and a builder.
    fn begin<'c, 'r, 'a, 'p>(cr: &'c mut Cr<'r, 'a, 'p>, op: OpId) -> Option<(Cx<'c, 'r, 'a, 'p>, Type<'a>)> {
        let ct = cr.rw.body[cr.rw.body[op].results[0]].ty.clone();
        let st = cr.type_converter()?.convert(&ct)?;
        let mut b = Cx::new(cr, ct);
        b.llvm = true;
        Some((b, st))
    }

    /// Both operands unpacked: (lhs re, lhs im, rhs re, rhs im).
    fn unpack(b: &mut Cx<'_, '_, '_, '_>, o: &[Vec<ValueId>]) -> (ValueId, ValueId, ValueId, ValueId) {
        let lr = b.field(o[0][0], 0);
        let li = b.field(o[0][0], 1);
        let rr = b.field(o[1][0], 0);
        let ri = b.field(o[1][0], 1);
        (lr, li, rr, ri)
    }

    fn abs(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let fmf = Fmf::of(cr, op);
        let ct = cr.rw.body[cr.rw.body[op].operands[0]].ty.clone();
        let mut b = Cx::new(cr, ct);
        b.llvm = true;
        let re = b.field(o[0][0], 0);
        let im = b.field(o[0][0], 1);
        let rr = b.mul(re, re, fmf);
        let ii = b.mul(im, im, fmf);
        let n = b.add(rr, ii, fmf);
        let ty = b.et.clone();
        cr.replace_new(op, OpData::build("llvm.intr.sqrt").operands(&[n]), &[ty]);
        true
    }

    fn constant(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let ct = cr.rw.body[cr.rw.body[op].results[0]].ty.clone();
        let Some(st) = cr.type_converter().and_then(|tc| tc.convert(&ct)) else { return false };
        let mut data = OpData::build("llvm.mlir.constant");
        if let Some(v) = cr.rw.body[op].get("value").cloned() {
            data.set("value", v);
        }
        cr.replace_new(op, data, &[st]);
        true
    }

    fn create(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let Some((mut b, st)) = Self::begin(cr, op) else { return false };
        let v = b.pack(st, o[0][0], o[1][0]);
        cr.replace_values(op, &[v]);
        true
    }

    fn part(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let ct = cr.rw.body[cr.rw.body[op].operands[0]].ty.clone();
        let i = i64::from(cr.rw.body[op].name == "complex.im");
        let mut b = Cx::new(cr, ct);
        let v = b.field(o[0][0], i);
        cr.replace_values(op, &[v]);
        true
    }

    fn arith(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let fmf = Fmf::of(cr, op);
        let name = cr.rw.body[op].name.clone();
        let Some((mut b, st)) = Self::begin(cr, op) else { return false };
        let (lr, li, rr, ri) = Self::unpack(&mut b, o);
        let poison = b.mk(OpData::build("llvm.mlir.poison"), st.clone());
        let (re, im) = match &*name {
            "complex.add" => (b.add(lr, rr, fmf), b.add(li, ri, fmf)),
            "complex.sub" => (b.sub(lr, rr, fmf), b.sub(li, ri, fmf)),
            "complex.mul" => {
                let a = b.mul(rr, lr, fmf);
                let c = b.mul(ri, li, fmf);
                let re = b.sub(a, c, fmf);
                let a = b.mul(li, rr, fmf);
                let c = b.mul(lr, ri, fmf);
                (re, b.add(a, c, fmf))
            }
            _ => return false,
        };
        let v = b.insert(poison, re, im);
        cr.replace_values(op, &[v]);
        true
    }

    fn div(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>], improved: bool) -> bool {
        let fmf = Fmf::of(cr, op);
        let Some((mut b, st)) = Self::begin(cr, op) else { return false };
        let (lr, li, rr, ri) = Self::unpack(&mut b, o);
        let poison = b.mk(OpData::build("llvm.mlir.poison"), st.clone());
        let (re, im) = if improved { b.div_range_reduction(lr, li, rr, ri, fmf) } else { b.div_algebraic(lr, li, rr, ri, fmf) };
        let v = b.insert(poison, re, im);
        cr.replace_values(op, &[v]);
        true
    }

    fn div_improved(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        Self::div(cr, op, o, true)
    }

    fn div_basic(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        Self::div(cr, op, o, false)
    }

    /// `populateComplexToLLVMConversionPatterns`; `improved`: `complex-range=improved`.
    pub fn populate(patterns: &mut ConversionPatterns<'_>, tc: usize, improved: bool) {
        let table: [(&'static str, super::LowerFn); 9] = [
            ("complex.abs", Self::abs),
            ("complex.add", Self::arith),
            ("complex.constant", Self::constant),
            ("complex.create", Self::create),
            ("complex.im", Self::part),
            ("complex.mul", Self::arith),
            ("complex.re", Self::part),
            ("complex.sub", Self::arith),
            ("complex.div", if improved { Self::div_improved } else { Self::div_basic }),
        ];
        for (root, f) in table {
            patterns.add_with(tc, Lowering { root, benefit: 1, f });
        }
    }
}
