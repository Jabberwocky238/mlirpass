//! `xevm` passes.

mod convert_xevm_to_llvm;

pub use convert_xevm_to_llvm::ConvertXevmToLlvm;

/// The xevm passes.
#[crate::pass_set(ConvertXevmToLlvm)]
pub struct XevmPasses;
