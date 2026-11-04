//! `ub` passes.

#[cfg(feature = "target.llvm")]
mod convert_ub_to_llvm;
#[cfg(feature = "target.llvm")]
pub use convert_ub_to_llvm::*;

#[cfg(feature = "target.spirv")]
mod convert_ub_to_spirv;
#[cfg(feature = "target.spirv")]
pub use convert_ub_to_spirv::*;

/// The `ub` passes.
#[crate::pass_set(#[cfg(feature = "target.llvm")] ConvertUbToLlvm, #[cfg(feature = "target.spirv")] ConvertUbToSpirv)]
pub struct UbPasses;
