//! `loop-invariant-code-motion`, as `LoopInvariantCodeMotionUtils.cpp`.

use alloc::collections::VecDeque;
use alloc::vec::Vec;

use crate::pass;
use mlirformat::Error;

use crate::{Body, OpId, RegionId, Trait, ValueId};

#[pass("loop-invariant-code-motion")]
pub fn loop_invariant_code_motion<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    // Innermost loops first, so hoisted ops can move on out of the enclosing loop.
    let loops: Vec<OpId> = body.post_order_ops(op).into_iter().filter(|l| body.loop_regions(*l).is_some()).collect();
    for l in loops {
        body.move_loop_invariant_code(l);
    }
    Ok(())
}

impl<'a> Body<'a> {
    /// Every op nested in `op` (and `op` last), post-order, as `Operation::walk`.
    pub fn post_order_ops(&self, op: OpId) -> Vec<OpId> {
        let mut out = Vec::new();
        self.post_order_into(op, &mut out);
        out
    }

    fn post_order_into(&self, op: OpId, out: &mut Vec<OpId>) {
        for r in &self[op].regions {
            for b in &self[*r].blocks {
                for o in &self[*b].ops {
                    self.post_order_into(*o, out);
                }
            }
        }
        out.push(op);
    }

    /// `LoopLikeOpInterface::getLoopRegions`.
    pub fn loop_regions(&self, op: OpId) -> Option<Vec<RegionId>> {
        if !self.has(op, Trait::LoopLikeOpInterface) {
            return None;
        }
        let r = &self[op].regions;
        Some(match &*self[op].name {
            "scf.while" => r.clone(),
            _ => r.first().map(|x| alloc::vec![*x]).unwrap_or_default(),
        })
    }

    /// `isDefinedOutsideOfLoop`.
    fn defined_outside(&self, l: OpId, v: ValueId) -> bool {
        let owner = match self[v].def {
            crate::Def::Result(o, _) => self.parent_op(o),
            crate::Def::Arg(b, _) => self.block_owner(b),
        };
        !owner.is_some_and(|o| self.is_ancestor(l, o))
    }

    /// Whether `a` is `b` or contains it.
    pub fn is_ancestor(&self, a: OpId, b: OpId) -> bool {
        let mut at = Some(b);
        while let Some(o) = at {
            if o == a {
                return true;
            }
            at = self.parent_op(o);
        }
        false
    }

    /// `canBeHoisted`: not a terminator, and every value it (or anything in it) uses from
    /// outside itself is defined outside the loop.
    fn can_be_hoisted(&self, l: OpId, op: OpId) -> bool {
        if self.has(op, Trait::IsTerminator) {
            return false;
        }
        let mut ok = true;
        self.walk(op, &mut |child| {
            for v in &self[child].operands {
                let owner = match self[*v].def {
                    crate::Def::Result(o, _) => self.parent_op(o),
                    crate::Def::Arg(b, _) => self.block_owner(b),
                };
                if owner.is_some_and(|o| self.is_ancestor(op, o)) {
                    continue;
                }
                if !self.defined_outside(l, *v) {
                    ok = false;
                }
            }
        });
        ok
    }

    /// `moveLoopInvariantCode`: pure ops whose operands come from outside move before the
    /// loop.
    pub fn move_loop_invariant_code(&mut self, l: OpId) -> usize {
        let mut moved = 0;
        for region in self.loop_regions(l).unwrap_or_default() {
            let mut work: VecDeque<OpId> = self[region].blocks.iter().flat_map(|b| self[*b].ops.clone()).collect();
            while let Some(op) = work.pop_front() {
                if self[op].parent.and_then(|b| self[b].parent) != Some(region) {
                    continue;
                }
                if !self.is_pure(op) || !self.can_be_hoisted(l, op) {
                    continue;
                }
                self.detach(op);
                self.insert_before(op, l);
                moved += 1;
                for r in self[op].results.clone() {
                    // MLIR's use lists are most-recent-first.
                    for u in self[r].uses.iter().rev() {
                        if self[u.op].parent.and_then(|b| self[b].parent) == Some(region) {
                            work.push_back(u.op);
                        }
                    }
                }
            }
        }
        moved
    }
}
