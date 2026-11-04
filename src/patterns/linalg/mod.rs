//! `linalg` rule sets.

mod canonicalize;
mod elementwise_to_linalg;
mod to_loops;

mod drop_unit_dims;
pub use elementwise_to_linalg::{ElementwiseToLinalg};
pub use to_loops::{LinalgLoops};
pub use drop_unit_dims::{Strategy as DropUnitDimsStrategy};
pub use canonicalize::LinalgCanon;
