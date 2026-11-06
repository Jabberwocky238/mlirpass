//! The data-flow analyses `sccp` and `remove-dead-values` run: `DeadCodeAnalysis`,
//! `SparseConstantPropagation` and `LivenessAnalysis`.
//!
//! Each is monotone, so its fixed point does not depend on visiting order. The forward analyses
//! reach it off a worklist (`DataFlowSolver`'s): every op and block once, in preorder, then only
//! what reads a state that changed. Liveness sweeps the IR until nothing changes.

use alloc::collections::{BTreeMap, BTreeSet, VecDeque};
use alloc::string::String;
use alloc::vec;
use alloc::vec::Vec;

use mlirformat::Attribute;

use crate::{Point, Succ};
use crate::{Body, BlockId, Const, Def, Fold, Folded, OpId, RegionId, Trait, ValueId, Visibility};

/// `ConstantValue` in its `Lattice`.
#[derive(Debug, Clone)]
pub enum Cv<'a> {
    Uninit,
    /// A constant, with the dialect that produced it.
    Known(Attribute<'a>, String),
    Unknown,
}

/// `ConstantValue::operator==`: the constants alone. The dialect only says who materializes it:
/// `math.cos` of a NaN and an `arith.constant` NaN are the same value, and the join keeps the first.
impl PartialEq for Cv<'_> {
    fn eq(&self, o: &Self) -> bool {
        match (self, o) {
            (Cv::Known(a, _), Cv::Known(b, _)) => a == b,
            (Cv::Uninit, Cv::Uninit) | (Cv::Unknown, Cv::Unknown) => true,
            _ => false,
        }
    }
}

impl<'a> Cv<'a> {
    fn join(&self, o: &Self) -> Self {
        match (self, o) {
            (Cv::Uninit, x) | (x, Cv::Uninit) => x.clone(),
            (a, b) if a == b => a.clone(),
            _ => Cv::Unknown,
        }
    }
}

/// `PredecessorState`.
#[derive(Debug, Default, Clone, PartialEq)]
struct Preds {
    unknown: bool,
    known: Vec<OpId>,
    inputs: BTreeMap<OpId, Vec<ValueId>>,
}

/// What the worklist visits: an op (`DeadCodeAnalysis` and `SparseConstantPropagation` of it),
/// or a block (its arguments).
#[derive(Debug, Clone, Copy)]
enum Item {
    Op(OpId),
    Block(BlockId),
}

/// A program point: after an op, or the start of a block.
#[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
enum Pt {
    After(OpId),
    Block(BlockId),
}

/// The body a solver works on: borrowed, or owned (a function lent out, solved apart round
/// after round: [`Solver::run_in`]).
pub enum BodyRef<'b, 'a> {
    Borrowed(&'b mut Body<'a>),
    Owned(Body<'a>),
}

impl<'a> core::ops::Deref for BodyRef<'_, 'a> {
    type Target = Body<'a>;
    fn deref(&self) -> &Body<'a> {
        match self {
            BodyRef::Borrowed(b) => b,
            BodyRef::Owned(b) => b,
        }
    }
}

impl<'a> core::ops::DerefMut for BodyRef<'_, 'a> {
    fn deref_mut(&mut self) -> &mut Body<'a> {
        match self {
            BodyRef::Borrowed(b) => b,
            BodyRef::Owned(b) => b,
        }
    }
}

/// A call as the whole body resolved it, for a solver that sees part of it ([`Boundary`]).
#[derive(Debug, Clone, Copy)]
struct CallInfo {
    callee: Option<OpId>,
    /// The callee is a symbol of the body with a body of its own: the call is one of its known
    /// callers (else its results are what an unknown callee gives).
    internal: bool,
    /// The callee is a callable without a body.
    bodiless: bool,
    /// The callee is a callable.
    callable: bool,
}

/// A callable's callers: an unknown one, the known calls, and what they pass, joined per
/// argument.
#[derive(Debug, Clone, Default, PartialEq)]
struct Callers<'a> {
    unknown: bool,
    calls: BTreeSet<OpId>,
    args: Vec<Cv<'a>>,
}

impl<'a> Callers<'a> {
    fn join_args(&mut self, args: &[Cv<'a>]) {
        if self.args.len() < args.len() {
            self.args.resize(args.len(), Cv::Uninit);
        }
        for (a, c) in self.args.iter_mut().zip(args) {
            *a = a.join(c);
        }
    }

    fn join(&mut self, o: &Self) {
        self.unknown |= o.unknown;
        self.calls.extend(o.calls.iter().copied());
        self.join_args(&o.args);
    }
}

/// What a callable's live terminators give its calls: unknown (one is not a return), and the
/// returns' operands, joined per result.
#[derive(Debug, Clone, Default, PartialEq)]
struct Returns<'a> {
    unknown: bool,
    values: Vec<Cv<'a>>,
}

impl<'a> Returns<'a> {
    fn join_values(&mut self, vs: &[Cv<'a>]) {
        if self.values.len() < vs.len() {
            self.values.resize(vs.len(), Cv::Uninit);
        }
        for (a, c) in self.values.iter_mut().zip(vs) {
            *a = a.join(c);
        }
    }

    fn join(&mut self, o: &Self) {
        self.unknown |= o.unknown;
        self.join_values(&o.values);
    }
}

/// What a solver that sees part of the body (a function, or the rest) knows of the other parts —
/// the calls resolved, each callable's callers and returns as of the last round — and what it
/// tells them: the callers and returns its own ops make.
#[derive(Debug, Clone, Default)]
struct Boundary<'a> {
    calls: alloc::sync::Arc<BTreeMap<OpId, CallInfo>>,
    callers: alloc::sync::Arc<BTreeMap<OpId, Callers<'a>>>,
    returns: alloc::sync::Arc<BTreeMap<OpId, Returns<'a>>>,
    out_callers: BTreeMap<OpId, Callers<'a>>,
    out_returns: BTreeMap<OpId, Returns<'a>>,
    /// Liveness: per callable, whether each entry argument is live; per callable, whether its
    /// results are live at some call (all, with an unknown caller).
    args_live: alloc::sync::Arc<BTreeMap<OpId, Vec<bool>>>,
    results_live: alloc::sync::Arc<BTreeMap<OpId, (bool, Vec<bool>)>>,
    /// Ops of the body that are solved elsewhere (lent out): not visited here.
    skip: BTreeSet<OpId>,
}

pub struct Solver<'b, 'a> {
    pub body: BodyRef<'b, 'a>,
    pub top: OpId,
    live: BTreeSet<BlockId>,
    edges: BTreeSet<(BlockId, BlockId)>,
    preds: BTreeMap<Pt, Preds>,
    /// Per value (by id); past the end: `Uninit`.
    lat: crate::IdVec<ValueId, Cv<'a>>,
    changed: bool,
    /// `Liveness`: the values found live.
    pub alive: crate::IdVec<ValueId, bool>,
    /// The sweep under way, from 1.
    round: u32,
    /// Per value, the sweep its lattice last changed in.
    changed_in: crate::IdVec<ValueId, u32>,
    /// Per op, the sweep `sparse_op` last folded it in (0: never, or it must fold every time):
    /// it need not fold again until one of its operands changes.
    folded_in: crate::IdVec<OpId, u32>,
    /// Each call's [`resolve`](Self::resolve): the IR does not change while solving.
    callees: BTreeMap<OpId, Option<OpId>>,
    /// What to visit again, and whether each op and block is in it already.
    work: VecDeque<Item>,
    queued_ops: crate::IdVec<OpId, bool>,
    queued_blocks: crate::IdVec<BlockId, bool>,
    /// The ops whose fold gave another value of their own ([`Folded::Value`]): they read it
    /// although it is not their operand.
    reads: BTreeMap<ValueId, Vec<OpId>>,
    /// Solving part of the body ([`Solver::run_in`]).
    unit: Option<Boundary<'a>>,
}

impl<'b, 'a> Solver<'b, 'a> {
    pub fn new(body: &'b mut Body<'a>, top: OpId) -> Self {
        Self::with(BodyRef::Borrowed(body), top)
    }

    fn with(body: BodyRef<'b, 'a>, top: OpId) -> Self {
        Self { unit: None, body, top, live: BTreeSet::new(), edges: BTreeSet::new(), preds: BTreeMap::new(), lat: crate::IdVec::new(Cv::Uninit), changed: false, alive: crate::IdVec::new(false), round: 0, changed_in: crate::IdVec::new(0), folded_in: crate::IdVec::new(0), callees: BTreeMap::new(), work: VecDeque::new(), queued_ops: crate::IdVec::new(false), queued_blocks: crate::IdVec::new(false), reads: BTreeMap::new() }
    }

    pub fn get(&self, v: ValueId) -> Cv<'a> {
        self.lat.get(v).clone()
    }

    fn join(&mut self, v: ValueId, c: &Cv<'a>) {
        let old = self.get(v);
        let new = old.join(c);
        if new != old {
            self.lat.set(v, new);
            self.changed = true;
            self.changed_in.set(v, self.round);
            self.value_changed(v);
        }
    }

    // ---- the worklist ----------------------------------------------------------------------

    fn push_op(&mut self, o: OpId) {
        if self.unit.as_ref().is_some_and(|u| u.skip.contains(&o)) {
            return;
        }
        if !core::mem::replace(self.queued_ops.get_mut(o), true) {
            self.work.push_back(Item::Op(o));
        }
    }

    fn push_block(&mut self, b: BlockId) {
        if !core::mem::replace(self.queued_blocks.get_mut(b), true) {
            self.work.push_back(Item::Block(b));
        }
    }

    /// The entry blocks of `op`'s regions.
    fn push_entries(&mut self, op: OpId) {
        for r in self.body[op].regions.clone() {
            if let Some(b) = self.entry_of(r) {
                self.push_block(b);
            }
        }
    }

    /// `v`'s lattice changed: what reads it, through each user (the user itself, the blocks its
    /// operands flow into — successors, its regions', a callee's —, and for a terminator its
    /// parent, the parent's regions and the calls a return answers), and the ops that folded
    /// to it.
    fn value_changed(&mut self, v: ValueId) {
        let users: Vec<OpId> = self.body[v].uses.iter().map(|u| u.op).collect();
        for u in users {
            self.push_op(u);
            for s in self.body[u].successors.clone() {
                self.push_block(s);
            }
            self.push_entries(u);
            // A terminator's operands flow to its parent: its results, its regions, its callers.
            let last = self.body[u].parent.is_some_and(|b| self.body.last_op(b) == Some(u));
            if let Some(p) = self.body.parent_op(u).filter(|_| last) {
                self.push_op(p);
                self.push_entries(p);
                if self.unit.is_some() {
                    continue;
                }
                if let Some(cs) = self.preds.get(&Pt::After(p)) {
                    for call in cs.known.clone() {
                        self.push_op(call);
                    }
                }
            }
            if self.unit.is_none()
                && self.body.has(u, Trait::CallOpInterface)
                && let Some(c) = self.callee(u)
                && let Some(b) = self.callable_region(c).and_then(|r| self.entry_of(r))
            {
                self.push_block(b);
            }
        }
        if let Some(ops) = self.reads.get(&v) {
            for o in ops.clone() {
                self.push_op(o);
            }
        }
    }

    /// Block `b` became live: it, and every op in it.
    fn block_changed(&mut self, b: BlockId) {
        self.push_block(b);
        for o in self.body.block_ops(b) {
            self.push_op(o);
        }
    }

    /// The predecessors of `p` changed: what reads them — the op (its results, a callable's
    /// liveness), a callable's returns and entry; or the block.
    fn preds_changed(&mut self, p: Pt) {
        match p {
            Pt::After(o) => {
                self.push_op(o);
                if self.is_callable(o) {
                    self.push_entries(o);
                    for r in self.body[o].regions.clone() {
                        for b in self.body[r].blocks.clone() {
                            if let Some(t) = self.body.last_op(b) {
                                self.push_op(t);
                            }
                        }
                    }
                }
            }
            Pt::Block(b) => self.push_block(b),
        }
    }

    fn unknown(&mut self, vs: &[ValueId]) {
        for v in vs {
            self.join(*v, &Cv::Unknown);
        }
    }

    fn mark_live(&mut self, b: BlockId) {
        if self.live.insert(b) {
            self.changed = true;
            self.block_changed(b);
        }
    }

    fn preds_mut(&mut self, p: Pt) -> &mut Preds {
        self.preds.entry(p).or_default()
    }

    fn set_unknown_preds(&mut self, p: Pt) {
        let s = self.preds_mut(p);
        if !s.unknown {
            s.unknown = true;
            self.changed = true;
            self.preds_changed(p);
        }
    }

    fn join_pred(&mut self, p: Pt, pred: OpId, inputs: &[ValueId]) {
        let s = self.preds.entry(p).or_default();
        let mut ch = false;
        if !s.known.contains(&pred) {
            s.known.push(pred);
            ch = true;
        }
        if !inputs.is_empty() && s.inputs.get(&pred).map(Vec::as_slice) != Some(inputs) {
            s.inputs.insert(pred, inputs.to_vec());
            ch = true;
        }
        if ch {
            self.changed = true;
            self.preds_changed(p);
        }
    }

    fn block_live(&self, op: OpId) -> bool {
        self.body[op].parent.is_none_or(|b| self.live.contains(&b))
    }

    fn entry_of(&self, r: RegionId) -> Option<BlockId> {
        self.body[r].blocks.first().copied()
    }

    fn mark_entries_live(&mut self, op: OpId) {
        for r in self.body[op].regions.clone() {
            if let Some(b) = self.entry_of(r) {
                self.mark_live(b);
            }
        }
    }

    fn is_callable(&self, op: OpId) -> bool {
        self.body.has(op, Trait::CallableOpInterface)
    }

    /// `getCallableRegion`: the body of a callable, when it has one.
    fn callable_region(&self, op: OpId) -> Option<RegionId> {
        self.body[op].regions.first().copied().filter(|r| !self.body[*r].blocks.is_empty())
    }

    /// `CallOpInterface::resolveCallable`.
    fn resolve(&self, call: OpId) -> Option<OpId> {
        let b = &*self.body;
        if let Some(callee) = b.interfaces(call).and_then(|i| i.indirect_callee(b, call)) {
            return b.def_op(callee);
        }
        let Some(Attribute::SymbolRef(path)) = b[call].get("callee") else { return None };
        let mut t = b.parent_op(call);
        while let Some(o) = t {
            if b.is_symbol_table(o) {
                return b.lookup_path(o, path)?.last().copied();
            }
            t = b.parent_op(o);
        }
        None
    }

    /// [`resolve`](Self::resolve), once per call.
    fn callee(&mut self, call: OpId) -> Option<OpId> {
        if let Some(c) = self.callees.get(&call) {
            return *c;
        }
        let c = self.resolve(call);
        self.callees.insert(call, c);
        c
    }

    fn call_args(&self, call: OpId) -> Vec<ValueId> {
        self.body[call].operands[self.body.call_arg_range(call)].to_vec()
    }

    fn is_ancestor(&self, anc: OpId, mut op: OpId) -> bool {
        loop {
            if op == anc {
                return true;
            }
            match self.body.parent_op(op) {
                Some(p) => op = p,
                None => return false,
            }
        }
    }

    /// The constants of `op`'s operands; `None` while one is uninitialized.
    fn operand_values(&self, op: OpId) -> Option<Vec<Option<Attribute<'a>>>> {
        self.body[op]
            .operands
            .iter()
            .map(|v| match self.get(*v) {
                Cv::Uninit => None,
                Cv::Known(a, _) => Some(Some(a)),
                Cv::Unknown => Some(None),
            })
            .collect()
    }

    fn is_region_branch(&self, op: OpId) -> bool {
        self.body.is_region_branch(op)
    }

    /// `getEntrySuccessorRegions(operands)`.
    fn entry_successors(&self, op: OpId, c: &[Option<Attribute<'a>>]) -> Vec<(Succ, Vec<ValueId>)> {
        let b = &*self.body;
        let all = b.region_successors(op, Point::Parent);
        match b.interfaces(op) {
            Some(i) => i.entry_successors(b, op, c, all),
            None => all,
        }
    }

    /// A region terminator's `getSuccessorRegions(operands)`.
    fn terminator_successors(&self, op: OpId, t: OpId, c: &[Option<Attribute<'a>>]) -> Vec<(Succ, Vec<ValueId>)> {
        let b = &*self.body;
        let all = b.region_successors(op, Point::Terminator(t));
        match b.interfaces(t) {
            Some(i) => i.terminator_successors(b, t, c, all),
            None => all,
        }
    }

    fn edges_to(&mut self, branch: OpId, pred: OpId, succs: &[(Succ, Vec<ValueId>)]) {
        for (s, inputs) in succs {
            let p = match s {
                Succ::Parent => Pt::After(branch),
                Succ::Region(r) => {
                    let Some(b) = self.entry_of(self.body[branch].regions[*r]) else { continue };
                    self.mark_live(b);
                    Pt::Block(b)
                }
            };
            self.join_pred(p, pred, inputs);
        }
    }

    /// `BranchOpInterface::getSuccessorForOperands`.
    fn successor_for(&self, op: OpId, c: &[Option<Attribute<'a>>]) -> Option<BlockId> {
        let b = &*self.body;
        b.interfaces(op)?.successor_for(b, op, c)
    }

    fn is_region_or_callable_return(&self, op: OpId) -> bool {
        let b = &*self.body;
        let Some(blk) = b[op].parent else { return false };
        let Some(p) = b.parent_op(op) else { return false };
        b[op].successors.is_empty() && (self.is_region_branch(p) || self.is_callable(p)) && b.last_op(blk) == Some(op)
    }

    /// `DeadCodeAnalysis::visit` of the point after `op`.
    fn dca(&mut self, op: OpId) {
        if !self.block_live(op) {
            return;
        }
        if self.body.has(op, Trait::CallOpInterface) {
            if self.unit.is_some() {
                self.unit_call(op);
            } else {
                let callee = self.callee(op);
                let external = |s: &Self, c: OpId| !s.is_ancestor(s.top, c) || (s.is_callable(c) && s.callable_region(c).is_none());
                match callee {
                    Some(c) if self.body.has(c, Trait::SymbolOpInterface) && !external(self, c) => self.join_pred(Pt::After(c), op, &[]),
                    _ => self.set_unknown_preds(Pt::After(op)),
                }
            }
        }
        if !self.body[op].regions.is_empty() {
            if self.is_region_branch(op) {
                if let Some(c) = self.operand_values(op) {
                    let s = self.entry_successors(op, &c);
                    self.edges_to(op, op, &s);
                }
            } else if self.is_callable(op) {
                let called = match &self.unit {
                    Some(u) => u.callers.get(&op).is_some_and(|c| c.unknown || !c.calls.is_empty()),
                    None => self.preds.get(&Pt::After(op)).is_some_and(|cs| cs.unknown || !cs.known.is_empty()),
                };
                if called {
                    self.mark_entries_live(op);
                }
            } else {
                self.mark_entries_live(op);
            }
        }
        if self.is_region_or_callable_return(op) {
            let p = self.body.parent_op(op).expect("nested");
            if self.is_region_branch(p) {
                if let Some(c) = self.operand_values(op)
                    && self.body.has(op, Trait::RegionBranchTerminatorOpInterface)
                {
                    let s = self.terminator_successors(p, op, &c);
                    self.edges_to(p, op, &s);
                }
            } else if self.unit.is_some() {
                self.unit_return(p, op);
            } else {
                let cs = self.preds.get(&Pt::After(p)).cloned().unwrap_or_default();
                let resolves = self.body.has(op, Trait::ReturnLike);
                for call in cs.known {
                    if resolves {
                        self.join_pred(Pt::After(call), op, &[]);
                    } else {
                        self.set_unknown_preds(Pt::After(call));
                    }
                }
            }
        }
        if !self.body[op].successors.is_empty() {
            let from = self.body[op].parent.expect("placed");
            let targets = if self.body.forwards_to_successors(op) {
                let Some(c) = self.operand_values(op) else { return };
                match self.successor_for(op, &c) {
                    Some(s) => vec![s],
                    None => self.body[op].successors.clone().to_vec(),
                }
            } else {
                self.body[op].successors.clone().to_vec()
            };
            for t in targets {
                self.mark_live(t);
                if self.edges.insert((from, t)) {
                    self.changed = true;
                    self.push_block(t);
                }
            }
        }
    }

    /// `visitRegionSuccessors`: `lattices` (results after the op, or a region's arguments)
    /// from what flows in.
    fn region_successors(&mut self, point: Pt, branch: OpId, lattices: &[ValueId]) {
        let ps = self.preds.get(&point).cloned().unwrap_or_default();
        for pred in &ps.known {
            let operands: Vec<ValueId> = if *pred == branch {
                self.body.forwarded(branch, Point::Parent).iter().map(|(o, i)| self.body[*o].operands[*i]).collect()
            } else if self.body.has(*pred, Trait::RegionBranchTerminatorOpInterface) {
                self.body.forwarded(branch, Point::Terminator(*pred)).iter().map(|(o, i)| self.body[*o].operands[*i]).collect()
            } else {
                return self.unknown(lattices);
            };
            let inputs = ps.inputs.get(pred).cloned().unwrap_or_default();
            let mut first = 0;
            if inputs.len() != lattices.len() {
                if let Some(v) = inputs.first() {
                    first = match self.body[*v].def {
                        Def::Result(_, i) | Def::Arg(_, i) => i as usize,
                    };
                }
                self.unknown(&lattices[..first.min(lattices.len())]);
                self.unknown(&lattices[(first + inputs.len()).min(lattices.len())..]);
            }
            for (o, l) in operands.iter().zip(&lattices[first.min(lattices.len())..]) {
                let c = self.get(*o);
                self.join(*l, &c);
            }
        }
    }

    /// `SparseConstantPropagation::visitOperation` and its callers.
    fn sparse_op(&mut self, op: OpId) {
        let results = self.body[op].results.clone();
        if results.is_empty() || !self.block_live(op) {
            return;
        }
        if self.is_region_branch(op) {
            return self.region_successors(Pt::After(op), op, &results);
        }
        if self.body.has(op, Trait::CallOpInterface) {
            if let Some(u) = &self.unit {
                let info = u.calls.get(&op).copied();
                if info.is_some_and(|i| i.bodiless) || self.preds.get(&Pt::After(op)).is_some_and(|p| p.unknown) {
                    return self.unknown(&results);
                }
                let Some(ret) = info.filter(|i| i.internal).and_then(|i| u.returns.get(&i.callee?)).cloned() else { return };
                if ret.unknown {
                    return self.unknown(&results);
                }
                for (r, c) in results.iter().zip(&ret.values) {
                    self.join(*r, c);
                }
                return;
            }
            let callee = self.callee(op);
            if callee.is_some_and(|c| self.is_callable(c) && self.callable_region(c).is_none()) {
                return self.unknown(&results);
            }
            let ps = self.preds.get(&Pt::After(op)).cloned().unwrap_or_default();
            if ps.unknown {
                return self.unknown(&results);
            }
            for ret in ps.known {
                for (o, r) in self.body[ret].operands.clone().iter().zip(&results) {
                    let c = self.get(*o);
                    self.join(*r, &c);
                }
            }
            return;
        }
        if !self.body[op].regions.is_empty() {
            return self.unknown(&results);
        }
        // Folded before, and no operand has changed since: folding again gives the same.
        let last = *self.folded_in.get(op);
        if last != 0 && self.body[op].operands.iter().all(|v| *self.changed_in.get(*v) < last) {
            return;
        }
        self.folded_in.set(op, self.round);
        let Some(consts) = self.operand_values(op) else { return };
        let dialect = |s: &Self| String::from(s.body[op].name.split_once('.').map_or("", |(d, _)| d));
        if self.body.has(op, Trait::ConstantLike)
            && let Some(v) = self.body.constant_value(op)
        {
            let d = dialect(self);
            return self.join(results[0], &Cv::Known(v, d));
        }
        // A fold in place is undone: from the journal, which saves only what the fold writes.
        let cp = self.body.checkpoint();
        match self.body.fold_with(op, &consts) {
            Fold::Results(rs) => {
                self.body.release(cp);
                for (r, f) in results.iter().zip(rs) {
                    let c = match f {
                        Folded::Attr(a) => Cv::Known(a, dialect(self)),
                        Folded::Value(v) => {
                            // A value of its own: the op depends on more than its operands.
                            self.folded_in.set(op, 0);
                            let readers = self.reads.entry(v).or_default();
                            if !readers.contains(&op) {
                                readers.push(op);
                            }
                            self.get(v)
                        }
                    };
                    self.join(*r, &c);
                }
            }
            Fold::InPlace => {
                self.body.rollback(cp);
                self.unknown(&results);
            }
            Fold::Failed => {
                self.body.release(cp);
                self.unknown(&results);
            }
        }
    }

    /// `AbstractSparseForwardDataFlowAnalysis::visitBlock`.
    fn sparse_block(&mut self, block: BlockId) {
        let args = self.body[block].args.clone();
        if args.is_empty() || !self.live.contains(&block) {
            return;
        }
        let region = self.body[block].parent.expect("in a region");
        if self.body[region].blocks[0] == block {
            let parent = self.body[region].parent;
            if self.is_callable(parent) && self.callable_region(parent) == Some(region) {
                if let Some(u) = &self.unit {
                    let cs = u.callers.get(&parent).cloned().unwrap_or_default();
                    if cs.unknown {
                        return self.unknown(&args);
                    }
                    for (a, c) in args.iter().zip(&cs.args) {
                        self.join(*a, c);
                    }
                    return;
                }
                let cs = self.preds.get(&Pt::After(parent)).cloned().unwrap_or_default();
                if cs.unknown {
                    return self.unknown(&args);
                }
                for call in cs.known {
                    for (o, a) in self.call_args(call).iter().zip(&args) {
                        let c = self.get(*o);
                        self.join(*a, &c);
                    }
                }
                return;
            }
            if self.is_region_branch(parent) {
                return self.region_successors(Pt::Block(block), parent, &args);
            }
            return self.unknown(&args);
        }
        for (t, i) in self.body.predecessors(block) {
            let from = self.body[t].parent.expect("placed");
            if !self.edges.contains(&(from, block)) {
                continue;
            }
            let Some((produced, range)) = self.body.successor_layout(t, i) else { return self.unknown(&args) };
            let ops: Vec<ValueId> = self.body[t].operands[range].to_vec();
            for (k, a) in args.iter().enumerate() {
                match k.checked_sub(produced).and_then(|k| ops.get(k)) {
                    Some(o) => {
                        let c = self.get(*o);
                        self.join(*a, &c);
                    }
                    None => self.join(*a, &Cv::Unknown),
                }
            }
        }
    }

    /// Every op and block under `op` onto the worklist, in the order a sweep visits them.
    fn enqueue_all(&mut self, op: OpId) {
        if self.unit.as_ref().is_some_and(|u| u.skip.contains(&op)) {
            return;
        }
        self.push_op(op);
        for r in self.body[op].regions.clone() {
            for b in self.body[r].blocks.clone() {
                self.push_block(b);
                for o in self.body.block_ops(b) {
                    self.enqueue_all(o);
                }
            }
        }
    }

    /// `initializeSymbolCallables` over `SymbolTable::walkSymbolTables`.
    fn symbol_callables(&mut self, op: OpId, mut visible: bool) {
        let table = self.body.is_symbol_table(op);
        if table {
            visible |= !self.body.has(op, Trait::SymbolOpInterface) || self.body.visibility(op) == Visibility::Private;
        } else {
            visible = true;
        }
        for r in self.body[op].regions.clone() {
            for b in self.body[r].blocks.clone() {
                for o in self.body.block_ops(b) {
                    self.symbol_callables(o, visible);
                }
            }
        }
        if !table {
            return;
        }
        let Some(&blk) = self.body[op].regions.first().and_then(|r| self.body[*r].blocks.first()) else { return };
        let mut found = false;
        for c in self.body.block_ops(blk) {
            if !self.is_callable(c) || self.callable_region(c).is_none() || !self.body.has(c, Trait::SymbolOpInterface) {
                continue;
            }
            let vis = self.body.visibility(c);
            if vis == Visibility::Public || (!visible && vis == Visibility::Nested) {
                self.set_unknown_preds(Pt::After(c));
            }
            found = true;
        }
        if !found {
            return;
        }
        let Some(uses) = self.body.region_symbol_uses(op) else {
            for c in self.body.ops_in(self.top) {
                if self.is_callable(c) {
                    self.set_unknown_preds(Pt::After(c));
                }
            }
            return;
        };
        for u in uses {
            if self.body.has(u.user, Trait::CallOpInterface) {
                continue;
            }
            if let Some(s) = self.body.lookup_path(self.top, &u.path).and_then(|p| p.last().copied()) {
                self.set_unknown_preds(Pt::After(s));
            }
        }
    }

    /// `DeadCodeAnalysis` and `SparseConstantPropagation` to their fixed point.
    pub fn run(&mut self) {
        let top = self.top;
        for r in self.body[top].regions.clone() {
            if let Some(b) = self.entry_of(r) {
                self.mark_live(b);
                let args = self.body[b].args.clone();
                self.unknown(&args);
            }
        }
        let visible = self.body[top].parent.is_none();
        self.symbol_callables(top, visible);
        // What the steps above queued goes first; then everything, as the first sweep did.
        self.enqueue_all(top);
        self.drain();
    }

    /// A call where only part of the body is seen ([`Boundary`]): one of its callee's callers,
    /// with what it passes; an unknown callee leaves its results' predecessors unknown.
    fn unit_call(&mut self, op: OpId) {
        let info = self.unit.as_ref().and_then(|u| u.calls.get(&op).copied());
        match info.filter(|i| i.internal).and_then(|i| i.callee) {
            Some(c) => {
                let args: Vec<Cv<'a>> = self.call_args(op).iter().map(|v| self.get(*v)).collect();
                let out = self.unit.as_mut().expect("a unit").out_callers.entry(c).or_default();
                out.calls.insert(op);
                out.join_args(&args);
            }
            None => self.set_unknown_preds(Pt::After(op)),
        }
    }

    /// A live terminator `op` of callable `p`, where only part of the body is seen: what it gives
    /// `p`'s calls (a return's operands; anything else: unknown).
    fn unit_return(&mut self, p: OpId, op: OpId) {
        let values: Option<Vec<Cv<'a>>> = self.body.has(op, Trait::ReturnLike).then(|| self.body[op].operands.iter().map(|v| self.get(*v)).collect());
        let out = self.unit.as_mut().expect("a unit").out_returns.entry(p).or_default();
        match values {
            Some(vs) => out.join_values(&vs),
            None => out.unknown = true,
        }
    }

    /// Every call under `top`, resolved on the whole body.
    fn call_infos(&mut self, top: OpId) -> BTreeMap<OpId, CallInfo> {
        let mut out = BTreeMap::new();
        for op in self.body.ops_in(top) {
            if !self.body.has(op, Trait::CallOpInterface) {
                continue;
            }
            let callee = self.resolve(op);
            let bodiless = callee.is_some_and(|c| self.is_callable(c) && self.callable_region(c).is_none());
            let internal = callee.is_some_and(|c| self.body.has(c, Trait::SymbolOpInterface) && self.is_ancestor(top, c) && !bodiless);
            let callable = callee.is_some_and(|c| self.is_callable(c));
            out.insert(op, CallInfo { callee, internal, bodiless, callable });
        }
        out
    }

    /// ⭐ [`run`](Self::run) of `top` (a module) and the [`lattice`](Self::lattice) it reaches,
    /// its functions solved in parallel on `exec`. Who calls what, and which callables anyone
    /// may call, are settled on the whole body first; then each function with a seg of its own
    /// is lent out and solved by a solver of its own, the rest here, all seeing each other only
    /// through each callable's callers and returns ([`Boundary`]) as the last round left them.
    /// Round after round, what changed in those is fed back to what reads it, until nothing
    /// does: the analyses are monotone, so this is the fixed point a serial run reaches.
    pub fn solve_in<X: moremath::Executor + Sync>(body: &'b mut Body<'a>, top: OpId, exec: &X) -> crate::IdVec<ValueId, Cv<'a>> {
        Self::solve(body, top, exec, false).0
    }

    /// [`solve_in`](Self::solve_in), then liveness ([`run_liveness`](Self::run_liveness)) the
    /// same way — through each callable's live entry arguments and the results its calls use —
    /// and the values found live.
    pub fn liveness_in<X: moremath::Executor + Sync>(body: &'b mut Body<'a>, top: OpId, exec: &X) -> crate::IdVec<ValueId, bool> {
        Self::solve(body, top, exec, true).1
    }

    fn solve<X: moremath::Executor + Sync>(body: &'b mut Body<'a>, top: OpId, exec: &X, liveness: bool) -> (crate::IdVec<ValueId, Cv<'a>>, crate::IdVec<ValueId, bool>) {
        let children = body.children(top);
        if moremath::Executor::threads(exec) < 2 || children.iter().filter(|c| body.lendable(**c)).count() < 2 {
            let mut s = Solver::new(body, top);
            s.run();
            if liveness {
                s.run_liveness_only();
            }
            return (s.lat, s.alive);
        }
        let mut main = Solver::new(body, top);
        let visible = main.body[top].parent.is_none();
        main.symbol_callables(top, visible);
        let calls = alloc::sync::Arc::new(main.call_infos(top));
        let base: BTreeMap<OpId, Callers<'a>> = main
            .preds
            .iter()
            .filter_map(|(p, st)| match p {
                Pt::After(o) if st.unknown && main.is_callable(*o) => Some((*o, Callers { unknown: true, ..Callers::default() })),
                _ => None,
            })
            .collect();
        let mut by_callee: BTreeMap<OpId, Vec<OpId>> = BTreeMap::new();
        for (call, info) in calls.iter() {
            if let Some(c) = info.callee.filter(|_| info.internal) {
                by_callee.entry(c).or_default().push(*call);
            }
        }
        // The functions lent out, each with a solver of its own; the rest stays here.
        let mut lent: Vec<(OpId, crate::Lent)> = Vec::new();
        let mut units: Vec<Solver<'_, 'a>> = Vec::new();
        for c in children {
            if let Some((sub, parent)) = main.body.lend(c) {
                let mut u = Solver::with(BodyRef::Owned(sub), c);
                u.unit = Some(Boundary { calls: calls.clone(), ..Boundary::default() });
                let stand_in = u.body.top_block(u.body.root);
                u.mark_live(stand_in);
                u.enqueue_all(c);
                lent.push((c, parent));
                units.push(u);
            }
        }
        let owner: BTreeMap<u32, usize> = lent.iter().enumerate().map(|(k, (c, _))| (crate::Id::seg(*c), k)).collect();
        main.unit = Some(Boundary { calls: calls.clone(), skip: lent.iter().map(|(c, _)| *c).collect(), ..Boundary::default() });
        // What settling the callables queued here belongs to the lent functions' solvers, which
        // visit everything of theirs anyway.
        main.work.clear();
        main.queued_ops = crate::IdVec::new(false);
        main.queued_blocks = crate::IdVec::new(false);
        for r in main.body[top].regions.clone() {
            if let Some(b) = main.entry_of(r) {
                main.mark_live(b);
                let args = main.body[b].args.clone();
                main.unknown(&args);
            }
        }
        main.enqueue_all(top);
        let (mut callers, mut returns): (BTreeMap<OpId, Callers<'a>>, BTreeMap<OpId, Returns<'a>>) = (base.clone(), BTreeMap::new());
        loop {
            let (ca, re) = (alloc::sync::Arc::new(callers.clone()), alloc::sync::Arc::new(returns.clone()));
            for s in units.iter_mut().chain(core::iter::once(&mut main)) {
                let u = s.unit.as_mut().expect("a unit");
                u.callers = ca.clone();
                u.returns = re.clone();
            }
            // Each function to its own fixed point under what the others gave last round.
            let mut slots: Vec<Option<Solver<'_, 'a>>> = units.drain(..).map(Some).collect();
            let tasks = slots
                .iter_mut()
                .map(|slot| {
                    alloc::boxed::Box::new(move || {
                        let mut s = slot.take().expect("a solver");
                        s.drain();
                        *slot = Some(s);
                    }) as crate::Task<'_>
                })
                .collect();
            moremath::Executor::execute(exec, tasks);
            units = slots.into_iter().map(|s| s.expect("every task ran")).collect();
            main.drain();
            // What they all tell: the callers and returns of every callable.
            let mut new_callers = base.clone();
            let mut new_returns: BTreeMap<OpId, Returns<'a>> = BTreeMap::new();
            for s in units.iter().chain(core::iter::once(&main)) {
                let u = s.unit.as_ref().expect("a unit");
                for (c, o) in &u.out_callers {
                    new_callers.entry(*c).or_default().join(o);
                }
                for (p, o) in &u.out_returns {
                    new_returns.entry(*p).or_default().join(o);
                }
            }
            if new_callers == callers && new_returns == returns {
                break;
            }
            // What read a changed one goes again: a callable's liveness and entry, the calls of a
            // callable whose returns changed.
            let owner_of = |x: OpId| -> usize { owner.get(&crate::Id::seg(x)).copied().unwrap_or(usize::MAX) };
            for (c, cs) in &new_callers {
                if callers.get(c) != Some(cs) {
                    let s = match owner_of(*c) {
                        usize::MAX => &mut main,
                        k => &mut units[k],
                    };
                    s.push_op(*c);
                    s.push_entries(*c);
                }
            }
            for (p, rs) in &new_returns {
                if returns.get(p) != Some(rs) {
                    for call in by_callee.get(p).into_iter().flatten() {
                        let s = match owner_of(*call) {
                            usize::MAX => &mut main,
                            k => &mut units[k],
                        };
                        s.push_op(*call);
                    }
                }
            }
            callers = new_callers;
            returns = new_returns;
        }
        if liveness {
            Self::liveness_rounds(&mut main, &mut units, top, &lent, &owner, &calls, &callers, exec);
        }
        // Every function back, its lattice and liveness into the whole ones.
        let mut parts = Vec::with_capacity(units.len());
        for (u, (c, parent)) in units.into_iter().zip(lent) {
            let (sub, lat, alive) = u.into_parts();
            main.body.unlend(c, sub, parent);
            parts.push((c, lat, alive));
        }
        let (mut lat, mut alive) = (main.lat, main.alive);
        for (c, mut l, mut a) in parts {
            let s = crate::Id::seg(c);
            lat.put_row(s, l.take_row(s));
            alive.put_row(s, a.take_row(s));
        }
        (lat, alive)
    }

    /// Liveness of the parts [`solve`](Self::solve) solved apart, round after round: each to its
    /// own fixed point in parallel under each callable's live entry arguments and the results its
    /// calls use as the last round left them; what changed goes back to the calls (arguments)
    /// and the returns (results) that read it, until nothing does.
    #[allow(clippy::too_many_arguments)]
    fn liveness_rounds<X: moremath::Executor + Sync>(main: &mut Self, units: &mut Vec<Self>, top: OpId, lent: &[(OpId, crate::Lent)], owner: &BTreeMap<u32, usize>, calls: &BTreeMap<OpId, CallInfo>, callers: &BTreeMap<OpId, Callers<'a>>, exec: &X) {
        let owner_of = |x: OpId| owner.get(&crate::Id::seg(x)).copied();
        let mut by_callee: BTreeMap<OpId, Vec<OpId>> = BTreeMap::new();
        for (call, info) in calls {
            if let Some(c) = info.callee.filter(|_| info.callable && !info.bodiless) {
                by_callee.entry(c).or_default().push(*call);
            }
        }
        main.enqueue_backward(top);
        for (u, (c, _)) in units.iter_mut().zip(lent) {
            u.enqueue_backward(*c);
        }
        let (mut args_live, mut results_live): (BTreeMap<OpId, Vec<bool>>, BTreeMap<OpId, (bool, Vec<bool>)>) = (BTreeMap::new(), BTreeMap::new());
        loop {
            let (al, rl) = (alloc::sync::Arc::new(args_live.clone()), alloc::sync::Arc::new(results_live.clone()));
            for s in units.iter_mut().chain(core::iter::once(&mut *main)) {
                let u = s.unit.as_mut().expect("a unit");
                u.args_live = al.clone();
                u.results_live = rl.clone();
            }
            let mut slots: Vec<Option<Self>> = units.drain(..).map(Some).collect();
            let tasks = slots
                .iter_mut()
                .map(|slot| {
                    alloc::boxed::Box::new(move || {
                        let mut s = slot.take().expect("a solver");
                        s.drain_backward();
                        *slot = Some(s);
                    }) as crate::Task<'_>
                })
                .collect();
            moremath::Executor::execute(exec, tasks);
            *units = slots.into_iter().map(|s| s.expect("every task ran")).collect();
            main.drain_backward();
            // What the parts say: each callee's live entry arguments, each callable's live
            // results at its calls.
            let mut new_args: BTreeMap<OpId, Vec<bool>> = BTreeMap::new();
            for c in by_callee.keys() {
                let s: &Self = match owner_of(*c) {
                    Some(k) => &units[k],
                    None => main,
                };
                if let Some(entry) = s.callable_region(*c).and_then(|r| s.entry_of(r)) {
                    new_args.insert(*c, s.body[entry].args.iter().map(|a| *s.alive.get(*a)).collect());
                }
            }
            let mut new_results: BTreeMap<OpId, (bool, Vec<bool>)> = BTreeMap::new();
            for (p, cs) in callers {
                let mut live: Vec<bool> = Vec::new();
                for call in &cs.calls {
                    let s: &Self = match owner_of(*call) {
                        Some(k) => &units[k],
                        None => main,
                    };
                    let rs: Vec<bool> = s.body[*call].results.iter().map(|r| *s.alive.get(*r)).collect();
                    if live.len() < rs.len() {
                        live.resize(rs.len(), false);
                    }
                    live.iter_mut().zip(rs).for_each(|(l, r)| *l |= r);
                }
                new_results.insert(*p, (cs.unknown, live));
            }
            if new_args == args_live && new_results == results_live {
                break;
            }
            for (c, a) in &new_args {
                if args_live.get(c) != Some(a) {
                    for call in by_callee.get(c).into_iter().flatten() {
                        match owner_of(*call) {
                            Some(k) => units[k].push_op(*call),
                            None => main.push_op(*call),
                        }
                    }
                }
            }
            for (p, r) in &new_results {
                if results_live.get(p) != Some(r) {
                    match owner_of(*p) {
                        Some(k) => units[k].push_terminators(*p),
                        None => main.push_terminators(*p),
                    }
                }
            }
            args_live = new_args;
            results_live = new_results;
        }
    }

    /// The backward worklist, to its end.
    fn drain_backward(&mut self) {
        while let Some(item) = self.work.pop_front() {
            if let Item::Op(o) = item {
                *self.queued_ops.get_mut(o) = false;
                self.backward(o);
            }
        }
    }

    /// An owned body, its lattice and its liveness.
    fn into_parts(self) -> (Body<'a>, crate::IdVec<ValueId, Cv<'a>>, crate::IdVec<ValueId, bool>) {
        match self.body {
            BodyRef::Owned(b) => (b, self.lat, self.alive),
            BodyRef::Borrowed(_) => unreachable!("a lent solver owns its body"),
        }
    }

    /// The worklist, to its end.
    fn drain(&mut self) {
        while let Some(item) = self.work.pop_front() {
            self.round += 1;
            match item {
                Item::Op(o) => {
                    *self.queued_ops.get_mut(o) = false;
                    self.dca(o);
                    self.sparse_op(o);
                }
                Item::Block(b) => {
                    *self.queued_blocks.get_mut(b) = false;
                    self.sparse_block(b);
                }
            }
        }
    }
}


impl Body<'_> {
    /// The integer (or bool) a constant operand holds, as successor selection reads it.
    pub fn selector_of(a: &Option<Attribute<'_>>) -> Option<i128> {
        match a.as_ref()? {
            Attribute::Bool(b) => Some(i128::from(*b)),
            a => Const::try_from(a).ok()?.at(0).int().map(|i| i.signed()),
        }
    }

    /// `CallOpInterface::getArgOperands` as a range of the operands.
    pub fn call_arg_range(&self, call: OpId) -> core::ops::Range<usize> {
        self.interfaces(call).and_then(|i| i.call_args(self, call)).unwrap_or(0..self[call].operands.len())
    }
}

/// `LivenessAnalysis`, the backward sparse analysis over the live code.
impl Solver<'_, '_> {
    fn mark_alive(&mut self, v: ValueId) {
        if !core::mem::replace(self.alive.get_mut(v), true) {
            self.changed = true;
            self.alive_changed(v);
        }
    }

    /// The terminators of the blocks in `op`'s regions.
    fn push_terminators(&mut self, op: OpId) {
        for r in self.body[op].regions.clone() {
            for b in self.body[r].blocks.clone() {
                if let Some(t) = self.body.last_op(b) {
                    self.push_op(t);
                }
            }
        }
    }

    /// `v` became live: the ops whose operands may be live through it. Its defining op (and,
    /// a region branch, its regions' terminators that yield to it; a call, the callee's
    /// returns); for a block argument, the branches into its block, the op holding its region
    /// and that op's terminators, and a callable's calls.
    fn alive_changed(&mut self, v: ValueId) {
        match self.body[v].def {
            Def::Result(d, _) => {
                self.push_op(d);
                if self.is_region_branch(d) {
                    self.push_terminators(d);
                }
                if self.unit.is_none()
                    && self.body.has(d, Trait::CallOpInterface)
                    && let Some(c) = self.callee(d)
                {
                    self.push_terminators(c);
                }
            }
            Def::Arg(b, _) => {
                for (t, _) in self.body.predecessors(b) {
                    self.push_op(t);
                }
                let Some(r) = self.body[b].parent else { return };
                let p = self.body[r].parent;
                self.push_op(p);
                self.push_terminators(p);
                if let Some(cs) = self.preds.get(&Pt::After(p)) {
                    for call in cs.known.clone() {
                        self.push_op(call);
                    }
                }
            }
        }
    }

    /// `meet(operand, value)`: `operand` is live once `value` is.
    fn meet_alive(&mut self, operand: ValueId, value: ValueId) {
        if *self.alive.get(value) {
            self.mark_alive(operand);
        }
    }

    /// `LivenessAnalysis::visitOperation`, for `operands` of `op`.
    fn liveness_visit(&mut self, op: OpId, operands: &[ValueId]) {
        let any_result = self.body[op].results.iter().any(|r| *self.alive.get(*r));
        if !self.body.would_be_trivially_dead(op) || any_result {
            operands.iter().for_each(|v| self.mark_alive(*v));
        }
    }

    /// `getSuccessorOperandInputMapping` from one point: each forwarded operand with the
    /// inputs it reaches.
    fn operand_inputs_at(&self, op: OpId, p: Point) -> Vec<(usize, Vec<ValueId>)> {
        let ops = self.body.forwarded(op, p);
        let mut out: Vec<(usize, Vec<ValueId>)> = ops.iter().map(|(_, i)| (*i, Vec::new())).collect();
        for (_, inputs) in self.body.region_successors(op, p) {
            for (k, input) in inputs.into_iter().enumerate() {
                if let Some(e) = out.get_mut(k) {
                    e.1.push(input);
                }
            }
        }
        out
    }

    /// `AbstractSparseBackwardDataFlowAnalysis::visitOperation`.
    fn backward(&mut self, op: OpId) {
        if !self.block_live(op) {
            return;
        }
        let operands = self.body[op].operands.clone();
        if self.is_region_branch(op) {
            let mut accounted = vec![false; operands.len()];
            for (i, inputs) in self.operand_inputs_at(op, Point::Parent) {
                for input in inputs {
                    self.meet_alive(operands[i], input);
                    accounted[i] = true;
                }
            }
            let results_live = self.body[op].results.iter().any(|r| *self.alive.get(*r));
            for (s, inputs) in self.body.region_successors(op, Point::Parent) {
                let Succ::Region(r) = s else { continue };
                let Some(b) = self.entry_of(self.body[op].regions[r]) else { continue };
                let extra: Vec<ValueId> = self.body[b].args.iter().copied().filter(|a| !inputs.contains(a)).collect();
                if results_live || !self.body.would_be_trivially_dead(op) {
                    extra.iter().for_each(|a| self.mark_alive(*a));
                }
            }
            for (i, v) in operands.iter().enumerate() {
                if !accounted[i] {
                    self.liveness_visit(op, &[*v]);
                }
            }
            return;
        }
        if self.body.forwards_to_successors(op) {
            let mut accounted = vec![false; operands.len()];
            for (k, blk) in self.body[op].successors.clone().into_iter().enumerate() {
                let (produced, range) = self.body.successor_layout(op, k).unwrap_or((0, 0..0));
                for (j, i) in range.enumerate() {
                    accounted[i] = true;
                    if let Some(a) = self.body[blk].args.get(produced + j).copied() {
                        self.meet_alive(operands[i], a);
                    }
                }
            }
            for (i, v) in operands.iter().enumerate() {
                if !accounted[i] {
                    self.liveness_visit(op, &[*v]);
                }
            }
            return;
        }
        if self.body.has(op, Trait::CallOpInterface)
            && let Some(u) = &self.unit
            && let Some(info) = u.calls.get(&op).copied().filter(|i| i.callable && i.callee.is_some())
        {
            if info.bodiless {
                return operands.iter().for_each(|v| self.mark_alive(*v));
            }
            // Not told yet (the first round): no argument is live yet; the calls go again once
            // the callee's entry is known.
            let live = u.args_live.get(&info.callee.expect("a callee")).cloned();
            let first = operands.len() - self.call_args(op).len();
            for (k, v) in operands.iter().enumerate() {
                let arg = k.checked_sub(first);
                let alive = match (&live, arg) {
                    (_, None) => true,
                    (None, Some(_)) => false,
                    (Some(l), Some(i)) => l.get(i).copied().unwrap_or(true),
                };
                if alive {
                    self.mark_alive(*v);
                }
            }
            return;
        }
        if self.unit.is_none()
            && self.body.has(op, Trait::CallOpInterface)
            && let Some(c) = self.callee(op).filter(|c| self.is_callable(*c))
        {
            let Some(region) = self.callable_region(c) else {
                return operands.iter().for_each(|v| self.mark_alive(*v));
            };
            let entry = self.body[region].blocks[0];
            let args = self.call_args(op);
            let first = operands.len() - args.len();
            for (k, v) in operands.iter().enumerate() {
                match self.body[entry].args.get(k.wrapping_sub(first)).copied().filter(|_| k >= first) {
                    Some(a) => self.meet_alive(*v, a),
                    None => self.mark_alive(*v),
                }
            }
            return;
        }
        if self.body.has(op, Trait::RegionBranchTerminatorOpInterface)
            && let Some(p) = self.body.parent_op(op).filter(|p| self.is_region_branch(*p))
        {
            let mut accounted = vec![false; operands.len()];
            for (i, inputs) in self.operand_inputs_at(p, Point::Terminator(op)) {
                for input in inputs {
                    self.meet_alive(operands[i], input);
                    accounted[i] = true;
                }
            }
            for (i, v) in operands.iter().enumerate() {
                if !accounted[i] {
                    self.liveness_visit(p, &[*v]);
                }
            }
            return;
        }
        if self.body.has(op, Trait::ReturnLike)
            && let Some(p) = self.body.parent_op(op).filter(|p| self.is_callable(*p))
        {
            if let Some(u) = &self.unit {
                let (unknown, live) = u.results_live.get(&p).cloned().unwrap_or_default();
                if unknown {
                    return operands.iter().for_each(|v| self.mark_alive(*v));
                }
                for (v, l) in operands.iter().zip(live) {
                    if l {
                        self.mark_alive(*v);
                    }
                }
                return;
            }
            let cs = self.preds.get(&Pt::After(p)).cloned().unwrap_or_default();
            if cs.unknown {
                return operands.iter().for_each(|v| self.mark_alive(*v));
            }
            for call in cs.known {
                for (v, r) in operands.iter().zip(self.body[call].results.clone()) {
                    self.meet_alive(*v, r);
                }
            }
            return;
        }
        self.liveness_visit(op, &operands);
    }

    /// Every op under `op` onto the worklist, in the order a backward sweep visits them.
    fn enqueue_backward(&mut self, op: OpId) {
        if self.unit.as_ref().is_some_and(|u| u.skip.contains(&op)) {
            return;
        }
        self.push_op(op);
        for r in self.body[op].regions.clone() {
            for b in self.body[r].blocks.clone() {
                for o in self.body.block_ops(b).into_iter().rev() {
                    self.enqueue_backward(o);
                }
            }
        }
    }

    /// `RunLivenessAnalysis`'s liveness, the baseline analyses done ([`run`](Self::run)): to its
    /// fixed point off the worklist (every op once, then those a newly live value reaches).
    fn run_liveness_only(&mut self) {
        let top = self.top;
        self.enqueue_backward(top);
        self.drain_backward();
    }
}
