//! `tensor` rule sets.

mod canonicalize;
mod to_linalg;

pub use to_linalg::{TensorToLinalg};
pub use canonicalize::TensorCanon;

#[cfg(feature = "spirv")]
mod to_spirv;
#[cfg(feature = "spirv")]
pub use to_spirv::TensorToSpirv;
