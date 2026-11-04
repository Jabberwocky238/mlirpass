//! `vector` passes.

mod convert_vector_to_scf;

pub use convert_vector_to_scf::{ConvertVectorToScf};

#[cfg(feature = "llvm")]
mod convert_vector_to_llvm;
#[cfg(feature = "llvm")]
pub use convert_vector_to_llvm::*;

#[cfg(feature = "spirv")]
mod convert_vector_to_spirv;
#[cfg(feature = "spirv")]
pub use convert_vector_to_spirv::*;
