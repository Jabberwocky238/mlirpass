//! Region simplification, as `RegionUtils.cpp`: unreachable blocks, dead code (`runRegionDCE`),
//! and — aggressively — identical blocks merged.

use alloc::collections::BTreeSet;
use alloc::vec::Vec;

use crate::{Body, BlockId, OpId, RegionId, Trait, ValueId};

/// What is proven live.
#[derive(Default)]
struct LiveMap {
    ops: BTreeSet<OpId>,
    args: BTreeSet<ValueId>,
    changed: bool,
}

impl LiveMap {
    fn set_value(&mut self, body: &Body<'_>, v: ValueId) {
        match body.def_op(v) {
            Some(op) => self.changed |= self.ops.insert(op),
            None => self.changed |= self.args.insert(v),
        }
    }

    fn set_op(&mut self, op: OpId) {
        self.changed |= self.ops.insert(op);
    }
}

impl Body<'_> {
    /// The successor argument a branch operand feeds, if it feeds one.
    fn fed_argument(&self, op: OpId, index: usize) -> Option<ValueId> {
        (0..self[op].successors.len()).find_map(|i| {
            let range = self.successor_operands(op, i)?;
            range.contains(&index).then(|| self[self[op].successors[i]].args.get(index - range.start).copied()).flatten()
        })
    }

    fn process_value(&self, v: ValueId, live: &mut LiveMap) {
        let proved = self[v].uses.iter().any(|u| {
            // A use by a branch is dead when the argument it feeds is.
            if self.has(u.op, Trait::IsTerminator)
                && self.is_branch(u.op)
                && let Some(arg) = self.fed_argument(u.op, u.index as usize)
            {
                return live.args.contains(&arg) && live.ops.contains(&u.op);
            }
            live.ops.contains(&u.op)
        });
        if proved {
            live.set_value(self, v);
        }
    }

    fn propagate_terminator(&self, op: OpId, live: &mut LiveMap) {
        live.set_op(op);
        // Not a branch: every successor argument is live. A branch only produces none itself.
        if !self.is_branch(op) {
            for s in &self[op].successors {
                for a in &self[*s].args {
                    live.set_value(self, *a);
                }
            }
        }
    }

    fn propagate_op(&self, op: OpId, live: &mut LiveMap) {
        for r in &self[op].regions {
            self.propagate_region(*r, live);
        }
        if self.has(op, Trait::IsTerminator) {
            return self.propagate_terminator(op, live);
        }
        if live.ops.contains(&op) {
            return;
        }
        if !self.would_be_trivially_dead(op) {
            return live.set_op(op);
        }
        for r in &self[op].results {
            self.process_value(*r, live);
        }
    }

    fn propagate_region(&self, region: RegionId, live: &mut LiveMap) {
        let Some(&entry) = self[region].blocks.first() else { return };
        for b in self.post_order(entry) {
            for op in self[b].ops.iter().rev() {
                self.propagate_op(*op, live);
            }
            if b == entry {
                continue;
            }
            for a in &self[b].args {
                if !live.args.contains(a) {
                    self.process_value(*a, live);
                }
            }
        }
    }

    fn erase_dead_successor_operands(&mut self, terminator: OpId, live: &LiveMap) {
        if !self.is_branch(terminator) {
            return;
        }
        for i in (0..self[terminator].successors.len()).rev() {
            let Some(range) = self.successor_operands(terminator, i) else { continue };
            let succ = self[terminator].successors[i];
            for j in (0..range.len()).rev() {
                if !live.args.contains(&self[succ].args[j]) {
                    self.erase_successor_operand(terminator, i, j);
                }
            }
        }
    }

    fn delete_dead(&mut self, regions: &[RegionId], live: &LiveMap) -> bool {
        let mut erased = false;
        for r in regions {
            let Some(&entry) = self[*r].blocks.first() else { continue };
            let single = self[*r].blocks.len() == 1;
            for b in self.post_order(entry) {
                if !single && let Some(&t) = self[b].ops.last() {
                    self.erase_dead_successor_operands(t, live);
                }
                for op in self[b].ops.clone().into_iter().rev() {
                    if !live.ops.contains(&op) {
                        erased = true;
                        self.drop_result_uses(op);
                        self.erase(op);
                    } else {
                        let inner = self[op].regions.clone();
                        erased |= self.delete_dead(&inner, live);
                    }
                }
            }
            for b in self[*r].blocks.clone().into_iter().skip(1) {
                let dead: Vec<usize> = self[b].args.iter().enumerate().filter(|(_, a)| !live.args.contains(*a)).map(|(i, _)| i).collect();
                for i in dead.into_iter().rev() {
                    self.erase_arg(b, i);
                }
            }
        }
        erased
    }

    /// `runRegionDCE`; whether anything was erased.
    pub fn region_dce(&mut self, regions: &[RegionId]) -> bool {
        let mut live = LiveMap::default();
        loop {
            live.changed = false;
            for r in regions {
                self.propagate_region(*r, &mut live);
            }
            if !live.changed {
                break;
            }
        }
        self.delete_dead(regions, &live)
    }

    /// Erases argument `i` of `block`; its uses must be gone.
    pub fn erase_arg(&mut self, block: BlockId, i: usize) {
        self[block].args.remove(i);
        for (k, a) in self[block].args.clone().into_iter().enumerate().skip(i) {
            self[a].def = crate::Def::Arg(block, k as u32);
        }
    }

    /// `eraseUnreachableBlocks`; whether any block went.
    pub fn erase_unreachable_blocks(&mut self, regions: &[RegionId]) -> bool {
        let mut erased = false;
        let mut work: Vec<RegionId> = regions.to_vec();
        while let Some(r) = work.pop() {
            let Some(&entry) = self[r].blocks.first() else { continue };
            if self[r].blocks.len() == 1 {
                work.extend(self[entry].ops.iter().flat_map(|o| self[*o].regions.clone()));
                continue;
            }
            let reachable: BTreeSet<BlockId> = self.post_order(entry).into_iter().collect();
            for b in self[r].blocks.clone() {
                if !reachable.contains(&b) {
                    for o in self[b].ops.clone() {
                        self.drop_result_uses(o);
                    }
                    for a in self[b].args.clone() {
                        self.drop_value_uses(a);
                    }
                    for o in self[b].ops.clone().into_iter().rev() {
                        self.erase(o);
                    }
                    self.remove_block(b);
                    erased = true;
                    continue;
                }
                work.extend(self[b].ops.iter().flat_map(|o| self[*o].regions.clone()));
            }
        }
        erased
    }

    /// ⭐ `simplifyRegions`; whether anything changed.
    pub fn simplify_regions(&mut self, regions: &[RegionId], merge_blocks: bool) -> bool {
        let blocks = self.erase_unreachable_blocks(regions);
        let dce = self.region_dce(regions);
        let (mut merged, mut dropped) = (false, false);
        if merge_blocks {
            merged = self.merge_identical_blocks(regions);
            dropped = self.drop_redundant_arguments(regions);
        }
        blocks || dce || merged || dropped
    }

    /// The branches into `block`: (terminator, successor index), one per edge.
    pub fn predecessors(&self, block: BlockId) -> Vec<(OpId, usize)> {
        let Some(region) = self[block].parent else { return Vec::new() };
        let mut out = Vec::new();
        for b in &self[region].blocks {
            if let Some(&t) = self[*b].ops.last() {
                out.extend(self[t].successors.iter().enumerate().filter(|(_, s)| **s == block).map(|(i, _)| (t, i)));
            }
        }
        out
    }

    /// The block defining `v`.
    pub fn value_block(&self, v: ValueId) -> Option<BlockId> {
        match self[v].def {
            crate::Def::Result(op, _) => self[op].parent,
            crate::Def::Arg(b, _) => Some(b),
        }
    }

    /// Whether some use of `v` is by an op outside `block`.
    fn used_outside(&self, v: ValueId, block: BlockId) -> bool {
        self[v].uses.iter().any(|u| self[u.op].parent != Some(block))
    }

    /// `dropRedundantArguments` of one block: an argument every predecessor passes the same
    /// value for is replaced by it.
    fn drop_redundant_block_args(&mut self, block: BlockId) -> bool {
        let preds = self.predecessors(block);
        let mut erase = Vec::new();
        for (i, arg) in self[block].args.clone().into_iter().enumerate() {
            let mut common = None;
            let mut same = true;
            for (t, s) in &preds {
                let Some(range) = self.successor_operands(*t, *s) else {
                    same = false;
                    break;
                };
                let v = self[*t].operands[range.start + i];
                match common {
                    None => common = Some(v),
                    Some(c) if c != v => {
                        same = false;
                        break;
                    }
                    _ => {}
                }
            }
            if let (Some(c), true) = (common, same) {
                erase.push(i);
                self.replace_all_uses(arg, c);
            }
        }
        for i in erase.iter().rev() {
            self.erase_arg(block, *i);
            for (t, s) in self.predecessors(block) {
                self.erase_successor_operand(t, s, *i);
            }
        }
        !erase.is_empty()
    }

    fn drop_redundant_arguments(&mut self, regions: &[RegionId]) -> bool {
        let mut work: Vec<RegionId> = regions.to_vec();
        let mut changed = false;
        while let Some(r) = work.pop() {
            for b in self[r].blocks.clone() {
                changed |= self.drop_redundant_block_args(b);
                work.extend(self[b].ops.iter().flat_map(|o| self[*o].regions.clone()));
            }
        }
        changed
    }

    /// Two ops alike but for their operands (whose types must still agree).
    fn alike(&self, l: OpId, r: OpId) -> bool {
        let (a, b) = (&self[l], &self[r]);
        a.name == b.name && a.attributes == b.attributes && a.properties == b.properties && a.regions.len() == b.regions.len() && a.successors.len() == b.successors.len() && a.operands.len() == b.operands.len() && self.types(&a.results) == self.types(&b.results) && a.operands.iter().zip(&b.operands).all(|(x, y)| x == y || self[*x].ty == self[*y].ty)
    }

    /// A value's place in its block: arguments first, then results in op order.
    fn order_in_block(&self, v: ValueId) -> usize {
        match self[v].def {
            crate::Def::Arg(_, i) => i as usize,
            crate::Def::Result(op, i) => {
                let block = self[op].parent.expect("placed");
                let before: usize = self[block].ops.iter().take_while(|o| **o != op).map(|o| self[*o].results.len()).sum();
                self[block].args.len() + before + i as usize
            }
        }
    }

    /// `BlockMergeCluster::addToCluster`: the operands to turn into arguments, if `other`
    /// can merge into `leader`.
    fn mergeable(&self, leader: BlockId, other: BlockId) -> Option<Vec<(usize, usize)>> {
        if self.types(&self[leader].args) != self.types(&self[other].args) || self[leader].ops.len() != self[other].ops.len() {
            return None;
        }
        let preds_of = |b: BlockId| self.predecessors(b).into_iter().filter_map(|(t, _)| self[t].parent).collect::<Vec<_>>();
        let valid = |b: BlockId, v: ValueId| {
            let Some(vb) = self.value_block(v) else { return true };
            self.def_op(v) != self[vb].ops.last().copied() || !preds_of(b).contains(&vb)
        };
        let mut mismatched = Vec::new();
        for (i, (l, r)) in self[leader].ops.iter().zip(&self[other].ops).enumerate() {
            if !self.alike(*l, *r) {
                return None;
            }
            for (k, (x, y)) in self[*l].operands.iter().zip(&self[*r].operands).enumerate() {
                if x == y {
                    continue;
                }
                let (lin, rin) = (self.value_block(*x) == Some(leader), self.value_block(*y) == Some(other));
                if lin != rin {
                    return None;
                }
                if !lin {
                    if !valid(leader, *x) || !valid(other, *y) {
                        return None;
                    }
                    mismatched.push((i, k));
                    continue;
                }
                if self.order_in_block(*x) != self.order_in_block(*y) {
                    return None;
                }
            }
            if self[*r].results.iter().any(|v| self.used_outside(*v, other)) || self[*l].results.iter().any(|v| self.used_outside(*v, leader)) {
                return None;
            }
        }
        Some(mismatched)
    }

    /// Merges `blocks` into `leader`, `operands` (op index, operand index) becoming arguments.
    fn merge_cluster(&mut self, leader: BlockId, blocks: &[BlockId], operands: &BTreeSet<(usize, usize)>) -> bool {
        if blocks.is_empty() {
            return false;
        }
        if !operands.is_empty() {
            let all_branches = |b: BlockId| self.predecessors(b).iter().all(|(t, _)| self.is_branch(*t));
            if !all_branches(leader) || !blocks.iter().all(|b| all_branches(*b)) {
                return false;
            }
            let old = self[leader].args.len();
            let mut new_args: Vec<Vec<ValueId>> = alloc::vec![Vec::new(); blocks.len() + 1];
            for (opi, k) in operands {
                for (c, b) in core::iter::once(leader).chain(blocks.iter().copied()).enumerate() {
                    let op = self[b].ops[*opi];
                    let v = self[op].operands[*k];
                    new_args[c].push(v);
                    if c == 0 {
                        let ty = self[v].ty.clone();
                        let a = self.add_arg(leader, ty);
                        self.set_operand(op, *k, a);
                    }
                }
            }
            let new_args = self.prune_redundant(new_args, old, leader);
            for (c, b) in core::iter::once(leader).chain(blocks.iter().copied()).enumerate() {
                for (t, s) in self.predecessors(b) {
                    self.append_successor_operands(t, s, &new_args[c]);
                }
            }
        }
        for b in blocks {
            for (t, s) in self.predecessors(*b) {
                self[t].successors[s] = leader;
            }
            for o in self[*b].ops.clone().into_iter().rev() {
                self.drop_result_uses(o);
                self.erase(o);
            }
            self.remove_block(*b);
        }
        true
    }

    /// `pruneRedundantArguments`: new arguments every predecessor fills alike collapse to one.
    fn prune_redundant(&mut self, lists: Vec<Vec<ValueId>>, old: usize, block: BlockId) -> Vec<Vec<ValueId>> {
        let n = lists[0].len();
        let mut first = alloc::collections::BTreeMap::new();
        for (j, v) in lists[0].iter().enumerate() {
            first.entry(*v).or_insert(j);
        }
        let mut replace = alloc::collections::BTreeMap::new();
        for j in 0..n {
            let k = first[&lists[0][j]];
            if k != j && lists.iter().skip(1).all(|l| l[k] == l[j]) {
                replace.insert(j, k);
            }
        }
        let pruned = lists.iter().map(|l| (0..n).filter(|j| !replace.contains_key(j)).map(|j| l[j]).collect()).collect();
        let mut erase = Vec::new();
        for (j, k) in &replace {
            let (from, to) = (self[block].args[old + j], self[block].args[old + k]);
            self.replace_all_uses(from, to);
            erase.push(old + j);
        }
        for i in erase.into_iter().rev() {
            self.erase_arg(block, i);
        }
        pruned
    }

    fn merge_identical_blocks_in(&mut self, region: RegionId) -> bool {
        let blocks = self[region].blocks.clone();
        if blocks.len() <= 1 {
            return false;
        }
        // Blocks grouped by their successor lists, in first-seen order.
        let mut groups: Vec<(Vec<BlockId>, Vec<BlockId>)> = Vec::new();
        for b in blocks.into_iter().skip(1) {
            let succ = self.successors(b).to_vec();
            match groups.iter_mut().find(|g| g.0 == succ) {
                Some(g) => g.1.push(b),
                None => groups.push((succ, alloc::vec![b])),
            }
        }
        let mut merged = false;
        for (_, group) in groups {
            if group.len() == 1 {
                continue;
            }
            let mut clusters: Vec<(BlockId, Vec<BlockId>, BTreeSet<(usize, usize)>)> = Vec::new();
            for b in group {
                if self[b].ops.iter().any(|o| self[*o].regions.iter().any(|r| !self[*r].blocks.is_empty())) || self[b].args.iter().any(|a| self.used_outside(*a, b)) {
                    continue;
                }
                let mut placed = false;
                for c in clusters.iter_mut() {
                    if let Some(m) = self.mergeable(c.0, b) {
                        c.1.push(b);
                        c.2.extend(m);
                        placed = true;
                        break;
                    }
                }
                if !placed {
                    clusters.push((b, Vec::new(), BTreeSet::new()));
                }
            }
            for (leader, members, operands) in clusters {
                merged |= self.merge_cluster(leader, &members, &operands);
            }
        }
        merged
    }

    fn merge_identical_blocks(&mut self, regions: &[RegionId]) -> bool {
        let mut work: Vec<RegionId> = regions.to_vec();
        let mut changed = false;
        while let Some(r) = work.pop() {
            if self.merge_identical_blocks_in(r) {
                work.push(r);
                changed = true;
            }
            for b in self[r].blocks.clone() {
                for o in self[b].ops.clone() {
                    for nested in self[o].regions.clone() {
                        if !work.contains(&nested) {
                            work.push(nested);
                        }
                    }
                }
            }
        }
        changed
    }
}
