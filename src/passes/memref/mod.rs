//! `memref` passes.

mod expand_strided_metadata;

pub use expand_strided_metadata::ExpandStridedMetadata;

#[cfg(feature = "target.llvm")]
mod finalize_memref_to_llvm;
#[cfg(feature = "target.llvm")]
pub use finalize_memref_to_llvm::*;

#[cfg(feature = "target.spirv")]
mod convert_memref_to_spirv;
#[cfg(feature = "target.spirv")]
pub use convert_memref_to_spirv::*;

#[cfg(feature = "target.spirv")]
mod map_memref_spirv_storage_class;
#[cfg(feature = "target.spirv")]
pub use map_memref_spirv_storage_class::*;

#[cfg(feature = "target.emitc")]
mod convert_memref_to_emitc;
#[cfg(feature = "target.emitc")]
pub use convert_memref_to_emitc::*;
