//! `tosa` passes.

mod tosa_to_arith;
mod tosa_to_linalg;
mod tosa_to_linalg_named;
mod tosa_to_scf;
mod tosa_to_tensor;

pub use tosa_to_arith::{TosaToArithPass};
pub use tosa_to_linalg::{TosaToLinalgPass};
pub use tosa_to_linalg_named::{TosaToLinalgNamedPass};
pub use tosa_to_scf::{TosaToScfPass};
pub use tosa_to_tensor::{TosaToTensorPass};
