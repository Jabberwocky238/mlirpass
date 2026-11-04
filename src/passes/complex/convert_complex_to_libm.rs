//! `convert-complex-to-libm`.

use crate::{ComplexToLibm};
use mlirformat::Error;
use crate::pass;
use crate::{Body, ConversionConfig, ConversionPatterns, ConversionTarget, Converter, Mode, OpId};

/// `convert-complex-to-libm`.
#[pass("convert-complex-to-libm", on = "builtin.module")]
pub fn convert_complex_to_libm<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let mut patterns = ConversionPatterns::default();
    ComplexToLibm::populate(&mut patterns);
    let mut target = ConversionTarget::default();
    target.legal_dialect("func");
    for r in ComplexToLibm::ROOTS {
        target.illegal_op(r);
    }
    Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
}
