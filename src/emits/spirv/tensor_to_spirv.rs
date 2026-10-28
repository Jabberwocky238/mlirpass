//! `tensor` ⇒ `spirv`, as `TensorToSPIRV.cpp`: a small constant tensor's element, through a
//! `Function` variable holding it.

use alloc::vec::Vec;

use mlirformat::spirv_types::SpirvType;
use mlirformat::Type;

use crate::patterns;

use crate::{ConversionRewriter, MemrefToSpirv, OpData, OpId, TargetEnv, ValueId};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

/// The tensor ⇒ spirv patterns (`populateTensorToSPIRVPatterns`), `threshold` the byte count
/// above which a tensor is left alone.
pub struct TensorToSpirv;

#[patterns(converter, options = i64)]
impl TensorToSpirv {
    /// `TensorExtractPattern`.
    #[lowering("tensor.extract")]
    fn extract(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], threshold: i64) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let t = cr.rw.body[op].operands[0];
        let Type::Shaped(s) = cr.rw.body[t].ty.clone() else { return false };
        if !TargetEnv::is_scalar(&s.elem) {
            return false;
        }
        let (Some(dims), Some(n), Some(bits)) = (s.dims(), cr.rw.body[t].ty.element_count(), s.elem.bit_width()) else { return false };
        if dims.iter().any(|d| *d < 0) || n as i64 * i64::from(bits) > threshold * 8 {
            return false;
        }
        let mut strides = alloc::vec![1i64; dims.len()];
        for i in (0..dims.len().saturating_sub(1)).rev() {
            strides[i] = strides[i + 1] * dims[i + 1];
        }
        let tensor = ops[0];
        if cr.rw.body.def_op(tensor).is_none_or(|d| cr.rw.body[d].name != "spirv.Constant") {
            return false;
        }
        let arr = cr.rw.body[tensor].ty.clone();
        let Ok(SpirvType::Array { elem, .. }) = SpirvType::try_from(&arr) else { return false };
        let var = cr.build(OpData::build("spirv.Variable").with("storage_class", Cr::spirv_enum("storage_class", "Function")), SpirvType::ptr(arr, "Function"));
        cr.rw.create(OpData::build("spirv.Store").operands(&[var, tensor]), &[]);
        let Some(ity) = cr.converted(&Type::Index) else { return false };
        let index = MemrefToSpirv::linearize(cr, &ops[1..], &strides, 0, &ity);
        let ac = cr.build(OpData::build("spirv.AccessChain").operands(&[var, index]), SpirvType::ptr((*elem).clone(), "Function"));
        cr.replace_new(op, OpData::build("spirv.Load").operands(&[ac]), &[(*elem).clone()]);
        true
    }
}
