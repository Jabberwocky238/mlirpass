//! `complex` ⇒ `spirv`, as `ComplexToSPIRV.cpp`: a complex number is a 2-vector.

use alloc::vec::Vec;

use mlirformat::{Attribute, Type};

use crate::patterns;

use crate::{Const, ConversionRewriter, OpData, OpId, ValueId};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

/// The complex ⇒ spirv patterns (`populateComplexToSPIRVPatterns`).
pub struct ComplexToSpirv;

impl ComplexToSpirv {
    fn result_ty<'a>(cr: &Cr<'_, 'a, '_>, op: OpId) -> Option<Type<'a>> {
        let r = cr.rw.body[op].results[0];
        cr.converted(&cr.rw.body[r].ty.clone())
    }

    /// `ReOpPattern` / `ImOpPattern`: element `i` of the vector.
    fn part(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], i: i64) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let Some(ty) = Self::result_ty(cr, op) else { return false };
        cr.replace_new(op, OpData::build("spirv.CompositeExtract").operands(&ops).with("indices", Attribute::Array(alloc::vec![Attribute::integer(i128::from(i), Type::int(32))])), &[ty]);
        true
    }
}

#[patterns(converter)]
impl ComplexToSpirv {
    /// `ConstantOpPattern`: the `[re, im]` pair as a dense vector.
    #[lowering("complex.constant")]
    fn constant(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let Some(ty @ Type::Shaped(_)) = Self::result_ty(cr, op) else { return false };
        let Some(Attribute::Array(parts)) = cr.rw.body[op].get("value") else { return false };
        let Some(values) = parts.iter().map(|p| Const::try_from(p).ok()?.splat_value()).collect::<Option<Vec<_>>>() else { return false };
        let value = match values[..] {
            [a, b] if a == b => Const::splat(a, ty.clone()),
            _ => Const { ty: ty.clone(), values, elements: true },
        };
        cr.replace_new(op, OpData::build("spirv.Constant").with("value", value.into()), &[ty]);
        true
    }

    /// `CreateOpPattern`.
    #[lowering("complex.create")]
    fn create(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let Some(ty) = Self::result_ty(cr, op) else { return false };
        cr.replace_new(op, OpData::build("spirv.CompositeConstruct").operands(&ops), &[ty]);
        true
    }

    #[lowering("complex.re")]
    fn re(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        Self::part(cr, op, operands, 0)
    }

    #[lowering("complex.im")]
    fn im(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        Self::part(cr, op, operands, 1)
    }
}
