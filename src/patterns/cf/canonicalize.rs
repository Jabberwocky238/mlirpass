//! `cf`: canonicalization patterns, as `ControlFlowOps.cpp`.

use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{arith, Attribute, Type};

use crate::{ApInt, Body, BlockId, Const, OpData, OpId, Rewriter, ValueId};

impl<'a> Body<'a> {
    /// `getSinglePredecessor`: the one edge into `b`.
    pub fn single_predecessor(&self, b: BlockId) -> Option<BlockId> {
        match self.predecessors(b)[..] {
            [(t, _)] => self[t].parent,
            _ => None,
        }
    }

    /// `getUniquePredecessor`: every edge into `b` comes from the same block.
    pub fn unique_predecessor(&self, b: BlockId) -> Option<BlockId> {
        let preds = self.predecessors(b);
        let first = self[preds.first()?.0].parent?;
        preds.iter().all(|(t, _)| self[*t].parent == Some(first)).then_some(first)
    }

    fn terminator(&self, b: BlockId) -> Option<OpId> {
        self.last_op(b)
    }

    /// `collapseBranch`: if `succ` only forwards to another block with a `cf.br`, the block it
    /// reaches and the operands it would get from `operands`.
    fn collapse_branch(&self, succ: BlockId, operands: &[ValueId]) -> Option<(BlockId, Vec<ValueId>)> {
        if self.len_ops(succ) != 1 {
            return None;
        }
        let br = self.terminator(succ).filter(|t| self[*t].name == "cf.br")?;
        if self[succ].args.iter().any(|a| self[*a].uses.iter().any(|u| u.op != br)) {
            return None;
        }
        let dest = self[br].successors[0];
        if dest == succ {
            return None;
        }
        // A chain of `cf.br` leading into a cycle never ends: leave it.
        let mut visited = vec![succ, dest];
        let mut next = self.terminator(dest).filter(|t| self[*t].name == "cf.br");
        while let Some(n) = next {
            let d = self[n].successors[0];
            if visited.contains(&d) {
                return None;
            }
            visited.push(d);
            next = self.terminator(d).filter(|t| self[*t].name == "cf.br");
        }
        let fwd = &self[br].operands;
        if self[succ].args.is_empty() {
            return Some((dest, fwd.clone().to_vec()));
        }
        let mapped = fwd.iter().map(|v| match self[*v].def {
            crate::Def::Arg(b, i) if b == succ => operands[i as usize],
            _ => *v,
        });
        Some((dest, mapped.collect()))
    }

    fn succ_operands(&self, op: OpId, i: usize) -> Vec<ValueId> {
        self.successor_operands(op, i).map(|r| self[op].operands[r].to_vec()).unwrap_or_default()
    }

    /// A `cf.switch`'s case values.
    fn case_values(&self, op: OpId) -> Option<(Const<'a>, Vec<ApInt>)> {
        let c = Const::try_from(self[op].get("case_values")?).ok()?;
        let n = c.ty.element_count()?;
        let values = (0..n).map(|i| c.at(i).int()).collect::<Option<Vec<_>>>()?;
        Some((c, values))
    }
}

impl<'a> Rewriter<'_, 'a> {
    /// Replaces `op` by `cf.br` to `dest` with `operands`.
    fn br(&mut self, op: OpId, dest: BlockId, operands: &[ValueId]) -> bool {
        self.replace_with(op, OpData::build("cf.br").operands(operands).successors(&[dest]), &[]);
        true
    }

    /// Replaces `op` by a `cf.switch`.
    fn switch(&mut self, op: OpId, flag: ValueId, default: (BlockId, Vec<ValueId>), cases: Vec<(ApInt, BlockId, Vec<ValueId>)>) -> bool {
        let flag_ty = self.body[flag].ty.clone();
        let mut operands = vec![flag];
        operands.extend(&default.1);
        let mut segs = Vec::new();
        for (_, _, ops) in &cases {
            operands.extend(ops);
            segs.push(ops.len());
        }
        let mut data = OpData::build("cf.switch").operands(&operands).successors(&core::iter::once(default.0).chain(cases.iter().map(|c| c.1)).collect::<Vec<_>>()).segments(&[1, default.1.len(), segs.iter().sum()]).with("case_operand_segments", Attribute::dense_i32(&segs));
        if !cases.is_empty() {
            let shape = Type::Shaped(mlirformat::Shaped { kind: mlirformat::ShapedKind::Vector, shape: Some(vec![mlirformat::Dim::Static(cases.len() as i64)]), elem: flag_ty.into(), extras: Vec::new() });
            let values = cases.iter().map(|c| crate::Scalar::Int(c.0)).collect();
            data = data.with("case_values", Const { ty: shape, values, elements: true }.into());
        }
        self.replace_with(op, data, &[]);
        true
    }
}

/// `cf` canonicalization: its rewrite patterns, folds and constant materialization.
pub struct CfCanon;

#[crate::patterns]
impl CfCanon {
    /// `AssertOp::canonicalize`: an assertion of `true` goes.
    #[rewrite("cf.assert")]
    fn assert_true(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
        let b = &*rw.body;
        let one = b.constant_of(b[op].operands[0]).and_then(|a| Const::try_from(&a).ok()).and_then(|c| c.as_int()).is_some_and(ApInt::is_one);
        if !one {
            return false;
        }
        rw.erase_op(op);
        true
    }

    /// `BranchOp::canonicalize`: merge into a single-predecessor successor, or skip a pass-through block.
    #[rewrite("cf.br")]
    fn branch_canonicalize(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
        let b = &*rw.body;
        let succ = b[op].successors[0];
        let parent = b[op].parent.expect("placed");
        if succ != parent && b.predecessors(succ).len() == 1 {
            let operands = b[op].operands.clone();
            rw.erase_op(op);
            rw.merge_blocks(succ, parent, &operands);
            return true;
        }
        let operands = b[op].operands.clone();
        if succ == parent {
            return false;
        }
        if let Some((dest, fwd)) = b.collapse_branch(succ, &operands) {
            return rw.br(op, dest, &fwd);
        }
        CfCanon::uniform_block_args(rw, succ)
    }

    /// `SimplifyUniformBlockArguments`: for any branch, its successors' uniform arguments.
    #[rewrite("_")]
    fn simplify_uniform_block_arguments(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
        if !rw.body.has(op, crate::Trait::BranchOpInterface) {
            return false;
        }
        let succs = rw.body[op].successors.to_vec();
        succs.into_iter().fold(false, |changed, s| CfCanon::uniform_block_args(rw, s) | changed)
    }

    #[rewrite("cf.cond_br")]
    fn simplify_const_cond_branch_pred(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
        let b = &*rw.body;
        let Some(c) = b.constant_of(b[op].operands[0]).and_then(|a| Const::try_from(&a).ok()).and_then(|c| c.as_int()) else { return false };
        let i = usize::from(c.is_zero());
        let (dest, operands) = (b[op].successors[i], b.succ_operands(op, i));
        rw.br(op, dest, &operands)
    }

    #[rewrite("cf.cond_br")]
    fn simplify_pass_through_cond_branch(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
        let b = &*rw.body;
        let (t, f) = (b[op].successors[0], b[op].successors[1]);
        let (to, fo) = (b.succ_operands(op, 0), b.succ_operands(op, 1));
        let ct = b.collapse_branch(t, &to);
        let cf = b.collapse_branch(f, &fo);
        if ct.is_none() && cf.is_none() {
            return false;
        }
        let (t, to) = ct.unwrap_or((t, to));
        let (f, fo) = cf.unwrap_or((f, fo));
        let cond = b[op].operands[0];
        let mut data = OpData::build("cf.cond_br").operands(&[&[cond][..], &to, &fo].concat()).successors(&[t, f]).segments(&[1, to.len(), fo.len()]);
        if let Some(w) = b[op].get("branch_weights").cloned() {
            data = data.with("branch_weights", w);
        }
        rw.replace_with(op, data, &[]);
        true
    }

    #[rewrite("cf.cond_br")]
    fn simplify_cond_branch_identical_successors(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
        let b = &*rw.body;
        let dest = b[op].successors[0];
        if dest != b[op].successors[1] {
            return false;
        }
        let (to, fo) = (b.succ_operands(op, 0), b.succ_operands(op, 1));
        if to == fo {
            return rw.br(op, dest, &to);
        }
        if b.unique_predecessor(dest) != b[op].parent {
            return false;
        }
        let cond = b[op].operands[0];
        rw.set_before(op);
        let mut merged = Vec::new();
        for (x, y) in to.into_iter().zip(fo) {
            if x == y {
                merged.push(x);
                continue;
            }
            let ty = rw.body[x].ty.clone();
            let s = rw.create(OpData::build("arith.select").operands(&[cond, x, y]), &[ty]);
            merged.push(rw.body[s].results[0]);
        }
        rw.br(op, dest, &merged)
    }

    #[rewrite("cf.cond_br")]
    fn simplify_cond_branch_from_cond_branch_on_same_condition(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
        let b = &*rw.body;
        let current = b[op].parent.expect("placed");
        let Some(pred) = b.single_predecessor(current) else { return false };
        let Some(pb) = b.terminator(pred).filter(|t| b[*t].name == "cf.cond_br") else { return false };
        if b[pb].operands[0] != b[op].operands[0] {
            return false;
        }
        let i = usize::from(b[pb].successors[0] != current);
        let (dest, operands) = (b[op].successors[i], b.succ_operands(op, i));
        rw.br(op, dest, &operands)
    }

    #[rewrite("cf.cond_br")]
    fn cond_branch_truth_propagation(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
        let mut replaced = false;
        let cond = rw.body[op].operands[0];
        for (i, value) in [(0, true), (1, false)] {
            let dest = rw.body[op].successors[i];
            if rw.body.single_predecessor(dest).is_none() {
                continue;
            }
            let mut constant = None;
            for u in rw.body[cond].uses.clone().into_iter().rev() {
                if rw.body[u.op].parent != Some(dest) {
                    continue;
                }
                replaced = true;
                let c = match constant {
                    Some(c) => c,
                    None => {
                        rw.set_before(op);
                        let c = rw.emit(&arith::Constant::new(Attribute::Bool(value), Type::I1));
                        let v = rw.body[c].results[0];
                        constant = Some(v);
                        v
                    }
                };
                rw.modify(u.op, |b| b.set_operand(u.op, u.index as usize, c));
            }
        }
        replaced
    }

    #[rewrite("cf.cond_br")]
    fn drop_unreachable_cond_branch(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
        let b = &*rw.body;
        let (t, f) = (b[op].successors[0], b[op].successors[1]);
        let unreachable = |blk: BlockId| b.len_ops(blk) == 1 && b.terminator(blk).is_some_and(|o| b[o].name == "ub.unreachable");
        if unreachable(t) {
            let operands = b.succ_operands(op, 1);
            return rw.br(op, f, &operands);
        }
        if unreachable(f) {
            let operands = b.succ_operands(op, 0);
            return rw.br(op, t, &operands);
        }
        false
    }

    #[rewrite("cf.switch")]
    fn simplify_switch_with_only_default(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
        let b = &*rw.body;
        if b[op].successors.len() != 1 {
            return false;
        }
        let (dest, operands) = (b[op].successors[0], b.succ_operands(op, 0));
        rw.br(op, dest, &operands)
    }

    #[rewrite("cf.switch")]
    fn drop_switch_cases_that_match_default(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
        let b = &*rw.body;
        let Some((_, values)) = b.case_values(op) else { return false };
        let default = (b[op].successors[0], b.succ_operands(op, 0));
        let mut cases = Vec::new();
        let mut changed = false;
        for (i, v) in values.into_iter().enumerate() {
            let (d, o) = (b[op].successors[i + 1], b.succ_operands(op, i + 1));
            if d == default.0 && o == default.1 {
                changed = true;
                continue;
            }
            cases.push((v, d, o));
        }
        if !changed {
            return false;
        }
        let flag = b[op].operands[0];
        rw.switch(op, flag, default, cases)
    }

    #[rewrite("cf.switch")]
    fn simplify_const_switch_value(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
        let b = &*rw.body;
        let Some(v) = b.constant_of(b[op].operands[0]).and_then(|a| Const::try_from(&a).ok()).and_then(|c| c.as_int()) else { return false };
        let i = b.case_values(op).and_then(|(_, vals)| vals.iter().position(|x| *x == v)).map_or(0, |k| k + 1);
        let (dest, operands) = (b[op].successors[i], b.succ_operands(op, i));
        rw.br(op, dest, &operands)
    }

    #[rewrite("cf.switch")]
    fn simplify_pass_through_switch(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
        let b = &*rw.body;
        let Some((_, values)) = b.case_values(op) else { return false };
        let mut changed = false;
        let mut cases = Vec::new();
        for (i, v) in values.into_iter().enumerate() {
            let (d, o) = (b[op].successors[i + 1], b.succ_operands(op, i + 1));
            let (d, o) = match b.collapse_branch(d, &o) {
                Some(c) => {
                    changed = true;
                    c
                }
                None => (d, o),
            };
            cases.push((v, d, o));
        }
        let (d, o) = (b[op].successors[0], b.succ_operands(op, 0));
        let default = match b.collapse_branch(d, &o) {
            Some(c) => {
                changed = true;
                c
            }
            None => (d, o),
        };
        if !changed {
            return false;
        }
        let flag = b[op].operands[0];
        rw.switch(op, flag, default, cases)
    }

    #[rewrite("cf.switch")]
    fn simplify_switch_from_switch_on_same_condition(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
        let b = &*rw.body;
        let current = b[op].parent.expect("placed");
        let Some(pred) = b.single_predecessor(current) else { return false };
        let Some(ps) = b.terminator(pred).filter(|t| b[*t].name == "cf.switch") else { return false };
        if b[ps].operands[0] != b[op].operands[0] || b[ps].successors[0] == current {
            return false;
        }
        let i = match b[ps].successors[1..].iter().position(|d| *d == current) {
            Some(k) => {
                let value = b.case_values(ps).map(|(_, v)| v[k]);
                value.and_then(|v| b.case_values(op).and_then(|(_, vals)| vals.iter().position(|x| *x == v))).map_or(0, |j| j + 1)
            }
            None => 0,
        };
        let (dest, operands) = (b[op].successors[i], b.succ_operands(op, i));
        rw.br(op, dest, &operands)
    }

    #[rewrite("cf.switch")]
    fn simplify_switch_from_default_switch_on_same_condition(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
        let b = &*rw.body;
        let current = b[op].parent.expect("placed");
        let Some(pred) = b.single_predecessor(current) else { return false };
        let Some(ps) = b.terminator(pred).filter(|t| b[*t].name == "cf.switch") else { return false };
        if b[ps].operands[0] != b[op].operands[0] || b[ps].successors[0] != current {
            return false;
        }
        let pred_values = b.case_values(ps).map(|(_, v)| v).unwrap_or_default();
        let remove: Vec<ApInt> = pred_values.iter().enumerate().filter(|(i, _)| b[ps].successors[i + 1] != current).map(|(_, v)| *v).collect();
        let Some((_, values)) = b.case_values(op) else { return false };
        let mut changed = false;
        let mut cases = Vec::new();
        for (i, v) in values.into_iter().enumerate() {
            if remove.contains(&v) {
                changed = true;
                continue;
            }
            cases.push((v, b[op].successors[i + 1], b.succ_operands(op, i + 1)));
        }
        if !changed {
            return false;
        }
        let default = (b[op].successors[0], b.succ_operands(op, 0));
        let flag = b[op].operands[0];
        rw.switch(op, flag, default, cases)
    }
}

impl CfCanon {
    /// `simplifyUniformBlockArgs`: an argument of `dest` that every edge into it passes the
    /// same value (none produced by the branch) is that value.
    fn uniform_block_args(rw: &mut crate::Rewriter<'_, '_>, dest: crate::BlockId) -> bool {
        let b = &*rw.body;
        let preds = b.predecessors(dest);
        if preds.len() < 2 {
            return false;
        }
        let mut replace = Vec::new();
        for (i, arg) in b[dest].args.iter().enumerate() {
            if b[*arg].uses.is_empty() {
                continue;
            }
            let mut common = None;
            for (t, k) in &preds {
                if !b.has(*t, crate::Trait::BranchOpInterface) {
                    common = None;
                    break;
                }
                // A produced operand has no value.
                let val = b.successor_arg_value(*t, *k, i).flatten();
                if val.is_none() || (common.is_some() && common != val) {
                    common = None;
                    break;
                }
                common = val;
            }
            if let Some(v) = common.filter(|v| v != arg) {
                replace.push((*arg, v));
            }
        }
        let changed = !replace.is_empty();
        for (arg, v) in replace {
            rw.replace_all_uses(arg, v);
        }
        changed
    }

    pub fn canonicalization(set: &mut crate::PatternSet) {
        set.add(AssertTrue);
        set.add(BranchCanonicalize);
        set.add(SimplifyConstCondBranchPred).add(SimplifyPassThroughCondBranch).add(SimplifyCondBranchIdenticalSuccessors).add(SimplifyCondBranchFromCondBranchOnSameCondition).add(CondBranchTruthPropagation).add(DropUnreachableCondBranch).add(SimplifyUniformBlockArguments);
        set.add(SimplifySwitchWithOnlyDefault).add(DropSwitchCasesThatMatchDefault).add(SimplifyConstSwitchValue).add(SimplifyPassThroughSwitch).add(SimplifySwitchFromSwitchOnSameCondition).add(SimplifySwitchFromDefaultSwitchOnSameCondition);
    }
}
