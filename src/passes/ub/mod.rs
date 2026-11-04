//! `ub` passes.

#[cfg(feature = "llvm")]
mod convert_ub_to_llvm;
#[cfg(feature = "llvm")]
pub use convert_ub_to_llvm::*;

#[cfg(feature = "spirv")]
mod convert_ub_to_spirv;
#[cfg(feature = "spirv")]
pub use convert_ub_to_spirv::*;
