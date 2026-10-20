//! `scf`: folds and canonicalization patterns, as `SCF.cpp` and the region-branch patterns
//! of `ControlFlowInterfaces.cpp`.

use alloc::collections::BTreeSet;
use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{Attribute, Type};

use crate::{ApInt, Body, BlockId, Const, Fold, Mapping, OpData, OpId, PatternSet, RegionId, Rewriter, ValueId, attr};

impl<'a> Body<'a> {
    /// The terminator of `op`'s region `r` (its last block).
    pub fn region_terminator(&self, op: OpId, r: usize) -> Option<OpId> {
        let region = *self[op].regions.get(r)?;
        self[region].blocks.last().and_then(|b| self[*b].ops.last().copied())
    }

    fn entry(&self, op: OpId, r: usize) -> Option<BlockId> {
        self[self[op].regions[r]].blocks.first().copied()
    }

    /// An `index` or integer constant behind `v` (`getConstantAPIntValue`).
    fn const_int(&self, v: ValueId) -> Option<ApInt> {
        Const::try_from(&self.constant_of(v)?).ok().filter(|c| !c.elements)?.as_int()
    }

    /// `constantTripCount` with `computeUbMinusLb`.
    fn trip_count(&self, lb: ValueId, ub: ValueId, step: ValueId, signed: bool) -> Option<ApInt> {
        let width = attr::int_width(&self[lb].ty).map_or(64, |w| w.0);
        if attr::int_width(&self[ub].ty).map(|w| w.0) != Some(width) || matches!(self[lb].ty, Type::Index) != matches!(self[ub].ty, Type::Index) {
            return None;
        }
        if lb == ub {
            return Some(ApInt::zero(width));
        }
        let step_c = self.const_int(step);
        if let Some(s) = step_c {
            if s.is_zero() {
                return Some(s);
            }
            if s.is_negative() {
                return Some(ApInt::zero(width));
            }
        }
        let diff = match (self.const_int(lb), self.const_int(ub)) {
            (Some(l), Some(u)) => {
                let le = if signed { u.scmp(l) != core::cmp::Ordering::Greater } else { u.ucmp(l) != core::cmp::Ordering::Greater };
                if le {
                    return Some(ApInt::zero(width));
                }
                u.sub(l)
            }
            (Some(_), None) => return None,
            (None, Some(_)) => return None,
            (None, None) => {
                // `computeUbMinusLb`: ub = lb + c, without wrapping.
                let add = self.def_named(ub, "arith.addi")?;
                let flags = match self[add].get("overflowFlags") {
                    Some(Attribute::Extended { ext, .. }) => alloc::string::String::from(ext.body.as_deref().unwrap_or("")),
                    _ => alloc::string::String::new(),
                };
                if !flags.contains(if signed { "nsw" } else { "nuw" }) || self[add].operands[0] != lb {
                    return None;
                }
                self.const_int(self[add].operands[1])?
            }
        };
        if signed && diff.is_negative() {
            return Some(ApInt::zero(width));
        }
        let s = step_c?;
        let (q, r) = if signed { (diff.sdiv(s)?, diff.srem(s)?) } else { (diff.udiv(s)?, diff.urem(s)?) };
        Some(if r.is_zero() { q } else { q.add(ApInt::new(width, 1)) })
    }

    /// Whether `v` is defined in `region` or a region nested in it.
    fn defined_in(&self, v: ValueId, region: RegionId) -> bool {
        let mut block = self.value_block(v);
        while let Some(b) = block {
            let r = self[b].parent.expect("block in region");
            if r == region {
                return true;
            }
            block = self[self[r].parent].parent;
        }
        false
    }

    /// Whether `region` is `inner` or encloses it.
    fn region_encloses(&self, region: RegionId, mut inner: RegionId) -> bool {
        loop {
            if inner == region {
                return true;
            }
            match self[self[inner].parent].parent.and_then(|b| self[b].parent) {
                Some(r) => inner = r,
                None => return false,
            }
        }
    }

    fn op_region(&self, op: OpId) -> Option<RegionId> {
        self[op].parent.and_then(|b| self[b].parent)
    }
}

impl<'a> Rewriter<'_, 'a> {
    /// `replaceOpWithRegion`: the region's single block inlined before `op`, which its
    /// terminator's operands replace.
    fn replace_op_with_region(&mut self, op: OpId, region: RegionId, args: &[ValueId]) {
        let block = self.body[region].blocks[0];
        let term = *self.body[block].ops.last().expect("terminator");
        let results = self.body[term].operands.clone();
        let parent = self.body[op].parent.expect("placed");
        self.inline_block_before(block, parent, Some(op), args);
        self.replace_op(op, &results);
        self.erase_op(term);
    }

    /// An `scf.yield` of `values` at the end of `block`.
    fn yield_at_end(&mut self, block: BlockId, values: &[ValueId]) -> OpId {
        self.set_end(block);
        self.create(OpData::build("scf.yield").operands(values), &[])
    }

    /// `takeBody`: `from`'s blocks move into the empty region `into`.
    fn take_body(&mut self, into: RegionId, from: RegionId) {
        self.inline_region_before(from, into, None);
    }
}

/// `scf.if`'s fold: `if (!c)` with an else region swaps the regions.
pub fn fold<'a>(b: &mut Body<'a>, op: OpId) -> Fold<'a> {
    if b[op].name != "scf.if" {
        return Fold::Failed;
    }
    let (then_r, else_r) = (b[op].regions[0], b[op].regions[1]);
    if b[else_r].blocks.is_empty() {
        return Fold::Failed;
    }
    let Some(xor) = b.def_named(b[op].operands[0], "arith.xori") else { return Fold::Failed };
    if !b.constant_of(b[xor].operands[1]).and_then(|a| Const::try_from(&a).ok()).and_then(|c| c.as_int()).is_some_and(ApInt::is_one) {
        return Fold::Failed;
    }
    let lhs = b[xor].operands[0];
    b.set_operand(op, 0, lhs);
    let (tb, eb) = (core::mem::take(&mut b[then_r].blocks), core::mem::take(&mut b[else_r].blocks));
    for blk in &tb {
        b[*blk].parent = Some(else_r);
    }
    for blk in &eb {
        b[*blk].parent = Some(then_r);
    }
    b[then_r].blocks = eb;
    b[else_r].blocks = tb;
    Fold::InPlace
}

rewrites! {
    SingleBlockExecuteInliner("scf.execute_region", 1) |rw, op| {
        let b = &*rw.body;
        let r = b[op].regions[0];
        if b[r].blocks.len() != 1 || b[op].get("no_inline").is_some() {
            return false;
        }
        rw.replace_op_with_region(op, r, &[]);
        true
    }

    MultiBlockExecuteInliner("scf.execute_region", 1) |rw, op| {
        let b = &*rw.body;
        if b[op].get("no_inline").is_some() {
            return false;
        }
        let Some(parent) = b.parent_op(op) else { return false };
        if !(b.has(parent, crate::Trait::FunctionOpInterface) || b[parent].name == "scf.execute_region") {
            return false;
        }
        let prev = b[op].parent.expect("placed");
        let region = b[op].regions[0];
        let entry = b[region].blocks[0];
        let post = rw.split_block(prev, op);
        rw.set_end(prev);
        rw.create(OpData::build("cf.br").successors(&[entry]), &[]);
        for blk in rw.body[region].blocks.clone() {
            let Some(&t) = rw.body[blk].ops.last() else { continue };
            if rw.body[t].name == "scf.yield" {
                rw.set_before(t);
                let vals = rw.body[t].operands.clone();
                rw.create(OpData::build("cf.br").operands(&vals).successors(&[post]), &[]);
                rw.erase_op(t);
            }
        }
        let outer = rw.body[prev].parent.expect("in region");
        rw.inline_region_before(region, outer, Some(post));
        let args: Vec<ValueId> = rw.body[op].results.clone().into_iter().map(|r| {
            let ty = rw.body[r].ty.clone();
            rw.body.add_arg(post, ty)
        }).collect();
        rw.replace_op(op, &args);
        true
    }

    SimplifyTrivialLoops("scf.for", 1) |rw, op| {
        let b = &*rw.body;
        let d = &b[op];
        let (lb, ub, step) = (d.operands[0], d.operands[1], d.operands[2]);
        let signed = d.get("unsignedCmp").is_none();
        let Some(trips) = b.trip_count(lb, ub, step, signed) else { return false };
        let inits: Vec<ValueId> = d.operands[3..].to_vec();
        if trips.is_zero() {
            rw.replace_op(op, &inits);
            return true;
        }
        if trips.signed() == 1 {
            let mut args = vec![lb];
            args.extend(inits);
            let r = b[op].regions[0];
            rw.replace_op_with_region(op, r, &args);
            return true;
        }
        let block = b.entry(op, 0).expect("body");
        if b[block].ops.len() != 1 {
            return false;
        }
        let y = b[block].ops[0];
        let yielded = b[y].operands.clone();
        let region = b[op].regions[0];
        if yielded.iter().any(|v| b.defined_in(*v, region)) {
            return false;
        }
        rw.replace_op(op, &yielded);
        true
    }

    RemoveStaticCondition("scf.if", 1) |rw, op| {
        let b = &*rw.body;
        let Some(c) = b.constant_of(b[op].operands[0]) else { return false };
        let Attribute::Bool(v) = c else { return false };
        let (t, e) = (b[op].regions[0], b[op].regions[1]);
        if v {
            rw.replace_op_with_region(op, t, &[]);
        } else if !b[e].blocks.is_empty() {
            rw.replace_op_with_region(op, e, &[]);
        } else {
            rw.erase_op(op);
        }
        true
    }

    ConvertTrivialIfToSelect("scf.if", 1) |rw, op| {
        let b = &*rw.body;
        if b[op].results.is_empty() {
            return false;
        }
        let cond = b[op].operands[0];
        let (tr, er) = (b[op].regions[0], b[op].regions[1]);
        let (Some(ty), Some(ey)) = (b.region_terminator(op, 0), b.region_terminator(op, 1)) else { return false };
        let (targs, eargs) = (b[ty].operands.clone(), b[ey].operands.clone());
        let in_region = |v: ValueId, r: RegionId| b.value_block(v).and_then(|blk| b[blk].parent) == Some(r);
        let non_hoistable: Vec<Type> = targs.iter().zip(&eargs).filter(|(t, e)| in_region(**t, tr) || in_region(**e, er)).map(|(t, _)| b[*t].ty.clone()).collect();
        if non_hoistable.len() == b[op].results.len() {
            return false;
        }
        rw.set_before(op);
        let new = rw.create_with(OpData::build("scf.if").operands(&[cond]), &non_hoistable, |body, n| {
            body.add_region(n);
            body.add_region(n);
        });
        let (nt, ne) = (rw.body[new].regions[0], rw.body[new].regions[1]);
        rw.take_body(nt, tr);
        rw.take_body(ne, er);
        let mut results = Vec::new();
        let (mut ty_vals, mut fy_vals) = (Vec::new(), Vec::new());
        rw.set_before(new);
        for (t, e) in targs.into_iter().zip(eargs) {
            let ib = &*rw.body;
            let inr = |v: ValueId, r: RegionId| ib.value_block(v).and_then(|blk| ib[blk].parent) == Some(r);
            if inr(t, nt) || inr(e, ne) {
                results.push(rw.body[new].results[ty_vals.len()]);
                ty_vals.push(t);
                fy_vals.push(e);
            } else if t == e {
                results.push(t);
            } else {
                let tyv = rw.body[t].ty.clone();
                let s = rw.create(OpData::build("arith.select").operands(&[cond, t, e]), &[tyv]);
                results.push(rw.body[s].results[0]);
            }
        }
        let (tblk, eblk) = (rw.body.entry(new, 0).expect("then"), rw.body.entry(new, 1).expect("else"));
        let (old_ty, old_ey) = (*rw.body[tblk].ops.last().expect("yield"), *rw.body[eblk].ops.last().expect("yield"));
        rw.set_end(tblk);
        rw.replace_with(old_ty, OpData::build("scf.yield").operands(&ty_vals), &[]);
        rw.set_end(eblk);
        rw.replace_with(old_ey, OpData::build("scf.yield").operands(&fy_vals), &[]);
        rw.replace_op(op, &results);
        true
    }

    ConditionPropagation("scf.if", 1) |rw, op| {
        let b = &*rw.body;
        let cond = b[op].operands[0];
        if b.constant_of(cond).is_some() {
            return false;
        }
        let (tr, er) = (b[op].regions[0], b[op].regions[1]);
        let mut changed = false;
        let (mut t_const, mut f_const) = (None, None);
        for u in rw.body[cond].uses.clone().into_iter().rev() {
            let Some(r) = rw.body.op_region(u.op) else { continue };
            let side = if rw.body.region_encloses(tr, r) {
                Some(true)
            } else if rw.body.region_encloses(er, r) {
                Some(false)
            } else {
                None
            };
            let Some(v) = side else { continue };
            changed = true;
            let slot = if v { &mut t_const } else { &mut f_const };
            let c = match *slot {
                Some(c) => c,
                None => {
                    rw.set_before(op);
                    let c = rw.create(OpData::build("arith.constant").with("value", Attribute::Bool(v)), &[Type::I1]);
                    let c = rw.body[c].results[0];
                    *slot = Some(c);
                    c
                }
            };
            rw.modify(u.op, |body| body.set_operand(u.op, u.index as usize, c));
        }
        changed
    }

    ReplaceIfYieldWithConditionOrValue("scf.if", 1) |rw, op| {
        let b = &*rw.body;
        if b[op].results.is_empty() {
            return false;
        }
        let (Some(ty), Some(ey)) = (b.region_terminator(op, 0), b.region_terminator(op, 1)) else { return false };
        let triples: Vec<_> = b[ty].operands.iter().zip(&b[ey].operands).zip(&b[op].results).map(|((t, e), r)| (*t, *e, *r)).collect();
        let cond = b[op].operands[0];
        rw.set_before(op);
        let mut changed = false;
        for (t, e, r) in triples {
            if t == e {
                if !rw.body[r].uses.is_empty() {
                    rw.body.replace_all_uses(r, t);
                    changed = true;
                }
                continue;
            }
            let (Some(Attribute::Bool(tv)), Some(Attribute::Bool(fv))) = (rw.body.constant_of(t), rw.body.constant_of(e)) else { continue };
            if !tv && fv && !rw.body[r].uses.is_empty() {
                let ns = rw.body[rw.body.def_op(t).expect("constant")].name.clone();
                let Some(one) = rw.body.materialize(&ns, &Attribute::Bool(true), &Type::I1) else { continue };
                let c = rw.create(one, &[Type::I1]);
                let c = rw.body[c].results[0];
                let x = rw.create(OpData::build("arith.xori").operands(&[cond, c]), &[Type::I1]);
                let x = rw.body[x].results[0];
                rw.body.replace_all_uses(r, x);
                changed = true;
            }
            if tv && !fv && !rw.body[r].uses.is_empty() {
                rw.body.replace_all_uses(r, cond);
                changed = true;
            }
        }
        changed
    }

    CombineIfs("scf.if", 1) |rw, op| {
        combine_ifs(rw, op)
    }

    RemoveEmptyElseBranch("scf.if", 1) |rw, op| {
        let b = &*rw.body;
        if !b[op].results.is_empty() {
            return false;
        }
        let Some(eb) = b.entry(op, 1) else { return false };
        if b[eb].ops.len() != 1 {
            return false;
        }
        let tr = b[op].regions[0];
        let data = OpData { regions: Vec::new(), results: Vec::new(), parent: None, ..b[op].clone() };
        rw.set_before(op);
        let new = rw.create_with(data, &[], |body, n| {
            body.add_region(n);
            body.add_region(n);
        });
        let nt = rw.body[new].regions[0];
        rw.inline_region_before(tr, nt, None);
        rw.erase_op(op);
        true
    }

    CombineNestedIfs("scf.if", 1) |rw, op| {
        combine_nested_ifs(rw, op)
    }

    WhileConditionTruth("scf.while", 1) |rw, op| {
        let b = &*rw.body;
        let Some(term) = b.region_terminator(op, 0) else { return false };
        let cond = b[term].operands[0];
        let after = b.entry(op, 1).expect("after");
        let pairs: Vec<_> = b[term].operands[1..].iter().zip(&b[after].args).map(|(a, x)| (*a, *x)).collect();
        let mut constant = None;
        let mut replaced = false;
        for (yielded, arg) in pairs {
            if yielded == cond && !rw.body[arg].uses.is_empty() {
                let c = match constant {
                    Some(c) => c,
                    None => {
                        rw.set_before(op);
                        let ty = rw.body[cond].ty.clone();
                        let c = rw.create(OpData::build("arith.constant").with("value", Attribute::Bool(true)), &[ty]);
                        let c = rw.body[c].results[0];
                        constant = Some(c);
                        c
                    }
                };
                rw.replace_all_uses(arg, c);
                replaced = true;
            }
        }
        replaced
    }

    WhileCmpCond("scf.while", 1) |rw, op| {
        let b = &*rw.body;
        let Some(term) = b.region_terminator(op, 0) else { return false };
        let Some(cmp) = b.def_named(b[term].operands[0], "arith.cmpi") else { return false };
        let after = b.entry(op, 1).expect("after");
        let pairs: Vec<_> = b[term].operands[1..].iter().zip(&b[after].args).map(|(a, x)| (*a, *x)).collect();
        let pred = b[cmp].get("predicate").cloned();
        let mut changed = false;
        for (yielded, arg) in pairs {
            for idx in 0..2 {
                if yielded != rw.body[cmp].operands[idx] {
                    continue;
                }
                for u in rw.body[arg].uses.clone().into_iter().rev() {
                    let cmp2 = u.op;
                    if rw.body[cmp2].name != "arith.cmpi" || rw.body[cmp2].parent.is_none() {
                        continue;
                    }
                    if rw.body[cmp2].operands[1 - idx] != rw.body[cmp].operands[1 - idx] {
                        continue;
                    }
                    let (p1, p2) = (int_of(pred.as_ref()), int_of(rw.body[cmp2].get("predicate")));
                    let same = if p1 == p2 {
                        true
                    } else if p2.zip(p1).is_some_and(|(x, y)| x == invert(y)) {
                        false
                    } else {
                        continue;
                    };
                    rw.replace_with(cmp2, OpData::build("arith.constant").with("value", Attribute::Bool(same)), &[Type::I1]);
                    changed = true;
                }
            }
        }
        changed
    }

    WhileOpAlignBeforeArgs("scf.while", 1) |rw, op| {
        align_before_args(rw, op)
    }

    WhileMoveIfDown("scf.while", 1) |rw, op| {
        while_move_if_down(rw, op)
    }

    FoldConstantCase("scf.index_switch", 1) |rw, op| {
        let b = &*rw.body;
        let Some(c) = b.const_int(b[op].operands[0]) else { return false };
        let cases: Vec<i64> = match b[op].get("cases") {
            Some(Attribute::DenseArray { values, .. }) => values.iter().filter_map(|v| v.parse().ok()).collect(),
            _ => Vec::new(),
        };
        let idx = cases.iter().position(|x| *x == c.signed() as i64).unwrap_or(cases.len());
        // Regions: the default first, then the cases.
        let region = if idx < cases.len() { b[op].regions[idx + 1] } else { b[op].regions[0] };
        let source = b[region].blocks[0];
        let term = *b[source].ops.last().expect("terminator");
        let results = b[term].operands.clone();
        let parent = b[op].parent.expect("placed");
        rw.inline_block_before(source, parent, Some(op), &[]);
        rw.erase_op(term);
        rw.replace_op(op, &results);
        true
    }

    ParallelOpSingleOrZeroIterationDimsFolder("scf.parallel", 1) |rw, op| {
        parallel_single_or_zero(rw, op)
    }

    MergeNestedParallelLoops("scf.parallel", 1) |rw, op| {
        merge_nested_parallel(rw, op)
    }
}

fn int_of(a: Option<&Attribute<'_>>) -> Option<i64> {
    match a? {
        Attribute::Int { lit, .. } => lit.parse().ok(),
        _ => None,
    }
}

/// `arith::invertPredicate`.
fn invert(p: i64) -> i64 {
    match p {
        0 => 1,
        1 => 0,
        2 => 5,
        3 => 4,
        4 => 3,
        5 => 2,
        6 => 9,
        7 => 8,
        8 => 7,
        _ => 6,
    }
}

fn combine_ifs(rw: &mut Rewriter<'_, '_>, next: OpId) -> bool {
    let b = &*rw.body;
    let parent = b[next].parent.expect("placed");
    let pos = b.position(next);
    if pos == 0 {
        return false;
    }
    let prev = b[parent].ops[pos - 1];
    if b[prev].name != "scf.if" {
        return false;
    }
    let (nc, pc) = (b[next].operands[0], b[prev].operands[0]);
    let has_else = |o: OpId| !b[b[o].regions[1]].blocks.is_empty();
    let (mut next_then, mut next_else) = (None, None);
    if nc == pc {
        next_then = b.entry(next, 0);
        if has_else(next) {
            next_else = b.entry(next, 1);
        }
    }
    let is_not_of = |x: ValueId, of: ValueId| b.def_named(x, "arith.xori").is_some_and(|n| b[n].operands[0] == of && b.const_int(b[n].operands[1]).is_some_and(ApInt::is_one));
    if is_not_of(nc, pc) || is_not_of(pc, nc) {
        next_else = b.entry(next, 0);
        if has_else(next) {
            next_then = b.entry(next, 1);
        }
    }
    if next_then.is_none() && next_else.is_none() {
        return false;
    }
    let then_yield = b.region_terminator(prev, 0).expect("yield");
    let prev_then_vals = b[then_yield].operands.clone();
    let prev_else_vals = if has_else(prev) { b[b.region_terminator(prev, 1).expect("yield")].operands.clone() } else { Vec::new() };
    let then_region = next_then.and_then(|blk| b[blk].parent);
    let else_region = next_else.and_then(|blk| b[blk].parent);
    for (i, r) in b[prev].results.clone().into_iter().enumerate() {
        // Only results with an else value take part (`zip` stops at the shortest).
        let Some(&ev) = prev_else_vals.get(i) else { continue };
        for u in rw.body[r].uses.clone().into_iter().rev() {
            let Some(ur) = rw.body.op_region(u.op) else { continue };
            if then_region.is_some_and(|t| rw.body.region_encloses(t, ur)) {
                rw.modify(u.op, |body| body.set_operand(u.op, u.index as usize, prev_then_vals[i]));
            } else if else_region.is_some_and(|e| rw.body.region_encloses(e, ur)) {
                rw.modify(u.op, |body| body.set_operand(u.op, u.index as usize, ev));
            }
        }
    }
    let b = &*rw.body;
    let mut types = b.types(&b[prev].results);
    types.extend(b.types(&b[next].results));
    let loc = b[next].loc.clone();
    rw.set_before(next);
    let combined = rw.create_with(OpData { loc, ..OpData::build("scf.if").operands(&[pc]) }, &types, |body, n| {
        body.add_region(n);
        body.add_region(n);
    });
    let (ct, ce) = (rw.body[combined].regions[0], rw.body[combined].regions[1]);
    let (pt, pe) = (rw.body[prev].regions[0], rw.body[prev].regions[1]);
    rw.inline_region_before(pt, ct, None);
    if let Some(nt) = next_then {
        let cblk = rw.body[ct].blocks[0];
        let y1 = *rw.body[cblk].ops.last().expect("yield");
        let y2 = *rw.body[nt].ops.last().expect("yield");
        rw.merge_blocks(nt, cblk, &[]);
        let mut vals = rw.body[y1].operands.clone();
        vals.extend(rw.body[y2].operands.clone());
        rw.yield_at_end(cblk, &vals);
        rw.erase_op(y1);
        rw.erase_op(y2);
    }
    rw.inline_region_before(pe, ce, None);
    if let Some(ne) = next_else {
        if rw.body[ce].blocks.is_empty() {
            let r = rw.body[ne].parent.expect("in region");
            rw.inline_region_before(r, ce, None);
        } else {
            let cblk = rw.body[ce].blocks[0];
            let y1 = *rw.body[cblk].ops.last().expect("yield");
            let y2 = *rw.body[ne].ops.last().expect("yield");
            rw.merge_blocks(ne, cblk, &[]);
            let mut vals = rw.body[y1].operands.clone();
            vals.extend(rw.body[y2].operands.clone());
            rw.yield_at_end(cblk, &vals);
            rw.erase_op(y1);
            rw.erase_op(y2);
        }
    }
    let n_prev = rw.body[prev].results.len();
    let all = rw.body[combined].results.clone();
    rw.replace_op(prev, &all[..n_prev]);
    rw.replace_op(next, &all[n_prev..]);
    true
}

fn combine_nested_ifs(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
    let b = &*rw.body;
    let then_blk = b.entry(op, 0).expect("then");
    if b[then_blk].ops.len() != 2 {
        return false;
    }
    let else_blk = b.entry(op, 1);
    if else_blk.is_some_and(|e| b[e].ops.len() != 1) {
        return false;
    }
    let nested = b[then_blk].ops[0];
    if b[nested].name != "scf.if" {
        return false;
    }
    let nested_else = b.entry(nested, 1);
    if nested_else.is_some_and(|e| b[e].ops.len() != 1) {
        return false;
    }
    let mut then_yield = b[b.region_terminator(op, 0).expect("yield")].operands.clone();
    let else_yield = if else_blk.is_some() { b[b.region_terminator(op, 1).expect("yield")].operands.clone() } else { Vec::new() };
    let then_region = b[op].regions[0];
    let mut upgrade = Vec::new();
    for i in 0..then_yield.len() {
        let v = then_yield[i];
        if b.def_op(v) == Some(nested) {
            let k = match b[v].def {
                crate::Def::Result(_, k) => k as usize,
                _ => unreachable!(),
            };
            let Some(ney) = b.region_terminator(nested, 1) else { return false };
            if else_yield.get(i) != Some(&b[ney].operands[k]) {
                return false;
            }
            then_yield[i] = b[b.region_terminator(nested, 0).expect("yield")].operands[k];
            continue;
        }
        if b.value_block(v).and_then(|blk| b[blk].parent) == Some(then_region) {
            return false;
        }
        upgrade.push(i);
    }
    let (c1, c2) = (b[op].operands[0], b[nested].operands[0]);
    let types = b.types(&b[op].results);
    let loc = b[op].loc.clone();
    let nested_then = b.entry(nested, 0).expect("then");
    rw.set_before(op);
    let and = rw.create(OpData { loc: loc.clone(), ..OpData::build("arith.andi").operands(&[c1, c2]) }, &[Type::I1]);
    let cond = rw.body[and].results[0];
    let new = rw.create_with(OpData { loc, ..OpData::build("scf.if").operands(&[cond]) }, &types, |body, n| {
        body.add_region(n);
        body.add_region(n);
    });
    let nt = rw.body[new].regions[0];
    let new_then = rw.create_block(nt, &[]);
    let mut results = rw.body[new].results.clone();
    rw.set_before(new);
    for i in upgrade {
        let ty = rw.body[then_yield[i]].ty.clone();
        let s = rw.create(OpData::build("arith.select").operands(&[c1, then_yield[i], else_yield[i]]), &[ty]);
        results[i] = rw.body[s].results[0];
    }
    rw.merge_blocks(nested_then, new_then, &[]);
    let old_yield = *rw.body[new_then].ops.last().expect("yield");
    rw.set_end(new_then);
    rw.replace_with(old_yield, OpData::build("scf.yield").operands(&then_yield), &[]);
    if !else_yield.is_empty() {
        let ne = rw.body[new].regions[1];
        let blk = rw.create_block(ne, &[]);
        rw.yield_at_end(blk, &else_yield);
    }
    rw.replace_op(op, &results);
    true
}

fn align_before_args(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
    let b = &*rw.body;
    let before = b.entry(op, 0).expect("before");
    let term = b.region_terminator(op, 0).expect("condition");
    let before_args = b[before].args.clone();
    let term_args: Vec<ValueId> = b[term].operands[1..].to_vec();
    if before_args == term_args {
        return false;
    }
    let unique: BTreeSet<_> = term_args.iter().collect();
    if unique.len() != term_args.len() || before_args.len() != term_args.len() {
        return false;
    }
    // mapping[j] = i: term arg j is before arg i.
    let mut mapping = vec![0usize; before_args.len()];
    for (i, a) in before_args.iter().enumerate() {
        let Some(j) = term_args.iter().position(|x| x == a) else { return false };
        mapping[j] = i;
    }
    let cond = b[term].operands[0];
    rw.set_before(term);
    let mut ops = vec![cond];
    ops.extend(&before_args);
    rw.replace_with(term, OpData::build("scf.condition").operands(&ops), &[]);
    let b = &*rw.body;
    let after = b.entry(op, 1).expect("after");
    let mut types = vec![Type::Index; before_args.len()];
    for (i, j) in mapping.iter().enumerate() {
        types[*j] = b[b[op].results[i]].ty.clone();
    }
    let inits = b[op].operands.clone();
    let init_types = b.types(&inits);
    let after_types = types.clone();
    rw.set_before(op);
    let new = rw.create_with(OpData::build("scf.while").operands(&inits), &types, |body, n| {
        let r0 = body.add_region(n);
        let args: Vec<_> = init_types.iter().map(|t| (t.clone(), None)).collect();
        body.add_block(r0, &args);
        let r1 = body.add_region(n);
        let args: Vec<_> = after_types.iter().map(|t| (t.clone(), None)).collect();
        body.add_block(r1, &args);
    });
    let (nb, na) = (rw.body.entry(new, 0).expect("before"), rw.body.entry(new, 1).expect("after"));
    let mut results = vec![rw.body[new].results[0]; before_args.len()];
    let mut after_args = results.clone();
    for (i, j) in mapping.iter().enumerate() {
        results[i] = rw.body[new].results[*j];
        after_args[i] = rw.body[na].args[*j];
    }
    let nb_args = rw.body[nb].args.clone();
    let first_b = rw.body[nb].ops.first().copied();
    rw.inline_block_before(before, nb, first_b, &nb_args);
    let first_a = rw.body[na].ops.first().copied();
    rw.inline_block_before(after, na, first_a, &after_args);
    rw.replace_op(op, &results);
    true
}

fn while_move_if_down(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
    let b = &*rw.body;
    let cond_op = b.region_terminator(op, 0).expect("condition");
    let before = b[cond_op].parent.expect("placed");
    let pos = b.position(cond_op);
    if pos == 0 {
        return false;
    }
    let if_op = b[before].ops[pos - 1];
    if b[if_op].name != "scf.if" || b[if_op].operands[0] != b[cond_op].operands[0] {
        return false;
    }
    if b.entry(if_op, 1).is_some_and(|e| b[e].ops.len() != 1) {
        return false;
    }
    let after = b.entry(op, 1).expect("after");
    let args: Vec<ValueId> = b[cond_op].operands[1..].to_vec();
    for (idx, a) in args.iter().enumerate() {
        let ib = &*rw.body;
        if let Some(k) = ib[if_op].results.iter().position(|r| r == a) {
            let then_v = ib[ib.region_terminator(if_op, 0).expect("yield")].operands[k];
            let else_v = ib[ib.region_terminator(if_op, 1).expect("yield")].operands[k];
            let (res, aarg) = (ib[if_op].results[k], ib[after].args[idx]);
            rw.replace_all_uses(res, else_v);
            rw.replace_all_uses(aarg, then_v);
        }
    }
    // Values of the before region the then region uses, in first-use order.
    let b = &*rw.body;
    let then_r = b[if_op].regions[0];
    let before_r = b[op].regions[0];
    let mut extra: Vec<ValueId> = Vec::new();
    for o in b.ops_in(if_op).into_iter().skip(1) {
        if !b.op_region(o).is_some_and(|r| b.region_encloses(then_r, r)) {
            continue;
        }
        for v in &b[o].operands {
            if b.value_block(*v).and_then(|blk| b[blk].parent) == Some(before_r) && !extra.contains(v) {
                extra.push(*v);
            }
        }
    }
    let extra_types = b.types(&extra);
    let mut types = b.types(&b[op].results);
    types.extend(extra_types.clone());
    let inits = b[op].operands.clone();
    rw.set_before(op);
    let new = rw.create_with(OpData::build("scf.while").operands(&inits), &types, |body, n| {
        body.add_region(n);
        body.add_region(n);
    });
    let (r0, r1) = (rw.body[op].regions[0], rw.body[op].regions[1]);
    let (n0, n1) = (rw.body[new].regions[0], rw.body[new].regions[1]);
    rw.modify(new, |_| {});
    rw.take_body(n0, r0);
    rw.take_body(n1, r1);
    let new_after = rw.body[n1].blocks[0];
    let added: Vec<ValueId> = extra_types.into_iter().map(|t| rw.body.add_arg(new_after, t)).collect();
    let mut cops = rw.body[cond_op].operands.clone();
    cops.extend(&extra);
    rw.modify(cond_op, |body| body.set_operands(cond_op, cops));
    for (v, a) in extra.iter().zip(&added) {
        rw.replace_uses_if(*v, *a, |body, u| body.op_region(u.op).is_some_and(|r| body.region_encloses(then_r, r)));
    }
    let then_y = rw.body.region_terminator(if_op, 0).expect("yield");
    rw.erase_op(then_y);
    let then_blk = rw.body.entry(if_op, 0).expect("then");
    let first = rw.body[new_after].ops.first().copied();
    rw.inline_block_before(then_blk, new_after, first, &[]);
    rw.erase_op(if_op);
    let n = rw.body[op].results.len();
    let res = rw.body[new].results[..n].to_vec();
    rw.replace_op(op, &res);
    true
}

fn parallel_single_or_zero(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
    let b = &*rw.body;
    let segs = match b[op].get("operandSegmentSizes") {
        Some(Attribute::DenseArray { values, .. }) => values.iter().filter_map(|v| v.parse::<usize>().ok()).collect::<Vec<_>>(),
        _ => return false,
    };
    let n = segs[0];
    let ops = b[op].operands.clone();
    let (lbs, ubs, steps, inits) = (&ops[..n], &ops[n..2 * n], &ops[2 * n..3 * n], &ops[3 * n..]);
    let body_blk = b.entry(op, 0).expect("body");
    let ivs = b[body_blk].args.clone();
    let mut map = Mapping::default();
    let (mut nl, mut nu, mut ns) = (Vec::new(), Vec::new(), Vec::new());
    for i in 0..n {
        match b.trip_count(lbs[i], ubs[i], steps[i], true) {
            Some(t) if t.is_zero() => {
                let inits = inits.to_vec();
                rw.replace_op(op, &inits);
                return true;
            }
            Some(t) if t.signed() == 1 => {
                map.map(ivs[i], lbs[i]);
                continue;
            }
            _ => {}
        }
        nl.push(lbs[i]);
        nu.push(ubs[i]);
        ns.push(steps[i]);
    }
    if nl.len() == n {
        return false;
    }
    rw.set_before(op);
    if nl.is_empty() {
        let mut results = Vec::new();
        let ops_in_body = rw.body[body_blk].ops.clone();
        let (reduce, others) = ops_in_body.split_last().expect("terminator");
        for o in others {
            rw.clone(*o, &mut map);
        }
        let reduce_ops = rw.body[*reduce].operands.clone();
        for (i, r) in rw.body[*reduce].regions.clone().into_iter().enumerate() {
            let blk = rw.body[r].blocks[0];
            let (a0, a1) = (rw.body[blk].args[0], rw.body[blk].args[1]);
            map.map(a0, inits[results.len()]);
            map.map(a1, map.get(reduce_ops[i]));
            let rops = rw.body[blk].ops.clone();
            let (ret, body_ops) = rops.split_last().expect("terminator");
            for o in body_ops {
                rw.clone(*o, &mut map);
            }
            results.push(map.get(rw.body[*ret].operands[0]));
        }
        rw.replace_op(op, &results);
        return true;
    }
    let types = rw.body.types(&rw.body[op].results.clone());
    let mut all = nl.clone();
    all.extend(&nu);
    all.extend(&ns);
    all.extend(inits);
    let k = nl.len();
    let new = rw.create_with(OpData::build("scf.parallel").operands(&all).segments(&[k, k, k, inits.len()]), &types, |body, n| {
        body.add_region(n);
    });
    let (from, into) = (rw.body[op].regions[0], rw.body[new].regions[0]);
    rw.clone_region_before(from, into, None, &mut map);
    let res = rw.body[new].results.clone();
    rw.replace_op(op, &res);
    true
}

fn merge_nested_parallel(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
    let b = &*rw.body;
    let outer = b.entry(op, 0).expect("body");
    if b[outer].ops.len() != 2 {
        return false;
    }
    let inner = b[outer].ops[0];
    if b[inner].name != "scf.parallel" {
        return false;
    }
    let seg = |o: OpId| match b[o].get("operandSegmentSizes") {
        Some(Attribute::DenseArray { values, .. }) => values.iter().filter_map(|v| v.parse::<usize>().ok()).collect::<Vec<_>>(),
        _ => Vec::new(),
    };
    let (so, si) = (seg(op), seg(inner));
    if so.len() != 4 || si.len() != 4 || so[3] != 0 || si[3] != 0 {
        return false;
    }
    let iops = &b[inner].operands;
    if b[outer].args.iter().any(|a| iops.contains(a)) {
        return false;
    }
    let (no, ni) = (so[0], si[0]);
    let oops = b[op].operands.clone();
    let iops = iops.clone();
    let mut all = Vec::new();
    for g in 0..3 {
        all.extend(&oops[g * no..(g + 1) * no]);
        all.extend(&iops[g * ni..(g + 1) * ni]);
    }
    let inner_blk = b.entry(inner, 0).expect("body");
    let (oargs, iargs) = (b[outer].args.clone(), b[inner_blk].args.clone());
    let inner_ops: Vec<OpId> = b[inner_blk].ops[..b[inner_blk].ops.len() - 1].to_vec();
    let k = no + ni;
    rw.set_before(op);
    let new = rw.create_with(OpData::build("scf.parallel").operands(&all).segments(&[k, k, k, 0]), &[], |body, n| {
        let r = body.add_region(n);
        let args: Vec<_> = (0..k).map(|_| (Type::Index, None)).collect();
        body.add_block(r, &args);
    });
    let nb = rw.body.entry(new, 0).expect("body");
    let nargs = rw.body[nb].args.clone();
    let mut map = Mapping::default();
    for (a, v) in oargs.iter().chain(&iargs).zip(&nargs) {
        map.map(*a, *v);
    }
    rw.set_end(nb);
    for o in inner_ops {
        rw.clone(o, &mut map);
    }
    rw.create(OpData::build("scf.reduce"), &[]);
    rw.replace_op(op, &[]);
    true
}

/// The three `populateRegionBranchOpInterfaceCanonicalizationPatterns` patterns.
pub struct RegionBranchPatterns(pub &'static str);

impl RegionBranchPatterns {
    fn defined_before(b: &Body<'_>, op: OpId, a: ValueId, input: ValueId) -> bool {
        let in_op = b.value_block(a).and_then(|blk| b[blk].parent).is_some_and(|r| b[r].parent == op);
        if !in_op {
            return true;
        }
        match (b[input].def, b[a].def) {
            (crate::Def::Result(..), _) => false,
            (crate::Def::Arg(bi, _), crate::Def::Arg(ba, _)) => bi == ba,
            _ => false,
        }
    }

    /// `MakeRegionBranchOpSuccessorInputsDead`.
    fn inputs_dead(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let map = rw.body.input_operands(op);
        let mut changed = false;
        for (value, _) in &map {
            if rw.body[*value].uses.is_empty() {
                continue;
            }
            // The values reaching `value` through successor edges, inputs looked through.
            let mut reach = Vec::new();
            let mut seen = BTreeSet::new();
            let mut work = vec![*value];
            while let Some(next) = work.pop() {
                match map.iter().find(|(i, _)| *i == next) {
                    None => {
                        if !reach.contains(&next) {
                            reach.push(next);
                        }
                    }
                    Some((_, operands)) => {
                        for (owner, idx) in operands {
                            let v = rw.body[*owner].operands[*idx];
                            if seen.insert(v) {
                                work.push(v);
                            }
                        }
                    }
                }
            }
            let [only] = reach[..] else { continue };
            if !Self::defined_before(rw.body, op, only, *value) {
                continue;
            }
            rw.replace_all_uses(*value, only);
            changed = true;
        }
        changed
    }

    /// `RemoveDuplicateSuccessorInputUses`.
    fn duplicate_inputs(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let map = rw.body.input_operands(op);
        let number = |b: &Body<'_>, v: ValueId| match b[v].def {
            crate::Def::Result(_, i) | crate::Def::Arg(_, i) => i,
        };
        let mut inputs: Vec<ValueId> = map.iter().map(|e| e.0).collect();
        inputs.sort_by_key(|v| number(rw.body, *v));
        let owner = |b: &Body<'_>, v: ValueId| match b[v].def {
            crate::Def::Result(o, _) => (0usize, o.0),
            crate::Def::Arg(blk, _) => (1, blk.0),
        };
        let mut changed = false;
        for i in 0..inputs.len() {
            for j in i + 1..inputs.len() {
                let (x, y) = (inputs[i], inputs[j]);
                if rw.body[y].uses.is_empty() || owner(rw.body, x) != owner(rw.body, y) {
                    continue;
                }
                let ops_of = |v: ValueId| -> Vec<(OpId, ValueId)> {
                    let mut out: Vec<_> = map.iter().find(|e| e.0 == v).map(|e| e.1.iter().map(|(o, k)| (*o, rw.body[*o].operands[*k])).collect()).unwrap_or_default();
                    out.sort_by_key(|p| p.0);
                    out
                };
                if ops_of(x) == ops_of(y) {
                    rw.replace_all_uses(y, x);
                    changed = true;
                }
            }
        }
        changed
    }

    /// `RemoveDeadRegionBranchOpSuccessorInputs`.
    fn dead_inputs(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let pairs = rw.body.operand_inputs(op);
        // Inputs tied by sharing an operand, as union-find over their first appearance.
        let mut classes: Vec<Vec<ValueId>> = Vec::new();
        for (_, inputs) in &pairs {
            let mut merged: Vec<ValueId> = Vec::new();
            let mut keep = Vec::new();
            for c in classes.drain(..) {
                if c.iter().any(|v| inputs.contains(v)) {
                    merged.extend(c);
                } else {
                    keep.push(c);
                }
            }
            for v in inputs {
                if !merged.contains(v) {
                    merged.push(*v);
                }
            }
            keep.push(merged);
            classes = keep;
        }
        let b = &*rw.body;
        let dead: Vec<ValueId> = classes.into_iter().filter(|c| c.iter().all(|v| b[*v].uses.is_empty())).flatten().collect();
        if dead.is_empty() {
            return false;
        }
        let inverse = b.input_operands(op);
        let mut operands: Vec<(OpId, Vec<usize>)> = Vec::new();
        for v in &dead {
            for (owner, idx) in inverse.iter().find(|e| e.0 == *v).map(|e| e.1.clone()).unwrap_or_default() {
                match operands.iter_mut().find(|e| e.0 == owner) {
                    Some(e) => e.1.push(idx),
                    None => operands.push((owner, vec![idx])),
                }
            }
        }
        for (owner, idxs) in operands {
            rw.modify(owner, |body| body.erase_operands(owner, &idxs));
        }
        let mut args: Vec<(BlockId, Vec<usize>)> = Vec::new();
        let mut results = Vec::new();
        for v in &dead {
            match rw.body[*v].def {
                crate::Def::Arg(blk, i) => match args.iter_mut().find(|e| e.0 == blk) {
                    Some(e) => e.1.push(i as usize),
                    None => args.push((blk, vec![i as usize])),
                },
                crate::Def::Result(_, i) => results.push(i as usize),
            }
        }
        for (blk, mut idxs) in args {
            idxs.sort_unstable();
            let owner = rw.body.block_owner(blk).expect("in op");
            rw.modify(owner, |body| idxs.iter().rev().for_each(|i| body.erase_arg(blk, *i)));
        }
        if !results.is_empty() {
            rw.erase_op_results(op, &results);
        }
        true
    }
}

impl crate::Pattern for RegionBranchPatterns {
    fn name(&self) -> &str {
        "RegionBranchOpInterfacePatterns"
    }

    fn root(&self) -> Option<&str> {
        Some(self.0)
    }

    fn rewrite(&self, rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        Self::inputs_dead(rw, op) || Self::duplicate_inputs(rw, op) || Self::dead_inputs(rw, op)
    }
}

pub fn patterns(set: &mut PatternSet) {
    set.add(SingleBlockExecuteInliner).add(MultiBlockExecuteInliner).add(RegionBranchPatterns("scf.execute_region"));
    set.add(SimplifyTrivialLoops).add(RegionBranchPatterns("scf.for"));
    set.add(CombineIfs).add(CombineNestedIfs).add(ConditionPropagation).add(ConvertTrivialIfToSelect).add(RemoveEmptyElseBranch).add(RemoveStaticCondition).add(ReplaceIfYieldWithConditionOrValue).add(RegionBranchPatterns("scf.if"));
    set.add(ParallelOpSingleOrZeroIterationDimsFolder).add(MergeNestedParallelLoops);
    set.add(WhileConditionTruth).add(WhileCmpCond).add(WhileOpAlignBeforeArgs).add(WhileMoveIfDown).add(RegionBranchPatterns("scf.while"));
    set.add(FoldConstantCase).add(RegionBranchPatterns("scf.index_switch"));
}
