//! `remove-dead-values`, as `RemoveDeadValues.cpp`: what liveness proves unused goes, with the
//! function arguments and results, branch operands and block arguments carrying it.

use alloc::collections::{BTreeMap, BTreeSet};
use alloc::string::String;
use alloc::vec;
use alloc::vec::Vec;

use crate::pass;
use mlirformat::{Attribute, Error, Type};

use super::dataflow::Solver;
use crate::{Body, BlockId, OpData, OpId, Run, Trait, ValueId, Visibility};

/// `RDVFinalCleanupList`.
#[derive(Default, Clone)]
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
    body: &'b Body<'a>,
    alive: &'s crate::IdVec<ValueId, bool>,
    dead: BTreeSet<ValueId>,
    cl: Cleanup,
    /// The ops naming each private function of the top, in preorder: what a function's callers
    /// are looked up in (`None`: by a scan of the top).
    users: Option<&'s BTreeMap<String, Vec<OpId>>>,
    /// The op of the top's block this walk is of ([`Rdv::cleanup_in`]), and whether a function
    /// was met under it.
    root: Option<OpId>,
    nested: bool,
}

impl<'a> Rdv<'_, '_, 'a> {
    fn body(&self) -> &Body<'a> {
        self.body
    }

    /// `markLives`: whether each value is live (`None`, a produced operand, counts as live).
    fn lives(&self, vs: &[Option<ValueId>]) -> Vec<bool> {
        vs.iter().map(|v| v.is_none_or(|v| !self.dead.contains(&v) && *self.alive.get(v))).collect()
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
        let calls: Vec<OpId> = match self.users {
            Some(users) => users.get(name).cloned().unwrap_or_default(),
            None => b.ops_in(top).into_iter().filter(|o| b.symbol_uses_of(*o).iter().any(|p| p.last().is_some_and(|s| Body::symbol_eq(s, name)))).collect(),
        };
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
        let layouts: Vec<_> = (0..n).map(|k| self.body().successor_layout(op, k).unwrap_or((0, 0..0))).collect();
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
        self.visit(op, top);
    }

    /// What the walk does at `op`, its regions walked.
    fn visit(&mut self, op: OpId, top: OpId) {
        let b = self.body();
        if b.has(op, Trait::FunctionOpInterface) {
            if self.root.is_some_and(|r| r != op) {
                self.nested = true;
            }
            self.func(op, top);
        } else if b.is_region_branch(op) {
            self.region_branch(op);
        } else if b.forwards_to_successors(op) {
            self.branch(op);
        } else if b.might_have(op, Trait::IsTerminator) || b.has(op, Trait::CallOpInterface) {
        } else {
            self.simple(op);
        }
    }
}

impl<'s, 'b, 'a> Rdv<'s, 'b, 'a> {
    fn new(body: &'b Body<'a>, alive: &'s crate::IdVec<ValueId, bool>, users: Option<&'s BTreeMap<String, Vec<OpId>>>) -> Self {
        Rdv { body, alive, dead: BTreeSet::new(), cl: Cleanup::default(), users, root: None, nested: false }
    }

    /// ⭐ The cleanup of `top`, its ops walked in parallel on `exec`: each op of `top`'s block on
    /// its own, its list after the last one's, then `top` itself — the list one walk gives. What
    /// one op's walk marks dead outside it (the results of calls to a function) was not live
    /// already, so no walk sees another's marks. Each function's callers are looked up in one
    /// table made in parallel first, not by a scan of the top per function. A function nested
    /// under an op of the block, or a top with operands or results, is walked serially.
    fn cleanup_in<X: crate::Executor + Sync>(body: &'b Body<'a>, top: OpId, alive: &'s crate::IdVec<ValueId, bool>, exec: &X) -> Cleanup {
        let serial = || {
            let mut r = Rdv::new(body, alive, None);
            r.walk(top, top);
            r.cl
        };
        let children = body.children(top);
        if crate::Executor::threads(exec) < 2 || children.len() < 2 || !body[top].operands.is_empty() || !body[top].results.is_empty() {
            return serial();
        }
        let step = children.len().div_ceil(crate::Executor::threads(exec) * 4).max(1);
        // The private functions' names, and the ops naming each, in preorder.
        let private: BTreeSet<&str> = children.iter().filter(|c| body.has(**c, Trait::FunctionOpInterface) && body.visibility(**c) != Visibility::Public).filter_map(|c| body.sym_name(*c)).collect();
        let naming = |o: OpId, out: &mut BTreeMap<String, Vec<OpId>>| {
            let mut names: Vec<&str> = body.symbol_uses_of(o).iter().filter_map(|p| p.last().map(|s| Body::unquoted(s))).filter(|s| private.contains(s)).map(|s| *private.get(s).expect("a private name")).collect();
            names.sort_unstable();
            names.dedup();
            for n in names {
                out.entry(String::from(n)).or_default().push(o);
            }
        };
        let mut users: BTreeMap<String, Vec<OpId>> = BTreeMap::new();
        if !private.is_empty() {
            naming(top, &mut users);
            let runs: Vec<_> = children
                .chunks(step)
                .map(|run| {
                    let naming = &naming;
                    move || {
                        let mut out = BTreeMap::new();
                        run.iter().flat_map(|c| body.ops_in(*c)).for_each(|o| naming(o, &mut out));
                        out
                    }
                })
                .collect();
            for part in crate::Executor::execute(exec, runs) {
                for (n, ops) in part {
                    users.entry(n).or_default().extend(ops);
                }
            }
        }
        let users = &users;
        let runs: Vec<_> = children
            .chunks(step)
            .map(|run| {
                move || {
                    let mut cl = Cleanup::default();
                    let mut nested = false;
                    for c in run {
                        let mut r = Rdv::new(body, alive, Some(users));
                        r.root = Some(*c);
                        r.walk(*c, top);
                        nested |= r.nested;
                        cl.extend(r.cl);
                    }
                    (cl, nested)
                }
            })
            .collect();
        let parts = crate::Executor::execute(exec, runs);
        if parts.iter().any(|(_, n)| *n) {
            return serial();
        }
        let mut cl = Cleanup::default();
        parts.into_iter().for_each(|(p, _)| cl.extend(p));
        let mut r = Rdv::new(body, alive, Some(users));
        r.visit(top, top);
        cl.extend(r.cl);
        cl
    }
}

impl<'a> Body<'a> {
    /// A symbol reference's name, unquoted.
    fn unquoted(s: &str) -> &str {
        s.strip_prefix('"').and_then(|s| s.strip_suffix('"')).unwrap_or(s)
    }

    /// The symbol references `op` itself holds.
    fn symbol_uses_of(&self, op: OpId) -> Vec<Vec<mlirformat::Str<'a>>> {
        let mut out = Vec::new();
        let mut visit = |a: &Attribute<'a>| Self::symbol_refs(a, &mut out);
        self[op].properties.iter().filter_map(|n| n.value.as_ref()).for_each(&mut visit);
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
        self[op].results = kept.into();
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
        let kept: crate::Ids<_> = self[op].operands.iter().zip(dead).filter(|(_, d)| !**d).map(|(v, _)| *v).collect();
        self.set_operands(op, kept);
    }
}

impl Cleanup {
    /// `o`'s lists after this one's.
    fn extend(&mut self, o: Cleanup) {
        self.operations.extend(o.operations);
        self.functions.extend(o.functions);
        self.operands.extend(o.operands);
        self.results.extend(o.results);
        self.blocks.extend(o.blocks);
        self.successors.extend(o.successors);
    }

    /// The functions losing arguments, and which.
    fn erased_args(&self) -> Vec<(OpId, Vec<bool>)> {
        self.functions.iter().filter(|(_, a, _)| a.contains(&true)).map(|(f, a, _)| (*f, a.clone())).collect()
    }

    /// ⭐ [`apply`](Self::apply) on `exec`: what touches a function with a seg of its own is done
    /// there, on its own thread (lent), in the lists' order; the rest here, in the same order. The
    /// only thing one part needs of another is which arguments each function loses (its calls
    /// drop those operands), known from the lists before anything is done.
    fn apply_in<X: crate::Executor + Sync>(&self, body: &mut Body<'_>, top: OpId, exec: &X) {
        let erased = self.erased_args();
        let owners: BTreeMap<u32, OpId> = body.children(top).into_iter().filter(|c| body.lendable(*c)).map(|c| (crate::Id::seg(c), c)).collect();
        if crate::Executor::threads(exec) < 2 || owners.len() < 2 {
            return self.apply(body, &erased);
        }
        let mut parts: BTreeMap<OpId, Cleanup> = BTreeMap::new();
        let mut rest = Cleanup::default();
        macro_rules! split {
            ($($list:ident => |$e:ident| $key:expr;)*) => {$(
                for $e in &self.$list {
                    let part = owners.get(&crate::Id::seg($key)).map_or(&mut rest, |c| parts.entry(*c).or_default());
                    part.$list.push($e.clone());
                }
            )*};
        }
        split! {
            operations => |e| *e;
            functions => |e| e.0;
            operands => |e| e.0;
            results => |e| e.0;
            blocks => |e| e.0;
            successors => |e| e.0;
        }
        let parts = &parts;
        let erased = &erased;
        let done = body.for_each_child(top, exec, &|b, c| {
            if let Some(cl) = parts.get(&c) {
                cl.apply(b, erased);
            }
        });
        for (c, cl) in parts {
            if !done.contains(c) {
                rest.extend(cl.clone());
            }
        }
        rest.apply(body, erased);
    }

    /// `cleanUpDeadVals`.
    fn apply(&self, body: &mut Body<'_>, erased_args: &[(OpId, Vec<bool>)]) {
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
            let (produced, len) = body.successor_layout(*op, *k).map_or((0, 0), |(p, r)| (p, r.len()));
            if produced + len != dead.len() {
                continue;
            }
            for i in (produced..dead.len()).rev().filter(|i| dead[*i]) {
                body.erase_successor_operand(*op, *k, i - produced);
            }
        }
        for (f, args, rets) in &self.functions {
            body.erase_signature(*f, args, rets);
        }
        for (op, dead, callee, poison) in &self.operands {
            let (op, mut dead, callee, poison) = (*op, dead.clone(), *callee, *poison);
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
        for &op in &self.operations {
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
    }
}

#[pass("remove-dead-values")]
pub struct RemoveDeadValues {
    #[opt("canonicalize", default = true)]
    canonicalize: bool,
}

impl Run for RemoveDeadValues {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        #[cfg(feature = "std")]
        return self.run_in(body, op, &crate::Exec::from(&crate::ThreadMulti::default()));
        #[cfg(not(feature = "std"))]
        self.run_in(body, op, &crate::Exec::from(&crate::ThreadSingle))
    }

    /// The analyses solved function by function on `exec` ([`Solver::liveness_in`]); the cleanup as
    /// before.
    fn run_in<'a>(&self, body: &mut Body<'a>, op: OpId, exec: &crate::Exec<'_>) -> Result<(), Error> {
        let alive = Solver::liveness_in(body, op, exec);
        let cl = Rdv::cleanup_in(body, op, &alive, exec);
        cl.apply_in(body, op, exec);
        if self.canonicalize {
            // In `Operation::walk`'s order (postorder): the worklist pops the last first. A
            // function's region branches are its own: each function's go on its own thread, the
            // rest here, each in that order.
            let patterns = crate::canonicalization_patterns();
            let branches = |b: &Body<'a>, top: OpId, ops: &mut Vec<OpId>| {
                b.walk_post(top, &mut |o| {
                    if b.is_region_branch(o) {
                        ops.push(o);
                    }
                });
            };
            let mut done = body.for_each_child(op, exec, &|b: &mut Body<'a>, c| {
                let mut ops = Vec::new();
                branches(b, c, &mut ops);
                b.apply_op_patterns_greedily(&ops, &patterns);
            });
            done.sort_unstable();
            let mut ops = Vec::new();
            for c in body.children(op) {
                if done.binary_search(&c).is_err() {
                    branches(body, c, &mut ops);
                }
            }
            if body.is_region_branch(op) {
                ops.push(op);
            }
            body.apply_op_patterns_greedily(&ops, &patterns);
        }
        Ok(())
    }
}
