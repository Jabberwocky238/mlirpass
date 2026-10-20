//! ⭐ Memory slots, as `MemorySlotInterfaces.td`: what `mem2reg` promotes and `sroa` destructures.
//!
//! An interface is a trait a dialect implements once, answering for its ops by name: each
//! method returns `None` (or `false`) for an op that does not implement it. The passes hold the
//! dialects they know as a slice (`&[&dyn Promotable]`), nothing global.
//!
//! ```text
//! Promotable      PromotableAllocationOpInterface, PromotableMemOpInterface, PromotableOpInterface
//! (sroa.rs)       DestructurableAllocationOpInterface, SafeMemorySlotAccessOpInterface,
//!                 DestructurableAccessorOpInterface, DestructurableTypeInterface
//! ```
//!
//! Hooks that build get a [`Rewriter`] (listener [`crate::Quiet`]) placed where the C++ builder
//! is: after the op for use removal and `getStored`, at the start of the block for block
//! arguments and default values.

use alloc::vec::Vec;

use mlirformat::{Attribute, Type};

use crate::{Body, OpId, Rewriter, Use, ValueId};

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

/// `DeletionKind`: what becomes of an op once its blocking uses are removed.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Deletion {
    Keep,
    Delete,
}

/// ⭐ The promotion interfaces of one dialect's ops.
///
/// `blocking` lists the uses (of `op`'s operands) promotion needs gone, ordered by operand.
#[allow(unused_variables)]
pub trait Promotable {
    /// The namespace whose ops this answers for (`llvm`, `memref`).
    fn dialect(&self) -> &str;

    // ---- PromotableAllocationOpInterface ------------------------------------------------

    /// `getPromotableSlots`; `None`: `op` allocates nothing promotable.
    fn promotable_slots<'a>(&self, b: &Body<'a>, op: OpId) -> Option<Vec<MemorySlot<'a>>> {
        None
    }

    /// `getDefaultValue`: what a load before any store reads.
    fn default_value<'a>(&self, rw: &mut Rewriter<'_, 'a>, alloc: OpId, slot: &MemorySlot<'a>) -> ValueId {
        unreachable!("{}: not a promotable allocation", self.dialect())
    }

    /// `handleBlockArgument`: `arg` was added to a merge block for `slot`.
    fn handle_block_argument<'a>(&self, rw: &mut Rewriter<'_, 'a>, alloc: OpId, slot: &MemorySlot<'a>, arg: ValueId) {}

    /// `handlePromotionComplete`; the new allocator, when `alloc` still has other slots.
    fn handle_promotion_complete<'a>(&self, rw: &mut Rewriter<'_, 'a>, alloc: OpId, slot: &MemorySlot<'a>, default: Option<ValueId>) -> Option<OpId> {
        None
    }

    // ---- PromotableMemOpInterface ---------------------------------------------------------

    /// Whether `op` implements `PromotableMemOpInterface`.
    fn is_mem_op(&self, b: &Body<'_>, op: OpId) -> bool {
        false
    }

    /// `loadsFrom`.
    fn loads_from<'a>(&self, b: &Body<'a>, op: OpId, slot: &MemorySlot<'a>) -> bool {
        false
    }

    /// `storesTo`.
    fn stores_to<'a>(&self, b: &Body<'a>, op: OpId, slot: &MemorySlot<'a>) -> bool {
        false
    }

    /// `getStored`: the value `op` stores to `slot`, `reaching` being the slot's value before.
    fn stored<'a>(&self, rw: &mut Rewriter<'_, 'a>, op: OpId, slot: &MemorySlot<'a>, reaching: ValueId) -> ValueId {
        unreachable!("{}: not a promotable memory op", self.dialect())
    }

    // ---- both: PromotableMemOpInterface (`slot` given) and PromotableOpInterface (`None`) --

    /// `canUsesBeRemoved`; `None`: `op` implements neither interface. Further uses to remove
    /// (uses of `op`'s results) go to `new_blocking`.
    fn can_uses_be_removed<'a>(&self, b: &Body<'a>, op: OpId, slot: Option<&MemorySlot<'a>>, blocking: &[Use], new_blocking: &mut Vec<Use>) -> Option<bool> {
        None
    }

    /// `removeBlockingUses`; `reaching` is the slot's value before `op` (memory ops only).
    fn remove_blocking_uses<'a>(&self, rw: &mut Rewriter<'_, 'a>, op: OpId, slot: Option<&MemorySlot<'a>>, blocking: &[Use], reaching: Option<ValueId>) -> Deletion {
        Deletion::Keep
    }

    // ---- PromotableOpInterface ------------------------------------------------------------

    /// `requiresReplacedValues`.
    fn requires_replaced_values(&self, b: &Body<'_>, op: OpId) -> bool {
        false
    }

    /// `visitReplacedValues`: each memory op that stored to the slot, and the value it stored.
    fn visit_replaced_values<'a>(&self, rw: &mut Rewriter<'_, 'a>, op: OpId, replaced: &[(OpId, ValueId)]) {}
}

impl Body<'_> {
    /// The implementation in `dialects` answering for `op`, by its namespace.
    pub fn promotable<'d>(&self, dialects: &[&'d dyn Promotable], op: OpId) -> Option<&'d dyn Promotable> {
        let ns = self[op].name.split_once('.').map(|(ns, _)| ns)?;
        dialects.iter().copied().find(|d| d.dialect() == ns)
    }
}
