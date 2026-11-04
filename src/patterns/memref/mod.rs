//! `memref` rule sets.

mod canonicalize;
mod expand_strided_metadata;

pub use expand_strided_metadata::StridedMetadata;
pub use canonicalize::{MemrefCanon, Ofr as MemrefOfr};

#[cfg(feature = "llvm")]
mod to_llvm;
#[cfg(feature = "llvm")]
pub use to_llvm::{MemrefOptions, MemrefToLlvm};
#[cfg(feature = "llvm")]
pub(crate) use to_llvm::Gep as LlvmGep;

#[cfg(feature = "spirv")]
mod to_spirv;
#[cfg(feature = "spirv")]
pub use to_spirv::{MemrefSpirvOptions, MemrefToSpirv};

#[cfg(feature = "emitc")]
mod to_emitc;
#[cfg(feature = "emitc")]
pub use to_emitc::MemrefToEmitc;
