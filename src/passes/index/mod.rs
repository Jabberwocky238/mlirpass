#[cfg(feature = "target.llvm")]
mod convert_index_to_llvm;
#[cfg(feature = "target.llvm")]
pub use convert_index_to_llvm::*;

#[cfg(feature = "target.spirv")]
mod convert_index_to_spirv;
#[cfg(feature = "target.spirv")]
pub use convert_index_to_spirv::*;
