//! `RegionBranchOpInterface`: where control goes between an op and its regions, and which
//! values flow along: each dialect's [`OpInterfaces`](crate::OpInterfaces) answer
//! `getSuccessorRegions`, `getEntrySuccessorOperands` and
//! `RegionBranchTerminatorOpInterface::getSuccessorOperands` for its ops.

use alloc::collections::BTreeMap;
use alloc::vec;
use alloc::vec::Vec;

use crate::{Body, OpData, OpId, ValueId};

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
