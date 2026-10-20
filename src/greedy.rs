//! ⭐ `applyPatternsGreedily`, as `GreedyPatternRewriteDriver.cpp` (region driver).
//!
//! Each iteration: collect the ops (top-down: preorder, then reversed; else postorder),
//! uniquing and hoisting constants on the way (`OperationFolder::insertKnownConstant`); erase
//! unreachable blocks; pop ops — erase if trivially dead, else fold, else try the patterns;
//! then simplify regions. Repeat while anything changed, up to `max_iterations`.

use alloc::collections::BTreeMap;
use alloc::string::String;
use alloc::vec::Vec;

use mlirformat::{Attribute, Type};

use crate::{Body, Fold, Folded, Listener, OpId, PatternSet, RegionId, Rewriter, Trait};

/// `GreedySimplifyRegionLevel`.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum RegionSimplify {
    Disabled,
    Normal,
    Aggressive,
}

/// `GreedyRewriteConfig`.
#[derive(Debug, Clone, Copy)]
pub struct GreedyConfig {
    pub top_down: bool,
    pub region_simplify: RegionSimplify,
    /// `None`: no limit.
    pub max_iterations: Option<u64>,
    pub max_rewrites: Option<u64>,
    pub fold: bool,
    pub cse_constants: bool,
}

impl Default for GreedyConfig {
    fn default() -> Self {
        Self { top_down: true, region_simplify: RegionSimplify::Normal, max_iterations: Some(10), max_rewrites: None, fold: true, cse_constants: true }
    }
}

/// The worklist: pushing an op already there does nothing; pops come from the back.
#[derive(Default)]
struct Worklist {
    list: Vec<Option<OpId>>,
    at: BTreeMap<OpId, usize>,
}

impl Worklist {
    fn push(&mut self, op: OpId) {
        if self.at.contains_key(&op) {
            return;
        }
        self.at.insert(op, self.list.len());
        self.list.push(Some(op));
    }

    fn pop(&mut self) -> Option<OpId> {
        while let Some(slot) = self.list.pop() {
            if let Some(op) = slot {
                self.at.remove(&op);
                return Some(op);
            }
        }
        None
    }

    fn remove(&mut self, op: OpId) {
        if let Some(i) = self.at.remove(&op) {
            self.list[i] = None;
        }
    }

    fn reverse(&mut self) {
        self.list.reverse();
        let n = self.list.len();
        for (i, slot) in self.list.iter().enumerate() {
            if let Some(op) = slot {
                self.at.insert(*op, i);
            }
        }
        debug_assert_eq!(n, self.list.len());
    }

    fn clear(&mut self) {
        self.list.clear();
        self.at.clear();
    }
}

/// The driver's listener: keeps the worklist in step with the IR.
struct Tracker {
    worklist: Worklist,
    scope: RegionId,
}

impl Tracker {
    /// `addToWorklist`: `op` and its ancestors, if it is inside the scope.
    fn add(&mut self, body: &Body<'_>, op: OpId) {
        let mut chain = Vec::new();
        let mut at = op;
        loop {
            chain.push(at);
            let Some(region) = body[at].parent.and_then(|b| body[b].parent) else { return };
            if region == self.scope {
                chain.into_iter().for_each(|o| self.worklist.push(o));
                return;
            }
            at = body[region].parent;
        }
    }

    /// The defining ops of `op`'s operands that have at most one other user.
    fn add_operands(&mut self, body: &Body<'_>, op: OpId) {
        for v in &body[op].operands {
            let Some(def) = body.def_op(*v) else { continue };
            let mut other = None;
            let mut many = false;
            for u in body[*v].uses.iter().rev() {
                if u.op == op || Some(u.op) == other {
                    continue;
                }
                if other.is_none() {
                    other = Some(u.op);
                    continue;
                }
                many = true;
                break;
            }
            if !many {
                self.add(body, def);
            }
        }
    }
}

impl<'a> Listener<'a> for Tracker {
    fn inserted(&mut self, body: &Body<'a>, op: OpId) {
        self.add(body, op);
    }

    fn modified(&mut self, body: &Body<'a>, op: OpId) {
        self.add(body, op);
    }

    fn erased(&mut self, body: &Body<'a>, op: OpId) {
        self.add_operands(body, op);
        self.worklist.remove(op);
    }
}

/// `OperationFolder`'s constant table for one iteration.
#[derive(Default)]
struct Folder<'a> {
    /// (insertion region, dialect, value, type) ⇒ the constant kept.
    known: Vec<(RegionId, String, Attribute<'a>, Type<'a>, OpId)>,
}

impl<'a> Folder<'a> {
    fn owns(&self, op: OpId) -> bool {
        self.known.iter().any(|k| k.4 == op)
    }

    /// `insertKnownConstant`: false when `op` was a duplicate, now replaced and erased.
    fn insert(&mut self, rw: &mut Rewriter<'_, 'a>, op: OpId, value: Attribute<'a>) -> bool {
        let block = rw.body[op].parent.expect("placed");
        let prev_owned = |f: &Self, b: &Body<'a>| {
            let i = b.position(op);
            i > 0 && f.owns(b[block].ops[i - 1])
        };
        if self.owns(op) {
            if rw.body[block].ops.first() != Some(&op) && !prev_owned(self, rw.body) {
                let front = rw.body[block].ops[0];
                rw.body.detach(op);
                rw.body.insert_before(op, front);
                rw.body[op].loc = Some("unknown".into());
            }
            return true;
        }
        let region = rw.body.insertion_region(block);
        let dialect: String = rw.body[op].name.split_once('.').map_or(&*rw.body[op].name, |(ns, _)| ns).into();
        let ty = rw.body[rw.body[op].results[0]].ty.clone();
        if let Some(existing) = self.known.iter().find(|k| k.0 == region && k.1 == dialect && k.2 == value && k.3 == ty).map(|k| k.4) {
            let results = rw.body[existing].results.clone();
            rw.replace_op(op, &results);
            rw.body[existing].loc = Some("unknown".into());
            return false;
        }
        let entry = rw.body[region].blocks[0];
        if block != entry {
            let front = rw.body[entry].ops.first().copied();
            rw.body.detach(op);
            match front {
                Some(f) => rw.body.insert_before(op, f),
                None => rw.body.insert(op, entry, None),
            }
            rw.body[op].loc = Some("unknown".into());
        } else if rw.body[entry].ops.first() != Some(&op) && !prev_owned(self, rw.body) {
            let front = rw.body[entry].ops[0];
            rw.body.detach(op);
            rw.body.insert_before(op, front);
        }
        self.known.push((region, dialect, value, ty, op));
        true
    }
}

impl<'a> Body<'a> {
    /// `getInsertionRegion`: where constants for an op in `block` go.
    pub fn insertion_region(&self, mut block: crate::BlockId) -> RegionId {
        loop {
            let region = self[block].parent.expect("block not in a region");
            let parent = self[region].parent;
            if self.might_have(parent, Trait::IsIsolatedFromAbove) || self[parent].parent.is_none() || self[parent].name == "test.one_region_op" {
                return region;
            }
            block = self[parent].parent.expect("placed");
        }
    }

    /// `applyOpPatternsGreedily(ops, patterns)`: one pass over a worklist seeded with `ops`,
    /// scoped to their closest common region.
    pub fn apply_op_patterns_greedily(&mut self, ops: &[OpId], patterns: &PatternSet) {
        let regions = |op: OpId| {
            let mut out = Vec::new();
            let mut at = op;
            while let Some(r) = self[at].parent.and_then(|b| self[b].parent) {
                out.push(r);
                at = self[r].parent;
            }
            out
        };
        let Some(first) = ops.first() else { return };
        let all: Vec<Vec<RegionId>> = ops.iter().map(|o| regions(*o)).collect();
        let Some(scope) = regions(*first).into_iter().find(|r| all.iter().all(|c| c.contains(r))) else { return };
        let mut tracker = Tracker { worklist: Worklist::default(), scope };
        ops.iter().for_each(|o| tracker.worklist.push(*o));
        self.process(&mut tracker, patterns, &GreedyConfig::default());
    }

    /// ⭐ `applyPatternsGreedily(region, patterns, config)`; whether it converged.
    pub fn apply_greedily(&mut self, region: RegionId, patterns: &PatternSet, config: &GreedyConfig) -> bool {
        let mut tracker = Tracker { worklist: Worklist::default(), scope: region };
        let mut iteration = 0u64;
        loop {
            iteration += 1;
            if config.max_iterations.is_some_and(|m| iteration > m) {
                return false;
            }
            tracker.worklist.clear();
            let mut folder = Folder::default();
            self.collect(region, config, &mut tracker, &mut folder);
            if config.top_down {
                tracker.worklist.reverse();
            }
            let mut again = Rewriter::new(self, &mut tracker).erase_unreachable_blocks(&[region]);
            again |= self.process(&mut tracker, patterns, config);
            if config.region_simplify != RegionSimplify::Disabled {
                again |= self.simplify_regions(&[region], config.region_simplify == RegionSimplify::Aggressive);
            }
            if !again {
                return true;
            }
        }
    }

    /// The initial walk (preorder when top-down, else postorder): every op goes on the
    /// worklist, but a constant that duplicates a known one is replaced by it and skipped.
    fn collect(&mut self, region: RegionId, config: &GreedyConfig, tracker: &mut Tracker, folder: &mut Folder<'a>) {
        for b in self[region].blocks.clone() {
            for op in self[b].ops.clone() {
                if config.top_down {
                    if !self.duplicate_constant(op, config, tracker, folder) {
                        tracker.add(self, op);
                        self.collect_nested(op, config, tracker, folder);
                    }
                } else {
                    self.collect_nested(op, config, tracker, folder);
                    if !self.duplicate_constant(op, config, tracker, folder) {
                        tracker.add(self, op);
                    }
                }
            }
        }
    }

    /// Uniques constant `op` in the folder; true when it was a duplicate (and is gone).
    fn duplicate_constant(&mut self, op: OpId, config: &GreedyConfig, tracker: &mut Tracker, folder: &mut Folder<'a>) -> bool {
        let Some(value) = config.cse_constants.then(|| self.constant_value(op)).flatten() else { return false };
        !folder.insert(&mut Rewriter::new(self, tracker), op, value)
    }

    fn collect_nested(&mut self, op: OpId, config: &GreedyConfig, tracker: &mut Tracker, folder: &mut Folder<'a>) {
        for r in self[op].regions.clone() {
            self.collect(r, config, tracker, folder);
        }
    }

    /// `processWorklist`; whether anything changed.
    fn process(&mut self, tracker: &mut Tracker, patterns: &PatternSet, config: &GreedyConfig) -> bool {
        let mut changed = false;
        let mut rewrites = 0u64;
        while config.max_rewrites.is_none_or(|m| rewrites < m) {
            let Some(op) = tracker.worklist.pop() else { break };
            if self.is_trivially_dead(op) {
                Rewriter::new(self, tracker).erase_op(op);
                changed = true;
                continue;
            }
            if config.fold && !self.has(op, Trait::ConstantLike) {
                match self.fold(op) {
                    Fold::Failed => {}
                    Fold::InPlace => {
                        tracker.add(self, op);
                        changed = true;
                        continue;
                    }
                    Fold::Results(results) => {
                        if self.replace_folded(op, results, tracker) {
                            changed = true;
                            continue;
                        }
                    }
                }
            }
            let name = self[op].name.clone();
            let mut rw = Rewriter::new(self, tracker);
            for p in patterns.for_op(&name) {
                if p.rewrite(&mut rw, op) {
                    changed = true;
                    rewrites += 1;
                    break;
                }
            }
        }
        changed
    }

    /// Materializes `results` before `op` and replaces it; false (nothing changed) when a
    /// constant cannot be materialized.
    fn replace_folded(&mut self, op: OpId, results: Vec<Folded<'a>>, tracker: &mut Tracker) -> bool {
        let name = self[op].name.clone();
        let types = self.types(&self[op].results.clone());
        let loc = self[op].loc.clone();
        let mut rw = Rewriter::new(self, tracker);
        rw.set_before(op);
        let mut values = Vec::new();
        let mut made = Vec::new();
        for (r, ty) in results.into_iter().zip(&types) {
            match r {
                Folded::Value(v) => values.push(v),
                Folded::Attr(a) => match rw.body.materialize(&name, &a, ty) {
                    Some(data) => {
                        let c = rw.create(crate::OpData { loc: loc.clone(), ..data }, core::slice::from_ref(ty));
                        made.push(c);
                        values.push(rw.body[c].results[0]);
                    }
                    None => {
                        made.into_iter().for_each(|c| rw.erase_op(c));
                        return false;
                    }
                },
            }
        }
        rw.replace_op(op, &values);
        true
    }
}
