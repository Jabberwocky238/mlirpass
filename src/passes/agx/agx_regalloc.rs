//! ⭐ `agx-regalloc`: a kernel's virtual USC instructions ⇒ GPRs ([`LinearScan`] over 16-bit halves),
//! then `agx-wait`: the waits for the loads.
//!
//! A 32-bit value takes two halves aligned to two, a 64-bit one four aligned to four; GPRs start at r1 (r0l is the
//! control flow's nesting counter in Mesa's compiler). Uniforms (`agx.usc.input {uniform}`: the base, the
//! parameters) are where the USC Uniform word loads them. A store's data is copied into a run first; a load's
//! destination is kept apart from its sources. Then each operand becomes its encoding's dictionary, as Mesa writes
//! a register of that kind (tests/usc.mlir has them: `reg` the half, `size32`, `hint` 1, `sx` for the integer adders,
//! `zx` for an index, a memory operand's `mask`), and the kernel gets `gprs` (halves: USC Registers' count).

use alloc::collections::{BTreeMap, BTreeSet};
use alloc::format;
use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{Attribute, Error, Op};

use crate::{AddOperand, AgxKernel, AgxSlot as Slot, AgxType, AluOperand, CmpselOperand, Dalu64Operand, DaluOperand, Enc, FloatOperand, MembaseOperand, MemindexOperand, MemoryOperand, MulOperand, Usc, UscBuild, UscInput, UscKind as Kind, UscOp};
use crate::{Body, Groups, Heads, Kernels, LinearScan, OpId, Quiet, RegTarget, Rewriter, Updates, ValueId, pass};


/// The GPR halves a kernel may use: from r1 (r0l is the nesting counter) up.
const GPRS: core::ops::Range<u32> = 2..256;

/// The register files as the linear scan sees them: 0 the GPR halves, 1 the uniform halves.
struct Files;

impl RegTarget for Files {
    fn preset(&self, body: &Body<'_>, op: OpId) -> Result<Option<u32>, Error> {
        if body[op].name != UscInput::NAME {
            return Ok(None);
        }
        Ok(Some(body.head::<UscInput>(op)?.uniform as u32))
    }

    fn reuses_sources(&self, body: &Body<'_>, op: OpId) -> bool {
        Usc::op(&body[op].name) != Some(UscOp::Load)
    }

    fn file(&self, body: &Body<'_>, v: ValueId) -> Result<usize, Error> {
        match AgxType::try_from(&body[v].ty) {
            Ok(AgxType::R(_)) => Ok(0),
            Ok(AgxType::U(_)) => Ok(1),
            Err(_) => Err(Error(format!("{} is not a register", body[v].ty))),
        }
    }

    fn size(&self, body: &Body<'_>, v: ValueId) -> Result<(u32, u32), Error> {
        Ok(match AgxType::try_from(&body[v].ty) {
            Ok(AgxType::R("i64") | AgxType::U("i64")) => (4, 4),
            _ => (2, 2),
        })
    }
}

/// One kernel being allocated: every change to it through a [`Rewriter`].
pub(super) struct Alloc<'r, 'a> {
    pub(super) rw: Rewriter<'r, 'a>,
    pub(super) kernel: OpId,
}

impl<'a> Alloc<'_, 'a> {
    fn ops(&self) -> Vec<OpId> {
        self.rw.body.block_ops(self.rw.body.top_block(self.kernel))
    }

    /// A store's data copied into a run.
    fn prepare(&mut self) -> Result<Groups, Error> {
        let mut groups = Groups::new();
        let stores: Vec<OpId> = self.ops().into_iter().filter(|o| Usc::op(&self.rw.body[*o].name) == Some(UscOp::Store)).collect();
        for op in stores {
            let slots = Usc::slots(&self.rw.body[op])?;
            let data: Vec<usize> = slots.iter().enumerate().filter(|(_, s)| **s == Slot::S0).map(|(k, _)| k).collect();
            if data.len() < 2 {
                continue;
            }
            let mut run = Vec::new();
            self.rw.set_before(op);
            for k in data {
                let v = self.rw.body[op].operands[k];
                let ty = self.rw.body[v].ty.clone();
                let (mov, types) = UscBuild::new(UscOp::Mov, &[v], &[Slot::S0], vec![ty]).split();
                let m = self.rw.create(mov, &types);
                let copy = self.rw.body[m].results[0];
                self.rw.modify(op, |b| b.set_operand(op, k, copy));
                run.push(copy);
            }
            groups.insert(run[0], run);
        }
        Ok(groups)
    }

    /// An operand of `kind` in the run of `n` values from `v` (its first half `half`), as Mesa encodes it; a float
    /// source negated / absolute (`neg`, `abs`).
    fn operand(&self, kind: Enc, v: ValueId, half: u32, n: u32, (neg, abs): (bool, bool)) -> Result<Attribute<'a>, Error> {
        let uniform = matches!(AgxType::try_from(&self.rw.body[v].ty), Ok(AgxType::U(_)));
        let (neg, abs) = (u32::from(neg), u32::from(abs));
        Ok(match (uniform, kind) {
            (false, Enc::Dalu) => Usc::attr(&DaluOperand::Reg { reg: half, cache: 0, size32: 1 }),
            (false, Enc::Dalu64) => Usc::attr(&Dalu64Operand::Reg1 { reg: half, cache: 0 }),
            (false, Enc::Alu) => Usc::attr(&AluOperand::Reg { reg: half, hint: 1, size32: 1 }),
            (false, Enc::Float) => Usc::attr(&FloatOperand::Reg { reg: half, abs, neg, hint: 1, size32: 1 }),
            (false, Enc::Add) => Usc::attr(&AddOperand::Reg { reg: half, sx: 1, hint: 1, size64: 0, size32: 1 }),
            (false, Enc::Mul) => Usc::attr(&MulOperand::Reg { reg: half, sx: 1, hint: 1, size32: 1 }),
            (false, Enc::Cmpsel) => Usc::attr(&CmpselOperand::Reg { reg: half, hint: 1, size32: 1 }),
            (false, Enc::Memory) => Usc::attr(&MemoryOperand::Reg { reg: half, size32: 1, mask: (1 << n) - 1 }),
            (false, Enc::Memindex) => Usc::attr(&MemindexOperand::Reg { reg: half, zx: 1 }),
            (true, Enc::Alu) => Usc::attr(&AluOperand::Uniform { uniform: half, size32: 1 }),
            (true, Enc::Float) => Usc::attr(&FloatOperand::Uniform { uniform: half, abs, neg, size32: 1 }),
            (true, Enc::Add) => Usc::attr(&AddOperand::Uniform { uniform: half, sx: 1, size32: 1 }),
            (true, Enc::Mul) => Usc::attr(&MulOperand::Uniform { uniform: half, sx: 1, size32: 1 }),
            (true, Enc::Cmpsel) => Usc::attr(&CmpselOperand::Uniform { uniform: half, size32: 1 }),
            (true, Enc::Membase) => Usc::attr(&MembaseOperand::Uniform { uniform: half }),
            (u, k) => return Err(Error(format!("a {} register as a {} operand", if u { "uniform" } else { "GPR" }, k.name()))),
        })
    }

    /// Every instruction with its operands encoded; the inputs gone; `gprs` on the kernel.
    fn rewrite(&mut self, reg: &BTreeMap<ValueId, u32>) -> Result<(), Error> {
        let mut top = GPRS.start;
        for (v, r) in reg {
            if Files.file(self.rw.body, *v)? == 0 {
                top = top.max(r + Files.size(self.rw.body, *v)?.0);
            }
        }
        let mut inputs = Vec::new();
        for op in self.ops() {
            let Some(inst) = Usc::op(&self.rw.body[op].name) else {
                inputs.extend((self.rw.body[op].name == UscInput::NAME).then_some(op));
                continue;
            };
            let ins = inst.ins();
            // a slot's encoding
            let kind = |slot: Slot| -> Result<Enc, Error> {
                let f = match slot.index() {
                    None => ins.dests.first(),
                    Some(k) => ins.sources.get(k),
                };
                f.and_then(|f| match f.kind {
                    Kind::Operand(e) => Some(e),
                    _ => None,
                })
                .ok_or_else(|| Error(format!("{inst:?} has no {slot:?}")))
            };
            let slots = Usc::slots(&self.rw.body[op])?;
            let operands = self.rw.body[op].operands.clone();
            let mut attrs: Vec<(&str, Attribute<'a>)> = Vec::new();
            let mut k = 0;
            while k < operands.len() {
                let slot = *slots.get(k).ok_or_else(|| Error(format!("{inst:?}: operand {k} without a slot")))?;
                let n = slots[k..].iter().take_while(|s| **s == slot).count();
                let first = reg[&operands[k]];
                if (0..n).any(|i| reg[&operands[k + i]] != first + 2 * i as u32) {
                    return Err(Error(format!("{inst:?}: {slot:?} not in consecutive registers")));
                }
                // a float source's modifiers
                let has = |keys: [&str; 3]| slot.index().and_then(|i| keys.get(i)).is_some_and(|k| self.rw.body[op].get(k).is_some());
                attrs.push((slot.key(), self.operand(kind(slot)?, operands[k], first, n as u32, (has(Slot::NEG), has(Slot::ABS)))?));
                k += n;
            }
            let results = self.rw.body[op].results.clone();
            if let Some(r) = results.first() {
                attrs.push((Slot::D0.key(), self.operand(kind(Slot::D0)?, *r, reg[r], results.len() as u32, (false, false))?));
            }
            self.rw.modify(op, |b| {
                for (n, v) in attrs {
                    b[op].set(n, v);
                }
                for m in Slot::NEG.into_iter().chain(Slot::ABS) {
                    b[op].remove(m);
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
        self.rw.update::<AgxKernel>(k, |k| k.gprs = Some(top))
    }

    /// The GPR halves instruction `op` names: each operand's `reg` on, two halves a register (this backend's are all
    /// 32-bit), as many registers as a memory operand's mask has bits; none for a uniform or an immediate.
    fn halves(&self, op: OpId) -> Result<BTreeSet<u32>, Error> {
        let Some(inst) = Usc::op(&self.rw.body[op].name) else { return Ok(BTreeSet::new()) };
        let ins = inst.ins();
        let mut out = BTreeSet::new();
        let slots = ins.dests.iter().map(|f| (Slot::D0, f)).chain(ins.sources.iter().enumerate().filter_map(|(k, f)| Some((Slot::source(k)?, f))));
        for (slot, f) in slots {
            let (Some(a), Kind::Operand(e)) = (self.rw.body[op].get(slot.key()), f.kind) else { continue };
            if let (Some(reg), mask) = e.regs(a)? {
                out.extend(reg..reg + 2 * mask.map_or(1, u32::count_ones));
            }
        }
        Ok(out)
    }

    /// `agx-wait` on this kernel.
    pub(super) fn wait(&mut self) -> Result<(), Error> {
        let mut pending: BTreeSet<u32> = BTreeSet::new();
        for i in self.ops() {
            let touched = self.halves(i)?;
            if !pending.is_disjoint(&touched) {
                self.rw.set_before(i);
                let (wait, types) = UscBuild::new(UscOp::Wait, &[], &[], Vec::new()).split();
                self.rw.create(wait, &types);
                pending.clear();
            }
            if Usc::op(&self.rw.body[i].name) == Some(UscOp::Load) {
                // a load's destination is d0
                let d0 = self.rw.body[i].get(Slot::D0.key()).cloned();
                let enc = UscOp::Load.ins().dests.first().and_then(|f| match f.kind {
                    Kind::Operand(e) => Some(e),
                    _ => None,
                });
                if let (Some(a), Some(e)) = (d0, enc)
                    && let (Some(reg), mask) = e.regs(&a)?
                {
                    pending.extend(reg..reg + 2 * mask.map_or(1, u32::count_ones));
                }
            }
        }
        Ok(())
    }
}

/// `agx-regalloc`.
#[pass("agx-regalloc", on = "builtin.module")]
pub fn agx_regalloc<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    for k in Kernels::all(body, op, AgxKernel::NAME) {
        let mut quiet = Quiet;
        let mut kernel = Alloc { rw: Rewriter::new(body, &mut quiet), kernel: k };
        let groups = kernel.prepare()?;
        let scan = LinearScan { files: vec![GPRS, 0..512], fixed: BTreeMap::new(), groups };
        let block = kernel.rw.body.top_block(k);
        let reg = scan.run(&Files, kernel.rw.body, block)?;
        kernel.rewrite(&reg)?;
    }
    Ok(())
}
