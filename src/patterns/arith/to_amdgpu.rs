//! `arith` ⇒ `amdgpu` / `rocdl`, as `ArithToAMDGPU.cpp`: fp8 `extf` / `truncf` through the packed
//! conversions, f32 ⇒ f16 through `rocdl.cvt.pkrtz`, the scaled conversions on gfx950.

use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{ApFloat, Attribute, Const, FloatKind, Scalar, ShapedKind, Type};

use crate::{AmdChipset, OpData, OpId, Pattern, PatternSet, Rewriter, ValueId};

type Rw<'r, 'a> = Rewriter<'r, 'a>;

/// `kGfx942`.
const GFX942: AmdChipset = AmdChipset::new(9, 4, 2);
/// `kGfx950`.
const GFX950: AmdChipset = AmdChipset::new(9, 5, 0);

/// `amdgpu::hasOcpFp8`.
fn ocp_fp8(c: AmdChipset) -> bool {
    (c.major == 9 && c.minor >= 5) || c.major >= 12
}

/// `isSupportedF8`.
fn supported_f8(t: &Type<'_>, c: AmdChipset) -> bool {
    if c == GFX942 {
        return matches!(t, Type::Float(FloatKind::F8E4M3FNUZ | FloatKind::F8E5M2FNUZ));
    }
    ocp_fp8(c) && matches!(t, Type::Float(FloatKind::F8E4M3FN | FloatKind::F8E5M2))
}

/// `APFloat::getLargest` of the 8-bit formats `ApFloat` has no layout for.
fn largest_f64(k: FloatKind) -> Option<f64> {
    Some(match k {
        FloatKind::F8E4M3FN => 448.0,
        FloatKind::F8E4M3FNUZ => 240.0,
        FloatKind::F8E5M2 | FloatKind::F8E5M2FNUZ => 57344.0,
        k => ApFloat::largest(k, false).to_f64(),
    })
}

fn vshape(t: &Type<'_>) -> Option<(Vec<i64>, Type<'static>)> {
    match t {
        Type::Shaped(s) if s.kind == ShapedKind::Vector => Some((s.dims()?, (*s.elem).owned())),
        _ => None,
    }
}

fn vty<'a>(shape: &[i64], elem: &Type<'_>) -> Type<'a> {
    Type::vector(shape, &[], elem.owned())
}

fn ints<'a>(v: &[i64]) -> Attribute<'a> {
    Attribute::Array(v.iter().map(|n| Attribute::i64(*n).untyped()).collect())
}

fn i32a<'a>(v: i64) -> Attribute<'a> {
    Attribute::of_int(v.into(), Type::int(32))
}

/// A float zero of `elem` (bits 0 in every format).
fn zero_attr<'a>(elem: &Type<'_>) -> Attribute<'a> {
    let Type::Float(k) = elem else { return Attribute::i64(0) };
    Attribute::Float { lit: "0.000000e+00".into(), ty: Some(Type::Float(*k)) }
}

trait Build<'a> {
    fn mk(&mut self, data: OpData<'a>, ty: Type<'a>) -> ValueId;
    fn vextract(&mut self, v: ValueId, pos: &[i64]) -> ValueId;
    fn vinsert(&mut self, v: ValueId, dest: ValueId, pos: &[i64]) -> ValueId;
    fn extract_slice(&mut self, v: ValueId, offsets: &[i64], sizes: &[i64]) -> ValueId;
    fn insert_slice(&mut self, v: ValueId, dest: ValueId, offsets: &[i64]) -> ValueId;
    fn shape_cast(&mut self, v: ValueId, ty: Type<'a>) -> ValueId;
    fn splat(&mut self, v: ValueId, ty: Type<'a>) -> ValueId;
    fn cast_f32_to(&mut self, des: Type<'a>, v: ValueId) -> ValueId;
    fn cast_to_f32(&mut self, v: ValueId) -> ValueId;
}

impl<'a> Build<'a> for Rw<'_, 'a> {
    fn mk(&mut self, data: OpData<'a>, ty: Type<'a>) -> ValueId {
        let o = self.create(data, &[ty]);
        self.body[o].results[0]
    }

    fn vextract(&mut self, v: ValueId, pos: &[i64]) -> ValueId {
        let (shape, elem) = vshape(&self.body[v].ty).expect("a vector");
        let rest = &shape[pos.len()..];
        let ty = if rest.is_empty() { elem } else { vty(rest, &elem) };
        self.mk(OpData::build("vector.extract").operands(&[v]).with("static_position", Attribute::dense_i64(pos)), ty)
    }

    fn vinsert(&mut self, v: ValueId, dest: ValueId, pos: &[i64]) -> ValueId {
        let ty = self.body[dest].ty.clone();
        self.mk(OpData::build("vector.insert").operands(&[v, dest]).with("static_position", Attribute::dense_i64(pos)), ty)
    }

    fn extract_slice(&mut self, v: ValueId, offsets: &[i64], sizes: &[i64]) -> ValueId {
        let (shape, elem) = vshape(&self.body[v].ty).expect("a vector");
        let mut dims = sizes.to_vec();
        dims.extend_from_slice(&shape[sizes.len()..]);
        let strides = vec![1; offsets.len()];
        self.mk(OpData::build("vector.extract_strided_slice").operands(&[v]).with("offsets", ints(offsets)).with("sizes", ints(sizes)).with("strides", ints(&strides)), vty(&dims, &elem))
    }

    fn insert_slice(&mut self, v: ValueId, dest: ValueId, offsets: &[i64]) -> ValueId {
        let ty = self.body[dest].ty.clone();
        let rank = vshape(&self.body[v].ty).map_or(0, |(s, _)| s.len());
        self.mk(OpData::build("vector.insert_strided_slice").operands(&[v, dest]).with("offsets", ints(offsets)).with("strides", ints(&vec![1; rank])), ty)
    }

    fn shape_cast(&mut self, v: ValueId, ty: Type<'a>) -> ValueId {
        self.mk(OpData::build("vector.shape_cast").operands(&[v]), ty)
    }

    /// `createOrFold<vector::BroadcastOp>`.
    fn splat(&mut self, v: ValueId, ty: Type<'a>) -> ValueId {
        self.create_or_fold(OpData::build("vector.broadcast").operands(&[v]), &[ty])[0]
    }

    /// `castF32To`.
    fn cast_f32_to(&mut self, des: Type<'a>, v: ValueId) -> ValueId {
        let bits = des.element_type().bit_width().unwrap_or(32);
        match bits {
            32 => v,
            b if b < 32 => self.mk(OpData::build("arith.truncf").operands(&[v]), des),
            _ => self.mk(OpData::build("arith.extf").operands(&[v]), des),
        }
    }

    /// `castToF32`.
    fn cast_to_f32(&mut self, v: ValueId) -> ValueId {
        let f32t = Type::Float(FloatKind::F32);
        match self.body[v].ty.bit_width().unwrap_or(32) {
            32 => v,
            b if b < 32 => self.mk(OpData::build("arith.extf").operands(&[v]), f32t),
            _ => self.mk(OpData::build("arith.truncf").operands(&[v]), f32t),
        }
    }
}

/// The patterns `populateArithToAMDGPUConversionPatterns` adds.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum Kind {
    ExtFOnFloat8,
    TruncFToFloat8 { saturate: bool },
    TruncFToFloat16,
    ScalingExtF,
    ScalingTruncF,
}

/// One of the ArithToAMDGPU rewrite patterns.
struct ArithToAmdgpuPattern {
    kind: Kind,
    chipset: AmdChipset,
}

/// The arith ⇒ amdgpu patterns.
pub struct ArithToAmdgpu;

impl ArithToAmdgpu {
    /// `populateArithToAMDGPUConversionPatterns`.
    pub fn patterns(set: &mut PatternSet, chipset: AmdChipset, fp8: bool, saturate: bool, packed_f16_rtz: bool, scaled: bool) {
        let mut add = |kind| {
            set.add(ArithToAmdgpuPattern { kind, chipset });
        };
        if fp8 {
            add(Kind::ExtFOnFloat8);
            add(Kind::TruncFToFloat8 { saturate });
        }
        if packed_f16_rtz {
            add(Kind::TruncFToFloat16);
        }
        if scaled {
            add(Kind::ScalingExtF);
            add(Kind::ScalingTruncF);
        }
    }

    /// `convert-arith-to-amdgpu`'s choice of patterns for `chipset`.
    pub fn for_chipset(set: &mut PatternSet, chipset: AmdChipset, saturate: bool, packed_f16_rtz: bool) {
        Self::patterns(set, chipset, chipset == GFX942 || ocp_fp8(chipset), saturate, packed_f16_rtz, chipset == GFX950);
    }
}

impl Pattern for ArithToAmdgpuPattern {
    fn name(&self) -> &str {
        match self.kind {
            Kind::ExtFOnFloat8 => "ExtFOnFloat8RewritePattern",
            Kind::TruncFToFloat8 { .. } => "TruncFToFloat8RewritePattern",
            Kind::TruncFToFloat16 => "TruncfToFloat16RewritePattern",
            Kind::ScalingExtF => "ScalingExtFRewritePattern",
            Kind::ScalingTruncF => "ScalingTruncFRewritePattern",
        }
    }

    fn root(&self) -> Option<&str> {
        Some(match self.kind {
            Kind::ExtFOnFloat8 => "arith.extf",
            Kind::TruncFToFloat8 { .. } | Kind::TruncFToFloat16 => "arith.truncf",
            Kind::ScalingExtF => "arith.scaling_extf",
            Kind::ScalingTruncF => "arith.scaling_truncf",
        })
    }

    fn rewrite(&self, rw: &mut Rw<'_, '_>, op: OpId) -> bool {
        match self.kind {
            Kind::ExtFOnFloat8 => self.ext_f8(rw, op),
            Kind::TruncFToFloat8 { saturate } => self.trunc_f8(rw, op, saturate),
            Kind::TruncFToFloat16 => Self::trunc_f16(rw, op),
            Kind::ScalingExtF => Self::scaling(rw, op, true),
            Kind::ScalingTruncF => Self::scaling(rw, op, false),
        }
    }
}

impl ArithToAmdgpuPattern {
    fn zero<'a>(rw: &mut Rw<'_, 'a>, elem: &Type<'_>) -> ValueId {
        rw.mk(OpData::build("arith.constant").with("value", zero_attr(elem)), elem.owned())
    }

    /// `ExtFOnFloat8RewritePattern`.
    fn ext_f8(&self, rw: &mut Rw<'_, '_>, op: OpId) -> bool {
        let input = rw.body[op].operands[0];
        let in_ty = rw.body[input].ty.clone();
        let vec_in = vshape(&in_ty);
        let in_elem = vec_in.as_ref().map_or(in_ty.owned(), |(_, e)| e.clone());
        if !supported_f8(&in_elem, self.chipset) {
            return false;
        }
        let out_ty = rw.body[rw.body[op].results[0]].ty.clone();
        let out_elem = out_ty.element_type().owned();
        let f32t = Type::Float(FloatKind::F32);
        rw.set_before(op);
        let Some((in_shape, in_e)) = vec_in else {
            let f = rw.mk(OpData::build("amdgpu.ext_packed_fp8").operands(&[input]).with("index", i32a(0)), f32t);
            let r = rw.cast_f32_to(out_elem, f);
            rw.replace_op(op, &[r]);
            return true;
        };
        let n: i64 = in_shape.iter().product();
        let zero = Self::zero(rw, &out_elem);
        if in_shape.is_empty() {
            let splat = rw.splat(zero, out_ty.clone());
            let s = rw.vextract(input, &[]);
            let e = rw.mk(OpData::build("arith.extf").operands(&[s]), out_elem.clone());
            let r = rw.vinsert(e, splat, &[]);
            rw.replace_op(op, &[r]);
            return true;
        }
        let mut result = rw.splat(zero, vty(&[n], &out_elem));
        let mut input = input;
        let mut in_rank = in_shape.len();
        if in_rank > 1 {
            input = rw.shape_cast(input, vty(&[n], &in_e));
            in_rank = 1;
        }
        let mut i = 0;
        while i < n {
            let this = (n.min(i + 4)) - i;
            let slice = rw.extract_slice(input, &[i], &[this]);
            let mut j = 0;
            while j < this {
                if i + j + 1 < n {
                    let fs = rw.mk(OpData::build("amdgpu.ext_packed_fp8").operands(&[slice]).with("index", i32a(j / 2)), vty(&[2], &f32t));
                    let t = rw.cast_f32_to(vty(&[2], &out_elem), fs);
                    result = rw.insert_slice(t, result, &[i + j]);
                } else {
                    let f = rw.mk(OpData::build("amdgpu.ext_packed_fp8").operands(&[slice]).with("index", i32a(j / 2 * 2)), f32t.clone());
                    let t = rw.cast_f32_to(out_elem.clone(), f);
                    result = rw.vinsert(t, result, &[i + j]);
                }
                j += 2;
            }
            i += 4;
        }
        if in_rank != vshape(&out_ty).map_or(0, |(s, _)| s.len()) {
            result = rw.shape_cast(result, out_ty);
        }
        rw.replace_op(op, &[result]);
        true
    }

    /// `clampInput`: `source` clamped to the target's finite range (non-finite kept).
    fn clamp<'a>(rw: &mut Rw<'_, 'a>, out_elem: &Type<'_>, source: ValueId) -> Option<ValueId> {
        let st = rw.body[source].ty.clone();
        let Type::Float(sk) = st.element_type().clone() else { return None };
        let Type::Float(tk) = out_elem.clone() else { return None };
        let max = largest_f64(tk)?;
        let cst = |rw: &mut Rw<'_, 'a>, x: f64| -> Option<ValueId> {
            let s = Scalar::Float(ApFloat::from_f64(sk, x)?);
            let value: Attribute<'_> = if vshape(&st).is_some() { Const::splat(s, st.clone()).into() } else { Const::scalar(s, st.clone()).into() };
            Some(rw.mk(OpData::build("arith.constant").with("value", value), st.clone()))
        };
        let min_c = cst(rw, -max)?;
        let max_c = cst(rw, max)?;
        let inf = cst(rw, f64::INFINITY)?;
        let neg_inf = cst(rw, f64::NEG_INFINITY)?;
        let i1 = match vshape(&st) {
            Some((s, _)) => vty(&s, &Type::int(1)),
            None => Type::int(1),
        };
        let cmp = |rw: &mut Rw<'_, 'a>, pred: i64, a: ValueId, b: ValueId| rw.create_or_fold(OpData::build("arith.cmpf").operands(&[a, b]).with("predicate", Attribute::i64(pred)), &[i1.clone()])[0];
        // `oeq` 1, `uno` 14.
        let is_inf = cmp(rw, 1, source, inf);
        let is_neg_inf = cmp(rw, 1, source, neg_inf);
        let is_nan = cmp(rw, 14, source, source);
        let or1 = rw.mk(OpData::build("arith.ori").operands(&[is_inf, is_neg_inf]), i1.clone());
        let non_finite = rw.mk(OpData::build("arith.ori").operands(&[or1, is_nan]), i1);
        let below = rw.mk(OpData::build("arith.maximumf").operands(&[source, min_c]), st.clone());
        let clamped = rw.mk(OpData::build("arith.minimumf").operands(&[below, max_c]), st.clone());
        Some(rw.mk(OpData::build("arith.select").operands(&[non_finite, source, clamped]), st))
    }

    fn trunc_2x(rw: &mut Rw<'_, '_>, ty: &Type<'_>, a: ValueId, b: Option<ValueId>, word: i64, existing: Option<ValueId>) -> ValueId {
        let mut ops = vec![a];
        ops.extend(b);
        ops.extend(existing);
        let data = OpData::build("amdgpu.packed_trunc_2xfp8").operands(&ops).segments(&[1, usize::from(b.is_some()), usize::from(existing.is_some())]).with("wordIndex", i32a(word));
        rw.mk(data, ty.owned())
    }

    /// `TruncFToFloat8RewritePattern`.
    fn trunc_f8(&self, rw: &mut Rw<'_, '_>, op: OpId, saturate: bool) -> bool {
        if rw.body[op].get("roundingmode").is_some() {
            return false;
        }
        let out_ty = rw.body[rw.body[op].results[0]].ty.clone();
        let out_vec = vshape(&out_ty);
        let out_elem = out_vec.as_ref().map_or(out_ty.owned(), |(_, e)| e.clone());
        let mut input = rw.body[op].operands[0];
        let in_elem = rw.body[input].ty.element_type().owned();
        if matches!(in_elem, Type::Float(_)) && in_elem.bit_width().is_some_and(|w| w <= 8) && saturate {
            return false;
        }
        if !supported_f8(&out_elem, self.chipset) {
            return false;
        }
        rw.set_before(op);
        if saturate {
            let Some(c) = Self::clamp(rw, &out_elem, input) else { return false };
            input = c;
        }
        let res4 = vty(&[4], &out_elem);
        let in_vec = vshape(&rw.body[input].ty);
        let Some((in_shape, in_e)) = in_vec else {
            let f = rw.cast_to_f32(input);
            let packed = Self::trunc_2x(rw, &res4, f, None, 0, None);
            let r = rw.vextract(packed, &[0]);
            rw.replace_op(op, &[r]);
            return true;
        };
        let Some((out_shape, _)) = out_vec else { return false };
        let n: i64 = out_shape.iter().product();
        let zero = Self::zero(rw, &out_elem);
        if out_shape.is_empty() {
            let s = rw.vextract(input, &[]);
            let t = rw.mk(OpData::build("arith.truncf").operands(&[s]), out_elem.clone());
            let r = rw.vinsert(t, zero, &[]);
            rw.replace_op(op, &[r]);
            return true;
        }
        let mut result = rw.splat(zero, vty(&[n], &out_elem));
        let mut in_rank = in_shape.len();
        if in_rank > 1 {
            input = rw.shape_cast(input, vty(&[n], &in_e));
            in_rank = 1;
        }
        let mut i = 0;
        while i < n {
            let this = n.min(i + 4) - i;
            let mut acc = None;
            let mut j = 0;
            while j < this {
                let a = rw.vextract(input, &[i + j]);
                let fa = rw.cast_to_f32(a);
                let fb = if j + 1 < this {
                    let b = rw.vextract(input, &[i + j + 1]);
                    Some(rw.cast_to_f32(b))
                } else {
                    None
                };
                acc = Some(Self::trunc_2x(rw, &res4, fa, fb, j / 2, acc));
                j += 2;
            }
            let mut part = acc.expect("a slice");
            if this < 4 {
                part = rw.extract_slice(part, &[0], &[this]);
            }
            result = rw.insert_slice(part, result, &[i]);
            i += 4;
        }
        if in_rank != out_shape.len() {
            result = rw.shape_cast(result, out_ty);
        }
        rw.replace_op(op, &[result]);
        true
    }

    /// `TruncfToFloat16RewritePattern`: `rocdl.cvt.pkrtz` two at a time.
    fn trunc_f16(rw: &mut Rw<'_, '_>, op: OpId) -> bool {
        let out_ty = rw.body[rw.body[op].results[0]].ty.clone();
        let mut input = rw.body[op].operands[0];
        let in_elem = rw.body[input].ty.element_type().owned();
        let out_elem = out_ty.element_type().owned();
        if out_elem != Type::Float(FloatKind::F16) || in_elem != Type::Float(FloatKind::F32) {
            return false;
        }
        let f32t = Type::Float(FloatKind::F32);
        rw.set_before(op);
        let pk = |rw: &mut Rw<'_, '_>, a: ValueId, b: ValueId| rw.mk(OpData::build("rocdl.cvt.pkrtz").operands(&[a, b]), vty(&[2], &Type::Float(FloatKind::F16)));
        let Some((in_shape, in_e)) = vshape(&rw.body[input].ty) else {
            let b = rw.mk(OpData::build("llvm.mlir.poison"), f32t);
            let p = pk(rw, input, b);
            let r = rw.vextract(p, &[0]);
            rw.replace_op(op, &[r]);
            return true;
        };
        let Some((out_shape, _)) = vshape(&out_ty) else { return false };
        let n: i64 = out_shape.iter().product();
        let zero = rw.create_or_fold(OpData::build("arith.constant").with("value", zero_attr(&out_elem)), &[out_elem.clone()])[0];
        let mut result = rw.splat(zero, out_ty.clone());
        let mut in_rank = in_shape.len();
        if in_rank > 1 {
            input = rw.shape_cast(input, vty(&[n], &in_e));
            in_rank = 1;
        }
        let mut i = 0;
        while i < n {
            let this = n.min(i + 2) - i;
            let a = rw.vextract(input, &[i]);
            let mut b = rw.mk(OpData::build("llvm.mlir.poison"), f32t.clone());
            if this == 2 {
                b = rw.vextract(input, &[i + 1]);
            }
            let p = pk(rw, a, b);
            let part = rw.extract_slice(p, &[0], &[this]);
            result = rw.insert_slice(part, result, &[i]);
            i += 2;
        }
        if in_rank != out_shape.len() {
            result = rw.shape_cast(result, out_ty);
        }
        rw.replace_op(op, &[result]);
        true
    }

    /// `getOriginalVectorValue`: through shape casts, and one broadcast.
    fn original_vector(rw: &Rw<'_, '_>, mut v: ValueId) -> ValueId {
        while let Some(d) = rw.body.def_op(v) {
            match &*rw.body[d].name {
                "vector.shape_cast" => v = rw.body[d].operands[0],
                "vector.broadcast" => {
                    v = rw.body[d].operands[0];
                    break;
                }
                _ => break,
            }
        }
        v
    }

    /// `ScalingExtFRewritePattern` / `ScalingTruncFRewritePattern`: block by block with one
    /// scale each.
    fn scaling(rw: &mut Rw<'_, '_>, op: OpId, ext: bool) -> bool {
        let (input, scale_orig) = (rw.body[op].operands[0], rw.body[op].operands[1]);
        let out_ty = rw.body[rw.body[op].results[0]].ty.clone();
        let in_elem = rw.body[input].ty.element_type().owned();
        let out_elem = out_ty.element_type().owned();
        let scale_ty = rw.body[scale_orig].ty.clone();
        let f32t = Type::Float(FloatKind::F32);
        rw.set_before(op);
        let mut scale = scale_orig;
        let scale_f32 = match vshape(&scale_ty) {
            Some((s, _)) => vty(&s, &f32t),
            None => f32t.clone(),
        };
        match scale_ty.element_type().bit_width().unwrap_or(32) {
            b if b < 32 => scale = rw.mk(OpData::build("arith.extf").operands(&[scale]), scale_f32),
            b if b > 32 => scale = rw.mk(OpData::build("arith.truncf").operands(&[scale]), scale_f32),
            _ => {}
        }
        let (in_bits, out_bits) = (in_elem.bit_width().unwrap_or(8) as i64, out_elem.bit_width().unwrap_or(8) as i64);
        // ext: 32 / in-width inputs give 2 outputs; trunc: 2 inputs give 32 / out-width outputs.
        let (in_width, out_width) = if ext { (32 / in_bits, 2) } else { (2, 32 / out_bits) };
        let res_ty = vty(&[if ext { 2 } else { out_width }], &out_elem);
        let ext_op = |rw: &mut Rw<'_, '_>, src: ValueId, s: ValueId, index: i64, existing: Option<ValueId>| {
            let mut ops = vec![src, s];
            ops.extend(existing);
            let name = if ext { "amdgpu.scaled_ext_packed" } else { "amdgpu.packed_scaled_trunc" };
            rw.mk(OpData::build(name).operands(&ops).with("index", i32a(index)), res_ty.clone())
        };
        let zero_of = |rw: &mut Rw<'_, '_>| rw.mk(OpData::build("arith.constant").with("value", zero_attr(&out_elem)), out_elem.clone());
        let Some((in_shape, _)) = vshape(&rw.body[input].ty) else {
            if !ext {
                let _ = zero_of(rw);
            }
            let cast = rw.mk(OpData::build("vector.broadcast").operands(&[input]), vty(&[1], &in_elem));
            let r = ext_op(rw, cast, scale, 0, None);
            let r = rw.vextract(r, &[0]);
            rw.replace_op(op, &[r]);
            return true;
        };
        let zero = zero_of(rw);
        let orig = Self::original_vector(rw, scale_orig);
        let mut scale_shape = vshape(&rw.body[orig].ty).map(|(s, _)| s).unwrap_or_default();
        scale_shape.resize(in_shape.len(), 1);
        let ratio: Vec<i64> = in_shape.iter().zip(&scale_shape).map(|(a, b)| if *b != 0 && a % b == 0 { a / b } else { 1 }).collect();
        let block: i64 = ratio.iter().product();
        let mut result = rw.splat(zero, out_ty.clone());
        // `StaticTileOffsetRange`: the tiles of `ratio` in row-major order.
        let counts: Vec<i64> = in_shape.iter().zip(&ratio).map(|(a, r)| a / r).collect();
        let tiles: i64 = counts.iter().product();
        for t in 0..tiles {
            let mut rest = t;
            let mut offsets = vec![0; in_shape.len()];
            for d in (0..in_shape.len()).rev() {
                offsets[d] = (rest % counts[d]) * ratio[d];
                rest /= counts[d];
            }
            let blk = rw.extract_slice(input, &offsets, &ratio);
            let blk1 = rw.shape_cast(blk, vty(&[block], &in_elem));
            let uniform = rw.vextract(scale, &offsets);
            let mut blk_res = rw.splat(zero, vty(&[block], &out_elem));
            let mut i = 0;
            while i < block {
                if ext {
                    let in_w = in_width.min(block - i);
                    let slice = rw.extract_slice(blk1, &[i], &[in_w]);
                    let mut j = 0;
                    while j < in_w {
                        let out_w = out_width.min(in_w - j);
                        let mut e = ext_op(rw, slice, uniform, j / out_width, None);
                        if out_w < out_width {
                            e = rw.extract_slice(e, &[0], &[out_w]);
                        }
                        blk_res = rw.insert_slice(e, blk_res, &[i + j]);
                        j += out_w;
                    }
                    i += in_w;
                } else {
                    let out_w = out_width.min(block - i);
                    let mut tr = if out_w <= in_width {
                        let slice = rw.extract_slice(blk1, &[i], &[out_w]);
                        ext_op(rw, slice, uniform, 0, None)
                    } else {
                        let mut acc = rw.mk(OpData::build("vector.broadcast").operands(&[zero]), res_ty.clone());
                        let mut j = 0;
                        while j < out_w {
                            let in_w = in_width.min(out_w - j);
                            let slice = rw.extract_slice(blk1, &[i + j], &[in_w]);
                            acc = ext_op(rw, slice, uniform, j / in_width, Some(acc));
                            j += in_width;
                        }
                        acc
                    };
                    if out_w != out_width {
                        tr = rw.extract_slice(tr, &[0], &[out_w]);
                    }
                    blk_res = rw.insert_slice(tr, blk_res, &[i]);
                    i += out_w;
                }
            }
            let cast = rw.shape_cast(blk_res, vty(&ratio, &out_elem));
            result = rw.insert_slice(cast, result, &offsets);
        }
        rw.replace_op(op, &[result]);
        true
    }
}
