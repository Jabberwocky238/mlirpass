//! `func` passes.

#[cfg(feature = "llvm")]
mod convert_func_to_llvm;
#[cfg(feature = "llvm")]
pub use convert_func_to_llvm::*;

#[cfg(feature = "spirv")]
mod convert_func_to_spirv;
#[cfg(feature = "spirv")]
pub use convert_func_to_spirv::*;

#[cfg(feature = "emitc")]
mod convert_func_to_emitc;
#[cfg(feature = "emitc")]
pub use convert_func_to_emitc::*;
