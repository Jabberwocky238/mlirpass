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

mod attrs;

pub use attrs::{AllReduceOp, Dimension, ShuffleMode};

#[cfg(feature = "target.llvm")]
mod to_llvm;
#[cfg(feature = "target.llvm")]
pub use to_llvm::{GpuLlvmOptions, GpuToLlvm, Printf, PrintfCall};

#[cfg(feature = "target.llvm")]
mod to_llvm_spv;
#[cfg(feature = "target.llvm")]
pub use to_llvm_spv::GpuToLlvmSpv;

#[cfg(all(feature = "target.llvm", feature = "dialect.nvvm"))]
mod to_nvvm;
#[cfg(all(feature = "target.llvm", feature = "dialect.nvvm"))]
pub use to_nvvm::{AssertToNvvm, GpuReduxToNvvm, GpuToNvvm};

mod rewrite;
pub use rewrite::GpuRewrite;

#[cfg(all(feature = "target.llvm", feature = "dialect.nvvm"))]
#[path = "wmma_nvvm.gen.rs"]
mod wmma_nvvm_gen;
#[cfg(all(feature = "target.llvm", feature = "dialect.nvvm"))]
mod wmma_to_nvvm;
#[cfg(all(feature = "target.llvm", feature = "dialect.nvvm"))]
pub use wmma_to_nvvm::{convert_mma_types, WmmaToNvvm};
