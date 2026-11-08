//! ⭐ `apple9-regalloc`: a kernel's virtual Apple9 instructions ⇒ GPRs ([`LinearScan`] over the 32-bit GPRs r0 ..
//! r62; r63 is `apple9-wait`'s). A store of several dwords gets its data copied into a run first (`or` of a value
//! with itself); a load's destination is kept apart from its index. Then each instruction gets its registers in the
//! attributes [`Apple9Op::sources`] names (a store's `data` the run's first), `dst` its result's (a load's: the
//! first of its components), and the kernel `gprs`.

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
        Apple9Op::of(&body[op].name) != Some(Apple9Op::Load)
    }

    fn file(&self, body: &Body<'_>, v: ValueId) -> Result<usize, Error> {
        Apple9Type::try_from(&body[v].ty).map(|_| 0)
    }

    fn size(&self, _: &Body<'_>, _: ValueId) -> Result<(u32, u32), Error> {
        Ok((1, 1))
    }
}

/// One kernel being allocated.
struct Alloc<'r, 'a> {
    rw: Rewriter<'r, 'a>,
    kernel: OpId,
}

impl<'a> Alloc<'_, 'a> {
    fn ops(&self) -> Vec<OpId> {
        self.rw.body.block_ops(self.rw.body.top_block(self.kernel))
    }

    /// A store's data copied into a run.
    fn prepare(&mut self) -> Groups {
        let mut groups = Groups::new();
        for op in self.ops() {
            if Apple9Op::of(&self.rw.body[op].name) != Some(Apple9Op::Store) {
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
    fn rewrite(&mut self, reg: &BTreeMap<ValueId, u32>) -> Result<(), Error> {
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
            if inst == Apple9Op::Store {
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
        let scan = LinearScan { files: vec![GPRS], fixed: BTreeMap::new(), groups };
        let block = kernel.rw.body.top_block(k);
        let reg = scan.run(&Files, kernel.rw.body, block)?;
        kernel.rewrite(&reg)?;
    }
    Ok(())
}
