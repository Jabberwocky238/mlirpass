//! `llvm`'s destructuring interfaces, as the destructuring half of `LLVMMemorySlot.cpp`.

use crate::transforms::memslot::{Destructurable, LlvmSlots};

impl Destructurable for LlvmSlots {
    fn dialect(&self) -> &str {
        "llvm"
    }
}
