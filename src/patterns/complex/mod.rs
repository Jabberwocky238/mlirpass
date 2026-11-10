//! `complex` rule sets.

mod canonicalize;
mod to_libm;
mod to_std;

pub use canonicalize::ComplexCanon;
pub use to_libm::ComplexToLibm;
pub use to_std::{ComplexToStd, Cx as ComplexCx};

#[cfg(feature = "target.llvm")]
mod to_llvm;
#[cfg(feature = "target.llvm")]
pub use to_llvm::ComplexToLlvm;

#[cfg(feature = "target.spirv")]
mod to_spirv;
#[cfg(feature = "target.spirv")]
pub use to_spirv::ComplexToSpirv;

#[cfg(all(feature = "dialect.func", feature = "dialect.arith"))]
mod to_rocdl_libcalls;
#[cfg(all(feature = "dialect.func", feature = "dialect.arith"))]
pub use to_rocdl_libcalls::ComplexToRocdlLibCalls;
