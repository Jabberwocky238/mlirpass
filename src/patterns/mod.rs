//! ⭐ Rule sets (`#[patterns]`): reusable rewrite / conversion patterns, one directory per
//! source dialect, a file per target (`scf/to_cf.rs`: scf ⇒ cf).

#[cfg(feature = "dialect.affine")]
mod affine;
#[cfg(feature = "dialect.arith")]
mod arith;
#[cfg(feature = "dialect.bufferization")]
mod bufferization;
mod canonicalize;
#[cfg(feature = "dialect.cf")]
mod cf;
#[cfg(feature = "dialect.complex")]
mod complex;
#[cfg(feature = "dialect.func")]
mod func;
#[cfg(feature = "dialect.gpu")]
mod gpu;
#[cfg(all(feature = "dialect.index", any(feature = "target.llvm", feature = "target.spirv")))]
mod index;
#[cfg(feature = "dialect.linalg")]
mod linalg;
#[cfg(feature = "dialect.llvm")]
mod llvm;
#[cfg(feature = "dialect.math")]
mod math;
#[cfg(feature = "dialect.memref")]
mod memref;
mod libm;
mod reshape;
#[cfg(feature = "dialect.scf")]
mod scf;
#[cfg(feature = "dialect.shape")]
mod shape;
#[cfg(feature = "dialect.spirv")]
mod spirv;
#[cfg(feature = "dialect.tensor")]
mod tensor;
#[cfg(feature = "dialect.test")]
mod test;
#[cfg(feature = "dialect.tosa")]
mod tosa;
#[cfg(all(feature = "dialect.ub", any(feature = "target.llvm", feature = "target.spirv")))]
mod ub;
#[cfg(feature = "dialect.vector")]
mod vector;
#[cfg(feature = "dialect.x86vector")]
mod x86vector;
#[cfg(all(feature = "dialect.xevm", feature = "target.llvm"))]
mod xevm;

pub use canonicalize::{fold, materialize, memref_cast_compatible, memref_cast_foldable, patterns as canonicalization_patterns, Fold, Folded};
pub(crate) use libm::Libm;
pub use reshape::{Ofr as MemrefOfr, Reshape, ComposeCollapseOfExpand, ComposeExpandOfCollapse, ComposeReassociative, Reassoc};
#[cfg(feature = "dialect.affine")]
pub use affine::*;
#[cfg(feature = "dialect.arith")]
pub use arith::*;
#[cfg(feature = "dialect.bufferization")]
pub use bufferization::*;
#[cfg(feature = "dialect.cf")]
pub use cf::*;
#[cfg(feature = "dialect.complex")]
pub use complex::*;
#[cfg(feature = "dialect.func")]
pub use func::*;
#[cfg(feature = "dialect.gpu")]
pub use gpu::*;
#[cfg(all(feature = "dialect.index", any(feature = "target.llvm", feature = "target.spirv")))]
pub use index::*;
#[cfg(feature = "dialect.linalg")]
pub use linalg::*;
#[cfg(feature = "dialect.llvm")]
pub use llvm::*;
#[cfg(feature = "dialect.math")]
pub use math::*;
#[cfg(feature = "dialect.memref")]
pub use memref::*;
#[cfg(feature = "dialect.scf")]
pub use scf::*;
#[cfg(feature = "dialect.shape")]
pub use shape::*;
#[cfg(feature = "dialect.spirv")]
pub use spirv::*;
#[cfg(feature = "dialect.tensor")]
pub use tensor::*;
#[cfg(feature = "dialect.test")]
pub use test::*;
#[cfg(feature = "dialect.tosa")]
pub use tosa::*;
#[cfg(all(feature = "dialect.ub", any(feature = "target.llvm", feature = "target.spirv")))]
pub use ub::*;
#[cfg(feature = "dialect.vector")]
pub use vector::*;
#[cfg(feature = "dialect.x86vector")]
pub use x86vector::*;
#[cfg(all(feature = "dialect.xevm", feature = "target.llvm"))]
pub use xevm::*;
