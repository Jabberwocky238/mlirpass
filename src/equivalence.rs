//! `OperationEquivalence::isEquivalentTo`, ignoring locations.

use alloc::collections::BTreeMap;
use alloc::vec::Vec;

use crate::{Body, BlockId, OpId, RegionId, Trait, ValueId};

/// Values known equivalent while comparing nested regions.
#[derive(Default)]
struct Equivalence {
    values: BTreeMap<ValueId, ValueId>,
}

impl Equivalence {
    fn check(&self, l: ValueId, r: ValueId) -> bool {
        l == r || self.values.get(&l) == Some(&r)
    }

    /// In order, or else as a permutation of the same values (both sides sorted).
    fn check_commutative(&self, l: &[ValueId], r: &[ValueId]) -> bool {
        if l.len() != r.len() {
            return false;
        }
        if l.iter().zip(r).all(|(a, b)| self.check(*a, *b)) {
            return true;
        }
        let (mut ls, mut rs): (Vec<_>, Vec<_>) = (l.to_vec(), r.to_vec());
        ls.sort();
        rs.sort();
        ls.iter().zip(&rs).all(|(a, b)| self.check(*a, *b))
    }
}

impl Body<'_> {
    /// ⭐ Whether `l` and `r` compute the same thing: name, attributes, properties, operands
    /// (as a permutation for commutative ops), result types and regions.
    pub fn equivalent(&self, l: OpId, r: OpId) -> bool {
        self.equivalent_in(l, r, &mut Equivalence::default())
    }

    fn equivalent_in(&self, l: OpId, r: OpId, eq: &mut Equivalence) -> bool {
        if l == r {
            return true;
        }
        let (a, b) = (&self[l], &self[r]);
        if a.attributes != b.attributes || a.name != b.name || a.regions.len() != b.regions.len() || a.successors.len() != b.successors.len() || a.operands.len() != b.operands.len() || a.results.len() != b.results.len() || a.properties != b.properties {
            return false;
        }
        if self.has(l, Trait::IsCommutative) {
            if !eq.check_commutative(&a.operands, &b.operands) {
                return false;
            }
        } else if !a.operands.iter().zip(&b.operands).all(|(x, y)| x == y || (self[*x].ty == self[*y].ty && eq.check(*x, *y))) {
            return false;
        }
        for (x, y) in a.results.iter().zip(&b.results) {
            if self[*x].ty != self[*y].ty {
                return false;
            }
            eq.values.insert(*x, *y);
        }
        a.regions.iter().zip(&b.regions).all(|(x, y)| self.regions_equivalent(*x, *y, eq))
    }

    fn regions_equivalent(&self, l: RegionId, r: RegionId, eq: &mut Equivalence) -> bool {
        let mut blocks: BTreeMap<BlockId, BlockId> = BTreeMap::new();
        let (lb, rb) = (&self[l].blocks, &self[r].blocks);
        if lb.len() != rb.len() {
            return false;
        }
        for (x, y) in lb.iter().zip(rb) {
            let (bx, by) = (&self[*x], &self[*y]);
            if bx.args.len() != by.args.len() || *blocks.entry(*x).or_insert(*y) != *y {
                return false;
            }
            for (p, q) in bx.args.iter().zip(&by.args) {
                if self[*p].ty != self[*q].ty {
                    return false;
                }
                eq.values.insert(*p, *q);
            }
            if bx.ops.len() != by.ops.len() {
                return false;
            }
            for (o, p) in bx.ops.iter().zip(&by.ops) {
                if !self.equivalent_in(*o, *p, eq) {
                    return false;
                }
                for (s, t) in self[*o].successors.iter().zip(&self[*p].successors) {
                    if *blocks.entry(*s).or_insert(*t) != *t {
                        return false;
                    }
                }
            }
        }
        true
    }
}
