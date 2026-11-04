//! `xegpu` rule sets.

mod types;

pub use types::{CachePolicy, Chip, FenceScope, MemDesc, MemorySpace as XegpuMemorySpace, TensorDesc};

#[cfg(feature = "target.llvm")]
mod to_xevm;
#[cfg(feature = "target.llvm")]
pub use to_xevm::XegpuToXevm;
