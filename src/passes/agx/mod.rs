//! The `agx` passes: a kernel's registers, then its waits; the streams' and kernels' ends; the image's layout.

mod agx_end;
mod agx_layout;
mod agx_regalloc;
mod agx_wait;

pub use agx_end::*;
pub use agx_layout::*;
pub use agx_regalloc::*;
pub use agx_wait::*;

use agx_regalloc::Alloc;
