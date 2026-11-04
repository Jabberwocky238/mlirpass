//! `arith` rule sets.

mod canonicalize;

pub use canonicalize::ArithCanon;
pub(crate) use canonicalize::{Folder as ArithFolder, float_layout};

#[cfg(feature = "llvm")]
mod to_llvm;
#[cfg(feature = "llvm")]
pub use to_llvm::ArithToLlvm;

#[cfg(feature = "spirv")]
mod to_spirv;
#[cfg(feature = "spirv")]
pub use to_spirv::{ArithSpirvOptions, ArithToSpirv};

#[cfg(feature = "emitc")]
mod to_emitc;
#[cfg(feature = "emitc")]
pub use to_emitc::ArithToEmitc;
