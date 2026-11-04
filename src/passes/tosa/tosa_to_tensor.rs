//! `tosa-to-tensor`.

use crate::{TosaToTensor};
use mlirformat::Error;
use crate::pass;
use crate::{Body, ConversionConfig, ConversionPatterns, ConversionTarget, Converter, Mode, OpId};

/// `tosa-to-tensor`.
#[pass("tosa-to-tensor", ty = TosaToTensorPass)]
pub fn tosa_to_tensor<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let tc = TosaToTensor::converter();
    let mut patterns = ConversionPatterns::default();
    let i = patterns.converter(&tc);
    TosaToTensor::populate(&mut patterns, i);
    let mut target = ConversionTarget::default();
    target.illegal_op("tosa.concat").illegal_op("tosa.reshape").illegal_op("tosa.slice").illegal_op("tosa.pad").legal_dialect("arith").legal_dialect("tensor");
    Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
}
