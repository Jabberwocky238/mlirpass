//! ⭐ `apple9-regalloc`: a kernel's virtual Apple9 instructions ⇒ GPRs ([`LinearScan`] over the 32-bit GPRs r0 ..
//! r62; r63 is `apple9-wait`'s). A store of several dwords gets its data copied into a run first (`or` of a value
//! with itself); a load's (an atomic's) destination is kept apart from its sources. Then each instruction gets its registers in the
//! attributes [`Apple9Op::sources`] names (a store's `data` the run's first), `dst` its result's (a load's: the
//! first of its components), and the kernel `gprs`.
//!
//! Structured control flow (`scf.if`, `scf.while`) stays, of registers: what it carries gets one register (a web: a
//! copy of each value going in, the region arguments, a copy of what each region yields, the results; a loop's yields
//! copied twice, so one carried value read for another is read before it is written), a value read in a loop lives to
//! the loop's end; then the ops lose their values (`apple9-control` makes them masks).
//!
//! A source read for the last time is released (`release`, a bit per source; the forms [`Apple9Op::releases`]):
//! no later instruction reads it, the instruction does not read it twice, and no loop around the instruction runs it
//! again with the value from outside the loop. (A released source is gone: one still needed reads back as zero.)

use alloc::collections::BTreeMap;
use alloc::format;
use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{Attribute, Error, Op};

use crate::{A, Apple9Kernel, Apple9Op, Apple9Type, Body, Groups, Kernels, LinearScan, OpData, OpId, Quiet, RegTarget, Rewriter, Updates, ValueId, pass};

/// The GPRs a kernel's values may take (r63 is the waits').
const GPRS: core::ops::Range<u32> = 0..63;
/// The register `apple9-wait`'s waits write (nothing reads it).
pub const APPLE9_WAIT_GPR: u32 = 63;

/// The one register file.
struct Files;

impl RegTarget for Files {
    fn preset(&self, _: &Body<'_>, _: OpId) -> Result<Option<u32>, Error> {
        Ok(None)
    }

    fn reuses_sources(&self, body: &Body<'_>, op: OpId) -> bool {
        !matches!(Apple9Op::of(&body[op].name), Some(Apple9Op::Load | Apple9Op::SharedLoad | Apple9Op::Atomic | Apple9Op::Cmpxchg | Apple9Op::SharedAtomic))
    }

    fn file(&self, body: &Body<'_>, v: ValueId) -> Result<usize, Error> {
        Apple9Type::try_from(&body[v].ty).map(|_| 0)
    }

    fn size(&self, _: &Body<'_>, _: ValueId) -> Result<(u32, u32), Error> {
        Ok((1, 1))
    }

    fn is_loop(&self, body: &Body<'_>, op: OpId) -> bool {
        body[op].name == "scf.while"
    }
}

/// The structured control flow ops a kernel keeps through the allocation.
pub const APPLE9_STRUCTURED: [&str; 4] = ["scf.if", "scf.while", "scf.condition", "scf.yield"];

/// One kernel being allocated.
struct Alloc<'r, 'a> {
    rw: Rewriter<'r, 'a>,
    kernel: OpId,
}

impl<'a> Alloc<'_, 'a> {
    /// The kernel's instructions in order, into its loops and branches (not those ops themselves).
    fn ops(&self) -> Vec<OpId> {
        let mut out = Vec::new();
        Self::instructions(self.rw.body, self.rw.body.top_block(self.kernel), &mut out);
        out
    }

    fn instructions(body: &Body<'_>, block: crate::BlockId, out: &mut Vec<OpId>) {
        for op in body.ops(block) {
            if !APPLE9_STRUCTURED.contains(&&*body[op].name) {
                out.push(op);
            }
            for &r in &body[op].regions {
                for &b in &body[r].blocks {
                    Self::instructions(body, b, out);
                }
            }
        }
    }

    /// The structured ops of the kernel, outer before inner.
    fn structured(&self) -> Vec<OpId> {
        let mut out = Vec::new();
        self.rw.body.walk(self.kernel, &mut |o| {
            if APPLE9_STRUCTURED.contains(&&*self.rw.body[o].name) {
                out.push(o);
            }
        });
        out
    }

    fn is(&self, op: OpId, name: &str) -> bool {
        self.rw.body[op].name == name
    }

    /// A copy of `v` (`or` of it with itself) before `before`.
    fn copy(&mut self, v: ValueId, before: OpId) -> ValueId {
        let ty = self.rw.body[v].ty.clone();
        self.rw.set_before(before);
        let c = self.rw.create(OpData::build(Apple9Op::Or.name()).operands(&[v, v]), &[ty]);
        self.rw.body[c].results[0]
    }

    /// The operands of terminator `t` from `from` on, each copied to a temporary and the temporary copied again (all
    /// the temporaries first); the second copies.
    fn twice(&mut self, t: OpId, from: usize) -> Vec<ValueId> {
        let values = self.rw.body[t].operands[from..].to_vec();
        let temps: Vec<ValueId> = values.iter().map(|v| self.copy(*v, t)).collect();
        let mut out = Vec::new();
        for (k, tmp) in temps.into_iter().enumerate() {
            let c = self.copy(tmp, t);
            self.rw.modify(t, |b| b.set_operand(t, from + k, c));
            out.push(c);
        }
        out
    }

    /// What a loop or a branch carries, a register each (the linear scan's webs).
    fn webs(&mut self) -> Vec<Vec<ValueId>> {
        let mut webs = Vec::new();
        for op in self.structured() {
            match &*self.rw.body[op].name {
                "scf.while" => {
                    // carried: the initial copy, the condition region's argument, (twice) copied what the body yields;
                    // forwarded: (twice) copied what the condition passes on, the body's argument, the result
                    let [before, after] = [0, 1].map(|i| self.rw.body[self.rw.body[op].regions[i]].blocks[0]);
                    let inits = self.rw.body[op].operands.to_vec();
                    let mut carried: Vec<Vec<ValueId>> = Vec::new();
                    for (k, v) in inits.into_iter().enumerate() {
                        let c = self.copy(v, op);
                        self.rw.modify(op, |b| b.set_operand(op, k, c));
                        carried.push(vec![c, self.rw.body[before].args[k]]);
                    }
                    if let Some(y) = self.rw.body.last_op(after).filter(|y| self.is(*y, "scf.yield")) {
                        for (k, c) in self.twice(y, 0).into_iter().enumerate() {
                            carried[k].push(c);
                        }
                    }
                    let mut forwarded: Vec<Vec<ValueId>> = self.rw.body[after].args.iter().map(|a| vec![*a]).collect();
                    if let Some(c) = self.rw.body.last_op(before).filter(|c| self.is(*c, "scf.condition")) {
                        for (k, v) in self.twice(c, 1).into_iter().enumerate() {
                            forwarded[k].push(v);
                        }
                    }
                    for (k, r) in self.rw.body[op].results.iter().copied().enumerate() {
                        forwarded[k].push(r);
                    }
                    webs.extend(carried);
                    webs.extend(forwarded);
                }
                "scf.if" => {
                    let results = self.rw.body[op].results.to_vec();
                    let mut carried: Vec<Vec<ValueId>> = results.iter().map(|r| vec![*r]).collect();
                    let regions = self.rw.body[op].regions.clone();
                    for r in regions {
                        let Some(&b) = self.rw.body[r].blocks.first() else { continue };
                        let Some(y) = self.rw.body.last_op(b).filter(|y| self.is(*y, "scf.yield")) else { continue };
                        let yielded = self.rw.body[y].operands.clone();
                        for (k, v) in yielded.into_iter().enumerate() {
                            let c = self.copy(v, y);
                            self.rw.modify(y, |b| b.set_operand(y, k, c));
                            carried[k].push(c);
                        }
                    }
                    webs.extend(carried);
                }
                _ => {}
            }
        }
        webs
    }

    /// Whether block `b` is inside op `l` (at any depth).
    fn within(body: &Body<'_>, mut b: crate::BlockId, l: OpId) -> bool {
        while let Some(owner) = body.block_owner(b) {
            if owner == l {
                return true;
            }
            let Some(p) = body[owner].parent else { return false };
            b = p;
        }
        false
    }

    /// The sources each instruction reads for the last time (a bit per source, in [`Apple9Op::sources`] order): no
    /// later instruction reads the value, it is not read by the same instruction twice, and no loop around the
    /// instruction that the value comes from outside of runs it again.
    fn releases(&self) -> BTreeMap<OpId, u32> {
        let body = &*self.rw.body;
        let ops = self.ops();
        let at: BTreeMap<OpId, usize> = ops.iter().enumerate().map(|(i, o)| (*o, i)).collect();
        let mut out = BTreeMap::new();
        for &op in &ops {
            let operands = &body[op].operands;
            let mut mask = 0;
            for (s, v) in operands.iter().enumerate() {
                if operands.iter().filter(|w| *w == v).count() > 1 {
                    continue;
                }
                let last = body[*v].uses.iter().filter_map(|u| at.get(&u.op)).all(|i| *i <= at[&op]);
                // the loops around the instruction: none may lie between it and the value's definition
                let Some(home) = body.value_block(*v) else { continue };
                let mut looped = false;
                let mut b = body[op].parent;
                while let Some(blk) = b {
                    let Some(owner) = body.block_owner(blk) else { break };
                    if body[owner].name == "scf.while" && !Self::within(body, home, owner) {
                        looped = true;
                        break;
                    }
                    b = body[owner].parent;
                }
                if last && !looped {
                    mask |= 1 << s;
                }
            }
            if mask != 0 {
                out.insert(op, mask);
            }
        }
        out
    }

    /// The structured ops without their values (what they carry is in its registers already).
    fn structure(&mut self) {
        for op in self.structured() {
            self.rw.modify(op, |b| {
                b.set_operands(op, Vec::new());
                b[op].results.clear();
                for r in b[op].regions.clone() {
                    for blk in b[r].blocks.clone() {
                        b[blk].args.clear();
                    }
                }
            });
        }
    }

    /// A store's data copied into a run.
    fn prepare(&mut self) -> Groups {
        let mut groups = Groups::new();
        for op in self.ops() {
            if !matches!(Apple9Op::of(&self.rw.body[op].name), Some(Apple9Op::Store | Apple9Op::Cmpxchg | Apple9Op::SharedAtomic)) {
                continue;
            }
            let n = self.rw.body[op].operands.len() - 1;
            if n < 2 {
                continue;
            }
            let mut run = Vec::new();
            self.rw.set_before(op);
            for k in 0..n {
                let v = self.rw.body[op].operands[k];
                let ty = self.rw.body[v].ty.clone();
                let copy = self.rw.create(OpData::build(Apple9Op::Or.name()).operands(&[v, v]), &[ty]);
                let copy = self.rw.body[copy].results[0];
                self.rw.modify(op, |b| b.set_operand(op, k, copy));
                run.push(copy);
            }
            groups.insert(run[0], run);
        }
        groups
    }

    /// Every instruction with its registers; `gprs` on the kernel.
    fn rewrite(&mut self, reg: &BTreeMap<ValueId, u32>, releases: &BTreeMap<OpId, u32>) -> Result<(), Error> {
        let top = reg.values().copied().max().map_or(0, |r| r + 1).max(APPLE9_WAIT_GPR + 1);
        for op in self.ops() {
            let Some(inst) = Apple9Op::of(&self.rw.body[op].name) else {
                return Err(Error(format!("{}: not an apple9 instruction", self.rw.body[op].name)));
            };
            let operands = self.rw.body[op].operands.clone();
            let results = self.rw.body[op].results.clone();
            let mut attrs: Vec<(&str, Attribute<'a>)> = Vec::new();
            let names = inst.sources();
            let at = |v: &ValueId| reg.get(v).copied().ok_or_else(|| Error(format!("{}: a value without a register", inst.name())));
            if matches!(inst, Apple9Op::Store | Apple9Op::Cmpxchg | Apple9Op::SharedAtomic) {
                let (data, index) = operands.split_at(operands.len() - 1);
                let first = at(&data[0])?;
                for (i, v) in data.iter().enumerate() {
                    if at(v)? != first + i as u32 {
                        return Err(Error("apple9.store: data not in consecutive registers".into()));
                    }
                }
                attrs.push(("data", A::from(first).into()));
                attrs.push(("index", A::from(at(&index[0])?).into()));
            } else {
                if operands.len() != names.len() {
                    return Err(Error(format!("{}: {} operands, {} sources", inst.name(), operands.len(), names.len())));
                }
                for (n, v) in names.iter().zip(&operands) {
                    attrs.push((n, A::from(at(v)?).into()));
                }
            }
            if let Some(r) = results.first() {
                let first = at(r)?;
                for (i, v) in results.iter().enumerate() {
                    if at(v)? != first + i as u32 {
                        return Err(Error(format!("{}: results not in consecutive registers", inst.name())));
                    }
                }
                attrs.push(("dst", A::from(first).into()));
            }
            if let Some(&m) = releases.get(&op).filter(|_| inst.releases()) {
                attrs.push(("release", A::from(m).into()));
            }
            self.rw.modify(op, |b| {
                for (n, v) in attrs {
                    b[op].set(n, v);
                }
                b.set_operands(op, Vec::new());
                b[op].results.clear();
            });
        }
        let k = self.kernel;
        self.rw.update::<Apple9Kernel>(k, |k| k.gprs = Some(top))
    }
}

/// `apple9-regalloc`.
#[pass("apple9-regalloc", on = "builtin.module")]
pub fn apple9_regalloc<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    for k in Kernels::all(body, op, Apple9Kernel::NAME) {
        let mut quiet = Quiet;
        let mut kernel = Alloc { rw: Rewriter::new(body, &mut quiet), kernel: k };
        let groups = kernel.prepare();
        let webs = kernel.webs();
        let scan = LinearScan { files: vec![GPRS], fixed: BTreeMap::new(), groups };
        let block = kernel.rw.body.top_block(k);
        let reg = scan.run_with(&Files, kernel.rw.body, block, &webs)?;
        let releases = kernel.releases();
        kernel.structure();
        kernel.rewrite(&reg, &releases)?;
    }
    Ok(())
}
