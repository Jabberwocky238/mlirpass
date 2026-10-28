//! `sroa`, as `SROA.cpp`: memory slots of aggregates split into one slot per used subelement.
//!
//! The dialects answer through [`Destructurable`] (`memslot.rs`): `llvm`'s in `llvm/memslot.rs`
//! (`LLVMMemorySlot.cpp`), `memref`'s in `memref_slots.rs` (`MemRefMemorySlot.cpp`).
//!
//! Orders follow MLIR's: a value's uses are visited most recent first (its use list), and
//! `usedIndices` keeps the order indices were first inserted in (a small `SmallPtrSet`).

use alloc::collections::BTreeSet;
use alloc::vec::Vec;

use crate::pass;
use mlirformat::{Attribute, Error};

use super::memref_slots::TestSlots;
use super::memslot::{Deletion, Destructurable, DestructurableMemorySlot, MemrefSlots, Promotable, Slots};
use crate::{Body, DataLayout, OpId, Quiet, Rewriter, Use};

/// `MemorySlotDestructuringInfo`.
#[derive(Default)]
struct Info<'a> {
    /// `usedIndices`.
    used: Vec<Attribute<'a>>,
    /// `userToBlockingUses`, each user's uses ordered by operand.
    blocking: Vec<(OpId, Vec<Use>)>,
    /// Accessors that will rewire their uses.
    accessors: Vec<OpId>,
}

impl Info<'_> {
    fn block(&mut self, u: Use) {
        match self.blocking.iter_mut().find(|(op, _)| *op == u.op) {
            Some((_, uses)) => {
                if let Err(i) = uses.binary_search_by_key(&u.index, |x| x.index) {
                    uses.insert(i, u);
                }
            }
            None => self.blocking.push((u.op, alloc::vec![u])),
        }
    }
}

/// `tryToDestructureMemorySlots` and what it asks with.
struct Destructurer<'s> {
    cx: Slots<'s>,
    promotable: &'s [&'s dyn Promotable],
}

impl<'s> Destructurer<'s> {
    /// `computeDestructuringInfo`; `None` when `slot` cannot be destructured or nothing uses it.
    fn info<'a>(&self, b: &Body<'a>, slot: &DestructurableMemorySlot<'a>) -> Option<Info<'a>> {
        let ptr = slot.slot.ptr;
        if b[ptr].uses.is_empty() {
            return None;
        }
        let mut info = Info::default();
        let mut must_be_safe = Vec::new();
        for u in b.use_list(ptr) {
            if let Some(d) = b.destructurable(self.cx.dialects, u.op).filter(|d| d.is_accessor(b, u.op))
                && d.can_rewire(self.cx, b, u.op, slot, &mut info.used, &mut must_be_safe)
            {
                info.accessors.push(u.op);
                continue;
            }
            info.block(u);
        }

        let mut visited = BTreeSet::new();
        while let Some(sub) = must_be_safe.pop() {
            for u in b.use_list(sub.ptr) {
                if !visited.insert((u.op, u.index)) {
                    continue;
                }
                let safe = b.destructurable(self.cx.dialects, u.op).and_then(|d| d.ensure_only_safe_accesses(self.cx, b, u.op, &sub, &mut must_be_safe));
                if safe != Some(true) {
                    info.block(u);
                }
            }
        }

        for user in b.forward_slice(ptr) {
            let Some(at) = info.blocking.iter().position(|(op, _)| *op == user) else { continue };
            let p = b.promotable(self.promotable, user)?;
            let mut new_blocking = Vec::new();
            if p.can_uses_be_removed(b, user, None, &info.blocking[at].1, &mut new_blocking) != Some(true) {
                return None;
            }
            new_blocking.into_iter().for_each(|u| info.block(u));
        }
        Some(info)
    }

    /// `destructureSlot`.
    fn destructure<'a>(&self, b: &mut Body<'a>, alloc: OpId, d: &dyn Destructurable, slot: &DestructurableMemorySlot<'a>, info: &Info<'a>, allocators: &mut Vec<OpId>) {
        let mut q = Quiet;
        let mut rw = Rewriter::new(b, &mut q);
        let block = rw.body.value_block(slot.slot.ptr).expect("slot pointer is placed");
        rw.set_start(block);
        let subslots = d.destructure(self.cx, &mut rw, alloc, slot, &info.used, allocators);

        let mut users: Vec<OpId> = info.blocking.iter().map(|(op, _)| *op).collect();
        info.accessors.iter().for_each(|a| if !users.contains(a) { users.push(*a) });
        let users = rw.body.topological_sort(&users);

        let mut erase = Vec::new();
        for op in users.into_iter().rev() {
            rw.set_after(op);
            let deletion = match rw.body.destructurable(self.cx.dialects, op).filter(|d| d.is_accessor(rw.body, op)) {
                Some(acc) => acc.rewire(self.cx, &mut rw, op, slot, &subslots),
                None => {
                    let p = rw.body.promotable(self.promotable, op).expect("blocking user is promotable");
                    let blocking = &info.blocking.iter().find(|(o, _)| *o == op).expect("blocking user").1;
                    p.remove_blocking_uses(&mut rw, op, None, blocking, None)
                }
            };
            if deletion == Deletion::Delete {
                erase.push(op);
            }
        }
        erase.into_iter().for_each(|op| rw.erase_op(op));
        debug_assert!(rw.body[slot.slot.ptr].uses.is_empty(), "after destructuring, the original slot pointer should no longer be used");

        allocators.extend(d.handle_destructuring_complete(&mut rw, alloc, slot));
    }

    /// `tryToDestructureMemorySlots`: whether anything was destructured.
    fn run(&self, b: &mut Body<'_>, allocators: Vec<OpId>) -> bool {
        let mut any = false;
        let mut work = allocators;
        loop {
            let mut next = Vec::with_capacity(work.len());
            let mut changed = false;
            for alloc in work {
                let d = b.destructurable(self.cx.dialects, alloc).expect("allocator has interfaces");
                let slots = d.destructurable_slots(self.cx, b, alloc).unwrap_or_default();
                // Destructuring a slot may invalidate the allocator's other slots.
                match slots.iter().find_map(|slot| Some((slot, self.info(b, slot)?))) {
                    Some((slot, info)) => {
                        self.destructure(b, alloc, d, slot, &info, &mut next);
                        changed = true;
                    }
                    None => next.push(alloc),
                }
            }
            if !changed {
                return any;
            }
            any = true;
            work = next;
        }
    }
}

#[pass("sroa", ty = Sroa)]
pub fn sroa<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let dialects: &[&dyn Destructurable] = &[#[cfg(feature = "llvm")] &crate::LlvmSlots, &MemrefSlots, &TestSlots];
    let promotable: &[&dyn Promotable] = &[#[cfg(feature = "llvm")] &crate::LlvmSlots, &MemrefSlots, &TestSlots];
    let layout = DataLayout::closest(body, op);
    let sroa = Destructurer { cx: Slots { dialects, layout: &layout }, promotable };
    for region in body[op].regions.clone() {
        if body[region].blocks.is_empty() {
            continue;
        }
        // `region.walk`: post-order.
        let mut allocators = Vec::new();
        for blk in body[region].blocks.clone() {
            for o in body[blk].ops.clone() {
                body.walk_post(o, &mut |x| {
                    if body.destructurable(&dialects, x).is_some_and(|d| d.destructurable_slots(sroa.cx, body, x).is_some()) {
                        allocators.push(x);
                    }
                });
            }
        }
        sroa.run(body, allocators);
    }
    Ok(())
}
