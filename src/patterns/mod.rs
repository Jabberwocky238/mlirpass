//! ⭐ Rule sets (`#[patterns]`): reusable rewrite / conversion patterns, one directory per
//! source dialect, a file per target (`scf/to_cf.rs`: scf ⇒ cf).

mod affine;
mod arith;
mod bufferization;
mod canonicalize;
mod cf;
mod complex;
mod func;
mod gpu;
#[cfg(any(feature = "llvm", feature = "spirv"))]
mod index;
mod linalg;
#[cfg(feature = "llvm")]
mod llvm;
mod math;
mod memref;
mod reshape;
mod scf;
mod shape;
mod spirv;
mod tensor;
mod test;
mod tosa;
#[cfg(feature = "spirv")]
mod ub;
mod vector;
#[cfg(feature = "llvm")]
mod x86vector;

pub use canonicalize::{fold, materialize, memref_cast_compatible, memref_cast_foldable, patterns as canonicalization_patterns, Fold, Folded};
pub use reshape::{Reshape, ComposeCollapseOfExpand, ComposeExpandOfCollapse, ComposeReassociative, Reassoc};
pub use affine::*;
pub use arith::*;
pub use bufferization::*;
pub use cf::*;
pub use complex::*;
pub use func::*;
pub use gpu::*;
#[cfg(any(feature = "llvm", feature = "spirv"))]
pub use index::*;
pub use linalg::*;
#[cfg(feature = "llvm")]
pub use llvm::*;
pub use math::*;
pub use memref::*;
pub use scf::*;
pub use shape::*;
pub use spirv::*;
pub use tensor::*;
pub use test::*;
pub use tosa::*;
#[cfg(feature = "spirv")]
pub use ub::*;
pub use vector::*;
#[cfg(feature = "llvm")]
pub use x86vector::*;
