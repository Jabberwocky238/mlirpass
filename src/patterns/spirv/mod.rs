mod canonicalize;

pub use canonicalize::SpirvCanon;
pub(crate) use canonicalize::Folder as SpirvFolder;
#[cfg(feature = "target.spirv")]
mod webgpu_prepare;
#[cfg(feature = "target.spirv")]
pub use webgpu_prepare::WebgpuPrepare;

#[cfg(any(feature = "target.agx", feature = "target.rdna2", feature = "target.xe3"))]
mod to_arith;
#[cfg(any(feature = "target.agx", feature = "target.rdna2", feature = "target.xe3"))]
pub use to_arith::SpirvToArith;
