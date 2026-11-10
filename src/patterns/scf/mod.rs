//! `scf` rule sets.

mod canonicalize;
mod forall;
mod structural;
mod to_cf;
#[cfg(all(feature = "dialect.gpu", feature = "dialect.affine"))]
mod to_gpu;

pub use to_cf::{ScfToCf};
#[cfg(all(feature = "dialect.gpu", feature = "dialect.affine"))]
pub use to_gpu::ScfToGpu;
pub use canonicalize::ScfCanon;
pub use structural::ScfStructural;

#[cfg(feature = "target.spirv")]
mod to_spirv;
#[cfg(feature = "target.spirv")]
pub use to_spirv::ScfToSpirv;

#[cfg(feature = "target.emitc")]
mod to_emitc;
#[cfg(feature = "target.emitc")]
pub use to_emitc::ScfToEmitc;
