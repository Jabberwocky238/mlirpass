//! `mem2reg`, as `Mem2Reg.cpp`: memory slots whose every use can be removed become SSA values.
//!
//! ```text
//! analysis   blocking uses (the forward slice of the slot pointer, each user asked whether it can
//!            drop them) ⇒ merge points (the iterated dominance frontier of the stores, pruned to
//!            the blocks where the slot is live-in) ⇒ their predecessors must be branches
//! mutation   reaching definitions down the dominator tree (merge points get a block argument)
//!            ⇒ blocking uses removed in reverse dominance order ⇒ dead branches forward the default
//! ```
//!
//! The dialects' promotion interfaces are [`Promotable`] implementations: `llvm` here
//! (`llvm/memslot.rs`), `memref` in `memref_slots.rs`.

use alloc::collections::{BTreeMap, BTreeSet};
use alloc::vec;
use alloc::vec::Vec;

use mlirpass_macros::pass;
use mlirformat::Error;

use super::memref_slots::TestSlots;
use super::memslot::{Deletion, LlvmSlots, MemorySlot, MemrefSlots, Promotable};
use crate::{BlockId, Body, DomTree, OpId, Quiet, RegionId, Rewriter, Use, ValueId};


/// `region-simplify` is accepted and, as in `Mem2Reg.cpp`, unused.
#[pass("mem2reg", ty = Mem2Reg, extra = ["region-simplify"])]
pub fn mem2reg<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let dialects: [&dyn Promotable; 3] = [&LlvmSlots, &MemrefSlots, &TestSlots];
    let promotion = Promotion { dialects: &dialects };
    for r in body[op].regions.clone() {
        if body[r].blocks.is_empty() {
            continue;
        }
        let allocators = promotion.allocators(body, r);
        promotion.promote_all(body, allocators);
    }
    Ok(())
}

/// `MemorySlotPromotionInfo`, and the promoter's state once promotion starts.
#[derive(Default)]
struct Info {
    /// Blocks where two definitions of the slot meet.
    merge_points: BTreeSet<BlockId>,
    /// Each user that must drop uses, in the order they were found, with those uses.
    blocking: Vec<(OpId, Vec<Use>)>,
    /// The slot pointer's region.
    region: Option<RegionId>,
    /// The slot's value before any store.
    default: Option<ValueId>,
    /// The slot's value just before each blocking memory op.
    reaching: BTreeMap<OpId, ValueId>,
    /// The value each storing op stores.
    replaced: BTreeMap<OpId, ValueId>,
}

impl Info {
    fn uses_of(&mut self, op: OpId) -> &mut Vec<Use> {
        let i = match self.blocking.iter().position(|(o, _)| *o == op) {
            Some(i) => i,
            None => {
                self.blocking.push((op, Vec::new()));
                self.blocking.len() - 1
            }
        };
        &mut self.blocking[i].1
    }

    fn get(&self, op: OpId) -> &[Use] {
        self.blocking.iter().find(|(o, _)| *o == op).map_or(&[], |(_, u)| u)
    }
}

/// `tryToPromoteMemorySlots` over the dialects the pass knows.
struct Promotion<'d> {
    dialects: &'d [&'d dyn Promotable],
}

impl<'d> Promotion<'d> {
    fn at(&self, b: &Body<'_>, op: OpId) -> Option<&'d dyn Promotable> {
        b.promotable(self.dialects, op)
    }

    /// The `PromotableAllocationOpInterface` ops in `region`, as `region.walk` visits them:
    /// post-order, an op's regions before the op.
    fn allocators(&self, b: &Body<'_>, region: RegionId) -> Vec<OpId> {
        let mut out = Vec::new();
        for block in &b[region].blocks {
            for op in &b[*block].ops {
                for r in &b[*op].regions {
                    out.extend(self.allocators(b, *r));
                }
                if self.at(b, *op).is_some_and(|d| d.promotable_slots(b, *op).is_some()) {
                    out.push(*op);
                }
            }
        }
        out
    }

    fn is_mem_op(&self, b: &Body<'_>, op: OpId) -> bool {
        self.at(b, op).is_some_and(|d| d.is_mem_op(b, op))
    }

    /// `tryToPromoteMemorySlots`: whether any slot was promoted.
    fn promote_all(&self, body: &mut Body<'_>, mut work: Vec<OpId>) -> bool {
        let mut any = false;
        loop {
            let mut next = Vec::new();
            let mut round = false;
            for alloc in work {
                let mut changed = false;
                let slots = self.at(body, alloc).and_then(|d| d.promotable_slots(body, alloc)).unwrap_or_default();
                for slot in slots {
                    if body[slot.ptr].uses.is_empty() {
                        continue;
                    }
                    let Some(info) = self.analyze(body, &slot) else { continue };
                    if let Some(new) = self.promote(body, alloc, &slot, info) {
                        next.push(new);
                    }
                    changed = true;
                    // Promoting a slot may invalidate the allocator's other slots.
                    break;
                }
                if !changed {
                    next.push(alloc);
                }
                round |= changed;
            }
            if !round {
                return any;
            }
            any = true;
            work = next;
        }
    }

    // ---- analysis ---------------------------------------------------------------------------

    /// `MemorySlotPromotionAnalyzer::computeInfo`.
    fn analyze<'a>(&self, b: &Body<'a>, slot: &MemorySlot<'a>) -> Option<Info> {
        let region = b.value_region(slot.ptr)?;
        let mut info = Info { region: Some(region), ..Info::default() };
        self.blocking_uses(b, slot, &mut info)?;
        info.merge_points = self.merge_points(b, slot, region);
        // Every predecessor of a merge point must be able to forward a value.
        let usable = info.merge_points.iter().all(|m| b.predecessors(*m).iter().all(|(t, _)| b.is_branch(*t)));
        usable.then_some(info)
    }

    /// `computeBlockingUses`.
    fn blocking_uses<'a>(&self, b: &Body<'a>, slot: &MemorySlot<'a>, info: &mut Info) -> Option<()> {
        let region = b.value_region(slot.ptr)?;
        if !b.has_ssa_dominance(region) {
            return None;
        }
        // MLIR's use lists are most-recent-first.
        for u in b[slot.ptr].uses.iter().rev() {
            info.uses_of(u.op).push(*u);
        }
        for user in b.forward_slice(slot.ptr) {
            let Some(uses) = info.blocking.iter().find(|(o, _)| *o == user).map(|(_, u)| u.clone()) else { continue };
            let mut sorted = uses;
            sorted.sort_by_key(|u| u.index);
            let d = self.at(b, user)?;
            let mut new = Vec::new();
            let mem = d.is_mem_op(b, user);
            if !d.can_uses_be_removed(b, user, mem.then_some(slot), &sorted, &mut new)? {
                return None;
            }
            for u in new {
                info.uses_of(u.op).push(u);
            }
        }
        // Only the slot pointer's own region is analysed.
        let outside = info.blocking.iter().any(|(o, _)| self.is_mem_op(b, *o) && b[*o].parent.and_then(|k| b[k].parent) != Some(region));
        (!outside).then_some(())
    }

    /// `computeSlotLiveIn`: blocks entered with the slot's value still to be read.
    fn live_in<'a>(&self, b: &Body<'a>, slot: &MemorySlot<'a>, defining: &BTreeSet<BlockId>) -> BTreeSet<BlockId> {
        let mut work = Vec::new();
        let mut seen = BTreeSet::new();
        for u in b[slot.ptr].uses.iter().rev() {
            let Some(block) = b[u.op].parent else { continue };
            if !seen.insert(block) {
                continue;
            }
            for op in &b[block].ops {
                let Some(d) = self.at(b, *op).filter(|d| d.is_mem_op(b, *op)) else { continue };
                if d.loads_from(b, *op, slot) {
                    work.push(block);
                    break;
                }
                if d.stores_to(b, *op, slot) {
                    break;
                }
            }
        }
        let mut live = BTreeSet::new();
        while let Some(block) = work.pop() {
            if !live.insert(block) {
                continue;
            }
            for (t, _) in b.predecessors(block) {
                if let Some(p) = b[t].parent.filter(|p| !defining.contains(p)) {
                    work.push(p);
                }
            }
        }
        live
    }

    /// `computeMergePoints`: the iterated dominance frontier of the stores, pruned to live-in
    /// blocks.
    fn merge_points<'a>(&self, b: &Body<'a>, slot: &MemorySlot<'a>, region: RegionId) -> BTreeSet<BlockId> {
        if b[region].blocks.len() == 1 {
            return BTreeSet::new();
        }
        let defining: BTreeSet<BlockId> = b[slot.ptr].uses.iter().filter(|u| self.at(b, u.op).is_some_and(|d| d.is_mem_op(b, u.op) && d.stores_to(b, u.op, slot))).filter_map(|u| b[u.op].parent).collect();
        let live = self.live_in(b, slot, &defining);
        let tree = b.dom_tree(region);
        let frontier = b.dominance_frontiers(region, &tree);
        let mut merge = BTreeSet::new();
        let mut work: Vec<BlockId> = defining.iter().copied().collect();
        let mut queued: BTreeSet<BlockId> = defining.clone();
        while let Some(x) = work.pop() {
            for y in frontier.get(&x).into_iter().flatten() {
                if !live.contains(y) || !merge.insert(*y) {
                    continue;
                }
                if queued.insert(*y) {
                    work.push(*y);
                }
            }
        }
        merge
    }

    // ---- mutation ---------------------------------------------------------------------------

    /// `MemorySlotPromoter::promoteSlot`; the new allocator, if any.
    fn promote<'a>(&self, body: &mut Body<'a>, alloc: OpId, slot: &MemorySlot<'a>, mut info: Info) -> Option<OpId> {
        let d = self.at(body, alloc).expect("an allocator's dialect");
        let mut quiet = Quiet;
        let mut rw = Rewriter::new(body, &mut quiet);
        // `getOrCreateDefaultValue`, at the start of the slot pointer's block.
        rw.set_start(rw.body.value_block(slot.ptr).expect("a placed slot"));
        let default = d.default_value(&mut rw, alloc, slot);
        info.default = Some(default);
        self.reaching_defs(&mut rw, d, alloc, slot, &mut info);
        self.remove_blocking_uses(&mut rw, slot, &info);
        // Branches of dead predecessors forward the default.
        for m in &info.merge_points {
            let n = rw.body[*m].args.len();
            for (t, i) in rw.body.predecessors(*m) {
                if rw.body.successor_operands(t, i).is_some_and(|r| r.len() + 1 == n) {
                    rw.body.append_successor_operands(t, i, &[default]);
                }
            }
        }
        d.handle_promotion_complete(&mut rw, alloc, slot, Some(default))
    }

    /// `computeReachingDefInRegion`: down the dominator tree, depth first.
    fn reaching_defs<'a>(&self, rw: &mut Rewriter<'_, 'a>, d: &dyn Promotable, alloc: OpId, slot: &MemorySlot<'a>, info: &mut Info) {
        let (region, default) = (info.region.expect("analysed"), info.default.expect("created"));
        let entry = rw.body[region].blocks[0];
        if rw.body[region].blocks.len() == 1 {
            self.reaching_in_block(rw, slot, info, entry, default);
            return;
        }
        let tree = rw.body.dom_tree(region);
        let mut stack = vec![(entry, default)];
        while let Some((block, mut def)) = stack.pop() {
            if info.merge_points.contains(&block) {
                let arg = rw.body.add_arg(block, slot.elem.clone());
                rw.body[arg].loc = rw.body[slot.ptr].loc.clone();
                rw.set_start(block);
                d.handle_block_argument(rw, alloc, slot, arg);
                def = arg;
            }
            def = self.reaching_in_block(rw, slot, info, block, def);
            if let Some(&t) = rw.body[block].ops.last()
                && rw.body.is_branch(t)
            {
                for (i, s) in rw.body[t].successors.clone().into_iter().enumerate() {
                    if info.merge_points.contains(&s) {
                        rw.body.append_successor_operands(t, i, &[def]);
                    }
                }
            }
            stack.extend(tree.children(block).iter().map(|c| (*c, def)));
        }
    }

    /// `computeReachingDefInBlock`: the definition reaching the end of `block`.
    fn reaching_in_block<'a>(&self, rw: &mut Rewriter<'_, 'a>, slot: &MemorySlot<'a>, info: &mut Info, block: BlockId, mut def: ValueId) -> ValueId {
        for op in rw.body[block].ops.clone() {
            let Some(d) = self.at(rw.body, op).filter(|d| d.is_mem_op(rw.body, op)) else { continue };
            if info.blocking.iter().any(|(o, _)| *o == op) {
                info.reaching.entry(op).or_insert(def);
            }
            if d.stores_to(rw.body, op, slot) {
                rw.set_after(op);
                def = d.stored(rw, op, slot, def);
                info.replaced.insert(op, def);
            }
        }
        def
    }

    /// `removeBlockingUses`: users in reverse dominance order, then the scheduled erasures.
    fn remove_blocking_uses<'a>(&self, rw: &mut Rewriter<'_, 'a>, slot: &MemorySlot<'a>, info: &Info) {
        let order = rw.body.blocks_by_dominance(info.region.expect("analysed"));
        let mut users: Vec<OpId> = info.blocking.iter().map(|(o, _)| *o).collect();
        users.sort_by_key(|o| {
            let block = rw.body[*o].parent.expect("a placed user");
            (order.iter().position(|b| *b == block).unwrap_or(usize::MAX), rw.body.position(*o))
        });
        let mut erase = Vec::new();
        let mut replaced_list = Vec::new();
        let mut visit = Vec::new();
        for op in users.into_iter().rev() {
            let d = self.at(rw.body, op).expect("a promotable user");
            let mut uses = info.get(op).to_vec();
            uses.sort_by_key(|u| u.index);
            rw.set_after(op);
            if d.is_mem_op(rw.body, op) {
                let def = info.reaching.get(&op).copied().or(info.default).expect("created");
                if d.remove_blocking_uses(rw, op, Some(slot), &uses, Some(def)) == Deletion::Delete {
                    erase.push(op);
                }
                if d.stores_to(rw.body, op, slot)
                    && let Some(v) = info.replaced.get(&op)
                {
                    replaced_list.push((op, *v));
                }
                continue;
            }
            if d.remove_blocking_uses(rw, op, None, &uses, None) == Deletion::Delete {
                erase.push(op);
            }
            if d.requires_replaced_values(rw.body, op) {
                visit.push((d, op));
            }
        }
        for (d, op) in visit {
            rw.set_after(op);
            d.visit_replaced_values(rw, op, &replaced_list);
        }
        for op in erase {
            rw.body.drop_result_uses(op);
            rw.body.erase(op);
        }
    }
}

impl Body<'_> {
    /// The region defining `v`.
    fn value_region(&self, v: ValueId) -> Option<RegionId> {
        self.value_block(v).and_then(|b| self[b].parent)
    }

    /// Dominance frontiers of `region`'s reachable blocks (Cooper, Harvey & Kennedy).
    fn dominance_frontiers(&self, region: RegionId, tree: &DomTree) -> BTreeMap<BlockId, BTreeSet<BlockId>> {
        let mut df: BTreeMap<BlockId, BTreeSet<BlockId>> = BTreeMap::new();
        for b in self[region].blocks.iter().filter(|b| tree.reachable(**b)) {
            let preds: Vec<BlockId> = self.predecessors(*b).iter().filter_map(|(t, _)| self[*t].parent).filter(|p| tree.reachable(*p)).collect();
            if preds.len() < 2 {
                continue;
            }
            let idom = tree.idom(*b);
            for p in preds {
                let mut runner = Some(p);
                while let Some(r) = runner.filter(|r| Some(*r) != idom) {
                    df.entry(r).or_default().insert(*b);
                    runner = tree.idom(r);
                }
            }
        }
        df
    }

}

