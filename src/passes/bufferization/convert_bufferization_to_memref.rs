//! `convert-bufferization-to-memref`.

use crate::{BufferizationToMemref};
use crate::pass;
use crate::{Body, ConversionConfig, ConversionPatterns, ConversionTarget, Converter, Mode, OpId};
use mlirformat::Error;

/// `convert-bufferization-to-memref`.
#[pass("convert-bufferization-to-memref")]
pub fn convert_bufferization_to_memref<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let mut patterns = ConversionPatterns::default();
    BufferizationToMemref::populate(&mut patterns);
    let mut target = ConversionTarget::default();
    target.legal_dialect("memref").legal_dialect("arith").legal_dialect("scf").legal_dialect("func").illegal_dialect("bufferization");
    Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
}
