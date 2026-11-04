//! `memref` rule sets.

mod canonicalize;
mod expand_strided_metadata;

pub use expand_strided_metadata::StridedMetadata;
pub use canonicalize::MemrefCanon;

#[cfg(feature = "target.llvm")]
mod to_llvm;
#[cfg(feature = "target.llvm")]
pub use to_llvm::{MemrefOptions, MemrefToLlvm};
#[cfg(all(feature = "target.llvm", feature = "dialect.vector"))]
pub(crate) use to_llvm::Gep as LlvmGep;

#[cfg(feature = "target.spirv")]
mod to_spirv;
#[cfg(feature = "target.spirv")]
pub use to_spirv::{MemrefSpirvOptions, MemrefToSpirv};

#[cfg(feature = "target.emitc")]
mod to_emitc;
#[cfg(feature = "target.emitc")]
pub use to_emitc::MemrefToEmitc;
