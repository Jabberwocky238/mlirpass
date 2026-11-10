//! ⭐ Rule sets (`#[patterns]`): reusable rewrite / conversion patterns, one directory per
//! source dialect, a file per target (`scf/to_cf.rs`: scf ⇒ cf).

#[cfg(feature = "dialect.affine")]
mod affine;
#[cfg(feature = "dialect.amdgpu")]
mod amdgpu;
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
#[cfg(feature = "dialect.index")]
mod index;
#[cfg(feature = "dialect.ptr")]
mod ptr;
#[cfg(feature = "dialect.quant")]
mod quant;
#[cfg(feature = "dialect.linalg")]
mod linalg;
#[cfg(feature = "dialect.llvm")]
mod llvm;
#[cfg(feature = "dialect.math")]
mod math;
#[cfg(feature = "dialect.memref")]
mod memref;
#[cfg(all(feature = "dialect.nvgpu", feature = "target.llvm"))]
mod nvgpu;
#[cfg(all(feature = "dialect.nvvm", feature = "target.llvm"))]
mod nvvm;
mod broadcast;
mod build;
#[cfg(any(feature = "dialect.math", feature = "dialect.complex"))]
mod libm;
mod chipset;
mod fastmath;
mod reshape;
mod slice;
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
#[cfg(all(feature = "dialect.x86", feature = "target.llvm"))]
mod x86;
#[cfg(feature = "dialect.xegpu")]
mod xegpu;
#[cfg(all(feature = "dialect.xevm", feature = "target.llvm"))]
mod xevm;

pub use broadcast::Broadcast;
pub use canonicalize::{fold, materialize, memref_cast_compatible, memref_cast_foldable, patterns as canonicalization_patterns, Fold, Folded, IntRange};
#[cfg(any(all(feature = "dialect.tensor", feature = "dialect.linalg"), feature = "dialect.tosa"))]
pub(crate) use build::{Named, RegionLocs};
#[cfg(feature = "dialect.tosa")]
pub(crate) use build::i64_elements;
#[cfg(any(feature = "dialect.math", feature = "dialect.complex"))]
pub(crate) use libm::Libm;
pub use chipset::Chipset as AmdChipset;
pub use fastmath::Fmf;
pub use reshape::{Ofr as MemrefOfr, Reshape, ComposeCollapseOfExpand, ComposeExpandOfCollapse, ComposeReassociative, Reassoc};
#[cfg(feature = "dialect.affine")]
pub use affine::*;
#[cfg(all(feature = "dialect.amdgpu", feature = "target.llvm"))]
pub use amdgpu::*;
#[cfg(all(feature = "dialect.amdgpu", not(feature = "target.llvm")))]
pub use amdgpu::AmdgpuCanon;
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
#[cfg(feature = "dialect.index")]
pub use index::*;
#[cfg(feature = "dialect.ptr")]
pub use ptr::*;
#[cfg(feature = "dialect.quant")]
pub use quant::*;
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
#[cfg(all(feature = "dialect.x86", feature = "target.llvm"))]
pub use x86::*;
#[cfg(all(feature = "dialect.nvgpu", feature = "target.llvm"))]
pub use nvgpu::*;
#[cfg(all(feature = "dialect.nvvm", feature = "target.llvm"))]
pub use nvvm::*;
#[cfg(feature = "dialect.xegpu")]
pub use xegpu::*;
#[cfg(all(feature = "dialect.xevm", feature = "target.llvm"))]
pub use xevm::*;
