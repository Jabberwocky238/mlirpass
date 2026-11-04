//! `cf` passes.

#[cfg(feature = "llvm")]
mod convert_cf_to_llvm;
#[cfg(feature = "llvm")]
pub use convert_cf_to_llvm::*;

#[cfg(feature = "spirv")]
mod convert_cf_to_spirv;
#[cfg(feature = "spirv")]
pub use convert_cf_to_spirv::*;
