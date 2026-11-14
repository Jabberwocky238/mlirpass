use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{Attribute, FloatKind, Type};

use super::to_nvvm::NvgpuToNvvm;
use crate::{ConversionRewriter as Cr, OpData, OpId, Rewriter, ValueId};

const REG_BITS: i64 = 32;

const F6_CONTAINER: i64 = 8;

#[derive(Clone, Copy, PartialEq, Eq)]
enum FpKind {
    F32,
    Bf16,
    F16,
    F8,
    F6,
    F4,
}

impl FpKind {
    fn of(t: &Type<'_>) -> Option<Self> {
        Some(match t {
            Type::Float(FloatKind::F32) => FpKind::F32,
            Type::Float(FloatKind::BF16) => FpKind::Bf16,
            Type::Float(FloatKind::F16) => FpKind::F16,
            Type::Float(FloatKind::F8E4M3FN | FloatKind::F8E5M2 | FloatKind::F8E8M0FNU) => FpKind::F8,
            Type::Float(FloatKind::F6E2M3FN | FloatKind::F6E3M2FN) => FpKind::F6,
            Type::Float(FloatKind::F4E2M1FN) => FpKind::F4,
            _ => return None,
        })
    }
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum Trunc {
    F32ToF16,
    F32ToBf16,
    F32ToF8,
    F32ToF6,
    F32ToF4,
    F16ToF8,
    F16ToF6,
    F16ToF4,
    Bf16ToF8,
    Bf16ToF6,
    Bf16ToF4,
}

impl Trunc {
    const TABLE: [(FpKind, FpKind, Trunc); 11] = [
        (FpKind::F32, FpKind::F16, Trunc::F32ToF16),
        (FpKind::F32, FpKind::Bf16, Trunc::F32ToBf16),
        (FpKind::F32, FpKind::F8, Trunc::F32ToF8),
        (FpKind::F32, FpKind::F6, Trunc::F32ToF6),
        (FpKind::F32, FpKind::F4, Trunc::F32ToF4),
        (FpKind::F16, FpKind::F8, Trunc::F16ToF8),
        (FpKind::F16, FpKind::F6, Trunc::F16ToF6),
        (FpKind::F16, FpKind::F4, Trunc::F16ToF4),
        (FpKind::Bf16, FpKind::F8, Trunc::Bf16ToF8),
        (FpKind::Bf16, FpKind::F6, Trunc::Bf16ToF6),
        (FpKind::Bf16, FpKind::F4, Trunc::Bf16ToF4),
    ];

    fn of(src: &Type<'_>, dst: &Type<'_>) -> Option<(FpKind, FpKind, Self)> {
        let (s, d) = (FpKind::of(src)?, FpKind::of(dst)?);
        Self::TABLE.iter().copied().find(|(a, b, _)| *a == s && *b == d)
    }

    fn op(self) -> (&'static str, Option<u32>, bool) {
        match self {
            Trunc::F32ToF16 => ("nvvm.convert.f32x2.to.f16x2", None, true),
            Trunc::F32ToBf16 => ("nvvm.convert.f32x2.to.bf16x2", None, true),
            Trunc::F32ToF8 => ("nvvm.convert.f32x2.to.f8x2", Some(16), true),
            Trunc::F32ToF6 => ("nvvm.convert.f32x2.to.f6x2", Some(16), false),
            Trunc::F32ToF4 => ("nvvm.convert.f32x2.to.f4x2", Some(8), false),
            Trunc::F16ToF8 => ("nvvm.convert.f16x2.to.f8x2", Some(16), false),
            Trunc::F16ToF6 => ("nvvm.convert.f16x2.to.f6x2", Some(16), false),
            Trunc::F16ToF4 => ("nvvm.convert.f16x2.to.f4x2", Some(8), false),
            Trunc::Bf16ToF8 => ("nvvm.convert.bf16x2.to.f8x2", Some(16), true),
            Trunc::Bf16ToF6 => ("nvvm.convert.bf16x2.to.f6x2", Some(16), false),
            Trunc::Bf16ToF4 => ("nvvm.convert.bf16x2.to.f4x2", Some(8), false),
        }
    }
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum Ext {
    F8ToF16,
    F8ToBf16,
    F6ToF16,
    F6ToBf16,
    F4ToF16,
    F4ToBf16,
}

impl Ext {
    const TABLE: [(FpKind, FpKind, Ext); 6] = [
        (FpKind::F8, FpKind::F16, Ext::F8ToF16),
        (FpKind::F8, FpKind::Bf16, Ext::F8ToBf16),
        (FpKind::F6, FpKind::F16, Ext::F6ToF16),
        (FpKind::F6, FpKind::Bf16, Ext::F6ToBf16),
        (FpKind::F4, FpKind::F16, Ext::F4ToF16),
        (FpKind::F4, FpKind::Bf16, Ext::F4ToBf16),
    ];

    fn of(src: &Type<'_>, dst: &Type<'_>) -> Option<Self> {
        let (s, d) = (FpKind::of(src)?, FpKind::of(dst)?);
        Self::TABLE.iter().find(|(a, b, _)| *a == s && *b == d).map(|(_, _, e)| *e)
    }

    fn op(self) -> (&'static str, bool) {
        match self {
            Ext::F8ToF16 => ("nvvm.convert.f8x2.to.f16x2", false),
            Ext::F8ToBf16 => ("nvvm.convert.f8x2.to.bf16x2", true),
            Ext::F6ToF16 => ("nvvm.convert.f6x2.to.f16x2", false),
            Ext::F6ToBf16 => ("nvvm.convert.f6x2.to.bf16x2", true),
            Ext::F4ToF16 => ("nvvm.convert.f4x2.to.f16x2", false),
            Ext::F4ToBf16 => ("nvvm.convert.f4x2.to.bf16x2", true),
        }
    }
}

fn effective(bits: i64) -> i64 {
    if bits == 6 { F6_CONTAINER } else { bits }
}

fn vec_of<'a>(n: i64, elem: Type<'a>) -> Type<'a> {
    Type::vector(&[n], &[false], elem)
}

fn make<'a>(rw: &mut Rewriter<'_, 'a>, data: OpData<'a>, ty: Type<'a>) -> ValueId {
    let o = rw.create(data, &[ty]);
    rw.body[o].results[0]
}

fn bit_width(t: &Type<'_>) -> i64 {
    t.element_type().bit_width().map_or(0, i64::from)
}

impl NvgpuToNvvm {
    fn element<'a>(cr: &mut Cr<'_, 'a, '_>, v: ValueId, i: i64, elem: Type<'a>) -> ValueId {
        let idx = Self::c(cr, i, 64);
        cr.build(OpData::build("llvm.extractelement").operands(&[v, idx]), elem)
    }

    fn bitcast<'a>(cr: &mut Cr<'_, 'a, '_>, v: ValueId, to: Type<'a>) -> ValueId {
        cr.build(OpData::build("llvm.bitcast").operands(&[v]), to)
    }

    fn insert<'a>(cr: &mut Cr<'_, 'a, '_>, into: ValueId, v: ValueId, i: i64) -> ValueId {
        let ty = cr.rw.body[into].ty.clone();
        let idx = Self::c(cr, i, 64);
        cr.build(OpData::build("llvm.insertelement").operands(&[into, v, idx]), ty)
    }

    #[allow(clippy::too_many_arguments)]
    fn trunc_one<'a>(cr: &mut Cr<'_, 'a, '_>, conv: Trunc, src: ValueId, base: i64, modes: &[(&str, Attribute<'a>)], relu: &Attribute<'a>, dst_elem: &Type<'a>, random: Option<ValueId>) -> ValueId {
        let (name, int, rounding) = conv.op();
        let (f32t, f16t, bf16t) = (Type::Float(FloatKind::F32), Type::Float(FloatKind::F16), Type::Float(FloatKind::BF16));
        let from_f32 = matches!(conv, Trunc::F32ToF16 | Trunc::F32ToBf16 | Trunc::F32ToF8 | Trunc::F32ToF6 | Trunc::F32ToF4);
        let mut operands = Vec::new();
        if from_f32 {
            let e0 = Self::element(cr, src, base, Type::int(32));
            let e1 = Self::element(cr, src, base + 1, Type::int(32));
            let lo = Self::bitcast(cr, e0, f32t.clone());
            let hi = Self::bitcast(cr, e1, f32t);
            operands.extend([hi, lo]);
        } else {
            let part = if matches!(conv, Trunc::F16ToF8 | Trunc::F16ToF6 | Trunc::F16ToF4) { f16t.clone() } else { bf16t.clone() };
            let e = Self::element(cr, src, base, Type::int(32));
            operands.push(Self::bitcast(cr, e, vec_of(2, part)));
        }
        let mut data = OpData::build(name);
        if let (Trunc::F32ToF16 | Trunc::F32ToBf16, Some(r)) = (conv, random) {
            operands.push(r);
        }
        data = data.operands(&operands);
        if rounding {
            for (n, v) in modes {
                data.set(n, v.clone());
            }
        }
        data.set("relu", relu.clone());
        let packed = match (conv, int) {
            (Trunc::F32ToF16, _) => vec_of(2, f16t),
            (Trunc::F32ToBf16, _) => vec_of(2, bf16t),
            (_, Some(w)) => {
                data.set("dstTy", Attribute::Type(dst_elem.clone()));
                Type::int(w)
            }
            _ => unreachable!("the table gives the result"),
        };
        let r = cr.build(data, packed);
        if int.is_none() { Self::bitcast(cr, r, Type::int(32)) } else { r }
    }

    pub(super) fn lower_truncf(cr: &mut Cr<'_, '_, '_>, op: OpId, input: ValueId, random: Option<ValueId>) -> bool {
        let b = &*cr.rw.body;
        let (src_ty, dst_ty) = (b[b[op].operands[0]].ty.clone(), b[b[op].results[0]].ty.clone());
        let one_d = |t: &Type<'_>| t.dims().is_some_and(|d| d.len() == 1) && matches!(t, Type::Shaped(s) if s.kind == mlirformat::ShapedKind::Vector);
        if !one_d(&src_ty) || !one_d(&dst_ty) {
            return false;
        }
        let modes: Vec<(&str, Attribute<'_>)> = ["rnd", "sat"].iter().filter_map(|n| b[op].get(n).map(|a| (*n, a.clone()))).collect();
        let relu = b[op].get("relu").cloned().unwrap_or(Attribute::Bool(false));
        let n = src_ty.element_count().unwrap_or(0) as i64;
        let (mut src_elem, dst_elem) = (src_ty.element_type().owned(), dst_ty.element_type().owned());
        let (mut src_bw, dst_bw) = (bit_width(&src_ty), bit_width(&dst_ty));
        let Some(converted) = cr.converted(&dst_ty) else { return false };
        cr.rw.set_before(op);
        let mut input = input;
        if src_bw == 64 {
            if dst_bw >= 16 {
                let r = cr.build(OpData::build("llvm.fptrunc").operands(&[input]), converted);
                cr.replace(op, vec![vec![r]]);
                return true;
            }
            let f32t = Type::Float(FloatKind::F32);
            input = cr.build(OpData::build("llvm.fptrunc").operands(&[input]), vec_of(n, f32t.clone()));
            src_elem = f32t;
            src_bw = 32;
        }
        let Some((src_kind, dst_kind, conv)) = Trunc::of(&src_elem, &dst_elem) else { return false };
        let eff_dst = effective(dst_bw);
        let (src_regs, dst_regs) = (n * src_bw / REG_BITS, n * eff_dst / REG_BITS);
        let regs = Self::bitcast(cr, input, vec_of(src_regs, Type::int(32)));
        let mut out = cr.build(OpData::build("llvm.mlir.undef"), vec_of(dst_regs, Type::int(32)));
        let per_conv = if src_kind == FpKind::F32 { 2 } else { 1 };
        let step = src_bw / eff_dst;
        let result_bw = eff_dst * 2;
        let convs_per_reg = REG_BITS / result_bw;
        let mut src_idx = 0;
        for dst_idx in 0..dst_regs {
            let dst_const = Self::c(cr, dst_idx, 64);
            let value = if convs_per_reg == 1 {
                Self::trunc_one(cr, conv, regs, src_idx, &modes, &relu, &dst_elem, random)
            } else {
                let mut sub = cr.build(OpData::build("llvm.mlir.undef"), vec_of(convs_per_reg, Type::int(result_bw as u32)));
                let (mut at, mut cur) = (convs_per_reg - 1, step);
                while cur > 0 {
                    cur -= per_conv;
                    let r = Self::trunc_one(cr, conv, regs, src_idx + cur, &modes, &relu, &dst_elem, None);
                    sub = Self::insert(cr, sub, r, at);
                    at -= 1;
                }
                Self::bitcast(cr, sub, Type::int(32))
            };
            let ty = cr.rw.body[out].ty.clone();
            out = cr.build(OpData::build("llvm.insertelement").operands(&[out, value, dst_const]), ty);
            src_idx += step;
        }
        let r = if dst_kind == FpKind::F6 {
            let bytes = Self::bitcast(cr, out, vec_of(n, Type::int(8)));
            cr.build(OpData::build("llvm.trunc").operands(&[bytes]), converted)
        } else {
            Self::bitcast(cr, out, converted)
        };
        cr.replace(op, vec![vec![r]]);
        true
    }

    fn ext_one<'a>(cr: &mut Cr<'_, 'a, '_>, conv: Ext, src: ValueId, relu: &Attribute<'a>, src_elem: &Type<'a>) -> ValueId {
        let (name, bf16) = conv.op();
        let mut data = OpData::build(name).operands(&[src]).with("srcType", Attribute::Type(src_elem.clone()));
        if !bf16 {
            data.set("relu", relu.clone());
        }
        let part = Type::Float(if bf16 { FloatKind::BF16 } else { FloatKind::F16 });
        let r = cr.build(data, vec_of(2, part));
        Self::bitcast(cr, r, Type::int(32))
    }

    pub(super) fn lower_extf(cr: &mut Cr<'_, '_, '_>, op: OpId, input: ValueId) -> bool {
        let b = &*cr.rw.body;
        let (src_ty, dst_ty) = (b[b[op].operands[0]].ty.clone(), b[b[op].results[0]].ty.clone());
        let one_d = |t: &Type<'_>| t.dims().is_some_and(|d| d.len() == 1) && matches!(t, Type::Shaped(s) if s.kind == mlirformat::ShapedKind::Vector);
        if !one_d(&src_ty) || !one_d(&dst_ty) {
            return false;
        }
        let relu = b[op].get("relu").cloned().unwrap_or(Attribute::Bool(false));
        let n = src_ty.element_count().unwrap_or(0) as i64;
        let (src_elem, dst_elem) = (src_ty.element_type().owned(), dst_ty.element_type().owned());
        let (src_bw, dst_bw) = (bit_width(&src_ty), bit_width(&dst_ty));
        let Some(converted) = cr.converted(&dst_ty) else { return false };
        cr.rw.set_before(op);
        if src_bw >= 16 && dst_bw >= 32 {
            let r = if src_elem == dst_elem { input } else { cr.build(OpData::build("llvm.fpext").operands(&[input]), converted) };
            cr.replace(op, vec![vec![r]]);
            return true;
        }
        let final_ext = dst_bw >= 32;
        let mid_elem = match (final_ext, &src_elem) {
            (true, Type::Float(FloatKind::F8E8M0FNU)) => Type::Float(FloatKind::BF16),
            (true, _) => Type::Float(FloatKind::F16),
            (false, _) => dst_elem.clone(),
        };
        let mid_bw = if final_ext { 16 } else { dst_bw };
        let eff_src = effective(src_bw);
        let Some(conv) = Ext::of(&src_elem, &mid_elem) else { return false };
        let mut v = input;
        if src_bw == 6 {
            v = cr.build(OpData::build("llvm.zext").operands(&[v]), vec_of(n, Type::int(8)));
        }
        let (src_regs, dst_regs) = (n * eff_src / REG_BITS, n * mid_bw / REG_BITS);
        let regs = Self::bitcast(cr, v, vec_of(src_regs, Type::int(32)));
        let mut out = cr.build(OpData::build("llvm.mlir.undef"), vec_of(dst_regs, Type::int(32)));
        let mut dst_idx = 0;
        for src_idx in 0..src_regs {
            let reg = Self::element(cr, regs, src_idx, Type::int(32));
            if eff_src == F6_CONTAINER {
                let halves = Self::bitcast(cr, reg, vec_of(2, Type::int(16)));
                for half in 0..2 {
                    let h = Self::element(cr, halves, half, Type::int(16));
                    let pair = Self::bitcast(cr, h, vec_of(2, Type::int(8)));
                    let r = Self::ext_one(cr, conv, pair, &relu, &src_elem);
                    out = Self::insert(cr, out, r, dst_idx);
                    dst_idx += 1;
                }
            } else {
                let bytes = Self::bitcast(cr, reg, vec_of(4, Type::int(8)));
                for byte in 0..4 {
                    let pair = Self::element(cr, bytes, byte, Type::int(8));
                    let r = Self::ext_one(cr, conv, pair, &relu, &src_elem);
                    out = Self::insert(cr, out, r, dst_idx);
                    dst_idx += 1;
                }
            }
        }
        let r = if final_ext {
            let mid = Self::bitcast(cr, out, vec_of(n, mid_elem));
            cr.build(OpData::build("llvm.fpext").operands(&[mid]), converted)
        } else {
            Self::bitcast(cr, out, converted)
        };
        cr.replace(op, vec![vec![r]]);
        true
    }

    fn padded(n: i64, src_bw: i64, dst_bw: i64, step: i64) -> i64 {
        let ceil = |x: i64, y: i64| (x + y - 1) / y;
        let (es, ed) = (effective(src_bw), effective(dst_bw));
        let p = (ceil(n * es, REG_BITS) * REG_BITS / es).max(ceil(n * ed, REG_BITS) * REG_BITS / ed);
        ceil(p, step) * step
    }

    pub(super) fn canonicalize_fp(rw: &mut Rewriter<'_, '_>, op: OpId, trunc: bool) -> bool {
        let b = &*rw.body;
        let (in_ty, out_ty) = (b[b[op].operands[0]].ty.clone(), b[b[op].results[0]].ty.clone());
        let (src_elem, dst_elem) = (in_ty.element_type().owned(), out_ty.element_type().owned());
        let (src_bw, dst_bw) = (bit_width(&in_ty), bit_width(&out_ty));
        let (es, ed) = (effective(src_bw), effective(dst_bw));
        let is_vector = matches!(&in_ty, Type::Shaped(s) if s.kind == mlirformat::ShapedKind::Vector);
        let rank = in_ty.dims().map_or(0, |d| d.len());
        let multi = is_vector && rank > 1;
        let n = if is_vector { in_ty.element_count().unwrap_or(0) as i64 } else { 1 };
        let step = if trunc { es / ed } else { ed / es };
        if step == 0 {
            return false;
        }
        let padded = Self::padded(n, src_bw, dst_bw, step);
        let pad = padded != n;
        if is_vector && !multi && !pad {
            return false;
        }
        let mut input = b[op].operands[0];
        rw.set_before(op);
        if !is_vector {
            input = make(rw, OpData::build("vector.broadcast").operands(&[input]), vec_of(1, src_elem.clone()));
        }
        if multi {
            input = make(rw, OpData::build("vector.shape_cast").operands(&[input]), vec_of(n, src_elem.clone()));
        }
        let i64s = |xs: &[i64]| Attribute::Array(xs.iter().map(|x| Attribute::Int { lit: alloc::format!("{x}").into(), ty: None }).collect());
        if pad {
            let pty = vec_of(padded, src_elem.clone());
            let zero = Attribute::Builtin { name: "dense".into(), body: "<0.000000e+00>".into(), ty: Some(pty.clone()) };
            let z = make(rw, OpData::build("arith.constant").with("value", zero), pty.clone());
            input = make(rw, OpData::build("vector.insert_strided_slice").operands(&[input, z]).with("offsets", i64s(&[0])).with("strides", i64s(&[1])), pty);
        }
        let b = &*rw.body;
        let cvt_ty = vec_of(if pad { padded } else { n }, dst_elem);
        let mut operands = vec![input];
        operands.extend(b[op].operands.get(1).copied());
        let mut data = OpData::build(&b[op].name).operands(&operands);
        for name in ["rnd", "sat", "relu"] {
            if let Some(v) = b[op].get(name).cloned() {
                data.set(name, v);
            }
        }
        let mut result = make(rw, data, cvt_ty);
        if pad {
            let ty = vec_of(n, out_ty.element_type().owned());
            result = make(rw, OpData::build("vector.extract_strided_slice").operands(&[result]).with("offsets", i64s(&[0])).with("sizes", i64s(&[n])).with("strides", i64s(&[1])), ty);
        }
        if multi {
            result = make(rw, OpData::build("vector.shape_cast").operands(&[result]), out_ty.clone());
        }
        if !is_vector {
            result = make(rw, OpData::build("vector.extract").operands(&[result]).with("static_position", Attribute::dense_i64(&[0])), out_ty);
        }
        rw.replace_op(op, &[result]);
        true
    }
}
