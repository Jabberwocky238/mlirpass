//! `arith` rule sets.

mod canonicalize;

pub use canonicalize::ArithCanon;
pub(crate) use canonicalize::Folder as ArithFolder;
#[cfg(feature = "dialect.math")]
pub(crate) use canonicalize::float_layout;

#[cfg(feature = "target.llvm")]
mod to_llvm;
#[cfg(feature = "target.llvm")]
pub use to_llvm::ArithToLlvm;

#[cfg(feature = "target.spirv")]
mod to_spirv;
#[cfg(feature = "target.spirv")]
pub use to_spirv::{ArithSpirvOptions, ArithToSpirv};

#[cfg(feature = "target.emitc")]
mod to_emitc;
#[cfg(feature = "target.emitc")]
pub use to_emitc::ArithToEmitc;
