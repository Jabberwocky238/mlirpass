//! ⭐ Rewriting, as `mlir/IR/PatternMatch`: the [`Rewriter`] every change goes through, the
//! [`Listener`] it tells, and [`Pattern`]s.
//!
//! Notifications follow `RewriterBase` exactly, because the greedy driver's worklist order (and
//! so its output) depends on them: replacing a value tells each user it was modified, in MLIR's
//! use-list order (most recent use first); erasing an op erases its regions first (last region
//! first, blocks in post-order, ops in reverse), telling the listener about each op.

use alloc::boxed::Box;
use alloc::vec::Vec;

use mlirformat::Type;

use crate::{Body, BlockId, OpData, OpId, RegionId, ValueId};

/// Told about every change a [`Rewriter`] makes. `body` is the IR just before (erased) or just
/// after (the rest) the change.
pub trait Listener<'a> {
    fn inserted(&mut self, _body: &Body<'a>, _op: OpId) {}
    fn modified(&mut self, _body: &Body<'a>, _op: OpId) {}
    fn replaced(&mut self, _body: &Body<'a>, _op: OpId, _with: &[ValueId]) {}
    fn erased(&mut self, _body: &Body<'a>, _op: OpId) {}
    fn block_erased(&mut self, _body: &Body<'a>, _block: BlockId) {}
}

/// A listener that ignores everything.
pub struct Quiet;

impl Listener<'_> for Quiet {}

/// Where new ops go: before `before` in `block`, or at its end.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct InsertPoint {
    pub block: BlockId,
    pub before: Option<OpId>,
}

/// ⭐ A body being rewritten, its listener, and an insertion point.
pub struct Rewriter<'r, 'a> {
    pub body: &'r mut Body<'a>,
    listener: &'r mut dyn Listener<'a>,
    pub ip: Option<InsertPoint>,
}

impl<'r, 'a> Rewriter<'r, 'a> {
    pub fn new(body: &'r mut Body<'a>, listener: &'r mut dyn Listener<'a>) -> Self {
        Self { body, listener, ip: None }
    }

    // ---- insertion point -------------------------------------------------------------

    pub fn set_before(&mut self, op: OpId) {
        self.ip = Some(InsertPoint { block: self.body[op].parent.expect("op is not placed"), before: Some(op) });
    }

    pub fn set_after(&mut self, op: OpId) {
        let block = self.body[op].parent.expect("op is not placed");
        let ops = &self.body[block].ops;
        let next = ops.get(self.body.position(op) + 1).copied();
        self.ip = Some(InsertPoint { block, before: next });
    }

    pub fn set_start(&mut self, block: BlockId) {
        self.ip = Some(InsertPoint { block, before: self.body[block].ops.first().copied() });
    }

    pub fn set_end(&mut self, block: BlockId) {
        self.ip = Some(InsertPoint { block, before: None });
    }

    // ---- creation --------------------------------------------------------------------

    /// Places detached `op` at the insertion point and tells the listener.
    pub fn insert(&mut self, op: OpId) -> OpId {
        let ip = self.ip.expect("no insertion point");
        match ip.before {
            Some(b) => self.body.insert_before(op, b),
            None => self.body.insert(op, ip.block, None),
        }
        self.listener.inserted(self.body, op);
        op
    }

    /// ⭐ Builds an op at the insertion point.
    pub fn create(&mut self, data: OpData<'a>, types: &[Type<'a>]) -> OpId {
        let op = self.body.create(data, types);
        self.insert(op)
    }

    /// Builds an op with regions: `regions` fills them (on the body) before it is inserted, so
    /// the listener hears about the op once, whole.
    pub fn create_with(&mut self, data: OpData<'a>, types: &[Type<'a>], regions: impl FnOnce(&mut Body<'a>, OpId)) -> OpId {
        let op = self.body.create(data, types);
        regions(self.body, op);
        self.insert(op)
    }

    // ---- modification ----------------------------------------------------------------

    /// Changes `op` in place through `f`, then tells the listener.
    pub fn modify(&mut self, op: OpId, f: impl FnOnce(&mut Body<'a>)) {
        f(self.body);
        self.listener.modified(self.body, op);
    }

    /// Every use of `from` becomes `to`, each user told it was modified.
    pub fn replace_all_uses(&mut self, from: ValueId, to: ValueId) {
        // MLIR's use lists are most-recent-first.
        for u in self.body[from].uses.clone().into_iter().rev() {
            self.modify(u.op, |b| b.set_operand(u.op, u.index as usize, to));
        }
    }

    /// Uses of `from` for which `keep` is false become `to`.
    pub fn replace_uses_if(&mut self, from: ValueId, to: ValueId, mut pick: impl FnMut(&Body<'a>, crate::Use) -> bool) {
        for u in self.body[from].uses.clone().into_iter().rev() {
            if pick(self.body, u) {
                self.modify(u.op, |b| b.set_operand(u.op, u.index as usize, to));
            }
        }
    }

    /// `replaceAllOpUsesWith`: the listener hears of the replacement, then of each user.
    pub fn replace_op_uses(&mut self, op: OpId, with: &[ValueId]) {
        self.listener.replaced(self.body, op, with);
        for (r, w) in self.body[op].results.clone().into_iter().zip(with) {
            self.replace_all_uses(r, *w);
        }
    }

    /// ⭐ Replaces `op`'s results by `with` and erases it.
    pub fn replace_op(&mut self, op: OpId, with: &[ValueId]) {
        self.replace_op_uses(op, with);
        self.erase_op(op);
    }

    /// Replaces `op` by a new op built from `data`; returns it.
    pub fn replace_with(&mut self, op: OpId, data: OpData<'a>, types: &[Type<'a>]) -> OpId {
        self.set_before(op);
        let new = self.create(data, types);
        let results = self.body[new].results.clone();
        self.replace_op(op, &results);
        new
    }

    /// ⭐ Erases `op` and everything in it, telling the listener about each op.
    pub fn erase_op(&mut self, op: OpId) {
        if self.ip.is_some_and(|ip| ip.before == Some(op)) {
            self.set_after(op);
        }
        self.erase_tree(op);
    }

    fn erase_tree(&mut self, op: OpId) {
        for r in self.body[op].regions.clone().into_iter().rev() {
            while let Some(&front) = self.body[r].blocks.first() {
                let order = self.body.post_order(front);
                for b in &order {
                    for o in self.body[*b].ops.clone().into_iter().rev() {
                        self.erase_tree(o);
                    }
                }
                for b in order {
                    self.erase_block(b);
                }
            }
        }
        self.listener.erased(self.body, op);
        self.body.drop_result_uses(op);
        self.body.erase(op);
    }

    /// Erases `block` (its ops last first) and takes it out of its region.
    pub fn erase_block(&mut self, block: BlockId) {
        for o in self.body[block].ops.clone().into_iter().rev() {
            self.body.drop_result_uses(o);
            self.erase_op(o);
        }
        for a in self.body[block].args.clone() {
            self.body.drop_value_uses(a);
        }
        self.listener.block_erased(self.body, block);
        self.body.remove_block(block);
    }

    /// Moves `op` before `before` (or to the end of `block`), telling the listener it was inserted.
    pub fn move_before(&mut self, op: OpId, block: BlockId, before: Option<OpId>) {
        self.body.detach(op);
        match before {
            Some(b) => self.body.insert_before(op, b),
            None => self.body.insert(op, block, None),
        }
        self.listener.inserted(self.body, op);
    }

    /// `inlineBlockBefore`: `source`'s arguments become `args`, its ops move before `before` in
    /// `dest`, and `source` is erased.
    pub fn inline_block_before(&mut self, source: BlockId, dest: BlockId, before: Option<OpId>, args: &[ValueId]) {
        for (a, v) in self.body[source].args.clone().into_iter().zip(args) {
            self.replace_all_uses(a, *v);
        }
        for o in self.body[source].ops.clone() {
            self.move_before(o, dest, before);
        }
        if self.ip.is_some_and(|ip| ip.block == source) {
            self.ip = Some(InsertPoint { block: dest, before });
        }
        self.erase_block(source);
    }

    /// `mergeBlocks`: `source` appended to `dest`.
    pub fn merge_blocks(&mut self, source: BlockId, dest: BlockId, args: &[ValueId]) {
        self.inline_block_before(source, dest, None, args);
    }

    /// `inlineRegionBefore`: `region`'s blocks move into `into` before `before` (`None`: the end).
    pub fn inline_region_before(&mut self, region: RegionId, into: RegionId, before: Option<BlockId>) {
        let blocks = core::mem::take(&mut self.body[region].blocks);
        let at = before.map_or(self.body[into].blocks.len(), |b| self.body[into].blocks.iter().position(|x| *x == b).expect("block not in region"));
        for (i, b) in blocks.iter().enumerate() {
            self.body[*b].parent = Some(into);
            self.body.region_insert(into, at + i, *b);
        }
    }

    /// Tells the listener `op` was modified, without changing it.
    pub fn touched(&mut self, op: OpId) {
        self.listener.modified(self.body, op);
    }
}

/// ⭐ A rewrite pattern rooted at an op name (`None`: any op).
pub trait Pattern {
    /// The debug name `enable-patterns` / `disable-patterns` match against.
    fn name(&self) -> &str;

    fn root(&self) -> Option<&str>;

    fn benefit(&self) -> u16 {
        1
    }

    /// `matchAndRewrite`: whether it matched (and so rewrote).
    fn rewrite(&self, rw: &mut Rewriter<'_, '_>, op: OpId) -> bool;
}

/// Patterns ordered as `PatternApplicator` tries them: by benefit, highest first, stable.
#[derive(Default)]
pub struct PatternSet {
    patterns: Vec<Box<dyn Pattern>>,
}

impl PatternSet {
    pub fn add(&mut self, p: impl Pattern + 'static) -> &mut Self {
        self.patterns.push(Box::new(p));
        self
    }

    pub fn add_boxed(&mut self, p: Box<dyn Pattern>) -> &mut Self {
        self.patterns.push(p);
        self
    }

    /// Keeps the patterns `keep` accepts.
    pub fn retain(&mut self, keep: impl Fn(&dyn Pattern) -> bool) {
        self.patterns.retain(|p| keep(p.as_ref()));
    }

    /// The patterns for op `name`, in the order they are tried.
    pub fn for_op(&self, name: &str) -> Vec<&dyn Pattern> {
        let mut out: Vec<&dyn Pattern> = self.patterns.iter().map(Box::as_ref).filter(|p| p.root().is_none_or(|r| r == name)).collect();
        out.sort_by(|a, b| b.benefit().cmp(&a.benefit()));
        out
    }

    pub fn is_empty(&self) -> bool {
        self.patterns.is_empty()
    }
}

impl Body<'_> {
    /// Blocks reachable from `entry` in post-order (successors in order), as `llvm::post_order`.
    pub fn post_order(&self, entry: BlockId) -> Vec<BlockId> {
        let mut out = Vec::new();
        let mut seen = alloc::collections::BTreeSet::from([entry]);
        let mut stack = alloc::vec![(entry, 0usize)];
        while let Some((b, i)) = stack.pop() {
            match self.successors(b).get(i) {
                Some(s) => {
                    stack.push((b, i + 1));
                    if seen.insert(*s) {
                        stack.push((*s, 0));
                    }
                }
                None => out.push(b),
            }
        }
        out
    }

    /// Every use of `v` points nowhere any more (its users are about to go too).
    pub fn drop_value_uses(&mut self, v: ValueId) {
        for u in core::mem::take(&mut self[v].uses) {
            // The operand stays, dangling; its owner is being erased.
            let _ = u;
        }
    }

    /// `dropAllUses` on `op`'s results.
    pub fn drop_result_uses(&mut self, op: OpId) {
        for r in self[op].results.clone() {
            self.drop_value_uses(r);
        }
    }

    /// Takes `block` out of its region (it must be empty of uses).
    pub fn remove_block(&mut self, block: BlockId) {
        if let Some(r) = self[block].parent.take() {
            self[r].blocks.retain(|b| *b != block);
        }
    }

    pub fn region_insert(&mut self, region: RegionId, at: usize, block: BlockId) {
        self[region].blocks.insert(at, block);
    }
}
