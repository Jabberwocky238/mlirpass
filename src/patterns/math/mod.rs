//! `math` rule sets.

mod canonicalize;
mod to_funcs;
mod to_libm;

pub use to_funcs::{MathToFuncs};
pub use to_libm::{ComplexToLibm, MathToLibm};

#[cfg(feature = "llvm")]
mod to_llvm;
#[cfg(feature = "llvm")]
pub use to_llvm::MathToLlvm;

#[cfg(feature = "spirv")]
mod to_spirv;
#[cfg(feature = "spirv")]
pub use to_spirv::MathToSpirv;

#[cfg(feature = "emitc")]
mod to_emitc;
#[cfg(feature = "emitc")]
pub use to_emitc::MathToEmitc;
