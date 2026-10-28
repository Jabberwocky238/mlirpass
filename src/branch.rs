//! `BranchOpInterface`: which operands of a branch go to which successor's arguments.

use alloc::borrow::Cow;
use alloc::collections::BTreeMap;
use alloc::vec::Vec;
use alloc::{format, vec};

use mlirformat::Attribute;

use crate::{Body, BranchLayout as Layout, OpData, OpId, ValueId};

impl Body<'_> {
    fn layout(&self, op: OpId) -> Option<Layout> {
        self.interfaces(op)?.branch_layout(self, op)
    }

    /// The sizes in dense array `name` of `op` (`operandSegmentSizes` and the like).
    pub fn segments(&self, op: OpId, name: &str) -> Option<Vec<usize>> {
        match self[op].get(name)? {
            Attribute::DenseArray { values, .. } => Some(values.iter().map(|v| v.parse().unwrap_or(0)).collect()),
            _ => None,
        }
    }

    pub fn set_segments(&mut self, op: OpId, name: &str, sizes: &[usize]) {
        let Some(Attribute::DenseArray { ty, .. }) = self[op].get(name).cloned() else { return };
        let values = sizes.iter().map(|s| Cow::Owned(format!("{s}"))).collect();
        self[op].set(name, Attribute::DenseArray { ty, values });
    }

    /// Start of operand group `g`.
    fn group_start(&self, op: OpId, g: usize) -> usize {
        self.segments(op, "operandSegmentSizes").map_or(g, |s| s.iter().take(g).sum())
    }

    /// ⭐ `getSuccessorOperands(i)`: the flat operand range forwarded to successor `i`'s
    /// arguments; `None` when `op` is not a branch this crate knows.
    pub fn successor_operands(&self, op: OpId, i: usize) -> Option<core::ops::Range<usize>> {
        let n = self[op].operands.len();
        match self.layout(op)? {
            Layout::All => Some(0..n),
            Layout::Groups { first } => {
                let sizes = self.segments(op, "operandSegmentSizes")?;
                let start = self.group_start(op, first + i);
                Some(start..start + sizes.get(first + i).copied().unwrap_or(0))
            }
            Layout::Cases { default, cases, split } => {
                if let (Some(d), 0) = (default, i) {
                    let sizes = self.segments(op, "operandSegmentSizes")?;
                    let start = self.group_start(op, d);
                    return Some(start..start + sizes[d]);
                }
                let k = i - usize::from(default.is_some());
                let parts = self.segments(op, split)?;
                let start = self.group_start(op, cases) + parts.iter().take(k).sum::<usize>();
                Some(start..start + parts.get(k).copied().unwrap_or(0))
            }
        }
    }

    /// Whether `op` implements `BranchOpInterface` (as far as this crate knows).
    pub fn is_branch(&self, op: OpId) -> bool {
        self.layout(op).is_some()
    }

    /// `SuccessorOperands` of successor `i`: the produced arguments, then the range of the
    /// forwarded operands.
    pub fn successor_layout(&self, op: OpId, i: usize) -> Option<(usize, core::ops::Range<usize>)> {
        match self.interfaces(op).and_then(|f| f.produced_successor_operands(self, op, i)) {
            Some(l) => Some(l),
            None => self.successor_operands(op, i).map(|r| (0, r)),
        }
    }

    /// Whether `op` forwards operands to its successors: a branch, or a terminator whose
    /// successor operands also produce arguments.
    pub fn forwards_to_successors(&self, op: OpId) -> bool {
        self.is_branch(op) || self.interfaces(op).is_some_and(|f| f.produced_successor_operands(self, op, 0).is_some())
    }

    /// Appends `values` to the operands forwarded to successor `i`.
    pub fn append_successor_operands(&mut self, op: OpId, i: usize, values: &[crate::ValueId]) {
        let Some(range) = self.successor_operands(op, i) else { return };
        let mut operands = self[op].operands.clone();
        operands.splice(range.end..range.end, values.iter().copied());
        self.set_operands(op, operands);
        self.resize_successor_group(op, i, values.len() as isize);
    }

    /// Grows (or shrinks) the segment sizes of successor `i`'s operand group by `by`.
    fn resize_successor_group(&mut self, op: OpId, i: usize, by: isize) {
        let group = match self.layout(op) {
            Some(Layout::Groups { first }) => Some(first + i),
            Some(Layout::Cases { default: Some(d), .. }) if i == 0 => Some(d),
            Some(Layout::Cases { default, cases, split }) => {
                let k = i - usize::from(default.is_some());
                if let Some(mut parts) = self.segments(op, split) {
                    parts[k] = parts[k].saturating_add_signed(by);
                    self.set_segments(op, split, &parts);
                }
                Some(cases)
            }
            _ => None,
        };
        if let (Some(g), Some(mut sizes)) = (group, self.segments(op, "operandSegmentSizes")) {
            sizes[g] = sizes[g].saturating_add_signed(by);
            self.set_segments(op, "operandSegmentSizes", &sizes);
        }
    }

    /// Drops the `j`th operand forwarded to successor `i`, keeping the segment sizes right.
    pub fn erase_successor_operand(&mut self, op: OpId, i: usize, j: usize) {
        let Some(range) = self.successor_operands(op, i) else { return };
        let at = range.start + j;
        let mut operands = self[op].operands.clone();
        operands.remove(at);
        self.set_operands(op, operands);
        self.resize_successor_group(op, i, -1);
    }

    /// `BranchOpInterface`'s verifier over everything in `root`: forwarded operands have the
    /// types of their successor's arguments.
    pub fn verify_branches(&self, root: OpId) -> Result<(), mlirformat::Error> {
        for op in self.ops_in(root) {
            for (i, succ) in self[op].successors.iter().enumerate() {
                let Some(range) = self.successor_operands(op, i) else { continue };
                let args = &self[*succ].args;
                for (j, (v, a)) in self[op].operands[range].iter().zip(args).enumerate() {
                    if self[*v].ty != self[*a].ty {
                        return Err(mlirformat::Error(format!("'{}' op type mismatch for bb argument #{j} of successor #{i}", self[op].name)));
                    }
                }
            }
        }
        Ok(())
    }
}

// `RegionBranchOpInterface`: where control goes between an op and its regions, and which
// values flow along: each dialect's [`OpInterfaces`](crate::OpInterfaces) answer
// `getSuccessorRegions`, `getEntrySuccessorOperands` and
// `RegionBranchTerminatorOpInterface::getSuccessorOperands` for its ops.

/// Where control is: entering from the parent op, or at a region's terminator.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Point {
    Parent,
    Terminator(OpId),
}

/// Where control goes.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Succ {
    Parent,
    Region(usize),
}

/// One operand by its owner and index.
pub type Operand = (OpId, usize);

impl<'a> Body<'a> {
    /// Whether `op` implements the interface, as far as this crate describes it.
    pub fn is_region_branch(&self, op: OpId) -> bool {
        self.interfaces(op).is_some_and(|i| i.is_region_branch(self, op))
    }

    /// The entry block's arguments of region `r` of `op`, from `skip` on.
    pub fn region_args(&self, op: OpId, r: usize, skip: usize) -> Vec<ValueId> {
        let region = self[op].regions[r];
        self[region].blocks.first().map(|b| self[*b].args.iter().skip(skip).copied().collect()).unwrap_or_default()
    }

    /// `getSuccessorRegions(point)`: each successor with its inputs.
    pub fn region_successors(&self, op: OpId, point: Point) -> Vec<(Succ, Vec<ValueId>)> {
        self.interfaces(op).map(|i| i.region_successors(self, op, point)).unwrap_or_default()
    }

    /// The operands flowing from `point` to its successors.
    pub fn forwarded(&self, op: OpId, point: Point) -> Vec<Operand> {
        match point {
            Point::Parent => self.interfaces(op).map(|i| i.entry_operands(self, op)).unwrap_or_default(),
            Point::Terminator(t) => {
                let skip = self.interfaces(t).map_or(0, |i| i.terminator_skip(self, t));
                (skip..self[t].operands.len()).map(|i| (t, i)).collect()
            }
        }
    }

    /// `getAllRegionBranchPoints`: the parent, then each region terminator in order.
    pub fn branch_points(&self, op: OpId) -> Vec<Point> {
        let mut out = vec![Point::Parent];
        for r in &self[op].regions {
            for b in &self[*r].blocks {
                if let Some(&t) = self[*b].ops.last()
                    && self.interfaces(t).is_some_and(|i| i.is_region_terminator(self, t))
                {
                    out.push(Point::Terminator(t));
                }
            }
        }
        out
    }

    /// `getSuccessorOperandInputMapping`: each forwarded operand with the inputs it reaches.
    pub fn operand_inputs(&self, op: OpId) -> Vec<(Operand, Vec<ValueId>)> {
        let mut out: Vec<(Operand, Vec<ValueId>)> = Vec::new();
        for p in self.branch_points(op) {
            let operands = self.forwarded(op, p);
            for (_, inputs) in self.region_successors(op, p) {
                for (o, i) in operands.iter().zip(inputs) {
                    match out.iter_mut().find(|e| e.0 == *o) {
                        Some(e) => e.1.push(i),
                        None => out.push((*o, vec![i])),
                    }
                }
            }
        }
        out
    }

    /// The inverse: each input with the operands that reach it, inputs in first-seen order.
    pub fn input_operands(&self, op: OpId) -> Vec<(ValueId, Vec<Operand>)> {
        let mut out: Vec<(ValueId, Vec<Operand>)> = Vec::new();
        for (o, inputs) in self.operand_inputs(op) {
            for i in inputs {
                match out.iter_mut().find(|e| e.0 == i) {
                    Some(e) => e.1.push(o),
                    None => out.push((i, vec![o])),
                }
            }
        }
        out
    }

    /// `eraseOperands` on `op`, keeping the uses right.
    pub fn erase_operands(&mut self, op: OpId, which: &[usize]) {
        let kept = self[op].operands.iter().enumerate().filter(|(i, _)| !which.contains(i)).map(|(_, v)| *v).collect();
        self.set_operands(op, kept);
    }
}

/// Value and block correspondences for cloning (`IRMapping`).
#[derive(Debug, Default, Clone)]
pub struct Mapping {
    pub values: BTreeMap<ValueId, ValueId>,
    pub blocks: BTreeMap<crate::BlockId, crate::BlockId>,
}

impl Mapping {
    pub fn map(&mut self, from: ValueId, to: ValueId) {
        self.values.insert(from, to);
    }

    pub fn get(&self, v: ValueId) -> ValueId {
        self.values.get(&v).copied().unwrap_or(v)
    }
}

impl<'a> Body<'a> {
    /// `Operation::clone`: a detached deep copy of `op`, operands through `map`.
    pub fn clone_op(&mut self, op: OpId, map: &mut Mapping) -> OpId {
        let d = self[op].clone();
        let types = self.types(&d.results);
        let data = OpData { operands: d.operands.iter().map(|v| map.get(*v)).collect(), successors: d.successors.iter().map(|b| map.blocks.get(b).copied().unwrap_or(*b)).collect(), regions: Vec::new(), parent: None, ..d };
        let new = self.create(data, &types);
        for (a, b) in self[op].results.clone().into_iter().zip(self[new].results.clone()) {
            map.map(a, b);
        }
        for r in self[op].regions.clone() {
            let nr = self.add_region(new);
            self.clone_region_into(r, nr, None, map);
        }
        new
    }

    /// `Region::cloneInto`: `from`'s blocks copied into `into` before `before` (`None`: the
    /// end); operands referring forward are remapped once everything is copied.
    pub fn clone_region_into(&mut self, from: crate::RegionId, into: crate::RegionId, before: Option<crate::BlockId>, map: &mut Mapping) -> Vec<crate::BlockId> {
        let blocks = self[from].blocks.clone();
        let mut made = Vec::new();
        for b in &blocks {
            // An argument the mapping already has is not created again.
            let fresh: Vec<ValueId> = self[*b].args.iter().copied().filter(|a| !map.values.contains_key(a)).collect();
            let args: Vec<_> = fresh.iter().map(|a| (self[*a].ty.clone(), self[*a].loc.clone())).collect();
            let nb = self.add_block(into, &args);
            // `add_block` appends; move into place.
            if let Some(at) = before {
                self[into].blocks.pop();
                let pos = self[into].blocks.iter().position(|x| *x == at).expect("block not in region");
                self[into].blocks.insert(pos + made.len(), nb);
            }
            for (x, y) in fresh.into_iter().zip(self[nb].args.clone()) {
                map.map(x, y);
            }
            map.blocks.insert(*b, nb);
            made.push(nb);
        }
        let mut cloned = Vec::new();
        for (b, nb) in blocks.iter().zip(&made) {
            for o in self[*b].ops.clone() {
                let c = self.clone_op(o, map);
                self.insert(c, *nb, None);
                cloned.push(c);
            }
        }
        // Remap what was cloned before its definition (forward references, successors).
        for c in cloned {
            for o in self.ops_in(c) {
                for i in 0..self[o].operands.len() {
                    let v = self[o].operands[i];
                    let m = map.get(v);
                    if m != v {
                        self.set_operand(o, i, m);
                    }
                }
                for s in self[o].successors.iter_mut() {
                    if let Some(n) = map.blocks.get(s) {
                        *s = *n;
                    }
                }
            }
        }
        made
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
            for o in self.body[b].ops.clone() {
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
        let data = OpData { regions: Vec::new(), results: Vec::new(), parent: None, ..d.clone() };
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
