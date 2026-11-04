//! ⭐ Passes: pipeline units, one directory per source dialect, a file per pass
//! (`scf/convert_scf_to_cf.rs`).

#[cfg(feature = "dialect.affine")]
mod affine;
#[cfg(all(feature = "dialect.amdgpu", feature = "target.llvm"))]
mod amdgpu;
#[cfg(all(feature = "dialect.arith", any(feature = "target.emitc", feature = "target.llvm", feature = "target.spirv")))]
mod arith;
#[cfg(feature = "dialect.bufferization")]
mod bufferization;
#[cfg(all(feature = "dialect.cf", any(feature = "target.llvm", feature = "target.spirv")))]
mod cf;
#[cfg(feature = "dialect.complex")]
mod complex;
#[cfg(feature = "target.emitc")]
mod emitc;
#[cfg(all(feature = "dialect.func", any(feature = "target.emitc", feature = "target.llvm", feature = "target.spirv")))]
mod func;
#[cfg(feature = "dialect.gpu")]
mod gpu;
#[cfg(all(feature = "dialect.index", any(feature = "target.llvm", feature = "target.spirv")))]
mod index;
#[cfg(feature = "dialect.linalg")]
mod linalg;
#[cfg(feature = "target.llvm")]
mod llvm;
#[cfg(feature = "dialect.math")]
mod math;
#[cfg(feature = "dialect.memref")]
mod memref;
#[cfg(feature = "dialect.scf")]
mod scf;
#[cfg(feature = "dialect.shape")]
mod shape;
#[cfg(feature = "target.spirv")]
mod spirv;
#[cfg(all(feature = "dialect.tensor", any(feature = "dialect.linalg", all(feature = "target.spirv", feature = "dialect.memref", feature = "dialect.func"))))]
mod tensor;
#[cfg(feature = "dialect.tosa")]
mod tosa;
mod transforms;
#[cfg(all(feature = "dialect.ub", any(feature = "target.llvm", feature = "target.spirv")))]
mod ub;
#[cfg(feature = "dialect.vector")]
mod vector;
#[cfg(all(feature = "dialect.nvgpu", feature = "target.llvm"))]
mod nvgpu;
#[cfg(all(feature = "dialect.nvvm", feature = "target.llvm"))]
mod nvvm;
#[cfg(all(feature = "dialect.xegpu", feature = "target.llvm"))]
mod xegpu;
#[cfg(all(feature = "dialect.xevm", feature = "target.llvm"))]
mod xevm;

#[cfg(feature = "dialect.affine")]
pub use affine::*;
#[cfg(all(feature = "dialect.amdgpu", feature = "target.llvm"))]
pub use amdgpu::*;
#[cfg(all(feature = "dialect.arith", any(feature = "target.emitc", feature = "target.llvm", feature = "target.spirv")))]
pub use arith::*;
#[cfg(feature = "dialect.bufferization")]
pub use bufferization::*;
#[cfg(all(feature = "dialect.cf", any(feature = "target.llvm", feature = "target.spirv")))]
pub use cf::*;
#[cfg(feature = "dialect.complex")]
pub use complex::*;
#[cfg(feature = "target.emitc")]
pub use emitc::*;
#[cfg(all(feature = "dialect.func", any(feature = "target.emitc", feature = "target.llvm", feature = "target.spirv")))]
pub use func::*;
#[cfg(feature = "dialect.gpu")]
pub use gpu::*;
#[cfg(all(feature = "dialect.index", any(feature = "target.llvm", feature = "target.spirv")))]
pub use index::*;
#[cfg(feature = "dialect.linalg")]
pub use linalg::*;
#[cfg(feature = "target.llvm")]
pub use llvm::*;
#[cfg(feature = "dialect.math")]
pub use math::*;
#[cfg(feature = "dialect.memref")]
pub use memref::*;
#[cfg(feature = "dialect.scf")]
pub use scf::*;
#[cfg(feature = "dialect.shape")]
pub use shape::*;
#[cfg(feature = "target.spirv")]
pub use spirv::*;
#[cfg(all(feature = "dialect.tensor", any(feature = "dialect.linalg", all(feature = "target.spirv", feature = "dialect.memref", feature = "dialect.func"))))]
pub use tensor::*;
#[cfg(feature = "dialect.tosa")]
pub use tosa::*;
pub use transforms::*;
#[cfg(all(feature = "dialect.ub", any(feature = "target.llvm", feature = "target.spirv")))]
pub use ub::*;
#[cfg(feature = "dialect.vector")]
pub use vector::*;
#[cfg(all(feature = "dialect.nvgpu", feature = "target.llvm"))]
pub use nvgpu::*;
#[cfg(all(feature = "dialect.nvvm", feature = "target.llvm"))]
pub use nvvm::*;
#[cfg(all(feature = "dialect.xegpu", feature = "target.llvm"))]
pub use xegpu::*;
#[cfg(all(feature = "dialect.xevm", feature = "target.llvm"))]
pub use xevm::*;
