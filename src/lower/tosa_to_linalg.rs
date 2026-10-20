//! `tosa-to-linalg`, as `TosaToLinalg.cpp`: elementwise ops as `linalg.generic` (with dynamic
//! broadcasting), reductions as `linalg.reduce`, and the data-movement ops.

use alloc::collections::BTreeMap;
use alloc::vec;
use alloc::vec::Vec;

use mlirpass_macros::patterns;
use mlirformat::{Attribute, FloatKind, Signedness, Type};

use super::linalg_build::{Named, dims_of, int_attr};
use super::tosa_to_tensor::TosaToTensor;
use crate::canon::MemrefOfr as Ofr;
use crate::{AffineExpr, AffineMap, ApFloat, Const, ConversionRewriter, DYNAMIC, OpData, OpId, Scalar, ValueId};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

/// `IndexPool`: index constants by value, created once.
type Pool = BTreeMap<i64, ValueId>;

fn elem<'a>(t: &Type<'a>) -> Type<'a> {
    t.element_type().clone()
}

fn float<'a>(v: f64, ty: &Type<'a>) -> Attribute<'a> {
    let Type::Float(k) = ty else { return int_attr(v as i128, ty) };
    Const::scalar(Scalar::Float(ApFloat::from_f64(*k, v).expect("a float")), ty.clone()).into()
}

fn ap<'a>(v: ApFloat, ty: &Type<'a>) -> Attribute<'a> {
    Const::scalar(Scalar::Float(v), ty.clone()).into()
}

fn width(t: &Type<'_>) -> u32 {
    t.bit_width().unwrap_or(0)
}

fn smin(w: u32) -> i128 {
    -(1i128 << (w - 1))
}

fn smax(w: u32) -> i128 {
    (1i128 << (w - 1)) - 1
}

/// `arith.cmpf` / `arith.cmpi` predicates by name.
fn cmpf(cr: &mut Cr<'_, '_, '_>, pred: i64, a: ValueId, b: ValueId) -> ValueId {
    cr.build(OpData::build("arith.cmpf").operands(&[a, b]).with("predicate", Attribute::i64(pred)), Type::int(1))
}

fn cmpi(cr: &mut Cr<'_, '_, '_>, pred: i64, a: ValueId, b: ValueId) -> ValueId {
    cr.build(OpData::build("arith.cmpi").operands(&[a, b]).with("predicate", Attribute::i64(pred)), Type::int(1))
}

const UNO: i64 = 14;

/// The tosa ⇒ linalg patterns.
pub struct TosaToLinalg;

#[patterns(converter)]
impl TosaToLinalg {
    fn ty<'a>(cr: &Cr<'_, 'a, '_>, v: ValueId) -> Type<'a> {
        cr.rw.body[v].ty.clone()
    }

    /// `getZeroPoint` of operand `i` of `op` (`None` when not constant).
    fn zp(cr: &Cr<'_, '_, '_>, op: OpId, i: usize) -> Option<i64> {
        let v = *cr.rw.body[op].operands.get(i)?;
        let c = Const::try_from(&cr.rw.body.constant_of(v)?).ok()?;
        match c.at(0) {
            Scalar::Float(f) => Some(if f.is_zero() { 0 } else { -1 }),
            Scalar::Int(i) => Some(i.signed() as i64),
        }
    }

    fn nan_ignore(cr: &Cr<'_, '_, '_>, op: OpId) -> bool {
        matches!(cr.rw.body[op].get("nan_mode"), Some(Attribute::Extended { ext, .. }) if ext.body.as_deref().is_some_and(|b| b.contains("IGNORE")))
    }

    /// `materializeBinaryNanCheckIfRequired`.
    fn nan_check(cr: &mut Cr<'_, '_, '_>, op: OpId, l: ValueId, r: ValueId, res: ValueId) -> ValueId {
        if !matches!(Self::ty(cr, l), Type::Float(_)) || !Self::nan_ignore(cr, op) {
            return res;
        }
        let ln = cmpf(cr, UNO, l, l);
        let rn = cmpf(cr, UNO, r, r);
        let ty = Self::ty(cr, res);
        let x = cr.op1("arith.select", &[ln, r, res], ty.clone());
        cr.op1("arith.select", &[rn, l, x], ty)
    }

    /// `clampIntHelper`.
    fn clamp_int(cr: &mut Cr<'_, '_, '_>, v: ValueId, min: ValueId, max: ValueId, unsigned: bool) -> ValueId {
        let (mx, mn) = if unsigned { ("arith.maxui", "arith.minui") } else { ("arith.maxsi", "arith.minsi") };
        let a = cr.bin(mx, min, v);
        cr.bin(mn, max, a)
    }

    /// `clampFloatHelper`.
    fn clamp_float(cr: &mut Cr<'_, '_, '_>, v: ValueId, min: ValueId, max: ValueId) -> ValueId {
        let a = cr.bin("arith.minimumf", v, max);
        cr.bin("arith.maximumf", a, min)
    }

    /// The scalar attribute `name` of `op` as `f64` / integer.
    fn attr_f64(cr: &Cr<'_, '_, '_>, op: OpId, name: &str) -> Option<ApFloat> {
        match Const::try_from(cr.rw.body[op].get(name)?).ok()?.values[0] {
            Scalar::Float(f) => Some(f),
            Scalar::Int(_) => None,
        }
    }

    fn attr_int(cr: &Cr<'_, '_, '_>, op: OpId, name: &str) -> Option<i128> {
        Const::try_from(cr.rw.body[op].get(name)?).ok()?.as_int().map(|i| i.signed())
    }

    /// `createLinalgBodyCalculationForElementwiseOp`.
    fn elementwise_body<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, args: &[ValueId], rt: &Type<'a>) -> Option<ValueId> {
        let b = &*cr.rw.body;
        let name = b[op].name.clone();
        let et = elem(&b[b[op].operands[0]].ty);
        let is_f = matches!(et, Type::Float(_));
        let is_i = matches!(et, Type::Integer { .. });
        let signless = matches!(et, Type::Integer { signedness: Signedness::Signless, .. });
        let i1 = et == Type::int(1);
        let round = matches!(b[op].get("round"), Some(Attribute::Bool(true) | Attribute::Unit));
        let unary_math = |n: &str| -> Option<&'static str> {
            Some(match n {
                "tosa.pow" => "math.powf",
                "tosa.rsqrt" => "math.rsqrt",
                "tosa.log" => "math.log",
                "tosa.exp" => "math.exp",
                "tosa.sin" => "math.sin",
                "tosa.cos" => "math.cos",
                "tosa.tanh" => "math.tanh",
                "tosa.erf" => "math.erf",
                "tosa.ceil" => "math.ceil",
                "tosa.floor" => "math.floor",
                _ => return None,
            })
        };
        let rt = rt.clone();
        Some(match (&*name, is_f, is_i) {
            ("tosa.abs", true, _) => cr.op1("math.absf", args, rt),
            ("tosa.abs", _, true) => {
                let z = cr.constant(int_attr(0, &et), et.clone());
                let n = cr.bin("arith.subi", z, args[0]);
                cr.bin("arith.maxsi", args[0], n)
            }
            ("tosa.add", true, _) => cr.op1("arith.addf", args, rt),
            ("tosa.add", _, true) => cr.op1("arith.addi", args, rt),
            ("tosa.sub", true, _) => cr.op1("arith.subf", args, rt),
            ("tosa.sub", _, true) => cr.op1("arith.subi", args, rt),
            ("tosa.intdiv", _, true) => cr.op1("arith.divsi", args, rt),
            ("tosa.reciprocal", true, _) => {
                let one = cr.constant(float(1.0, &et), et.clone());
                cr.op1("arith.divf", &[one, args[0]], rt)
            }
            ("tosa.mul", ..) => {
                let shift_v = b[op].operands[2];
                let sc = b.constant_of(shift_v).and_then(|a| Const::try_from(&a).ok());
                let constant = sc.is_some();
                let shift = sc.and_then(|c| c.at(0).int()).map_or(0, |i| i.signed() as i64);
                if is_f {
                    if shift != 0 {
                        return None;
                    }
                    return Some(cr.op1("arith.mulf", &args[..2], rt));
                }
                if !is_i {
                    return None;
                }
                let (mut a, mut bb) = (args[0], args[1]);
                if shift > 0 || !constant {
                    let sconst = constant.then(|| cr.constant(int_attr(i128::from(shift), &Type::int(8)), Type::int(8)));
                    let i32t = Type::int(32);
                    if Self::ty(cr, a) != i32t {
                        a = cr.op1("arith.extsi", &[a], i32t.clone());
                    }
                    if Self::ty(cr, bb) != i32t {
                        bb = cr.op1("arith.extsi", &[bb], i32t.clone());
                    }
                    let s = sconst.unwrap_or(args[2]);
                    let r = Attribute::dialect("tosa.rounding_mode", "<SINGLE_ROUND>");
                    return Some(cr.build(OpData::build("tosa.apply_scale").operands(&[a, bb, s]).with("rounding_mode", r), i32t));
                }
                let cw = width(&rt);
                if width(&Self::ty(cr, a)) < cw {
                    a = cr.op1("arith.extsi", &[a], rt.clone());
                }
                if width(&Self::ty(cr, bb)) < cw {
                    bb = cr.op1("arith.extsi", &[bb], rt.clone());
                }
                cr.op1("arith.muli", &[a, bb], rt)
            }
            ("tosa.negate", ..) => {
                let (izp, ozp) = (Self::zp(cr, op, 1), Self::zp(cr, op, 2));
                if is_f {
                    return Some(cr.op1("arith.negf", &args[..1], rt));
                }
                if !is_i {
                    return None;
                }
                let iw = width(&et);
                let (it, zp_add) = match (izp, ozp) {
                    (Some(i), Some(o)) => {
                        let add = i + o;
                        let maxv = smax(iw) + i128::from(add.abs()) + 1;
                        let w = if maxv <= smax(16) { 16 } else if maxv <= smax(32) { 32 } else { 64 };
                        let t = Type::int(w);
                        (t.clone(), cr.constant(int_attr(i128::from(add), &t), t))
                    }
                    _ => {
                        let t = Type::int(64);
                        let (mut a1, mut a2) = (args[1], args[2]);
                        if Self::ty(cr, a1) != t {
                            a1 = cr.op1("arith.extsi", &[a1], t.clone());
                        }
                        if Self::ty(cr, a2) != t {
                            a2 = cr.op1("arith.extsi", &[a2], t.clone());
                        }
                        (t.clone(), cr.op1("arith.addi", &[a1, a2], t))
                    }
                };
                let mut ext = args[0];
                if Self::ty(cr, ext) != it {
                    ext = cr.op1("arith.extsi", &[ext], it.clone());
                }
                let sub = cr.bin("arith.subi", zp_add, ext);
                let mn = cr.constant(int_attr(smin(iw), &it), it.clone());
                let mx = cr.constant(int_attr(smax(iw), &it), it.clone());
                let c = Self::clamp_int(cr, sub, mn, mx, false);
                if it == et { c } else { cr.op1("arith.trunci", &[c], et.clone()) }
            }
            ("tosa.bitwise_and", _, true) => cr.op1("arith.andi", args, rt),
            ("tosa.bitwise_or", _, true) => cr.op1("arith.ori", args, rt),
            ("tosa.bitwise_not", _, true) => {
                let ones = cr.constant(int_attr(-1, &et), et.clone());
                cr.op1("arith.xori", &[args[0], ones], rt)
            }
            ("tosa.bitwise_xor", _, true) => cr.op1("arith.xori", args, rt),
            ("tosa.logical_left_shift", _, true) => cr.op1("arith.shli", args, rt),
            ("tosa.logical_right_shift", _, true) => cr.op1("arith.shrui", args, rt),
            ("tosa.arithmetic_right_shift", _, true) => {
                let result = cr.op1("arith.shrsi", args, rt.clone());
                if !round {
                    return Some(result);
                }
                let i1t = Type::int(1);
                let one = cr.constant(int_attr(1, &et), et.clone());
                let zero = cr.constant(int_attr(0, &et), et.clone());
                let i1z = cr.constant(int_attr(0, &i1t), i1t.clone());
                let i1o = cr.constant(int_attr(1, &i1t), i1t.clone());
                let gt = cmpi(cr, 4, args[1], zero);
                let sub = cr.op1("arith.subi", &[args[1], one], rt.clone());
                let sh = cr.op1("arith.shrsi", &[args[0], sub], rt.clone());
                let tr = cr.op1("arith.trunci", &[sh], i1t.clone());
                let odd = cr.op1("arith.andi", &[tr, i1o], i1t.clone());
                let should = cr.op1("arith.select", &[gt, odd, i1z], i1t);
                let ext = cr.op1("arith.extui", &[should], rt.clone());
                cr.op1("arith.addi", &[result, ext], rt)
            }
            ("tosa.clz", _, true) => cr.op1("math.ctlz", &args[..1], et.clone()),
            ("tosa.logical_and", ..) if i1 => cr.op1("arith.andi", args, rt),
            ("tosa.logical_not", ..) if i1 => {
                let one = cr.constant(int_attr(1, &et), et.clone());
                cr.op1("arith.xori", &[args[0], one], rt)
            }
            ("tosa.logical_or", ..) if i1 => cr.op1("arith.ori", args, rt),
            ("tosa.logical_xor", ..) if i1 => cr.op1("arith.xori", args, rt),
            (n, true, _) if unary_math(n).is_some() => cr.op1(unary_math(n).expect("math op"), args, rt),
            ("tosa.greater", true, _) => cmpf(cr, 2, args[0], args[1]),
            ("tosa.greater", ..) if signless => cmpi(cr, 4, args[0], args[1]),
            ("tosa.greater_equal", true, _) => cmpf(cr, 3, args[0], args[1]),
            ("tosa.greater_equal", ..) if signless => cmpi(cr, 5, args[0], args[1]),
            ("tosa.equal", true, _) => cmpf(cr, 1, args[0], args[1]),
            ("tosa.equal", ..) if signless => cmpi(cr, 0, args[0], args[1]),
            ("tosa.select", ..) => {
                let e1 = elem(&b[b[op].operands[1]].ty);
                if !matches!(e1, Type::Float(_) | Type::Integer { .. }) {
                    return None;
                }
                let ty = Self::ty(cr, args[1]);
                cr.op1("arith.select", &args[..3], ty)
            }
            ("tosa.maximum", true, _) => {
                let m = cr.bin("arith.maximumf", args[0], args[1]);
                Self::nan_check(cr, op, args[0], args[1], m)
            }
            ("tosa.maximum", ..) if signless => cr.bin("arith.maxsi", args[0], args[1]),
            ("tosa.minimum", true, _) => {
                let m = cr.bin("arith.minimumf", args[0], args[1]);
                Self::nan_check(cr, op, args[0], args[1], m)
            }
            ("tosa.minimum", ..) if signless => cr.bin("arith.minsi", args[0], args[1]),
            ("tosa.clamp", true, _) => {
                let Type::Float(k) = et else { return None };
                let (lo, hi) = (Self::attr_f64(cr, op, "min_val")?, Self::attr_f64(cr, op, "max_val")?);
                let conv = |f: ApFloat| if f.kind == k { f } else { ApFloat::from_f64(k, f.to_f64()).expect("a float") };
                let mn = cr.constant(ap(conv(lo), &et), et.clone());
                let mx = cr.constant(ap(conv(hi), &et), et.clone());
                let r = Self::clamp_float(cr, args[0], mn, mx);
                if !Self::nan_ignore(cr, op) {
                    return Some(r);
                }
                let nan = cmpf(cr, UNO, args[0], args[0]);
                cr.op1("arith.select", &[nan, mn, r], et.clone())
            }
            ("tosa.clamp", _, true) => {
                let (mut lo, mut hi) = (Self::attr_int(cr, op, "min_val")?, Self::attr_int(cr, op, "max_val")?);
                let w = width(&et);
                let unsigned = matches!(et, Type::Integer { signedness: Signedness::Unsigned, .. });
                let (rmin, rmax) = if unsigned {
                    (0, if w <= 63 { (1i128 << w) - 1 } else { i128::from(i64::MAX) })
                } else if w <= 64 {
                    (smin(w), smax(w))
                } else {
                    (i128::from(i64::MIN), i128::from(i64::MAX))
                };
                if unsigned {
                    // The attribute holds the unsigned value as written.
                    lo = lo.rem_euclid(1i128 << w);
                    hi = hi.rem_euclid(1i128 << w);
                }
                lo = lo.max(rmin).min(rmax);
                hi = hi.max(rmin).min(rmax);
                let t = Type::int(w);
                let mn = cr.constant(int_attr(lo, &t), t.clone());
                let mx = cr.constant(int_attr(hi, &t), t);
                Self::clamp_int(cr, args[0], mn, mx, unsigned)
            }
            ("tosa.sigmoid", true, _) => {
                let one = cr.constant(float(1.0, &et), et.clone());
                let n = cr.op1("arith.negf", &args[..1], rt.clone());
                let e = cr.op1("math.exp", &[n], rt.clone());
                let a = cr.op1("arith.addf", &[e, one], rt.clone());
                cr.op1("arith.divf", &[one, a], rt)
            }
            ("tosa.cast", ..) => return Self::cast_body(cr, args[0], &et, &rt),
            _ => return None,
        })
    }

    /// The `tosa.cast` body.
    fn cast_body<'a>(cr: &mut Cr<'_, 'a, '_>, arg: ValueId, src: &Type<'a>, dst: &Type<'a>) -> Option<ValueId> {
        let (sf, df) = (matches!(src, Type::Float(_)), matches!(dst, Type::Float(_)));
        let (si, di) = (matches!(src, Type::Integer { .. }), matches!(dst, Type::Integer { .. }));
        if !(sf || si) || !(df || di) {
            return None;
        }
        let extend = width(src) < width(dst);
        let dst = dst.clone();
        if src == &dst {
            return Some(arg);
        }
        let src_i1 = *src == Type::int(1);
        Some(match () {
            _ if sf && df && extend => cr.op1("arith.extf", &[arg], dst),
            _ if sf && df => cr.op1("arith.truncf", &[arg], dst),
            _ if src_i1 && df => cr.op1("arith.uitofp", &[arg], dst),
            _ if src_i1 && di && extend => cr.op1("arith.extui", &[arg], dst),
            _ if matches!(src, Type::Integer { signedness: Signedness::Unsigned, .. }) && df => {
                let c = cr.op1("builtin.unrealized_conversion_cast", &[arg], Type::int(width(src)));
                cr.op1("arith.uitofp", &[c], dst)
            }
            _ if si && df => cr.op1("arith.sitofp", &[arg], dst),
            _ if sf && dst == Type::int(1) => {
                let z = cr.constant(float(0.0, src), src.clone());
                cmpf(cr, 13, arg, z)
            }
            _ if sf && di => {
                let Type::Float(k) = src else { return None };
                let rounded = cr.op1("math.roundeven", &[arg], src.clone());
                let dw = width(&dst);
                let max_exp: i64 = match k {
                    FloatKind::F16 => 15,
                    FloatKind::BF16 | FloatKind::F32 => 127,
                    FloatKind::F64 => 1023,
                    _ => 127,
                };
                if i64::from(dw) - 1 > max_exp {
                    let conv = cr.op1("arith.fptosi", &[rounded], dst.clone());
                    let pinf = cr.constant(float(f64::INFINITY, src), src.clone());
                    let ninf = cr.constant(float(f64::NEG_INFINITY, src), src.clone());
                    let over = cmpf(cr, 8, rounded, pinf);
                    let under = cmpf(cr, 8, rounded, ninf);
                    let imin = cr.constant(int_attr(smin(dw), &dst), dst.clone());
                    let imax = cr.constant(int_attr(smax(dw), &dst), dst.clone());
                    let mc = cr.op1("arith.select", &[over, imax, conv], dst.clone());
                    return Some(cr.op1("arith.select", &[under, imin, mc], dst));
                }
                let mant: u32 = match k {
                    FloatKind::F16 => 11,
                    FloatKind::BF16 => 8,
                    FloatKind::F32 => 24,
                    FloatKind::F64 => 53,
                    _ => 24,
                };
                let imin_fp = cr.constant(float(smin(dw) as f64, src), src.clone());
                if mant >= dw - 1 {
                    let imax_fp = cr.constant(float(smax(dw) as f64, src), src.clone());
                    let c = Self::clamp_float(cr, rounded, imin_fp, imax_fp);
                    return Some(cr.op1("arith.fptosi", &[c], dst));
                }
                let plus1 = cr.constant(float(smax(dw) as f64 + 1.0, src), src.clone());
                let imax = cr.constant(int_attr(smax(dw), &dst), dst.clone());
                let mcf = cr.bin("arith.maximumf", rounded, imin_fp);
                let mc = cr.op1("arith.fptosi", &[mcf], dst.clone());
                let over = cmpf(cr, 10, rounded, plus1);
                cr.op1("arith.select", &[over, imax, mc], dst)
            }
            _ if si && dst == Type::int(1) => {
                let t = Type::int(width(src));
                let z = cr.constant(int_attr(0, &t), t);
                cmpi(cr, 1, arg, z)
            }
            _ if si && di && extend => cr.op1("arith.extsi", &[arg], dst),
            _ if si && di => cr.op1("arith.trunci", &[arg], dst),
            _ => return None,
        })
    }

    fn pool_index(cr: &mut Cr<'_, '_, '_>, pool: &mut Pool, i: i64) -> ValueId {
        if let Some(v) = pool.get(&i) {
            return *v;
        }
        let v = cr.cidx(i);
        pool.insert(i, v);
        v
    }

    fn pool_dim(cr: &mut Cr<'_, '_, '_>, pool: &mut Pool, t: ValueId, i: i64) -> ValueId {
        let k = Self::pool_index(cr, pool, i);
        cr.op1("tensor.dim", &[t, k], Type::Index)
    }

    /// `computeTargetSize`.
    fn target_size(cr: &mut Cr<'_, '_, '_>, pool: &mut Pool, ops: &[ValueId], d: usize) -> (Ofr, Option<ValueId>) {
        for o in ops {
            let s = dims_of(&Self::ty(cr, *o))[d];
            if s != DYNAMIC && s > 1 {
                return (Ofr::C(s), Some(*o));
            }
        }
        let dynamic: Vec<ValueId> = ops.iter().copied().filter(|o| dims_of(&Self::ty(cr, *o))[d] == DYNAMIC).collect();
        if dynamic.is_empty() {
            return (Ofr::C(1), Some(ops[0]));
        }
        let mut t = Self::pool_dim(cr, pool, dynamic[0], d as i64);
        if dynamic.len() == 1 {
            return (Ofr::V(t), Some(dynamic[0]));
        }
        for o in &dynamic[1..] {
            let n = Self::pool_dim(cr, pool, *o, d as i64);
            t = cr.bin("arith.maxui", t, n);
        }
        (Ofr::V(t), None)
    }

    /// `broadcastDynamicDimension`.
    fn broadcast_dim(cr: &mut Cr<'_, '_, '_>, pool: &mut Pool, operand: ValueId, d: usize, target: Ofr, master: Option<ValueId>) -> ValueId {
        let ot = Self::ty(cr, operand);
        let dims = dims_of(&ot);
        if dims[d] != DYNAMIC || Some(operand) == master {
            return operand;
        }
        let rank = dims.len();
        let bmap = AffineMap { dims: rank as u32, syms: 0, results: (0..rank as u32).map(|i| if i as usize == d { AffineExpr::Const(0) } else { AffineExpr::Dim(i) }).collect() };
        let maps = [bmap, AffineMap::identity(rank as u32)];
        let one = Self::pool_index(cr, pool, 1);
        let rs = Self::pool_dim(cr, pool, operand, d as i64);
        let need = cmpi(cr, 0, rs, one);
        let data = OpData::build("scf.if").operands(&[need]);
        let op = cr.rw.create_with(data, core::slice::from_ref(&ot), |b, o| {
            for _ in 0..2 {
                let r = b.add_region(o);
                b.add_block(r, &[]);
            }
        });
        let (then, other) = (cr.rw.body.top_block(op), {
            let r = cr.rw.body[op].regions[1];
            cr.rw.body[r].blocks[0]
        });
        let saved = cr.rw.ip;
        cr.rw.set_end(then);
        let mut local = Pool::new();
        let mut shape = Vec::new();
        for (i, s) in dims.iter().enumerate() {
            shape.push(if i == d {
                target
            } else if *s == DYNAMIC {
                Ofr::V(Self::pool_dim(cr, &mut local, operand, i as i64))
            } else {
                Ofr::C(*s)
            });
        }
        let out = cr.empty_mixed(&shape, elem(&ot));
        let out_ty = Self::ty(cr, out);
        let g = cr.generic(core::slice::from_ref(&out_ty), &[operand], &[out], &maps, &vec![true; rank], &mut |_, a| vec![a[0]]);
        let gr = cr.rw.body[g].results[0];
        let cast = cr.rw.create_or_fold(OpData::build("tensor.cast").operands(&[gr]), core::slice::from_ref(&ot))[0];
        cr.rw.create(OpData::build("scf.yield").operands(&[cast]), &[]);
        cr.rw.set_end(other);
        cr.rw.create(OpData::build("scf.yield").operands(&[operand]), &[]);
        cr.rw.ip = saved;
        cr.rw.body[op].results[0]
    }

    /// `elementwiseMatchAndRewriteHelper`.
    #[lowering("tosa.add", "tosa.sub", "tosa.mul", "tosa.intdiv", "tosa.negate", "tosa.pow", "tosa.reciprocal", "tosa.rsqrt", "tosa.log", "tosa.exp", "tosa.abs", "tosa.sin", "tosa.cos", "tosa.tanh", "tosa.erf", "tosa.bitwise_and", "tosa.bitwise_or", "tosa.bitwise_not", "tosa.bitwise_xor", "tosa.logical_and", "tosa.logical_not", "tosa.logical_or", "tosa.logical_xor", "tosa.cast", "tosa.logical_left_shift", "tosa.logical_right_shift", "tosa.arithmetic_right_shift", "tosa.clz", "tosa.select", "tosa.greater", "tosa.greater_equal", "tosa.equal", "tosa.maximum", "tosa.minimum", "tosa.ceil", "tosa.floor", "tosa.clamp", "tosa.sigmoid")]
    fn pointwise(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let b = &*cr.rw.body;
        let ranked = |v: &ValueId| b[*v].ty.shape().is_some();
        if !b[op].operands.iter().all(ranked) || !b[op].results.iter().all(ranked) {
            return false;
        }
        let operands: Vec<ValueId> = o.iter().map(|v| v[0]).collect();
        let name = b[op].name.clone();
        // `getBroadcastableOperands`.
        let take = match &*name {
            "tosa.mul" => {
                if b.constant_of(b[op].operands[2]).is_some() { 2 } else { 3 }
            }
            "tosa.negate" if Self::zp(cr, op, 1).is_some() || Self::zp(cr, op, 2).is_some() => 1,
            _ => operands.len(),
        };
        let ops = &operands[..take];
        let r = cr.rw.body[op].results[0];
        let Some(rt) = cr.type_converter().and_then(|tc| tc.convert(&cr.rw.body[r].ty)) else { return false };
        let mut pool = Pool::new();
        let rank = dims_of(&Self::ty(cr, ops[0])).len();
        let mut target = Vec::new();
        let mut masters = Vec::new();
        for d in 0..rank {
            let (t, m) = Self::target_size(cr, &mut pool, ops, d);
            target.push(t);
            masters.push(m);
        }
        let mut bops = ops.to_vec();
        if ops.len() > 1 && ops.iter().any(|v| dims_of(&Self::ty(cr, *v)).contains(&DYNAMIC)) {
            for v in bops.iter_mut() {
                for d in 0..rank {
                    *v = Self::broadcast_dim(cr, &mut pool, *v, d, target[d], masters[d]);
                }
            }
        }
        // `emitElementwiseComputation`.
        let re = elem(&rt);
        let out = cr.empty_mixed(&target, re.clone());
        let out_ty = Self::ty(cr, out);
        let rdims = dims_of(&rt);
        let mut maps: Vec<AffineMap> = bops
            .iter()
            .map(|v| {
                let s = dims_of(&Self::ty(cr, *v));
                AffineMap { dims: rank as u32, syms: 0, results: s.iter().enumerate().map(|(i, d)| if *d == 1 && rdims[i] != 1 { AffineExpr::Const(0) } else { AffineExpr::Dim(i as u32) }).collect() }
            })
            .collect();
        maps.push(AffineMap::identity(rank as u32));
        let n = cr.rw.body[op].operands.len();
        let mut failed = false;
        let g = cr.generic(core::slice::from_ref(&out_ty), &bops, &[out], &maps, &vec![true; rank], &mut |cr, a| {
            let args = &a[..n.min(a.len())];
            match Self::elementwise_body(cr, op, args, &re) {
                Some(v) => vec![v],
                None => {
                    failed = true;
                    Vec::new()
                }
            }
        });
        if failed {
            return false;
        }
        let gr = cr.rw.body[g].results[0];
        let cast = cr.rw.create_or_fold(OpData::build("tensor.cast").operands(&[gr]), core::slice::from_ref(&rt))[0];
        cr.replace_values(op, &[cast]);
        true
    }

    /// `createInitialValueForReduceOp`.
    fn reduce_init<'a>(name: &str, et: &Type<'a>) -> Option<Attribute<'a>> {
        let f = matches!(et, Type::Float(_));
        let w = width(et);
        Some(match (name, f) {
            ("tosa.reduce_sum", true) => float(0.0, et),
            ("tosa.reduce_sum", false) => int_attr(0, et),
            ("tosa.reduce_product", true) => float(1.0, et),
            ("tosa.reduce_product", false) => int_attr(1, et),
            ("tosa.reduce_min", true) => ap(ApFloat::largest(if let Type::Float(k) = et { *k } else { FloatKind::F32 }, false), et),
            ("tosa.reduce_min", false) => int_attr(smax(w), et),
            ("tosa.reduce_max" | "tosa.argmax", true) => ap(ApFloat::largest(if let Type::Float(k) = et { *k } else { FloatKind::F32 }, true), et),
            ("tosa.reduce_max" | "tosa.argmax", false) => int_attr(smin(w), et),
            ("tosa.reduce_all", false) if w == 1 => int_attr(1, et),
            ("tosa.reduce_any", false) if w == 1 => int_attr(0, et),
            _ => return None,
        })
    }

    /// `createLinalgBodyCalculationForReduceOp`.
    fn reduce_body(cr: &mut Cr<'_, '_, '_>, name: &str, a: ValueId, b: ValueId, et: &Type<'_>) -> Option<ValueId> {
        let f = matches!(et, Type::Float(_));
        let n = match (name, f) {
            ("tosa.reduce_sum", true) => "arith.addf",
            ("tosa.reduce_sum", false) => "arith.addi",
            ("tosa.reduce_product", true) => "arith.mulf",
            ("tosa.reduce_product", false) => "arith.muli",
            ("tosa.reduce_min", true) => "arith.minimumf",
            ("tosa.reduce_min", false) => "arith.minsi",
            ("tosa.reduce_max", true) => "arith.maximumf",
            ("tosa.reduce_max", false) => "arith.maxsi",
            ("tosa.reduce_all", false) if width(et) == 1 => "arith.andi",
            ("tosa.reduce_any", false) if width(et) == 1 => "arith.ori",
            _ => return None,
        };
        Some(cr.bin(n, a, b))
    }

    /// `reduceMatchAndRewriteHelper`.
    #[lowering("tosa.reduce_all", "tosa.reduce_any", "tosa.reduce_min", "tosa.reduce_max", "tosa.reduce_sum", "tosa.reduce_product", untyped)]
    fn reduce(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let b = &*cr.rw.body;
        let name = b[op].name.clone();
        let input = b[op].operands[0];
        let (it, rt) = (Self::ty(cr, input), Self::ty(cr, cr.rw.body[op].results[0]));
        if it.shape().is_none() || rt.shape().is_none() {
            return false;
        }
        let axis = match cr.rw.body[op].get("axis") {
            Some(Attribute::Int { lit, .. }) => lit.parse::<usize>().unwrap_or(0),
            _ => 0,
        };
        let et = elem(&rt);
        let widen = name == "tosa.reduce_sum" && matches!(et, Type::Float(FloatKind::BF16));
        let acc = if widen { Type::Float(FloatKind::F32) } else { et.clone() };
        let idims = dims_of(&it);
        let mut shape = Vec::new();
        let mut dyn_dims = Vec::new();
        for (i, d) in idims.iter().enumerate() {
            if i != axis {
                shape.push(*d);
                if *d == DYNAMIC {
                    dyn_dims.push(cr.tdim(input, i as i64));
                }
            }
        }
        let empty = cr.empty(&shape, acc.clone(), &dyn_dims);
        let Some(init) = Self::reduce_init(&name, &acc) else { return false };
        let fv = cr.constant(init, acc.clone());
        let et_ty = Self::ty(cr, empty);
        let fill = cr.named("linalg.fill", Named::Fill, &[fv], &[empty], core::slice::from_ref(&et_ty), Vec::new());
        let filled = cr.rw.body[fill].results[0];
        let mut inputs = vec![input];
        let mut outputs = vec![filled];
        let nan_ignore = matches!(&*name, "tosa.reduce_min" | "tosa.reduce_max") && matches!(et, Type::Float(_)) && Self::nan_ignore(cr, op);
        if nan_ignore {
            let t = cr.constant(Attribute::Bool(true), Type::int(1));
            let eb = cr.empty(&shape, Type::int(1), &dyn_dims);
            let ebt = Self::ty(cr, eb);
            let f = cr.named("linalg.fill", Named::Fill, &[t], &[eb], core::slice::from_ref(&ebt), Vec::new());
            inputs.push(input);
            outputs.push(cr.rw.body[f].results[0]);
        }
        let out_types: Vec<Type> = outputs.iter().map(|v| Self::ty(cr, *v)).collect();
        let mut failed = false;
        let red = cr.structured("linalg.reduce", &inputs, &outputs, &out_types, vec![("dimensions", super::vector_transforms::dense_i64(&[axis as i64]))], &mut |cr, a| {
            let mut x = a[0];
            let y = if nan_ignore { a[2] } else { a[1] };
            if Self::ty(cr, x) != acc {
                x = cr.op1("arith.extf", &[x], acc.clone());
            }
            let Some(r) = Self::reduce_body(cr, &name, x, y, &acc) else {
                failed = true;
                return Vec::new();
            };
            if nan_ignore {
                let nan = cmpf(cr, UNO, a[0], a[0]);
                let s = cr.op1("arith.select", &[nan, a[2], r], acc.clone());
                let flag = cr.bin("arith.andi", a[3], nan);
                vec![s, flag]
            } else {
                vec![r]
            }
        });
        if failed {
            return false;
        }
        let mut res = cr.rw.body[red].results[0];
        if nan_ignore {
            let Type::Float(k) = acc else { return false };
            let nv = cr.constant(ap(ApFloat::nan(k), &acc), acc.clone());
            let en = cr.empty(&shape, acc.clone(), &dyn_dims);
            let ent = Self::ty(cr, en);
            let nf = cr.named("linalg.fill", Named::Fill, &[nv], &[en], core::slice::from_ref(&ent), Vec::new());
            let nft = cr.rw.body[nf].results[0];
            let fe = cr.empty(&shape, acc.clone(), &dyn_dims);
            let fet = Self::ty(cr, fe);
            let flag = cr.rw.body[red].results[1];
            let sel = cr.structured("linalg.select", &[flag, nft, res], &[fe], core::slice::from_ref(&fet), Vec::new(), &mut |cr, a| {
                let ty = Self::ty(cr, a[1]);
                vec![cr.op1("arith.select", &a[..3], ty)]
            });
            res = cr.rw.body[sel].results[0];
        }
        if widen {
            let re = cr.empty(&shape, et.clone(), &dyn_dims);
            let ret = Self::ty(cr, re);
            let r = shape.len() as u32;
            let id = AffineMap::identity(r);
            let g = cr.generic(core::slice::from_ref(&ret), &[res], &[re], &[id.clone(), id], &vec![true; r as usize], &mut |cr, a| vec![cr.op1("arith.truncf", &[a[0]], et.clone())]);
            res = cr.rw.body[g].results[0];
        }
        let n = dims_of(&Self::ty(cr, res)).len();
        let mut reassoc: Vec<Vec<i64>> = (0..n).map(|i| vec![if i > axis { i as i64 + 1 } else { i as i64 }]).collect();
        if n != 0 {
            let e = if axis < n { axis } else { n - 1 };
            reassoc[e].push(e as i64 + 1);
        }
        let v = TosaToTensor::expand(cr, rt, res, &reassoc, false);
        cr.replace_values(op, &[v]);
        true
    }

    /// The integer attribute `name` of `op` (`axis`).
    fn axis(cr: &Cr<'_, '_, '_>, op: OpId) -> usize {
        Self::attr_int(cr, op, "axis").map_or(0, |a| a as usize)
    }

    /// A rank-`n` map of the given dims.
    fn dims_map(n: usize, dims: &[usize]) -> AffineMap {
        AffineMap { dims: n as u32, syms: 0, results: dims.iter().map(|d| AffineExpr::Dim(*d as u32)).collect() }
    }

    /// `tensor.dim`s of the dynamic dimensions of `v` (those `keep` accepts).
    fn dyn_dims(cr: &mut Cr<'_, '_, '_>, v: ValueId, keep: impl Fn(usize, i64) -> bool) -> Vec<ValueId> {
        let dims = dims_of(&Self::ty(cr, v));
        dims.iter().enumerate().filter(|(i, d)| keep(*i, **d)).map(|(i, _)| cr.tdim(v, i as i64)).collect()
    }

    /// `ReverseConverter`.
    #[lowering("tosa.reverse", untyped)]
    fn reverse(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let input = cr.rw.body[op].operands[0];
        let rt = Self::ty(cr, cr.rw.body[op].results[0]);
        let it = Self::ty(cr, input);
        let axis = Self::axis(cr, op);
        let dyn_dims = Self::dyn_dims(cr, input, |_, d| d == DYNAMIC);
        let size = cr.tdim(input, axis as i64);
        let empty = cr.op1("tensor.empty", &dyn_dims, it.clone());
        let rank = dims_of(&rt).len();
        let g = cr.generic(core::slice::from_ref(&rt), &[], &[empty], &[AffineMap::identity(rank as u32)], &vec![true; rank], &mut |cr, _| {
            let mut idx = Vec::new();
            for i in 0..rank {
                let mut v = cr.index(i as i64);
                if i == axis {
                    let one = cr.cidx(1);
                    let m = cr.bin("arith.subi", size, one);
                    v = cr.bin("arith.subi", m, v);
                }
                idx.push(v);
            }
            let mut ops = vec![input];
            ops.extend(idx);
            vec![cr.op1("tensor.extract", &ops, elem(&it))]
        });
        let r = cr.rw.body[g].results[0];
        cr.replace_values(op, &[r]);
        true
    }

    /// `!tosa.shape<n>`.
    fn shape_type<'a>(n: usize) -> Type<'a> {
        Type::Extended(mlirformat::Extended { name: "tosa.shape".into(), body: Some(alloc::format!("<{n}>").into()), params: Vec::new() })
    }

    /// `TileConverter`.
    #[lowering("tosa.tile", untyped)]
    fn tile(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let (input, mv) = (cr.rw.body[op].operands[0], cr.rw.body[op].operands[1]);
        let Some(multiples) = TosaToTensor::const_shape(cr, mv) else { return false };
        let it = Self::ty(cr, input);
        let rt = Self::ty(cr, cr.rw.body[op].results[0]);
        let shape = dims_of(&it);
        let rank = shape.len();
        let mut gshape = Vec::new();
        for i in 0..rank {
            gshape.push(if multiples[i] == -1 { DYNAMIC } else { multiples[i] });
            gshape.push(shape[i]);
        }
        let dyn_dims = Self::dyn_dims(cr, input, |i, d| d == DYNAMIC || multiples[i] == -1);
        let empty = cr.empty(&gshape, elem(&it), &dyn_dims);
        let read = Self::dims_map(rank * 2, &(0..rank).map(|i| i * 2 + 1).collect::<Vec<_>>());
        let gt = super::linalg_build::tensor_type(&gshape, elem(&it));
        let g = cr.generic(core::slice::from_ref(&gt), &[input], &[empty], &[read, AffineMap::identity(gshape.len() as u32)], &vec![true; gshape.len()], &mut |_, a| vec![a[0]]);
        let gr = cr.rw.body[g].results[0];
        let rdims: Vec<i64> = dims_of(&rt).iter().map(|d| if *d == DYNAMIC { -1 } else { *d }).collect();
        let values = rdims.iter().map(|x| Scalar::Int(crate::ApInt::new(64, i128::from(*x)))).collect();
        let attr = Const { ty: super::linalg_build::tensor_type(&[rdims.len() as i64], Type::Index), values, elements: true };
        let sv = cr.build(OpData::build("tosa.const_shape").with("values", attr.into()), Self::shape_type(rdims.len()));
        cr.replace_new(op, OpData::build("tosa.reshape").operands(&[gr, sv]), &[rt]);
        true
    }

    /// `ArgMaxConverter`.
    #[lowering("tosa.argmax", untyped)]
    fn argmax(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let input = cr.rw.body[op].operands[0];
        let it = Self::ty(cr, input);
        let rt = Self::ty(cr, cr.rw.body[op].results[0]);
        let (ie, oe) = (elem(&it), elem(&rt));
        let axis = Self::axis(cr, op);
        if !matches!(oe, Type::Integer { .. }) || !matches!(ie, Type::Float(_) | Type::Integer { .. }) {
            return false;
        }
        let Some(init) = Self::reduce_init("tosa.argmax", &ie) else { return false };
        let rshape = dims_of(&rt);
        let max_ty = super::linalg_build::tensor_type(&rshape, ie.clone());
        let dyn_dims = Self::dyn_dims(cr, input, |i, d| d == DYNAMIC && i != axis);
        let ei = cr.empty(&rshape, oe.clone(), &dyn_dims);
        let zero = cr.constant(int_attr(0, &oe), oe.clone());
        let fi = cr.named("linalg.fill", Named::Fill, &[zero], &[ei], core::slice::from_ref(&rt), Vec::new());
        let fi = cr.rw.body[fi].results[0];
        let em = cr.empty(&rshape, ie.clone(), &dyn_dims);
        let mv = cr.constant(init, ie.clone());
        let fm = cr.named("linalg.fill", Named::Fill, &[mv], &[em], core::slice::from_ref(&max_ty), Vec::new());
        let fm = cr.rw.body[fm].results[0];
        let rank = dims_of(&it).len();
        let dst: Vec<usize> = (0..rank).filter(|i| *i != axis).collect();
        let maps = [Self::dims_map(rank, &(0..rank).collect::<Vec<_>>()), Self::dims_map(rank, &dst), Self::dims_map(rank, &dst)];
        let iters: Vec<bool> = (0..rank).map(|i| i != axis).collect();
        let nan_ignore = Self::nan_ignore(cr, op);
        let g = cr.generic(&[rt, max_ty], &[input], &[fi, fm], &maps, &iters, &mut |cr, a| {
            let (new_v, old_i, old_v) = (a[0], a[1], a[2]);
            let ix = cr.index(axis as i64);
            let new_i = cr.op1("arith.index_cast", &[ix], oe.clone());
            let pred = if matches!(ie, Type::Float(_)) {
                if nan_ignore {
                    cmpf(cr, 2, new_v, old_v)
                } else {
                    let gt = cmpf(cr, 9, new_v, old_v);
                    let ord = cmpf(cr, 7, old_v, old_v);
                    cr.op1("arith.andi", &[gt, ord], Type::int(1))
                }
            } else {
                cmpi(cr, 4, new_v, old_v)
            };
            let rm = cr.op1("arith.select", &[pred, new_v, old_v], ie.clone());
            let ri = cr.op1("arith.select", &[pred, new_i, old_i], oe.clone());
            vec![ri, rm]
        });
        let r = cr.rw.body[g].results[0];
        cr.replace_values(op, &[r]);
        true
    }

    /// `GatherConverter`.
    #[lowering("tosa.gather")]
    fn gather(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let (values, indices) = (o[0][0], o[1][0]);
        let rt = Self::ty(cr, cr.rw.body[op].results[0]);
        if Self::ty(cr, cr.rw.body[op].operands[0]).shape().is_none() || rt.shape().is_none() {
            return false;
        }
        let mut dyn_dims = Vec::new();
        for (v, d) in [(values, 0), (indices, 1), (values, 2)] {
            if let Ofr::V(x) = cr.mixed_size(v, d) {
                dyn_dims.push(x);
            }
        }
        let empty = cr.empty(&dims_of(&rt), elem(&rt), &dyn_dims);
        let rank = dims_of(&rt).len();
        let maps = [Self::dims_map(rank, &[0, 1]), AffineMap::identity(rank as u32)];
        let g = cr.generic(core::slice::from_ref(&rt), &[indices], &[empty], &maps, &vec![true; rank], &mut |cr, a| {
            let i0 = cr.index(0);
            let i1 = cr.op1("arith.index_cast", &[a[0]], Type::Index);
            let i2 = cr.index(2);
            vec![cr.op1("tensor.extract", &[values, i0, i1, i2], elem(&rt))]
        });
        let r = cr.rw.body[g].results[0];
        cr.replace_values(op, &[r]);
        true
    }

    /// `TableConverter`.
    #[lowering("tosa.table", untyped)]
    fn table(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let (input, table) = (cr.rw.body[op].operands[0], cr.rw.body[op].operands[1]);
        let it = Self::ty(cr, input);
        let rt = Self::ty(cr, cr.rw.body[op].results[0]);
        let (ie, te, re) = (elem(&it), elem(&Self::ty(cr, table)), elem(&rt));
        let i8 = ie == Type::int(8) && te == Type::int(8) && re == Type::int(8);
        let i16 = ie == Type::int(16) && te == Type::int(16) && re == Type::int(32);
        if !i8 && !i16 {
            return false;
        }
        let rank = dims_of(&rt).len();
        let dyn_dims = Self::dyn_dims(cr, input, |i, d| i < rank && d == DYNAMIC);
        let empty = cr.empty(&dims_of(&rt), re.clone(), &dyn_dims);
        let id = AffineMap::identity(rank as u32);
        let g = cr.generic(core::slice::from_ref(&rt), &[input], &[empty], &[id.clone(), id], &vec![true; rank], &mut |cr, a| {
            let i32t = Type::int(32);
            if i8 {
                let ix = cr.op1("arith.index_cast", &[a[0]], Type::Index);
                let off = cr.cidx(128);
                let ix = cr.bin("arith.addi", ix, off);
                return vec![cr.op1("tensor.extract", &[table, ix], te.clone())];
            }
            let ext = cr.op1("arith.extsi", &[a[0]], i32t.clone());
            let c = |cr: &mut Cr<'_, '_, '_>, v: i128| cr.constant(int_attr(v, &Type::int(32)), Type::int(32));
            let off = c(cr, 32768);
            let seven = c(cr, 7);
            let one = c(cr, 1);
            let mask = c(cr, 127);
            let add = cr.bin("arith.addi", ext, off);
            let ix = cr.bin("arith.shrui", add, seven);
            let frac = cr.bin("arith.andi", add, mask);
            let ix1 = cr.bin("arith.addi", ix, one);
            let ix = cr.op1("arith.index_cast", &[ix], Type::Index);
            let ix1 = cr.op1("arith.index_cast", &[ix1], Type::Index);
            let base = cr.op1("tensor.extract", &[table, ix], te.clone());
            let next = cr.op1("tensor.extract", &[table, ix1], te.clone());
            let base = cr.op1("arith.extsi", &[base], i32t.clone());
            let next = cr.op1("arith.extsi", &[next], i32t.clone());
            let bs = cr.bin("arith.shli", base, seven);
            let diff = cr.bin("arith.subi", next, base);
            let ds = cr.bin("arith.muli", diff, frac);
            vec![cr.bin("arith.addi", bs, ds)]
        });
        let r = cr.rw.body[g].results[0];
        cr.replace_values(op, &[r]);
        true
    }

    /// `RescaleConverter`.
    #[lowering("tosa.rescale", untyped)]
    fn rescale(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let b = &*cr.rw.body;
        let mode = match b[op].get("rounding_mode") {
            Some(Attribute::Extended { ext, .. }) => alloc::string::String::from(ext.body.as_deref().unwrap_or("")),
            _ => return false,
        };
        let flag = |n: &str| matches!(b[op].get(n), Some(Attribute::Bool(true) | Attribute::Unit));
        let (scale32, in_unsigned, out_unsigned) = (flag("scale32"), flag("input_unsigned"), flag("output_unsigned"));
        if mode.contains("INEXACT_ROUND") || (mode.contains("DOUBLE_ROUND") && !scale32) {
            return false;
        }
        let ops = b[op].operands.clone();
        let input = ops[0];
        let it = b[input].ty.clone();
        let ot = b[b[op].results[0]].ty.clone();
        if !matches!(elem(&it), Type::Integer { .. }) {
            return false;
        }
        let rank = dims_of(&it).len();
        let dyn_dims: Vec<ValueId> = dims_of(&ot).iter().enumerate().filter(|(_, d)| **d == DYNAMIC).map(|(i, _)| i).collect::<Vec<_>>().into_iter().map(|i| cr.tdim(input, i as i64)).collect();
        let ints = |cr: &Cr<'_, '_, '_>, v: ValueId| -> Option<Vec<i32>> {
            let c = Const::try_from(&cr.rw.body.constant_of(v)?).ok()?;
            let n = c.ty.element_count()?;
            (0..n).map(|i| c.at(i).int().map(|x| x.signed() as i32)).collect()
        };
        let (mc, sc) = (ints(cr, ops[1]), ints(cr, ops[2]));
        let (m_const, s_const) = (mc.is_some(), sc.is_some());
        let (mut mvals, mut svals) = (Vec::new(), Vec::new());
        let double = if let (Some(m), Some(s)) = (mc, sc) {
            mvals = m;
            svals = s;
            for i in 0..mvals.len() {
                if svals[i] > 63 {
                    svals[i] = 0;
                    mvals[i] = 0;
                }
            }
            mode.contains("DOUBLE_ROUND") && svals.iter().any(|v| *v > 31)
        } else {
            mode.contains("DOUBLE_ROUND")
        };
        let mut inputs = vec![input];
        let mut maps = vec![AffineMap::identity(rank as u32)];
        let last = Self::dims_map(rank, &[rank - 1]);
        let bcast = AffineMap { dims: rank as u32, syms: 0, results: Vec::new() };
        let collapse = |cr: &mut Cr<'_, '_, '_>, v: ValueId| {
            let t = super::linalg_build::tensor_type(&[], elem(&Self::ty(cr, v)));
            cr.collapse(v, &[], t)
        };
        let setup = |cr: &mut Cr<'_, '_, '_>, inputs: &mut Vec<ValueId>, maps: &mut Vec<AffineMap>, vals: &[i32], constant: bool, operand: ValueId, shift: bool| -> (Option<ValueId>, usize) {
            let et = Type::int(if shift { 8 } else { 32 });
            let mut c = None;
            if constant {
                if vals.len() == 1 {
                    let v = if shift { i128::from(vals[0] as i8) } else { i128::from(vals[0]) };
                    c = Some(cr.constant(int_attr(v, &et), et));
                } else {
                    let ty = super::linalg_build::tensor_type(&[vals.len() as i64], et.clone());
                    let w = if shift { 8 } else { 32 };
                    let values = vals.iter().map(|x| Scalar::Int(crate::ApInt::new(w, if shift { i128::from(*x as i8) } else { i128::from(*x) }))).collect();
                    let attr: Attribute = Const { ty: ty.clone(), values, elements: true }.into();
                    inputs.push(cr.constant(attr, ty));
                    maps.push(last.clone());
                }
            } else {
                let d = dims_of(&Self::ty(cr, operand));
                if d.first() == Some(&1) && !d.contains(&DYNAMIC) {
                    inputs.push(collapse(cr, operand));
                    maps.push(bcast.clone());
                } else {
                    inputs.push(operand);
                    maps.push(last.clone());
                }
            }
            (c, maps.len() - 1)
        };
        let (mconst, marg) = setup(cr, &mut inputs, &mut maps, &mvals, m_const, ops[1], false);
        let (sconst, sarg) = setup(cr, &mut inputs, &mut maps, &svals, s_const, ops[2], true);
        let zp = |cr: &Cr<'_, '_, '_>, i: usize, unsigned: bool| -> Option<i64> {
            let c = Const::try_from(&cr.rw.body.constant_of(ops[i])?).ok()?;
            Some(match c.at(0) {
                Scalar::Float(f) => if f.is_zero() { 0 } else { -1 },
                Scalar::Int(x) => if unsigned { x.unsigned() as i64 } else { x.signed() as i64 },
            })
        };
        let (izp, ozp) = (zp(cr, 3, in_unsigned), zp(cr, 4, out_unsigned));
        let mut iarg = 0;
        if izp.is_none() {
            inputs.push(collapse(cr, ops[3]));
            maps.push(bcast.clone());
            iarg = maps.len() - 1;
        }
        let mut oarg = 0;
        if ozp.is_none() {
            inputs.push(collapse(cr, ops[4]));
            maps.push(bcast.clone());
            oarg = maps.len() - 1;
        }
        maps.push(AffineMap::identity(rank as u32));
        let empty = cr.empty(&dims_of(&ot), elem(&ot), &dyn_dims);
        let ext_zp = |cr: &mut Cr<'_, '_, '_>, vt: &Type<'_>, zp: Option<i64>, a: &[ValueId], arg: usize, out: bool| -> ValueId {
            let bw = width(vt);
            let aw = if out { 32 } else { bw.max(32) };
            let et = Type::int(aw);
            let Some(z) = zp else {
                let mut r = a[arg];
                let zt = Self::ty(cr, r);
                if width(&zt) < aw {
                    let unsigned = matches!(zt, Type::Integer { signedness: Signedness::Unsigned, .. });
                    if unsigned {
                        r = cr.op1("builtin.unrealized_conversion_cast", &[r], Type::int(width(&zt)));
                        return cr.op1("arith.extui", &[r], et);
                    }
                    return cr.op1("arith.extsi", &[r], et);
                }
                return r;
            };
            cr.constant(int_attr(i128::from(z), &et), et)
        };
        let rmode = Attribute::dialect("tosa.rounding_mode", if double { "<DOUBLE_ROUND>" } else { "<SINGLE_ROUND>" });
        let g = cr.generic(core::slice::from_ref(&ot), &inputs, &[empty], &maps, &vec![true; rank], &mut |cr, a| {
            let mut v = a[0];
            let vt = Self::ty(cr, v);
            let izv = ext_zp(cr, &vt, izp, a, iarg, false);
            let ozv = ext_zp(cr, &vt, ozp, a, oarg, true);
            let out_t = Self::ty(cr, *a.last().expect("an output"));
            let ow = width(&out_t);
            let m = mconst.unwrap_or(a[marg]);
            let s = sconst.unwrap_or(a[sarg]);
            let i32t = Type::int(32);
            if matches!(vt, Type::Integer { signedness: Signedness::Unsigned, .. }) {
                v = cr.op1("builtin.unrealized_conversion_cast", &[v], Type::int(width(&vt)));
            }
            if width(&vt) < 32 {
                v = cr.op1(if in_unsigned { "arith.extui" } else { "arith.extsi" }, &[v], i32t.clone());
            }
            v = cr.bin("arith.subi", v, izv);
            v = cr.build(OpData::build("tosa.apply_scale").operands(&[v, m, s]).with("rounding_mode", rmode.clone()), i32t.clone());
            v = cr.bin("arith.addi", v, ozv);
            let (lo, hi) = if out_unsigned { (0, (1i128 << ow) - 1) } else { (smin(ow), smax(ow)) };
            // `int32_t` truncation of the bounds.
            let (lo, hi) = (i128::from(lo as i32), i128::from(hi as i32));
            let mn = cr.constant(int_attr(lo, &i32t), i32t.clone());
            let mx = cr.constant(int_attr(hi, &i32t), i32t.clone());
            v = Self::clamp_int(cr, v, mn, mx, false);
            if ow < 32 {
                v = cr.op1("arith.trunci", &[v], Type::int(ow));
            }
            if matches!(out_t, Type::Integer { signedness: Signedness::Unsigned, .. }) {
                v = cr.op1("builtin.unrealized_conversion_cast", &[v], out_t.clone());
            }
            vec![v]
        });
        let r = cr.rw.body[g].results[0];
        cr.replace_values(op, &[r]);
        true
    }

    /// `RFFT2dConverter::castIndexToFloat`.
    fn index_to_float<'a>(cr: &mut Cr<'_, 'a, '_>, ty: &Type<'a>, v: ValueId) -> ValueId {
        let it = Type::int(if width(ty) > 32 { 64 } else { 32 });
        let i = cr.op1("arith.index_castui", &[v], it);
        cr.op1("arith.uitofp", &[i], ty.clone())
    }

    /// `RFFT2dConverter::createZeroTensor`.
    fn zero_tensor<'a>(cr: &mut Cr<'_, 'a, '_>, ty: &Type<'a>, dynamic: &[ValueId]) -> ValueId {
        let e = cr.op1("tensor.empty", dynamic, ty.clone());
        let et = elem(ty);
        let z = cr.constant(float(0.0, &et), et);
        let f = cr.named("linalg.fill", Named::Fill, &[z], &[e], core::slice::from_ref(ty), Vec::new());
        cr.rw.body[f].results[0]
    }

    /// `RFFT2dConverter` and `FFT2dConverter`.
    #[lowering("tosa.rfft2d", "tosa.fft2d", untyped)]
    fn fft(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let b = &*cr.rw.body;
        let ranked = |v: &ValueId| b[*v].ty.shape().is_some();
        if !b[op].operands.iter().all(ranked) || !b[op].results.iter().all(ranked) {
            return false;
        }
        let real = b[op].name == "tosa.rfft2d";
        let inverse = matches!(b[op].get("inverse"), Some(Attribute::Bool(true)));
        let inputs = b[op].operands.clone();
        let results: Vec<Type> = b[op].results.iter().map(|r| b[*r].ty.clone()).collect();
        let input = inputs[0];
        let et = elem(&Self::ty(cr, input));
        if !matches!(et, Type::Float(_)) {
            return false;
        }
        let mut dims = cr.mixed_sizes(input);
        if real {
            let one = cr.cidx(1);
            let two = cr.cidx(2);
            let v = match dims[2] {
                Ofr::V(v) => v,
                Ofr::C(c) => cr.cidx(c),
            };
            let d = cr.rw.create_or_fold(OpData::build("arith.divui").operands(&[v, two]), &[Type::Index])[0];
            let p = cr.rw.create_or_fold(OpData::build("arith.addi").operands(&[d, one]).with("overflowFlags", Attribute::dialect("arith.overflow", "<none>")), &[Type::Index])[0];
            dims[2] = cr.rw.body.ofr_int(Ofr::V(p)).map_or(Ofr::V(p), Ofr::C);
        }
        let shape: Vec<i64> = dims.iter().map(|s| if let Ofr::C(c) = s { *c } else { DYNAMIC }).collect();
        let dynamic: Vec<ValueId> = dims.iter().filter_map(|s| if let Ofr::V(v) = s { Some(*v) } else { None }).collect();
        let out_ty = super::linalg_build::tensor_type(&shape, et.clone());
        let outs = [Self::zero_tensor(cr, &out_ty, &dynamic), Self::zero_tensor(cr, &out_ty, &dynamic)];
        let (inm, outm) = (Self::dims_map(5, &[0, 3, 4]), Self::dims_map(5, &[0, 1, 2]));
        let mut maps = vec![inm; inputs.len()];
        maps.extend([outm.clone(), outm]);
        let fold_dim = |cr: &mut Cr<'_, '_, '_>, i: i64| {
            let k = cr.cidx(i);
            cr.rw.create_or_fold(OpData::build("tensor.dim").operands(&[input, k]), &[Type::Index])[0]
        };
        let dim_h = fold_dim(cr, 1);
        let dim_w = fold_dim(cr, 2);
        let two_pi = cr.constant(float(6.283185307179586, &et), et.clone());
        let ch = Self::index_to_float(cr, &et, dim_h);
        let cw = Self::index_to_float(cr, &et, dim_w);
        let iters = [true, true, true, false, false];
        let g = cr.generic(&results, &inputs, &outs, &maps, &iters, &mut |cr, a| {
            let n = inputs.len();
            let (sr, si) = (a[n], a[n + 1]);
            let [oy, ox, iy, ix] = [1, 2, 3, 4].map(|d| cr.index(d));
            let yy = cr.bin("index.mul", iy, oy);
            let xx = cr.bin("index.mul", ix, ox);
            let yr = cr.bin("index.remu", yy, dim_h);
            let xr = cr.bin("index.remu", xx, dim_w);
            let yf = Self::index_to_float(cr, &et, yr);
            let xf = Self::index_to_float(cr, &et, xr);
            let yc = cr.bin("arith.divf", yf, ch);
            let xc = cr.bin("arith.divf", xf, cw);
            let s = cr.bin("arith.addf", yc, xc);
            let mut angle = cr.bin("arith.mulf", two_pi, s);
            if real {
                let cos = cr.op1("math.cos", &[angle], et.clone());
                let sin = cr.op1("math.sin", &[angle], et.clone());
                let rc = cr.bin("arith.mulf", a[0], cos);
                let ic = cr.bin("arith.mulf", a[0], sin);
                return vec![cr.bin("arith.addf", sr, rc), cr.bin("arith.subf", si, ic)];
            }
            if inverse {
                let m1 = cr.constant(float(-1.0, &et), et.clone());
                angle = cr.bin("arith.mulf", angle, m1);
            }
            let cos = cr.op1("math.cos", &[angle], et.clone());
            let sin = cr.op1("math.sin", &[angle], et.clone());
            let rcos = cr.bin("arith.mulf", a[0], cos);
            let rsin = cr.bin("arith.mulf", a[1], sin);
            let rc = cr.bin("arith.addf", rcos, rsin);
            let icos = cr.bin("arith.mulf", a[1], cos);
            let isin = cr.bin("arith.mulf", a[0], sin);
            let ic = cr.bin("arith.subf", icos, isin);
            vec![cr.bin("arith.addf", sr, rc), cr.bin("arith.addf", si, ic)]
        });
        let r = cr.rw.body[g].results.clone();
        cr.replace_values(op, &r);
        true
    }

    /// The `tosa.resize` mode (`Some(true)` for bilinear, `Some(false)` nearest).
    fn bilinear(cr: &Cr<'_, '_, '_>, op: OpId) -> Option<bool> {
        let Some(Attribute::Extended { ext, .. }) = cr.rw.body[op].get("mode") else { return None };
        match ext.body.as_deref()? {
            m if m.contains("BILINEAR") => Some(true),
            m if m.contains("NEAREST_NEIGHBOR") => Some(false),
            _ => None,
        }
    }

    /// `ResizeUnaryConverter`.
    #[lowering("tosa.resize", benefit = 200, untyped)]
    fn resize_unary(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let input = cr.rw.body[op].operands[0];
        let (it, rt) = (Self::ty(cr, input), Self::ty(cr, cr.rw.body[op].results[0]));
        let (id, rd) = (dims_of(&it), dims_of(&rt));
        if id[1] != 1 || id[2] != 1 || rd[1] != 1 || rd[2] != 1 {
            return false;
        }
        let Some(bilinear) = Self::bilinear(cr, op) else { return false };
        if it == rt {
            cr.replace_values(op, &[input]);
            return true;
        }
        let Some(scale) = TosaToTensor::const_shape(cr, cr.rw.body[op].operands[1]) else { return false };
        let reassoc = [vec![0], vec![1, 2, 3]];
        let (ie, re) = (elem(&it), elem(&rt));
        let ct = super::linalg_build::tensor_type(&[id[0], id[3]], ie.clone());
        let collapse = cr.collapse(input, &reassoc, ct);
        let dyn_dims = Self::dyn_dims(cr, input, |i, d| d == DYNAMIC && (i == 0 || i == 3));
        let gt = super::linalg_build::tensor_type(&[id[0], id[3]], re.clone());
        let empty = cr.op1("tensor.empty", &dyn_dims, gt.clone());
        let id2 = AffineMap::identity(2);
        let g = cr.generic(core::slice::from_ref(&gt), &[collapse], &[empty], &[id2.clone(), id2], &[true, true], &mut |cr, a| {
            let mut v = a[0];
            if ie != re {
                v = cr.op1("arith.extsi", &[v], re.clone());
                for s in [scale[0], scale[2]] {
                    if bilinear && s != 0 {
                        let c = cr.constant(int_attr(i128::from(s as i32), &Type::int(32)), Type::int(32));
                        v = cr.bin("arith.muli", v, c);
                    }
                }
            }
            vec![v]
        });
        let gr = cr.rw.body[g].results[0];
        let v = TosaToTensor::expand(cr, rt, gr, &reassoc, false);
        cr.replace_values(op, &[v]);
        true
    }

    /// `MaterializeResizeBroadcast`.
    #[lowering("tosa.resize", benefit = 300, untyped)]
    fn resize_broadcast(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let input = cr.rw.body[op].operands[0];
        let (it, rt) = (Self::ty(cr, input), Self::ty(cr, cr.rw.body[op].results[0]));
        if it.shape().is_none() || rt.shape().is_none() {
            return false;
        }
        let (id, rd) = (dims_of(&it), dims_of(&rt));
        let (batch, channels, ih, iw, oh, ow) = (id[0], id[3], id[1], id[2], rd[1], rd[2]);
        if (ih != 1 || oh == 1) && (iw != 1 || ow == 1) {
            return false;
        }
        let re = elem(&rt);
        let rshape = [batch, if ih == 1 { 1 } else { oh }, if iw == 1 { 1 } else { ow }, channels];
        let o = &cr.rw.body[op];
        let data = OpData { results: Vec::new(), successors: Vec::new(), regions: Vec::new(), parent: None, ..o.clone() };
        let resize = cr.build(data, super::linalg_build::tensor_type(&rshape, re.clone()));
        let mut reassoc = vec![vec![0], vec![1]];
        if ih != 1 {
            reassoc.push(Vec::new());
        }
        reassoc.last_mut().expect("a group").push(2);
        if iw != 1 {
            reassoc.push(Vec::new());
        }
        reassoc.last_mut().expect("a group").push(3);
        let mut cshape = vec![batch];
        let mut in_dims = vec![0];
        if ih != 1 {
            cshape.push(oh);
            in_dims.push(1);
        }
        if iw != 1 {
            cshape.push(ow);
            in_dims.push(2);
        }
        cshape.push(channels);
        in_dims.push(3);
        let collapse = cr.collapse(resize, &reassoc, super::linalg_build::tensor_type(&cshape, re.clone()));
        let dyn_dims = Self::dyn_dims(cr, input, |i, d| d == DYNAMIC && (i == 0 || i == 3));
        let empty = cr.op1("tensor.empty", &dyn_dims, rt.clone());
        let maps = [Self::dims_map(4, &in_dims), AffineMap::identity(4)];
        let g = cr.generic(core::slice::from_ref(&rt), &[collapse], &[empty], &maps, &[true; 4], &mut |_, a| vec![a[0]]);
        let r = cr.rw.body[g].results[0];
        cr.replace_values(op, &[r]);
        true
    }

    /// `GenericResizeConverter`.
    #[lowering("tosa.resize", benefit = 100, untyped)]
    fn resize<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let ops = cr.rw.body[op].operands.clone();
        let input = ops[0];
        let (it, rt) = (Self::ty(cr, input), Self::ty(cr, cr.rw.body[op].results[0]));
        let re = elem(&rt);
        let fp = matches!(re, Type::Float(_));
        let id = dims_of(&it);
        let (ih, iw) = (id[1], id[2]);
        let out = cr.rw.body[op].results[0];
        let Some(dyn_dims) = super::TosaToLinalgNamed::dynamic_batch(cr, &[input, out]) else { return false };
        let Some(bilinear) = Self::bilinear(cr, op) else { return false };
        let (Some(scale), Some(offset), Some(border)) = (TosaToTensor::const_shape(cr, ops[1]), TosaToTensor::const_shape(cr, ops[2]), TosaToTensor::const_shape(cr, ops[3])) else { return false };
        let empty = cr.op1("tensor.empty", &dyn_dims, rt.clone());
        let g = cr.generic(core::slice::from_ref(&rt), &[], &[empty], &[AffineMap::identity(4)], &[true; 4], &mut |cr, _| {
            let i32t = Type::int(32);
            let c32 = |cr: &mut Cr<'_, 'a, '_>, v: i64| cr.constant(int_attr(i128::from(v as i32), &Type::int(32)), Type::int(32));
            let [batch, y, x, channel] = [0, 1, 2, 3].map(|d| cr.index(d));
            let zero = c32(cr, 0);
            let zero_fp = cr.constant(float(0.0, &re), re.clone());
            let hmax = c32(cr, ih - 1);
            let wmax = c32(cr, iw - 1);
            let in_y = cr.op1("arith.index_cast", &[y], i32t.clone());
            let in_x = cr.op1("arith.index_cast", &[x], i32t.clone());
            let [ysn, ysd, xsn, xsd] = [0, 1, 2, 3].map(|i| c32(cr, scale[i]));
            let [yo, xo] = [0, 1].map(|i| c32(cr, offset[i]));
            let _ = [0, 1].map(|i| c32(cr, border[i]));
            let index_delta = |cr: &mut Cr<'_, 'a, '_>, v: ValueId, sn: ValueId, sd: ValueId, off: ValueId, size: i64| -> (ValueId, ValueId) {
                if size == 1 {
                    return (zero, if fp { zero_fp } else { zero });
                }
                let m = cr.bin("arith.muli", v, sd);
                let val = cr.bin("arith.addi", m, off);
                if fp {
                    let index = cr.bin("arith.floordivsi", val, sn);
                    let r = cr.bin("arith.remsi", val, sn);
                    let rf = cr.op1("arith.sitofp", &[r], re.clone());
                    let sf = cr.op1("arith.uitofp", &[sn], re.clone());
                    return (index, cr.bin("arith.divf", rf, sf));
                }
                let index = cr.bin("arith.divsi", val, sn);
                let d = cr.bin("arith.muli", index, sn);
                (index, cr.bin("arith.subi", val, d))
            };
            let (iy, dy) = index_delta(cr, in_y, ysn, ysd, yo, ih);
            let (ix, dx) = index_delta(cr, in_x, xsn, xsd, xo, iw);
            if !bilinear {
                let one = c32(cr, 1);
                let nearest = |cr: &mut Cr<'_, 'a, '_>, v: ValueId, dv: ValueId, s: ValueId, max: ValueId, size: i64| -> ValueId {
                    if size == 1 {
                        return cr.cidx(0);
                    }
                    let pred = if fp {
                        let h = cr.constant(float(0.5, &re), re.clone());
                        cmpf(cr, 3, dv, h)
                    } else {
                        let dd = cr.bin("arith.shli", dv, one);
                        cmpi(cr, 5, dd, s)
                    };
                    let off = cr.op1("arith.select", &[pred, one, zero], Type::int(32));
                    let v = cr.bin("arith.addi", v, off);
                    let v = Self::clamp_int(cr, v, zero, max, false);
                    cr.op1("arith.index_cast", &[v], Type::Index)
                };
                let iy = nearest(cr, iy, dy, ysn, hmax, ih);
                let ix = nearest(cr, ix, dx, xsn, wmax, iw);
                return vec![cr.op1("tensor.extract", &[input, batch, iy, ix, channel], elem(&it))];
            }
            let one = c32(cr, 1);
            let clamped = |cr: &mut Cr<'_, 'a, '_>, v: ValueId, max: ValueId| -> (ValueId, ValueId) {
                let v1 = cr.bin("arith.addi", v, one);
                let v0 = Self::clamp_int(cr, v, zero, max, false);
                let v1 = Self::clamp_int(cr, v1, zero, max, false);
                (cr.op1("arith.index_cast", &[v0], Type::Index), cr.op1("arith.index_cast", &[v1], Type::Index))
            };
            let (y0, y1) = clamped(cr, iy, hmax);
            let (x0, x1) = clamped(cr, ix, wmax);
            let ie = elem(&it);
            let ex = |cr: &mut Cr<'_, 'a, '_>, yy: ValueId, xx: ValueId| cr.op1("tensor.extract", &[input, batch, yy, xx, channel], ie.clone());
            let (mut v00, mut v01, mut v10, mut v11) = (ex(cr, y0, x0), ex(cr, y0, x1), ex(cr, y1, x0), ex(cr, y1, x1));
            if fp {
                let onef = cr.constant(float(1.0, &re), re.clone());
                let interp = |cr: &mut Cr<'_, 'a, '_>, a: ValueId, b: ValueId, d: ValueId, size: i64| -> ValueId {
                    if size == 1 {
                        return a;
                    }
                    let omd = cr.bin("arith.subf", onef, d);
                    let m0 = cr.bin("arith.mulf", a, omd);
                    let m1 = cr.bin("arith.mulf", b, d);
                    cr.bin("arith.addf", m0, m1)
                };
                let top = interp(cr, v00, v01, dx, iw);
                let bottom = interp(cr, v10, v11, dx, iw);
                return vec![interp(cr, top, bottom, dy, ih)];
            }
            for v in [&mut v00, &mut v01, &mut v10, &mut v11] {
                *v = cr.op1("arith.extsi", &[*v], re.clone());
            }
            let (mut dx, mut dy) = (dx, dy);
            if width(&re) > width(&Self::ty(cr, dx)) {
                dx = cr.op1("arith.extsi", &[dx], re.clone());
                dy = cr.op1("arith.extsi", &[dy], re.clone());
            }
            let (mut ysn, mut xsn) = (ysn, xsn);
            if width(&re) > 32 {
                ysn = cr.op1("arith.extsi", &[ysn], re.clone());
                xsn = cr.op1("arith.extsi", &[xsn], re.clone());
            }
            let interp = |cr: &mut Cr<'_, 'a, '_>, a: ValueId, b: ValueId, w1: ValueId, s: ValueId, size: i64| -> ValueId {
                if size == 1 {
                    return cr.bin("arith.muli", a, s);
                }
                let w0 = cr.bin("arith.subi", s, w1);
                let m0 = cr.bin("arith.muli", a, w0);
                let m1 = cr.bin("arith.muli", b, w1);
                cr.bin("arith.addi", m0, m1)
            };
            let top = interp(cr, v00, v01, dx, xsn, iw);
            let bottom = interp(cr, v10, v11, dx, xsn, iw);
            vec![interp(cr, top, bottom, dy, ysn, ih)]
        });
        let r = cr.rw.body[g].results[0];
        cr.replace_values(op, &[r]);
        true
    }

    /// `IdentityNConverter`.
    #[lowering("tosa.identity", untyped)]
    fn identity(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let ops = cr.rw.body[op].operands.clone();
        cr.replace_values(op, &ops);
        true
    }

}
