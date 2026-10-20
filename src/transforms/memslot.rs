//! ⭐ Memory slots, as `MemorySlotInterfaces.h`: what `mem2reg` promotes and `sroa` destructures.
//! The interfaces' per-op implementations (`LLVMMemorySlot.cpp`, `MemRefMemorySlot.cpp`) live
//! with the pass that asks them: promotion in `mem2reg.rs`, destructuring in `sroa.rs`.

use alloc::vec::Vec;

use mlirformat::{Attribute, Type};

use crate::ValueId;

/// `MemorySlot`: a pointer to memory holding one value of type `elem`.
#[derive(Debug, Clone, PartialEq)]
pub struct MemorySlot<'a> {
    pub ptr: ValueId,
    pub elem: Type<'a>,
}

/// `DestructurableMemorySlot`: a slot whose value splits into subelements, keyed by index.
#[derive(Debug, Clone, PartialEq)]
pub struct DestructurableMemorySlot<'a> {
    pub slot: MemorySlot<'a>,
    /// `subelementTypes`, in the order the allocator lists them.
    pub subelements: Vec<(Attribute<'a>, Type<'a>)>,
}
