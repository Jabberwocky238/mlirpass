mod canonicalize;

pub use canonicalize::SpirvCanon;
pub(crate) use canonicalize::Folder as SpirvFolder;
#[cfg(feature = "target.spirv")]
mod webgpu_prepare;
#[cfg(feature = "target.spirv")]
pub use webgpu_prepare::WebgpuPrepare;

#[cfg(feature = "target.spirv")]
mod to_arith;
#[cfg(feature = "target.spirv")]
pub use to_arith::SpirvToArith;
