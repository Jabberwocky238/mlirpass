use alloc::vec::Vec;

use crate::patterns;
use mlirformat::Attribute;

use crate::{ConversionRewriter, OpData, OpId, ValueId};

pub struct UbToLlvm;

#[patterns(converter)]
impl UbToLlvm {
    #[convert("ub.poison")]
    fn poison(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        if !cr.rw.body[op].get("value").is_some_and(Attribute::is_poison) {
            return false;
        }
        let Some(tc) = cr.type_converter() else { return false };
        let Some(ty) = tc.convert(&cr.rw.body[cr.rw.body[op].results[0]].ty.clone()) else { return false };
        cr.replace_new(op, OpData::build("llvm.mlir.poison"), &[ty]);
        true
    }

    #[convert("ub.unreachable")]
    fn unreachable(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        cr.replace_new(op, OpData::build("llvm.unreachable"), &[]);
        true
    }
}
