use alloc::collections::{BTreeMap, BTreeSet};
use alloc::format;
use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{Error, Op};

use crate::{Body, Groups, Heads, Kernels, LinearScan, OpId, Quiet, RegTarget, Rewriter, Updates, ValueId, pass};
use crate::{Rdna2Build as Build, Rdna2Flat as Flat, Rdna2Format as Format, Rdna2Input, Rdna2Isa as Isa, Rdna2Kernel, Rdna2Opcode as Opcode, Rdna2Operand as Operand, Rdna2Reg as Reg, Rdna2Salu as Salu, Rdna2Slot as Slot, Rdna2Type, Rdna2Valu as Valu};

const SGPRS: u32 = 106;

const VGPRS: u32 = 256;

const WAIT_VMCNT0: i64 = 0x3f70;

struct Files;

impl RegTarget for Files {
    fn preset(&self, body: &Body<'_>, op: OpId) -> Result<Option<u32>, Error> {
        if body[op].name != Rdna2Input::NAME {
            return Ok(None);
        }
        Ok(Some(body.head::<Rdna2Input>(op)?.reg as u32))
    }

    fn reuses_sources(&self, body: &Body<'_>, op: OpId) -> bool {
        !(body[op].name == Flat::NAME && Isa::read(body, op).ok().flatten().is_some_and(|i| i.global_load()))
    }

    fn file(&self, body: &Body<'_>, v: ValueId) -> Result<usize, Error> {
        match Rdna2Type::try_from(&body[v].ty) {
            Ok(Rdna2Type::S(_)) => Ok(0),
            Ok(Rdna2Type::V(_)) => Ok(1),
            Err(_) => Err(Error(format!("{} is not a register", body[v].ty))),
        }
    }

    fn size(&self, body: &Body<'_>, v: ValueId) -> Result<(u32, u32), Error> {
        Ok(match Rdna2Type::try_from(&body[v].ty) {
            Ok(Rdna2Type::S("i64")) => (2, 2),
            _ => (1, 1),
        })
    }
}

pub(super) struct Alloc<'r, 'a> {
    pub(super) rw: Rewriter<'r, 'a>,
    pub(super) kernel: OpId,
}

impl<'a> Alloc<'_, 'a> {
    fn ops(&self) -> Vec<OpId> {
        self.rw.body.block_ops(self.rw.body.top_block(self.kernel))
    }

    fn global(&self) -> Result<Vec<OpId>, Error> {
        let mut out = Vec::new();
        for op in self.ops() {
            if self.rw.body[op].name == Flat::NAME && Isa::read(self.rw.body, op)?.is_some_and(|f| f.op.format() == Format::Global) {
                out.push(op);
            }
        }
        Ok(out)
    }

    fn prepare(&mut self) -> Result<Groups, Error> {
        let mut groups = Groups::new();
        let global = self.global()?;
        if global.is_empty() {
            return Ok(groups);
        }
        let block = self.rw.body.top_block(self.kernel);
        self.rw.set_start(block);
        let (zero, types) = Build::new::<Salu>(Opcode::SMovB64, &[], &[], vec![Rdna2Type::S("i64").into()]).source(Slot::Src0, 0.into()).split();
        let base = self.rw.create(zero, &types);
        let base = self.rw.body[base].results[0];
        for op in global {
            let mut flat = self.rw.body.head::<Flat>(op)?;
            let mut slots = flat.slots.take().unwrap_or_default();
            let data: Vec<usize> = slots.iter().enumerate().filter(|(_, s)| **s == Slot::Data).map(|(k, _)| k).collect();
            if data.len() > 1 {
                let mut run = Vec::new();
                self.rw.set_before(op);
                for k in data {
                    let v = self.rw.body[op].operands[k];
                    let ty = self.rw.body[v].ty.clone();
                    let (copy, types) = Build::new::<Valu>(Opcode::VMovB32, &[v], &[Slot::Src0], vec![ty]).split();
                    let m = self.rw.create(copy, &types);
                    let copy = self.rw.body[m].results[0];
                    self.rw.modify(op, |b| b.set_operand(op, k, copy));
                    run.push(copy);
                }
                groups.insert(run[0], run);
            }
            let mut operands = self.rw.body[op].operands.clone();
            operands.push(base);
            slots.push(Slot::Saddr);
            self.rw.modify(op, |b| b.set_operands(op, operands));
            self.rw.update::<Flat>(op, |f| f.slots = Some(slots))?;
        }
        Ok(groups)
    }

    fn operand(&self, v: ValueId, reg: &BTreeMap<ValueId, u32>, n: u32) -> Result<Operand, Error> {
        let r = reg[&v];
        let n = n * Files.size(self.rw.body, v)?.0;
        Ok(match Files.file(self.rw.body, v)? {
            0 => Operand::sgpr(r, n),
            _ => Operand::vgpr(r, n),
        })
    }

    fn rewrite(&mut self, reg: &BTreeMap<ValueId, u32>) -> Result<(), Error> {
        let mut used = [0u32; 2];
        for (v, r) in reg {
            let f = Files.file(self.rw.body, *v)?;
            used[f] = used[f].max(r + Files.size(self.rw.body, *v)?.0);
        }
        let mut inputs = Vec::new();
        for op in self.ops() {
            let Some(inst) = Isa::read(self.rw.body, op)? else {
                inputs.extend((self.rw.body[op].name == Rdna2Input::NAME).then_some(op));
                continue;
            };
            let slots = &inst.slots;
            let operands = self.rw.body[op].operands.clone();
            let mut fields: Vec<(&str, Operand)> = Vec::new();
            let mut k = 0;
            while k < operands.len() {
                let slot = *slots.get(k).ok_or_else(|| Error(format!("{:?}: operand {k} without a slot", inst.op)))?;
                let n = slots[k..].iter().take_while(|s| **s == slot).count();
                let first = reg[&operands[k]];
                if (0..n).any(|i| reg[&operands[k + i]] != first + i as u32) {
                    return Err(Error(format!("{:?}: {slot:?} not in consecutive registers", inst.op)));
                }
                fields.push((slot.key(), self.operand(operands[k], reg, n as u32)?));
                k += n;
            }
            let results = self.rw.body[op].results.clone();
            if let Some(r) = results.first() {
                fields.push(("dst", self.operand(*r, reg, results.len() as u32)?));
            }
            self.rw.modify(op, |b| {
                for (key, o) in fields {
                    b[op].set(key, o.into());
                }
                b[op].remove("slots");
                b.set_operands(op, Vec::new());
                b[op].results.clear();
            });
        }
        for op in inputs {
            self.rw.modify(op, |b| b[op].results.clear());
            self.rw.erase_op(op);
        }
        let k = self.kernel;
        self.rw.update::<Rdna2Kernel>(k, |k| (k.sgprs, k.vgprs) = (Some(used[0]), Some(used[1].max(1))))
    }

    pub(super) fn waitcnt(&mut self) -> Result<(), Error> {
        let mut pending: BTreeSet<u32> = BTreeSet::new();
        for i in self.ops() {
            let Some(inst) = Isa::read(self.rw.body, i)? else { continue };
            if inst.fields().flat_map(|o| o.vgprs()).any(|r| pending.contains(&r)) {
                self.rw.set_before(i);
                let (wait, types) = Build::new::<Salu>(Opcode::SWaitcnt, &[], &[], Vec::new()).simm16(WAIT_VMCNT0).split();
                self.rw.create(wait, &types);
                pending.clear();
            }
            if inst.global_load() {
                pending.extend(inst.reg(Reg::Dst).iter().flat_map(Operand::vgprs));
            }
        }
        Ok(())
    }
}

#[pass("rdna2-regalloc", on = "builtin.module")]
pub fn rdna2_regalloc<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    for k in Kernels::all(body, op, Rdna2Kernel::NAME) {
        let mut quiet = Quiet;
        let mut kernel = Alloc { rw: Rewriter::new(body, &mut quiet), kernel: k };
        let groups = kernel.prepare()?;
        let scan = LinearScan { files: vec![0..SGPRS, 0..VGPRS], fixed: BTreeMap::new(), groups };
        let block = kernel.rw.body.top_block(k);
        let reg = scan.run(&Files, kernel.rw.body, block)?;
        kernel.rewrite(&reg)?;
    }
    Ok(())
}
