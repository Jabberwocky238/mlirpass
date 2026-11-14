mod expand_strided_metadata;
mod fold_memref_alias_ops;
mod resolve_ranked_shaped_type_result_dims;
mod resolve_shaped_type_result_dims;

pub use fold_memref_alias_ops::FoldMemrefAliasOps;
pub use expand_strided_metadata::ExpandStridedMetadata;
pub use resolve_ranked_shaped_type_result_dims::ResolveRankedShapedTypeResultDims;
pub use resolve_shaped_type_result_dims::ResolveShapedTypeResultDims;

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
