//! `vector` ⇒ `spirv`, as `VectorToSPIRV.cpp` (the dot-product reductions aside).

use alloc::vec;
use alloc::vec::Vec;

use crate::patterns;
use mlirformat::spirv_types::SpirvType;
use mlirformat::{ApFloat, Attribute, Const, Scalar, Type};

use super::{SpirvTypes, TargetEnv};
use crate::{ConversionRewriter, OpData, OpId, ValueId};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

/// What the vector patterns need of the type converter.
#[derive(Debug, Clone, Copy)]
pub struct VectorSpirvOptions {
    pub index64: bool,
    pub kernel: bool,
}

/// The vector ⇒ spirv patterns (`populateVectorToSPIRVPatterns`).
pub struct VectorToSpirv;

/// `vector::ExtractOp::kPoisonIndex`.
const POISON: i64 = -1;

impl VectorToSpirv {
    fn i32_array<'a>(xs: &[i64]) -> Attribute<'a> {
        Attribute::Array(xs.iter().map(|x| Attribute::integer(i128::from(*x), Type::int(32))).collect())
    }

    fn ints(a: Option<&Attribute<'_>>) -> Vec<i64> {
        match a {
            Some(Attribute::Array(es)) => es
                .iter()
                .filter_map(|e| match e {
                    Attribute::Int { lit, .. } => lit.parse().ok(),
                    e => Const::try_from(e).ok()?.as_int().map(|i| i.signed() as i64),
                })
                .collect(),
            Some(Attribute::DenseArray { values, .. }) => values.iter().filter_map(|v| v.parse().ok()).collect(),
            _ => Vec::new(),
        }
    }

    fn scalar(t: &Type<'_>) -> bool {
        TargetEnv::is_scalar(t)
    }

    fn result_ty<'a>(cr: &Cr<'_, 'a, '_>, op: OpId, i: usize) -> Option<Type<'a>> {
        let r = cr.rw.body[op].results[i];
        cr.converted(&cr.rw.body[r].ty)
    }

    fn extract<'a>(cr: &mut Cr<'_, 'a, '_>, v: ValueId, i: i64, ty: Type<'a>) -> ValueId {
        cr.build(OpData::build("spirv.CompositeExtract").operands(&[v]).with("indices", Self::i32_array(&[i])), ty)
    }

    /// `sanitizeDynamicIndex`.
    fn sanitize<'a>(cr: &mut Cr<'_, 'a, '_>, index: ValueId, size: i64) -> ValueId {
        let ty = cr.rw.body[index].ty.clone();
        if (size as u64).is_power_of_two() {
            let m = cr.spirv_const(ty.clone(), Attribute::integer(i128::from(size - 1), ty.clone()));
            return cr.build(OpData::build("spirv.BitwiseAnd").operands(&[index, m]), ty);
        }
        let p = cr.spirv_const(ty.clone(), Attribute::integer(i128::from(POISON), ty.clone()));
        let c = cr.build(OpData::build("spirv.IEqual").operands(&[index, p]), Type::I1);
        let zero = cr.spirv_int_like(&ty, 0);
        cr.build(OpData::build("spirv.Select").operands(&[c, zero, index]), ty)
    }

    fn element_count(cr: &Cr<'_, '_, '_>, v: ValueId) -> i64 {
        cr.rw.body[v].ty.element_count().unwrap_or(1) as i64
    }

    /// The `(lhs, next)` combiner of a reduction kind.
    fn combine<'a>(cr: &mut Cr<'_, 'a, '_>, kind: &str, ty: &Type<'a>, l: ValueId, r: ValueId, gl: bool) -> Option<ValueId> {
        let float = matches!(ty, Type::Float(_));
        let name = match (kind, float, gl) {
            ("add", false, _) => "spirv.IAdd",
            ("add", true, _) => "spirv.FAdd",
            ("mul", false, _) => "spirv.IMul",
            ("mul", true, _) => "spirv.FMul",
            ("minui", _, true) => "spirv.GL.UMin",
            ("minsi", _, true) => "spirv.GL.SMin",
            ("maxui", _, true) => "spirv.GL.UMax",
            ("maxsi", _, true) => "spirv.GL.SMax",
            ("minui", _, false) => "spirv.CL.u_min",
            ("minsi", _, false) => "spirv.CL.s_min",
            ("maxui", _, false) => "spirv.CL.u_max",
            ("maxsi", _, false) => "spirv.CL.s_max",
            _ => return None,
        };
        Some(cr.build(OpData::build(name).operands(&[l, r]), ty.clone()))
    }

    /// `getReductionInfo` and the element by element combination.
    fn reduce<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, ops: &[ValueId], f: &dyn Fn(&mut Cr<'_, 'a, '_>, &str, &Type<'a>, ValueId, ValueId) -> Option<ValueId>) -> bool {
        let Some(ty) = Self::result_ty(cr, op, 0) else { return false };
        let src = cr.rw.body[cr.rw.body[op].operands[0]].ty.clone();
        if src.shape().is_none_or(|s| s.len() != 1) {
            return false;
        }
        let Some(Attribute::Extended { ext, .. }) = cr.rw.body[op].get("kind") else { return false };
        let kind = alloc::string::String::from(ext.body.as_deref().unwrap_or("").trim_matches(['<', '>']));
        let n = src.element_count().unwrap_or(0) as i64;
        let elem = src.element_type().clone();
        let mut values: Vec<ValueId> = (0..n).map(|i| Self::extract(cr, ops[0], i, elem.clone())).collect();
        values.extend(ops.get(1).copied());
        let mut acc = values[0];
        for next in &values[1..] {
            let Some(v) = f(cr, &kind, &ty, acc, *next) else { return false };
            acc = v;
        }
        cr.replace_values(op, &[acc]);
        true
    }

    /// `vector.load` / `vector.store`'s element pointer, bitcast to a vector pointer.
    fn vector_ptr<'a>(cr: &mut Cr<'_, 'a, '_>, mt: &Type<'a>, base: ValueId, indices: &[ValueId], vt: &Type<'a>, o: VectorSpirvOptions) -> Option<ValueId> {
        let Type::Shaped(s) = mt else { return None };
        let storage = SpirvTypes::storage_class(s)?;
        let mo = super::MemrefSpirvOptions { index64: o.index64, kernel: o.kernel, bool_bits: 8 };
        let ptr = super::MemrefToSpirv::element_ptr(cr, s, base, indices, mo)?;
        if vt.element_count() == Some(1) {
            return Some(ptr);
        }
        Some(cr.build(OpData::build("spirv.Bitcast").operands(&[ptr]), SpirvType::ptr(vt.clone(), &storage)))
    }

    fn alignment<'a>(cr: &Cr<'_, 'a, '_>, op: OpId) -> Option<Vec<(&'static str, Attribute<'a>)>> {
        let a = Const::try_from(cr.rw.body[op].get("alignment")?).ok()?.as_int()?.bits();
        Some(vec![("memory_access", Cr::spirv_enum("memory_access", "Aligned")), ("alignment", Attribute::integer(a as i128, Type::int(32)))])
    }
}

#[patterns(converter, options = VectorSpirvOptions)]
impl VectorToSpirv {
    /// `VectorBitcastConvert`.
    #[lowering("vector.bitcast")]
    fn bitcast<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: VectorSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let Some(dst) = Self::result_ty(cr, op, 0) else { return false };
        let src = cr.rw.body[ops[0]].ty.clone();
        if dst == src {
            cr.replace_values(op, &[ops[0]]);
            return true;
        }
        let bits = |t: &Type<'_>| t.element_count().unwrap_or(1) as u32 * t.element_type().bit_width().unwrap_or(0);
        if bits(&dst) != bits(&src) {
            return false;
        }
        let v = cr.build(OpData::build("spirv.Bitcast").operands(&ops), dst);
        cr.replace_values(op, &[v]);
        true
    }

    /// `VectorBroadcastConvert` (then `VectorScalarBroadcastPattern`, its equal from a
    /// scalar).
    #[lowering("vector.broadcast")]
    fn broadcast<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: VectorSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let Some(ty) = Self::result_ty(cr, op, 0) else { return false };
        if Self::scalar(&ty) {
            cr.replace_values(op, &[ops[0]]);
            return true;
        }
        let r = cr.rw.body[op].results[0];
        let n = cr.rw.body[r].ty.element_count().unwrap_or(1);
        let v = cr.build(OpData::build("spirv.CompositeConstruct").operands(&vec![ops[0]; n as usize]), ty);
        cr.replace_values(op, &[v]);
        true
    }

    /// `VectorExtractOpConvert`.
    #[lowering("vector.extract")]
    fn extract_op<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: VectorSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let Some(ty) = Self::result_ty(cr, op, 0) else { return false };
        if Self::scalar(&cr.rw.body[ops[0]].ty) {
            cr.replace_values(op, &[ops[0]]);
            return true;
        }
        let pos = Self::ints(cr.rw.body[op].get("static_position"));
        let v = match pos.first() {
            Some(&p) if p != i64::MIN => {
                if p == POISON {
                    return false;
                }
                Self::extract(cr, ops[0], p, ty)
            }
            _ => {
                let n = Self::element_count(cr, cr.rw.body[op].operands[0]);
                let i = Self::sanitize(cr, ops[1], n);
                cr.build(OpData::build("spirv.VectorExtractDynamic").operands(&[ops[0], i]), ty)
            }
        };
        cr.replace_values(op, &[v]);
        true
    }

    /// `VectorExtractStridedSliceOpConvert`.
    #[lowering("vector.extract_strided_slice")]
    fn extract_strided_slice<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: VectorSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let Some(ty) = Self::result_ty(cr, op, 0) else { return false };
        let d = &cr.rw.body[op];
        let (offset, size, stride) = (Self::ints(d.get("offsets"))[0], Self::ints(d.get("sizes"))[0], Self::ints(d.get("strides"))[0]);
        if stride != 1 {
            return false;
        }
        let v = if Self::scalar(&ty) {
            Self::extract(cr, ops[0], offset, ty)
        } else {
            let idx: Vec<i64> = (offset..offset + size).collect();
            cr.build(OpData::build("spirv.VectorShuffle").operands(&[ops[0], ops[0]]).with("components", Self::i32_array(&idx)), ty)
        };
        cr.replace_values(op, &[v]);
        true
    }

    /// `VectorFmaOpConvert`: GLSL's `Fma`, else OpenCL's.
    #[lowering("vector.fma")]
    fn fma_gl<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: VectorSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let Some(ty) = Self::result_ty(cr, op, 0) else { return false };
        let v = cr.build(OpData::build("spirv.GL.Fma").operands(&ops), ty);
        cr.replace_values(op, &[v]);
        true
    }

    #[lowering("vector.fma")]
    fn fma_cl<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: VectorSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let Some(ty) = Self::result_ty(cr, op, 0) else { return false };
        let v = cr.build(OpData::build("spirv.CL.fma").operands(&ops), ty);
        cr.replace_values(op, &[v]);
        true
    }

    /// `VectorFromElementsOpConvert`.
    #[lowering("vector.from_elements")]
    fn from_elements<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: VectorSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let Some(ty) = Self::result_ty(cr, op, 0) else { return false };
        let v = if Self::scalar(&ty) { ops[0] } else { cr.build(OpData::build("spirv.CompositeConstruct").operands(&ops), ty) };
        cr.replace_values(op, &[v]);
        true
    }

    /// `VectorToElementOpConvert`.
    #[lowering("vector.to_elements")]
    fn to_elements<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: VectorSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let results = cr.rw.body[op].results.clone();
        if Self::scalar(&cr.rw.body[ops[0]].ty) {
            cr.replace_values(op, &[ops[0]]);
            return true;
        }
        let Some(ty) = cr.converted(&cr.rw.body[results[0]].ty.clone()) else { return false };
        // A dead element is not extracted: it is replaced by nothing.
        let mut out = Vec::new();
        for (i, r) in results.iter().enumerate() {
            if cr.rw.body[*r].uses.is_empty() {
                out.push(Vec::new());
                continue;
            }
            out.push(vec![Self::extract(cr, ops[0], i as i64, ty.clone())]);
        }
        cr.replace(op, out);
        true
    }

    /// `VectorInsertOpConvert`.
    #[lowering("vector.insert")]
    fn insert<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: VectorSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let orig = cr.rw.body[op].operands.clone();
        if matches!(cr.rw.body[orig[0]].ty, Type::Shaped(_)) {
            return false;
        }
        let dest_t = cr.rw.body[orig[1]].ty.clone();
        if cr.converted(&dest_t).is_none() {
            return false;
        }
        if dest_t.element_count() == Some(1) {
            cr.replace_values(op, &[ops[0]]);
            return true;
        }
        let ty = cr.rw.body[ops[1]].ty.clone();
        let pos = Self::ints(cr.rw.body[op].get("static_position"));
        let v = match pos.first() {
            Some(&p) if p != i64::MIN => {
                if p == POISON {
                    return false;
                }
                cr.build(OpData::build("spirv.CompositeInsert").operands(&[ops[0], ops[1]]).with("indices", Self::i32_array(&[p])), ty)
            }
            _ => {
                let n = dest_t.element_count().unwrap_or(1) as i64;
                let i = Self::sanitize(cr, ops[2], n);
                // Upstream inserts into the unconverted destination.
                cr.build(OpData::build("spirv.VectorInsertDynamic").operands(&[orig[1], ops[0], i]), dest_t.clone())
            }
        };
        cr.replace_values(op, &[v]);
        true
    }

    /// `VectorInsertStridedSliceOpConvert`.
    #[lowering("vector.insert_strided_slice")]
    fn insert_strided_slice<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: VectorSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let (src, dst) = (ops[0], ops[ops.len() - 1]);
        let d = &cr.rw.body[op];
        let (offset, stride) = (Self::ints(d.get("offsets"))[0], Self::ints(d.get("strides"))[0]);
        if stride != 1 {
            return false;
        }
        let dty = cr.rw.body[dst].ty.clone();
        let v = if Self::scalar(&cr.rw.body[src].ty) {
            cr.build(OpData::build("spirv.CompositeInsert").operands(&[src, dst]).with("indices", Self::i32_array(&[offset])), dty)
        } else {
            let total = dty.element_count().unwrap_or(0) as i64;
            let size = Self::element_count(cr, src);
            let mut idx: Vec<i64> = (0..total).collect();
            for (k, i) in idx[offset as usize..(offset + size) as usize].iter_mut().enumerate() {
                *i = total + k as i64;
            }
            cr.build(OpData::build("spirv.VectorShuffle").operands(&[dst, src]).with("components", Self::i32_array(&idx)), dty)
        };
        cr.replace_values(op, &[v]);
        true
    }

    /// `VectorReductionPattern` (GLSL's min / max, else OpenCL's).
    #[lowering("vector.reduction")]
    fn reduction_gl<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: VectorSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        Self::reduce(cr, op, &ops, &|cr, k, t, l, r| Self::combine(cr, k, t, l, r, true))
    }

    #[lowering("vector.reduction")]
    fn reduction_cl<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: VectorSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        Self::reduce(cr, op, &ops, &|cr, k, t, l, r| Self::combine(cr, k, t, l, r, false))
    }

    /// `VectorReductionFloatMinMax` (OpenCL's, else GLSL's).
    #[lowering("vector.reduction")]
    fn reduction_float_cl<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: VectorSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        Self::reduce(cr, op, &ops, &|cr, k, t, l, r| {
            let n = match k {
                "maximumf" | "maxnumf" => "spirv.CL.fmax",
                "minimumf" | "minnumf" => "spirv.CL.fmin",
                _ => return None,
            };
            Some(cr.build(OpData::build(n).operands(&[l, r]), t.clone()))
        })
    }

    #[lowering("vector.reduction")]
    fn reduction_float_gl<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: VectorSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        Self::reduce(cr, op, &ops, &|cr, k, t, l, r| {
            let n = match k {
                "maximumf" | "maxnumf" => "spirv.GL.FMax",
                "minimumf" | "minnumf" => "spirv.GL.FMin",
                _ => return None,
            };
            Some(cr.build(OpData::build(n).operands(&[l, r]), t.clone()))
        })
    }

    /// `VectorReductionToFPDotProd`: a float `add` reduction as `spirv.Dot` (of the operands
    /// of an `arith.mulf`, else with ones), ahead of the generic patterns.
    #[lowering("vector.reduction", benefit = 2)]
    fn reduction_dot<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: VectorSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        if !matches!(cr.rw.body[op].get("kind"), Some(Attribute::Extended { ext, .. }) if ext.body.as_deref().unwrap_or("").trim_matches(['<', '>']) == "add") {
            return false;
        }
        let Some(ty @ Type::Float(_)) = Self::result_ty(cr, op, 0) else { return false };
        let (vec, acc) = (ops[0], ops.get(1).copied());
        let vt = cr.rw.body[vec].ty.clone();
        let Type::Shaped(vs) = &vt else {
            match acc {
                Some(acc) => {
                    cr.replace_new(op, OpData::build("spirv.FAdd").operands(&[acc, vec]), &[ty]);
                }
                None => cr.replace_values(op, &[vec]),
            }
            return true;
        };
        let (lhs, rhs) = match cr.rw.body.def_op(vec).filter(|d| cr.rw.body[*d].name == "arith.mulf") {
            Some(mul) => (cr.rw.body[mul].operands[0], cr.rw.body[mul].operands[1]),
            None => {
                let Type::Float(k) = *vs.elem else { return false };
                let one = Const::splat(Scalar::Float(ApFloat::from_f64(k, 1.0).expect("a float")), vt.clone());
                (vec, cr.spirv_const(vt.clone(), one.into()))
            }
        };
        let mut res = cr.build(OpData::build("spirv.Dot").operands(&[lhs, rhs]), ty.clone());
        if let Some(acc) = acc {
            res = cr.build(OpData::build("spirv.FAdd").operands(&[acc, res]), ty);
        }
        cr.replace_values(op, &[res]);
        true
    }

    /// `VectorShapeCast`.
    #[lowering("vector.shape_cast")]
    fn shape_cast<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: VectorSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let Some(ty) = Self::result_ty(cr, op, 0) else { return false };
        let r = cr.rw.body[op].results[0];
        if ty == cr.rw.body[ops[0]].ty || cr.rw.body[r].ty.element_count() == Some(1) {
            cr.replace_values(op, &[ops[0]]);
            return true;
        }
        false
    }

    /// `VectorShuffleOpConvert`.
    #[lowering("vector.shuffle")]
    fn shuffle<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: VectorSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let Some(ty) = Self::result_ty(cr, op, 0) else { return false };
        let mask = Self::ints(cr.rw.body[op].get("mask"));
        let orig = cr.rw.body[op].operands.clone();
        let (n1, n2) = (Self::element_count(cr, orig[0]), Self::element_count(cr, orig[1]));
        let r = cr.rw.body[op].results[0];
        if n1 > 1 && n2 > 1 && cr.rw.body[r].ty.element_count().unwrap_or(1) > 1 {
            let v = cr.build(OpData::build("spirv.VectorShuffle").operands(&[ops[0], ops[1]]).with("components", Self::i32_array(&mask)), ty);
            cr.replace_values(op, &[v]);
            return true;
        }
        let mut parts = Vec::new();
        for m in &mask {
            let (vec, i) = if *m >= n1 { (ops[1], m - n1) } else { (ops[0], *m) };
            let vt = cr.rw.body[vec].ty.clone();
            parts.push(if Self::scalar(&vt) { vec } else { Self::extract(cr, vec, i, vt.element_type().clone()) });
        }
        let v = if parts.len() == 1 { parts[0] } else { cr.build(OpData::build("spirv.CompositeConstruct").operands(&parts), ty) };
        cr.replace_values(op, &[v]);
        true
    }

    /// `VectorInterleaveOpConvert`.
    #[lowering("vector.interleave")]
    fn interleave<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: VectorSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let Some(ty) = Self::result_ty(cr, op, 0) else { return false };
        let n = Self::element_count(cr, cr.rw.body[op].operands[0]);
        let v = if n == 1 {
            cr.build(OpData::build("spirv.CompositeConstruct").operands(&ops), ty)
        } else {
            let idx: Vec<i64> = (0..2 * n).map(|i| (if i % 2 == 1 { n } else { 0 }) + i / 2).collect();
            cr.build(OpData::build("spirv.VectorShuffle").operands(&ops).with("components", Self::i32_array(&idx)), ty)
        };
        cr.replace_values(op, &[v]);
        true
    }

    /// `VectorDeinterleaveOpConvert`.
    #[lowering("vector.deinterleave")]
    fn deinterleave<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: VectorSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let Some(ty) = Self::result_ty(cr, op, 0) else { return false };
        let n = Self::element_count(cr, cr.rw.body[op].operands[0]);
        let (a, b) = if n == 2 {
            (Self::extract(cr, ops[0], 0, ty.clone()), Self::extract(cr, ops[0], 1, ty))
        } else {
            let even: Vec<i64> = (0..n / 2).map(|i| i * 2).collect();
            let odd: Vec<i64> = (0..n / 2).map(|i| i * 2 + 1).collect();
            let a = cr.build(OpData::build("spirv.VectorShuffle").operands(&[ops[0], ops[0]]).with("components", Self::i32_array(&even)), ty.clone());
            let b = cr.build(OpData::build("spirv.VectorShuffle").operands(&[ops[0], ops[0]]).with("components", Self::i32_array(&odd)), ty);
            (a, b)
        };
        cr.replace_values(op, &[a, b]);
        true
    }

    /// `VectorLoadOpConverter`.
    #[lowering("vector.load")]
    fn load<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], o: VectorSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let mt = cr.rw.body[cr.rw.body[op].operands[0]].ty.clone();
        let r = cr.rw.body[op].results[0];
        let Some(vt) = cr.converted(&cr.rw.body[r].ty.clone()) else { return false };
        let Some(ptr) = Self::vector_ptr(cr, &mt, ops[0], &ops[1..], &vt, o) else { return false };
        let mut data = OpData::build("spirv.Load").operands(&[ptr]);
        for (k, v) in Self::alignment(cr, op).unwrap_or_default() {
            data.set(k, v);
        }
        let v = cr.build(data, vt);
        cr.replace_values(op, &[v]);
        true
    }

    /// `VectorStoreOpConverter`.
    #[lowering("vector.store")]
    fn store<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], o: VectorSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let mt = cr.rw.body[cr.rw.body[op].operands[1]].ty.clone();
        let vt = cr.rw.body[cr.rw.body[op].operands[0]].ty.clone();
        let Some(ptr) = Self::vector_ptr(cr, &mt, ops[1], &ops[2..], &vt, o) else { return false };
        let mut data = OpData::build("spirv.Store").operands(&[ptr, ops[0]]);
        for (k, v) in Self::alignment(cr, op).unwrap_or_default() {
            data.set(k, v);
        }
        cr.replace_new(op, data, &[]);
        true
    }

    /// `VectorStepOpConvert`.
    #[lowering("vector.step")]
    fn step<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, _: &[Vec<ValueId>], o: VectorSpirvOptions) -> bool {
        let Some(ty) = Self::result_ty(cr, op, 0) else { return false };
        let r = cr.rw.body[op].results[0];
        let n = cr.rw.body[r].ty.element_count().unwrap_or(1) as i64;
        let it = Type::int(if o.index64 { 64 } else { 32 });
        if n == 1 {
            let z = cr.spirv_int_like(&it, 0);
            cr.replace_values(op, &[z]);
            return true;
        }
        let parts: Vec<ValueId> = (0..n).map(|i| cr.spirv_const(it.clone(), Attribute::integer(i128::from(i), it.clone()))).collect();
        let v = cr.build(OpData::build("spirv.CompositeConstruct").operands(&parts), ty);
        cr.replace_values(op, &[v]);
        true
    }
}
