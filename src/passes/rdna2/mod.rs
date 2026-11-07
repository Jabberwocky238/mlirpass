//! The `rdna2` machine code's passes: registers, then waits.

mod rdna2_regalloc;
mod rdna2_waitcnt;

pub use rdna2_regalloc::*;
pub use rdna2_waitcnt::*;

use rdna2_regalloc::Alloc;
