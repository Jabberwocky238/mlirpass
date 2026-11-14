use alloc::collections::{BTreeMap, BTreeSet};
use alloc::vec;
use alloc::vec::Vec;

use crate::pass;
use mlirformat::Error;

use super::memslot::{Deletion, MemorySlot, Promotable};
use crate::{BlockId, Body, DomTree, OpId, Quiet, RegionId, Rewriter, Use, ValueId};

#[pass("mem2reg", ty = Mem2Reg, extra = ["region-simplify"])]
pub fn mem2reg<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let dialects: &[&dyn Promotable] = &[#[cfg(feature = "dialect.llvm")] &crate::LlvmSlots, #[cfg(feature = "dialect.memref")] &crate::MemrefSlots, #[cfg(feature = "dialect.scf")] &crate::ScfSlots, #[cfg(all(feature = "dialect.memref", feature = "dialect.test"))] &crate::TestSlots];
    let promotion = Promotion { dialects };
    for r in body[op].regions.clone() {
        if body[r].blocks.is_empty() {
            continue;
        }
        let allocators = promotion.allocators(body, r);
        promotion.promote_all(body, allocators);
    }
    Ok(())
}

#[derive(Clone)]
struct Alias<'a> {
    slot: MemorySlot<'a>,
    op: OpId,
    operand: usize,
}

#[derive(Default)]
struct Info<'a> {
    merge_points: BTreeSet<BlockId>,
    blocking: Vec<(RegionId, Vec<(OpId, Vec<Use>)>)>,
    regions: BTreeMap<RegionId, bool>,
    aliases: Vec<(ValueId, Alias<'a>)>,
    visit_replaced: bool,
}

impl<'a> Info<'a> {
    fn users_in(&mut self, region: RegionId) -> &mut Vec<(OpId, Vec<Use>)> {
        let i = match self.blocking.iter().position(|(r, _)| *r == region) {
            Some(i) => i,
            None => {
                self.blocking.push((region, Vec::new()));
                self.blocking.len() - 1
            }
        };
        &mut self.blocking[i].1
    }

    fn uses_of(&mut self, region: RegionId, op: OpId) -> &mut Vec<Use> {
        let users = self.users_in(region);
        let i = match users.iter().position(|(o, _)| *o == op) {
            Some(i) => i,
            None => {
                users.push((op, Vec::new()));
                users.len() - 1
            }
        };
        &mut users[i].1
    }

    fn blocking_of(&self, region: RegionId, op: OpId) -> Option<&Vec<Use>> {
        self.blocking.iter().find(|(r, _)| *r == region)?.1.iter().find(|(o, _)| *o == op).map(|(_, u)| u)
    }

    fn alias(&self, ptr: ValueId) -> Option<&Alias<'a>> {
        self.aliases.iter().find(|(p, _)| *p == ptr).map(|(_, a)| a)
    }

    fn parent_slot(&self, root: &MemorySlot<'a>, ptr: ValueId) -> Option<MemorySlot<'a>> {
        if ptr == root.ptr {
            return Some(root.clone());
        }
        self.alias(ptr).map(|a| a.slot.clone())
    }

    fn op_slot(&self, b: &Body<'a>, root: &MemorySlot<'a>, op: OpId) -> MemorySlot<'a> {
        b[op].operands.iter().find_map(|v| self.parent_slot(root, *v)).unwrap_or_else(|| root.clone())
    }

    fn one_alias(&self, b: &Body<'a>, root: &MemorySlot<'a>, op: OpId) -> bool {
        let mut seen: Option<ValueId> = None;
        for v in &b[op].operands {
            let Some(s) = self.parent_slot(root, *v) else { continue };
            if seen.is_some_and(|p| p != s.ptr) {
                return false;
            }
            seen = Some(s.ptr);
        }
        true
    }

    fn chain(&self, b: &Body<'a>, root: &MemorySlot<'a>, alias: &MemorySlot<'a>) -> Vec<(OpId, MemorySlot<'a>, MemorySlot<'a>)> {
        let mut out = Vec::new();
        let mut at = alias.ptr;
        while at != root.ptr {
            let Some(a) = self.alias(at) else { break };
            let through = b[a.op].operands[a.operand];
            let Some(parent) = self.parent_slot(root, through) else { break };
            out.push((a.op, parent, a.slot.clone()));
            at = through;
        }
        out
    }
}

struct Promotion<'d> {
    dialects: &'d [&'d dyn Promotable],
}

impl<'d> Promotion<'d> {
    fn at(&self, b: &Body<'_>, op: OpId) -> Option<&'d dyn Promotable> {
        b.promotable(self.dialects, op)
    }

    fn allocators(&self, b: &Body<'_>, region: RegionId) -> Vec<OpId> {
        let mut out = Vec::new();
        for block in &b[region].blocks {
            for op in &b.block_ops(*block) {
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

    fn mem_op(&self, b: &Body<'_>, op: OpId) -> Option<&'d dyn Promotable> {
        self.at(b, op).filter(|d| d.is_mem_op(b, op))
    }

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
                    let d = self.at(body, alloc).expect("an allocator's dialect");
                    let mut quiet = Quiet;
                    let rw = Rewriter::new(body, &mut quiet);
                    let promoter = Promoter { p: self, d, alloc, slot: &slot, info, default: None, reaching: BTreeMap::new(), replaced: Vec::new(), at_end: BTreeMap::new(), post_order: Vec::new(), erase: Vec::new(), rw };
                    if let Some(new) = promoter.promote() {
                        next.push(new);
                    }
                    changed = true;
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

    fn analyze<'a>(&self, b: &Body<'a>, slot: &MemorySlot<'a>) -> Option<Info<'a>> {
        let mut info = Info::default();
        self.blocking_uses(b, slot, &mut info)?;
        let mut defining: Vec<(RegionId, BTreeSet<BlockId>)> = Vec::new();
        let mut add = |r: RegionId, blk: BlockId| match defining.iter_mut().find(|(x, _)| *x == r) {
            Some((_, s)) => {
                s.insert(blk);
            }
            None => defining.push((r, BTreeSet::from([blk]))),
        };
        let ptrs: Vec<(ValueId, MemorySlot<'a>)> = core::iter::once((slot.ptr, slot.clone())).chain(info.aliases.iter().map(|(p, a)| (*p, a.slot.clone()))).collect();
        for (ptr, s) in &ptrs {
            for u in b.use_list(*ptr) {
                if self.mem_op(b, u.op).is_some_and(|d| d.stores_to(b, u.op, s))
                    && let Some(blk) = b[u.op].parent
                    && let Some(r) = b[blk].parent
                {
                    add(r, blk);
                }
            }
        }
        for (region, stores) in &info.regions {
            if *stores
                && let op = b[*region].parent
                && let Some(blk) = b[op].parent
                && let Some(r) = b[blk].parent
            {
                add(r, blk);
            }
        }
        for (region, blocks) in &defining {
            info.merge_points.extend(self.merge_points(b, *region, blocks));
        }
        let usable = info.merge_points.iter().all(|m| b.predecessors(*m).iter().all(|(t, _)| b.is_branch(*t)));
        usable.then_some(info)
    }

    fn blocking_uses<'a>(&self, b: &Body<'a>, slot: &MemorySlot<'a>, info: &mut Info<'a>) -> Option<()> {
        let home = b.value_region(slot.ptr)?;
        if !b.has_ssa_dominance(home) {
            return None;
        }
        for u in b.use_list(slot.ptr) {
            let r = b.op_region(u.op)?;
            info.uses_of(r, u.op).push(u);
        }
        let (mut with_use, mut with_store) = (Vec::new(), Vec::new());
        for user in b.forward_slice(slot.ptr) {
            let Some(region) = b.op_region(user) else { continue };
            let Some(mut uses) = info.blocking_of(region, user).cloned() else { continue };
            uses.sort_by_key(|u| u.index);
            let d = self.at(b, user)?;
            for i in 0..b[user].operands.len() {
                let Some(parent) = info.parent_slot(slot, b[user].operands[i]) else { continue };
                for alias in d.slot_aliases(b, user, i, &parent).unwrap_or_default() {
                    if info.alias(alias.ptr).is_none() {
                        info.aliases.push((alias.ptr, Alias { slot: alias, op: user, operand: i }));
                    }
                }
            }
            let mut new = Vec::new();
            if d.is_mem_op(b, user) {
                if !info.one_alias(b, slot, user) {
                    return None;
                }
                let s = info.op_slot(b, slot, user);
                if !d.can_uses_be_removed(b, user, Some(&s), &uses, &mut new)? {
                    return None;
                }
                let at = if d.stores_to(b, user, &s) { &mut with_store } else { &mut with_use };
                if !at.contains(&region) {
                    at.push(region);
                }
            } else {
                if !d.can_uses_be_removed(b, user, None, &uses, &mut new)? {
                    return None;
                }
                if !with_use.contains(&region) {
                    with_use.push(region);
                }
                info.visit_replaced |= d.requires_replaced_values(b, user);
            }
            for u in new {
                let r = b.op_region(u.op)?;
                info.uses_of(r, u.op).push(u);
            }
        }
        for (from, stores) in [(with_store, true), (with_use, false)] {
            let mut work = from;
            while let Some(region) = work.pop() {
                if region == home || info.regions.contains_key(&region) {
                    continue;
                }
                info.regions.insert(region, stores);
                let op = b[region].parent;
                let d = self.at(b, op).filter(|d| d.is_region_op(b, op))?;
                if !d.region_promotable(b, op, slot, region, stores)? {
                    return None;
                }
                work.push(b.op_region(op)?);
            }
        }
        Some(())
    }

    fn merge_points(&self, b: &Body<'_>, region: RegionId, defining: &BTreeSet<BlockId>) -> BTreeSet<BlockId> {
        if b[region].blocks.len() == 1 {
            return BTreeSet::new();
        }
        let tree = b.dom_tree(region);
        let frontier = b.dominance_frontiers(region, &tree);
        let mut merge = BTreeSet::new();
        let mut work: Vec<BlockId> = defining.iter().copied().collect();
        let mut queued: BTreeSet<BlockId> = defining.clone();
        while let Some(x) = work.pop() {
            for y in frontier.get(&x).into_iter().flatten() {
                if !merge.insert(*y) {
                    continue;
                }
                if queued.insert(*y) {
                    work.push(*y);
                }
            }
        }
        merge
    }
}

struct Promoter<'p, 'd, 's, 'r, 'a> {
    p: &'p Promotion<'d>,
    d: &'d dyn Promotable,
    alloc: OpId,
    slot: &'s MemorySlot<'a>,
    info: Info<'a>,
    default: Option<ValueId>,
    reaching: BTreeMap<OpId, Option<ValueId>>,
    replaced: Vec<(OpId, ValueId)>,
    at_end: BTreeMap<BlockId, Option<ValueId>>,
    post_order: Vec<RegionId>,
    erase: Vec<OpId>,
    rw: Rewriter<'r, 'a>,
}

impl<'a> Promoter<'_, '_, '_, '_, 'a> {
    fn promote(mut self) -> Option<OpId> {
        let home = self.rw.body.value_region(self.slot.ptr).expect("a placed slot");
        self.promote_region(home, None);
        if self.info.visit_replaced {
            for region in self.post_order.clone() {
                self.visit_replaced(region);
            }
        }
        for region in self.post_order.clone() {
            self.remove_blocking_uses(region);
        }
        self.remove_unused();
        let default = self.default;
        self.d.handle_promotion_complete(&mut self.rw, self.alloc, self.slot, default)
    }

    fn default(&mut self) -> ValueId {
        if let Some(d) = self.default {
            return d;
        }
        let ip = self.rw.ip;
        let home = self.rw.body.value_region(self.slot.ptr).expect("a placed slot");
        let entry = self.rw.body[home].blocks[0];
        self.rw.set_start(entry);
        let d = self.d.default_value(&mut self.rw, self.alloc, self.slot);
        self.rw.ip = ip;
        self.default = Some(d);
        d
    }

    fn to_alias(&mut self, value: ValueId, alias: &MemorySlot<'a>) -> ValueId {
        let chain = self.info.chain(self.rw.body, self.slot, alias);
        let mut v = value;
        for (op, parent, a) in chain.iter().rev() {
            let d = self.p.at(self.rw.body, *op).expect("an aliaser");
            v = d.project_to_alias(&mut self.rw, *op, parent, a, v);
        }
        v
    }

    fn to_slot(&mut self, value: ValueId, alias: &MemorySlot<'a>, reaching: ValueId) -> ValueId {
        let chain = self.info.chain(self.rw.body, self.slot, alias);
        let mut per_step = alloc::vec![reaching; chain.len()];
        let mut cur = reaching;
        for (i, (op, parent, a)) in chain.iter().enumerate().rev() {
            per_step[i] = cur;
            let d = self.p.at(self.rw.body, *op).expect("an aliaser");
            cur = d.project_to_alias(&mut self.rw, *op, parent, a, cur);
        }
        let mut v = value;
        for ((op, parent, a), r) in chain.iter().zip(per_step) {
            let d = self.p.at(self.rw.body, *op).expect("an aliaser");
            v = d.project_to_slot(&mut self.rw, *op, parent, a, v, r);
        }
        v
    }

    fn promote_block(&mut self, block: BlockId, mut def: Option<ValueId>) -> Option<ValueId> {
        for op in self.rw.body.block_ops(block) {
            if let Some(d) = self.p.mem_op(self.rw.body, op) {
                let region = self.rw.body.op_region(op);
                if region.is_some_and(|r| self.info.blocking_of(r, op).is_some()) {
                    self.reaching.entry(op).or_insert(def);
                }
                let s = self.info.op_slot(self.rw.body, self.slot, op);
                if d.stores_to(self.rw.body, op, &s) {
                    self.rw.set_before(op);
                    let root = match def {
                        Some(v) => v,
                        None => self.default(),
                    };
                    self.rw.set_before(op);
                    let at_store = if s.ptr != self.slot.ptr { self.to_alias(root, &s) } else { root };
                    let mut stored = d.stored(&mut self.rw, op, &s, at_store);
                    match self.replaced.iter_mut().find(|(o, _)| *o == op) {
                        Some(e) => e.1 = stored,
                        None => self.replaced.push((op, stored)),
                    }
                    if s.ptr != self.slot.ptr {
                        stored = self.to_slot(stored, &s, root);
                    }
                    def = Some(stored);
                }
            }
            if let Some(d) = self.p.at(self.rw.body, op).filter(|d| d.is_region_op(self.rw.body, op)) {
                let regions = self.rw.body[op].regions.to_vec();
                let wanted: Vec<bool> = regions.iter().filter_map(|r| self.info.regions.get(r).copied()).collect();
                if wanted.is_empty() {
                    continue;
                }
                let stores = wanted.contains(&true);
                let root = match def {
                    Some(v) => v,
                    None => self.default(),
                };
                let process = d.setup_promotion(&mut self.rw, op, self.slot, root, stores);
                for (r, entry) in process {
                    if self.info.regions.contains_key(&r) {
                        self.promote_region(r, Some(entry));
                    }
                }
                self.rw.set_after(op);
                let at_end = core::mem::take(&mut self.at_end);
                def = Some(d.finalize_promotion(&mut self.rw, op, self.slot, root, stores, &at_end));
                self.at_end = at_end;
            }
        }
        self.at_end.insert(block, def);
        def
    }

    fn promote_region(&mut self, region: RegionId, def: Option<ValueId>) {
        let entry = self.rw.body[region].blocks[0];
        if self.rw.body[region].blocks.len() == 1 {
            self.promote_block(entry, def);
            self.post_order.push(region);
            return;
        }
        let tree = self.rw.body.dom_tree(region);
        let mut stack = vec![(entry, def)];
        while let Some((block, mut def)) = stack.pop() {
            if self.info.merge_points.contains(&block) {
                let arg = self.rw.body.add_arg(block, self.slot.elem.clone());
                self.rw.body[arg].loc = self.rw.body[self.slot.ptr].loc.clone();
                def = Some(arg);
            }
            def = self.promote_block(block, def);
            if let Some(t) = self.rw.body.last_op(block)
                && self.rw.body.is_branch(t)
            {
                for (i, s) in self.rw.body[t].successors.clone().into_iter().enumerate() {
                    if self.info.merge_points.contains(&s) {
                        let v = match def {
                            Some(v) => v,
                            None => self.default(),
                        };
                        def = Some(v);
                        self.rw.body.append_successor_operands(t, i, &[v]);
                    }
                }
            }
            stack.extend(tree.children(block).iter().map(|c| (*c, def)));
        }
        self.post_order.push(region);
    }

    fn visit_replaced(&mut self, region: RegionId) {
        let Some((_, users)) = self.info.blocking.iter().find(|(r, _)| *r == region) else { return };
        for (op, _) in users.clone() {
            let Some(d) = self.p.at(self.rw.body, op) else { continue };
            if d.is_mem_op(self.rw.body, op) || !d.requires_replaced_values(self.rw.body, op) {
                continue;
            }
            self.rw.set_after(op);
            let replaced = self.replaced.clone();
            d.visit_replaced_values(&mut self.rw, op, &replaced);
        }
    }

    fn remove_blocking_uses(&mut self, region: RegionId) {
        let Some((_, users)) = self.info.blocking.iter().find(|(r, _)| *r == region) else { return };
        let Some(&(first, _)) = users.first() else { return };
        let users = users.clone();
        let Some(now) = self.rw.body.op_region(first) else { return };
        let order = self.rw.body.blocks_by_dominance(now);
        let mut ops: Vec<OpId> = users.iter().map(|(o, _)| *o).collect();
        let b = &*self.rw.body;
        let rank = |o: &OpId| order.iter().position(|x| Some(*x) == b[*o].parent).unwrap_or(usize::MAX);
        ops.sort_by(|x, y| rank(x).cmp(&rank(y)).then_with(|| if x == y { core::cmp::Ordering::Equal } else if b.is_before(*x, *y) { core::cmp::Ordering::Less } else { core::cmp::Ordering::Greater }));
        for op in ops.into_iter().rev() {
            let d = self.p.at(self.rw.body, op).expect("a promotable user");
            let mut uses = users.iter().find(|(o, _)| *o == op).map(|(_, u)| u.clone()).unwrap_or_default();
            uses.sort_by_key(|u| u.index);
            let kind = if d.is_mem_op(self.rw.body, op) {
                let root = match self.reaching.get(&op).copied().flatten() {
                    Some(v) => v,
                    None => self.default(),
                };
                self.rw.set_after(op);
                let s = self.info.op_slot(self.rw.body, self.slot, op);
                let at_use = if s.ptr != self.slot.ptr { self.to_alias(root, &s) } else { root };
                d.remove_blocking_uses(&mut self.rw, op, Some(&s), &uses, Some(at_use))
            } else {
                self.rw.set_after(op);
                d.remove_blocking_uses(&mut self.rw, op, None, &uses, None)
            };
            if kind == Deletion::Delete && !self.erase.contains(&op) {
                self.erase.push(op);
            }
        }
    }

    fn remove_unused(&mut self) {
        let merge: Vec<BlockId> = self.info.merge_points.iter().copied().collect();
        let last_arg = |b: &Body<'_>, m: BlockId| *b[m].args.last().expect("a merge point argument");
        let mut unused: BTreeSet<ValueId> = BTreeSet::new();
        let mut used: Vec<ValueId> = Vec::new();
        for m in &merge {
            let arg = last_arg(self.rw.body, *m);
            if self.definitely_used(arg) {
                used.push(arg);
            } else {
                unused.insert(arg);
            }
        }
        while let Some(arg) = used.pop() {
            let m = self.rw.body.value_block(arg).expect("a block argument");
            let n = self.rw.body[m].args.len();
            for (t, i) in self.rw.body.predecessors(m) {
                let mut range = self.rw.body.successor_operands(t, i).expect("a branch");
                if range.len() + 1 == n {
                    let d = self.default();
                    self.rw.body.append_successor_operands(t, i, &[d]);
                    range = self.rw.body.successor_operands(t, i).expect("a branch");
                }
                let v = self.rw.body[t].operands[range.start + n - 1];
                if unused.remove(&v) {
                    used.push(v);
                }
            }
            self.rw.set_start(m);
            self.d.handle_block_argument(&mut self.rw, self.alloc, self.slot, arg);
        }
        for op in core::mem::take(&mut self.erase) {
            self.rw.body.drop_result_uses(op);
            self.rw.body.erase(op);
        }
        for arg in &unused {
            let m = self.rw.body.value_block(*arg).expect("a block argument");
            let n = self.rw.body[m].args.len();
            for (t, i) in self.rw.body.predecessors(m) {
                if self.rw.body.successor_operands(t, i).is_some_and(|r| r.len() == n) {
                    self.rw.body.erase_successor_operand(t, i, n - 1);
                }
            }
        }
        for arg in unused {
            let m = self.rw.body.value_block(arg).expect("a block argument");
            let n = self.rw.body[m].args.len();
            self.rw.body.erase_arg(m, n - 1);
        }
    }

    fn definitely_used(&self, arg: ValueId) -> bool {
        let b = &*self.rw.body;
        b.use_list(arg).iter().any(|u| {
            if self.erase.contains(&u.op) {
                return false;
            }
            let Some(succ) = b.successor_of_operand(u.op, u.index as usize) else { return true };
            let (block, at) = succ;
            !self.info.merge_points.contains(&block) || at + 1 != b[block].args.len()
        })
    }
}

impl Body<'_> {
    fn value_region(&self, v: ValueId) -> Option<RegionId> {
        self.value_block(v).and_then(|b| self[b].parent)
    }

    fn successor_of_operand(&self, op: OpId, index: usize) -> Option<(BlockId, usize)> {
        if !self.is_branch(op) {
            return None;
        }
        self[op].successors.iter().enumerate().find_map(|(i, s)| {
            let r = self.successor_operands(op, i)?;
            r.contains(&index).then(|| (*s, index - r.start))
        })
    }

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
