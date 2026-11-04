//! `memref` passes.

mod expand_strided_metadata;

pub use expand_strided_metadata::ExpandStridedMetadata;

#[cfg(feature = "llvm")]
mod finalize_memref_to_llvm;
#[cfg(feature = "llvm")]
pub use finalize_memref_to_llvm::*;

#[cfg(feature = "spirv")]
mod convert_memref_to_spirv;
#[cfg(feature = "spirv")]
pub use convert_memref_to_spirv::*;

#[cfg(feature = "spirv")]
mod map_memref_spirv_storage_class;
#[cfg(feature = "spirv")]
pub use map_memref_spirv_storage_class::*;

#[cfg(feature = "emitc")]
mod convert_memref_to_emitc;
#[cfg(feature = "emitc")]
pub use convert_memref_to_emitc::*;
