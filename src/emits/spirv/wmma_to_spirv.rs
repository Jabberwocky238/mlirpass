//! `gpu` subgroup MMA ⇒ `spirv` KHR cooperative matrices, as `WmmaOpsToSPIRV.cpp`.

use alloc::string::String;
use alloc::vec::Vec;

use mlirformat::spirv_types::SpirvType;
use mlirformat::{Attribute, Const, Type};

use crate::patterns;

use super::{MemrefSpirvOptions, MemrefToSpirv};
use crate::{ConversionRewriter, OpData, OpId, TypeConverter, ValueId};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

/// The wmma ⇒ cooperative matrix patterns (`populateGpuWMMAToSPIRVCoopMatrixKHRConversionPatterns`).
pub struct WmmaToSpirv;

impl WmmaToSpirv {
    /// `populateMMAToSPIRVCoopMatrixTypeConversion`: `!gpu.mma_matrix<RxCxT, "AOp">` as
    /// `!spirv.coopmatrix<RxCxT, Subgroup, MatrixA>`.
    pub fn convert_types(tc: &mut TypeConverter<'_>) {
        tc.conversion(|t| {
            let Type::Extended(e) = t else { return None };
            if e.name != "gpu.mma_matrix" {
                return None;
            }
            let body = e.body.as_deref()?.trim_matches(['<', '>']);
            let (shape, operand) = body.rsplit_once(',')?;
            let usage = match operand.trim().trim_matches('"') {
                "AOp" => "MatrixA",
                "BOp" => "MatrixB",
                _ => "MatrixAcc",
            };
            let vector = alloc::format!("vector<{}>", shape.trim());
            let Ok(Type::Shaped(s)) = mlirformat::Parser::read(&vector, |p| p.ty()) else { return Some(None) };
            let dims = s.dims()?;
            let coop = SpirvType::CoopMatrix { rows: dims[0] as u32, cols: dims[1] as u32, elem: (*s.elem).owned().into(), scope: String::from("Subgroup"), usage: String::from(usage) };
            Some(Some(alloc::vec![Type::from(coop).owned()]))
        });
    }

    /// Constant `index` operands (`arith.constant`s), as an `i32` array.
    fn const_indices<'a>(cr: &Cr<'_, 'a, '_>, idx: &[ValueId]) -> Option<Attribute<'a>> {
        let b = &cr.rw.body;
        let vals = idx.iter().map(|v| {
            let d = b.def_op(*v).filter(|d| b[*d].name == "arith.constant" && b[*v].ty == Type::Index)?;
            let i = Const::try_from(b[d].get("value")?).ok()?.as_int()?.signed();
            Some(Attribute::integer(i128::from(i as i32), Type::int(32)))
        });
        Some(Attribute::Array(vals.collect::<Option<Vec<_>>>()?))
    }

    fn result_ty<'a>(cr: &Cr<'_, 'a, '_>, op: OpId) -> Option<Type<'a>> {
        let r = cr.rw.body[op].results[0];
        cr.converted(&cr.rw.body[r].ty.clone())
    }

    fn is_coop(t: &Type<'_>) -> bool {
        matches!(SpirvType::try_from(t), Ok(SpirvType::CoopMatrix { .. }))
    }

    /// `allOperandsHaveSameCoopMatrixType`.
    fn same_coop(cr: &Cr<'_, '_, '_>, ops: &[ValueId]) -> bool {
        let t = &cr.rw.body[ops[0]].ty;
        Self::is_coop(t) && ops.iter().all(|v| cr.rw.body[*v].ty == *t)
    }

    /// The stride constant and layout of a load / store.
    fn stride_layout<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId) -> Option<(ValueId, Attribute<'a>)> {
        let stride = Const::try_from(cr.rw.body[op].get("leadDimension")?).ok()?.as_int()?.signed();
        let col = cr.rw.body[op].get("transpose").is_some_and(|a| !matches!(a, Attribute::Bool(false)));
        let s = cr.spirv_const(Type::int(32), Attribute::integer(stride, Type::int(32)));
        Some((s, Cr::spirv_enum("coop_matrix_layout_khr", if col { "ColumnMajor" } else { "RowMajor" })))
    }

    /// The element pointer of a load / store's memref at its indices.
    fn ptr(cr: &mut Cr<'_, '_, '_>, op: OpId, ops: &[ValueId], at: usize, o: MemrefSpirvOptions) -> Option<ValueId> {
        let m = cr.rw.body[op].operands[at];
        let Type::Shaped(s) = cr.rw.body[m].ty.clone() else { return None };
        MemrefToSpirv::element_ptr(cr, &s, ops[at], &ops[at + 1..], o)
    }
}

#[patterns(converter, options = MemrefSpirvOptions)]
impl WmmaToSpirv {
    /// `WmmaLoadOpToSPIRVLowering`.
    #[lowering("gpu.subgroup_mma_load_matrix")]
    fn load(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], o: MemrefSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let Some(ptr) = Self::ptr(cr, op, &ops, 0, o) else { return false };
        let Some(ty) = Self::result_ty(cr, op) else { return false };
        let Some((stride, layout)) = Self::stride_layout(cr, op) else { return false };
        cr.replace_new(op, OpData::build("spirv.KHR.CooperativeMatrixLoad").operands(&[ptr, stride]).with("matrix_layout", layout), &[ty]);
        true
    }

    /// `WmmaMmaOpToSPIRVLowering`.
    #[lowering("gpu.subgroup_mma_compute")]
    fn compute(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], _: MemrefSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let ty = cr.rw.body[ops[2]].ty.clone();
        cr.replace_new(op, OpData::build("spirv.KHR.CooperativeMatrixMulAdd").operands(&ops[..3]), &[ty]);
        true
    }

    /// `WmmaStoreOpToSPIRVLowering`.
    #[lowering("gpu.subgroup_mma_store_matrix")]
    fn store(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], o: MemrefSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let Some(ptr) = Self::ptr(cr, op, &ops, 1, o) else { return false };
        let Some((stride, layout)) = Self::stride_layout(cr, op) else { return false };
        cr.replace_new(op, OpData::build("spirv.KHR.CooperativeMatrixStore").operands(&[ptr, ops[0], stride]).with("matrix_layout", layout), &[]);
        true
    }

    /// `WmmaConstantOpToSPIRVLowering`: the scalar splat.
    #[lowering("gpu.subgroup_mma_constant_matrix")]
    fn constant(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], _: MemrefSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let Some(ty) = Self::result_ty(cr, op) else { return false };
        cr.replace_new(op, OpData::build("spirv.CompositeConstruct").operands(&ops), &[ty]);
        true
    }

    /// `WmmaExtractOpToSPIRVLowering`.
    #[lowering("gpu.subgroup_mma_extract_thread_local")]
    fn extract(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], _: MemrefSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let Ok(SpirvType::CoopMatrix { elem, .. }) = SpirvType::try_from(&cr.rw.body[ops[0]].ty) else { return false };
        let idx = cr.rw.body[op].operands[1..].to_vec();
        let Some(indices) = Self::const_indices(cr, &idx) else { return false };
        cr.replace_new(op, OpData::build("spirv.CompositeExtract").operands(&ops[..1]).with("indices", indices), &[(*elem).owned()]);
        true
    }

    /// `WmmaInsertOpToSPIRVLowering`.
    #[lowering("gpu.subgroup_mma_insert_thread_local")]
    fn insert(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], _: MemrefSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let ty = cr.rw.body[ops[1]].ty.clone();
        let idx = cr.rw.body[op].operands[2..].to_vec();
        let Some(indices) = Self::const_indices(cr, &idx) else { return false };
        cr.replace_new(op, OpData::build("spirv.CompositeInsert").operands(&ops[..2]).with("indices", indices), &[ty]);
        true
    }

    /// `WmmaElementwiseOpToSPIRVDefaultLowering`.
    #[lowering("gpu.subgroup_mma_elementwise")]
    fn elementwise(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], _: MemrefSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        if !Self::same_coop(cr, &ops) {
            return false;
        }
        let Some(ty) = Self::result_ty(cr, op) else { return false };
        let Some(Attribute::Extended { ext, .. }) = cr.rw.body[op].get("opType") else { return false };
        let kind = ext.body.as_deref().unwrap_or("").trim_matches(['<', '>']).rsplit(' ').next().unwrap_or("");
        let name = match kind {
            "addf" => "spirv.FAdd",
            "addi" => "spirv.IAdd",
            "subf" => "spirv.FSub",
            "subi" => "spirv.ISub",
            "mulf" => "spirv.FMul",
            "divf" => "spirv.FDiv",
            "divs" => "spirv.SDiv",
            "divu" => "spirv.UDiv",
            "negatef" => "spirv.FNegate",
            "negates" => "spirv.SNegate",
            "extf" => "spirv.FConvert",
            _ => return false,
        };
        cr.replace_new(op, OpData::build(name).operands(&ops), &[ty]);
        true
    }

    /// `WmmaElementwiseOpToSPIRVScalarMulLowering`: a product with a constant matrix is
    /// `spirv.MatrixTimesScalar`.
    #[lowering("gpu.subgroup_mma_elementwise", benefit = 2)]
    fn scalar_mul(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], _: MemrefSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        if ops.len() != 2 || !Self::same_coop(cr, &ops) {
            return false;
        }
        let b = &cr.rw.body;
        if !matches!(b[op].get("opType"), Some(Attribute::Extended { ext, .. }) if ext.body.as_deref().unwrap_or("").contains("mulf")) {
            return false;
        }
        let is_const = |v: ValueId| b.def_op(v).is_some_and(|d| b[d].name == "gpu.subgroup_mma_constant_matrix");
        let (splat, matrix) = if is_const(b[op].operands[0]) {
            (ops[0], ops[1])
        } else if is_const(b[op].operands[1]) {
            (ops[1], ops[0])
        } else {
            return false;
        };
        let Some(cc) = b.def_op(splat).filter(|d| b[*d].name == "spirv.CompositeConstruct") else { return false };
        let [scalar] = b[cc].operands[..] else { return false };
        let Some(ty) = Self::result_ty(cr, op) else { return false };
        cr.replace_new(op, OpData::build("spirv.MatrixTimesScalar").operands(&[matrix, scalar]), &[ty]);
        true
    }
}
