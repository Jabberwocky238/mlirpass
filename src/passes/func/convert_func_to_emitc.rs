//! `convert-func-to-emitc`.

use crate::{Emitc, FuncToEmitc};
use mlirformat::Error;
use crate::pass;
use crate::{Body, ConversionConfig, ConversionPatterns, ConversionTarget, Converter, Mode, OpId};

/// `convert-func-to-emitc`.
#[pass("convert-func-to-emitc", on = "builtin.module")]
pub fn convert_func_to_emitc<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let tc = Emitc::converter(false);
    let mut patterns = ConversionPatterns::default();
    let i = patterns.converter(&tc);
    FuncToEmitc::populate(&mut patterns, i);
    let mut target = ConversionTarget::default();
    target.legal_dialect("emitc").illegal_op("func.call").illegal_op("func.func").illegal_op("func.return");
    Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
}
