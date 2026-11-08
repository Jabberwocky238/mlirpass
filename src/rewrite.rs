//! ⭐ Rewriting, as `mlir/IR/PatternMatch`: the [`Rewriter`] every change goes through, the
//! [`Listener`] it tells, and [`Pattern`]s.
//!
//! Notifications follow `RewriterBase` exactly, because the greedy driver's worklist order (and
//! so its output) depends on them: replacing a value tells each user it was modified, in MLIR's
//! use-list order (most recent use first); erasing an op erases its regions first (last region
//! first, blocks in post-order, ops in reverse), telling the listener about each op.

use alloc::vec;
use alloc::boxed::Box;
use alloc::collections::BTreeMap;
use alloc::string::String;
use alloc::vec::Vec;
use mlirformat::{Type, Attribute};
use crate::{Mapping, Body, BlockId, OpData, OpId, RegionId, TypedOp, ValueId, Fold, Folded, Trait};

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
    /// Whether replacing `op` by `with` (erasing it: `with` empty) is recorded rather than
    /// done; the conversion driver records them while a rewrite pattern runs.
    fn record_replacement(&mut self, _body: &Body<'a>, _op: OpId, _with: &[ValueId]) -> bool {
        false
    }
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
    /// The location new ops get when built without one (`op->getLoc()` of the op a pattern
    /// rewrites): the drivers set it to the root op's before calling a pattern.
    pub loc: Option<mlirformat::Str<'a>>,
}

impl<'r, 'a> Rewriter<'r, 'a> {
    pub fn new(body: &'r mut Body<'a>, listener: &'r mut dyn Listener<'a>) -> Self {
        Self { body, listener, ip: None, loc: None }
    }
}

impl<'r, 'a, L: Listener<'a>> Rewriter<'r, 'a, L> {
    /// A rewriter whose listener keeps its concrete type.
    pub fn typed(body: &'r mut Body<'a>, listener: &'r mut L) -> Self {
        Self { body, listener, ip: None, loc: None }
    }
}

impl<'r, 'a, L: Listener<'a> + ?Sized> Rewriter<'r, 'a, L> {
    /// ⭐ A DRR pattern's location for what it builds: `rewriter.getFusedLoc` of the ops its source DAG matched
    /// (`tblgen_ops`: the root first, then its operands' ops depth first), as `FusedLoc::get` makes it.
    pub fn fuse_locs(&mut self, ops: &[OpId]) {
        let locs: Vec<Option<&str>> = ops.iter().map(|o| self.body[*o].loc.as_deref()).collect();
        self.loc = Some(fused_loc(&locs).into());
    }

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
        let next = self.body.next_op(op);
        self.ip = Some(InsertPoint { block, before: next });
    }

    pub fn set_start(&mut self, block: BlockId) {
        self.ip = Some(InsertPoint { block, before: self.body.first_op(block) });
    }

    pub fn set_end(&mut self, block: BlockId) {
        self.ip = Some(InsertPoint { block, before: None });
    }

    // ---- creation --------------------------------------------------------------------

    /// Places detached `op` at the insertion point and tells the listener. `op` and the ops its
    /// regions already hold (built with it, [`Self::create_with`]) that have no location take the
    /// rewriter's ([`Self::loc`]: the matched op's, or what the pattern set), as C++ builds them all
    /// through one builder at that location; a location set explicitly stays.
    pub fn insert(&mut self, op: OpId) -> OpId {
        let ip = self.ip.expect("no insertion point");
        self.stamp(op);
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
        self.stamp(op);
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
        self.body[op].results.clone().to_vec()
    }

    /// Gives `op` and the ops nested in it that have no location the rewriter's.
    fn stamp(&mut self, op: OpId) {
        if self.loc.is_none() {
            return;
        }
        let mut bare = Vec::new();
        self.body.walk(op, &mut |o| bare.push(o));
        for o in bare {
            if self.body[o].loc.is_none() {
                self.body[o].loc.clone_from(&self.loc);
            }
        }
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
        if self.listener.record_replacement(self.body, op, with) {
            if self.ip.is_some_and(|ip| ip.before == Some(op)) {
                self.set_after(op);
            }
            return;
        }
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
        if self.listener.record_replacement(self.body, op, &[]) {
            return;
        }
        self.erase_tree(op);
    }

    fn erase_tree(&mut self, op: OpId) {
        for r in self.body[op].regions.clone().into_iter().rev() {
            while let Some(&front) = self.body[r].blocks.first() {
                let order = self.body.post_order(front);
                for b in &order {
                    for o in self.body.block_ops(*b).into_iter().rev() {
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
        for o in self.body.block_ops(block).into_iter().rev() {
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
        for o in self.body.splice(source, None, dest, before) {
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
        for o in self.body.splice(block, Some(at), new, None) {
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
pub trait Pattern: Send + Sync {
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

/// What a lowering needs of its rewriter: the greedy one and the conversion one both do.
pub trait Build<'a> {
    fn body(&self) -> &Body<'a>;
    /// A new op at the insertion point.
    fn make(&mut self, data: OpData<'a>, types: &[Type<'a>]) -> OpId;
    fn replace(&mut self, op: OpId, values: &[ValueId]);
    fn remove(&mut self, op: OpId);
    fn before(&mut self, op: OpId);

    fn make1(&mut self, data: OpData<'a>, ty: Type<'a>) -> ValueId {
        let o = self.make(data, &[ty]);
        self.body()[o].results[0]
    }
}

impl<'a> Build<'a> for Rewriter<'_, 'a> {
    fn body(&self) -> &Body<'a> {
        self.body
    }
    fn make(&mut self, data: OpData<'a>, types: &[Type<'a>]) -> OpId {
        self.create(data, types)
    }
    fn replace(&mut self, op: OpId, values: &[ValueId]) {
        self.replace_op(op, values);
    }
    fn remove(&mut self, op: OpId) {
        self.erase_op(op);
    }
    fn before(&mut self, op: OpId) {
        self.set_before(op);
    }
}

impl<'a> Build<'a> for crate::ConversionRewriter<'_, 'a, '_> {
    fn body(&self) -> &Body<'a> {
        self.rw.body
    }
    fn make(&mut self, data: OpData<'a>, types: &[Type<'a>]) -> OpId {
        self.rw.create(data, types)
    }
    fn replace(&mut self, op: OpId, values: &[ValueId]) {
        self.replace_values(op, values);
    }
    fn remove(&mut self, op: OpId) {
        self.erase(op);
    }
    fn before(&mut self, op: OpId) {
        self.rw.set_before(op);
    }
}

// ============================================================================================
// ⭐ `applyPatternsGreedily`, as `GreedyPatternRewriteDriver.cpp` (region driver).
//
// Each iteration: collect the ops (top-down: preorder, then reversed; else postorder),
// uniquing and hoisting constants on the way (`OperationFolder::insertKnownConstant`); erase
// unreachable blocks; pop ops — erase if trivially dead, else fold, else try the patterns;
// then simplify regions. Repeat while anything changed, up to `max_iterations`.

/// `GreedySimplifyRegionLevel`.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum RegionSimplify {
    Disabled,
    Normal,
    Aggressive,
}

impl core::str::FromStr for RegionSimplify {
    type Err = ();
    fn from_str(s: &str) -> Result<Self, ()> {
        match s {
            "disabled" => Ok(Self::Disabled),
            "normal" => Ok(Self::Normal),
            "aggressive" => Ok(Self::Aggressive),
            _ => Err(()),
        }
    }
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
            b.prev_op(op).is_some_and(|p| f.owns(p))
        };
        if self.owns(op) {
            if rw.body.first_op(block) != Some(op) && !prev_owned(self, rw.body) {
                let front = rw.body.first_op(block).expect("an op in the block");
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
            let front = rw.body.first_op(entry);
            rw.body.detach(op);
            match front {
                Some(f) => rw.body.insert_before(op, f),
                None => rw.body.insert(op, entry, None),
            }
            rw.body[op].loc = Some("unknown".into());
        } else if rw.body.first_op(entry) != Some(op) && !prev_owned(self, rw.body) {
            let front = rw.body.first_op(entry).expect("an op in the block");
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

    /// `walkAndApplyPatterns(op, patterns)`: one post-order walk of the ops nested in `op`,
    /// each tried once against `patterns` (highest benefit first, the first that matches
    /// wins); no folding, no dead-code erasure, and ops a rewrite creates are not visited.
    /// Whether a pattern matched (a pass that walks again until nothing does).
    pub fn walk_and_apply(&mut self, op: OpId, patterns: &PatternSet) -> bool {
        let mut matched = false;
        let mut ops = Vec::new();
        self.walk_post(op, &mut |o| ops.push(o));
        ops.pop();
        let mut quiet = crate::Quiet;
        for o in ops {
            if self[o].parent.is_none() {
                continue;
            }
            let name = self[o].name.clone();
            let loc = self[o].loc.clone();
            let mut rw = Rewriter::new(self, &mut quiet);
            rw.loc = loc;
            for p in patterns.for_op(&name) {
                if p.rewrite(&mut rw, o) {
                    matched = true;
                    break;
                }
            }
        }
        matched
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
            for op in self.block_ops(b) {
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
            let loc = self[op].loc.clone();
            let mut rw = Rewriter::new(self, tracker);
            rw.loc = loc;
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

impl<'r, 'a, L: crate::Listener<'a> + ?Sized> crate::Rewriter<'r, 'a, L> {
    /// `OpBuilder::clone`: a copy at the insertion point; the listener hears of it and of every
    /// op inside it.
    pub fn clone(&mut self, op: OpId, map: &mut Mapping) -> OpId {
        let c = self.body.clone_op(op, map);
        self.insert(c);
        for nested in self.body.ops_in(c).into_iter().skip(1) {
            self.notify_inserted(nested);
        }
        c
    }

    /// `cloneRegionBefore`.
    pub fn clone_region_before(&mut self, from: crate::RegionId, into: crate::RegionId, before: Option<crate::BlockId>, map: &mut Mapping) {
        let made = self.body.clone_region_into(from, into, before, map);
        for b in made {
            for o in self.body.block_ops(b) {
                for nested in self.body.ops_in(o) {
                    self.notify_inserted(nested);
                }
            }
        }
    }

    /// `eraseOpResults`: `op` rebuilt without the results in `erase`, its regions moved over.
    pub fn erase_op_results(&mut self, op: OpId, erase: &[usize]) -> OpId {
        let d = &self.body[op];
        let types: Vec<_> = d.results.iter().enumerate().filter(|(i, _)| !erase.contains(i)).map(|(_, r)| self.body[*r].ty.clone()).collect();
        let data = OpData { regions: crate::Ids::new(), results: crate::Ids::new(), parent: None, ..d.clone() };
        let n_regions = d.regions.len();
        let old_regions = d.regions.clone();
        self.set_before(op);
        let new = self.create_with(data, &types, |b, new| {
            for _ in 0..n_regions {
                b.add_region(new);
            }
        });
        for (i, r) in old_regions.into_iter().enumerate() {
            let into = self.body[new].regions[i];
            self.inline_region_before(r, into, None);
        }
        let mut next = self.body[new].results.clone().into_iter();
        let replacements: Vec<ValueId> = (0..self.body[op].results.len()).map(|i| if erase.contains(&i) { self.body[op].results[i] } else { next.next().expect("result") }).collect();
        self.replace_op(op, &replacements);
        new
    }
}


/// `FusedLoc::get(locs)` (no metadata) printed: a fused location without metadata is taken apart, unknown ones go,
/// duplicates go (the first kept); none left is `unknown`, one left is itself, else `fused[a, b, …]`.
pub fn fused_loc(locs: &[Option<&str>]) -> String {
    let mut out: Vec<&str> = Vec::new();
    let mut parts: Vec<&str> = Vec::new();
    for l in locs.iter().flatten() {
        let l = l.trim();
        match l.strip_prefix("fused[").and_then(|r| r.strip_suffix(']')) {
            Some(inner) => parts.extend(split_top(inner)),
            None => parts.push(l),
        }
    }
    for p in parts {
        if p != "unknown" && !out.contains(&p) {
            out.push(p);
        }
    }
    match out.as_slice() {
        [] => "unknown".into(),
        [one] => (*one).into(),
        _ => alloc::format!("fused[{}]", out.join(", ")),
    }
}

/// The top-level comma-separated items of a location list (strings, parens and brackets nest).
fn split_top(s: &str) -> Vec<&str> {
    let (mut out, mut depth, mut start, mut quoted, mut escaped) = (Vec::new(), 0i32, 0usize, false, false);
    for (i, c) in s.char_indices() {
        if quoted {
            match c {
                _ if escaped => escaped = false,
                '\\' => escaped = true,
                '"' => quoted = false,
                _ => {}
            }
            continue;
        }
        match c {
            '"' => quoted = true,
            '(' | '[' | '<' | '{' => depth += 1,
            ')' | ']' | '>' | '}' => depth -= 1,
            ',' if depth == 0 => {
                out.push(s[start..i].trim());
                start = i + 1;
            }
            _ => {}
        }
    }
    out.push(s[start..].trim());
    out
}
