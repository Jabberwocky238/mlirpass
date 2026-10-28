//! `ub` ⇒ `spirv`, as `UBToSPIRV.cpp`.

use alloc::vec::Vec;

use crate::patterns;

use crate::{ConversionRewriter, OpData, OpId, ValueId};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

/// The ub ⇒ spirv patterns (`populateUBToSPIRVConversionPatterns`).
pub struct UbToSpirv;

#[patterns(converter)]
impl UbToSpirv {
    /// `PoisonOpLowering`.
    #[lowering("ub.poison")]
    fn poison<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let r = cr.rw.body[op].results[0];
        let Some(ty) = cr.converted(&cr.rw.body[r].ty.clone()) else { return false };
        cr.replace_new(op, OpData::build("spirv.Undef"), &[ty]);
        true
    }

    /// `UnreachableOpLowering`.
    #[lowering("ub.unreachable")]
    fn unreachable<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        cr.replace_new(op, OpData::build("spirv.Unreachable"), &[]);
        true
    }
}
