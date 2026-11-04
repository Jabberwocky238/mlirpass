//! `amdgpu` rule sets.

#[cfg(feature = "target.llvm")]
mod to_rocdl;
#[cfg(feature = "target.llvm")]
pub use to_rocdl::AmdgpuToRocdl;
