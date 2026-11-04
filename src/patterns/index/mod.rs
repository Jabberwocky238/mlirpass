//! `index` rule sets.

#[cfg(feature = "llvm")]
mod to_llvm;
#[cfg(feature = "llvm")]
pub use to_llvm::{IndexToLlvm, UbToLlvm};

#[cfg(feature = "spirv")]
mod to_spirv;
#[cfg(feature = "spirv")]
pub use to_spirv::IndexToSpirv;
