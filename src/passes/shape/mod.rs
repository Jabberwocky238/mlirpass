//! `shape` passes.

mod convert_shape_to_std;

pub use convert_shape_to_std::{ConvertShapeToStd};

/// The `shape` passes.
#[crate::pass_set(ConvertShapeToStd)]
pub struct ShapePasses;
