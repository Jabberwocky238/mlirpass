//! `math` passes.

mod convert_math_to_funcs;
mod convert_math_to_libm;

pub use convert_math_to_funcs::{ConvertMathToFuncs};
pub use convert_math_to_libm::{ConvertMathToLibm};

#[cfg(feature = "target.llvm")]
mod convert_math_to_llvm;
#[cfg(feature = "target.llvm")]
pub use convert_math_to_llvm::*;

#[cfg(feature = "target.spirv")]
mod convert_math_to_spirv;
#[cfg(feature = "target.spirv")]
pub use convert_math_to_spirv::*;

#[cfg(feature = "target.emitc")]
mod convert_math_to_emitc;
#[cfg(feature = "target.emitc")]
pub use convert_math_to_emitc::*;

/// The `math` passes.
#[crate::pass_set(ConvertMathToFuncs, ConvertMathToLibm, #[cfg(feature = "target.llvm")] ConvertMathToLlvm, #[cfg(feature = "target.spirv")] ConvertMathToSpirv, #[cfg(feature = "target.emitc")] ConvertMathToEmitc)]
pub struct MathPasses;
