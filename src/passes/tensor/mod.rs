//! `tensor` passes.

mod convert_tensor_to_linalg;

pub use convert_tensor_to_linalg::{ConvertTensorToLinalg};

#[cfg(feature = "target.spirv")]
mod convert_tensor_to_spirv;
#[cfg(feature = "target.spirv")]
pub use convert_tensor_to_spirv::*;
