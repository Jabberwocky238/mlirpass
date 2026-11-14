mod canonicalize;
pub use canonicalize::IndexCanon;

#[cfg(feature = "target.llvm")]
mod to_llvm;
#[cfg(feature = "target.llvm")]
pub use to_llvm::IndexToLlvm;

#[cfg(feature = "target.spirv")]
mod to_spirv;
#[cfg(feature = "target.spirv")]
pub use to_spirv::IndexToSpirv;
