#[cfg(feature = "target.llvm")]
mod convert_arith_to_llvm;
#[cfg(feature = "target.llvm")]
pub use convert_arith_to_llvm::*;

#[cfg(feature = "target.spirv")]
mod convert_arith_to_spirv;
#[cfg(feature = "target.spirv")]
pub use convert_arith_to_spirv::*;

#[cfg(feature = "target.emitc")]
mod convert_arith_to_emitc;
#[cfg(feature = "target.emitc")]
pub use convert_arith_to_emitc::*;

#[cfg(all(feature = "dialect.amdgpu", feature = "dialect.vector"))]
mod convert_arith_to_amdgpu;
#[cfg(all(feature = "dialect.amdgpu", feature = "dialect.vector"))]
pub use convert_arith_to_amdgpu::ConvertArithToAmdgpu;
