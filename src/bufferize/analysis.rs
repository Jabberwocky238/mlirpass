//! The One-Shot analysis, as `OneShotAnalysis.cpp`: every tensor operand, in the heuristic's
//! order, bufferizes in place unless that would write to a non-writable buffer or create a
//! read-after-write conflict; then which values are equivalent, which uses read undefined
//! contents.

use alloc::collections::{BTreeMap, BTreeSet};
use alloc::format;
use alloc::string::String;
use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{Attribute, Error};

use super::{is_tensor, OneShot, BufferizationOptions, BufferRelation, AnalysisState, TraversalConfig};
use crate::{Body, Def, OpId, Operand, RegionId, ValueId};

/// `std::mt19937`, the fuzzer heuristic's shuffle.
struct Mt19937 {
    state: [u32; 624],
    at: usize,
}

impl Mt19937 {
    fn new(seed: u32) -> Self {
        let mut state = [0u32; 624];
        state[0] = seed;
        for i in 1..624 {
            state[i] = 1_812_433_253u32.wrapping_mul(state[i - 1] ^ (state[i - 1] >> 30)).wrapping_add(i as u32);
        }
        Self { state, at: 624 }
    }

    fn next(&mut self) -> u32 {
        if self.at >= 624 {
            for i in 0..624 {
                let y = (self.state[i] & 0x8000_0000) | (self.state[(i + 1) % 624] & 0x7fff_ffff);
                let mut v = self.state[(i + 397) % 624] ^ (y >> 1);
                if y & 1 != 0 {
                    v ^= 0x9908_b0df;
                }
                self.state[i] = v;
            }
            self.at = 0;
        }
        let mut y = self.state[self.at];
        self.at += 1;
        y ^= y >> 11;
        y ^= (y << 7) & 0x9d2c_5680;
        y ^= (y << 15) & 0xefc6_0000;
        y ^ (y >> 18)
    }

    /// `llvm::shuffle`.
    fn shuffle<T>(&mut self, v: &mut [T]) {
        let mut first = 0;
        let mut size = v.len();
        while size > 1 {
            let offset = self.next() as usize % size;
            if offset != 0 {
                v.swap(first, first + offset);
            }
            first += 1;
            size -= 1;
        }
    }
}

impl Body<'_> {
    /// `Operation::isProperAncestor`.
    fn proper_ancestor(&self, a: OpId, x: OpId) -> bool {
        a != x && self.is_ancestor(a, x)
    }

    /// The op of `block` holding `x` (`findAncestorOpInBlock`).
    fn ancestor_in_block(&self, block: crate::BlockId, mut x: OpId) -> Option<OpId> {
        loop {
            if self[x].parent == Some(block) {
                return Some(x);
            }
            x = self.parent_op(x)?;
        }
    }

    /// `DominanceInfo::properlyDominates(a, x)`.
    fn properly_dominates(&self, a: OpId, x: OpId) -> bool {
        if a == x {
            return false;
        }
        let Some(blk) = self[a].parent else { return false };
        let Some(region) = self[blk].parent else { return false };
        // `x`, or its ancestor, in `a`'s region.
        let mut xa = x;
        let xb = loop {
            let Some(b) = self[xa].parent else { return false };
            if self[b].parent == Some(region) {
                break b;
            }
            match self.parent_op(xa) {
                Some(p) => xa = p,
                None => return false,
            }
        };
        if xa == a {
            return true;
        }
        if xb == blk {
            let ops = &self[blk].ops;
            return ops.iter().position(|o| *o == a) < ops.iter().position(|o| *o == xa);
        }
        !self.has_ssa_dominance(region) || self.dom_tree(region).dominates(blk, xb)
    }

    /// `happensBefore`: `a` (or an ancestor) properly dominates `x`, `a` not holding it.
    fn happens_before(&self, mut a: OpId, x: OpId) -> bool {
        loop {
            if self.proper_ancestor(a, x) {
                return false;
            }
            if self.properly_dominates(a, x) {
                return true;
            }
            match self.parent_op(a) {
                Some(p) => a = p,
                None => return false,
            }
        }
    }

    fn region_of_op(&self, op: OpId) -> Option<RegionId> {
        self[op].parent.and_then(|blk| self[blk].parent)
    }

    fn region_of_value(&self, v: ValueId) -> Option<RegionId> {
        match self[v].def {
            Def::Result(op, _) => self.region_of_op(op),
            Def::Arg(blk, _) => self[blk].parent,
        }
    }

    fn parent_region(&self, r: RegionId) -> Option<RegionId> {
        self.region_of_op(self[r].parent)
    }

    /// The index of region `r` in its op.
    fn region_index(&self, r: RegionId) -> usize {
        self[self[r].parent].regions.iter().position(|x| *x == r).expect("a region of its op")
    }

    /// `Block::isReachable(other, except)`: `other` is reached from `from`'s successors, not
    /// through `except`.
    fn block_reachable(&self, from: crate::BlockId, to: crate::BlockId, except: crate::BlockId) -> bool {
        let succs = |blk: crate::BlockId| self[blk].ops.last().map(|t| self[*t].successors.to_vec()).unwrap_or_default();
        let mut work = succs(from);
        let mut seen = BTreeSet::new();
        while let Some(blk) = work.pop() {
            if blk == to {
                return true;
            }
            if blk == except || !seen.insert(blk) {
                continue;
            }
            work.extend(succs(blk));
        }
        false
    }
}

impl BufferizationOptions {
    /// Region `r` repeats (`isRepetitiveRegion` of its op's interface).
    fn repetitive(&self, b: &Body<'_>, r: RegionId) -> bool {
        let op = b[r].parent;
        self.bufferizable(b, op).is_some_and(|i| i.repetitive_region(b, op, b.region_index(r)))
    }

    /// `getEnclosingRepetitiveRegion`: `r` or the first region around it that repeats.
    fn enclosing_repetitive(&self, b: &Body<'_>, mut r: Option<RegionId>) -> Option<RegionId> {
        while let Some(x) = r {
            if self.repetitive(b, x) {
                return Some(x);
            }
            r = b.parent_region(x);
        }
        None
    }

    /// `getNextEnclosingRepetitiveRegion`.
    fn next_repetitive(&self, b: &Body<'_>, r: RegionId) -> Option<RegionId> {
        self.enclosing_repetitive(b, b.parent_region(r))
    }

    /// `getParallelRegion`: the first region around `r` (itself included) that is parallel.
    fn parallel_region(&self, b: &Body<'_>, mut r: Option<RegionId>) -> Option<RegionId> {
        while let Some(x) = r {
            let op = b[x].parent;
            if self.bufferizable(b, op).is_some_and(|i| i.parallel_region(b, op, b.region_index(x))) {
                return Some(x);
            }
            r = b.parent_region(x);
        }
        None
    }
}

/// `SubsetInsertionOpInterface` of the ops that implement it: (source, destination) operand
/// indices.
fn subset_insertion(b: &Body<'_>, op: OpId) -> Option<(usize, usize)> {
    matches!(&*b[op].name, "tensor.insert_slice" | "tensor.parallel_insert_slice" | "bufferization.materialize_in_destination").then_some((0, 1))
}

impl<'o> AnalysisState<'o> {
    fn shot(&self) -> &OneShot {
        self.one_shot.as_ref().expect("a One-Shot analysis")
    }

    fn shot_mut(&mut self) -> &mut OneShot {
        self.one_shot.as_mut().expect("a One-Shot analysis")
    }

    /// `bufferizeInPlace`: `u` in place, its aliasing values in its alias set.
    fn bufferize_in_place(&mut self, b: &Body<'_>, u: Operand) {
        if !self.shot_mut().inplace.insert(u) {
            return;
        }
        let v = b[u.0].operands[u.1];
        for a in self.aliasing_values(b, u) {
            self.shot_mut().alias.union(a.value, v);
        }
    }

    /// `findDefinitionsCached`.
    fn definitions_cached(&mut self, b: &Body<'_>, u: Operand) -> Vec<ValueId> {
        let v = b[u.0].operands[u.1];
        if let Some(d) = self.shot().definitions.get(&v) {
            return d.clone();
        }
        let d = self.definitions(b, u);
        self.shot_mut().definitions.insert(v, d.clone());
        d
    }

    fn in_place_write(&self, b: &Body<'_>, u: Operand) -> bool {
        self.writes(b, u) && self.in_place(b, u)
    }

    /// `getAliasingInplaceWrites`.
    fn aliasing_in_place_writes(&self, b: &Body<'_>, root: ValueId, res: &mut Vec<Operand>) {
        for alias in self.shot().alias.of(root) {
            for u in b.uses_of(alias) {
                if self.in_place_write(b, u) && !res.contains(&u) {
                    res.push(u);
                }
            }
        }
    }

    /// `getAliasingReads`.
    fn aliasing_reads(&self, b: &Body<'_>, root: ValueId, res: &mut Vec<Operand>) {
        for alias in self.shot().alias.of(root) {
            for u in b.uses_of(alias) {
                let read = self.reads(b, u) || (!self.writes(b, u) && self.aliasing_values(b, u).iter().any(|a| self.value_read(b, a.value)));
                if read && !res.contains(&u) {
                    res.push(u);
                }
            }
        }
    }

    /// `canUseOpDominance`: by regions (a definition in a repetitive region outside the read's
    /// is reached again) and by blocks (read and write reach each other not through the def).
    fn can_use_dominance(&self, b: &Body<'_>, read: Operand, write: Operand, defs: &[ValueId]) -> bool {
        let o = self.options;
        for d in defs {
            let mut r_read = o.enclosing_repetitive(b, b.region_of_op(read.0));
            let r_def = o.enclosing_repetitive(b, b.region_of_value(*d));
            if r_read == r_def {
                continue;
            }
            loop {
                let next = r_read.and_then(|r| o.next_repetitive(b, r));
                if next == r_def || next.is_none() {
                    break;
                }
                r_read = next;
            }
            if let Some(r) = r_read
                && b.is_ancestor(b[r].parent, write.0)
            {
                return false;
            }
        }
        if b.region_of_op(read.0) != b.region_of_op(write.0) {
            return true;
        }
        let (rb, wb) = (b[read.0].parent.expect("placed"), b[write.0].parent.expect("placed"));
        for d in defs {
            let db = match b[*d].def {
                Def::Arg(blk, _) => blk,
                Def::Result(op, _) => b[op].parent.expect("placed"),
            };
            if b.block_reachable(rb, wb, db) && b.block_reachable(wb, rb, db) {
                return false;
            }
        }
        true
    }

    /// `hasEquivalentValueInReverseUseDefChain`.
    fn equivalent_in_chain(&self, b: &Body<'_>, start: Operand, other: ValueId) -> bool {
        let config = TraversalConfig { always_include_leaves: false, follow_equivalent_only: true, follow_same_type_or_casts_only: true, ..TraversalConfig::default() };
        !self.reverse_chain(b, start, &mut |_, v| v == other, config, None).is_empty()
    }

    /// `SubsetInsertionOpInterface::isEquivalentSubset`: `candidate` extracts from a value
    /// equivalent to `insert`'s destination exactly the subset it inserts.
    fn equivalent_subset(&self, b: &Body<'_>, insert: OpId, candidate: ValueId) -> bool {
        let Def::Result(ext, _) = b[candidate].def else { return false };
        let dest = b[insert].operands[1];
        if b[insert].name == "bufferization.materialize_in_destination" {
            return self.equivalent(candidate, dest);
        }
        if b[ext].name != "tensor.extract_slice" || !self.equivalent(b[ext].operands[0], dest) {
            return false;
        }
        let same = |x: &[crate::MemrefOfr], y: &[crate::MemrefOfr]| x.len() == y.len() && x.iter().zip(y).all(|(p, q)| p == q || (b.ofr_int(*p).is_some() && b.ofr_int(*p) == b.ofr_int(*q)));
        let (e, i) = (b.slice_lists(ext), b.slice_lists(insert));
        (0..3).all(|k| same(&e[k], &i[k]))
    }

    /// `matchesInsertDestination`: every value up the chain from `u` is such a subset.
    fn matches_insert_destination(&self, b: &Body<'_>, u: Operand, insert: OpId) -> bool {
        let matching = |s: &Self, v: ValueId| s.equivalent_subset(b, insert, v);
        let slice = self.reverse_chain(b, u, &mut |s, v| matching(s, v), TraversalConfig::default(), None);
        slice.iter().all(|v| matching(self, *v))
    }

    /// `areNonConflictingSubsets`.
    fn non_conflicting_subsets(&self, b: &Body<'_>, read: Operand, write: Operand) -> bool {
        if let Some((src, dst)) = subset_insertion(b, read.0) {
            if read.1 == dst && self.matches_insert_destination(b, write, read.0) {
                return true;
            }
            if read.1 == src && write == (read.0, dst) && self.matches_insert_destination(b, read, read.0) {
                return true;
            }
        }
        if let Some((src, dst)) = subset_insertion(b, write.0)
            && write.1 == dst
            && self.equivalent(b[read.0].operands[read.1], b[write.0].operands[src])
            && self.matches_insert_destination(b, (write.0, src), write.0)
        {
            return true;
        }
        false
    }

    /// `hasReadAfterWriteInterference`.
    fn read_after_write(&mut self, b: &Body<'_>, reads: &[Operand], writes: &[Operand]) -> bool {
        let o = self.options;
        if o.check_parallel_regions && !reads.is_empty() {
            for &w in writes {
                let defs = self.reverse_chain(b, w, &mut |s, v| s.value_writes(b, v), TraversalConfig::default(), None);
                for d in defs {
                    if o.parallel_region(b, b.region_of_value(d)) != o.parallel_region(b, b.region_of_op(w.0)) {
                        return true;
                    }
                }
            }
        }
        for &r in reads {
            let defs = self.definitions_cached(b, r);
            if defs.is_empty() {
                continue;
            }
            for &w in writes {
                if self.can_use_dominance(b, r, w, &defs) {
                    if b.happens_before(r.0, w.0) || w == r || b.mutually_exclusive(r.0, w.0) {
                        continue;
                    }
                    if w.0 == r.0
                        && o.bufferizable(b, r.0).is_some_and(|i| i.elementwise(self, b, &[r, w]))
                        && (self.equivalent_in_chain(b, r, b[w.0].operands[w.1]) || self.equivalent_in_chain(b, w, b[r.0].operands[r.1]))
                    {
                        continue;
                    }
                }
                if self.non_conflicting_subsets(b, r, w) {
                    continue;
                }
                if o.bufferizable(b, r.0).is_some_and(|i| i.not_conflicting(self, b, r, w)) {
                    continue;
                }
                if w.0 != r.0 && o.bufferizable(b, w.0).is_some_and(|i| i.not_conflicting(self, b, r, w)) {
                    continue;
                }
                for &d in &defs {
                    match b[d].def {
                        Def::Result(dop, _) => {
                            if b.happens_before(w.0, dop) || b.proper_ancestor(dop, w.0) {
                                continue;
                            }
                        }
                        Def::Arg(blk, _) => {
                            if b.ancestor_in_block(blk, w.0).is_none() {
                                continue;
                            }
                        }
                    }
                    let aliases = self.aliasing_values(b, w);
                    if aliases.len() == 1 && aliases[0].value == d {
                        continue;
                    }
                    return true;
                }
            }
        }
        false
    }

    /// `wouldCreateReadAfterWriteInterference`.
    fn would_create_raw(&mut self, b: &Body<'_>, u: Operand, consistency_only: bool) -> bool {
        let (mut reads, mut writes) = (Vec::new(), Vec::new());
        let v = b[u.0].operands[u.1];
        self.aliasing_reads(b, v, &mut reads);
        self.aliasing_in_place_writes(b, v, &mut writes);
        for a in self.aliasing_values(b, u) {
            self.aliasing_reads(b, a.value, &mut reads);
            self.aliasing_in_place_writes(b, a.value, &mut writes);
        }
        if !consistency_only && self.writes(b, u) && !writes.contains(&u) {
            writes.push(u);
        }
        self.read_after_write(b, &reads, &writes)
    }

    /// `wouldCreateWriteToNonWritableBuffer`.
    fn would_write_read_only(&self, b: &Body<'_>, u: Operand, consistency_only: bool) -> bool {
        let mut found = !consistency_only && self.writes(b, u);
        let v = b[u.0].operands[u.1];
        if !found {
            let mut w = Vec::new();
            self.aliasing_in_place_writes(b, v, &mut w);
            for a in self.aliasing_values(b, u) {
                self.aliasing_in_place_writes(b, a.value, &mut w);
            }
            found = !w.is_empty();
        }
        if !found {
            return false;
        }
        let mut read_only = self.shot().alias.of(v).into_iter().any(|x| !self.writable(b, x));
        for a in self.aliasing_values(b, u) {
            read_only |= self.shot().alias.of(a.value).into_iter().any(|x| !self.writable(b, x));
        }
        read_only
    }

    /// `analyzeSingleOp`: each tensor operand in place unless that conflicts.
    fn analyze_single(&mut self, b: &Body<'_>, op: OpId) {
        for i in 0..b[op].operands.len() {
            let u = (op, i);
            if !b.tensor_operand(u) {
                continue;
            }
            let conflict = self.would_write_read_only(b, u, false) || self.would_create_raw(b, u, false);
            if !conflict {
                self.bufferize_in_place(b, u);
            }
        }
    }

    /// `hasTensorSemantics`: through the op's interface (whatever the options allow).
    fn tensor_semantics(b: &Body<'_>, op: OpId) -> bool {
        match b.ctx.interfaces.of(&b[op].name).and_then(|i| i.bufferizable(&b[op].name)) {
            Some(i) => i.tensor_semantics(b, op),
            None => b.default_tensor_semantics(op),
        }
    }

    /// `bottomUpFromTerminatorsHeuristic`.
    fn bottom_up_from_terminators(&self, b: &Body<'_>, root: OpId) -> Vec<OpId> {
        let mut traversed: Vec<OpId> = Vec::new();
        let mut terms = Vec::new();
        b.walk_post(root, &mut |op| {
            if b.interfaces(op).is_some_and(|i| i.is_region_terminator(b, op)) {
                terms.push(op);
            }
        });
        for term in terms {
            if traversed.contains(&term) {
                continue;
            }
            traversed.push(term);
            let mut work: Vec<ValueId> = b[term].operands.iter().copied().filter(|v| is_tensor(&b[*v].ty) && matches!(b[*v].def, Def::Result(..))).collect();
            while let Some(r) = work.pop() {
                let Def::Result(def, _) = b[r].def else { continue };
                if traversed.contains(&def) {
                    continue;
                }
                traversed.push(def);
                let region = b.region_of_op(term).expect("a terminator in a region");
                if !b[region].blocks.iter().any(|blk| b.ancestor_in_block(*blk, def).is_some()) {
                    continue;
                }
                for a in self.aliasing_operands(b, r) {
                    let v = b[a.operand.0].operands[a.operand.1];
                    if is_tensor(&b[v].ty) && matches!(b[v].def, Def::Result(..)) {
                        work.push(v);
                    }
                }
            }
        }
        let mut result = traversed.clone();
        // `walk<PostOrder, ReverseIterator>`: the post order with each block's ops reversed.
        for op in Self::reverse_post_order(b, root) {
            if !traversed.contains(&op) && Self::tensor_semantics(b, op) {
                result.push(op);
            }
        }
        result
    }

    /// `walk<WalkOrder::PostOrder, ReverseIterator>`.
    fn reverse_post_order(b: &Body<'_>, op: OpId) -> Vec<OpId> {
        let mut out = Vec::new();
        for r in b[op].regions.iter().rev() {
            for blk in b[*r].blocks.iter().rev() {
                for o in b[*blk].ops.iter().rev() {
                    out.extend(Self::reverse_post_order(b, *o));
                }
            }
        }
        out.push(op);
        out
    }

    /// `OneShotAnalysisState::analyzeOp`: every op in the heuristic's order, then equivalence.
    fn analyze_ops(&mut self, b: &Body<'_>, root: OpId) {
        let ordered = match self.options.heuristic {
            super::AnalysisHeuristic::BottomUpFromTerminators => self.bottom_up_from_terminators(b, root),
            h => {
                let mut ops = Vec::new();
                b.walk_post(root, &mut |op| {
                    if Self::tensor_semantics(b, op) {
                        ops.push(op);
                    }
                });
                match h {
                    super::AnalysisHeuristic::BottomUp => ops.reverse(),
                    super::AnalysisHeuristic::Fuzzer(seed) => Mt19937::new(seed).shuffle(&mut ops),
                    _ => {}
                }
                ops
            }
        };
        for op in ordered {
            self.analyze_single(b, op);
        }
        self.equivalence(b, root);
    }

    /// `equivalenceAnalysis`.
    fn equivalence(&mut self, b: &Body<'_>, root: OpId) {
        let mut ops = Vec::new();
        b.walk_post(root, &mut |op| {
            if b[op].results.iter().any(|r| is_tensor(&b[*r].ty)) {
                ops.push(op);
            }
        });
        for op in ops {
            let Some(i) = self.options.bufferizable(b, op) else { continue };
            for &r in b[op].results.iter() {
                if !is_tensor(&b[r].ty) {
                    continue;
                }
                let aliases = self.aliasing_operands(b, r);
                let Some(first) = aliases.first().map(|a| b[a.operand.0].operands[a.operand.1]) else { continue };
                let mut all = true;
                let mut done = false;
                for a in &aliases {
                    let equiv = a.relation == BufferRelation::Equivalent;
                    let in_place = self.in_place(b, a.operand);
                    let operand = b[a.operand.0].operands[a.operand.1];
                    if equiv && in_place && a.definite {
                        self.shot_mut().equiv.union(r, operand);
                        all = false;
                        done = true;
                        break;
                    }
                    if !equiv || !in_place {
                        all = false;
                    }
                    if !self.equivalent(operand, first) {
                        all = false;
                    }
                }
                if !done && all && !i.to_allocation(b, r) {
                    self.shot_mut().equiv.union(r, first);
                }
            }
        }
    }

    /// `gatherUndefinedTensorUses`: the uses of a result no definition reaches.
    fn gather_undefined(&mut self, b: &Body<'_>, root: OpId) {
        let mut ops = Vec::new();
        b.walk_post(root, &mut |op| ops.push(op));
        for op in ops {
            if self.options.bufferizable(b, op).is_none() {
                continue;
            }
            for &r in b[op].results.iter() {
                if !is_tensor(&b[r].ty) {
                    continue;
                }
                let Some(&first) = b.uses_of(r).first() else { continue };
                if self.definitions_cached(b, first).is_empty() {
                    let uses = b.uses_of(r);
                    self.shot_mut().undefined.extend(uses);
                }
            }
        }
    }

    /// `checkPreBufferizationAssumptions`.
    fn check_assumptions(&mut self, b: &Body<'_>, root: OpId) -> Result<(), Error> {
        let mut ops = Vec::new();
        b.walk_post(root, &mut |op| ops.push(op));
        let o = self.options;
        for &op in &ops {
            let Some(i) = o.bufferizable(b, op) else { continue };
            if !i.unstructured_control_flow(b, op) && b[op].regions.iter().any(|r| b[*r].blocks.len() > 1) {
                return Err(Error(format!("'{}' op op or BufferizableOpInterface implementation does not support unstructured control flow, but at least one region has multiple blocks", b[op].name)));
            }
        }
        for &op in &ops {
            if o.bufferizable(b, op).is_none() {
                continue;
            }
            if b[op].name == "bufferization.to_tensor" && b[op].get("restrict").is_none() && !b[b[op].results[0]].uses.is_empty() {
                return Err(Error(format!("'{}' op to_tensor ops without `restrict` are not supported by One-Shot Analysis", b[op].name)));
            }
            for i in 0..b[op].operands.len() {
                let u = (op, i);
                if !b.tensor_operand(u) {
                    continue;
                }
                if self.would_create_raw(b, u, true) {
                    return Err(Error(format!("'{}' op not bufferizable under the given constraints: cannot avoid RaW conflict", b[op].name)));
                }
                if self.in_place(b, u) && self.would_write_read_only(b, u, true) {
                    return Err(Error(format!("'{}' op not bufferizable under the given constraints: would write to read-only buffer", b[op].name)));
                }
            }
        }
        Ok(())
    }

    /// `OneShotAnalysisState(op, options)`: every tensor in `root` in its own alias and
    /// equivalence set, the operands that must bufferize in place in place.
    pub(crate) fn one_shot(options: &'o BufferizationOptions, b: &Body<'_>, root: OpId) -> Self {
        let mut s = Self { options, one_shot: Some(OneShot::default()) };
        b.walk_post(root, &mut |op| {
            let shot = s.one_shot.as_mut().expect("one-shot");
            for r in b[op].results.iter().filter(|v| is_tensor(&b[**v].ty)) {
                shot.alias.insert(*r);
                shot.equiv.insert(*r);
            }
            for reg in b[op].regions.iter() {
                for blk in b[*reg].blocks.iter() {
                    for a in b[*blk].args.iter().filter(|a| is_tensor(&b[**a].ty)) {
                        shot.alias.insert(*a);
                        shot.equiv.insert(*a);
                    }
                }
            }
        });
        let mut ops = Vec::new();
        b.walk(root, &mut |op| ops.push(op));
        for op in ops {
            let Some(i) = options.bufferizable(b, op) else { continue };
            for k in 0..b[op].operands.len() {
                if b.tensor_operand((op, k)) && i.must_in_place(&s, b, (op, k)) {
                    s.bufferize_in_place(b, (op, k));
                }
            }
        }
        s
    }

    /// `analyzeOp(root, state)`: the checks, the in-place decisions, equivalence, undefined uses
    /// and each op's `verifyAnalysis`.
    pub(crate) fn analyze_root(&mut self, b: &Body<'_>, root: OpId) -> Result<(), Error> {
        self.check_assumptions(b, root)?;
        self.analyze_ops(b, root);
        self.gather_undefined(b, root);
        let mut ops = Vec::new();
        b.walk_post(root, &mut |op| ops.push(op));
        let mut failed = None;
        for op in ops {
            if let Some(i) = self.options.bufferizable(b, op)
                && let Err(e) = i.verify(self, b, op)
            {
                failed.get_or_insert(e);
            }
        }
        failed.map_or(Ok(()), Err)
    }

    /// ⭐ The One-Shot analysis of `root`.
    pub fn analyze(options: &'o BufferizationOptions, b: &Body<'_>, root: OpId) -> Result<Self, Error> {
        let mut s = Self::one_shot(options, b, root);
        s.analyze_root(b, root)?;
        Ok(s)
    }

    /// `isValueWritten`: an alias is written by an in-place use.
    fn value_written(&self, b: &Body<'_>, v: ValueId) -> bool {
        self.shot().alias.of(v).into_iter().any(|a| b.uses_of(a).into_iter().any(|u| self.in_place(b, u) && self.writes(b, u)))
    }

    /// `aliasingFuncOpBBArgsAnalysis` and `funcOpBbArgReadWriteAnalysis` of `f`.
    fn func_summary(&mut self, b: &Body<'_>, f: OpId) -> Result<(), Error> {
        let (inputs, results) = func_signature(b, f);
        let mut info_aliasing: BTreeMap<usize, Vec<usize>> = BTreeMap::new();
        let mut info_equiv: BTreeMap<usize, usize> = BTreeMap::new();
        let returns = return_ops(b, f);
        let entry = b[f].regions.first().and_then(|r| b[*r].blocks.first()).copied();
        match entry {
            None => {
                for (i, t) in inputs.iter().enumerate() {
                    if !is_tensor(t) {
                        continue;
                    }
                    for (r, rt) in results.iter().enumerate() {
                        if is_tensor(rt) {
                            info_aliasing.entry(i).or_default().push(r);
                        }
                    }
                }
            }
            Some(blk) => {
                if returns.is_empty() {
                    return Err(Error(format!("'{}' op cannot bufferize func.func without func.return", b[f].name)));
                }
                let args = b[blk].args.to_vec();
                let ranked = |v: ValueId| matches!(&b[v].ty, mlirformat::Type::Shaped(s) if s.kind == mlirformat::ShapedKind::Tensor && s.shape.is_some());
                for (i, a) in args.iter().enumerate() {
                    if !ranked(*a) {
                        continue;
                    }
                    let mut aliases: Vec<usize> = Vec::new();
                    for r in &returns {
                        for (k, v) in b[*r].operands.iter().enumerate() {
                            if ranked(*v) && self.aliasing(*v, *a) && !aliases.contains(&k) {
                                aliases.push(k);
                            }
                        }
                    }
                    info_aliasing.entry(i).or_default().extend(aliases);
                }
                let equivalent_arg = |s: &Self, v: ValueId| -> Option<usize> {
                    if !is_tensor(&b[v].ty) {
                        return None;
                    }
                    args.iter().position(|a| ranked(*a) && s.equivalent(v, *a))
                };
                for k in 0..b[returns[0]].operands.len() {
                    let Some(arg) = equivalent_arg(self, b[returns[0]].operands[k]) else { continue };
                    if returns[1..].iter().all(|r| equivalent_arg(self, b[*r].operands[k]) == Some(arg)) {
                        info_equiv.insert(k, arg);
                    }
                }
            }
        }
        let mut read = BTreeSet::new();
        let mut written = BTreeSet::new();
        for (i, t) in inputs.iter().enumerate() {
            if !is_tensor(t) {
                continue;
            }
            let (r, w) = match func_arg_attr(b, f, i, "bufferization.access") {
                Some(Attribute::Str { lit, .. }) => {
                    let v = lit.trim_matches('"');
                    (matches!(v, "read" | "read-write"), matches!(v, "write" | "read-write"))
                }
                _ => match entry {
                    None => (true, true),
                    Some(blk) => {
                        let a = b[blk].args[i];
                        (self.value_read(b, a), self.value_written(b, a))
                    }
                },
            };
            if r {
                read.insert(i);
            }
            if w {
                written.insert(i);
            }
        }
        let funcs = self.shot_mut().funcs.get_or_insert_with(Default::default);
        funcs.aliasing.insert(f, info_aliasing);
        funcs.equivalent.insert(f, info_equiv);
        funcs.read.insert(f, read);
        funcs.written.insert(f, written);
        Ok(())
    }

    /// ⭐ `analyzeModuleOp`: the functions callees first, each analyzed and summarized for its
    /// callers; then those in call cycles.
    pub fn analyze_module(options: &'o BufferizationOptions, b: &Body<'_>, module: OpId) -> Result<Self, Error> {
        let mut s = Self::one_shot(options, b, module);
        s.shot_mut().funcs = Some(Default::default());
        let (ordered, remaining) = funcs_by_calls(b, module);
        for f in ordered {
            if !options.allowed(b, f) {
                continue;
            }
            s.shot_mut().funcs.as_mut().expect("funcs").analyzed.insert(f, false);
            s.analyze_root(b, f)?;
            s.func_summary(b, f)?;
            s.shot_mut().funcs.as_mut().expect("funcs").analyzed.insert(f, true);
        }
        for f in remaining {
            if options.allowed(b, f) {
                s.analyze_root(b, f)?;
            }
        }
        Ok(s)
    }

    /// The `test-analysis-only` marks of the module analysis: each analyzed function's ops,
    /// its returns' `__equivalent_func_args__` and its arguments' `bufferization.access`.
    pub fn annotate_module(&self, b: &mut Body<'_>, module: OpId) {
        let (ordered, remaining) = funcs_by_calls(b, module);
        for f in ordered.iter().chain(&remaining) {
            if self.options.allowed(b, *f) {
                self.annotate(b, *f);
                if self.options.dump_alias_sets {
                    self.annotate_alias_sets(b, *f);
                }
            }
        }
        for f in ordered {
            if !self.func_analyzed(f) {
                continue;
            }
            let returns = return_ops(b, f);
            if let Some(blk) = b[f].regions.first().and_then(|r| b[*r].blocks.first()).copied() {
                let args = b[blk].args.to_vec();
                let ranked = |b: &Body<'_>, v: ValueId| matches!(&b[v].ty, mlirformat::Type::Shaped(s) if s.kind == mlirformat::ShapedKind::Tensor && s.shape.is_some());
                if let Some(&first) = returns.first() {
                    for k in 0..b[first].operands.len() {
                        for (n, r) in returns.iter().enumerate() {
                            let v = b[*r].operands[k];
                            let arg = if is_tensor(&b[v].ty) { args.iter().position(|a| ranked(b, *a) && self.equivalent(v, *a)) } else { None };
                            let Some(arg) = arg else { break };
                            let mut marks: Vec<i64> = match b[*r].get("__equivalent_func_args__") {
                                Some(Attribute::Array(xs)) => xs.iter().map(|x| if let Attribute::Int { lit, .. } = x { lit.parse().unwrap_or(-1) } else { -1 }).collect(),
                                _ => vec![-1; b[*r].operands.len()],
                            };
                            marks[k] = arg as i64;
                            b[*r].set("__equivalent_func_args__", Attribute::Array(marks.iter().map(|m| Attribute::Int { lit: format!("{m}").into(), ty: None }).collect()));
                            if n == 0 && returns.len() == 1 {
                                break;
                            }
                        }
                    }
                }
            }
            let (inputs, _) = func_signature(b, f);
            for (i, t) in inputs.iter().enumerate() {
                if !is_tensor(t) {
                    continue;
                }
                let access = match (self.func_reads(f, i), self.func_writes(f, i)) {
                    (true, true) => "read-write",
                    (true, false) => "read",
                    (false, true) => "write",
                    (false, false) => "none",
                };
                set_func_arg_attr(b, f, i, "bufferization.access", Attribute::str(&String::from(access)));
            }
        }
    }

    /// `annotateOpsWithBufferizationMarkers` (`test-analysis-only`): each op's
    /// `__inplace_operands_attr__`, "true" / "false" per tensor operand, "none" for the others.
    pub fn annotate(&self, b: &mut Body<'_>, root: OpId) {
        let mut ops = Vec::new();
        b.walk_post(root, &mut |op| ops.push(op));
        for op in ops {
            let n = b[op].operands.len();
            if !(0..n).any(|i| b.tensor_operand((op, i))) {
                continue;
            }
            let marks: Vec<Attribute<'_>> = (0..n)
                .map(|i| {
                    let m = if !b.tensor_operand((op, i)) { "none" } else if self.in_place(b, (op, i)) { "true" } else { "false" };
                    Attribute::str(&String::from(m))
                })
                .collect();
            b[op].set("__inplace_operands_attr__", Attribute::Array(marks));
        }
    }
}

/// The inputs and results of `func.func` `f` (`getFunctionType`).
pub(crate) fn func_signature<'a>(b: &Body<'a>, f: OpId) -> (Vec<mlirformat::Type<'a>>, Vec<mlirformat::Type<'a>>) {
    match b[f].get("function_type") {
        Some(Attribute::Type(mlirformat::Type::Function(t))) => (t.inputs.clone(), t.results.clone()),
        _ => (Vec::new(), Vec::new()),
    }
}

/// `getReturnOps`: the `func.return`s ending `f`'s blocks.
pub(crate) fn return_ops(b: &Body<'_>, f: OpId) -> Vec<OpId> {
    let Some(r) = b[f].regions.first() else { return Vec::new() };
    b[*r].blocks.iter().filter_map(|blk| b[*blk].ops.last().copied()).filter(|t| b[*t].name == "func.return").collect()
}

/// Argument attribute `name` of argument `i` of `f`.
pub(crate) fn func_arg_attr<'b, 'a>(b: &'b Body<'a>, f: OpId, i: usize, name: &str) -> Option<&'b Attribute<'a>> {
    match b[f].get("arg_attrs")? {
        Attribute::Array(ds) => match ds.get(i)? {
            Attribute::Dict(d) => d.iter().find(|a| a.name == name)?.value.as_ref(),
            _ => None,
        },
        _ => None,
    }
}

/// `setArgAttr`: argument attribute `name` of argument `i` of `f` set to `value`.
pub(crate) fn set_func_arg_attr<'a>(b: &mut Body<'a>, f: OpId, i: usize, name: &str, value: Attribute<'a>) {
    let n = func_signature(b, f).0.len();
    let mut dicts: Vec<Vec<mlirformat::NamedAttr<'a>>> = match b[f].get("arg_attrs") {
        Some(Attribute::Array(ds)) => ds.iter().map(|d| if let Attribute::Dict(d) = d { d.clone() } else { Vec::new() }).collect(),
        _ => vec![Vec::new(); n],
    };
    dicts.resize(n, Vec::new());
    match dicts[i].iter_mut().find(|a| a.name == name) {
        Some(a) => a.value = Some(value),
        // A `DictionaryAttr` keeps its entries sorted by name.
        None => {
            let at = dicts[i].iter().position(|a| &*a.name > name).unwrap_or(dicts[i].len());
            dicts[i].insert(at, mlirformat::NamedAttr { name: String::from(name).into(), value: Some(value) });
        }
    }
    b[f].set("arg_attrs", Attribute::Array(dicts.into_iter().map(Attribute::Dict).collect()));
}

/// `removeArgAttr` of `name` from every argument of `f` (the attribute gone when all empty).
pub(crate) fn remove_func_arg_attr(b: &mut Body<'_>, f: OpId, name: &str) {
    let Some(Attribute::Array(ds)) = b[f].get("arg_attrs").cloned() else { return };
    let dicts: Vec<Attribute<'_>> = ds.into_iter().map(|d| match d {
        Attribute::Dict(mut d) => {
            d.retain(|a| a.name != name);
            Attribute::Dict(d)
        }
        d => d,
    }).collect();
    if dicts.iter().all(|d| matches!(d, Attribute::Dict(x) if x.is_empty())) {
        b[f].remove("arg_attrs");
    } else {
        b[f].set("arg_attrs", Attribute::Array(dicts));
    }
}

/// The callee `func.func` of `func.call` `call`.
pub(crate) fn callee(b: &Body<'_>, call: OpId) -> Option<OpId> {
    let Some(Attribute::SymbolRef(path)) = b[call].get("callee") else { return None };
    let mut table = b.parent_op(call)?;
    while !b.is_symbol_table(table) {
        table = b.parent_op(table)?;
    }
    b.lookup_path(table, path)?.last().copied().filter(|f| b[*f].name == "func.func")
}

/// `getFuncOpsOrderedByCalls`: the module's functions, each after the functions with tensor
/// signatures it calls; those in cycles apart.
pub(crate) fn funcs_by_calls(b: &Body<'_>, module: OpId) -> (Vec<OpId>, Vec<OpId>) {
    let funcs: Vec<OpId> = b[module].regions.iter().flat_map(|r| b[*r].blocks.iter()).flat_map(|blk| b[*blk].ops.iter().copied()).filter(|o| b[*o].name == "func.func").collect();
    let tensor_signature = |f: OpId| {
        let (i, r) = func_signature(b, f);
        i.iter().chain(&r).any(is_tensor)
    };
    let mut called_by: BTreeMap<OpId, Vec<OpId>> = BTreeMap::new();
    let mut count: BTreeMap<OpId, usize> = BTreeMap::new();
    for &f in &funcs {
        count.insert(f, 0);
        let mut calls = Vec::new();
        b.walk(f, &mut |o| {
            if b[o].name == "func.call" {
                calls.push(o);
            }
        });
        for c in calls {
            let Some(g) = callee(b, c) else { continue };
            if !tensor_signature(g) {
                continue;
            }
            let by = called_by.entry(g).or_default();
            if !by.contains(&f) {
                by.push(f);
                *count.get_mut(&f).expect("counted") += 1;
            }
        }
    }
    let mut work: Vec<OpId> = funcs.iter().copied().filter(|f| count[f] == 0).collect();
    let mut ordered = Vec::new();
    while let Some(f) = work.pop() {
        ordered.push(f);
        for caller in called_by.get(&f).cloned().unwrap_or_default() {
            if let Some(c) = count.get_mut(&caller) {
                *c -= 1;
                if *c == 0 {
                    work.push(caller);
                }
            }
        }
        count.remove(&f);
    }
    let remaining = funcs.into_iter().filter(|f| count.contains_key(f)).collect();
    (ordered, remaining)
}

/// The SSA names `printAsOperand` gives under an `AsmState` of a root op (`SSANameState`):
/// results numbered (generic form), entry block arguments `%argN` uniqued per region scope.
struct AsmNames {
    names: BTreeMap<ValueId, String>,
    ids: BTreeMap<ValueId, usize>,
    used: Vec<BTreeSet<String>>,
    next_value: usize,
    next_arg: usize,
    next_conflict: usize,
}

impl AsmNames {
    /// `sanitizeIdentifier`.
    fn sanitize(name: &str) -> String {
        let valid = |c: char| c.is_ascii_alphanumeric() || "$._-".contains(c);
        let copy = |out: &mut String| {
            for c in name.chars() {
                if valid(c) {
                    out.push(c);
                } else if c == ' ' {
                    out.push('_');
                } else {
                    out.push_str(&format!("{:X}", c as u32));
                }
            }
        };
        let first = name.chars().next().unwrap_or('_');
        let mut out = String::new();
        if first.is_ascii_digit() || (!valid(first) && first != ' ') {
            out.push('_');
            copy(&mut out);
            return out;
        }
        if name.chars().all(valid) {
            return name.into();
        }
        copy(&mut out);
        out
    }

    /// `setValueName`: numbered when unnamed, else uniqued in the scopes open.
    fn set(&mut self, v: ValueId, name: &str) {
        if name.is_empty() {
            self.ids.insert(v, self.next_value);
            self.next_value += 1;
            return;
        }
        let name = Self::sanitize(name);
        let taken = |s: &Self, n: &str| s.used.iter().any(|u| u.contains(n));
        let unique = if !taken(self, &name) {
            name
        } else {
            loop {
                let probe = format!("{name}_{}", self.next_conflict);
                self.next_conflict += 1;
                if !taken(self, &probe) {
                    break probe;
                }
            }
        };
        self.used.last_mut().expect("a scope").insert(unique.clone());
        self.names.insert(v, unique);
    }

    /// `numberValuesInOp`.
    fn number_op(&mut self, b: &Body<'_>, op: OpId) {
        // The fixtures print generic: `getAsmResultNames` is not asked.
        if let Some(r) = b[op].results.first()
            && !self.names.contains_key(r)
            && !self.ids.contains_key(r)
        {
            self.ids.insert(*r, self.next_value);
            self.next_value += 1;
        }
    }

    /// `numberValuesInRegion` / `numberValuesInBlock`.
    fn number_region(&mut self, b: &Body<'_>, r: RegionId) {
        for (k, blk) in b[r].blocks.iter().enumerate() {
            for a in b[*blk].args.iter() {
                if self.names.contains_key(a) || self.ids.contains_key(a) {
                    continue;
                }
                if k == 0 {
                    let n = format!("arg{}", self.next_arg);
                    self.next_arg += 1;
                    self.set(*a, &n);
                } else {
                    self.set(*a, "");
                }
            }
            for op in b[*blk].ops.iter() {
                self.number_op(b, *op);
            }
        }
    }

    /// `SSANameState(op)`: the names under an `AsmState` of `root`.
    fn of(b: &Body<'_>, root: OpId) -> Self {
        let mut s = Self { names: BTreeMap::new(), ids: BTreeMap::new(), used: vec![BTreeSet::new()], next_value: 0, next_arg: 0, next_conflict: 0 };
        // Generic form prints unique SSA ids: the counters carry across sibling regions.
        let mut stack: Vec<(RegionId, usize)> = b[root].regions.iter().map(|r| (*r, 1)).collect();
        s.number_op(b, root);
        while let Some((r, depth)) = stack.pop() {
            s.used.truncate(depth);
            s.used.push(BTreeSet::new());
            s.number_region(b, r);
            let d = s.used.len();
            for blk in b[r].blocks.iter() {
                for op in b[*blk].ops.iter() {
                    for nr in b[*op].regions.iter() {
                        stack.push((*nr, d));
                    }
                }
            }
        }
        s
    }

    /// `printAsOperand`: `%name`, `%N`, or `%N#k` for result `k` of a multi-result op.
    fn print(&self, b: &Body<'_>, v: ValueId) -> String {
        if let Some(n) = self.names.get(&v) {
            return format!("%{n}");
        }
        match b[v].def {
            Def::Result(op, k) => {
                let first = b[op].results[0];
                match self.ids.get(&first) {
                    Some(i) if b[op].results.len() > 1 => format!("%{i}#{k}"),
                    Some(i) => format!("%{i}"),
                    None => format!("%{}#{k}", self.names.get(&first).cloned().unwrap_or_default()),
                }
            }
            Def::Arg(..) => self.ids.get(&v).map_or_else(|| String::from("%<<UNKNOWN SSA VALUE>>"), |i| format!("%{i}")),
        }
    }
}

impl AnalysisState<'_> {
    /// `annotateOpsWithAliasSets` (`dump-alias-sets`): each op's tensor results' and block
    /// arguments' alias sets, by their SSA names under `root`.
    pub fn annotate_alias_sets(&self, b: &mut Body<'_>, root: OpId) {
        let names = AsmNames::of(b, root);
        let set = |b: &Body<'_>, v: ValueId| Attribute::Array(self.shot().alias.of(v).into_iter().map(|a| Attribute::str(&names.print(b, a))).collect());
        let mut ops = Vec::new();
        b.walk_post(root, &mut |op| ops.push(op));
        for op in ops {
            let results: Vec<Attribute<'_>> = b[op].results.iter().filter(|r| is_tensor(&b[**r].ty)).map(|r| set(b, *r)).collect();
            if !results.is_empty() {
                b[op].set("__opresult_alias_set_attr__", Attribute::Array(results));
            }
            let mut any = false;
            let regions: Vec<Attribute<'_>> = b[op]
                .regions
                .iter()
                .map(|r| {
                    Attribute::Array(
                        b[*r].blocks.iter().map(|blk| {
                            Attribute::Array(b[*blk].args.iter().filter(|a| is_tensor(&b[**a].ty)).map(|a| {
                                any = true;
                                set(b, *a)
                            }).collect())
                        }).collect(),
                    )
                })
                .collect();
            if any {
                b[op].set("__bbarg_alias_set_attr__", Attribute::Array(regions));
            }
        }
    }
}
