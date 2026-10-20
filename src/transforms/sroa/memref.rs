//! `memref`'s destructuring interfaces, as the destructuring half of `MemRefMemorySlot.cpp`.

use crate::transforms::memslot::{Destructurable, MemrefSlots};

impl Destructurable for MemrefSlots {
    fn dialect(&self) -> &str {
        "memref"
    }
}
