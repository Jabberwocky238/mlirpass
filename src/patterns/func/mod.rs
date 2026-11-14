mod canonicalize;

pub use canonicalize::FuncCanon;

#[cfg(feature = "target.llvm")]
mod to_llvm;
#[cfg(feature = "target.llvm")]
pub use to_llvm::FuncToLlvm;

#[cfg(feature = "target.spirv")]
mod to_spirv;
#[cfg(feature = "target.spirv")]
pub use to_spirv::FuncToSpirv;

#[cfg(feature = "target.emitc")]
mod to_emitc;
#[cfg(feature = "target.emitc")]
pub use to_emitc::FuncToEmitc;
