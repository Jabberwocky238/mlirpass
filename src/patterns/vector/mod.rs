//! `vector` rule sets.

mod canonicalize;
mod to_scf;
mod transforms;

pub use to_scf::{VectorToScfOptions};
pub use transforms::{pre_patterns as vector_pre_patterns, transfer_read_to_load, transfer_write_to_store};
pub(crate) use transforms::{VectorBuild, elem, vshape, zeros};
pub use canonicalize::VectorCanon;
pub(crate) use canonicalize::Folder as VectorFolder;

#[cfg(feature = "target.llvm")]
mod to_llvm;
#[cfg(feature = "target.llvm")]
pub use to_llvm::{VectorOptions, VectorToLlvm};

#[cfg(feature = "target.spirv")]
mod to_spirv;
#[cfg(feature = "target.spirv")]
pub use to_spirv::{VectorSpirvOptions, VectorToSpirv};
