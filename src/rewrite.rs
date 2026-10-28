//! ⭐ Rewriting, as `mlir/IR/PatternMatch`: the [`Rewriter`] every change goes through, the
//! [`Listener`] it tells, and [`Pattern`]s.
//!
//! Notifications follow `RewriterBase` exactly, because the greedy driver's worklist order (and
//! so its output) depends on them: replacing a value tells each user it was modified, in MLIR's
//! use-list order (most recent use first); erasing an op erases its regions first (last region
//! first, blocks in post-order, ops in reverse), telling the listener about each op.

use alloc::boxed::Box;
use alloc::vec;
use alloc::vec::Vec;

use mlirformat::Type;

use crate::{Body, BlockId, OpData, OpId, RegionId, TypedOp, ValueId};

/// Told about every change a [`Rewriter`] makes. `body` is the IR just before (erased) or just
/// after (the rest) the change.
pub trait Listener<'a> {
    /// A new op was placed.
    fn inserted(&mut self, _body: &Body<'a>, _op: OpId) {}
    /// A placed op moved; the greedy driver treats it as inserted.
    fn moved(&mut self, body: &Body<'a>, op: OpId) {
        self.inserted(body, op)
    }
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
pub struct Rewriter<'r, 'a, L: Listener<'a> + ?Sized = dyn Listener<'a> + 'r> {
    pub body: &'r mut Body<'a>,
    pub listener: &'r mut L,
    pub ip: Option<InsertPoint>,
}

impl<'r, 'a> Rewriter<'r, 'a> {
    pub fn new(body: &'r mut Body<'a>, listener: &'r mut dyn Listener<'a>) -> Self {
        Self { body, listener, ip: None }
    }
}

impl<'r, 'a, L: Listener<'a>> Rewriter<'r, 'a, L> {
    /// A rewriter whose listener keeps its concrete type.
    pub fn typed(body: &'r mut Body<'a>, listener: &'r mut L) -> Self {
        Self { body, listener, ip: None }
    }
}

impl<'r, 'a, L: Listener<'a> + ?Sized> Rewriter<'r, 'a, L> {
    /// An op built with its regions' contents first, as builders with body callbacks do: the
    /// nested ops are created (and reported) before the op is inserted.
    pub fn with_body(&mut self, data: OpData<'a>, types: &[Type<'a>], blocks: &[Vec<Type<'a>>], fill: &mut dyn FnMut(&mut Self, usize, &[ValueId])) -> OpId {
        let op = self.body.create(data, types);
        let mut made = Vec::new();
        for args in blocks {
            let r = self.body.add_region(op);
            let a: Vec<_> = args.iter().map(|t| (t.clone(), None)).collect();
            made.push(self.body.add_block(r, &a));
        }
        let saved = self.ip;
        for (k, blk) in made.into_iter().enumerate() {
            self.set_end(blk);
            let args = self.body[blk].args.clone();
            fill(self, k, &args);
        }
        self.ip = saved;
        self.insert(op)
    }

    /// `scf::ForOp::create` with a body builder returning what it yields.
    pub fn build_for(&mut self, lb: ValueId, ub: ValueId, step: ValueId, inits: &[ValueId], body: &mut dyn FnMut(&mut Self, ValueId, &[ValueId]) -> Vec<ValueId>) -> OpId {
        let types = self.body.types(inits);
        let mut ops = vec![lb, ub, step];
        ops.extend(inits);
        let mut args = vec![Type::Index];
        args.extend(types.clone());
        self.with_body(OpData::build("scf.for").operands(&ops), &types, &[args], &mut |rw, _, a| {
            let y = body(rw, a[0], &a[1..]);
            rw.create(OpData::build("scf.yield").operands(&y), &[]);
        })
    }

    /// `scf::IfOp::create` with only a then builder: the else region stays empty.
    pub fn build_if_then(&mut self, cond: ValueId, then: &mut dyn FnMut(&mut Self)) -> OpId {
        let op = self.body.create(OpData::build("scf.if").operands(&[cond]), &[]);
        let r = self.body.add_region(op);
        self.body.add_region(op);
        let blk = self.body.add_block(r, &[]);
        let saved = self.ip;
        self.set_end(blk);
        then(self);
        self.create(OpData::build("scf.yield"), &[]);
        self.ip = saved;
        self.insert(op)
    }

    /// `scf::IfOp::create` with then and else builders.
    pub fn build_if(&mut self, cond: ValueId, types: &[Type<'a>], then: &mut dyn FnMut(&mut Self) -> Option<ValueId>, other: &mut dyn FnMut(&mut Self) -> Option<ValueId>) -> OpId {
        self.with_body(OpData::build("scf.if").operands(&[cond]), types, &[Vec::new(), Vec::new()], &mut |rw, k, _| {
            let v = if k == 0 { then(rw) } else { other(rw) };
            rw.create(OpData::build("scf.yield").operands(&v.into_iter().collect::<Vec<_>>()), &[]);
        })
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

    /// ⭐ Builds mlirformat's typed op `op` at the insertion point.
    pub fn emit(&mut self, op: &impl TypedOp) -> OpId {
        let (data, types) = op.split();
        self.create(data, &types)
    }

    /// `createOrFold`: builds an op at the insertion point and folds it; when the fold yields
    /// values (constants materialized in its place) the op goes again, unannounced.
    pub fn create_or_fold(&mut self, data: OpData<'a>, types: &[Type<'a>]) -> Vec<ValueId> {
        let op = self.body.create(data, types);
        let ip = self.ip.expect("no insertion point");
        match ip.before {
            Some(b) => self.body.insert_before(op, b),
            None => self.body.insert(op, ip.block, None),
        }
        // `tryFold`: a constant stays as built.
        let constant = self.body.has(op, crate::Trait::ConstantLike);
        if !constant && let crate::Fold::Results(folded) = self.body.fold(op) {
            let name = alloc::string::String::from(&*self.body[op].name);
            let mut out = Vec::new();
            let mut constants = Vec::new();
            let mut ok = true;
            for (f, r) in folded.into_iter().zip(self.body[op].results.clone()) {
                match f {
                    crate::Folded::Value(v) => out.push(v),
                    crate::Folded::Attr(a) => {
                        let ty = self.body[r].ty.clone();
                        match self.body.materialize(&name, &a, &ty) {
                            Some(d) => {
                                let loc = self.body[op].loc.clone();
                                let c = self.body.create(OpData { loc, ..d }, &[ty]);
                                out.push(self.body[c].results[0]);
                                constants.push(c);
                            }
                            None => ok = false,
                        }
                    }
                }
            }
            if ok && !out.is_empty() {
                for c in constants {
                    self.body.insert_before(c, op);
                    self.listener.inserted(self.body, c);
                }
                self.body.erase(op);
                return out;
            }
        }
        self.listener.inserted(self.body, op);
        self.body[op].results.clone()
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

    /// [`Rewriter::replace_with`] mlirformat's typed op `with`.
    pub fn replace_by(&mut self, op: OpId, with: &impl TypedOp) -> OpId {
        let (data, types) = with.split();
        self.replace_with(op, data, &types)
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
        self.listener.moved(self.body, op);
    }

    /// `inlineBlockBefore`: `source`'s arguments become `args`, its ops move before `before` in
    /// `dest`, and `source` is erased.
    pub fn inline_block_before(&mut self, source: BlockId, dest: BlockId, before: Option<OpId>, args: &[ValueId]) {
        for (a, v) in self.body[source].args.clone().into_iter().zip(args) {
            self.replace_all_uses(a, *v);
        }
        let at = before.map(|b| self.body.position(b));
        let n = self.body[source].ops.len();
        for o in self.body.splice(source, 0..n, dest, at) {
            self.listener.moved(self.body, o);
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

    /// Tells the listener `op` was inserted (it is already placed).
    pub fn notify_inserted(&mut self, op: OpId) {
        self.listener.inserted(self.body, op);
    }

    /// Splits `block` before `at`: the ops from `at` on move to a new block right after it.
    pub fn split_block(&mut self, block: BlockId, at: OpId) -> BlockId {
        let region = self.body[block].parent.expect("block not in a region");
        let new = self.body.add_block(region, &[]);
        let pos = self.body[region].blocks.iter().position(|b| *b == block).expect("block not in region");
        self.body[region].blocks.pop();
        self.body[region].blocks.insert(pos + 1, new);
        // Moved in one go; the listener still hears of each op, as `RewriterBase::splitBlock` tells it.
        let i = self.body.position(at);
        let n = self.body[block].ops.len();
        for o in self.body.splice(block, i..n, new, None) {
            self.listener.moved(self.body, o);
        }
        new
    }

    /// `createBlock`: a new block with arguments of `types` at the end of `region`; the
    /// insertion point moves to its end.
    pub fn create_block(&mut self, region: RegionId, types: &[Type<'a>]) -> BlockId {
        let args: Vec<_> = types.iter().map(|t| (t.clone(), None)).collect();
        let b = self.body.add_block(region, &args);
        self.set_end(b);
        b
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

/// Patterns ordered as `PatternApplicator` tries them: by benefit, highest first, stable. Kept
/// in that order as they are added, so [`PatternSet::for_op`] just filters.
#[derive(Default)]
pub struct PatternSet {
    /// Each with its place in that order: benefit (highest first), then op-specific before any-op.
    patterns: Vec<((core::cmp::Reverse<u16>, bool), Box<dyn Pattern>)>,
}

impl PatternSet {
    pub fn add(&mut self, p: impl Pattern + 'static) -> &mut Self {
        self.add_boxed(Box::new(p))
    }

    /// Goes after every pattern tried before it or alongside it (stable).
    pub fn add_boxed(&mut self, p: Box<dyn Pattern>) -> &mut Self {
        let key = (core::cmp::Reverse(p.benefit()), p.root().is_none());
        let at = self.patterns.partition_point(|q| q.0 <= key);
        self.patterns.insert(at, (key, p));
        self
    }

    /// Keeps the patterns `keep` accepts.
    pub fn retain(&mut self, keep: impl Fn(&dyn Pattern) -> bool) {
        self.patterns.retain(|p| keep(p.1.as_ref()));
    }

    /// The patterns for op `name`, in the order they are tried.
    pub fn for_op<'s>(&'s self, name: &'s str) -> impl Iterator<Item = &'s dyn Pattern> {
        self.patterns.iter().map(|p| p.1.as_ref()).filter(move |p| p.root().is_none_or(|r| r == name))
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
