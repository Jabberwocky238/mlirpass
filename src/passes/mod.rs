//! ⭐ Passes: pipeline units, one directory per source dialect, a file per pass
//! (`scf/convert_scf_to_cf.rs`).

mod affine;
#[cfg(any(feature = "emitc", feature = "llvm", feature = "spirv"))]
mod arith;
mod bufferization;
#[cfg(any(feature = "llvm", feature = "spirv"))]
mod cf;
mod complex;
#[cfg(feature = "emitc")]
mod emitc;
#[cfg(any(feature = "emitc", feature = "llvm", feature = "spirv"))]
mod func;
mod gpu;
#[cfg(any(feature = "llvm", feature = "spirv"))]
mod index;
mod linalg;
#[cfg(feature = "llvm")]
mod llvm;
mod math;
mod memref;
mod scf;
mod shape;
#[cfg(feature = "spirv")]
mod spirv;
mod tensor;
mod tosa;
mod transforms;
#[cfg(any(feature = "llvm", feature = "spirv"))]
mod ub;
mod vector;

pub use affine::*;
#[cfg(any(feature = "emitc", feature = "llvm", feature = "spirv"))]
pub use arith::*;
pub use bufferization::*;
#[cfg(any(feature = "llvm", feature = "spirv"))]
pub use cf::*;
pub use complex::*;
#[cfg(feature = "emitc")]
pub use emitc::*;
#[cfg(any(feature = "emitc", feature = "llvm", feature = "spirv"))]
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
#[cfg(feature = "spirv")]
pub use spirv::*;
pub use tensor::*;
pub use tosa::*;
pub use transforms::*;
#[cfg(any(feature = "llvm", feature = "spirv"))]
pub use ub::*;
pub use vector::*;

/// The dialect passes: lowerings between dialects and dialect-specific transforms.
#[crate::pass_set(BufferResultsToOutParams, ExpandStridedMetadata, LinalgFoldUnitExtentDims, PromoteBuffersToStack, ConvertAffineForToGpu, ConvertParallelLoopsToGpu, GpuMapParallelLoops, GpuKernelOutlining, GpuLaunchSinkIndexComputations, ConvertBufferizationToMemref, ConvertComplexToLibm, ConvertLinalgToAffineLoops, ConvertLinalgToLoops, ConvertLinalgToParallelLoops, ConvertComplexToStandard, ConvertElementwiseToLinalg, ConvertMathToFuncs, ConvertMathToLibm, ConvertScfToCf, ConvertShapeToStd, ConvertTensorToLinalg, ConvertVectorToScf, LowerAffine, TosaToArithPass, TosaToLinalgNamedPass, TosaToLinalgPass, TosaToScfPass, TosaToTensorPass)]
pub struct DialectPasses;
