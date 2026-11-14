use alloc::vec::Vec;

use mlirformat::llvm_types::LlvmType;
use mlirformat::{FloatKind, Type};

use crate::patterns;
use crate::{AmdChipset, ConversionRewriter, LibFns, OpData, OpId, ValueId};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

const OCML: [(&str, LibFns); 29] = [
    ("math.acos", LibFns::half("__ocml_acos_f32", "__ocml_acos_f64", "__ocml_acos_f16")),
    ("math.acosh", LibFns::half("__ocml_acosh_f32", "__ocml_acosh_f64", "__ocml_acosh_f16")),
    ("math.asin", LibFns::half("__ocml_asin_f32", "__ocml_asin_f64", "__ocml_asin_f16")),
    ("math.asinh", LibFns::half("__ocml_asinh_f32", "__ocml_asinh_f64", "__ocml_asinh_f16")),
    ("math.atan", LibFns::half("__ocml_atan_f32", "__ocml_atan_f64", "__ocml_atan_f16")),
    ("math.atanh", LibFns::half("__ocml_atanh_f32", "__ocml_atanh_f64", "__ocml_atanh_f16")),
    ("math.atan2", LibFns::half("__ocml_atan2_f32", "__ocml_atan2_f64", "__ocml_atan2_f16")),
    ("math.cbrt", LibFns::half("__ocml_cbrt_f32", "__ocml_cbrt_f64", "__ocml_cbrt_f16")),
    ("math.ceil", LibFns::half("__ocml_ceil_f32", "__ocml_ceil_f64", "__ocml_ceil_f16")),
    ("math.cos", LibFns::half("__ocml_cos_f32", "__ocml_cos_f64", "__ocml_cos_f16")),
    ("math.cosh", LibFns::half("__ocml_cosh_f32", "__ocml_cosh_f64", "__ocml_cosh_f16")),
    ("math.sinh", LibFns::half("__ocml_sinh_f32", "__ocml_sinh_f64", "__ocml_sinh_f16")),
    ("math.exp", LibFns::half("", "__ocml_exp_f64", "__ocml_exp_f16")),
    ("math.exp2", LibFns::half("__ocml_exp2_f32", "__ocml_exp2_f64", "__ocml_exp2_f16")),
    ("math.expm1", LibFns::half("__ocml_expm1_f32", "__ocml_expm1_f64", "__ocml_expm1_f16")),
    ("math.floor", LibFns::half("__ocml_floor_f32", "__ocml_floor_f64", "__ocml_floor_f16")),
    ("math.log", LibFns::half("", "__ocml_log_f64", "__ocml_log_f16")),
    ("math.log10", LibFns::half("__ocml_log10_f32", "__ocml_log10_f64", "__ocml_log10_f16")),
    ("math.log1p", LibFns::half("__ocml_log1p_f32", "__ocml_log1p_f64", "__ocml_log1p_f16")),
    ("math.log2", LibFns::half("__ocml_log2_f32", "__ocml_log2_f64", "__ocml_log2_f16")),
    ("math.powf", LibFns::half("__ocml_pow_f32", "__ocml_pow_f64", "__ocml_pow_f16")),
    ("math.rsqrt", LibFns::half("__ocml_rsqrt_f32", "__ocml_rsqrt_f64", "__ocml_rsqrt_f16")),
    ("math.sin", LibFns::half("__ocml_sin_f32", "__ocml_sin_f64", "__ocml_sin_f16")),
    ("math.tanh", LibFns::half("__ocml_tanh_f32", "__ocml_tanh_f64", "__ocml_tanh_f16")),
    ("math.tan", LibFns::half("__ocml_tan_f32", "__ocml_tan_f64", "__ocml_tan_f16")),
    ("math.erf", LibFns::half("__ocml_erf_f32", "__ocml_erf_f64", "__ocml_erf_f16")),
    ("math.erfc", LibFns::half("__ocml_erfc_f32", "__ocml_erfc_f64", "__ocml_erfc_f16")),
    ("math.fpowi", LibFns::half("__ocml_pown_f32", "__ocml_pown_f64", "__ocml_pown_f16")),
    ("arith.remf", LibFns::half("__ocml_fmod_f32", "__ocml_fmod_f64", "__ocml_fmod_f16")),
];

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct MathRocdlOptions {
    pub chipset: Option<AmdChipset>,
}

pub struct MathToRocdl;

#[patterns(converter, options = MathRocdlOptions)]
impl MathToRocdl {
    #[convert("math.acos", "math.acosh", "math.asin", "math.asinh", "math.atan", "math.atanh", "math.atan2", "math.cbrt", "math.ceil", "math.cos", "math.cosh", "math.sinh", "math.exp", "math.exp2", "math.expm1", "math.floor", "math.log", "math.log10", "math.log1p", "math.log2", "math.powf", "math.rsqrt", "math.sin", "math.tanh", "math.tan", "math.erf", "math.erfc", "math.fpowi", "arith.remf")]
    fn scalarize_ocml(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], _: MathRocdlOptions) -> bool {
        let ops: Vec<ValueId> = operands.iter().flatten().copied().collect();
        cr.scalarize(op, &ops)
    }

    #[convert("math.acos", "math.acosh", "math.asin", "math.asinh", "math.atan", "math.atanh", "math.atan2", "math.cbrt", "math.ceil", "math.cos", "math.cosh", "math.sinh", "math.exp", "math.exp2", "math.expm1", "math.floor", "math.log", "math.log10", "math.log1p", "math.log2", "math.powf", "math.rsqrt", "math.sin", "math.tanh", "math.tan", "math.erf", "math.erfc", "math.fpowi", "arith.remf")]
    fn ocml(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], _: MathRocdlOptions) -> bool {
        let name = cr.rw.body[op].name.clone();
        let Some((_, fns)) = OCML.iter().find(|(n, _)| **n == *name) else { return false };
        let ops: Vec<ValueId> = operands.iter().flatten().copied().collect();
        cr.lib_call(op, &ops, fns)
    }

    #[convert("math.clampf")]
    fn clampf(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], o: MathRocdlOptions) -> bool {
        if o.chipset.is_none_or(|c| c.major < 9) {
            return false;
        }
        let ty = cr.rw.body[cr.rw.body[op].results[0]].ty.clone();
        if !matches!(ty.element_type(), Type::Float(FloatKind::F16 | FloatKind::F32)) {
            return false;
        }
        let Some(res) = cr.converted(&ty) else { return false };
        let ops: Vec<ValueId> = operands.iter().flatten().copied().collect();
        if matches!(LlvmType::try_from(&res), Ok(LlvmType::Array(..))) {
            cr.rw.set_before(op);
            return cr.unroll_vectors(op, &ops, |cr, t, pieces| cr.build(OpData::build("rocdl.fmed3").operands(pieces), t));
        }
        let orig = cr.rw.body[op].operands.clone();
        cr.replace_new(op, OpData::build("rocdl.fmed3").operands(&orig), &[ty]);
        true
    }
}

impl MathRocdlOptions {
    pub fn new(chipset: Option<AmdChipset>) -> Self {
        Self { chipset }
    }
}
