//! `convert-scf-to-cf`.

use crate::{ScfToCf};
use mlirformat::Error;
use crate::pass;
use crate::{Action, Body, ConversionConfig, ConversionPatterns, ConversionTarget, Converter, Mode, OpId};

/// `convert-scf-to-cf`.
#[pass("convert-scf-to-cf", extra = ["allow-pattern-rollback"])]
pub fn convert_scf_to_cf<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let mut patterns = ConversionPatterns::default();
    ScfToCf::populate(&mut patterns);
    let mut target = ConversionTarget::default();
    for o in ["scf.forall", "scf.for", "scf.if", "scf.index_switch", "scf.parallel", "scf.while", "scf.execute_region"] {
        target.illegal_op(o);
    }
    target.unknown(Action::Legal);
    Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
}
