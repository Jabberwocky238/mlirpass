//! `func` passes.

#[cfg(feature = "target.llvm")]
mod convert_func_to_llvm;
#[cfg(feature = "target.llvm")]
pub use convert_func_to_llvm::*;

#[cfg(feature = "target.spirv")]
mod convert_func_to_spirv;
#[cfg(feature = "target.spirv")]
pub use convert_func_to_spirv::*;

#[cfg(feature = "target.emitc")]
mod convert_func_to_emitc;
#[cfg(feature = "target.emitc")]
pub use convert_func_to_emitc::*;

/// The `func` passes.
#[crate::pass_set(#[cfg(feature = "target.llvm")] ConvertFuncToLlvm, #[cfg(feature = "target.spirv")] ConvertFuncToSpirv, #[cfg(feature = "target.emitc")] ConvertFuncToEmitc)]
pub struct FuncPasses;
