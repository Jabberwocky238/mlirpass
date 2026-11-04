//! `math` passes.

mod convert_math_to_funcs;
mod convert_math_to_libm;

pub use convert_math_to_funcs::{ConvertMathToFuncs};
pub use convert_math_to_libm::{ConvertMathToLibm};

#[cfg(feature = "llvm")]
mod convert_math_to_llvm;
#[cfg(feature = "llvm")]
pub use convert_math_to_llvm::*;

#[cfg(feature = "spirv")]
mod convert_math_to_spirv;
#[cfg(feature = "spirv")]
pub use convert_math_to_spirv::*;

#[cfg(feature = "emitc")]
mod convert_math_to_emitc;
#[cfg(feature = "emitc")]
pub use convert_math_to_emitc::*;
