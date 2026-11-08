//! `cf` passes.

#[cfg(feature = "target.llvm")]
mod convert_cf_to_llvm;
#[cfg(feature = "target.llvm")]
pub use convert_cf_to_llvm::*;

#[cfg(feature = "target.spirv")]
mod convert_cf_to_spirv;
#[cfg(feature = "target.spirv")]
pub use convert_cf_to_spirv::*;

#[cfg(all(feature = "dialect.scf", feature = "dialect.func"))]
mod lift_control_flow_to_scf;
#[cfg(all(feature = "dialect.scf", feature = "dialect.func"))]
pub use lift_control_flow_to_scf::*;
