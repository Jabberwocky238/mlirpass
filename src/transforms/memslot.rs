//! ⭐ Memory slots, as `MemorySlotInterfaces.td`: what `mem2reg` promotes and `sroa` destructures.
//!
//! An interface is a trait a dialect implements once, answering for its ops by name: each
//! method returns `None` (or `false`) for an op that does not implement it. The passes hold the
//! dialects they know as a slice (`&[&dyn Promotable]`), nothing global.
//!
//! ```text
//! Promotable      PromotableAllocationOpInterface, PromotableMemOpInterface, PromotableOpInterface
//! Destructurable  DestructurableAllocationOpInterface, SafeMemorySlotAccessOpInterface,
//!                 DestructurableAccessorOpInterface, DestructurableTypeInterface
//! ```
//!
//! Hooks that build get a [`Rewriter`] (listener [`crate::Quiet`]) placed where the C++ builder
//! is: after the op for use removal and `getStored`, at the start of the block for block
//! arguments and default values.

use alloc::collections::BTreeSet;
use alloc::vec::Vec;

use mlirformat::{Attribute, Type};

use crate::{BlockId, Body, DataLayout, OpId, RegionId, Rewriter, Use, ValueId};

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
    /// The uses of `v` in MLIR's use-list order: most recent first.
    pub fn use_list(&self, v: ValueId) -> Vec<Use> {
        self[v].uses.iter().rev().copied().collect()
    }

    /// `topologicalSort`: `ops` in a dominance respecting pre-order walk of the IR, from the
    /// outermost op holding the first of them.
    pub fn topological_sort(&self, ops: &[OpId]) -> Vec<OpId> {
        if ops.len() <= 1 {
            return ops.to_vec();
        }
        let mut top = ops[0];
        while let Some(p) = self.parent_op(top) {
            top = p;
        }
        let mut out = Vec::new();
        let mut stack = alloc::vec![top];
        while let Some(op) = stack.pop() {
            if ops.contains(&op) {
                out.push(op);
            }
            for r in self[op].regions.iter().rev() {
                for blk in self.blocks_by_dominance(*r).into_iter().rev() {
                    stack.extend(self[blk].ops.iter().rev());
                }
            }
        }
        out
    }

    /// `getVolatile_` / `getIsVolatile`.
    pub fn is_volatile(&self, op: OpId) -> bool {
        match self[op].get("volatile_").or_else(|| self[op].get("isVolatile")) {
            Some(Attribute::Bool(v)) => *v,
            Some(Attribute::Int { lit, .. }) => lit != "0" && lit != "false",
            Some(_) => true,
            None => false,
        }
    }

    /// `getStaticMemIntrLen`: the `len` attribute, or the length operand, if a constant of at
    /// most 64 bits.
    pub fn mem_intr_len(&self, op: OpId) -> Option<u64> {
        let len = match self[op].get("len") {
            Some(a) => a.clone(),
            None => self.constant_of(*self[op].operands.get(2)?)?,
        };
        let i = crate::Const::try_from(&len).ok().filter(|c| !c.elements)?.as_int()?;
        (i.width <= 64).then(|| i.unsigned() as u64)
    }

    /// `getForwardSlice(v)`: the ops transitively using `v`, topologically sorted.
    pub fn forward_slice(&self, v: ValueId) -> Vec<OpId> {
        let mut post = Vec::new();
        let mut seen = BTreeSet::new();
        let mut stack: Vec<(OpId, bool)> = self[v].uses.iter().rev().map(|u| (u.op, false)).collect();
        stack.reverse();
        while let Some((op, done)) = stack.pop() {
            if done {
                post.push(op);
                continue;
            }
            if !seen.insert(op) {
                continue;
            }
            stack.push((op, true));
            let users: Vec<OpId> = self[op].results.iter().flat_map(|r| self[*r].uses.iter().rev().map(|u| u.op)).collect();
            stack.extend(users.into_iter().rev().filter(|u| !seen.contains(u)).map(|u| (u, false)));
        }
        post.reverse();
        post
    }

    /// `getBlocksSortedByDominance`: reverse post-order from each block not yet reached.
    pub fn blocks_by_dominance(&self, region: RegionId) -> Vec<BlockId> {
        let mut out: Vec<BlockId> = Vec::new();
        for b in self[region].blocks.clone() {
            if out.contains(&b) {
                continue;
            }
            let mut rpo = self.post_order(b);
            rpo.retain(|x| !out.contains(x));
            rpo.reverse();
            out.extend(rpo);
        }
        out
    }

    /// The implementation in `dialects` answering for `op`, by its namespace.
    pub fn promotable<'d>(&self, dialects: &[&'d dyn Promotable], op: OpId) -> Option<&'d dyn Promotable> {
        let ns = self[op].name.split_once('.').map(|(ns, _)| ns)?;
        dialects.iter().copied().find(|d| d.dialect() == ns)
    }
}

/// What the destructuring interfaces are asked with: every dialect's (an op of one dialect may
/// ask about a type of another) and the data layout.
#[derive(Clone, Copy)]
pub struct Slots<'s> {
    pub dialects: &'s [&'s dyn Destructurable],
    pub layout: &'s DataLayout,
}

impl Slots<'_> {
    /// `DestructurableTypeInterface::getSubelementIndexMap` of `ty`, whichever dialect owns it.
    pub fn subelements<'a>(&self, ty: &Type<'a>) -> Option<Vec<(Attribute<'a>, Type<'a>)>> {
        self.dialects.iter().find_map(|d| d.subelements(ty))
    }

    /// `DestructurableTypeInterface::getTypeAtIndex` of `ty`.
    pub fn type_at<'a>(&self, ty: &Type<'a>, index: &Attribute<'a>) -> Option<Type<'a>> {
        self.dialects.iter().find_map(|d| d.type_at(ty, index))
    }
}

/// ⭐ The destructuring interfaces of one dialect's ops and types.
///
/// `used` is `usedIndices`: a set, kept in insertion order. `subslots` is the map
/// `destructure` returned.
#[allow(unused_variables)]
pub trait Destructurable {
    /// The namespace whose ops and types this answers for (`llvm`, `memref`).
    fn dialect(&self) -> &str;

    // ---- DestructurableTypeInterface ----------------------------------------------------

    /// `getSubelementIndexMap`, in index order; `None`: not destructurable, or not this
    /// dialect's type.
    fn subelements<'a>(&self, ty: &Type<'a>) -> Option<Vec<(Attribute<'a>, Type<'a>)>> {
        None
    }

    /// `getTypeAtIndex`; `None` for a null type.
    fn type_at<'a>(&self, ty: &Type<'a>, index: &Attribute<'a>) -> Option<Type<'a>> {
        None
    }

    // ---- DestructurableAllocationOpInterface --------------------------------------------

    /// `getDestructurableSlots`; `None`: `op` is no destructurable allocation.
    fn destructurable_slots<'a>(&self, cx: Slots<'_>, b: &Body<'a>, op: OpId) -> Option<Vec<DestructurableMemorySlot<'a>>> {
        None
    }

    /// `destructure`: one subslot per `used` index. `rw` is at the start of the block defining
    /// the slot pointer; new allocators go to `allocators`.
    fn destructure<'a>(&self, cx: Slots<'_>, rw: &mut Rewriter<'_, 'a>, alloc: OpId, slot: &DestructurableMemorySlot<'a>, used: &[Attribute<'a>], allocators: &mut Vec<OpId>) -> Vec<(Attribute<'a>, MemorySlot<'a>)> {
        unreachable!("{}: not a destructurable allocation", self.dialect())
    }

    /// `handleDestructuringComplete`; the new allocator, if it made one.
    fn handle_destructuring_complete<'a>(&self, rw: &mut Rewriter<'_, 'a>, alloc: OpId, slot: &DestructurableMemorySlot<'a>) -> Option<OpId> {
        None
    }

    // ---- SafeMemorySlotAccessOpInterface ------------------------------------------------

    /// `ensureOnlySafeAccesses`; `None`: `op` does not implement it. Slots whose accesses must
    /// be safe too go to `must_be_safe`.
    fn ensure_only_safe_accesses<'a>(&self, cx: Slots<'_>, b: &Body<'a>, op: OpId, slot: &MemorySlot<'a>, must_be_safe: &mut Vec<MemorySlot<'a>>) -> Option<bool> {
        None
    }

    // ---- DestructurableAccessorOpInterface ----------------------------------------------

    /// Whether `op` implements `DestructurableAccessorOpInterface`.
    fn is_accessor(&self, b: &Body<'_>, op: OpId) -> bool {
        false
    }

    /// `canRewire`: the indices `op` accesses go to `used`.
    fn can_rewire<'a>(&self, cx: Slots<'_>, b: &Body<'a>, op: OpId, slot: &DestructurableMemorySlot<'a>, used: &mut Vec<Attribute<'a>>, must_be_safe: &mut Vec<MemorySlot<'a>>) -> bool {
        false
    }

    /// `rewire`; `rw` is right after `op`.
    fn rewire<'a>(&self, cx: Slots<'_>, rw: &mut Rewriter<'_, 'a>, op: OpId, slot: &DestructurableMemorySlot<'a>, subslots: &[(Attribute<'a>, MemorySlot<'a>)]) -> Deletion {
        Deletion::Keep
    }
}

impl Body<'_> {
    /// The implementation in `dialects` answering for `op`, by its namespace.
    pub fn destructurable<'d>(&self, dialects: &[&'d dyn Destructurable], op: OpId) -> Option<&'d dyn Destructurable> {
        let ns = self[op].name.split_once('.').map(|(ns, _)| ns)?;
        dialects.iter().copied().find(|d| d.dialect() == ns)
    }
}

/// `llvm`'s memory slot interfaces: [`Promotable`] in `mem2reg/llvm.rs`, [`Destructurable`]
/// in `sroa/llvm.rs` (`LLVMMemorySlot.cpp`).
pub struct LlvmSlots;

/// `memref`'s memory slot interfaces: [`Promotable`] in `mem2reg/memref.rs`, [`Destructurable`]
/// in `sroa/memref.rs` (`MemRefMemorySlot.cpp`).
pub struct MemrefSlots;
