//! `cse`: common subexpression elimination, as `CSE.cpp`.
//!
//! Regions are walked in dominator-tree order with a scoped table of known ops; an op equivalent
//! to a known one (memory-effect free, or only reading with no write in between in the same
//! block) is replaced by it. Trivially dead ops go too. Everything is erased at the end.

use alloc::vec::Vec;

use crate::pass;
use mlirformat::Error;

use crate::{Body, BlockId, DomTree, EffectKind, OpId, RegionId, Trait};

#[pass("cse")]
pub fn cse<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    body.cse(op);
    Ok(())
}

/// The scoped table of known ops: a lookup finds the latest equivalent one in scope.
#[derive(Default)]
struct Known {
    ops: Vec<OpId>,
    scopes: Vec<usize>,
}

impl Known {
    fn open(&mut self) {
        self.scopes.push(self.ops.len());
    }

    fn close(&mut self) {
        let n = self.scopes.pop().expect("no scope");
        self.ops.truncate(n);
    }

    fn lookup(&self, body: &Body<'_>, op: OpId) -> Option<OpId> {
        self.ops.iter().rev().copied().find(|k| body.equivalent(*k, op))
    }
}

/// One run's state.
#[derive(Default)]
struct Driver {
    erase: Vec<OpId>,
}

impl Driver {
    /// No op between `from` and `to` (same block) might write.
    fn write_between(&self, body: &Body<'_>, from: OpId, to: OpId) -> bool {
        let block = body[from].parent.expect("placed");
        let ops = &body[block].ops;
        let (i, j) = (body.position(from), body.position(to));
        ops[i + 1..j].iter().any(|o| body.effects_recursively(*o).is_none_or(|e| e.iter().any(|x| x.kind == EffectKind::Write)))
    }

    fn replace(&mut self, body: &mut Body<'_>, known: &Known, op: OpId, existing: OpId, ssa: bool) {
        let pairs: Vec<_> = body[op].results.iter().copied().zip(body[existing].results.iter().copied()).collect();
        if ssa {
            pairs.into_iter().for_each(|(from, to)| body.replace_all_uses(from, to));
            self.erase.push(op);
        } else {
            // Only uses not yet visited: a graph region may use a value before its definition.
            for (from, to) in pairs {
                for u in body[from].uses.clone() {
                    if known.lookup(body, u.op).is_none() {
                        body.set_operand(u.op, u.index as usize, to);
                    }
                }
            }
            if body[op].results.iter().all(|r| body[*r].uses.is_empty()) {
                self.erase.push(op);
            }
        }
        if body[existing].loc.as_deref() == Some("unknown") && body[op].loc.as_deref().is_some_and(|l| l != "unknown") {
            body[existing].loc = body[op].loc.clone();
        }
    }

    /// Whether `op` was simplified away.
    fn operation(&mut self, body: &mut Body<'_>, known: &mut Known, op: OpId, ssa: bool) -> bool {
        if body.has(op, Trait::IsTerminator) {
            return false;
        }
        if body.is_trivially_dead(op) {
            self.erase.push(op);
            return true;
        }
        if !body[op].regions.iter().all(|r| body[*r].blocks.len() <= 1) {
            return false;
        }
        if !body.is_memory_effect_free(op) {
            if !body.has_only_effect(op, EffectKind::Read) {
                return false;
            }
            if let Some(existing) = known.lookup(body, op)
                && body[existing].parent == body[op].parent
                && !self.write_between(body, existing, op)
            {
                self.replace(body, known, op, existing, ssa);
                return true;
            }
            known.ops.push(op);
            return false;
        }
        if let Some(existing) = known.lookup(body, op) {
            self.replace(body, known, op, existing, ssa);
            return true;
        }
        known.ops.push(op);
        false
    }

    fn block(&mut self, body: &mut Body<'_>, known: &mut Known, block: BlockId, ssa: bool) {
        for op in body[block].ops.clone() {
            let regions = body[op].regions.clone();
            if !regions.is_empty() {
                if body.might_have(op, Trait::IsIsolatedFromAbove) {
                    let mut nested = Known::default();
                    regions.into_iter().for_each(|r| self.region(body, &mut nested, r));
                } else {
                    regions.into_iter().for_each(|r| self.region(body, known, r));
                }
            }
            self.operation(body, known, op, ssa);
        }
    }

    fn region(&mut self, body: &mut Body<'_>, known: &mut Known, region: RegionId) {
        let Some(&entry) = body[region].blocks.first() else { return };
        let ssa = body.has_ssa_dominance(region);
        if body[region].blocks.len() == 1 {
            known.open();
            self.block(body, known, entry, ssa);
            known.close();
            return;
        }
        if !ssa {
            return;
        }
        let tree = body.dom_tree(region);
        self.node(body, known, &tree, tree.root, ssa);
    }

    fn node(&mut self, body: &mut Body<'_>, known: &mut Known, tree: &DomTree, b: BlockId, ssa: bool) {
        known.open();
        self.block(body, known, b, ssa);
        for c in tree.children(b) {
            self.node(body, known, tree, *c, ssa);
        }
        known.close();
    }
}

impl Body<'_> {
    /// ⭐ `eliminateCommonSubExpressions` on everything inside `op`; whether anything changed.
    pub fn cse(&mut self, op: OpId) -> bool {
        let mut d = Driver::default();
        let mut known = Known::default();
        for r in self[op].regions.clone() {
            d.region(self, &mut known, r);
        }
        let changed = !d.erase.is_empty();
        d.erase.into_iter().for_each(|o| self.erase(o));
        changed
    }
}
