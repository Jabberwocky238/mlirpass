//! ⭐ The upstream dialects' [`OpInterfaces`](crate::OpInterfaces): one unit struct per
//! dialect, answering for its ops what their C++ interface methods compute.

mod affine;
mod arith;
mod bufferization;
mod cf;
mod func;
mod gpu;
mod linalg;
mod memref;
mod scf;
mod shape;
mod spirv;
mod tensor;
mod test;
mod tosa;
mod ub;
mod vector;

pub use affine::AffineDialect;
pub use arith::ArithDialect;
pub use bufferization::BufferizationDialect;
pub use cf::CfDialect;
pub use func::FuncDialect;
pub use gpu::GpuDialect;
pub use linalg::LinalgDialect;
pub use memref::MemrefDialect;
pub use scf::ScfDialect;
pub use shape::ShapeDialect;
pub use spirv::SpirvDialect;
pub use tensor::TensorDialect;
pub use test::TestDialect;
pub use tosa::TosaDialect;
pub use ub::UbDialect;
pub use vector::VectorDialect;

use crate::{Body, OpId};

impl Body<'_> {
    /// `tensor.dim` / `memref.dim`: speculatable when the index is a constant in range.
    fn dim_speculatability(&self, op: OpId) -> Option<bool> {
        let i = self.int_constant(self[op].operands[1])?;
        let rank = self[self[op].operands[0]].ty.shape()?.len() as i128;
        (i < rank).then_some(false)
    }
}
