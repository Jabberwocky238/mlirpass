//! `complex` ⇒ `arith` + `math`, as `ComplexToStandard.cpp` (and the division algorithms of
//! `ComplexCommon/DivisionConverter.cpp`).

use alloc::vec::Vec;

use mlirpass_macros::{ops, patterns};
use mlirformat::arith::CmpFPredicate as P;
use mlirformat::{Attribute, FloatKind, Type};

use super::FromOp;
use crate::{ApFloat, Const, ConversionRewriter, OpData, OpId, Scalar, ValueId};

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
    #[ops(self, fmf = f2)]
    fn abs(&mut self, real: ValueId, imag: ValueId, fmf: Fmf, fun: AbsFn) -> ValueId {
        let one = 1.0;
        let ar = self.m("absf", real, fmf);
        let ai = self.m("absf", imag, fmf);
        let mut max = self.f("arith.maximumf", &[ar, ai], fmf);
        let mut min = self.f("arith.minimumf", &[ar, ai], fmf);
        let f2 = fmf.without_nan_inf();
        let ratio = min / max;
        let mut sq1 = ratio * ratio + one;
        if fun == AbsFn::Rsqrt {
            sq1 = self.m("rsqrt", sq1, f2);
            min = self.m("rsqrt", min, f2);
            max = self.m("rsqrt", max, f2);
        }
        let result = if fun == AbsFn::Sqrt {
            let quarter = 0.25;
            let s = self.m("sqrt", max, f2);
            let p = self.f("math.powf", &[sq1, quarter], f2);
            s * p
        } else {
            let s = self.m("sqrt", sq1, f2);
            max * s
        };
        let nan = self.cmp(P::uno, result, result, f2);
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

    /// `convertDivToStandardUsingAlgebraic` (and its LLVM twin).
    #[ops(self, fmf = f)]
    fn div_algebraic(&mut self, lr: ValueId, li: ValueId, rr: ValueId, ri: ValueId, f: Fmf) -> (ValueId, ValueId) {
        let norm = rr * rr + ri * ri;
        let rnum = lr * rr + li * ri;
        let inum = li * rr - lr * ri;
        (rnum / norm, inum / norm)
    }

    /// `convertDivToStandardUsingRangeReduction` (and its LLVM twin).
    #[ops(self, fmf = f)]
    fn div_range_reduction(&mut self, lr: ValueId, li: ValueId, rr: ValueId, ri: ValueId, f: Fmf) -> (ValueId, ValueId) {
        let n = Fmf::NONE;
        let ratio1 = rr / ri;
        let denom1 = ri + ratio1 * rr;
        let r1 = (lr * ratio1 + li) / denom1;
        let i1 = (li * ratio1 - lr) / denom1;
        let ratio2 = ri / rr;
        let denom2 = rr + ratio2 * ri;
        let r2 = (lr + li * ratio2) / denom2;
        let i2 = (li - lr * ratio2) / denom2;
        let zero = 0.0;
        let rra = self.m("absf", rr, f);
        let rrz = self.cmp(P::oeq, rra, zero, n);
        let ria = self.m("absf", ri, f);
        let riz = self.cmp(P::oeq, ria, zero, n);
        let lrn = self.cmp(P::ord, lr, zero, n);
        let lin = self.cmp(P::ord, li, zero, n);
        let is_inf = (lrn | lin) & (rrz & riz);
        let inf = self.inf(false);
        let infs = self.f("math.copysign", &[inf, rr], n);
        let infr = infs * lr;
        let infi = infs * li;
        let rrf = self.cmp(P::one, rra, inf, n);
        let rif = self.cmp(P::one, ria, inf, n);
        let rf = rrf & rif;
        let lra = self.m("absf", lr, f);
        let lri = self.cmp(P::oeq, lra, inf, n);
        let lia = self.m("absf", li, f);
        let lii = self.cmp(P::oeq, lia, inf, n);
        let inf_fin = (lri | lii) & rf;
        let one = 1.0;
        let s = self.select(lri, one, zero);
        let lris = self.f("math.copysign", &[s, lr], n);
        let s = self.select(lii, one, zero);
        let liis = self.f("math.copysign", &[s, li], n);
        let r3 = inf * (lris * rr + liis * ri);
        let a = lris * ri;
        let i3 = inf * (liis * rr - a);
        let lrf = self.cmp(P::one, lra, inf, n);
        let lif = self.cmp(P::one, lia, inf, n);
        let lf = lrf & lif;
        let rri = self.cmp(P::oeq, rra, inf, n);
        let rii = self.cmp(P::oeq, ria, inf, n);
        let fin_inf = lf & (rri | rii);
        let s = self.select(rri, one, zero);
        let rris = self.f("math.copysign", &[s, rr], n);
        let s = self.select(rii, one, zero);
        let riis = self.f("math.copysign", &[s, ri], n);
        let r4 = zero * (lr * rris + li * riis);
        let i4 = zero * (li * rris - lr * riis);
        let smaller = self.cmp(P::olt, rra, ria, n);
        let r5 = self.select(smaller, r1, r2);
        let i5 = self.select(smaller, i1, i2);
        let rs3 = self.select(fin_inf, r4, r5);
        let is3 = self.select(fin_inf, i4, i5);
        let rs2 = self.select(inf_fin, r3, rs3);
        let is2 = self.select(inf_fin, i3, is3);
        let rs1 = self.select(is_inf, infr, rs2);
        let is1 = self.select(is_inf, infi, is2);
        let rn = self.cmp(P::uno, r5, zero, n);
        let inn = self.cmp(P::uno, i5, zero, n);
        let both = rn & inn;
        (self.select(both, rs1, r5), self.select(both, is1, i5))
    }

    fn neg(&mut self, x: ValueId, f: Fmf) -> ValueId {
        self.f("arith.negf", &[x], f)
    }

    fn xor(&mut self, a: ValueId, b: ValueId) -> ValueId {
        self.bit(if self.llvm { "llvm.xor" } else { "arith.xori" }, a, b)
    }

    /// `TrigonometricOpConversion`: `cos` or `sin` of `x`.
    #[ops(self, fmf = fmf)]
    fn trig(&mut self, x: ValueId, fmf: Fmf, cos_op: bool) -> ValueId {
        let (re, im) = (self.re(x), self.im(x));
        let half = 0.5;
        let e = self.m("exp", im, fmf);
        let se = half * e;
        let re_e = half / e;
        let sin = self.m("sin", re, fmf);
        let cos = self.m("cos", re, fmf);
        let (r, i) = if cos_op {
            let r = (re_e + se) * cos;
            let i = (re_e - se) * sin;
            (r, i)
        } else {
            let r = (se + re_e) * sin;
            let i = (se - re_e) * cos;
            (r, i)
        };
        self.create(r, i)
    }

    /// `TanTanhOpConversion`: `tan` (through `tanh` of `i x`) or `tanh` of `x`.
    #[ops(self, fmf = fmf)]
    fn tan_tanh(&mut self, x: ValueId, fmf: Fmf, tan: bool) -> ValueId {
        let (mut re, mut im) = (self.re(x), self.im(x));
        let neg_one = -1.0;
        if tan {
            core::mem::swap(&mut re, &mut im);
            re = re * neg_one;
        }
        let inf = self.inf(false);
        let four = 4.0;
        let two_re = re + re;
        let neg_two_re = neg_one * two_re;
        let e1 = self.m("expm1", two_re, fmf);
        let e2 = self.m("expm1", neg_two_re, fmf);
        let rnum = e1 - e2;
        let ci = self.m("cos", im, fmf);
        let two_cos = ci * ci * four;
        let si = self.m("sin", im, fmf);
        let inum = four * (ci * si);
        let esum = e1 + e2;
        let denom = esum + two_cos;
        let is_inf = self.cmp(P::oeq, esum, inf, fmf);
        let limit = self.f("math.copysign", &[neg_one, re], fmf);
        let t = rnum / denom;
        let mut r = self.select(is_inf, limit, t);
        let mut i = inum / denom;
        if !fmf.finite() {
            let ar = self.m("absf", re, fmf);
            let zero = 0.0;
            let nan = self.nan();
            let ari = self.cmp(P::oeq, ar, inf, fmf);
            let iz = self.cmp(P::oeq, im, zero, fmf);
            let t = self.mk(OpData::build("arith.constant").with("value", Attribute::Bool(true)), Type::int(1));
            let arni = ari ^ t;
            let inn = self.cmp(P::uno, inum, inum, fmf);
            let rnan = inn & arni;
            let izero = iz | (ari & inn);
            r = self.select(rnan, nan, r);
            i = self.select(izero, zero, i);
        }
        if tan {
            core::mem::swap(&mut r, &mut i);
            i = i * neg_one;
        }
        self.create(r, i)
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
        let abs0 = self.cmp(P::oeq, abs, zero, fmf);
        let d0 = self.cmp(P::oeq, d, zero, fmf);
        let c0 = self.cmp(P::oeq, c, zero, fmf);
        let b0 = self.cmp(P::oeq, b, zero, fmf);
        let zle = self.cmp(P::ole, zero, c, fmf);
        let ccos = self.mul(coeff, cq, fmf);
        let csin = self.mul(coeff, sq, fmf);
        let one_or_zero = self.select(c0, c_one, c_zero);
        let cs = self.create(ccos, csin);
        let t = self.and(abs0, d0);
        let t = self.and(t, zle);
        let cut0 = self.select(t, one_or_zero, cs);
        let rhs0 = self.and(c0, d0);
        let cut1 = self.select(rhs0, c_one, cut0);
        let t = self.cmp(P::oeq, a, one, fmf);
        let lhs1 = self.and(t, b0);
        let cut2 = self.select(lhs1, c_one, cut1);
        let t = self.cmp(P::oeq, a, inf, fmf);
        let lhs_inf = self.and(t, b0);
        let t = self.cmp(P::ogt, c, zero, fmf);
        let gt0 = self.and(d0, t);
        let t = self.and(lhs_inf, gt0);
        let cut3 = self.select(t, c_inf, cut2);
        let t = self.cmp(P::olt, c, zero, fmf);
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

#[patterns(improved: bool, builder = Self::cx)]
impl ComplexToStd {
    /// The builder over the complex type of the first operand.
    fn cx<'c, 'r, 'a, 'p>(cr: &'c mut Cr<'r, 'a, 'p>, op: OpId) -> Cx<'c, 'r, 'a, 'p> {
        let ty = cr.rw.body[cr.rw.body[op].operands[0]].ty.clone();
        Cx::new(cr, ty)
    }

    #[lowering("complex.abs")]
    fn abs(b: &mut Cx<'_, '_, '_, '_>, x: ValueId, fmf: Fmf) -> ValueId {
        let (re, im) = (b.re(x), b.im(x));
        b.abs(re, im, fmf, AbsFn::Abs)
    }

    #[lowering("complex.angle")]
    fn angle(b: &mut Cx<'_, '_, '_, '_>, x: ValueId, fmf: Fmf) -> ValueId {
        let (re, im) = (b.re(x), b.im(x));
        b.f("math.atan2", &[im, re], fmf)
    }

    #[lowering("complex.atan2")]
    fn atan2(b: &mut Cx<'_, '_, '_, '_>, lhs: ValueId, rhs: ValueId, fmf: Fmf) -> ValueId {
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
        b.c("complex.mul", &[ni, l], fmf)
    }

    #[lowering("complex.add")]
    #[ops(b, fmf = fmf)]
    fn add(b: &mut Cx<'_, '_, '_, '_>, l: ValueId, r: ValueId, fmf: Fmf) -> ValueId {
        let re = b.re(l) + b.re(r);
        let im = b.im(l) + b.im(r);
        b.create(re, im)
    }

    #[lowering("complex.sub")]
    #[ops(b, fmf = fmf)]
    fn sub(b: &mut Cx<'_, '_, '_, '_>, l: ValueId, r: ValueId, fmf: Fmf) -> ValueId {
        let re = b.re(l) - b.re(r);
        let im = b.im(l) - b.im(r);
        b.create(re, im)
    }

    #[lowering("complex.eq")]
    #[ops(b)]
    fn eq(b: &mut Cx<'_, '_, '_, '_>, l: ValueId, r: ValueId) -> ValueId {
        let (lr, li, rr, ri) = (b.re(l), b.im(l), b.re(r), b.im(r));
        b.cmp(P::oeq, lr, rr, Fmf::NONE) & b.cmp(P::oeq, li, ri, Fmf::NONE)
    }

    #[lowering("complex.neq")]
    #[ops(b)]
    fn neq(b: &mut Cx<'_, '_, '_, '_>, l: ValueId, r: ValueId) -> ValueId {
        let (lr, li, rr, ri) = (b.re(l), b.im(l), b.re(r), b.im(r));
        b.cmp(P::une, lr, rr, Fmf::NONE) | b.cmp(P::une, li, ri, Fmf::NONE)
    }

    #[lowering("complex.conj")]
    #[ops(b, fmf = Fmf::NONE)]
    fn conj(b: &mut Cx<'_, '_, '_, '_>, x: ValueId) -> ValueId {
        let (re, im) = (b.re(x), b.im(x));
        let ni = -im;
        b.create(re, ni)
    }

    /// `TrigonometricOpConversion`.
    #[lowering("complex.cos")]
    fn cos(b: &mut Cx<'_, '_, '_, '_>, x: ValueId, fmf: Fmf) -> ValueId {
        b.trig(x, fmf, true)
    }

    /// `TrigonometricOpConversion`.
    #[lowering("complex.sin")]
    fn sin(b: &mut Cx<'_, '_, '_, '_>, x: ValueId, fmf: Fmf) -> ValueId {
        b.trig(x, fmf, false)
    }

    #[lowering("complex.exp")]
    #[ops(b, fmf = fmf)]
    fn exp(b: &mut Cx<'_, '_, '_, '_>, z: ValueId, fmf: Fmf) -> ValueId {
        let (x, y) = (b.re(z), b.im(z));
        let zero = 0.0;
        let half = 0.5;
        let inf = b.inf(false);
        let exp = b.m("exp", x, fmf);
        let eh = b.m("exp", x * half, fmf);
        let cos = b.m("cos", y, fmf);
        let sin = b.m("sin", y, fmf);
        let ei = b.cmp(P::oeq, exp, inf, fmf);
        let yz = b.cmp(P::oeq, y, zero, Fmf::NONE);
        let rn = exp * cos;
        let ro = eh * cos * eh;
        let r = b.select(ei, ro, rn);
        let in_ = exp * sin;
        let io = eh * sin * eh;
        let inz = b.select(ei, io, in_);
        let i = b.select(yz, zero, inz);
        b.create(r, i)
    }

    #[lowering("complex.expm1")]
    #[ops(b, fmf = fmf)]
    fn expm1(b: &mut Cx<'_, '_, '_, '_>, x: ValueId, fmf: Fmf) -> ValueId {
        let (re, im) = (b.re(x), b.im(x));
        let zero = 0.0;
        let one = 1.0;
        let em1 = b.m("expm1", re, fmf);
        let er = em1 + one;
        let si = b.m("sin", im, fmf);
        // `emitCosm1`.
        let neg_half = -0.5;
        let neg_one = -1.0;
        const K: [f64; 7] = [4.7377507964246204691685E-14, -1.1470284843425359765671E-11, 2.0876754287081521758361E-9, -2.7557319214999787979814E-7, 2.4801587301570552304991E-5, -1.3888888888888872993737E-3, 4.1666666666666666609054E-2];
        let cos = b.m("cos", im, fmf);
        let large = cos + neg_one;
        let p2 = im * im;
        let p4 = p2 * p2;
        let poly = b.poly(p2, &K, fmf);
        let a = p4 * poly;
        let c = neg_half * p2;
        let small = fm(Fmf::NONE, a + c);
        let pi4 = 0.61685;
        let cond = b.cmp(P::oge, p2, pi4, fmf);
        let cm1 = b.select(cond, large, small);
        let ci = cm1 + one;
        let r = em1 * ci + cm1;
        let iz = b.cmp(P::oeq, im, zero, fmf);
        let t = er * si;
        let i = b.select(iz, zero, t);
        b.create(r, i)
    }

    #[lowering("complex.log")]
    fn log(b: &mut Cx<'_, '_, '_, '_>, x: ValueId, fmf: Fmf) -> ValueId {
        let et = b.et.clone();
        let abs = b.mk(OpData::build("complex.abs").operands(&[x]).with("fastmath", fmf.attr()), et);
        let r = b.m("log", abs, fmf);
        let (re, im) = (b.re(x), b.im(x));
        let i = b.f("math.atan2", &[im, re], fmf);
        b.create(r, i)
    }

    #[lowering("complex.log1p")]
    #[ops(b, fmf = fmf)]
    fn log1p(b: &mut Cx<'_, '_, '_, '_>, x: ValueId, fmf: Fmf) -> ValueId {
        let (re, im) = (b.re(x), b.im(x));
        let half = 0.5;
        let one = 1.0;
        let rp1 = re + one;
        let arp1 = b.m("absf", rp1, fmf);
        let ai = b.m("absf", im, fmf);
        let max = b.f("arith.maximumf", &[arp1, ai], fmf);
        let min = b.f("arith.minimumf", &[arp1, ai], fmf);
        let use_re = b.cmp(P::ogt, rp1, ai, fmf);
        let mm1 = max - one;
        let m = b.select(use_re, re, mm1);
        let f2 = fmf.without_nan_inf();
        let ratio = fm(f2, min / max);
        let lm = b.m("log1p", m, fmf);
        let ls = b.m("log1p", fm(f2, ratio * ratio), f2);
        let r = fm(f2, half * ls + lm);
        let nan = b.cmp(P::uno, r, r, f2);
        let rr = b.select(nan, min, r);
        let i = b.f("math.atan2", &[im, rp1], fmf);
        b.create(rr, i)
    }

    #[lowering("complex.mul")]
    #[ops(b, fmf = fmf)]
    fn mul(b: &mut Cx<'_, '_, '_, '_>, l: ValueId, r: ValueId, fmf: Fmf) -> ValueId {
        let (lr, li, rr, ri) = (b.re(l), b.im(l), b.re(r), b.im(r));
        let re = lr * rr - li * ri;
        let im = li * rr + lr * ri;
        b.create(re, im)
    }

    #[lowering("complex.neg")]
    #[ops(b, fmf = Fmf::NONE)]
    fn neg(b: &mut Cx<'_, '_, '_, '_>, x: ValueId) -> ValueId {
        let (re, im) = (b.re(x), b.im(x));
        let (nr, ni) = (-re, -im);
        b.create(nr, ni)
    }

    #[lowering("complex.sign")]
    #[ops(b, fmf = fmf)]
    fn sign(b: &mut Cx<'_, '_, '_, '_>, x: ValueId, fmf: Fmf) -> ValueId {
        let (re, im) = (b.re(x), b.im(x));
        let zero = 0.0;
        let z = b.cmp(P::oeq, re, zero, Fmf::NONE) & b.cmp(P::oeq, im, zero, Fmf::NONE);
        let et = b.et.clone();
        let abs = b.mk(OpData::build("complex.abs").operands(&[x]).with("fastmath", fmf.attr()), et);
        let (rs, is) = (re / abs, im / abs);
        let s = b.create(rs, is);
        b.select(z, x, s)
    }

    #[lowering("complex.sqrt")]
    #[ops(b, fmf = fmf)]
    fn sqrt(b: &mut Cx<'_, '_, '_, '_>, x: ValueId, fmf: Fmf) -> ValueId {
        let zero = 0.0;
        let half = 0.5;
        let (re, im) = (b.re(x), b.im(x));
        let abs = b.abs(re, im, fmf, AbsFn::Sqrt);
        let arg = b.f("math.atan2", &[im, re], fmf);
        let sa = arg * half;
        let cos = b.m("cos", sa, fmf);
        let sin = b.m("sin", sa, fmf);
        let sz = b.cmp(P::oeq, sin, zero, fmf);
        let mut r = abs * cos;
        let t = abs * sin;
        let mut i = b.select(sz, zero, t);
        if !fmf.finite() {
            let inf = b.inf(false);
            let ninf = b.inf(true);
            let nan = b.nan();
            let ai = b.m("absf", im, fmf);
            let aii = b.cmp(P::oeq, ai, inf, fmf);
            let ain = b.cmp(P::one, ai, inf, fmf);
            let ri = b.cmp(P::oeq, re, inf, fmf);
            let rni = b.cmp(P::oeq, re, ninf, fmf);
            r = b.select(rni & ain, zero, r);
            r = b.select(aii | ri, inf, r);
            let isi = b.f("math.copysign", &[inf, im], fmf);
            let t = b.cmp(P::uno, abs, abs, Fmf::NONE);
            i = b.select(t, nan, i);
            i = b.select(aii | rni, isi, i);
        }
        let z = b.cmp(P::oeq, abs, zero, fmf);
        r = b.select(z, zero, r);
        i = b.select(z, zero, i);
        b.create(r, i)
    }

    /// `TanTanhOpConversion`.
    #[lowering("complex.tan")]
    fn tan(b: &mut Cx<'_, '_, '_, '_>, x: ValueId, fmf: Fmf) -> ValueId {
        b.tan_tanh(x, fmf, true)
    }

    /// `TanTanhOpConversion`.
    #[lowering("complex.tanh")]
    fn tanh(b: &mut Cx<'_, '_, '_, '_>, x: ValueId, fmf: Fmf) -> ValueId {
        b.tan_tanh(x, fmf, false)
    }

    #[lowering("complex.powi")]
    fn powi(b: &mut Cx<'_, '_, '_, '_>, x: ValueId, e: ValueId, fmf: Fmf) -> ValueId {
        let et = b.et.clone();
        let fe = b.mk(OpData::build("arith.sitofp").operands(&[e]), et);
        let zero = b.cst(0.0);
        let ce = b.create(fe, zero);
        b.c("complex.pow", &[x, ce], fmf)
    }

    #[lowering("complex.pow")]
    fn pow(b: &mut Cx<'_, '_, '_, '_>, x: ValueId, y: ValueId, fmf: Fmf) -> ValueId {
        let (c, d) = (b.re(y), b.im(y));
        b.pow(x, c, d, fmf)
    }

    #[lowering("complex.rsqrt")]
    #[ops(b, fmf = fmf)]
    fn rsqrt(b: &mut Cx<'_, '_, '_, '_>, x: ValueId, fmf: Fmf) -> ValueId {
        let zero = 0.0;
        let inf = b.inf(false);
        let neg_half = -0.5;
        let nan = b.nan();
        let (re, im) = (b.re(x), b.im(x));
        let abs = b.abs(re, im, fmf, AbsFn::Rsqrt);
        let arg = b.f("math.atan2", &[im, re], fmf);
        let ra = arg * neg_half;
        let cos = b.m("cos", ra, fmf);
        let sin = b.m("sin", ra, fmf);
        let mut r = abs * cos;
        let mut i = abs * sin;
        if !fmf.finite() {
            let neg_one = -1.0;
            let rsz = b.f("math.copysign", &[zero, re], fmf);
            let isz = b.f("math.copysign", &[zero, im], fmf);
            let nisz = neg_one * isz;
            let ar = b.m("absf", re, fmf);
            let ai = b.m("absf", im, fmf);
            let aii = b.cmp(P::oeq, ai, inf, fmf);
            let rn = b.cmp(P::uno, re, re, fmf);
            let ri = b.cmp(P::oeq, ar, inf, fmf);
            let z = aii & rn | ri;
            r = b.select(z, rsz, r);
            i = b.select(z, nisz, i);
        }
        let z = b.cmp(P::oeq, re, zero, fmf) & b.cmp(P::oeq, im, zero, fmf);
        r = b.select(z, inf, r);
        i = b.select(z, nan, i);
        b.create(r, i)
    }

    /// `DivOpConversion` with `complex-range=improved`.
    #[lowering("complex.div", when = improved)]
    fn div_improved(b: &mut Cx<'_, '_, '_, '_>, l: ValueId, r: ValueId, fmf: Fmf) -> ValueId {
        let (lr, li, rr, ri) = (b.re(l), b.im(l), b.re(r), b.im(r));
        let (re, im) = b.div_range_reduction(lr, li, rr, ri, fmf);
        b.create(re, im)
    }

    /// `DivOpConversion` with `complex-range=basic` or `none`.
    #[lowering("complex.div", when = !improved)]
    fn div_basic(b: &mut Cx<'_, '_, '_, '_>, l: ValueId, r: ValueId, fmf: Fmf) -> ValueId {
        let (lr, li, rr, ri) = (b.re(l), b.im(l), b.re(r), b.im(r));
        let (re, im) = b.div_algebraic(lr, li, rr, ri, fmf);
        b.create(re, im)
    }
}

impl FromOp for Fmf {
    fn from_op(cr: &ConversionRewriter<'_, '_, '_>, op: OpId) -> Self {
        Fmf::of(cr, op)
    }
}

/// `complex` ⇒ `llvm`, as `ComplexToLLVM.cpp`.
pub struct ComplexToLlvm;

#[patterns(converter, improved: bool)]
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

    #[lowering("complex.abs")]
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

    #[lowering("complex.constant")]
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

    #[lowering("complex.create")]
    fn create(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let Some((mut b, st)) = Self::begin(cr, op) else { return false };
        let v = b.pack(st, o[0][0], o[1][0]);
        cr.replace_values(op, &[v]);
        true
    }

    #[lowering("complex.im", "complex.re")]
    fn part(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let ct = cr.rw.body[cr.rw.body[op].operands[0]].ty.clone();
        let i = i64::from(cr.rw.body[op].name == "complex.im");
        let mut b = Cx::new(cr, ct);
        let v = b.field(o[0][0], i);
        cr.replace_values(op, &[v]);
        true
    }

    #[lowering("complex.add", "complex.mul", "complex.sub")]
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

    #[lowering("complex.div", when = improved)]
    fn div_improved(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        Self::div(cr, op, o, true)
    }

    #[lowering("complex.div", when = !improved)]
    fn div_basic(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        Self::div(cr, op, o, false)
    }

}
