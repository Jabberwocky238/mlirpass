//! `arith` passes.

#[cfg(feature = "llvm")]
mod convert_arith_to_llvm;
#[cfg(feature = "llvm")]
pub use convert_arith_to_llvm::*;

#[cfg(feature = "spirv")]
mod convert_arith_to_spirv;
#[cfg(feature = "spirv")]
pub use convert_arith_to_spirv::*;

#[cfg(feature = "emitc")]
mod convert_arith_to_emitc;
#[cfg(feature = "emitc")]
pub use convert_arith_to_emitc::*;
