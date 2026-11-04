//! `tensor` passes.

#[cfg(feature = "dialect.linalg")]
mod convert_tensor_to_linalg;

#[cfg(feature = "dialect.linalg")]
pub use convert_tensor_to_linalg::{ConvertTensorToLinalg};

#[cfg(all(feature = "target.spirv", feature = "dialect.memref", feature = "dialect.func"))]
mod convert_tensor_to_spirv;
#[cfg(all(feature = "target.spirv", feature = "dialect.memref", feature = "dialect.func"))]
pub use convert_tensor_to_spirv::*;
