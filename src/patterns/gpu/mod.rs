//! `gpu` rule sets.

mod canonicalize;

pub use canonicalize::GpuCanon;

#[cfg(feature = "target.spirv")]
mod to_spirv;
#[cfg(feature = "target.spirv")]
pub use to_spirv::{GpuSpirvOptions, GpuToSpirv};

#[cfg(feature = "target.spirv")]
mod wmma_to_spirv;
#[cfg(feature = "target.spirv")]
pub use wmma_to_spirv::WmmaToSpirv;
