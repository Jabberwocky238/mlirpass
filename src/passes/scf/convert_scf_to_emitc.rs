use crate::{Emitc, ScfToEmitc};
use mlirformat::Error;
use crate::pass;
use crate::{Action, Body, ConversionConfig, ConversionPatterns, ConversionTarget, Converter, Mode, OpId};

#[pass("convert-scf-to-emitc")]
pub fn convert_scf_to_emitc<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let mut tc = Emitc::converter(true);
    Emitc::size_t_conversions(&mut tc);
    let mut patterns = ConversionPatterns::default();
    let i = patterns.converter(&tc);
    ScfToEmitc::populate(&mut patterns, i);
    let mut target = ConversionTarget::default();
    target.illegal_op("scf.for").illegal_op("scf.if").illegal_op("scf.index_switch").illegal_op("scf.while").unknown(Action::Legal);
    Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
}
