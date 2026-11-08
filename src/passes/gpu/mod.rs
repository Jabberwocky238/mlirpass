//! `gpu` passes.

mod gpu_kernel_outlining;
mod gpu_module_to_binary;
mod gpu_launch_sink_index_computations;
mod outlining;

pub use gpu_kernel_outlining::{GpuKernelOutlining};
pub use gpu_module_to_binary::{CompilationFormat, GpuModuleToBinary};
pub use gpu_launch_sink_index_computations::{GpuLaunchSinkIndexComputations};

#[cfg(all(feature = "target.spirv", feature = "dialect.func", feature = "dialect.scf", feature = "dialect.vector"))]
mod convert_gpu_to_spirv;
#[cfg(all(feature = "target.spirv", feature = "dialect.func", feature = "dialect.scf", feature = "dialect.vector"))]
pub use convert_gpu_to_spirv::*;

#[cfg(feature = "target.llvm")]
mod convert_gpu_to_llvm_spv;
#[cfg(feature = "target.llvm")]
pub use convert_gpu_to_llvm_spv::ConvertGpuToLlvmSpv;

mod xevm_attach_target;
pub use xevm_attach_target::XevmAttachTarget;

#[cfg(all(feature = "target.llvm", feature = "dialect.nvvm"))]
mod convert_gpu_to_nvvm;
#[cfg(all(feature = "target.llvm", feature = "dialect.nvvm"))]
pub use convert_gpu_to_nvvm::{configure_nvvm, ConvertGpuToNvvm, NVVM_GPU_SPACES};

#[cfg(all(feature = "target.llvm", feature = "dialect.amdgpu", feature = "dialect.math"))]
mod convert_gpu_to_rocdl;
#[cfg(all(feature = "target.llvm", feature = "dialect.amdgpu", feature = "dialect.math"))]
pub use convert_gpu_to_rocdl::{AmdRuntime, ConvertGpuToRocdl};

#[cfg(any(feature = "target.agx", feature = "target.rdna2", feature = "target.xe3"))]
mod gpu_inline_calls;
#[cfg(any(feature = "target.agx", feature = "target.rdna2", feature = "target.xe3"))]
pub use gpu_inline_calls::*;

#[cfg(feature = "target.rdna2")]
mod convert_gpu_to_rdna2;
#[cfg(feature = "target.rdna2")]
pub use convert_gpu_to_rdna2::*;

#[cfg(feature = "target.agx")]
mod convert_gpu_to_agx;
#[cfg(feature = "target.agx")]
pub use convert_gpu_to_agx::*;

#[cfg(feature = "target.xe3")]
mod convert_gpu_to_xe3;
#[cfg(feature = "target.xe3")]
pub use convert_gpu_to_xe3::*;
