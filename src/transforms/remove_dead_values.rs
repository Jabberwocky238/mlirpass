//! `remove-dead-values`, as `RemoveDeadValues.cpp`: what liveness proves unused goes, with the
//! function arguments and results, branch operands and block arguments carrying it.

use alloc::collections::BTreeSet;
use alloc::vec;
use alloc::vec::Vec;

use mlirpass_macros::pass;
use mlirformat::{Attribute, Error, Type};

use crate::dataflow::Solver;
use crate::{Body, BlockId, OpData, OpId, Run, Trait, ValueId, Visibility};

/// `RDVFinalCleanupList`.
#[derive(Default)]
struct Cleanup {
    operations: Vec<OpId>,
    /// (function, dead arguments, dead results).
    functions: Vec<(OpId, Vec<bool>, Vec<bool>)>,
    /// (op, dead operands, callee, replace with poison).
    operands: Vec<(OpId, Vec<bool>, Option<OpId>, bool)>,
    results: Vec<(OpId, Vec<bool>)>,
    blocks: Vec<(BlockId, Vec<bool>)>,
    successors: Vec<(OpId, usize, Vec<bool>)>,
}

struct Rdv<'s, 'b, 'a> {
    s: &'s mut Solver<'b, 'a>,
    dead: BTreeSet<ValueId>,
    cl: Cleanup,
}

impl<'a> Rdv<'_, '_, 'a> {
    fn body(&self) -> &Body<'a> {
        self.s.body
    }

    /// `markLives`: whether each value is live (`None`, a produced operand, counts as live).
    fn lives(&self, vs: &[Option<ValueId>]) -> Vec<bool> {
        vs.iter().map(|v| v.is_none_or(|v| !self.dead.contains(&v) && self.s.is_alive(v))).collect()
    }

    fn has_live(&self, vs: &[ValueId]) -> bool {
        self.lives(&vs.iter().map(|v| Some(*v)).collect::<Vec<_>>()).contains(&true)
    }

    fn collect(&mut self, vs: &[ValueId], dead: &[bool]) {
        for (v, d) in vs.iter().zip(dead) {
            if *d {
                self.dead.insert(*v);
            }
        }
    }

    fn simple(&mut self, op: OpId) {
        let operands: Vec<_> = self.body()[op].operands.iter().map(|v| Some(*v)).collect();
        let results = self.body()[op].results.clone();
        if self.lives(&operands).contains(&false) {
            self.cl.operations.push(op);
            self.collect(&results, &vec![true; results.len()]);
            return;
        }
        if !self.body().is_memory_effect_free(op) || self.has_live(&results) {
            return;
        }
        self.cl.operations.push(op);
        self.collect(&results, &vec![true; results.len()]);
    }

    fn func(&mut self, f: OpId, top: OpId) {
        let b = self.body();
        let Some(&region) = b[f].regions.first() else { return };
        if b.visibility(f) == Visibility::Public || b[region].blocks.is_empty() {
            return;
        }
        let entry = b[region].blocks[0];
        let args = b[entry].args.clone();
        let dead_args: Vec<bool> = self.lives(&args.iter().map(|v| Some(*v)).collect::<Vec<_>>()).iter().map(|l| !l).collect();
        self.collect(&args, &dead_args);
        let b = self.body();
        let name = b.sym_name(f).unwrap_or_default();
        let calls: Vec<OpId> = b.ops_in(top).into_iter().filter(|o| b.symbol_uses_of(*o).iter().any(|p| p.last().is_some_and(|s| Body::symbol_eq(s, name)))).collect();
        for c in &calls {
            let n = self.body()[*c].operands.len();
            self.cl.operands.push((*c, vec![false; n], Some(f), false));
        }
        let n_rets = match self.body()[f].get("function_type") {
            Some(Attribute::Type(Type::Function(t))) => t.results.len(),
            _ => 0,
        };
        let mut dead_rets = vec![true; n_rets];
        for c in &calls {
            let rs: Vec<_> = self.body()[*c].results.iter().map(|v| Some(*v)).collect();
            for (d, l) in dead_rets.iter_mut().zip(self.lives(&rs)) {
                *d &= !l;
            }
        }
        for blk in self.body()[region].blocks.clone() {
            let Some(&t) = self.body()[blk].ops.last() else { continue };
            if self.body().has(t, Trait::ReturnLike) && self.body()[t].operands.len() == n_rets {
                self.cl.operands.push((t, dead_rets.clone(), None, false));
            }
        }
        self.cl.functions.push((f, dead_args, dead_rets.clone()));
        if n_rets == 0 {
            return;
        }
        for c in calls {
            self.cl.results.push((c, dead_rets.clone()));
            let rs = self.body()[c].results.clone();
            self.collect(&rs, &dead_rets);
        }
    }

    fn region_branch(&mut self, op: OpId) {
        let results = self.body()[op].results.clone();
        if self.body().is_memory_effect_free(op) && !self.has_live(&results) {
            self.cl.operations.push(op);
            return;
        }
        let mut per_op: Vec<(OpId, Vec<bool>)> = Vec::new();
        for ((owner, i), inputs) in self.body().operand_inputs(op) {
            let v = self.body()[owner].operands[i];
            if self.has_live(&[v]) && self.has_live(&inputs) {
                continue;
            }
            let n = self.body()[owner].operands.len();
            match per_op.iter_mut().find(|e| e.0 == owner) {
                Some(e) => e.1[i] = true,
                None => {
                    let mut d = vec![false; n];
                    d[i] = true;
                    per_op.push((owner, d));
                }
            }
        }
        for (o, d) in per_op {
            self.cl.operands.push((o, d, None, true));
        }
    }

    fn branch(&mut self, op: OpId) {
        let operands: Vec<_> = self.body()[op].operands.iter().map(|v| Some(*v)).collect();
        let mut dead_unforwarded: Vec<bool> = self.lives(&operands).iter().map(|l| !l).collect();
        let n = self.body()[op].successors.len();
        let layouts: Vec<_> = (0..n).map(|k| self.s.successor_layout(op, k).unwrap_or((0, 0..0))).collect();
        for (_, r) in &layouts {
            for i in r.clone() {
                dead_unforwarded[i] = false;
            }
        }
        if dead_unforwarded.contains(&true) {
            self.cl.operations.push(op);
            return;
        }
        for (k, (produced, r)) in layouts.into_iter().enumerate() {
            let blk = self.body()[op].successors[k];
            let mut vals: Vec<Option<ValueId>> = vec![None; produced];
            vals.extend(r.map(|i| Some(self.body()[op].operands[i])));
            let dead: Vec<bool> = self.lives(&vals).iter().map(|l| !l).collect();
            let args = self.body()[blk].args.clone();
            self.collect(&args, &dead);
            self.cl.blocks.push((blk, dead.clone()));
            self.cl.successors.push((op, k, dead));
        }
    }

    fn walk(&mut self, op: OpId, top: OpId) {
        for r in self.body()[op].regions.clone() {
            for b in self.body()[r].blocks.clone() {
                for o in self.body()[b].ops.clone() {
                    self.walk(o, top);
                }
            }
        }
        let b = self.body();
        if b.has(op, Trait::FunctionOpInterface) {
            self.func(op, top);
        } else if b.is_region_branch(op) {
            self.region_branch(op);
        } else if b.is_branch(op) || b[op].name == "test.internal_br" {
            self.branch(op);
        } else if b.might_have(op, Trait::IsTerminator) || b.has(op, Trait::CallOpInterface) {
        } else {
            self.simple(op);
        }
    }
}

impl<'a> Body<'a> {
    /// The symbol references `op` itself holds.
    fn symbol_uses_of(&self, op: OpId) -> Vec<Vec<mlirformat::Str<'a>>> {
        let mut out = Vec::new();
        let mut visit = |a: &Attribute<'a>| Self::symbol_refs(a, &mut out);
        self[op].properties.iter().for_each(&mut visit);
        self[op].attributes.iter().filter_map(|n| n.value.as_ref()).for_each(visit);
        out
    }

    fn symbol_refs(a: &Attribute<'a>, out: &mut Vec<Vec<mlirformat::Str<'a>>>) {
        match a {
            Attribute::SymbolRef(p) => out.push(p.clone()),
            Attribute::Array(xs) => xs.iter().for_each(|x| Self::symbol_refs(x, out)),
            Attribute::Dict(d) => d.iter().filter_map(|n| n.value.as_ref()).for_each(|x| Self::symbol_refs(x, out)),
            _ => {}
        }
    }

    fn symbol_eq(s: &str, name: &str) -> bool {
        s.strip_prefix('"').and_then(|s| s.strip_suffix('"')).unwrap_or(s) == name
    }

    /// `dropAllUses`: the uses of `v` go to a detached placeholder.
    fn drop_all_uses(&mut self, v: ValueId) {
        if self[v].uses.is_empty() {
            return;
        }
        let ty = self[v].ty.clone();
        let p = self.create(OpData::build("rdv.dropped"), &[ty]);
        let r = self[p].results[0];
        self.replace_all_uses(v, r);
    }

    /// Erases the flagged results of `op` (`eraseOpResults`), their uses dropped.
    fn erase_results(&mut self, op: OpId, dead: &[bool]) {
        let results = self[op].results.clone();
        let mut kept = Vec::new();
        for (r, d) in results.iter().zip(dead) {
            if *d {
                self.drop_all_uses(*r);
            } else {
                kept.push(*r);
            }
        }
        for (k, r) in kept.iter().enumerate() {
            self[*r].def = crate::Def::Result(op, k as u32);
        }
        self[op].results = kept;
    }

    /// Removes the flagged entries of array attribute `name`; an array left all empty goes.
    fn erase_attr_entries(&mut self, op: OpId, name: &str, dead: &[bool]) {
        let Some(Attribute::Array(xs)) = self[op].get(name).cloned() else { return };
        let kept: Vec<_> = xs.into_iter().zip(dead.iter().chain(core::iter::repeat(&false))).filter(|(_, d)| !**d).map(|(x, _)| x).collect();
        if kept.iter().all(|x| matches!(x, Attribute::Dict(d) if d.is_empty())) {
            self[op].remove(name);
        } else {
            self[op].set(name, Attribute::Array(kept));
        }
    }

    /// `FunctionOpInterface::eraseArguments` / `eraseResults`.
    fn erase_signature(&mut self, f: OpId, args: &[bool], rets: &[bool]) {
        let Some(Attribute::Type(Type::Function(mut t))) = self[f].get("function_type").cloned() else { return };
        let keep = |v: Vec<Type<'a>>, d: &[bool]| v.into_iter().enumerate().filter(|(i, _)| !d.get(*i).copied().unwrap_or(false)).map(|(_, x)| x).collect();
        t.inputs = keep(t.inputs, args);
        t.results = keep(t.results, rets);
        self[f].set("function_type", Attribute::Type(Type::Function(t)));
        if args.contains(&true) {
            self.erase_attr_entries(f, "arg_attrs", args);
            let entry = self[self[f].regions[0]].blocks[0];
            for i in (0..args.len()).rev().filter(|i| args[*i]) {
                let a = self[entry].args[i];
                self.drop_all_uses(a);
                self.erase_arg(entry, i);
            }
        }
        if rets.contains(&true) {
            self.erase_attr_entries(f, "res_attrs", rets);
        }
    }

    /// `eraseOperands`, the operand segments shrinking with them.
    fn erase_flagged_operands(&mut self, op: OpId, dead: &[bool]) {
        if let Some(seg) = self.segments(op, "operandSegmentSizes") {
            let mut start = 0;
            let new: Vec<usize> = seg.iter().map(|n| {
                let gone = dead.iter().skip(start).take(*n).filter(|d| **d).count();
                start += n;
                n - gone
            }).collect();
            self.set_segments(op, "operandSegmentSizes", &new);
        }
        let kept = self[op].operands.iter().zip(dead).filter(|(_, d)| !**d).map(|(v, _)| *v).collect();
        self.set_operands(op, kept);
    }
}

impl Cleanup {
    /// `cleanUpDeadVals`.
    fn apply(self, body: &mut Body<'_>) {
        for (b, dead) in &self.blocks {
            if body[*b].args.len() != dead.len() {
                continue;
            }
            for i in (0..dead.len()).rev().filter(|i| dead[*i]) {
                let a = body[*b].args[i];
                body.drop_all_uses(a);
                body.erase_arg(*b, i);
            }
        }
        for (op, k, dead) in &self.successors {
            let (produced, len) = match body[*op].name.as_ref() {
                "test.internal_br" => (*k, body.segments(*op, "operandSegmentSizes").and_then(|s| s.get(*k).copied()).unwrap_or(0)),
                _ => (0, body.successor_operands(*op, *k).map_or(0, |r| r.len())),
            };
            if produced + len != dead.len() {
                continue;
            }
            for i in (produced..dead.len()).rev().filter(|i| dead[*i]) {
                body.erase_successor_operand(*op, *k, i - produced);
            }
        }
        let mut erased_args: Vec<(OpId, Vec<bool>)> = Vec::new();
        for (f, args, rets) in &self.functions {
            body.erase_signature(*f, args, rets);
            if args.contains(&true) {
                erased_args.push((*f, args.clone()));
            }
        }
        let mut poisons = Vec::new();
        for (op, mut dead, callee, poison) in self.operands {
            let mut handled = false;
            if let Some(c) = callee
                && body.has(op, Trait::CallOpInterface)
                && let Some((_, args)) = erased_args.iter().find(|e| e.0 == c)
            {
                let first = body.call_arg_range(op).start;
                let mut flags = vec![false; body[op].operands.len()];
                for (i, d) in args.iter().enumerate() {
                    if *d && first + i < flags.len() {
                        flags[first + i] = true;
                        if first + i < dead.len() {
                            dead[first + i] = false;
                        }
                    }
                }
                body.erase_flagged_operands(op, &flags);
                handled = true;
            }
            if handled || !dead.contains(&true) {
                continue;
            }
            if poison {
                for i in (0..dead.len()).filter(|i| dead[*i]) {
                    let ty = body[body[op].operands[i]].ty.clone();
                    let p = body.create(OpData::build("ub.poison").with("value", Attribute::Extended { ext: mlirformat::Extended { name: "ub.poison".into(), body: None, params: Vec::new() }, ty: None }), &[ty]);
                    body.insert_before(p, op);
                    poisons.push(p);
                    let r = body[p].results[0];
                    body.set_operand(op, i, r);
                }
            } else {
                body.erase_flagged_operands(op, &dead);
            }
        }
        for (op, dead) in &self.results {
            body.erase_results(*op, dead);
        }
        for op in self.operations {
            if body[op].parent.is_none() {
                continue;
            }
            if body.might_have(op, Trait::IsTerminator) {
                let u = body.create(OpData::build("ub.unreachable"), &[]);
                body.insert_before(u, op);
            }
            for r in body[op].results.clone() {
                body.drop_all_uses(r);
            }
            body.erase(op);
        }
        for p in poisons {
            if body[p].parent.is_some() && body[body[p].results[0]].uses.is_empty() {
                body.erase(p);
            }
        }
    }
}

#[pass("remove-dead-values")]
pub struct RemoveDeadValues {
    #[opt("canonicalize", default = true)]
    canonicalize: bool,
}

impl Run for RemoveDeadValues {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let mut s = Solver::new(body, op);
        s.run_liveness();
        let mut r = Rdv { s: &mut s, dead: BTreeSet::new(), cl: Cleanup::default() };
        r.walk(op, op);
        let cl = r.cl;
        cl.apply(body);
        if self.canonicalize {
            let ops: Vec<OpId> = body.ops_in(op).into_iter().filter(|o| body.is_region_branch(*o)).collect();
            body.apply_op_patterns_greedily(&ops, &crate::canon::patterns());
        }
        Ok(())
    }
}
