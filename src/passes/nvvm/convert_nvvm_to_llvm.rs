//! `convert-nvvm-to-llvm`.

use mlirformat::Error;

use crate::pass;
use crate::NvvmToLlvm;
use crate::{Body, ConversionConfig, ConversionPatterns, ConversionTarget, Converter, Mode, OpId};

/// `convert-nvvm-to-llvm`, as `ConvertNVVMToLLVMPass`: llvm legal, the PTX-building ops as
/// inline assembly.
#[pass("convert-nvvm-to-llvm")]
pub fn convert_nvvm_to_llvm<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let mut patterns = ConversionPatterns::default();
    NvvmToLlvm::populate(&mut patterns);
    let mut target = ConversionTarget::default();
    target.legal_dialect("llvm");
    Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
}
