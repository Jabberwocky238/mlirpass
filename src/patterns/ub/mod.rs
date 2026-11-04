//! `ub` rule sets.

#[cfg(feature = "spirv")]
mod to_spirv;
#[cfg(feature = "spirv")]
pub use to_spirv::UbToSpirv;
