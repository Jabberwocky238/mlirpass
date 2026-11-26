//! x86-64 machine code from the llvm dialect, selected as LLVM's fast instruction selector does:
//! the patterns of one node and their instructions are `isel.gen.rs` (`scripts/isel.py`, from
//! LLVM's `X86` TableGen); what `X86FastISel.cpp` writes by hand (memory, compares, branches,
//! calls, divisions, shifts by a register) is here, and the encoding is `encode.rs`.
//!
//! Every value lives in a 64-bit register or frame slot, an integer narrower than 64 bits
//! zero-extended; `stencil` functions are a JIT's stencils (`StencilEmit`).

mod dag;
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
use crate::{Body, BlockId, Emit, Hole, HoleKind, OpId, OptLevel, Stencil, StencilEmit, ValueId};
use encode::{Asm, Cc, Mem, X};
use isel::{Class, FAST, ImmPred, Opcode, Reg};

#[derive(Clone, Debug, PartialEq, Eq)]
pub struct X86_64Code {
    pub name: String,
    pub bytes: Vec<u8>,
    pub relocs: Vec<X86_64Reloc>,
}

#[derive(Clone, Debug, PartialEq, Eq)]
pub struct X86_64Reloc {
    pub offset: usize,
    pub symbol: String,
}

/// x86-64 code at an optimization level: `O0` is LLVM's fast selector, `O1` and up its
/// SelectionDAG patterns (the IR passes of a level are `OptLevel::pipeline`'s, run before).
#[derive(Clone, Copy, Debug, Default, PartialEq, Eq)]
pub struct X86_64Emit {
    pub level: OptLevel,
}

impl Emit for X86_64Emit {
    type Output = Vec<X86_64Code>;

    fn emit(&self, body: &Body<'_>, op: OpId) -> Result<Vec<X86_64Code>, Error> {
        let mut out = Vec::new();
        self.collect(body, op, &mut out)?;
        Ok(out)
    }
}

impl X86_64Emit {
    fn collect(&self, body: &Body<'_>, op: OpId, out: &mut Vec<X86_64Code>) -> Result<(), Error> {
        if body[op].name == "llvm.func" {
            if let Some(&region) = body[op].regions.first()
                && !body[region].blocks.is_empty()
            {
                out.push(X86_64Code::of(body, op, self.level)?);
            }
            return Ok(());
        }
        for &region in body[op].regions.iter() {
            for &block in body[region].blocks.iter() {
                for child in body.block_ops(block) {
                    self.collect(body, child, out)?;
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

impl ImmPred {
    fn holds(self, v: i64) -> bool {
        match self {
            ImmPred::I64immSExt32 => i32::try_from(v).is_ok(),
        }
    }
}

impl Class {
    fn members<'t>(self) -> &'t [Reg] {
        Class::MEMBERS[self as usize]
    }

    fn is_float(self) -> bool {
        matches!(self, Class::FR32 | Class::FR64 | Class::VR128)
    }

    /// The member of the class that is part of `unit`.
    fn of(self, unit: Reg) -> Reg {
        let unit = unit.unit();
        self.members().iter().copied().find(|r| r.unit() == unit).unwrap_or_else(|| panic!("{self:?} has no part of {unit:?}"))
    }

    fn int(t: Mvt) -> Class {
        match t {
            Mvt::I1 | Mvt::I8 => Class::GR8,
            Mvt::I16 => Class::GR16,
            Mvt::I32 => Class::GR32,
            _ => Class::GR64,
        }
    }
}

impl Opcode {
    /// Sample operands: registers of each class (a tied pair the same, high ones for REX),
    /// immediates as wide as the encoding takes, `[r13 + 0x40]`.
    fn sample(self) -> Vec<X> {
        let desc = self.desc();
        let mut out: Vec<X> = Vec::new();
        for (i, o) in desc.operands.iter().enumerate() {
            let tied = desc.tied.iter().find(|&&(a, _)| usize::from(a) == i).map(|&(_, b)| usize::from(b));
            out.push(match (tied, o.kind, o.class) {
                (Some(t), _, _) => out[t],
                (_, super::OperandKind::Reg, Some(c)) => X::R(c.members()[(i + SAMPLE_REG) % c.members().len()]),
                (_, super::OperandKind::Mem, _) => X::M(Mem::at(Reg::R13, SAMPLE_DISP)),
                (_, super::OperandKind::PcRel, _) => X::Rel,
                (_, super::OperandKind::Cond, _) => X::C(Cc::Ne),
                _ => X::I(match desc.encoding.map(|e| e.imm) {
                    Some(isel::ImmT::Imm8 | isel::ImmT::Imm8PCRel) => SAMPLE_IMMS[0],
                    Some(isel::ImmT::Imm16) => SAMPLE_IMMS[1],
                    Some(isel::ImmT::Imm64) => SAMPLE_IMMS[3],
                    _ => SAMPLE_IMMS[2],
                }),
            });
        }
        out
    }
}

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
enum Loc {
    Slot(i32),
    Gpr(Reg),
    Xmm(Reg),
}

struct Pool;

impl Pool {
    /// Values not live across a call.
    const SCRATCH: [Reg; 2] = [Reg::R10, Reg::R11];
    /// Callee-saved, for values live across calls (`CSR_64` without `rbp`, the frame).
    const SAVED: [Reg; 5] = [Reg::RBX, Reg::R12, Reg::R13, Reg::R14, Reg::R15];
    const XMM: [Reg; 8] = [Reg::XMM8, Reg::XMM9, Reg::XMM10, Reg::XMM11, Reg::XMM12, Reg::XMM13, Reg::XMM14, Reg::XMM15];
    /// What one op computes in (never allocated): the result and two more operands.
    const TEMPS: [Reg; 3] = [Reg::RAX, Reg::RCX, Reg::RDX];
    const FTEMPS: [Reg; 3] = [Reg::XMM0, Reg::XMM1, Reg::XMM2];
    /// Every register an op may compute in: the temporaries, the argument registers.
    const SCRATCHES: [Reg; 7] = [Reg::RAX, Reg::RCX, Reg::RDX, Reg::RSI, Reg::RDI, Reg::R8, Reg::R9];
    /// A stencil's context and frame registers.
    const CTX: Reg = Reg::R15;
    const FRAME: Reg = Reg::RBP;
}

/// Sample operands: the class member index past the first eight, a displacement, immediates of
/// one, two, four and eight bytes.
const SAMPLE_REG: usize = 9;
const SAMPLE_DISP: i32 = 0x40;
const SAMPLE_IMMS: [i64; 4] = [0x12, 0x1234, 0x1234_5678, 0x1234_5678_9abc_def0];

/// The page a frame larger than one is probed by.
const PAGE: i64 = 4096;
const SIGN64: u64 = 1 << 63;
const SIGN32: i64 = 1 << 31;

struct Lower<'b, 'a> {
    body: &'b Body<'a>,
    asm: Asm,
    slots: BTreeMap<ValueId, Loc>,
    saved: Vec<(Reg, i32)>,
    frame: i32,
    blocks: BTreeMap<BlockId, usize>,
    fixups: Vec<(usize, BlockId)>,
    relocs: Vec<X86_64Reloc>,
    stencil: Option<Stenciled>,
    /// Each `llvm.alloca`'s frame offset.
    allocas: BTreeMap<ValueId, i32>,
    /// The SelectionDAG selection (`O1` and up).
    selected: Option<dag::Selected>,
}

struct Stenciled {
    holes: Vec<Hole>,
    slots: BTreeMap<ValueId, String>,
    ends: Vec<usize>,
}

impl Stenciled {
    fn of(body: &Body<'_>, f: OpId) -> Option<Self> {
        Template::slots(body, f).map(|slots| Stenciled { holes: Vec::new(), slots, ends: Vec::new() })
    }
}

impl X86_64Code {
    pub fn of(body: &Body<'_>, f: OpId, level: OptLevel) -> Result<X86_64Code, Error> {
        let name = body[f].get_str("sym_name").ok_or_else(|| Error("x86-64: a function without a name".into()))?.to_string();
        let mut lower = Lower::new(body, f, level).map_err(|e| Error(format!("x86-64: @{name}: {}", e.0)))?;
        lower.function(f).map_err(|e| Error(format!("x86-64: @{name}: {}", e.0)))?;
        Ok(X86_64Code { name, bytes: lower.asm.bytes, relocs: lower.relocs })
    }
}

impl StencilEmit for X86_64Emit {
    fn stencils(&self, body: &Body<'_>, root: OpId) -> Result<Vec<Stencil>, Error> {
        let mut out = Vec::new();
        for (name, f) in Template::stencils(body, root) {
            let mut lower = Lower::new(body, f, self.level).map_err(|e| Error(format!("x86-64: stencil @{name}: {}", e.0)))?;
            lower.function(f).map_err(|e| Error(format!("x86-64: stencil @{name}: {}", e.0)))?;
            let holes = lower.stencil.map(|st| st.holes).unwrap_or_default();
            out.push(Stencil { name, code: lower.asm.bytes, holes });
        }
        Ok(out)
    }
}

/// The condition codes of `X86::getX86SSEConditionCode`: whether the operands swap, the
/// condition, and a second one it is and-ed (`oeq`) or or-ed (`une`) with.
enum Both {
    One,
    And(Cc),
    Or(Cc),
}

impl<'b, 'a> Lower<'b, 'a> {
    fn new(body: &'b Body<'a>, f: OpId, level: OptLevel) -> Result<Self, Error> {
        let stencil = Stenciled::of(body, f);
        let region = body[f].regions[0];
        let blocks: Vec<BlockId> = body[region].blocks.iter().copied().collect();
        for &block in &blocks {
            for op in body.block_ops(block) {
                if !body[op].regions.is_empty() {
                    return Err(Error(format!("{} has regions", body[op].name)));
                }
            }
        }
        let selected = (level != OptLevel::O0).then(|| dag::Selector::select(body, &dag::Table::new(), &blocks, stencil.as_ref().map(|s| &s.slots)));
        let none = BTreeMap::new();
        let mut intervals = Interval::of(body, &blocks, selected.as_ref().map_or(&none, |s| &s.folded))?;
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
        let frame = (-next + 15) & !15;
        Ok(Lower { body, asm: Asm::default(), slots, saved, frame, blocks: BTreeMap::new(), fixups: Vec::new(), relocs: Vec::new(), stencil, allocas, selected })
    }

    fn allocate(intervals: &[Interval], stencil: bool) -> (BTreeMap<ValueId, Loc>, Vec<Reg>) {
        let mut locs = BTreeMap::new();
        let mut active: Vec<(u32, Loc)> = Vec::new();
        let mut used: Vec<Reg> = Vec::new();
        for iv in intervals {
            active.retain(|&(hi, _)| hi >= iv.lo);
            let busy = |l: Loc| active.iter().any(|&(_, a)| a == l);
            let pick = if iv.float {
                if iv.across_call { None } else { Pool::XMM.iter().map(|&x| Loc::Xmm(x)).find(|&l| !busy(l)) }
            } else {
                let scratch = (!iv.across_call).then_some(Pool::SCRATCH.iter()).into_iter().flatten();
                scratch.chain(Pool::SAVED.iter()).filter(|&&r| !stencil || r != Pool::CTX).map(|&r| Loc::Gpr(r)).find(|&l| !busy(l))
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

    fn inst(&mut self, op: Opcode, ops: &[X]) -> encode::Placed {
        self.asm.inst(op, ops)
    }

    fn slot(&self, v: ValueId) -> Result<Loc, Error> {
        self.slots.get(&v).copied().ok_or_else(|| Error("a value defined outside the function".into()))
    }

    fn mvt(&self, v: ValueId) -> Result<Mvt, Error> {
        Mvt::try_from(&self.body[v].ty)
    }

    fn mem(&self, d: i32) -> X {
        X::M(Mem::at(Pool::FRAME, d))
    }

    /// `v` in the register of `class` part of `temp`, or of the register it lives in.
    fn read(&mut self, v: ValueId, temp: Reg, class: Class) -> Result<Reg, Error> {
        let float = class.is_float();
        Ok(match self.slot(v)? {
            Loc::Gpr(u) if !float => class.of(u),
            Loc::Xmm(x) if float => x,
            Loc::Gpr(u) => {
                self.inst(Opcode::MOV64toSDrr, &[X::R(temp), X::R(u)]);
                temp
            }
            Loc::Xmm(x) => {
                self.inst(Opcode::MOVSDto64rr, &[X::R(temp), X::R(x)]);
                class.of(temp)
            }
            Loc::Slot(d) => {
                match (float, self.mvt(v)?) {
                    (true, Mvt::F32) => self.inst(Opcode::MOVSSrm, &[X::R(temp), self.mem(d)]),
                    (true, _) => self.inst(Opcode::MOVSDrm, &[X::R(temp), self.mem(d)]),
                    (false, _) => self.inst(Opcode::MOV64rm, &[X::R(temp.unit()), self.mem(d)]),
                };
                if float { temp } else { class.of(temp) }
            }
        })
    }

    /// `v` into exactly `unit` (a copy to a physical register before an instruction).
    fn read_into(&mut self, v: ValueId, unit: Reg) -> Result<(), Error> {
        let float = self.mvt(v)?.is_float();
        let class = if float { Class::FR64 } else { Class::GR64 };
        let temp = match (float, unit.is_xmm()) {
            (a, b) if a == b => unit,
            (true, _) => Pool::FTEMPS[1],
            (false, _) => Reg::RDX,
        };
        let r = self.read(v, temp, class)?;
        self.copy(unit, r);
        Ok(())
    }

    fn copy(&mut self, dst: Reg, src: Reg) {
        if dst.unit() == src.unit() {
            return;
        }
        match (dst.is_xmm(), src.is_xmm()) {
            (true, true) => self.inst(Opcode::MOVAPSrr, &[X::R(dst), X::R(src)]),
            (true, false) => self.inst(Opcode::MOV64toSDrr, &[X::R(dst), X::R(src.unit())]),
            (false, true) => self.inst(Opcode::MOVSDto64rr, &[X::R(dst.unit()), X::R(src)]),
            (false, false) => self.inst(Opcode::MOV64rr, &[X::R(dst.unit()), X::R(src.unit())]),
        };
    }

    /// The result `v` from `src` (an integer zero-extended past its width first).
    fn write(&mut self, v: ValueId, src: Reg) -> Result<(), Error> {
        let t = self.mvt(v)?;
        if !t.is_float() {
            // Cleared past the width where the value goes, never in a register another value has.
            let bits = self.int_bits(v)?;
            let at = match self.slot(v)? {
                Loc::Gpr(u) => u,
                _ if Pool::SCRATCHES.contains(&src.unit()) => src.unit(),
                _ => Reg::RAX,
            };
            self.copy(at, src);
            let r = self.zext(at, bits);
            return self.write_bits(v, r);
        }
        match self.slot(v)? {
            Loc::Slot(d) => {
                match t {
                    Mvt::F32 => self.inst(Opcode::MOVSSmr, &[self.mem(d), X::R(src)]),
                    Mvt::F64 => self.inst(Opcode::MOVSDmr, &[self.mem(d), X::R(src)]),
                    _ => self.inst(Opcode::MOV64mr, &[self.mem(d), X::R(src.unit())]),
                };
            }
            Loc::Gpr(u) => self.copy(u, src),
            Loc::Xmm(x) => self.copy(x, src),
        }
        Ok(())
    }

    /// `r`'s bits past `bits` cleared, in `r`'s 64-bit register.
    fn zext(&mut self, r: Reg, bits: u32) -> Reg {
        let u = r.unit();
        match bits {
            64 => {}
            32 => {
                let e = Class::GR32.of(u);
                self.inst(Opcode::MOV32rr, &[X::R(e), X::R(e)]);
            }
            16 => {
                self.inst(Opcode::MOVZX32rr16, &[X::R(Class::GR32.of(u)), X::R(Class::GR16.of(u))]);
            }
            8 => {
                self.inst(Opcode::MOVZX32rr8, &[X::R(Class::GR32.of(u)), X::R(Class::GR8.of(u))]);
            }
            n if n < 32 => {
                let e = Class::GR32.of(u);
                self.inst(Opcode::AND32ri, &[X::R(e), X::R(e), X::I((1i64 << n) - 1)]);
            }
            n => {
                self.inst(Opcode::SHL64ri, &[X::R(u), X::R(u), X::I(i64::from(64 - n))]);
                self.inst(Opcode::SHR64ri, &[X::R(u), X::R(u), X::I(i64::from(64 - n))]);
            }
        }
        u
    }

    /// The constant `v` is, if an `llvm.mlir.constant` defines it.
    fn constant_of(&self, v: ValueId) -> Option<i64> {
        let def = self.body.def_op(v)?;
        (self.body[def].name == "llvm.mlir.constant").then(|| Constant::bits(self.body, def, Mvt::I64).ok()).flatten().map(|b| b.cast_signed())
    }

    fn epilogue(&mut self) {
        for &(r, at) in &self.saved.clone() {
            self.inst(Opcode::MOV64rm, &[X::R(r), self.mem(at)]);
        }
        self.inst(Opcode::MOV64rr, &[X::R(Reg::RSP), X::R(Pool::FRAME)]);
        self.inst(Opcode::POP64r, &[X::R(Pool::FRAME)]);
        self.inst(Opcode::RET64, &[X::I(0)]);
    }

    /// Touches the stack a page at a time down to the frame's end (`r11` walks, `rax` counts).
    fn probe_stack(&mut self) {
        let (r11, rax) = (X::R(Reg::R11), X::R(Reg::RAX));
        self.inst(Opcode::MOV64rr, &[r11, X::R(Reg::RSP)]);
        self.inst(Opcode::MOV32ri, &[X::R(Reg::EAX), X::I(self.frame.into())]);
        let again = self.asm.here();
        self.inst(Opcode::SUB64ri32, &[r11, r11, X::I(PAGE)]);
        self.inst(Opcode::MOV64mr, &[X::M(Mem::at(Reg::R11, 0)), rax]);
        self.inst(Opcode::SUB64ri32, &[rax, rax, X::I(PAGE)]);
        self.inst(Opcode::CMP64ri32, &[rax, X::I(PAGE)]);
        let back = self.inst(Opcode::JCC_1, &[X::Rel, X::C(Cc::Ae)]).imm.expect("a jump");
        self.asm.patch(back, 1, again);
        self.inst(Opcode::TEST64rr, &[rax, rax]);
        let done = self.inst(Opcode::JCC_1, &[X::Rel, X::C(Cc::E)]).imm.expect("a jump");
        self.inst(Opcode::SUB64rr, &[r11, r11, rax]);
        self.inst(Opcode::MOV64mr, &[X::M(Mem::at(Reg::R11, 0)), rax]);
        let here = self.asm.here();
        self.asm.patch(done, 1, here);
    }

    fn function(&mut self, f: OpId) -> Result<(), Error> {
        let body = self.body;
        let region = body[f].regions[0];
        let blocks: Vec<BlockId> = body[region].blocks.iter().copied().collect();
        if self.stencil.is_some() {
            return self.stencil_body(&blocks);
        }
        self.inst(Opcode::PUSH64r, &[X::R(Pool::FRAME)]);
        self.inst(Opcode::MOV64rr, &[X::R(Pool::FRAME), X::R(Reg::RSP)]);
        if i64::from(self.frame) >= PAGE {
            self.probe_stack();
        }
        if self.frame > 0 {
            self.inst(Opcode::SUB64ri32, &[X::R(Reg::RSP), X::R(Reg::RSP), X::I(self.frame.into())]);
        }
        for &(r, at) in &self.saved.clone() {
            self.inst(Opcode::MOV64mr, &[self.mem(at), X::R(r)]);
        }
        let (mut ints, mut floats) = (0usize, 0usize);
        for &arg in body[blocks[0]].args.iter() {
            let t = self.mvt(arg)?;
            let (n, list) = if t.is_float() { (&mut floats, Reg::args(Mvt::F64)) } else { (&mut ints, Reg::args(Mvt::I64)) };
            let r = *list.get(*n).ok_or_else(|| Error(format!("more than {} parameters of type {t:?}", list.len())))?;
            *n += 1;
            self.write(arg, r)?;
        }
        for &block in &blocks {
            self.blocks.insert(block, self.asm.here());
            for op in body.block_ops(block) {
                self.op(op)?;
            }
        }
        for (at, block) in core::mem::take(&mut self.fixups) {
            let target = self.blocks[&block];
            self.asm.patch(at, 4, target);
        }
        Ok(())
    }

    fn stencil_body(&mut self, blocks: &[BlockId]) -> Result<(), Error> {
        let body = self.body;
        for &block in blocks {
            self.blocks.insert(block, self.asm.here());
            for op in body.block_ops(block) {
                self.op(op)?;
            }
        }
        for (at, block) in core::mem::take(&mut self.fixups) {
            let target = self.blocks[&block];
            self.asm.patch(at, 4, target);
        }
        let mut ends = core::mem::take(&mut self.stencil.as_mut().expect("a stencil").ends);
        if let Some(last) = ends.iter().position(|&at| at + 4 == self.asm.here()) {
            let at = ends.swap_remove(last);
            self.asm.bytes.truncate(at - 1);
        }
        let end = self.asm.here();
        for at in ends {
            self.asm.patch(at, 4, end);
        }
        Ok(())
    }

    fn frame_slot(&self, v: ValueId) -> Option<String> {
        self.stencil.as_ref().and_then(|st| st.slots.get(&v).cloned())
    }

    fn hole(&mut self, at: usize, kind: HoleKind, name: String) {
        if let Some(st) = self.stencil.as_mut() {
            st.holes.push(Hole { at, kind, name });
        }
    }

    fn operand(&self, op: OpId, i: usize) -> Result<ValueId, Error> {
        self.body[op].operands.get(i).copied().ok_or_else(|| Error(format!("{} needs operand {i}", self.body[op].name)))
    }

    fn result(&self, op: OpId) -> Result<ValueId, Error> {
        self.body[op].results.first().copied().ok_or_else(|| Error(format!("{} has no result", self.body[op].name)))
    }

    fn op(&mut self, op: OpId) -> Result<(), Error> {
        let body = self.body;
        if let Some(&r) = body[op].results.first()
            && self.frame_slot(r).is_some()
        {
            return Ok(());
        }
        let name: &str = &body[op].name;
        if self.selected.as_ref().is_some_and(|s| s.folded.contains_key(&op)) {
            return Ok(());
        }
        if let Some(m) = self.selected.as_mut().and_then(|s| s.roots.remove(&op)) {
            return self.emit_match(op, &m);
        }
        if let Some(node) = Isd::of(body, op)
            && self.fast(op, node)?
        {
            return Ok(());
        }
        match name {
            "llvm.mlir.constant" => self.constant(op),
            "llvm.mlir.zero" | "llvm.mlir.undef" | "llvm.mlir.poison" => {
                let r = self.result(op)?;
                self.inst(Opcode::XOR32rr, &[X::R(Reg::EAX), X::R(Reg::EAX), X::R(Reg::EAX)]);
                self.write_bits(r, Reg::RAX)
            }
            "llvm.shl" | "llvm.lshr" | "llvm.ashr" => self.shift(op, name),
            "llvm.sdiv" | "llvm.udiv" | "llvm.srem" | "llvm.urem" => self.divide(op, name),
            "llvm.icmp" => self.icmp(op),
            "llvm.fcmp" => self.fcmp(op),
            "llvm.fneg" => self.fneg(op),
            "llvm.select" => self.select(op),
            "llvm.zext" | "llvm.sext" | "llvm.trunc" | "llvm.ptrtoint" | "llvm.inttoptr" | "llvm.bitcast" => self.int_cast(op, name == "llvm.sext"),
            "llvm.sitofp" | "llvm.uitofp" => self.int_to_float(op, name == "llvm.sitofp"),
            "llvm.fptosi" | "llvm.fptoui" => self.float_to_int(op),
            "llvm.load" => self.load(op),
            "llvm.store" => self.store(op),
            "llvm.getelementptr" => self.gep(op),
            "llvm.alloca" => self.alloca(op),
            "llvm.call" => self.call(op),
            "llvm.intr.stacksave" => {
                let r = self.result(op)?;
                self.write(r, Reg::RSP)
            }
            "llvm.br" => self.branch(op),
            "llvm.cond_br" => self.cond_branch(op),
            "llvm.return" => self.ret(op),
            "llvm.unreachable" => {
                if self.stencil.is_none() {
                    self.inst(Opcode::TRAP, &[]);
                }
                Ok(())
            }
            other => Err(Error(format!("{other} is not supported"))),
        }
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
        let imm = if args.len() == 2 { self.constant_of(args[1]) } else { None };
        let kinds = match args.len() {
            1 => Kinds::R,
            2 => Kinds::Rr,
            _ => Kinds::Rrr,
        };
        let pick = imm.and_then(|i| Fast::find(FAST, node, vt, ret, Kinds::Ri, Some(i), ImmPred::holds).map(|f| (f, Some(i))));
        let Some((f, imm)) = pick.or_else(|| Fast::find(FAST, node, vt, ret, kinds, None, ImmPred::holds).map(|f| (f, None))) else {
            return Ok(false);
        };
        let mut taken: Vec<Reg> = Vec::new();
        for &(k, phys) in f.copies {
            self.read_into(args[usize::from(k)], phys.unit())?;
            taken.push(phys.unit());
        }
        let (opcode, class) = match f.emit {
            FastEmit::Inst(o, c) => (o, c),
            FastEmit::Extract(_) => {
                self.read_into(first, Reg::RAX)?;
                self.write(r, Reg::RAX)?;
                return Ok(true);
            }
        };
        let desc = opcode.desc();
        let dst_unit = if class.is_float() { Pool::FTEMPS[0] } else { Pool::TEMPS[0] };
        let tied = desc.tied.contains(&(1, 0));
        let mut temps = Pool::TEMPS.iter().chain(&Pool::FTEMPS).copied().filter(|t| !taken.contains(t) && *t != dst_unit).collect::<Vec<_>>();
        let mut ops: Vec<X> = Vec::new();
        let outs = usize::from(desc.outs);
        if outs == 1 {
            ops.push(X::R(class.of(dst_unit)));
        }
        for (n, &a) in f.args.iter().enumerate() {
            let at = outs + n;
            let o = desc.operands[at];
            if o.kind != super::OperandKind::Reg {
                ops.push(X::I(imm.unwrap_or(0)));
                continue;
            }
            let c = o.class.unwrap_or(class);
            let v = args[usize::from(a)];
            if tied && at == 1 {
                self.read_into(v, dst_unit)?;
                ops.push(X::R(c.of(dst_unit)));
                continue;
            }
            let kind_float = c.is_float();
            let pos = temps.iter().position(|t| t.is_xmm() == kind_float).ok_or_else(|| Error("out of temporaries".into()))?;
            let t = temps.remove(pos);
            let reg = self.read(v, t, c)?;
            ops.push(X::R(reg));
        }
        self.inst(opcode, &ops);
        let out = if outs == 1 { class.of(dst_unit) } else { *desc.defs.first().ok_or_else(|| Error(format!("{} has no result", opcode.name())))? };
        self.write(r, out)?;
        Ok(true)
    }

    /// Nodes that read the sign bit: an `i1` or `i7` is not the `i8` it is selected as.
    fn signed(node: Isd) -> bool {
        matches!(node, Isd::SignExtend | Isd::Sra | Isd::Sdiv | Isd::SintToFp)
    }

    fn exact(&self, v: ValueId) -> Result<bool, Error> {
        let t = self.mvt(v)?;
        Ok(t.is_float() || self.int_bits(v)? == t.bits())
    }

    fn constant(&mut self, op: OpId) -> Result<(), Error> {
        let r = self.result(op)?;
        let t = self.mvt(r)?;
        let bits = Constant::bits(self.body, op, t)?;
        self.materialize(bits);
        if t.is_float() {
            let x = Pool::FTEMPS[0];
            self.copy(x, Reg::RAX);
            self.write(r, x)
        } else {
            self.write_bits(r, Reg::RAX)
        }
    }

    /// `rax = bits`, as short as `X86FastISel::fastMaterializeConstant` writes it.
    fn materialize(&mut self, bits: u64) {
        if bits == 0 {
            self.inst(Opcode::XOR32rr, &[X::R(Reg::EAX), X::R(Reg::EAX), X::R(Reg::EAX)]);
        } else if let Ok(v) = u32::try_from(bits) {
            self.inst(Opcode::MOV32ri, &[X::R(Reg::EAX), X::I(v.into())]);
        } else {
            self.inst(Opcode::MOV64ri, &[X::R(Reg::RAX), X::I(bits.cast_signed())]);
        }
    }

    /// An integer result already zero-extended in `src`'s 64-bit register.
    fn write_bits(&mut self, v: ValueId, src: Reg) -> Result<(), Error> {
        match self.slot(v)? {
            Loc::Slot(d) => {
                self.inst(Opcode::MOV64mr, &[self.mem(d), X::R(src.unit())]);
            }
            Loc::Gpr(u) | Loc::Xmm(u) => self.copy(u, src),
        }
        Ok(())
    }

    /// `X86FastISel::X86SelectShift`: the amount in `cl`.
    fn shift(&mut self, op: OpId, name: &str) -> Result<(), Error> {
        let r = self.result(op)?;
        let t = self.mvt(r)?.legal();
        let opcode = match (name, t) {
            ("llvm.shl", Mvt::I8) => Opcode::SHL8rCL,
            ("llvm.shl", Mvt::I16) => Opcode::SHL16rCL,
            ("llvm.shl", Mvt::I32) => Opcode::SHL32rCL,
            ("llvm.shl", _) => Opcode::SHL64rCL,
            ("llvm.lshr", Mvt::I8) => Opcode::SHR8rCL,
            ("llvm.lshr", Mvt::I16) => Opcode::SHR16rCL,
            ("llvm.lshr", Mvt::I32) => Opcode::SHR32rCL,
            ("llvm.lshr", _) => Opcode::SHR64rCL,
            (_, Mvt::I8) => Opcode::SAR8rCL,
            (_, Mvt::I16) => Opcode::SAR16rCL,
            (_, Mvt::I32) => Opcode::SAR32rCL,
            _ => Opcode::SAR64rCL,
        };
        let class = Class::int(t);
        self.read_into(self.operand(op, 1)?, Reg::RCX)?;
        self.read_into(self.operand(op, 0)?, Reg::RAX)?;
        let a = class.of(Reg::RAX);
        self.inst(opcode, &[X::R(a), X::R(a)]);
        self.write(r, a)
    }

    /// `X86FastISel::X86SelectDivRem`: `cdq` / `cqo` + `idiv`, or zeroed `edx` + `div`, on
    /// operands widened to 32 bits below that.
    fn divide(&mut self, op: OpId, name: &str) -> Result<(), Error> {
        let r = self.result(op)?;
        let t = self.mvt(r)?.legal();
        let signed = matches!(name, "llvm.sdiv" | "llvm.srem");
        let wide = t == Mvt::I64;
        let (a, b) = (self.operand(op, 0)?, self.operand(op, 1)?);
        self.read_into(b, Reg::RCX)?;
        self.read_into(a, Reg::RAX)?;
        if !wide && signed && t != Mvt::I32 {
            for u in [Reg::RAX, Reg::RCX] {
                let (e, n) = (Class::GR32.of(u), Class::int(t).of(u));
                let ext = if t == Mvt::I16 { Opcode::MOVSX32rr16 } else { Opcode::MOVSX32rr8 };
                self.inst(ext, &[X::R(e), X::R(n)]);
            }
        }
        let (src, div) = match (wide, signed) {
            (true, true) => (Reg::RCX, Opcode::IDIV64r),
            (true, false) => (Reg::RCX, Opcode::DIV64r),
            (false, true) => (Reg::ECX, Opcode::IDIV32r),
            (false, false) => (Reg::ECX, Opcode::DIV32r),
        };
        match (wide, signed) {
            (true, true) => self.inst(Opcode::CQO, &[]),
            (false, true) => self.inst(Opcode::CDQ, &[]),
            _ => self.inst(Opcode::XOR32rr, &[X::R(Reg::EDX), X::R(Reg::EDX), X::R(Reg::EDX)]),
        };
        self.inst(div, &[X::R(src)]);
        let out = if matches!(name, "llvm.srem" | "llvm.urem") { Reg::RDX } else { Reg::RAX };
        self.write(r, out)
    }

    fn icmp_cc(p: ICmpPredicate) -> Cc {
        match p {
            ICmpPredicate::Eq => Cc::E,
            ICmpPredicate::Ne => Cc::Ne,
            ICmpPredicate::Slt => Cc::L,
            ICmpPredicate::Sle => Cc::Le,
            ICmpPredicate::Sgt => Cc::G,
            ICmpPredicate::Sge => Cc::Ge,
            ICmpPredicate::Ult => Cc::B,
            ICmpPredicate::Ule => Cc::Be,
            ICmpPredicate::Ugt => Cc::A,
            ICmpPredicate::Uge => Cc::Ae,
        }
    }

    /// `X86FastISel::X86SelectCmp`: `cmp` and `setcc` into `al`, zero-extended.
    fn icmp(&mut self, op: OpId) -> Result<(), Error> {
        let r = self.result(op)?;
        let cc = Self::icmp_cc(Pred::of::<ICmpPredicate>(self.body, op)?);
        let (a, b) = (self.operand(op, 0)?, self.operand(op, 1)?);
        let t = self.mvt(a)?.legal();
        let class = Class::int(t);
        let cmp = match t {
            Mvt::I8 => Opcode::CMP8rr,
            Mvt::I16 => Opcode::CMP16rr,
            Mvt::I32 => Opcode::CMP32rr,
            _ => Opcode::CMP64rr,
        };
        let x = self.read(a, Reg::RCX, class)?;
        let y = self.read(b, Reg::RDX, class)?;
        self.inst(cmp, &[X::R(x), X::R(y)]);
        self.inst(Opcode::SETCCr, &[X::R(Reg::AL), X::C(cc)]);
        self.write(r, Reg::AL)
    }

    fn fcmp(&mut self, op: OpId) -> Result<(), Error> {
        let r = self.result(op)?;
        let pred = Pred::of::<FCmpPredicate>(self.body, op)?;
        let (a, b) = (self.operand(op, 0)?, self.operand(op, 1)?);
        let (swap, cc, both) = match pred {
            FCmpPredicate::False | FCmpPredicate::True => {
                self.materialize(u64::from(pred == FCmpPredicate::True));
                return self.write_bits(r, Reg::RAX);
            }
            FCmpPredicate::Oeq => (false, Cc::E, Both::And(Cc::Np)),
            FCmpPredicate::Une => (false, Cc::Ne, Both::Or(Cc::P)),
            FCmpPredicate::Ogt => (false, Cc::A, Both::One),
            FCmpPredicate::Oge => (false, Cc::Ae, Both::One),
            FCmpPredicate::Olt => (true, Cc::A, Both::One),
            FCmpPredicate::Ole => (true, Cc::Ae, Both::One),
            FCmpPredicate::Ugt => (true, Cc::B, Both::One),
            FCmpPredicate::Uge => (true, Cc::Be, Both::One),
            FCmpPredicate::Ult => (false, Cc::B, Both::One),
            FCmpPredicate::Ule => (false, Cc::Be, Both::One),
            FCmpPredicate::One => (false, Cc::Ne, Both::One),
            FCmpPredicate::Ueq => (false, Cc::E, Both::One),
            FCmpPredicate::Ord => (false, Cc::Np, Both::One),
            FCmpPredicate::Uno => (false, Cc::P, Both::One),
        };
        let (x, y) = if swap { (b, a) } else { (a, b) };
        let t = self.mvt(x)?;
        let class = if t == Mvt::F32 { Class::FR32 } else { Class::FR64 };
        let xr = self.read(x, Pool::FTEMPS[0], class)?;
        let yr = self.read(y, Pool::FTEMPS[1], class)?;
        self.inst(if t == Mvt::F32 { Opcode::UCOMISSrr } else { Opcode::UCOMISDrr }, &[X::R(xr), X::R(yr)]);
        self.inst(Opcode::SETCCr, &[X::R(Reg::AL), X::C(cc)]);
        match both {
            Both::One => {}
            Both::And(c2) | Both::Or(c2) => {
                self.inst(Opcode::SETCCr, &[X::R(Reg::CL), X::C(c2)]);
                let combine = if matches!(both, Both::And(_)) { Opcode::AND8rr } else { Opcode::OR8rr };
                self.inst(combine, &[X::R(Reg::AL), X::R(Reg::AL), X::R(Reg::CL)]);
            }
        }
        self.write(r, Reg::AL)
    }

    fn fneg(&mut self, op: OpId) -> Result<(), Error> {
        let r = self.result(op)?;
        let a = self.operand(op, 0)?;
        let t = self.mvt(a)?;
        if t == Mvt::F32 {
            let x = self.read(a, Pool::FTEMPS[0], Class::FR32)?;
            self.inst(Opcode::MOVSS2DIrr, &[X::R(Reg::EAX), X::R(x)]);
            self.inst(Opcode::XOR32ri, &[X::R(Reg::EAX), X::R(Reg::EAX), X::I(SIGN32)]);
            self.inst(Opcode::MOVDI2SSrr, &[X::R(Pool::FTEMPS[0]), X::R(Reg::EAX)]);
        } else {
            self.read_into(a, Reg::RAX)?;
            self.inst(Opcode::MOV64ri, &[X::R(Reg::RCX), X::I(SIGN64.cast_signed())]);
            self.inst(Opcode::XOR64rr, &[X::R(Reg::RAX), X::R(Reg::RAX), X::R(Reg::RCX)]);
            self.copy(Pool::FTEMPS[0], Reg::RAX);
        }
        self.write(r, Pool::FTEMPS[0])
    }

    /// `X86FastISel::X86FastEmitCMoveSelect`: `test` the condition, `cmovne` the true value over
    /// the false one (a float through its bits).
    fn select(&mut self, op: OpId) -> Result<(), Error> {
        let r = self.result(op)?;
        let (c, t, f) = (self.operand(op, 0)?, self.operand(op, 1)?, self.operand(op, 2)?);
        let ty = self.mvt(r)?;
        let wide = ty.bits() > 32;
        let class = if wide { Class::GR64 } else { Class::GR32 };
        let cond = self.read(c, Reg::RDX, Class::GR8)?;
        self.inst(Opcode::TEST8rr, &[X::R(cond), X::R(cond)]);
        self.read_into(f, Reg::RAX)?;
        self.read_into(t, Reg::RCX)?;
        let (a, b) = (class.of(Reg::RAX), class.of(Reg::RCX));
        self.inst(if wide { Opcode::CMOV64rr } else { Opcode::CMOV32rr }, &[X::R(a), X::R(a), X::R(b), X::C(Cc::Ne)]);
        if ty.is_float() {
            self.copy(Pool::FTEMPS[0], Reg::RAX);
            return self.write(r, Pool::FTEMPS[0]);
        }
        self.write(r, a)
    }

    /// Integer casts the patterns leave: extensions by shifts, copies of the 64-bit register.
    fn int_cast(&mut self, op: OpId, signed: bool) -> Result<(), Error> {
        let r = self.result(op)?;
        let a = self.operand(op, 0)?;
        let (from, to) = (self.mvt(a)?, self.mvt(r)?);
        if from.is_float() != to.is_float() {
            return Err(Error(format!("{} from {from:?} to {to:?} is not supported", self.body[op].name)));
        }
        let unit = if from.is_float() { Pool::FTEMPS[0] } else { Reg::RAX };
        self.read_into(a, unit)?;
        if signed {
            let n = i64::from(64 - self.int_bits(a)?);
            self.inst(Opcode::SHL64ri, &[X::R(Reg::RAX), X::R(Reg::RAX), X::I(n)]);
            self.inst(Opcode::SAR64ri, &[X::R(Reg::RAX), X::R(Reg::RAX), X::I(n)]);
        }
        self.write(r, unit)
    }

    fn int_bits(&self, v: ValueId) -> Result<u32, Error> {
        match &self.body[v].ty {
            mlirformat::Type::Integer { width, .. } => Ok(*width),
            _ => Ok(64),
        }
    }

    /// From the integers the patterns do not take: narrower ones widened to 32 bits, unsigned
    /// 32-bit ones as the 64-bit integer they are.
    fn int_to_float(&mut self, op: OpId, signed: bool) -> Result<(), Error> {
        let r = self.result(op)?;
        let a = self.operand(op, 0)?;
        let to = self.mvt(r)?;
        let bits = self.int_bits(a)?;
        if !signed && bits == 64 {
            return Err(Error("uitofp from i64 is not supported".into()));
        }
        self.read_into(a, Reg::RAX)?;
        if signed && bits < 64 {
            let n = i64::from(64 - bits);
            self.inst(Opcode::SHL64ri, &[X::R(Reg::RAX), X::R(Reg::RAX), X::I(n)]);
            self.inst(Opcode::SAR64ri, &[X::R(Reg::RAX), X::R(Reg::RAX), X::I(n)]);
        }
        let x = Pool::FTEMPS[0];
        let opcode = if to == Mvt::F32 { Opcode::CVTSI642SSrr } else { Opcode::CVTSI642SDrr };
        let class = if to == Mvt::F32 { Class::FR32 } else { Class::FR64 };
        self.inst(opcode, &[X::R(class.of(x)), X::R(Reg::RAX)]);
        self.write(r, x)
    }

    /// To the integers the patterns do not give: through the 64-bit conversion.
    fn float_to_int(&mut self, op: OpId) -> Result<(), Error> {
        let r = self.result(op)?;
        let a = self.operand(op, 0)?;
        let from = self.mvt(a)?;
        if self.int_bits(r)? == 64 && self.body[op].name == "llvm.fptoui" {
            return Err(Error("fptoui to i64 is not supported".into()));
        }
        let class = if from == Mvt::F32 { Class::FR32 } else { Class::FR64 };
        let x = self.read(a, Pool::FTEMPS[0], class)?;
        let opcode = if from == Mvt::F32 { Opcode::CVTTSS2SI64rr } else { Opcode::CVTTSD2SI64rr };
        self.inst(opcode, &[X::R(Reg::RAX), X::R(x)]);
        self.write(r, Reg::RAX)
    }

    fn address(&mut self, addr: ValueId) -> Result<(Mem, Option<String>), Error> {
        Ok(match self.frame_slot(addr) {
            Some(name) => (Mem::wide(Pool::FRAME, 0), Some(name)),
            None => {
                let p = self.read(addr, Reg::RCX, Class::GR64)?;
                (Mem::at(p, 0), None)
            }
        })
    }

    /// `X86FastISel::X86FastEmitLoad`: an integer zero-extended to 32 bits or more.
    fn load(&mut self, op: OpId) -> Result<(), Error> {
        let r = self.result(op)?;
        let (m, hole) = self.address(self.operand(op, 0)?)?;
        let t = self.mvt(r)?;
        let (opcode, dst) = match t {
            Mvt::I1 | Mvt::I8 => (Opcode::MOVZX32rm8, Reg::EAX),
            Mvt::I16 => (Opcode::MOVZX32rm16, Reg::EAX),
            Mvt::I32 => (Opcode::MOV32rm, Reg::EAX),
            Mvt::I64 => (Opcode::MOV64rm, Reg::RAX),
            Mvt::F32 => (Opcode::MOVSSrm, Pool::FTEMPS[0]),
            Mvt::F64 => (Opcode::MOVSDrm, Pool::FTEMPS[0]),
        };
        let placed = self.inst(opcode, &[X::R(dst), X::M(m)]);
        if let (Some(name), Some(at)) = (hole, placed.disp) {
            self.hole(at, HoleKind::Disp32, name);
        }
        self.write(r, dst)
    }

    /// `X86FastISel::X86FastEmitStore`.
    fn store(&mut self, op: OpId) -> Result<(), Error> {
        let (v, p) = (self.operand(op, 0)?, self.operand(op, 1)?);
        let t = self.mvt(v)?;
        let src = match t {
            Mvt::F32 => self.read(v, Pool::FTEMPS[0], Class::FR32)?,
            Mvt::F64 => self.read(v, Pool::FTEMPS[0], Class::FR64)?,
            t => self.read(v, Reg::RAX, Class::int(t))?,
        };
        let (m, hole) = self.address(p)?;
        let opcode = match t {
            Mvt::I1 | Mvt::I8 => Opcode::MOV8mr,
            Mvt::I16 => Opcode::MOV16mr,
            Mvt::I32 => Opcode::MOV32mr,
            Mvt::I64 => Opcode::MOV64mr,
            Mvt::F32 => Opcode::MOVSSmr,
            Mvt::F64 => Opcode::MOVSDmr,
        };
        let placed = self.inst(opcode, &[X::M(m), X::R(src)]);
        if let (Some(name), Some(at)) = (hole, placed.disp) {
            self.hole(at, HoleKind::Disp32, name);
        }
        Ok(())
    }

    /// The address of the frame area the alloca has.
    fn alloca(&mut self, op: OpId) -> Result<(), Error> {
        let r = self.result(op)?;
        let at = *self.allocas.get(&r).ok_or_else(|| Error("an llvm.alloca without a frame area".into()))?;
        self.inst(Opcode::LEA64r, &[X::R(Reg::RAX), self.mem(at)]);
        self.write(r, Reg::RAX)
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
        self.read_into(self.operand(op, 0)?, Reg::RAX)?;
        const DYNAMIC: i64 = i32::MIN as i64;
        if index == DYNAMIC {
            let i = self.operand(op, 1)?;
            let bits = self.int_bits(i)?;
            self.read_into(i, Reg::RCX)?;
            if bits < 64 {
                let n = i64::from(64 - bits);
                self.inst(Opcode::SHL64ri, &[X::R(Reg::RCX), X::R(Reg::RCX), X::I(n)]);
                self.inst(Opcode::SAR64ri, &[X::R(Reg::RCX), X::R(Reg::RCX), X::I(n)]);
            }
            self.inst(Opcode::IMUL64rri32, &[X::R(Reg::RCX), X::R(Reg::RCX), X::I(size)]);
            self.inst(Opcode::ADD64rr, &[X::R(Reg::RAX), X::R(Reg::RAX), X::R(Reg::RCX)]);
        } else if let Ok(off) = i32::try_from(index * size) {
            if off != 0 {
                self.inst(Opcode::ADD64ri32, &[X::R(Reg::RAX), X::R(Reg::RAX), X::I(off.into())]);
            }
        } else {
            self.inst(Opcode::MOV64ri, &[X::R(Reg::RCX), X::I(index * size)]);
            self.inst(Opcode::ADD64rr, &[X::R(Reg::RAX), X::R(Reg::RAX), X::R(Reg::RCX)]);
        }
        self.write(r, Reg::RAX)
    }

    /// `X86FastISel::fastLowerCall` for the C convention, through `rax`.
    fn call(&mut self, op: OpId) -> Result<(), Error> {
        let callee = Template::callee(self.body, op).ok_or_else(|| Error("an indirect call is not supported".into()))?.to_string();
        if self.stencil.is_some() {
            match Callee::from(callee.as_str()) {
                Callee::Slot(_) => return Ok(()),
                Callee::Jump(_) => {
                    let at = self.inst(Opcode::JMP_4, &[X::Rel]).imm.expect("a jump");
                    self.hole(at, HoleKind::Rel32, callee);
                    return Ok(());
                }
                Callee::Hole(_) => {
                    let r = self.result(op)?;
                    let at = self.inst(Opcode::MOV64ri, &[X::R(Reg::RAX), X::I(0)]).imm.expect("an immediate");
                    self.hole(at, HoleKind::Abs64, callee);
                    return self.write_bits(r, Reg::RAX);
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
        let at = self.inst(Opcode::MOV64ri, &[X::R(Reg::RAX), X::I(0)]).imm.expect("an immediate");
        if self.stencil.is_some() {
            self.hole(at, HoleKind::Abs64, callee);
        } else {
            self.relocs.push(X86_64Reloc { offset: at, symbol: callee });
        }
        self.inst(Opcode::CALL64r, &[X::R(Reg::RAX)]);
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
        // A parallel copy: each move once nothing still reads its destination; a cycle is
        // broken through `rax`.
        let mut moves: Vec<(Loc, Loc)> = Vec::new();
        for (&v, &a) in values.iter().zip(&args) {
            let (src, dst) = (self.slot(v)?, self.slot(a)?);
            if src != dst {
                moves.push((dst, src));
            }
        }
        while !moves.is_empty() {
            match moves.iter().position(|&(d, _)| !moves.iter().any(|&(_, s)| s == d)) {
                Some(i) => {
                    let (d, s) = moves.remove(i);
                    self.move_loc(d, s);
                }
                None => {
                    let (_, s) = moves[0];
                    self.move_loc(Loc::Gpr(Reg::RAX), s);
                    moves[0].1 = Loc::Gpr(Reg::RAX);
                }
            }
        }
        Ok(())
    }

    /// The 64 bits at `src` to `dst` (`rax` between two slots).
    fn move_loc(&mut self, dst: Loc, src: Loc) {
        match (dst, src) {
            (Loc::Slot(d), Loc::Slot(s)) => {
                self.inst(Opcode::MOV64rm, &[X::R(Reg::RAX), self.mem(s)]);
                self.inst(Opcode::MOV64mr, &[self.mem(d), X::R(Reg::RAX)]);
            }
            (Loc::Slot(d), Loc::Gpr(r)) => {
                self.inst(Opcode::MOV64mr, &[self.mem(d), X::R(r)]);
            }
            (Loc::Slot(d), Loc::Xmm(x)) => {
                self.inst(Opcode::MOVSDmr, &[self.mem(d), X::R(x)]);
            }
            (Loc::Gpr(r), Loc::Slot(s)) => {
                self.inst(Opcode::MOV64rm, &[X::R(r), self.mem(s)]);
            }
            (Loc::Xmm(x), Loc::Slot(s)) => {
                self.inst(Opcode::MOVSDrm, &[X::R(x), self.mem(s)]);
            }
            (Loc::Gpr(d) | Loc::Xmm(d), Loc::Gpr(s) | Loc::Xmm(s)) => self.copy(d, s),
        }
    }

    fn jump_to(&mut self, to: BlockId) {
        let at = self.inst(Opcode::JMP_4, &[X::Rel]).imm.expect("a jump");
        self.fixups.push((at, to));
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
        let c = self.read(ops[0], Reg::RAX, Class::GR8)?;
        self.inst(Opcode::TEST8rr, &[X::R(c), X::R(c)]);
        let to_false = self.inst(Opcode::JCC_4, &[X::Rel, X::C(Cc::E)]).imm.expect("a jump");
        self.pass(&ops[1..=nt], t)?;
        self.jump_to(t);
        let here = self.asm.here();
        self.asm.patch(to_false, 4, here);
        self.pass(&ops[1 + nt..1 + nt + nf], f)?;
        self.jump_to(f);
        Ok(())
    }

    fn ret(&mut self, op: OpId) -> Result<(), Error> {
        if self.stencil.is_some() {
            if !self.body[op].operands.is_empty() {
                return Err(Error("a stencil returns nothing".into()));
            }
            let at = self.inst(Opcode::JMP_4, &[X::Rel]).imm.expect("a jump");
            self.stencil.as_mut().expect("a stencil").ends.push(at);
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

impl Reg {
    fn is_xmm(self) -> bool {
        Class::FR64.members().contains(&self.unit())
    }

    fn args<'t>(t: Mvt) -> &'t [Reg] {
        Reg::ARGS.iter().find(|(m, _)| *m == t).map_or(&[], |(_, r)| r)
    }

    fn rets<'t>(t: Mvt) -> &'t [Reg] {
        Reg::RETS.iter().find(|(m, _)| *m == t).map_or(&[], |(_, r)| r)
    }
}
