//! `func` rule sets.

mod canonicalize;

pub use canonicalize::FuncCanon;

#[cfg(feature = "llvm")]
mod to_llvm;
#[cfg(feature = "llvm")]
pub use to_llvm::FuncToLlvm;

#[cfg(feature = "spirv")]
mod to_spirv;
#[cfg(feature = "spirv")]
pub use to_spirv::FuncToSpirv;

#[cfg(feature = "emitc")]
mod to_emitc;
#[cfg(feature = "emitc")]
pub use to_emitc::FuncToEmitc;
