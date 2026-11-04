//! `vector` passes.

mod convert_vector_to_scf;

pub use convert_vector_to_scf::{ConvertVectorToScf};

#[cfg(feature = "target.llvm")]
mod convert_vector_to_llvm;
#[cfg(feature = "target.llvm")]
pub use convert_vector_to_llvm::*;

#[cfg(feature = "target.spirv")]
mod convert_vector_to_spirv;
#[cfg(feature = "target.spirv")]
pub use convert_vector_to_spirv::*;
