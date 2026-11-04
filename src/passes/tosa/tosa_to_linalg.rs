//! `tosa-to-linalg`.

use crate::{TosaToLinalg, TosaToTensor};
use mlirformat::Error;
use crate::pass;
use crate::{Action, Body, ConversionConfig, ConversionPatterns, ConversionTarget, Converter, Mode, OpId};

/// `tosa-to-linalg`.
#[pass("tosa-to-linalg", on = "func.func", ty = TosaToLinalgPass)]
pub fn tosa_to_linalg<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let tc = TosaToTensor::converter();
    let mut patterns = ConversionPatterns::default();
    let i = patterns.converter(&tc);
    TosaToLinalg::populate(&mut patterns, i);
    let mut target = ConversionTarget::default();
    target.legal_dialect("linalg").legal_dialect("tensor").legal_dialect("scf").illegal_dialect("tosa");
    for o in ["tosa.apply_scale", "tosa.if", "tosa.const", "tosa.const_shape", "tosa.while", "tosa.concat", "tosa.slice", "tosa.reshape", "tosa.pad"] {
        target.legal_op(o);
    }
    target.unknown(Action::Legal);
    Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Full)
}
