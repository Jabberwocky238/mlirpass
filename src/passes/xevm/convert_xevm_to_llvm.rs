//! `convert-xevm-to-llvm`.

use mlirformat::Error;

use crate::pass;
use crate::XevmToLlvm;
use crate::{Body, ConversionConfig, ConversionPatterns, ConversionTarget, Converter, Mode, OpId};

/// `convert-xevm-to-llvm`, as `ConvertXeVMToLLVMPass`: the xevm ops illegal, llvm's legal but a load or store with a
/// `cache_control` (it becomes the decorations).
#[pass("convert-xevm-to-llvm")]
pub fn convert_xevm_to_llvm<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let mut patterns = ConversionPatterns::default();
    XevmToLlvm::populate(&mut patterns);
    let mut target = ConversionTarget::default();
    XevmToLlvm::target(&mut target);
    Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
}
