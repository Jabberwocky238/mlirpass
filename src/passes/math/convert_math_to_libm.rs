//! `convert-math-to-libm`.

use crate::{MathToLibm};
use mlirformat::Error;
use crate::pass;
use crate::{Body, ConversionConfig, ConversionPatterns, ConversionTarget, Converter, Mode, OpId};

/// `convert-math-to-libm`.
#[pass("convert-math-to-libm", on = "builtin.module")]
pub fn convert_math_to_libm<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let mut patterns = ConversionPatterns::default();
    MathToLibm::populate(&mut patterns);
    let mut target = ConversionTarget::default();
    target.legal_dialect("arith").legal_dialect("builtin").legal_dialect("func").legal_dialect("vector").illegal_dialect("math");
    Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
}
