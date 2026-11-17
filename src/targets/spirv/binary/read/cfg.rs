use alloc::string::String;
use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{Attribute, Error, Type};

use crate::targets::tree::{At, B, Mapping, O, V};
use super::{Merge, Reader};

/// Terminators the structurizer and the phi wiring know
#[derive(Clone, Copy, PartialEq, Eq)]
enum Term {
    Branch,
    BranchConditional,
    Switch,
}

impl Term {
    const TABLE: &'static [(&'static str, Term)] = &[("spirv.Branch", Term::Branch), ("spirv.BranchConditional", Term::BranchConditional), ("spirv.Switch", Term::Switch)];

    fn of(name: &str) -> Option<Term> {
        Term::TABLE.iter().find(|(n, _)| *n == name).map(|(_, t)| *t)
    }
}

impl Reader<'_> {
    const MERGE: &'static str = "spirv.mlir.merge";

    fn func_op(&self) -> O {
        self.func.expect("inside a function")
    }

    fn is_fn_entry(&self, b: B) -> bool {
        let Some(r) = self.tree.blk(b).region else { return false };
        self.tree.reg(r).blocks.first() == Some(&b) && self.tree.reg(r).parent.is_some_and(|p| self.tree.node(p).name == "spirv.func")
    }

    /// Hands each predecessor's OpPhi values to its branch, as `Deserializer::wireUpBlockArgument`
    pub fn wire_phis(&mut self) -> Result<(), Error> {
        for ((pred, target), ids) in core::mem::take(&mut self.phis) {
            let term = self.tree.terminator(pred).ok_or_else(|| Error::from("OpPhi from a block without a terminator"))?;
            self.tree.at = Some(At::Before(term));
            let args = ids.iter().map(|id| self.value(*id)).collect::<Result<Vec<V>, _>>().map_err(|_| Error::from("OpPhi references undefined value!"))?;
            let n = self.tree.node(term);
            match Term::of(&n.name) {
                Some(Term::Branch) => self.tree.node_mut(term).operands = args,
                Some(Term::BranchConditional) => {
                    let (t, f) = (self.tree.successor_operands(term, 0), self.tree.successor_operands(term, 1));
                    let ops = &self.tree.node(term).operands;
                    let (cond, mut ta, mut fa) = (ops[0], ops[t].to_vec(), ops[f].to_vec());
                    if self.tree.node(term).succ[0] == target {
                        ta = args;
                    } else {
                        fa = args;
                    }
                    let mut all = vec![cond];
                    all.extend(&ta);
                    all.extend(&fa);
                    let node = self.tree.node_mut(term);
                    node.operands = all;
                    node.set(Reader::SEGMENTS, Attribute::dense_array(32, &[1, ta.len(), fa.len()]));
                }
                Some(Term::Switch) => {
                    let succ = self.tree.node(term).succ.clone();
                    let mut groups: Vec<Vec<V>> = (0..succ.len()).map(|i| self.tree.node(term).operands[self.tree.successor_operands(term, i)].to_vec()).collect();
                    let i = succ.iter().position(|s| *s == target).expect("a switch target");
                    groups[i] = args;
                    let sel = self.tree.node(term).operands[0];
                    let mut all = vec![sel];
                    for g in &groups {
                        all.extend(g);
                    }
                    let cases: Vec<usize> = groups[1..].iter().map(Vec::len).collect();
                    let node = self.tree.node_mut(term);
                    node.operands = all;
                    node.set(Reader::SEGMENTS, Attribute::dense_array(32, &[1, groups[0].len(), cases.iter().sum()]));
                    node.set(Reader::CASE_SEGMENTS, Attribute::dense_array(32, &cases));
                }
                None => return Err(Error::from("unimplemented terminator for Phi creation")),
            }
        }
        Ok(())
    }

    /// A selection header with more than its branch, or one that also merges another construct,
    /// is split so the branch starts a block of its own
    fn split_selection_headers(&mut self) {
        let headers: Vec<(B, Merge)> = self.merges.clone();
        for (b, m) in headers {
            if m.cont.is_some() {
                continue;
            }
            let Some(term) = self.tree.terminator(b) else { continue };
            if !matches!(Term::of(&self.tree.node(term).name), Some(Term::BranchConditional | Term::Switch)) {
                continue;
            }
            let merges_another = self.merges.iter().any(|(_, x)| x.merge == b);
            if self.tree.blk(b).ops.len() > 1 || merges_another {
                let new = self.tree.split(b, term);
                self.tree.at = Some(At::End(b));
                self.tree.create("spirv.Branch", &[], &[], Vec::new(), &[new], 0);
                if let Some(e) = self.merges.iter_mut().find(|(h, _)| *h == b) {
                    e.0 = new;
                }
            }
        }
    }

    /// Puts each selection and loop into a `spirv.mlir.selection` / `spirv.mlir.loop`, as
    /// `Deserializer::structurizeControlFlow`
    pub fn structurize(&mut self) -> Result<(), Error> {
        self.split_selection_headers();
        while !self.merges.is_empty() {
            let (header, m) = self.merges.remove(0);
            if m.cont.is_some() && !self.tree.blk(m.merge).args.is_empty() {
                return Err(Error::from("OpPhi in loop merge block unimplemented"));
            }
            self.construct(header, m)?;
        }
        Ok(())
    }

    fn successors(&self, b: B) -> Vec<B> {
        self.tree.terminator(b).map(|t| self.tree.node(t).succ.clone()).unwrap_or_default()
    }

    fn construct(&mut self, header: B, m: Merge) -> Result<(), Error> {
        let f = self.func_op();
        let is_loop = m.cont.is_some();
        let merge = m.merge;
        let (name, control_name, class) = if is_loop { ("spirv.mlir.loop", "loop_control", "LoopControl") } else { ("spirv.mlir.selection", "selection_control", "SelectionControl") };
        let control = Reader::enum_attr(class, m.control)?;
        self.tree.start(merge);
        let op = self.tree.create(name, &[], &[], vec![(String::from(control_name), control.clone())], &[], 1);
        let body = self.tree.node(op).regions[0];
        if is_loop {
            self.tree.block_in(body);
        }
        let region_merge = self.tree.block_in(body);
        self.tree.at = Some(At::End(region_merge));
        self.tree.create(Reader::MERGE, &[], &[], Vec::new(), &[], 0);

        let mut map = Mapping::new();
        map.blocks.insert(merge, region_merge);
        let mut construct = vec![header];
        let mut i = 0;
        while i < construct.len() {
            for s in self.successors(construct[i]) {
                if s != merge && !construct.contains(&s) {
                    construct.push(s);
                }
            }
            i += 1;
        }
        for b in &construct {
            let nb = self.tree.detached();
            self.tree.place(body, nb, Some(region_merge));
            map.blocks.insert(*b, nb);
            if !self.is_fn_entry(*b) {
                for a in self.tree.blk(*b).args.clone() {
                    let na = self.tree.arg(nb, self.tree.ty(a).clone());
                    map.values.insert(a, na);
                }
            }
        }
        for b in &construct {
            let nb = map.block(*b);
            self.tree.at = Some(At::End(nb));
            for o in self.tree.blk(*b).ops.clone() {
                self.tree.clone_op(o, &mut map);
            }
        }
        let mut inside = Vec::new();
        for b in self.tree.reg(body).blocks.clone() {
            self.tree.walk_block(b, &mut inside);
        }
        for o in inside {
            let n = self.tree.node_mut(o);
            for v in &mut n.operands {
                *v = map.value(*v);
            }
            for s in &mut n.succ {
                *s = map.block(*s);
            }
        }
        self.tree.replace_block_uses(f, header, merge);

        if is_loop {
            let mut args = Vec::new();
            for a in self.tree.blk(header).args.clone() {
                args.push(self.tree.arg(merge, self.tree.ty(a).clone()));
            }
            let entry = self.tree.reg(body).blocks[0];
            self.tree.at = Some(At::End(entry));
            self.tree.create("spirv.Branch", &args, &[], Vec::new(), &[map.block(header)], 0);
        }

        let mut yields: Vec<V> = Vec::new();
        let mut outside: Vec<V> = Vec::new();
        if !is_loop {
            for a in self.tree.blk(merge).args.clone() {
                let na = self.tree.arg(region_merge, self.tree.ty(a).clone());
                yields.push(na);
                outside.push(a);
            }
        }
        for b in &construct {
            let mut all = Vec::new();
            self.tree.walk_block(*b, &mut all);
            for o in all {
                let n = self.tree.node_mut(o);
                n.operands.clear();
                n.succ.clear();
            }
        }
        for b in &construct {
            for o in self.tree.blk(*b).ops.clone() {
                for r in self.tree.node(o).results.clone() {
                    if self.tree.used(f, r) {
                        yields.push(map.value(r));
                        outside.push(r);
                    }
                }
            }
            for a in self.tree.blk(*b).args.clone() {
                if self.tree.used(f, a) {
                    yields.push(map.value(a));
                    outside.push(a);
                }
            }
        }
        if !yields.is_empty() {
            let mo = self.tree.terminator(region_merge).expect("the merge op");
            self.tree.node_mut(mo).operands = yields.clone();
            let types: Vec<Type<'static>> = outside.iter().map(|v| self.tree.ty(*v).clone()).collect();
            self.tree.at = Some(At::Before(op));
            let new = self.tree.create(name, &[], &types, vec![(String::from(control_name), control)], &[], 0);
            let regions = core::mem::take(&mut self.tree.node_mut(op).regions);
            for r in &regions {
                self.tree.reg_mut(*r).parent = Some(new);
            }
            self.tree.node_mut(new).regions = regions;
            self.tree.unlink(op);
            for (old, res) in outside.iter().zip(self.tree.node(new).results.clone()) {
                self.tree.replace_uses(f, *old, res);
            }
            if !is_loop {
                self.tree.blk_mut(merge).args.clear();
            }
        }
        for b in &construct {
            if self.tree.block_used(f, *b) {
                return Err(Error::from("failed control flow structurization: block has uses outside of the enclosing selection/loop construct"));
            }
        }
        for b in &construct {
            let mut nested = Vec::new();
            for o in self.tree.blk(*b).ops.clone() {
                self.tree.blocks_under(o, &mut nested);
            }
            for x in core::iter::once(*b).chain(nested) {
                if let Some(e) = self.merges.iter_mut().find(|(h, _)| *h == x) {
                    let nh = map.blocks.get(&x).copied().ok_or_else(|| Error::from("failed control flow structurization: nested loop header block should be remapped!"))?;
                    e.0 = nh;
                    if let Some(c) = e.1.cont {
                        e.1.cont = Some(map.blocks.get(&c).copied().ok_or_else(|| Error::from("failed control flow structurization: nested loop continue block should be remapped!"))?);
                    }
                    e.1.merge = map.block(e.1.merge);
                }
            }
            if self.is_fn_entry(*b) {
                for o in self.tree.blk(*b).ops.clone() {
                    self.tree.unlink(o);
                }
                self.tree.at = Some(At::End(*b));
                self.tree.create("spirv.Branch", &[], &[], Vec::new(), &[merge], 0);
            } else {
                let r = self.tree.blk(*b).region.expect("a placed block");
                self.tree.reg_mut(r).blocks.retain(|x| x != b);
                self.tree.blk_mut(*b).region = None;
                for o in self.tree.blk(*b).ops.clone() {
                    self.tree.unlink(o);
                }
            }
        }
        Ok(())
    }
}
