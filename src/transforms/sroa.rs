//! `sroa`, as `SROA.cpp`: memory slots of aggregates split into one slot per used subelement.
//!
//! The interfaces it asks (`MemorySlotInterfaces.td`) are one [`Destructuring`] per dialect,
//! answering by op name (and for types, by type); [`SroaInterfaces`] holds them, nothing is
//! global. The dialects' answers live next to this file: `llvm.rs` (`LLVMMemorySlot.cpp`),
//! `memref.rs` (`MemRefMemorySlot.cpp`).

mod llvm;
mod memref;

use alloc::boxed::Box;
use alloc::vec::Vec;

use mlirpass_macros::pass;
use mlirformat::{Attribute, Error, Type};

use super::memslot::{Deletion, DestructurableMemorySlot, MemorySlot};
use crate::{Body, DataLayout, OpId, Rewriter};

/// What every interface method is asked with: all dialects' interfaces (an op of one dialect
/// may ask about a type of another) and the data layout.
pub struct Slots<'s> {
    pub dialects: &'s SroaInterfaces,
    pub layout: &'s DataLayout,
}

/// ⭐ One dialect's destructuring interfaces. Op methods are only asked about ops of
/// [`Destructuring::dialect`]; an op that does not implement an interface answers its default.
pub trait Destructuring {
    /// The dialect namespace (`llvm`, `memref`).
    fn dialect(&self) -> &'static str;

    // ---- DestructurableTypeInterface -------------------------------------------------

    /// `getSubelementIndexMap`, in index order; `None`: not destructurable (or not this
    /// dialect's type).
    fn subelements<'a>(&self, _ty: &Type<'a>) -> Option<Vec<(Attribute<'a>, Type<'a>)>> {
        None
    }

    /// `getTypeAtIndex`; `None` for a null type.
    fn type_at<'a>(&self, _ty: &Type<'a>, _index: &Attribute<'a>) -> Option<Type<'a>> {
        None
    }

    // ---- DestructurableAllocationOpInterface -----------------------------------------

    /// Whether op `name` implements `DestructurableAllocationOpInterface`.
    fn allocator(&self, _name: &str) -> bool {
        false
    }

    /// `getDestructurableSlots`.
    fn slots<'a>(&self, _cx: &Slots<'_>, _b: &Body<'a>, _op: OpId) -> Vec<DestructurableMemorySlot<'a>> {
        Vec::new()
    }

    /// `destructure`: one subslot per `used` index, in `used`'s order. `rw` is at the start of
    /// the block defining the slot pointer; new allocators go to `allocators`.
    fn destructure<'a>(&self, _cx: &Slots<'_>, _rw: &mut Rewriter<'_, 'a>, _op: OpId, _slot: &DestructurableMemorySlot<'a>, _used: &[Attribute<'a>], _allocators: &mut Vec<OpId>) -> Vec<(Attribute<'a>, MemorySlot<'a>)> {
        Vec::new()
    }

    /// `handleDestructuringComplete`: the new allocator it made, if any.
    fn destructured<'a>(&self, _rw: &mut Rewriter<'_, 'a>, _op: OpId, _slot: &DestructurableMemorySlot<'a>) -> Option<OpId> {
        None
    }

    // ---- SafeMemorySlotAccessOpInterface ---------------------------------------------

    /// `ensureOnlySafeAccesses`; `false` too when the op does not implement it.
    fn safe<'a>(&self, _cx: &Slots<'_>, _b: &Body<'a>, _op: OpId, _slot: &MemorySlot<'a>, _must_be_safe: &mut Vec<MemorySlot<'a>>) -> bool {
        false
    }

    // ---- DestructurableAccessorOpInterface -------------------------------------------

    /// Whether op `name` implements `DestructurableAccessorOpInterface`.
    fn accessor(&self, _name: &str) -> bool {
        false
    }

    /// `canRewire`: adds the indices it accesses to `used` (a set, kept in insertion order).
    fn can_rewire<'a>(&self, _cx: &Slots<'_>, _b: &Body<'a>, _op: OpId, _slot: &DestructurableMemorySlot<'a>, _used: &mut Vec<Attribute<'a>>, _must_be_safe: &mut Vec<MemorySlot<'a>>) -> bool {
        false
    }

    /// `rewire`; `rw` is right after `op`, which must not be erased here.
    fn rewire<'a>(&self, _cx: &Slots<'_>, _rw: &mut Rewriter<'_, 'a>, _op: OpId, _slot: &DestructurableMemorySlot<'a>, _subslots: &[(Attribute<'a>, MemorySlot<'a>)]) -> Deletion {
        Deletion::Keep
    }
}

/// The dialects' [`Destructuring`]s; [`Default`]: the upstream dialects this crate knows.
pub struct SroaInterfaces {
    by_dialect: Vec<Box<dyn Destructuring>>,
}

impl SroaInterfaces {
    pub fn new() -> Self {
        Self { by_dialect: Vec::new() }
    }

    pub fn register(&mut self, d: impl Destructuring + 'static) -> &mut Self {
        self.by_dialect.push(Box::new(d));
        self
    }

    /// The interfaces of op `name`'s dialect.
    pub fn of(&self, name: &str) -> Option<&dyn Destructuring> {
        let ns = name.split_once('.').map_or(name, |(ns, _)| ns);
        self.by_dialect.iter().find(|d| d.dialect() == ns).map(|d| &**d)
    }

    /// `DestructurableTypeInterface::getSubelementIndexMap` of `ty`, whichever dialect owns it.
    pub fn subelements<'a>(&self, ty: &Type<'a>) -> Option<Vec<(Attribute<'a>, Type<'a>)>> {
        self.by_dialect.iter().find_map(|d| d.subelements(ty))
    }

    /// `DestructurableTypeInterface::getTypeAtIndex` of `ty`.
    pub fn type_at<'a>(&self, ty: &Type<'a>, index: &Attribute<'a>) -> Option<Type<'a>> {
        self.by_dialect.iter().find_map(|d| d.type_at(ty, index))
    }
}

impl Default for SroaInterfaces {
    fn default() -> Self {
        let mut s = Self::new();
        s.register(llvm::LlvmSlots).register(memref::MemrefSlots);
        s
    }
}

#[pass("sroa", ty = Sroa)]
pub fn sroa<'a>(_body: &mut Body<'a>, _op: OpId) -> Result<(), Error> {
    Ok(())
}
