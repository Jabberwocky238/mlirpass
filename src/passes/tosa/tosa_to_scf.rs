use crate::{TosaToScf};
use mlirformat::Error;
use crate::pass;
use crate::{Action, Body, ConversionConfig, ConversionPatterns, ConversionTarget, Converter, Mode, OpId};

#[pass("tosa-to-scf", on = "func.func", ty = TosaToScfPass)]
pub fn tosa_to_scf<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let mut patterns = ConversionPatterns::default();
    TosaToScf::populate(&mut patterns);
    let mut target = ConversionTarget::default();
    target.legal_dialect("tensor").legal_dialect("scf").illegal_op("tosa.cond_if").illegal_op("tosa.scatter").illegal_op("tosa.while_loop").unknown(Action::Legal);
    Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
}
