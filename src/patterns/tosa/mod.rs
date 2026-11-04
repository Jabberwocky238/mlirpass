//! `tosa` rule sets.

mod canonicalize;
mod to_arith;
mod to_linalg;
mod to_linalg_named;
mod to_scf;
mod to_tensor;

pub use to_arith::{TosaToArith};
pub use to_linalg::{TosaToLinalg};
pub use to_linalg_named::{TosaToLinalgNamed};
pub use to_scf::{TosaToScf};
pub use to_tensor::{TosaToTensor};
pub use canonicalize::TosaCanon;
