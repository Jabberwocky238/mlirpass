//! `gpu` passes.

mod gpu_kernel_outlining;
mod gpu_launch_sink_index_computations;
mod outlining;

pub use gpu_kernel_outlining::{GpuKernelOutlining};
pub use gpu_launch_sink_index_computations::{GpuLaunchSinkIndexComputations};

#[cfg(feature = "spirv")]
mod convert_gpu_to_spirv;
#[cfg(feature = "spirv")]
pub use convert_gpu_to_spirv::*;
