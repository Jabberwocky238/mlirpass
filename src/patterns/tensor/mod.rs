//! `tensor` rule sets.

mod canonicalize;
#[cfg(feature = "dialect.linalg")]
mod to_linalg;

#[cfg(feature = "dialect.linalg")]
pub use to_linalg::{TensorToLinalg};
pub use canonicalize::TensorCanon;

#[cfg(all(feature = "target.spirv", feature = "dialect.memref", feature = "dialect.func"))]
mod to_spirv;
#[cfg(all(feature = "target.spirv", feature = "dialect.memref", feature = "dialect.func"))]
pub use to_spirv::TensorToSpirv;
