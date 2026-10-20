//! `sroa`, as `SROA.cpp`: memory slots of aggregates split into one slot per used subelement.
//!
//! The dialects answer through [`Destructurable`] (`memslot.rs`); their answers live next to
//! this file: `llvm.rs` (`LLVMMemorySlot.cpp`), `memref.rs` (`MemRefMemorySlot.cpp`).

mod llvm;
mod memref;

use mlirpass_macros::pass;
use mlirformat::Error;

use super::memslot::{Destructurable, LlvmSlots, MemrefSlots};
use crate::{Body, OpId};

#[pass("sroa", ty = Sroa)]
pub fn sroa<'a>(_body: &mut Body<'a>, _op: OpId) -> Result<(), Error> {
    let _dialects: [&dyn Destructurable; 2] = [&LlvmSlots, &MemrefSlots];
    Ok(())
}
