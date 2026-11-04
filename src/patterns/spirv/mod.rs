//! `spirv` rule sets.

mod canonicalize;

pub use canonicalize::SpirvCanon;
pub(crate) use canonicalize::Folder as SpirvFolder;
#[cfg(feature = "spirv")]
mod webgpu_prepare;
#[cfg(feature = "spirv")]
pub use webgpu_prepare::WebgpuPrepare;
