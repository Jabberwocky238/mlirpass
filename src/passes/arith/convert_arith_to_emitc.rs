//! `convert-arith-to-emitc`.

use crate::{ArithToEmitc, Emitc};
use mlirformat::Error;
use crate::pass;
use crate::{Body, ConversionConfig, ConversionPatterns, ConversionTarget, Converter, Mode, OpId};

/// `convert-arith-to-emitc`.
#[pass("convert-arith-to-emitc")]
pub fn convert_arith_to_emitc<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let mut tc = Emitc::converter(false);
    Emitc::size_t_conversions(&mut tc);
    let mut patterns = ConversionPatterns::default();
    let i = patterns.converter(&tc);
    ArithToEmitc::populate(&mut patterns, i);
    let mut target = ConversionTarget::default();
    target.legal_dialect("emitc").illegal_dialect("arith");
    Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
}
