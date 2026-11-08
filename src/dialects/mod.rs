//! ⭐ The upstream dialects' [`OpInterfaces`](crate::OpInterfaces): one unit struct per
//! dialect, answering for its ops what their C++ interface methods compute.

#[cfg(feature = "dialect.affine")]
mod affine;
#[cfg(feature = "dialect.agx")]
mod agx;
#[cfg(feature = "dialect.apple9")]
mod apple9;
#[cfg(feature = "dialect.arith")]
mod arith;
#[cfg(feature = "dialect.bufferization")]
mod bufferization;
#[cfg(feature = "dialect.cf")]
mod cf;
#[cfg(feature = "dialect.complex")]
mod complex;
#[cfg(feature = "dialect.func")]
mod func;
#[cfg(feature = "dialect.gpu")]
mod gpu;
#[cfg(feature = "dialect.image")]
mod image;
#[cfg(feature = "dialect.index")]
mod index;
#[cfg(feature = "dialect.linalg")]
mod linalg;
#[cfg(feature = "dialect.llvm")]
mod llvm;
#[cfg(feature = "dialect.math")]
mod math;
#[cfg(feature = "dialect.memref")]
mod memref;
#[cfg(feature = "dialect.ml_program")]
mod ml_program;
#[cfg(feature = "dialect.rdna2")]
mod rdna2;
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
#[cfg(feature = "dialect.ub")]
mod ub;
#[cfg(feature = "dialect.vector")]
mod vector;
#[cfg(feature = "dialect.xe3")]
mod xe3;

#[cfg(feature = "dialect.affine")]
pub use affine::AffineDialect;
#[cfg(feature = "dialect.agx")]
pub use agx::*;
#[cfg(feature = "dialect.apple9")]
pub use apple9::*;
#[cfg(feature = "dialect.arith")]
pub use arith::ArithDialect;
#[cfg(feature = "dialect.bufferization")]
pub use bufferization::BufferizationDialect;
#[cfg(feature = "dialect.cf")]
pub use cf::CfDialect;
#[cfg(feature = "dialect.complex")]
pub use complex::ComplexDialect;
#[cfg(feature = "dialect.func")]
pub use func::FuncDialect;
#[cfg(feature = "dialect.gpu")]
pub use gpu::GpuDialect;
#[cfg(feature = "dialect.image")]
pub use image::{
    Data as ImageData, Field as PackField, Fill, Fields, Group as PackGroup, Hole, Image, ImageDialect, ImageEmit, ImageTarget, Item as PackItem, Layout as ImageLayout, Layouts, MemType, Memory as ImageMemory, Placed as ImagePlaced, Real,
    Segment as ImageSegment, Stream as ImageStream, Template, Ty as PackTy, Words as ImageWords, attribute_of,
};
#[cfg(feature = "dialect.index")]
pub use index::IndexDialect;
#[cfg(feature = "dialect.linalg")]
pub use linalg::{IndexAttr, LinalgDialect, OpDsl, OPDSL};
#[cfg(feature = "dialect.llvm")]
pub use llvm::LlvmDialect;
#[cfg(feature = "dialect.math")]
pub use math::MathDialect;
#[cfg(feature = "dialect.memref")]
pub use memref::MemrefDialect;
#[cfg(feature = "dialect.ml_program")]
pub use ml_program::MlProgramDialect;
#[cfg(feature = "dialect.rdna2")]
pub use rdna2::*;
#[cfg(feature = "dialect.scf")]
pub use scf::ScfDialect;
#[cfg(feature = "dialect.shape")]
pub use shape::ShapeDialect;
#[cfg(feature = "dialect.spirv")]
pub use spirv::SpirvDialect;
#[cfg(feature = "dialect.tensor")]
pub use tensor::TensorDialect;
#[cfg(feature = "dialect.test")]
pub use test::TestDialect;
#[cfg(feature = "dialect.tosa")]
pub use tosa::TosaDialect;
#[cfg(feature = "dialect.ub")]
pub use ub::UbDialect;
#[cfg(feature = "dialect.vector")]
pub use vector::VectorDialect;

#[cfg(any(feature = "dialect.tensor", feature = "dialect.memref"))]
use crate::{Body, OpId};

#[cfg(any(feature = "dialect.tensor", feature = "dialect.memref"))]
impl Body<'_> {
    /// `tensor.dim` / `memref.dim`: speculatable when the index is a constant in range.
    fn dim_speculatability(&self, op: OpId) -> Option<bool> {
        let i = self.int_constant(self[op].operands[1])?;
        let rank = self[self[op].operands[0]].ty.shape()?.len() as i128;
        (i < rank).then_some(false)
    }
}
#[cfg(feature = "dialect.xe3")]
pub use xe3::*;
