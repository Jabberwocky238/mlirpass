//! `cf` passes.

#[cfg(feature = "target.llvm")]
mod convert_cf_to_llvm;
#[cfg(feature = "target.llvm")]
pub use convert_cf_to_llvm::*;

#[cfg(feature = "target.spirv")]
mod convert_cf_to_spirv;
#[cfg(feature = "target.spirv")]
pub use convert_cf_to_spirv::*;
