//! The data-flow analyses `sccp` and `remove-dead-values` run: `DeadCodeAnalysis`,
//! `SparseConstantPropagation` and `LivenessAnalysis`.
//!
//! Each is monotone, so its fixed point does not depend on visiting order: it is reached here
//! by sweeping the IR until nothing changes.

use alloc::collections::{BTreeMap, BTreeSet};
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

/// A program point: after an op, or the start of a block.
#[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
enum Pt {
    After(OpId),
    Block(BlockId),
}

pub struct Solver<'b, 'a> {
    pub body: &'b mut Body<'a>,
    pub top: OpId,
    live: BTreeSet<BlockId>,
    edges: BTreeSet<(BlockId, BlockId)>,
    preds: BTreeMap<Pt, Preds>,
    /// Per value (by id); past the end: `Uninit`.
    lat: Vec<Cv<'a>>,
    changed: bool,
    /// `Liveness`: the values found live.
    pub alive: BTreeSet<ValueId>,
    /// The sweep under way, from 1.
    round: u32,
    /// Per value, the sweep its lattice last changed in.
    changed_in: Vec<u32>,
    /// Per op, the sweep `sparse_op` last folded it in (0: never, or it must fold every time):
    /// it need not fold again until one of its operands changes.
    folded_in: Vec<u32>,
    /// Each call's [`resolve`](Self::resolve): the IR does not change while solving.
    callees: BTreeMap<OpId, Option<OpId>>,
}

/// `v[i]`, grown with zeros as ids are made.
fn at(v: &mut Vec<u32>, i: usize) -> &mut u32 {
    if v.len() <= i {
        v.resize(i + 1, 0);
    }
    &mut v[i]
}

impl<'b, 'a> Solver<'b, 'a> {
    pub fn new(body: &'b mut Body<'a>, top: OpId) -> Self {
        Self { body, top, live: BTreeSet::new(), edges: BTreeSet::new(), preds: BTreeMap::new(), lat: Vec::new(), changed: false, alive: BTreeSet::new(), round: 0, changed_in: Vec::new(), folded_in: Vec::new(), callees: BTreeMap::new() }
    }

    pub fn get(&self, v: ValueId) -> Cv<'a> {
        self.lat.get(usize::from(v)).cloned().unwrap_or(Cv::Uninit)
    }

    fn join(&mut self, v: ValueId, c: &Cv<'a>) {
        let old = self.get(v);
        let new = old.join(c);
        if new != old {
            let i = usize::from(v);
            if self.lat.len() <= i {
                self.lat.resize(i + 1, Cv::Uninit);
            }
            self.lat[i] = new;
            self.changed = true;
            *at(&mut self.changed_in, usize::from(v)) = self.round;
        }
    }

    fn unknown(&mut self, vs: &[ValueId]) {
        for v in vs {
            self.join(*v, &Cv::Unknown);
        }
    }

    fn mark_live(&mut self, b: BlockId) {
        self.changed |= self.live.insert(b);
    }

    fn preds_mut(&mut self, p: Pt) -> &mut Preds {
        self.preds.entry(p).or_default()
    }

    fn set_unknown_preds(&mut self, p: Pt) {
        let s = self.preds_mut(p);
        if !s.unknown {
            s.unknown = true;
            self.changed = true;
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
        self.changed |= ch;
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
        b[op].successors.is_empty() && (self.is_region_branch(p) || self.is_callable(p)) && b[blk].ops.last() == Some(&op)
    }

    /// `DeadCodeAnalysis::visit` of the point after `op`.
    fn dca(&mut self, op: OpId) {
        if !self.block_live(op) {
            return;
        }
        if self.body.has(op, Trait::CallOpInterface) {
            let callee = self.callee(op);
            let external = |s: &Self, c: OpId| !s.is_ancestor(s.top, c) || (s.is_callable(c) && s.callable_region(c).is_none());
            match callee {
                Some(c) if self.body.has(c, Trait::SymbolOpInterface) && !external(self, c) => self.join_pred(Pt::After(c), op, &[]),
                _ => self.set_unknown_preds(Pt::After(op)),
            }
        }
        if !self.body[op].regions.is_empty() {
            if self.is_region_branch(op) {
                if let Some(c) = self.operand_values(op) {
                    let s = self.entry_successors(op, &c);
                    self.edges_to(op, op, &s);
                }
            } else if self.is_callable(op) {
                let cs = self.preds.get(&Pt::After(op)).cloned().unwrap_or_default();
                if cs.unknown || !cs.known.is_empty() {
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
                    None => self.body[op].successors.clone(),
                }
            } else {
                self.body[op].successors.clone()
            };
            for t in targets {
                self.mark_live(t);
                self.changed |= self.edges.insert((from, t));
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
        let last = self.folded_in.get(usize::from(op)).copied().unwrap_or(0);
        if last != 0 && self.body[op].operands.iter().all(|v| self.changed_in.get(usize::from(*v)).copied().unwrap_or(0) < last) {
            return;
        }
        *at(&mut self.folded_in, usize::from(op)) = self.round;
        let Some(consts) = self.operand_values(op) else { return };
        let dialect: String = self.body[op].name.split_once('.').map_or("", |(d, _)| d).into();
        if self.body.has(op, Trait::ConstantLike)
            && let Some(v) = self.body.constant_value(op)
        {
            return self.join(results[0], &Cv::Known(v, dialect));
        }
        let saved = (self.body[op].operands.clone(), self.body[op].properties.clone(), self.body[op].attributes.clone());
        match self.body.fold_with(op, &consts) {
            Fold::Results(rs) => {
                for (r, f) in results.iter().zip(rs) {
                    let c = match f {
                        Folded::Attr(a) => Cv::Known(a, dialect.clone()),
                        Folded::Value(v) => {
                            // A value of its own: the op depends on more than its operands.
                            self.folded_in[usize::from(op)] = 0;
                            self.get(v)
                        }
                    };
                    self.join(*r, &c);
                }
            }
            Fold::InPlace => {
                self.body.set_operands(op, saved.0);
                self.body[op].properties = saved.1;
                self.body[op].attributes = saved.2;
                self.unknown(&results);
            }
            Fold::Failed => self.unknown(&results),
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

    fn sweep(&mut self, op: OpId) {
        self.dca(op);
        self.sparse_op(op);
        for r in self.body[op].regions.clone() {
            for b in self.body[r].blocks.clone() {
                self.sparse_block(b);
                for o in self.body[b].ops.clone() {
                    self.sweep(o);
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
                for o in self.body[b].ops.clone() {
                    self.symbol_callables(o, visible);
                }
            }
        }
        if !table {
            return;
        }
        let Some(&blk) = self.body[op].regions.first().and_then(|r| self.body[*r].blocks.first()) else { return };
        let mut found = false;
        for c in self.body[blk].ops.clone() {
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
        loop {
            self.round += 1;
            self.changed = false;
            self.sweep(top);
            if !self.changed {
                break;
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
        self.changed |= self.alive.insert(v);
    }

    /// `meet(operand, value)`: `operand` is live once `value` is.
    fn meet_alive(&mut self, operand: ValueId, value: ValueId) {
        if self.alive.contains(&value) {
            self.mark_alive(operand);
        }
    }

    /// `LivenessAnalysis::visitOperation`, for `operands` of `op`.
    fn liveness_visit(&mut self, op: OpId, operands: &[ValueId]) {
        let any_result = self.body[op].results.iter().any(|r| self.alive.contains(r));
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
            let results_live = self.body[op].results.iter().any(|r| self.alive.contains(r));
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

    fn backward_sweep(&mut self, op: OpId) {
        self.backward(op);
        for r in self.body[op].regions.clone() {
            for b in self.body[r].blocks.clone() {
                for o in self.body[b].ops.clone().into_iter().rev() {
                    self.backward_sweep(o);
                }
            }
        }
    }

    /// `RunLivenessAnalysis`: the baseline analyses, then liveness, to their fixed points.
    pub fn run_liveness(&mut self) {
        self.run();
        loop {
            self.changed = false;
            let top = self.top;
            self.backward_sweep(top);
            if !self.changed {
                break;
            }
        }
    }

    pub fn is_alive(&self, v: ValueId) -> bool {
        self.alive.contains(&v)
    }
}
