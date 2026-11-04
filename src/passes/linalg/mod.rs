//! `linalg` passes.

mod convert_elementwise_to_linalg;
mod convert_linalg_to_affine_loops;
mod convert_linalg_to_loops;
mod convert_linalg_to_parallel_loops;

mod linalg_fold_unit_extent_dims;
pub use convert_elementwise_to_linalg::{ConvertElementwiseToLinalg};
pub use convert_linalg_to_affine_loops::{ConvertLinalgToAffineLoops};
pub use convert_linalg_to_loops::{ConvertLinalgToLoops};
pub use convert_linalg_to_parallel_loops::{ConvertLinalgToParallelLoops};
pub use linalg_fold_unit_extent_dims::{LinalgFoldUnitExtentDims};

/// The `linalg` passes.
#[crate::pass_set(ConvertElementwiseToLinalg, ConvertLinalgToAffineLoops, ConvertLinalgToLoops, ConvertLinalgToParallelLoops, LinalgFoldUnitExtentDims)]
pub struct LinalgPasses;
