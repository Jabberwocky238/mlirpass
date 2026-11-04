//! `index` passes.

#[cfg(feature = "llvm")]
mod convert_index_to_llvm;
#[cfg(feature = "llvm")]
pub use convert_index_to_llvm::*;

#[cfg(feature = "spirv")]
mod convert_index_to_spirv;
#[cfg(feature = "spirv")]
pub use convert_index_to_spirv::*;
