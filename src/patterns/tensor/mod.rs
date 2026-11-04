//! `tensor` rule sets.

mod canonicalize;
mod to_linalg;

pub use to_linalg::{TensorToLinalg};
pub use canonicalize::TensorCanon;

#[cfg(feature = "target.spirv")]
mod to_spirv;
#[cfg(feature = "target.spirv")]
pub use to_spirv::TensorToSpirv;
