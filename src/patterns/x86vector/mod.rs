//! `x86vector` rule sets.

#[cfg(feature = "target.llvm")]
mod to_llvm;
#[cfg(feature = "target.llvm")]
pub use to_llvm::X86ToLlvm;
