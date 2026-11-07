//! The `xe3` passes: a kernel's registers, its control flow, its software scoreboard and branches, its padding; the
//! batches' ends; the image's layout.

mod xe3_control;
mod xe3_end;
mod xe3_layout;
mod xe3_pad;
mod xe3_regalloc;
mod xe3_swsb;

pub use xe3_control::*;
pub use xe3_end::*;
pub use xe3_layout::*;
pub use xe3_pad::*;
pub use xe3_regalloc::*;
pub use xe3_swsb::*;
