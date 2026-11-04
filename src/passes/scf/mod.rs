//! `scf` passes.

mod convert_parallel_loops_to_gpu;
mod convert_scf_to_cf;
mod gpu_map_parallel_loops;

pub use convert_parallel_loops_to_gpu::{ConvertParallelLoopsToGpu};
pub use gpu_map_parallel_loops::{GpuMapParallelLoops};
pub use convert_scf_to_cf::ConvertScfToCf;

#[cfg(feature = "target.spirv")]
mod convert_scf_to_spirv;
#[cfg(feature = "target.spirv")]
pub use convert_scf_to_spirv::*;

#[cfg(feature = "target.emitc")]
mod convert_scf_to_emitc;
#[cfg(feature = "target.emitc")]
pub use convert_scf_to_emitc::*;
