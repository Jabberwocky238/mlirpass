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

mod attrs;

pub use attrs::{AllReduceOp, BroadcastType, Dimension, ShuffleMode};

#[cfg(feature = "target.llvm")]
mod to_llvm;
#[cfg(feature = "target.llvm")]
pub use to_llvm::{GpuLlvmOptions, GpuToLlvm, Printf, PrintfCall};

#[cfg(feature = "target.llvm")]
mod to_llvm_spv;
#[cfg(feature = "target.llvm")]
pub use to_llvm_spv::GpuToLlvmSpv;

#[cfg(feature = "target.llvm")]
mod index;
#[cfg(feature = "target.llvm")]
pub use index::constant_range;

#[cfg(all(feature = "target.llvm", feature = "dialect.nvvm"))]
mod to_nvvm;
#[cfg(all(feature = "target.llvm", feature = "dialect.nvvm"))]
pub use to_nvvm::{AssertToNvvm, GpuReduxToNvvm, GpuToNvvm};

mod rewrite;
pub use rewrite::{GpuPromoteShuffleToPermlane, GpuPromoteShuffleToSwizzle, GpuRewrite};

#[cfg(all(feature = "target.llvm", feature = "dialect.nvvm"))]
#[path = "wmma_nvvm.gen.rs"]
mod wmma_nvvm_gen;
#[cfg(all(feature = "target.llvm", feature = "dialect.nvvm"))]
mod wmma_to_nvvm;
#[cfg(all(feature = "target.llvm", feature = "dialect.nvvm"))]
pub use wmma_to_nvvm::{convert_mma_types, WmmaToNvvm};

#[cfg(all(feature = "target.llvm", feature = "dialect.amdgpu", feature = "dialect.math"))]
mod to_rocdl;
#[cfg(all(feature = "target.llvm", feature = "dialect.amdgpu", feature = "dialect.math"))]
pub use to_rocdl::{GpuRocdlOptions, GpuToRocdl};

#[cfg(feature = "target.rdna2")]
mod to_rdna2;
#[cfg(feature = "target.rdna2")]
pub use to_rdna2::*;

#[cfg(feature = "target.agx")]
mod to_agx;
#[cfg(feature = "target.agx")]
pub use to_agx::*;

#[cfg(feature = "target.apple9")]
mod to_apple9;
#[cfg(feature = "target.apple9")]
pub use to_apple9::*;

#[cfg(feature = "target.xe3")]
mod to_xe3;
#[cfg(feature = "target.xe3")]
pub use to_xe3::*;
