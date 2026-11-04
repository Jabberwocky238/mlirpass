//! `tensor` passes.

mod convert_tensor_to_linalg;

pub use convert_tensor_to_linalg::{ConvertTensorToLinalg};

#[cfg(feature = "spirv")]
mod convert_tensor_to_spirv;
#[cfg(feature = "spirv")]
pub use convert_tensor_to_spirv::*;
