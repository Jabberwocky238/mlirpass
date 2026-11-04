//! `linalg` rule sets.

mod canonicalize;
mod build;
mod elementwise_to_linalg;
mod to_loops;

pub(crate) use build::{Named, i64_elements};
mod drop_unit_dims;
pub use elementwise_to_linalg::{ElementwiseToLinalg};
pub use to_loops::{LinalgLoops};
pub use drop_unit_dims::{Strategy as DropUnitDimsStrategy};
pub use canonicalize::LinalgCanon;
