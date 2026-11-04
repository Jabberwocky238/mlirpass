//! `convert-tensor-to-linalg`.

use crate::{TensorToLinalg};
use mlirformat::Error;
use crate::pass;
use crate::{Body, ConversionConfig, ConversionPatterns, ConversionTarget, Converter, Mode, OpId};

/// `convert-tensor-to-linalg`.
#[pass("convert-tensor-to-linalg", on = "builtin.module")]
pub fn convert_tensor_to_linalg<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let mut patterns = ConversionPatterns::default();
    TensorToLinalg::populate(&mut patterns);
    let mut target = ConversionTarget::default();
    target.legal_dialect("arith").legal_dialect("linalg").legal_dialect("tensor").illegal_op("tensor.pad");
    Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
}
