//! `index` ⇒ `spirv`, as `IndexToSPIRV.cpp`.

use alloc::vec::Vec;

use mlirformat::{Attribute, Type};

use crate::patterns;

use crate::{ArithSpirvOptions, ArithToSpirv, Const, ConversionRewriter, OpData, OpId, ValueId};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

/// The index ⇒ spirv patterns (`populateIndexToSPIRVPatterns`).
pub struct IndexToSpirv;

impl IndexToSpirv {
    /// `spirv.<name>` of `ops`, typed `ty`.
    fn op<'a>(cr: &mut Cr<'_, 'a, '_>, name: &str, ops: &[ValueId], ty: &Type<'a>) -> ValueId {
        cr.build(OpData::build(name).operands(ops), ty.clone())
    }

    /// An integer `spirv.Constant` of `ty`.
    fn int<'a>(cr: &mut Cr<'_, 'a, '_>, ty: &Type<'a>, v: i64) -> ValueId {
        let w = ty.bit_width().unwrap_or(32);
        cr.spirv_const(ty.clone(), Const::int(mlirformat::ApInt::new(w, i128::from(v)), ty.clone()).into())
    }

    /// The lhs, the rhs and their type.
    fn binary<'a>(cr: &Cr<'_, 'a, '_>, operands: &[Vec<ValueId>]) -> Option<(ValueId, ValueId, Type<'a>)> {
        let [n, m] = Cr::one_to_one(operands)?[..] else { return None };
        Some((n, m, cr.rw.body[n].ty.clone()))
    }

    /// The converted `index`.
    fn index<'a>(cr: &Cr<'_, 'a, '_>) -> Option<Type<'a>> {
        cr.converted(&Type::Index)
    }
}

#[patterns(converter)]
impl IndexToSpirv {
    /// `spirv::ElementwiseOpPattern`s.
    #[lowering("index.add", "index.sub", "index.mul", "index.divs", "index.divu", "index.rems", "index.remu", "index.maxs", "index.maxu", "index.mins", "index.minu", "index.shl", "index.shrs", "index.shru", "index.and", "index.or", "index.xor")]
    fn elementwise(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        let spirv = match &*cr.rw.body[op].name {
            "index.add" => "spirv.IAdd",
            "index.sub" => "spirv.ISub",
            "index.mul" => "spirv.IMul",
            "index.divs" => "spirv.SDiv",
            "index.divu" => "spirv.UDiv",
            "index.rems" => "spirv.SRem",
            "index.remu" => "spirv.UMod",
            "index.maxs" => "spirv.GL.SMax",
            "index.maxu" => "spirv.GL.UMax",
            "index.mins" => "spirv.GL.SMin",
            "index.minu" => "spirv.GL.UMin",
            "index.shl" => "spirv.ShiftLeftLogical",
            "index.shrs" => "spirv.ShiftRightArithmetic",
            "index.shru" => "spirv.ShiftRightLogical",
            "index.and" => "spirv.BitwiseAnd",
            "index.or" => "spirv.BitwiseOr",
            _ => "spirv.BitwiseXor",
        };
        ArithToSpirv::elementwise(cr, op, operands, spirv, ArithSpirvOptions { no_wrap: false, emulate_floats: true })
    }

    /// `ConvertIndexConstantBoolOpPattern`.
    #[lowering("index.bool.constant")]
    fn bool_constant(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let Some(value) = cr.rw.body[op].get("value").cloned() else { return false };
        cr.replace_new(op, OpData::build("spirv.Constant").with("value", value), &[Type::I1]);
        true
    }

    /// `ConvertIndexConstantOpPattern`: the value truncated to the index bitwidth.
    #[lowering("index.constant")]
    fn constant(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let Some(ty) = Self::index(cr) else { return false };
        let w = ty.bit_width().unwrap_or(32);
        let Some(v) = cr.rw.body[op].get("value").and_then(|a| Const::try_from(a).ok()).and_then(|c| c.as_int()) else { return false };
        let value: Attribute = Const::int(v.trunc(w), ty.clone()).into();
        cr.replace_new(op, OpData::build("spirv.Constant").with("value", value), &[ty]);
        true
    }

    /// `ConvertIndexCeilDivSPattern`.
    #[lowering("index.ceildivs")]
    fn ceildivs(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        let Some((n, m, t)) = Self::binary(cr, operands) else { return false };
        let (zero, pos_one, neg_one) = (Self::int(cr, &t, 0), Self::int(cr, &t, 1), Self::int(cr, &t, -1));
        let m_pos = Self::op(cr, "spirv.SGreaterThan", &[m, zero], &Type::I1);
        let x = Self::op(cr, "spirv.Select", &[m_pos, neg_one, pos_one], &t);
        let n_plus_x = Self::op(cr, "spirv.IAdd", &[n, x], &t);
        let q = Self::op(cr, "spirv.SDiv", &[n_plus_x, m], &t);
        let pos = Self::op(cr, "spirv.IAdd", &[q, pos_one], &t);
        let neg_n = Self::op(cr, "spirv.ISub", &[zero, n], &t);
        let neg_q = Self::op(cr, "spirv.SDiv", &[neg_n, m], &t);
        let neg = Self::op(cr, "spirv.ISub", &[zero, neg_q], &t);
        let n_pos = Self::op(cr, "spirv.SGreaterThan", &[n, zero], &Type::I1);
        let same = Self::op(cr, "spirv.LogicalEqual", &[n_pos, m_pos], &Type::I1);
        let nz = Self::op(cr, "spirv.INotEqual", &[n, zero], &Type::I1);
        let cmp = Self::op(cr, "spirv.LogicalAnd", &[same, nz], &Type::I1);
        cr.replace_new(op, OpData::build("spirv.Select").operands(&[cmp, pos, neg]), &[t]);
        true
    }

    /// `ConvertIndexCeilDivUPattern`.
    #[lowering("index.ceildivu")]
    fn ceildivu(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        let Some((n, m, t)) = Self::binary(cr, operands) else { return false };
        let (zero, one) = (Self::int(cr, &t, 0), Self::int(cr, &t, 1));
        let minus_one = Self::op(cr, "spirv.ISub", &[n, one], &t);
        let q = Self::op(cr, "spirv.UDiv", &[minus_one, m], &t);
        let plus_one = Self::op(cr, "spirv.IAdd", &[q, one], &t);
        let cmp = Self::op(cr, "spirv.IEqual", &[n, zero], &Type::I1);
        cr.replace_new(op, OpData::build("spirv.Select").operands(&[cmp, zero, plus_one]), &[t]);
        true
    }

    /// `ConvertIndexFloorDivSPattern`.
    #[lowering("index.floordivs")]
    fn floordivs(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        let Some((n, m, t)) = Self::binary(cr, operands) else { return false };
        let (zero, pos_one, neg_one) = (Self::int(cr, &t, 0), Self::int(cr, &t, 1), Self::int(cr, &t, -1));
        let m_neg = Self::op(cr, "spirv.SLessThan", &[m, zero], &Type::I1);
        let x = Self::op(cr, "spirv.Select", &[m_neg, pos_one, neg_one], &t);
        let x_minus_n = Self::op(cr, "spirv.ISub", &[x, n], &t);
        let q = Self::op(cr, "spirv.SDiv", &[x_minus_n, m], &t);
        let neg = Self::op(cr, "spirv.ISub", &[neg_one, q], &t);
        let pos = Self::op(cr, "spirv.SDiv", &[n, m], &t);
        let n_neg = Self::op(cr, "spirv.SLessThan", &[n, zero], &Type::I1);
        let diff = Self::op(cr, "spirv.LogicalNotEqual", &[n_neg, m_neg], &Type::I1);
        let nz = Self::op(cr, "spirv.INotEqual", &[n, zero], &Type::I1);
        let cmp = Self::op(cr, "spirv.LogicalAnd", &[diff, nz], &Type::I1);
        cr.replace_new(op, OpData::build("spirv.Select").operands(&[cmp, pos, neg]), &[t]);
        true
    }

    /// `ConvertIndexCast<CastSOp / CastUOp>`: `index` on either side is the converted index.
    #[lowering("index.casts", "index.castu")]
    fn cast(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        let Some(index) = Self::index(cr) else { return false };
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let as_index = |v: ValueId| match &cr.rw.body[v].ty {
            Type::Index => index.clone(),
            t => t.clone(),
        };
        let (src, dst) = (as_index(ops[0]), as_index(cr.rw.body[op].results[0]));
        if src == dst {
            cr.replace_values(op, &ops);
        } else {
            let name = if cr.rw.body[op].name == "index.casts" { "spirv.SConvert" } else { "spirv.UConvert" };
            cr.replace_new(op, OpData::build(name).operands(&ops), &[dst]);
        }
        true
    }

    /// `ConvertIndexCmpPattern`.
    #[lowering("index.cmp")]
    fn cmp(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        let Some(Attribute::Extended { ext, .. }) = cr.rw.body[op].get("pred") else { return false };
        // `#index<cmp_predicate eq>`.
        let body = ext.body.as_deref().unwrap_or("").trim_matches(|c| c == '<' || c == '>');
        let name = match body.rsplit(' ').next().unwrap_or(body) {
            "eq" => "spirv.IEqual",
            "ne" => "spirv.INotEqual",
            "sge" => "spirv.SGreaterThanEqual",
            "sgt" => "spirv.SGreaterThan",
            "sle" => "spirv.SLessThanEqual",
            "slt" => "spirv.SLessThan",
            "uge" => "spirv.UGreaterThanEqual",
            "ugt" => "spirv.UGreaterThan",
            "ule" => "spirv.ULessThanEqual",
            "ult" => "spirv.ULessThan",
            _ => return false,
        };
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        cr.replace_new(op, OpData::build(name).operands(&ops), &[Type::I1]);
        true
    }

    /// `ConvertIndexSizeOf`: the index bitwidth (as upstream has it, in bits).
    #[lowering("index.sizeof")]
    fn sizeof(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let Some(ty) = Self::index(cr) else { return false };
        let w = ty.bit_width().unwrap_or(32);
        let v = Self::int(cr, &ty, i64::from(w));
        cr.replace_values(op, &[v]);
        true
    }
}
