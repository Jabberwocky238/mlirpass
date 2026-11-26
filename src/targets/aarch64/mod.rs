//! AArch64 machine code from the llvm dialect, selected as LLVM's fast instruction selector does:
//! the patterns of one node and their instructions are `isel.gen.rs` (`scripts/isel.py`, from
//! LLVM's `AArch64` TableGen, its pseudo instructions expanded as `AArch64ExpandPseudo` does);
//! what `AArch64FastISel.cpp` writes by hand (memory, compares, branches, calls, multiplication,
//! remainders, 32-bit shifts) is here, and the encoding is `encode.rs`.
//!
//! Every value lives in a 64-bit register or frame slot, an integer narrower than 64 bits
//! zero-extended; `stencil` functions are a JIT's stencils (`StencilEmit`).

mod encode;
#[path = "isel.gen.rs"]
mod isel;

use alloc::collections::BTreeMap;
use alloc::format;
use alloc::string::{String, ToString};
use alloc::vec::Vec;

use mlirformat::Error;
use mlirformat::llvm::{FCmpPredicate, ICmpPredicate};

use super::machine::{Allocas, Callee, Constant, Interval, Pred, Template};
use crate::targets::{Fast, FastEmit, Isd, Kinds, Mvt};
use crate::{Body, BlockId, Emit, Hole, HoleKind, OpId, Stencil, StencilEmit, ValueId};
use encode::{A, Asm, Cond, Placed};
use isel::{Class, EXPAND, FAST, ImmPred, Opcode, Reg};

#[derive(Clone, Debug, PartialEq, Eq)]
pub struct AArch64Code {
    pub name: String,
    pub bytes: Vec<u8>,
    pub relocs: Vec<AArch64Reloc>,
}

/// Eight bytes at `offset` take `symbol`'s address.
#[derive(Clone, Debug, PartialEq, Eq)]
pub struct AArch64Reloc {
    pub offset: usize,
    pub symbol: String,
}

pub struct AArch64Emit;

impl Emit for AArch64Emit {
    type Output = Vec<AArch64Code>;

    fn emit(&self, body: &Body<'_>, op: OpId) -> Result<Vec<AArch64Code>, Error> {
        let mut out = Vec::new();
        Self::collect(body, op, &mut out)?;
        Ok(out)
    }
}

impl AArch64Emit {
    fn collect(body: &Body<'_>, op: OpId, out: &mut Vec<AArch64Code>) -> Result<(), Error> {
        if body[op].name == "llvm.func" {
            if let Some(&region) = body[op].regions.first()
                && !body[region].blocks.is_empty()
            {
                out.push(AArch64Code::of(body, op)?);
            }
            return Ok(());
        }
        for &region in body[op].regions.iter() {
            for &block in body[region].blocks.iter() {
                for child in body.block_ops(block) {
                    Self::collect(body, child, out)?;
                }
            }
        }
        Ok(())
    }

    /// Every instruction the selector emits, each encoded once with sample operands: the LLVM
    /// instruction a disassembler should read back (a codegen-only one's twin) and the bytes.
    pub fn encodings() -> Vec<(String, Vec<u8>)> {
        Opcode::ALL
            .iter()
            .filter(|op| op.desc().encoding.is_some())
            .map(|&op| {
                let mut asm = Asm::default();
                asm.inst(op, &op.sample());
                let name = Opcode::TWINS.iter().find(|(o, _)| *o == op).map_or(op.name(), |(_, t)| t);
                (name.to_string(), asm.bytes)
            })
            .collect()
    }
}

impl StencilEmit for AArch64Emit {
    fn stencils(&self, body: &Body<'_>, root: OpId) -> Result<Vec<Stencil>, Error> {
        let mut out = Vec::new();
        for (name, f) in Template::stencils(body, root) {
            let mut lower = Lower::new(body, f).map_err(|e| Error(format!("aarch64: stencil @{name}: {}", e.0)))?;
            lower.function(f).map_err(|e| Error(format!("aarch64: stencil @{name}: {}", e.0)))?;
            let holes = lower.stencil.map(|st| st.holes).unwrap_or_default();
            out.push(Stencil { name, code: lower.asm.bytes, holes });
        }
        Ok(out)
    }
}

impl AArch64Code {
    pub fn of(body: &Body<'_>, f: OpId) -> Result<AArch64Code, Error> {
        let name = body[f].get_str("sym_name").ok_or_else(|| Error("aarch64: a function without a name".into()))?.to_string();
        let mut lower = Lower::new(body, f).map_err(|e| Error(format!("aarch64: @{name}: {}", e.0)))?;
        lower.function(f).map_err(|e| Error(format!("aarch64: @{name}: {}", e.0)))?;
        Ok(AArch64Code { name, bytes: lower.asm.bytes, relocs: lower.relocs })
    }
}

impl ImmPred {
    fn holds(self, _: i64) -> bool {
        match self {}
    }
}

impl Class {
    fn members<'t>(self) -> &'t [Reg] {
        Class::MEMBERS[self as usize]
    }

    fn is_float(self) -> bool {
        matches!(self, Class::FPR32 | Class::FPR64)
    }

    /// The member of the class that is part of `unit`.
    fn of(self, unit: Reg) -> Reg {
        let unit = unit.unit();
        self.members().iter().copied().find(|r| r.unit() == unit).unwrap_or_else(|| panic!("{self:?} has no part of {unit:?}"))
    }

    fn float(t: Mvt) -> Class {
        if t == Mvt::F32 { Class::FPR32 } else { Class::FPR64 }
    }
}

impl Reg {
    fn is_fpr(self) -> bool {
        Class::FPR64.members().contains(&self.unit())
    }

    fn args<'t>(t: Mvt) -> &'t [Reg] {
        Reg::ARGS.iter().find(|(m, _)| *m == t).map_or(&[], |(_, r)| r)
    }

    fn rets<'t>(t: Mvt) -> &'t [Reg] {
        Reg::RETS.iter().find(|(m, _)| *m == t).map_or(&[], |(_, r)| r)
    }
}

impl Opcode {
    /// Sample operands: registers of each class (a tied pair the same), small immediates.
    fn sample(self) -> Vec<A> {
        let desc = self.desc();
        let mut out: Vec<A> = Vec::new();
        for (i, o) in desc.operands.iter().enumerate() {
            let tied = desc.tied.iter().find(|&&(a, _)| usize::from(a) == i).map(|&(_, b)| usize::from(b));
            out.push(match (tied, o.kind, o.class) {
                (Some(t), _, _) => out[t],
                (_, super::OperandKind::Reg, Some(c)) => A::R(c.members()[(i * SAMPLE_STRIDE + 1) % c.members().len()]),
                (_, super::OperandKind::PcRel, _) => A::Rel,
                _ => A::I(SAMPLE_IMM),
            });
        }
        out
    }
}

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
enum Loc {
    Slot(i32),
    Gpr(Reg),
    Fpr(Reg),
}

struct Pool;

impl Pool {
    /// Values not live across a call.
    const SCRATCH: [Reg; 6] = [Reg::X9, Reg::X10, Reg::X11, Reg::X12, Reg::X13, Reg::X14];
    /// Callee-saved, for values live across calls (a stencil's caller saved them).
    const SAVED: [Reg; 4] = [Reg::X19, Reg::X20, Reg::X21, Reg::X22];
    const FLOATS: [Reg; 8] = [Reg::D16, Reg::D17, Reg::D18, Reg::D19, Reg::D20, Reg::D21, Reg::D22, Reg::D23];
    /// What one op computes in (never allocated): the result and two more operands.
    const TEMPS: [Reg; 3] = [Reg::X16, Reg::X17, Reg::X15];
    const FTEMPS: [Reg; 3] = [Reg::D30, Reg::D31, Reg::D29];
    /// Addresses of frame slots out of a load's reach, and a stencil's slot offsets.
    const INDEX: Reg = Reg::X8;
    /// A stencil's context and frame registers.
    const CTX: Reg = Reg::X23;
    const FRAME: Reg = Reg::FP;
}

/// Sample operands: registers a few apart, an immediate every field holds.
const SAMPLE_STRIDE: usize = 3;
const SAMPLE_IMM: i64 = 1;

/// `ldur` / `stur` offsets: a signed nine-bit byte offset.
const UNSCALED: core::ops::RangeInclusive<i32> = -256..=255;
/// The largest frame step one `sub sp, sp, #imm` takes, a multiple of 16.
const FRAME_STEP: i32 = 4080;
/// Words from a literal load to its literal, and from the branch over it to what follows.
const LITERAL_AHEAD: i64 = 2;
const PAST_QUAD: i64 = 3;
const PAST_WORD: i64 = 2;
/// The `brk` immediate of `llvm.unreachable`.
const TRAP: i64 = 1;
/// `stp` / `ldp` of the frame record: 16 bytes, in units of 8.
const RECORD_WORDS: i64 = 2;

struct Lower<'b, 'a> {
    body: &'b Body<'a>,
    asm: Asm,
    slots: BTreeMap<ValueId, Loc>,
    saved: Vec<(Reg, i32)>,
    scratch: i32,
    frame: i32,
    blocks: BTreeMap<BlockId, usize>,
    fixups: Vec<(Placed, BlockId)>,
    relocs: Vec<AArch64Reloc>,
    stencil: Option<Stenciled>,
    /// Each `llvm.alloca`'s frame offset.
    allocas: BTreeMap<ValueId, i32>,
}

struct Stenciled {
    holes: Vec<Hole>,
    slots: BTreeMap<ValueId, String>,
    ends: Vec<Placed>,
}

impl<'b, 'a> Lower<'b, 'a> {
    fn new(body: &'b Body<'a>, f: OpId) -> Result<Self, Error> {
        let stencil = Template::slots(body, f).map(|slots| Stenciled { holes: Vec::new(), slots, ends: Vec::new() });
        let region = body[f].regions[0];
        let blocks: Vec<BlockId> = body[region].blocks.iter().copied().collect();
        let mut widest_copy = 0usize;
        for &block in &blocks {
            for op in body.block_ops(block) {
                if !body[op].regions.is_empty() {
                    return Err(Error(format!("{} has regions", body[op].name)));
                }
                widest_copy = widest_copy.max(body[op].operands.len());
            }
        }
        let mut intervals = Interval::of(body, &blocks, &BTreeMap::new())?;
        let mut fixed = BTreeMap::new();
        if let Some(st) = &stencil {
            let args = &body[blocks[0]].args;
            if args.len() != 2 {
                return Err(Error("a stencil takes the context and the frame".into()));
            }
            fixed.insert(args[0], Loc::Gpr(Pool::CTX));
            fixed.insert(args[1], Loc::Gpr(Pool::FRAME));
            intervals.retain(|iv| !st.slots.contains_key(&iv.value) && !fixed.contains_key(&iv.value));
        }
        let (mut slots, used) = Self::allocate(&intervals, stencil.is_some());
        slots.extend(fixed);
        let mut next = if stencil.is_some() { Template::SPILL_TOP } else { 0 };
        let mut saved = Vec::new();
        for r in used {
            next -= 8;
            saved.push((r, next));
        }
        for iv in &intervals {
            if let alloc::collections::btree_map::Entry::Vacant(e) = slots.entry(iv.value) {
                next -= 8;
                e.insert(Loc::Slot(next));
            }
        }
        if stencil.is_some() && next < Template::SPILL_TOP - 8 * Template::SPILL_WORDS {
            return Err(Error("a stencil spills more than its words".into()));
        }
        let mut allocas = BTreeMap::new();
        for (v, size, align) in Allocas::of(body, &blocks)? {
            if stencil.is_some() {
                return Err(Error("a stencil allocates no stack".into()));
            }
            let size = i32::try_from(size).map_err(|_| Error("an llvm.alloca larger than a frame".into()))?;
            let align = i32::try_from(align).unwrap_or(1);
            next = (next - size) & !(align - 1);
            allocas.insert(v, next);
        }
        let scratch = next - 8 * i32::try_from(widest_copy).unwrap_or(0);
        let frame = (-scratch + 15) & !15;
        Ok(Lower { body, asm: Asm::default(), slots, saved, scratch, frame, blocks: BTreeMap::new(), fixups: Vec::new(), relocs: Vec::new(), stencil, allocas })
    }

    fn allocate(intervals: &[Interval], stencil: bool) -> (BTreeMap<ValueId, Loc>, Vec<Reg>) {
        let mut locs = BTreeMap::new();
        let mut active: Vec<(u32, Loc)> = Vec::new();
        let mut used: Vec<Reg> = Vec::new();
        for iv in intervals {
            active.retain(|&(hi, _)| hi >= iv.lo);
            let busy = |l: Loc| active.iter().any(|&(_, a)| a == l);
            let pick = if iv.float {
                if iv.across_call { None } else { Pool::FLOATS.iter().map(|&x| Loc::Fpr(x)).find(|&l| !busy(l)) }
            } else {
                let scratch = (!iv.across_call).then_some(Pool::SCRATCH.iter()).into_iter().flatten();
                scratch.chain(Pool::SAVED.iter()).map(|&r| Loc::Gpr(r)).find(|&l| !busy(l))
            };
            if let Some(l) = pick {
                if let Loc::Gpr(r) = l
                    && !stencil
                    && Pool::SAVED.contains(&r)
                    && !used.contains(&r)
                {
                    used.push(r);
                }
                locs.insert(iv.value, l);
                active.push((iv.hi, l));
            }
        }
        (locs, used)
    }

    fn inst(&mut self, op: Opcode, ops: &[A]) -> Placed {
        self.asm.inst(op, ops)
    }

    fn slot(&self, v: ValueId) -> Result<Loc, Error> {
        self.slots.get(&v).copied().ok_or_else(|| Error("a value defined outside the function".into()))
    }

    fn mvt(&self, v: ValueId) -> Result<Mvt, Error> {
        Mvt::try_from(&self.body[v].ty)
    }

    fn int_bits(&self, v: ValueId) -> Result<u32, Error> {
        match &self.body[v].ty {
            mlirformat::Type::Integer { width, .. } => Ok(*width),
            _ => Ok(64),
        }
    }

    /// `[fp + d]` as an unscaled base and offset (`x8` holds the address past their reach).
    fn frame_at(&mut self, d: i32) -> (Reg, i64) {
        if UNSCALED.contains(&d) {
            return (Pool::FRAME, d.into());
        }
        self.materialize(Pool::INDEX, i64::from(d).cast_unsigned());
        self.inst(Opcode::ADDXrs, &[A::R(Pool::INDEX), A::R(Pool::FRAME), A::R(Pool::INDEX), A::I(0)]);
        (Pool::INDEX, 0)
    }

    fn load_slot(&mut self, dst: Reg, t: Mvt, d: i32) {
        let (base, off) = self.frame_at(d);
        let op = match (dst.is_fpr(), t) {
            (true, Mvt::F32) => Opcode::LDURSi,
            (true, _) => Opcode::LDURDi,
            (false, _) => Opcode::LDURXi,
        };
        let dst = if dst.is_fpr() { Class::float(t).of(dst) } else { dst.unit() };
        self.inst(op, &[A::R(dst), A::R(base), A::I(off)]);
    }

    fn store_slot(&mut self, src: Reg, t: Mvt, d: i32) {
        let (base, off) = self.frame_at(d);
        let op = match (src.is_fpr(), t) {
            (true, Mvt::F32) => Opcode::STURSi,
            (true, _) => Opcode::STURDi,
            (false, _) => Opcode::STURXi,
        };
        let src = if src.is_fpr() { Class::float(t).of(src) } else { src.unit() };
        self.inst(op, &[A::R(src), A::R(base), A::I(off)]);
    }

    /// `v` in the register of `class` part of `temp`, or of the register it lives in.
    fn read(&mut self, v: ValueId, temp: Reg, class: Class) -> Result<Reg, Error> {
        let float = class.is_float();
        let t = self.mvt(v)?;
        Ok(match self.slot(v)? {
            Loc::Gpr(u) if !float => class.of(u),
            Loc::Fpr(x) if float => class.of(x),
            Loc::Gpr(u) => {
                self.copy(temp, u);
                class.of(temp)
            }
            Loc::Fpr(x) => {
                self.copy(temp, x);
                class.of(temp)
            }
            Loc::Slot(d) => {
                self.load_slot(temp, if float { t } else { Mvt::I64 }, d);
                class.of(temp)
            }
        })
    }

    /// `v` into exactly `unit`.
    fn read_into(&mut self, v: ValueId, unit: Reg) -> Result<(), Error> {
        let t = self.mvt(v)?;
        let float = t.is_float();
        let class = if float { Class::FPR64 } else { Class::GPR64 };
        let temp = match (float, unit.is_fpr()) {
            (a, b) if a == b => unit,
            (true, _) => Pool::FTEMPS[1],
            (false, _) => Pool::TEMPS[2],
        };
        let r = self.read(v, temp, class)?;
        self.copy(unit, r);
        Ok(())
    }

    fn copy(&mut self, dst: Reg, src: Reg) {
        let (d, s) = (dst.unit(), src.unit());
        if d == s {
            return;
        }
        match (d.is_fpr(), s.is_fpr()) {
            (true, true) => self.inst(Opcode::FMOVDr, &[A::R(d), A::R(s)]),
            (true, false) => self.inst(Opcode::FMOVXDr, &[A::R(d), A::R(s)]),
            (false, true) => self.inst(Opcode::FMOVDXr, &[A::R(d), A::R(s)]),
            (false, false) if d == Reg::SP || s == Reg::SP => self.inst(Opcode::ADDXri, &[A::R(d), A::R(s), A::I(0)]),
            (false, false) => self.inst(Opcode::ORRXrs, &[A::R(d), A::R(Reg::XZR), A::R(s), A::I(0)]),
        };
    }

    /// The result `v` from `src` (an integer zero-extended past its width first).
    fn write(&mut self, v: ValueId, src: Reg) -> Result<(), Error> {
        let t = self.mvt(v)?;
        let src = if t.is_float() { src } else { self.zext(src, self.int_bits(v)?) };
        match self.slot(v)? {
            Loc::Slot(d) => self.store_slot(src, t, d),
            Loc::Gpr(u) | Loc::Fpr(u) => self.copy(u, src),
        }
        Ok(())
    }

    /// `r`'s bits past `bits` cleared, in `r`'s 64-bit register (`ubfm`, `mov w`).
    fn zext(&mut self, r: Reg, bits: u32) -> Reg {
        let u = r.unit();
        match bits {
            64.. => {}
            32 => {
                let w = Class::GPR32.of(u);
                self.inst(Opcode::ORRWrs, &[A::R(w), A::R(Reg::WZR), A::R(w), A::I(0)]);
            }
            n => {
                self.inst(Opcode::UBFMXri, &[A::R(u), A::R(u), A::I(0), A::I(i64::from(n - 1))]);
            }
        }
        u
    }

    /// `r` sign-extended from `bits` in place.
    fn sext(&mut self, r: Reg, bits: u32) {
        if bits < 64 {
            let u = r.unit();
            self.inst(Opcode::SBFMXri, &[A::R(u), A::R(u), A::I(0), A::I(i64::from(bits - 1))]);
        }
    }

    /// `expandMOVImm`, its plainest form: `movz` the lowest non-zero chunk, `movk` the rest.
    fn materialize(&mut self, dst: Reg, bits: u64) {
        let d = dst.unit();
        let chunks: Vec<(i64, i64)> = (0..4).map(|i| (((bits >> (16 * i)) & 0xffff) as i64, 16 * i)).filter(|&(c, _)| c != 0).collect();
        if chunks.is_empty() {
            self.inst(Opcode::MOVZXi, &[A::R(d), A::I(0), A::I(0)]);
            return;
        }
        for (n, &(c, shift)) in chunks.iter().enumerate() {
            if n == 0 {
                self.inst(Opcode::MOVZXi, &[A::R(d), A::I(c), A::I(shift)]);
            } else {
                self.inst(Opcode::MOVKXi, &[A::R(d), A::R(d), A::I(c), A::I(shift)]);
            }
        }
    }

    /// A literal eight bytes in the code (`ldr d, #8; b #12; .quad`): where they are.
    fn literal64(&mut self, dst: Reg) -> usize {
        self.inst(Opcode::LDRXl, &[A::R(dst.unit()), A::I(LITERAL_AHEAD)]);
        self.inst(Opcode::B, &[A::I(PAST_QUAD)]);
        let at = self.asm.here();
        self.asm.bytes.extend_from_slice(&[0; 8]);
        at
    }

    /// A stencil frame slot's offset into `x8` (`ldrsw x8, #8; b #8; .word`), its hole named.
    fn frame_index(&mut self, name: String) {
        self.inst(Opcode::LDRSWl, &[A::R(Pool::INDEX), A::I(LITERAL_AHEAD)]);
        self.inst(Opcode::B, &[A::I(PAST_WORD)]);
        let at = self.asm.here();
        self.asm.word(0);
        self.hole(at, HoleKind::Disp32, name);
    }

    fn hole(&mut self, at: usize, kind: HoleKind, name: String) {
        if let Some(st) = self.stencil.as_mut() {
            st.holes.push(Hole { at, kind, name });
        }
    }

    fn frame_slot(&self, v: ValueId) -> Option<String> {
        self.stencil.as_ref().and_then(|st| st.slots.get(&v).cloned())
    }

    fn operand(&self, op: OpId, i: usize) -> Result<ValueId, Error> {
        self.body[op].operands.get(i).copied().ok_or_else(|| Error(format!("{} needs operand {i}", self.body[op].name)))
    }

    fn result(&self, op: OpId) -> Result<ValueId, Error> {
        self.body[op].results.first().copied().ok_or_else(|| Error(format!("{} has no result", self.body[op].name)))
    }

    fn function(&mut self, f: OpId) -> Result<(), Error> {
        let body = self.body;
        let region = body[f].regions[0];
        let blocks: Vec<BlockId> = body[region].blocks.iter().copied().collect();
        if self.stencil.is_none() {
            self.prologue(&blocks)?;
        }
        for &block in &blocks {
            self.blocks.insert(block, self.asm.here());
            for op in body.block_ops(block) {
                self.op(op)?;
            }
        }
        for (p, block) in core::mem::take(&mut self.fixups) {
            let target = self.blocks[&block];
            self.asm.patch(p, target);
        }
        if let Some(st) = self.stencil.as_mut() {
            let mut ends = core::mem::take(&mut st.ends);
            if let Some(last) = ends.iter().position(|p| p.at + 4 == self.asm.here()) {
                let p = ends.swap_remove(last);
                self.asm.bytes.truncate(p.at);
            }
            let end = self.asm.here();
            for p in ends {
                self.asm.patch(p, end);
            }
        }
        Ok(())
    }

    fn prologue(&mut self, blocks: &[BlockId]) -> Result<(), Error> {
        self.inst(Opcode::STPXpre, &[A::R(Reg::SP), A::R(Pool::FRAME), A::R(Reg::LR), A::R(Reg::SP), A::I(-RECORD_WORDS)]);
        self.copy(Pool::FRAME, Reg::SP);
        let mut left = self.frame;
        while left > 0 {
            let step = left.min(FRAME_STEP);
            self.inst(Opcode::SUBXri, &[A::R(Reg::SP), A::R(Reg::SP), A::I(step.into())]);
            left -= step;
        }
        for (r, at) in self.saved.clone() {
            self.store_slot(r, Mvt::I64, at);
        }
        let (mut ints, mut floats) = (0usize, 0usize);
        for &arg in self.body[blocks[0]].args.iter() {
            let t = self.mvt(arg)?;
            let (n, list) = if t.is_float() { (&mut floats, Reg::args(Mvt::F64)) } else { (&mut ints, Reg::args(Mvt::I64)) };
            let r = *list.get(*n).ok_or_else(|| Error(format!("more than {} parameters of type {t:?}", list.len())))?;
            *n += 1;
            self.write(arg, r)?;
        }
        Ok(())
    }

    fn epilogue(&mut self) {
        for (r, at) in self.saved.clone() {
            self.load_slot(r, Mvt::I64, at);
        }
        self.copy(Reg::SP, Pool::FRAME);
        self.inst(Opcode::LDPXpost, &[A::R(Reg::SP), A::R(Pool::FRAME), A::R(Reg::LR), A::R(Reg::SP), A::I(RECORD_WORDS)]);
        self.inst(Opcode::RET, &[A::R(Reg::LR)]);
    }

    fn op(&mut self, op: OpId) -> Result<(), Error> {
        let body = self.body;
        if let Some(&r) = body[op].results.first()
            && self.frame_slot(r).is_some()
        {
            return Ok(());
        }
        let name: &str = &body[op].name;
        if let Some(node) = Isd::of(body, op)
            && self.fast(op, node)?
        {
            return Ok(());
        }
        match name {
            "llvm.mlir.constant" => self.constant(op),
            "llvm.mlir.zero" | "llvm.mlir.undef" | "llvm.mlir.poison" => {
                let r = self.result(op)?;
                self.materialize(Pool::TEMPS[0], 0);
                self.write_bits(r, Pool::TEMPS[0])
            }
            "llvm.add" | "llvm.sub" | "llvm.and" | "llvm.or" | "llvm.xor" | "llvm.mul" | "llvm.shl" | "llvm.lshr" | "llvm.ashr" | "llvm.sdiv" | "llvm.udiv" | "llvm.srem" | "llvm.urem" => self.int(op, name),
            "llvm.icmp" => self.icmp(op),
            "llvm.fcmp" => self.fcmp(op),
            "llvm.select" => self.select(op),
            "llvm.zext" | "llvm.sext" | "llvm.trunc" | "llvm.ptrtoint" | "llvm.inttoptr" | "llvm.bitcast" => self.int_cast(op, name == "llvm.sext"),
            "llvm.sitofp" | "llvm.uitofp" => self.int_to_float(op, name == "llvm.sitofp"),
            "llvm.fptosi" | "llvm.fptoui" => self.float_to_int(op, name == "llvm.fptosi"),
            "llvm.load" => self.load(op),
            "llvm.store" => self.store(op),
            "llvm.getelementptr" => self.gep(op),
            "llvm.alloca" => self.alloca(op),
            "llvm.call" => self.call(op),
            "llvm.intr.stacksave" => {
                let r = self.result(op)?;
                self.copy(Pool::TEMPS[0], Reg::SP);
                self.write(r, Pool::TEMPS[0])
            }
            "llvm.br" => self.branch(op),
            "llvm.cond_br" => self.cond_branch(op),
            "llvm.return" => self.ret(op),
            "llvm.unreachable" => {
                if self.stencil.is_none() {
                    self.inst(Opcode::BRK, &[A::I(TRAP)]);
                }
                Ok(())
            }
            other => Err(Error(format!("{other} is not supported"))),
        }
    }

    /// Nodes that read the sign bit: an `i1` or `i7` is not the `i8` it is selected as.
    fn signed(node: Isd) -> bool {
        matches!(node, Isd::SignExtend | Isd::Sra | Isd::Sdiv | Isd::SintToFp)
    }

    fn exact(&self, v: ValueId) -> Result<bool, Error> {
        let t = self.mvt(v)?;
        Ok(t.is_float() || self.int_bits(v)? == t.bits())
    }

    /// A node a pattern of the fast selector takes: `false` if none does.
    fn fast(&mut self, op: OpId, node: Isd) -> Result<bool, Error> {
        let args: Vec<ValueId> = self.body[op].operands.iter().copied().collect();
        let Some(&first) = args.first() else { return Ok(false) };
        let r = self.result(op)?;
        let (vt, ret) = (self.mvt(first)?.legal(), self.mvt(r)?.legal());
        if Self::signed(node) && (!self.exact(first)? || !self.exact(r)?) {
            return Ok(false);
        }
        let kinds = match args.len() {
            1 => Kinds::R,
            2 => Kinds::Rr,
            _ => Kinds::Rrr,
        };
        let Some(f) = Fast::find(FAST, node, vt, ret, kinds, None, ImmPred::holds) else { return Ok(false) };
        let (opcode, class) = match f.emit {
            FastEmit::Inst(o, c) => (o, c),
            FastEmit::Extract(_) => {
                self.read_into(first, Pool::TEMPS[0])?;
                self.write(r, Pool::TEMPS[0])?;
                return Ok(true);
            }
        };
        let (opcode, extra) = match EXPAND.iter().find(|(p, _)| *p == opcode) {
            Some(&(_, real)) => (real, true),
            None => (opcode, false),
        };
        if opcode.desc().encoding.is_none() {
            return Ok(false);
        }
        let desc = opcode.desc();
        let dst_unit = if class.is_float() { Pool::FTEMPS[0] } else { Pool::TEMPS[0] };
        let mut temps = Pool::TEMPS.iter().chain(&Pool::FTEMPS).copied().filter(|t| *t != dst_unit).collect::<Vec<_>>();
        let mut ops: Vec<A> = Vec::new();
        let outs = usize::from(desc.outs);
        if outs == 1 {
            ops.push(A::R(class.of(dst_unit)));
        }
        for (n, &a) in f.args.iter().enumerate() {
            let o = desc.operands[outs + n];
            let c = o.class.unwrap_or(class);
            let pos = temps.iter().position(|t| t.is_fpr() == c.is_float()).ok_or_else(|| Error("out of temporaries".into()))?;
            let t = temps.remove(pos);
            let reg = self.read(args[usize::from(a)], t, c)?;
            ops.push(A::R(reg));
        }
        if extra {
            ops.push(A::I(0));
        }
        self.inst(opcode, &ops);
        self.write(r, class.of(dst_unit))?;
        Ok(true)
    }

    fn constant(&mut self, op: OpId) -> Result<(), Error> {
        let r = self.result(op)?;
        let t = self.mvt(r)?;
        let bits = Constant::bits(self.body, op, t)?;
        self.materialize(Pool::TEMPS[0], bits);
        if t.is_float() {
            self.copy(Pool::FTEMPS[0], Pool::TEMPS[0]);
            self.write(r, Pool::FTEMPS[0])
        } else {
            self.write_bits(r, Pool::TEMPS[0])
        }
    }

    /// An integer result already zero-extended in `src`'s 64-bit register.
    fn write_bits(&mut self, v: ValueId, src: Reg) -> Result<(), Error> {
        match self.slot(v)? {
            Loc::Slot(d) => self.store_slot(src, Mvt::I64, d),
            Loc::Gpr(u) | Loc::Fpr(u) => self.copy(u, src),
        }
        Ok(())
    }

    /// Integer arithmetic the patterns leave: 32- and 64-bit forms on operands sign-extended
    /// first where the sign matters, `madd` for products, `msub` for remainders.
    fn int(&mut self, op: OpId, name: &str) -> Result<(), Error> {
        let r = self.result(op)?;
        let (a, b) = (self.operand(op, 0)?, self.operand(op, 1)?);
        let bits = self.int_bits(r)?;
        let wide = bits > 32;
        let (d, x, y) = (Pool::TEMPS[0], Pool::TEMPS[1], Pool::TEMPS[2]);
        self.read_into(a, x)?;
        self.read_into(b, y)?;
        let signed = matches!(name, "llvm.ashr" | "llvm.sdiv" | "llvm.srem");
        if signed && bits != 32 && bits != 64 {
            self.sext(x, bits);
            if name != "llvm.ashr" {
                self.sext(y, bits);
            }
        }
        let c = if wide { Class::GPR64 } else { Class::GPR32 };
        let (rd, rx, ry) = (c.of(d), c.of(x), c.of(y));
        let zr = if c == Class::GPR64 { Reg::XZR } else { Reg::WZR };
        let x64 = c == Class::GPR64;
        let pick = |w: Opcode, xx: Opcode| if x64 { xx } else { w };
        match name {
            "llvm.add" => self.inst(pick(Opcode::ADDWrs, Opcode::ADDXrs), &[A::R(rd), A::R(rx), A::R(ry), A::I(0)]),
            "llvm.sub" => self.inst(pick(Opcode::SUBWrs, Opcode::SUBXrs), &[A::R(rd), A::R(rx), A::R(ry), A::I(0)]),
            "llvm.and" => self.inst(pick(Opcode::ANDWrs, Opcode::ANDXrs), &[A::R(rd), A::R(rx), A::R(ry), A::I(0)]),
            "llvm.or" => self.inst(pick(Opcode::ORRWrs, Opcode::ORRXrs), &[A::R(rd), A::R(rx), A::R(ry), A::I(0)]),
            "llvm.xor" => self.inst(pick(Opcode::EORWrs, Opcode::EORXrs), &[A::R(rd), A::R(rx), A::R(ry), A::I(0)]),
            "llvm.mul" => self.inst(pick(Opcode::MADDWrrr, Opcode::MADDXrrr), &[A::R(rd), A::R(rx), A::R(ry), A::R(zr)]),
            "llvm.shl" => self.inst(pick(Opcode::LSLVWr, Opcode::LSLVXr), &[A::R(rd), A::R(rx), A::R(ry)]),
            "llvm.lshr" => self.inst(pick(Opcode::LSRVWr, Opcode::LSRVXr), &[A::R(rd), A::R(rx), A::R(ry)]),
            "llvm.ashr" => self.inst(pick(Opcode::ASRVWr, Opcode::ASRVXr), &[A::R(rd), A::R(rx), A::R(ry)]),
            "llvm.sdiv" => self.inst(pick(Opcode::SDIVWr, Opcode::SDIVXr), &[A::R(rd), A::R(rx), A::R(ry)]),
            "llvm.udiv" => self.inst(pick(Opcode::UDIVWr, Opcode::UDIVXr), &[A::R(rd), A::R(rx), A::R(ry)]),
            "llvm.srem" | "llvm.urem" => {
                let div = if name == "llvm.srem" { pick(Opcode::SDIVWr, Opcode::SDIVXr) } else { pick(Opcode::UDIVWr, Opcode::UDIVXr) };
                self.inst(div, &[A::R(rd), A::R(rx), A::R(ry)]);
                self.inst(pick(Opcode::MSUBWrrr, Opcode::MSUBXrrr), &[A::R(rd), A::R(rd), A::R(ry), A::R(rx)])
            }
            other => return Err(Error(format!("{other} is not supported"))),
        };
        self.write(r, d)
    }

    fn icmp_cond(p: ICmpPredicate) -> Cond {
        match p {
            ICmpPredicate::Eq => Cond::Eq,
            ICmpPredicate::Ne => Cond::Ne,
            ICmpPredicate::Slt => Cond::Lt,
            ICmpPredicate::Sle => Cond::Le,
            ICmpPredicate::Sgt => Cond::Gt,
            ICmpPredicate::Sge => Cond::Ge,
            ICmpPredicate::Ult => Cond::Lo,
            ICmpPredicate::Ule => Cond::Ls,
            ICmpPredicate::Ugt => Cond::Hi,
            ICmpPredicate::Uge => Cond::Hs,
        }
    }

    /// `cset`: `csinc d, wzr, wzr, !cond`.
    fn cset(&mut self, d: Reg, c: Cond) {
        let w = Class::GPR32.of(d);
        self.inst(Opcode::CSINCWr, &[A::R(w), A::R(Reg::WZR), A::R(Reg::WZR), A::I(c.invert() as i64)]);
    }

    /// `AArch64FastISel::emitCmp`: 64-bit `subs` on operands sign-extended for a signed compare.
    fn icmp(&mut self, op: OpId) -> Result<(), Error> {
        let r = self.result(op)?;
        let p = Pred::of::<ICmpPredicate>(self.body, op)?;
        let (a, b) = (self.operand(op, 0)?, self.operand(op, 1)?);
        let bits = self.int_bits(a)?;
        let (x, y) = (Pool::TEMPS[1], Pool::TEMPS[2]);
        self.read_into(a, x)?;
        self.read_into(b, y)?;
        if matches!(p, ICmpPredicate::Slt | ICmpPredicate::Sle | ICmpPredicate::Sgt | ICmpPredicate::Sge) {
            self.sext(x, bits);
            self.sext(y, bits);
        }
        self.inst(Opcode::SUBSXrs, &[A::R(Reg::XZR), A::R(x), A::R(y), A::I(0)]);
        self.cset(Pool::TEMPS[0], Self::icmp_cond(p));
        self.write(r, Pool::TEMPS[0])
    }

    /// `changeFCMPPredToAArch64CC`: one condition, or two or-ed.
    fn fcmp(&mut self, op: OpId) -> Result<(), Error> {
        let r = self.result(op)?;
        let pred = Pred::of::<FCmpPredicate>(self.body, op)?;
        let (one, two) = match pred {
            FCmpPredicate::False | FCmpPredicate::True => {
                self.materialize(Pool::TEMPS[0], u64::from(pred == FCmpPredicate::True));
                return self.write_bits(r, Pool::TEMPS[0]);
            }
            FCmpPredicate::Oeq => (Cond::Eq, None),
            FCmpPredicate::Ogt => (Cond::Gt, None),
            FCmpPredicate::Oge => (Cond::Ge, None),
            FCmpPredicate::Olt => (Cond::Mi, None),
            FCmpPredicate::Ole => (Cond::Ls, None),
            FCmpPredicate::One => (Cond::Mi, Some(Cond::Gt)),
            FCmpPredicate::Ord => (Cond::Vc, None),
            FCmpPredicate::Uno => (Cond::Vs, None),
            FCmpPredicate::Ueq => (Cond::Eq, Some(Cond::Vs)),
            FCmpPredicate::Ugt => (Cond::Hi, None),
            FCmpPredicate::Uge => (Cond::Pl, None),
            FCmpPredicate::Ult => (Cond::Lt, None),
            FCmpPredicate::Ule => (Cond::Le, None),
            FCmpPredicate::Une => (Cond::Ne, None),
        };
        let (a, b) = (self.operand(op, 0)?, self.operand(op, 1)?);
        let t = self.mvt(a)?;
        let c = Class::float(t);
        let x = self.read(a, Pool::FTEMPS[0], c)?;
        let y = self.read(b, Pool::FTEMPS[1], c)?;
        self.inst(if t == Mvt::F32 { Opcode::FCMPSrr } else { Opcode::FCMPDrr }, &[A::R(x), A::R(y)]);
        self.cset(Pool::TEMPS[0], one);
        if let Some(two) = two {
            self.cset(Pool::TEMPS[1], two);
            let (d, s) = (Class::GPR32.of(Pool::TEMPS[0]), Class::GPR32.of(Pool::TEMPS[1]));
            self.inst(Opcode::ORRWrs, &[A::R(d), A::R(d), A::R(s), A::I(0)]);
        }
        self.write(r, Pool::TEMPS[0])
    }

    /// `cmp w, #0` and `csel` / `fcsel` on `ne`.
    fn select(&mut self, op: OpId) -> Result<(), Error> {
        let r = self.result(op)?;
        let (c, t, f) = (self.operand(op, 0)?, self.operand(op, 1)?, self.operand(op, 2)?);
        let ty = self.mvt(r)?;
        let cond = self.read(c, Pool::TEMPS[2], Class::GPR32)?;
        self.inst(Opcode::SUBSWri, &[A::R(Reg::WZR), A::R(cond), A::I(0)]);
        if ty.is_float() {
            let class = Class::float(ty);
            let x = self.read(t, Pool::FTEMPS[0], class)?;
            let y = self.read(f, Pool::FTEMPS[1], class)?;
            let d = class.of(Pool::FTEMPS[0]);
            self.inst(if ty == Mvt::F32 { Opcode::FCSELSrrr } else { Opcode::FCSELDrrr }, &[A::R(d), A::R(x), A::R(y), A::I(Cond::Ne as i64)]);
            return self.write(r, d);
        }
        let x = self.read(t, Pool::TEMPS[0], Class::GPR64)?;
        let y = self.read(f, Pool::TEMPS[1], Class::GPR64)?;
        let d = Pool::TEMPS[0];
        self.inst(Opcode::CSELXr, &[A::R(d), A::R(x), A::R(y), A::I(Cond::Ne as i64)]);
        self.write(r, d)
    }

    fn int_cast(&mut self, op: OpId, signed: bool) -> Result<(), Error> {
        let r = self.result(op)?;
        let a = self.operand(op, 0)?;
        let (from, to) = (self.mvt(a)?, self.mvt(r)?);
        if from.is_float() != to.is_float() {
            return Err(Error(format!("{} from {from:?} to {to:?} is not supported", self.body[op].name)));
        }
        let unit = if from.is_float() { Pool::FTEMPS[0] } else { Pool::TEMPS[0] };
        self.read_into(a, unit)?;
        if signed {
            self.sext(unit, self.int_bits(a)?);
        }
        self.write(r, unit)
    }

    /// Through the 64-bit conversions, the integer extended to 64 bits first.
    fn int_to_float(&mut self, op: OpId, signed: bool) -> Result<(), Error> {
        let r = self.result(op)?;
        let a = self.operand(op, 0)?;
        let to = self.mvt(r)?;
        let x = Pool::TEMPS[0];
        self.read_into(a, x)?;
        if signed {
            self.sext(x, self.int_bits(a)?);
        }
        let opcode = match (signed, to) {
            (true, Mvt::F32) => Opcode::SCVTFUXSri,
            (true, _) => Opcode::SCVTFUXDri,
            (false, Mvt::F32) => Opcode::UCVTFUXSri,
            (false, _) => Opcode::UCVTFUXDri,
        };
        let d = Class::float(to).of(Pool::FTEMPS[0]);
        self.inst(opcode, &[A::R(d), A::R(x)]);
        self.write(r, d)
    }

    /// Through the 64-bit conversions.
    fn float_to_int(&mut self, op: OpId, signed: bool) -> Result<(), Error> {
        let r = self.result(op)?;
        let a = self.operand(op, 0)?;
        let from = self.mvt(a)?;
        let x = self.read(a, Pool::FTEMPS[0], Class::float(from))?;
        let opcode = match (signed, from) {
            (true, Mvt::F32) => Opcode::FCVTZSUXSr,
            (true, _) => Opcode::FCVTZSUXDr,
            (false, Mvt::F32) => Opcode::FCVTZUUXSr,
            (false, _) => Opcode::FCVTZUUXDr,
        };
        self.inst(opcode, &[A::R(Pool::TEMPS[0]), A::R(x)]);
        self.write(r, Pool::TEMPS[0])
    }

    /// The load or store of `t` with an unsigned scaled offset, and with a register offset.
    fn access(t: Mvt, load: bool) -> (Opcode, Opcode, Option<Class>) {
        match (t, load) {
            (Mvt::I1 | Mvt::I8, true) => (Opcode::LDRBBui, Opcode::LDRBBroX, Some(Class::GPR32)),
            (Mvt::I16, true) => (Opcode::LDRHHui, Opcode::LDRHHroX, Some(Class::GPR32)),
            (Mvt::I32, true) => (Opcode::LDRWui, Opcode::LDRWroX, Some(Class::GPR32)),
            (Mvt::I64, true) => (Opcode::LDRXui, Opcode::LDRXroX, Some(Class::GPR64)),
            (Mvt::F32, true) => (Opcode::LDRSui, Opcode::LDRSroX, Some(Class::FPR32)),
            (Mvt::F64, true) => (Opcode::LDRDui, Opcode::LDRDroX, Some(Class::FPR64)),
            (Mvt::I1 | Mvt::I8, false) => (Opcode::STRBBui, Opcode::STRBBroX, Some(Class::GPR32)),
            (Mvt::I16, false) => (Opcode::STRHHui, Opcode::STRHHroX, Some(Class::GPR32)),
            (Mvt::I32, false) => (Opcode::STRWui, Opcode::STRWroX, Some(Class::GPR32)),
            (Mvt::I64, false) => (Opcode::STRXui, Opcode::STRXroX, Some(Class::GPR64)),
            (Mvt::F32, false) => (Opcode::STRSui, Opcode::STRSroX, Some(Class::FPR32)),
            (Mvt::F64, false) => (Opcode::STRDui, Opcode::STRDroX, Some(Class::FPR64)),
        }
    }

    fn load(&mut self, op: OpId) -> Result<(), Error> {
        let r = self.result(op)?;
        let addr = self.operand(op, 0)?;
        let t = self.mvt(r)?;
        let (ui, ro, class) = Self::access(t, true);
        let class = class.unwrap_or(Class::GPR64);
        let dst = class.of(if t.is_float() { Pool::FTEMPS[0] } else { Pool::TEMPS[0] });
        match self.frame_slot(addr) {
            Some(name) => {
                self.frame_index(name);
                self.inst(ro, &[A::R(dst), A::R(Pool::FRAME), A::R(Pool::INDEX), A::I(0)]);
            }
            None => {
                let p = self.read(addr, Pool::TEMPS[1], Class::GPR64)?;
                self.inst(ui, &[A::R(dst), A::R(p), A::I(0)]);
            }
        }
        self.write(r, dst)
    }

    fn store(&mut self, op: OpId) -> Result<(), Error> {
        let (v, addr) = (self.operand(op, 0)?, self.operand(op, 1)?);
        let t = self.mvt(v)?;
        let (ui, ro, class) = Self::access(t, false);
        let class = class.unwrap_or(Class::GPR64);
        let src = self.read(v, if t.is_float() { Pool::FTEMPS[0] } else { Pool::TEMPS[0] }, class)?;
        match self.frame_slot(addr) {
            Some(name) => {
                self.frame_index(name);
                self.inst(ro, &[A::R(src), A::R(Pool::FRAME), A::R(Pool::INDEX), A::I(0)]);
            }
            None => {
                let p = self.read(addr, Pool::TEMPS[1], Class::GPR64)?;
                self.inst(ui, &[A::R(src), A::R(p), A::I(0)]);
            }
        }
        Ok(())
    }

    /// The address of the frame area the alloca has.
    fn alloca(&mut self, op: OpId) -> Result<(), Error> {
        let r = self.result(op)?;
        let at = *self.allocas.get(&r).ok_or_else(|| Error("an llvm.alloca without a frame area".into()))?;
        let d = Pool::TEMPS[0];
        self.materialize(d, i64::from(at).cast_unsigned());
        self.inst(Opcode::ADDXrs, &[A::R(d), A::R(Pool::FRAME), A::R(d), A::I(0)]);
        self.write(r, d)
    }

    fn gep(&mut self, op: OpId) -> Result<(), Error> {
        let r = self.result(op)?;
        let elem = match self.body[op].get("elem_type") {
            Some(mlirformat::Attribute::Type(t)) => t.clone(),
            _ => return Err(Error("getelementptr without an element type".into())),
        };
        let size = i64::from(Mvt::try_from(&elem).map_err(|_| Error(format!("getelementptr over {elem} is not supported")))?.bits().div_ceil(8));
        let raw: Vec<i64> = match self.body[op].get("rawConstantIndices") {
            Some(mlirformat::Attribute::DenseArray { values, .. }) => values.iter().map(|v| v.parse::<i64>().map_err(|_| Error(format!("bad index {v}")))).collect::<Result<_, _>>()?,
            _ => return Err(Error("getelementptr without indices".into())),
        };
        let [index] = raw[..] else { return Err(Error("getelementptr with more than one index is not supported".into())) };
        let (d, i, s) = (Pool::TEMPS[0], Pool::TEMPS[1], Pool::TEMPS[2]);
        self.read_into(self.operand(op, 0)?, d)?;
        const DYNAMIC: i64 = i32::MIN as i64;
        if index == DYNAMIC {
            let iv = self.operand(op, 1)?;
            self.read_into(iv, i)?;
            self.sext(i, self.int_bits(iv)?);
            self.materialize(s, size.cast_unsigned());
            self.inst(Opcode::MADDXrrr, &[A::R(d), A::R(i), A::R(s), A::R(d)]);
        } else if index != 0 {
            self.materialize(s, (index * size).cast_unsigned());
            self.inst(Opcode::ADDXrs, &[A::R(d), A::R(d), A::R(s), A::I(0)]);
        }
        self.write(r, d)
    }

    /// The C convention: arguments in `x0`.. / `d0`.., the callee's address from a literal.
    fn call(&mut self, op: OpId) -> Result<(), Error> {
        let callee = Template::callee(self.body, op).ok_or_else(|| Error("an indirect call is not supported".into()))?.to_string();
        if self.stencil.is_some() {
            match Callee::from(callee.as_str()) {
                Callee::Slot(_) => return Ok(()),
                Callee::Jump(_) => {
                    let at = self.inst(Opcode::B, &[A::Rel]).at;
                    self.hole(at, HoleKind::Branch26, callee);
                    return Ok(());
                }
                Callee::Hole(_) => {
                    let r = self.result(op)?;
                    let at = self.literal64(Pool::TEMPS[0]);
                    self.hole(at, HoleKind::Abs64, callee);
                    return self.write_bits(r, Pool::TEMPS[0]);
                }
                Callee::Runtime(_) => {}
            }
        }
        let (mut ints, mut floats) = (0usize, 0usize);
        let args: Vec<ValueId> = self.body[op].operands.iter().copied().collect();
        for v in args {
            let t = self.mvt(v)?;
            let (n, list) = if t.is_float() { (&mut floats, Reg::args(Mvt::F64)) } else { (&mut ints, Reg::args(Mvt::I64)) };
            let r = *list.get(*n).ok_or_else(|| Error(format!("a call with more than {} arguments of type {t:?}", list.len())))?;
            *n += 1;
            self.read_into(v, r)?;
        }
        let at = self.literal64(Pool::TEMPS[0]);
        if self.stencil.is_some() {
            self.hole(at, HoleKind::Abs64, callee);
        } else {
            self.relocs.push(AArch64Reloc { offset: at, symbol: callee });
        }
        self.inst(Opcode::BLR, &[A::R(Pool::TEMPS[0])]);
        if let Some(&r) = self.body[op].results.first() {
            let t = self.mvt(r)?;
            let ret = Reg::rets(if t.is_float() { Mvt::F64 } else { Mvt::I64 })[0];
            self.write(r, ret)?;
        }
        Ok(())
    }

    fn pass(&mut self, values: &[ValueId], to: BlockId) -> Result<(), Error> {
        let args: Vec<ValueId> = self.body[to].args.iter().copied().collect();
        if self.stencil.is_some() && !values.is_empty() {
            return Err(Error("a stencil passes no block arguments".into()));
        }
        if args.len() != values.len() {
            return Err(Error("a jump with the wrong number of block arguments".into()));
        }
        let t = Pool::TEMPS[0];
        for (i, &v) in (0i32..).zip(values) {
            let s = self.read(v, t, Class::GPR64)?;
            self.store_slot(s, Mvt::I64, self.scratch + 8 * i);
        }
        for (i, &a) in (0i32..).zip(&args) {
            self.load_slot(t, Mvt::I64, self.scratch + 8 * i);
            self.write_bits(a, t)?;
        }
        Ok(())
    }

    fn jump_to(&mut self, to: BlockId) {
        let p = self.inst(Opcode::B, &[A::Rel]);
        self.fixups.push((p, to));
    }

    fn branch(&mut self, op: OpId) -> Result<(), Error> {
        let to = *self.body[op].successors.first().ok_or_else(|| Error("llvm.br without a successor".into()))?;
        let values: Vec<ValueId> = self.body[op].operands.iter().copied().collect();
        self.pass(&values, to)?;
        self.jump_to(to);
        Ok(())
    }

    fn cond_branch(&mut self, op: OpId) -> Result<(), Error> {
        let succ: Vec<BlockId> = self.body[op].successors.iter().copied().collect();
        let [t, f] = succ[..] else { return Err(Error("llvm.cond_br needs two successors".into())) };
        let sizes: Vec<usize> = match self.body[op].get("operandSegmentSizes") {
            Some(mlirformat::Attribute::DenseArray { values, .. }) => values.iter().map(|v| v.parse::<usize>().unwrap_or(0)).collect(),
            _ => alloc::vec![1, 0, 0],
        };
        let ops: Vec<ValueId> = self.body[op].operands.iter().copied().collect();
        let (nt, nf) = (sizes.get(1).copied().unwrap_or(0), sizes.get(2).copied().unwrap_or(0));
        let c = self.read(ops[0], Pool::TEMPS[2], Class::GPR32)?;
        if nt == 0 && nf == 0 {
            let p = self.inst(Opcode::CBNZW, &[A::R(c), A::Rel]);
            self.fixups.push((p, t));
            self.jump_to(f);
            return Ok(());
        }
        let to_false = self.inst(Opcode::CBZW, &[A::R(c), A::Rel]);
        self.pass(&ops[1..=nt], t)?;
        self.jump_to(t);
        let here = self.asm.here();
        self.asm.patch(to_false, here);
        self.pass(&ops[1 + nt..1 + nt + nf], f)?;
        self.jump_to(f);
        Ok(())
    }

    fn ret(&mut self, op: OpId) -> Result<(), Error> {
        if self.stencil.is_some() {
            if !self.body[op].operands.is_empty() {
                return Err(Error("a stencil returns nothing".into()));
            }
            let p = self.inst(Opcode::B, &[A::Rel]);
            self.stencil.as_mut().expect("a stencil").ends.push(p);
            return Ok(());
        }
        if let Some(&v) = self.body[op].operands.first() {
            let t = self.mvt(v)?;
            let ret = Reg::rets(if t.is_float() { Mvt::F64 } else { Mvt::I64 })[0];
            self.read_into(v, ret)?;
        }
        self.epilogue();
        Ok(())
    }
}
