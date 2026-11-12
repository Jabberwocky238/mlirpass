//! ⭐ x86-64 out: each `llvm.func` with a body ⇒ its machine code ([`X86_64Code`]), System V calling convention,
//! without LLVM.
//!
//! First tier: every SSA value (block arguments, results) has its own 8-byte stack slot below `rbp`, every op loads
//! its operands into scratch registers (`rax` / `rcx` / `rdx`, `xmm0` / `xmm1`), computes, and stores the result
//! back. Integers narrower than 64 bits are kept zero-extended in their slots. No register allocation yet: correct
//! first, fast later.
//!
//! ```text
//!   push rbp; mov rbp, rsp; sub rsp, frame       the parameters (rdi, rsi, …; xmm0, …) into their slots
//!   …one op at a time…
//!   llvm.br / llvm.cond_br                       block arguments as a parallel copy (through a scratch area)
//!   llvm.call @f                                 mov rax, imm64 (an [`X86_64Reloc`] the loader fills); call rax
//!   llvm.return                                  the result into rax / xmm0; leave; ret
//! ```
//!
//! Supported: integers (`i1` … `i64`) and `!llvm.ptr`, `f64`; `llvm.mlir.constant` / `zero` / `undef` / `poison`,
//! integer and float arithmetic, `icmp` / `fcmp` / `select`, the casts between them, `load` / `store`,
//! `getelementptr` with one index, `br` / `cond_br` / `switch`-free control flow, `call` of a symbol (at most six
//! integer and eight float arguments), `return`, `unreachable`. Anything else is an error naming the op.

use alloc::collections::BTreeMap;
use alloc::format;
use alloc::string::{String, ToString};
use alloc::vec::Vec;

use mlirformat::llvm::{FCmpOp, FCmpPredicate, ICmpOp, ICmpPredicate};
use mlirformat::llvm_types::LlvmType;
use mlirformat::{Attribute, Error, FloatKind, Type};

use crate::{Attrs, Body, BlockId, Emit, Heads, OpId, ValueId};

/// ⭐ One function's machine code.
#[derive(Clone, Debug, PartialEq, Eq)]
pub struct X86_64Code {
    pub name: String,
    pub bytes: Vec<u8>,
    /// Where the absolute addresses of the functions it calls go.
    pub relocs: Vec<X86_64Reloc>,
}

/// ⭐ A 64-bit absolute address of symbol `symbol` to write at byte `offset` (the immediate of a `mov rax, imm64`).
#[derive(Clone, Debug, PartialEq, Eq)]
pub struct X86_64Reloc {
    pub offset: usize,
    pub symbol: String,
}

/// ⭐ x86-64 as an [`Emit`] target: every `llvm.func` with a body under an op.
pub struct X86_64Emit;

impl Emit for X86_64Emit {
    type Output = Vec<X86_64Code>;

    fn emit(&self, body: &Body<'_>, op: OpId) -> Result<Vec<X86_64Code>, Error> {
        let mut out = Vec::new();
        Self::collect(body, op, &mut out)?;
        Ok(out)
    }
}

impl X86_64Emit {
    fn collect(body: &Body<'_>, op: OpId, out: &mut Vec<X86_64Code>) -> Result<(), Error> {
        if body[op].name == "llvm.func" {
            if let Some(&region) = body[op].regions.first()
                && !body[region].blocks.is_empty()
            {
                out.push(X86_64Code::of(body, op)?);
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
}

/// General-purpose registers by their encoding.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
#[repr(u8)]
enum Gpr {
    Rax = 0,
    Rcx = 1,
    Rdx = 2,
    Rbx = 3,
    Rsp = 4,
    Rbp = 5,
    Rsi = 6,
    Rdi = 7,
    R8 = 8,
    R9 = 9,
    R10 = 10,
    R11 = 11,
    R12 = 12,
    R13 = 13,
    R14 = 14,
    R15 = 15,
}

impl Gpr {
    /// System V's integer argument registers, in order.
    const ARGS: [Gpr; 6] = [Gpr::Rdi, Gpr::Rsi, Gpr::Rdx, Gpr::Rcx, Gpr::R8, Gpr::R9];

    fn low(self) -> u8 {
        self as u8 & 7
    }

    fn high(self) -> bool {
        self as u8 >= 8
    }
}

/// System V's float argument registers `xmm0 … xmm7`.
const XMM_ARGS: u8 = 8;

/// A value's machine kind.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
enum Kind {
    /// An integer of this many bits (`!llvm.ptr` is 64).
    Int(u32),
    F64,
}

impl Kind {
    fn of(t: &Type<'_>) -> Result<Kind, Error> {
        match t {
            Type::Integer { width, .. } if *width <= 64 => Ok(Kind::Int(*width)),
            Type::Float(FloatKind::F64) => Ok(Kind::F64),
            Type::Index => Ok(Kind::Int(64)),
            t if matches!(LlvmType::try_from(t), Ok(LlvmType::Ptr(_))) => Ok(Kind::Int(64)),
            t => Err(Error(format!("x86-64: values of type {t} are not supported"))),
        }
    }

    /// Bytes in memory (`load` / `store` / `getelementptr` elements).
    fn size(t: &Type<'_>) -> Result<u32, Error> {
        match Kind::of(t)? {
            Kind::Int(w) => Ok(w.div_ceil(8).next_power_of_two()),
            Kind::F64 => Ok(8),
        }
    }
}

/// The byte buffer with x86-64's encodings (only the forms the lowering uses).
#[derive(Default)]
struct Asm {
    bytes: Vec<u8>,
}

impl Asm {
    fn byte(&mut self, b: u8) {
        self.bytes.push(b);
    }

    fn bytes(&mut self, b: &[u8]) {
        self.bytes.extend_from_slice(b);
    }

    fn here(&self) -> usize {
        self.bytes.len()
    }

    /// REX prefix when needed (`w`: 64-bit operand; `r` / `b`: high register in ModRM.reg / rm).
    fn rex(&mut self, w: bool, r: bool, b: bool) {
        let rex = 0x40 | (u8::from(w) << 3) | (u8::from(r) << 2) | u8::from(b);
        if rex != 0x40 {
            self.byte(rex);
        }
    }

    /// ModRM + disp32 for `[base + disp]` (`base` is rbp or rcx here: no SIB needed).
    fn mem(&mut self, reg: u8, base: Gpr, disp: i32) {
        self.byte(0x80 | ((reg & 7) << 3) | base.low());
        self.bytes(&disp.to_le_bytes());
    }

    /// `op reg, [base + disp]` with an optional mandatory prefix and a REX.W choice.
    fn rm(&mut self, prefix: Option<u8>, w: bool, opcode: &[u8], reg: u8, base: Gpr, disp: i32) {
        if let Some(p) = prefix {
            self.byte(p);
        }
        self.rex(w, reg >= 8, base.high());
        self.bytes(opcode);
        self.mem(reg, base, disp);
    }

    /// `op dst, src` register to register (ModRM mod = 11; `reg` field is `reg`, rm field is `rm`).
    fn rr(&mut self, prefix: Option<u8>, w: bool, opcode: &[u8], reg: u8, rm: u8) {
        if let Some(p) = prefix {
            self.byte(p);
        }
        self.rex(w, reg >= 8, rm >= 8);
        self.bytes(opcode);
        self.byte(0xc0 | ((reg & 7) << 3) | (rm & 7));
    }

    /// `mov r64, [base + disp]`
    fn load64(&mut self, dst: Gpr, base: Gpr, disp: i32) {
        self.rm(None, true, &[0x8b], dst as u8, base, disp);
    }

    /// `mov [base + disp], r64`
    fn store64(&mut self, base: Gpr, disp: i32, src: Gpr) {
        self.rm(None, true, &[0x89], src as u8, base, disp);
    }

    /// A `bits`-wide integer from memory into `dst`, zero- or sign-extended to 64 bits.
    fn load_int(&mut self, dst: Gpr, base: Gpr, disp: i32, bits: u32, signed: bool) {
        match (bits, signed) {
            (64, _) => self.load64(dst, base, disp),
            (32, false) => self.rm(None, false, &[0x8b], dst as u8, base, disp),
            (32, true) => self.rm(None, true, &[0x63], dst as u8, base, disp),
            (16, false) => self.rm(None, true, &[0x0f, 0xb7], dst as u8, base, disp),
            (16, true) => self.rm(None, true, &[0x0f, 0xbf], dst as u8, base, disp),
            (_, false) => self.rm(None, true, &[0x0f, 0xb6], dst as u8, base, disp),
            (_, true) => self.rm(None, true, &[0x0f, 0xbe], dst as u8, base, disp),
        }
    }

    /// The low `bytes` bytes of `src` to memory.
    fn store_int(&mut self, base: Gpr, disp: i32, src: Gpr, bytes: u32) {
        match bytes {
            8 => self.store64(base, disp, src),
            4 => self.rm(None, false, &[0x89], src as u8, base, disp),
            2 => self.rm(Some(0x66), false, &[0x89], src as u8, base, disp),
            _ => {
                // a byte store of rsi / rdi needs a REX to name sil / dil; the scratch registers are rax / rcx / rdx
                self.rm(None, false, &[0x88], src as u8, base, disp);
            }
        }
    }

    /// `mov r64, imm64`; gives the offset of the immediate.
    fn mov_imm64(&mut self, dst: Gpr, imm: u64) -> usize {
        self.rex(true, false, dst.high());
        self.byte(0xb8 + dst.low());
        let at = self.here();
        self.bytes(&imm.to_le_bytes());
        at
    }

    /// `mov dst, src` (64-bit)
    fn mov_rr(&mut self, dst: Gpr, src: Gpr) {
        self.rr(None, true, &[0x89], src as u8, dst as u8);
    }

    /// `movsd xmm, [base + disp]`
    fn movsd_load(&mut self, xmm: u8, base: Gpr, disp: i32) {
        self.rm(Some(0xf2), false, &[0x0f, 0x10], xmm, base, disp);
    }

    /// `movsd [base + disp], xmm`
    fn movsd_store(&mut self, base: Gpr, disp: i32, xmm: u8) {
        self.rm(Some(0xf2), false, &[0x0f, 0x11], xmm, base, disp);
    }

    /// `setcc al` then `movzx eax, al`.
    fn setcc(&mut self, cc: u8) {
        self.bytes(&[0x0f, 0x90 | cc, 0xc0]);
        self.bytes(&[0x0f, 0xb6, 0xc0]);
    }

    /// `jcc rel32` / `jmp rel32` with a placeholder; gives the offset of the rel32.
    fn jump(&mut self, cc: Option<u8>) -> usize {
        match cc {
            Some(cc) => self.bytes(&[0x0f, 0x80 | cc]),
            None => self.byte(0xe9),
        }
        let at = self.here();
        self.bytes(&[0; 4]);
        at
    }

    fn patch(&mut self, at: usize, target: usize) {
        let rel = i32::try_from(target as i64 - (at as i64 + 4)).unwrap_or(i32::MAX);
        self.bytes[at..at + 4].copy_from_slice(&rel.to_le_bytes());
    }
}

/// Condition codes (the low nibble of `jcc` / `setcc`).
struct Cc;

impl Cc {
    const B: u8 = 0x2;
    const AE: u8 = 0x3;
    const E: u8 = 0x4;
    const NE: u8 = 0x5;
    const BE: u8 = 0x6;
    const A: u8 = 0x7;
    const P: u8 = 0xa;
    const NP: u8 = 0xb;
    const L: u8 = 0xc;
    const GE: u8 = 0xd;
    const LE: u8 = 0xe;
    const G: u8 = 0xf;
}

/// Where a value lives: its stack slot `[rbp + disp]`, or a register.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
enum Loc {
    Slot(i32),
    Gpr(Gpr),
    Xmm(u8),
}

/// The registers values are allocated to. `rax` / `rcx` / `rdx` and `xmm0` / `xmm1` stay scratch for the ops, the
/// argument registers (`rdi` … `r9`, `xmm0` … `xmm7`) stay free for calls.
struct Pool;

impl Pool {
    /// Callee-saved: a value in one lives across calls (the prologue saves the ones used).
    const SAVED: [Gpr; 5] = [Gpr::Rbx, Gpr::R12, Gpr::R13, Gpr::R14, Gpr::R15];
    /// Caller-saved, not an argument register: only for values not live across a call.
    const SCRATCH: [Gpr; 2] = [Gpr::R10, Gpr::R11];
    /// Caller-saved float registers past the argument ones: only for values not live across a call.
    const XMM: [u8; 8] = [8, 9, 10, 11, 12, 13, 14, 15];
}

/// One value's live range over the function's ops in block order (inclusive positions).
#[derive(Clone, Copy, Debug)]
struct Interval {
    value: ValueId,
    lo: u32,
    hi: u32,
    float: bool,
    /// A call lies strictly inside: caller-saved registers do not survive it
    across_call: bool,
}

/// One function being lowered.
struct Lower<'b, 'a> {
    body: &'b Body<'a>,
    asm: Asm,
    /// Each value's location.
    slots: BTreeMap<ValueId, Loc>,
    /// The callee-saved registers used, with the slot each is saved in.
    saved: Vec<(Gpr, i32)>,
    /// The scratch area for parallel copies (block arguments).
    scratch: i32,
    frame: i32,
    blocks: BTreeMap<BlockId, usize>,
    /// Jumps to blocks not placed yet: (rel32 offset, block).
    fixups: Vec<(usize, BlockId)>,
    relocs: Vec<X86_64Reloc>,
}

impl X86_64Code {
    /// Function `f` (an `llvm.func` with a body).
    pub fn of(body: &Body<'_>, f: OpId) -> Result<X86_64Code, Error> {
        let name = body[f].get_str("sym_name").ok_or_else(|| Error("x86-64: a function without a name".into()))?.to_string();
        let mut lower = Lower::new(body, f).map_err(|e| Error(format!("x86-64: @{name}: {}", e.0)))?;
        lower.function(f).map_err(|e| Error(format!("x86-64: @{name}: {}", e.0)))?;
        Ok(X86_64Code { name, bytes: lower.asm.bytes, relocs: lower.relocs })
    }
}

impl<'b, 'a> Lower<'b, 'a> {
    /// Every value's location (linear scan over live intervals), the saved registers' slots, the scratch area.
    fn new(body: &'b Body<'a>, f: OpId) -> Result<Self, Error> {
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
        let intervals = Self::intervals(body, &blocks)?;
        let (mut slots, used) = Self::allocate(&intervals);
        // stack: the saved registers, then the spilled values, then the scratch area
        let mut next = 0i32;
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
        let scratch = next - 8 * i32::try_from(widest_copy).unwrap_or(0);
        // 16-byte aligned below the saved rbp (rsp is 16-aligned after `push rbp`)
        let frame = (-scratch + 15) & !15;
        Ok(Lower { body, asm: Asm::default(), slots, saved, scratch, frame, blocks: BTreeMap::new(), fixups: Vec::new(), relocs: Vec::new() })
    }

    /// Each value's live interval: positions are the ops in block order (a block's arguments at its first position);
    /// a value live into or out of a block covers the whole block (block-level liveness, solved to a fixed point).
    fn intervals(body: &Body<'_>, blocks: &[BlockId]) -> Result<Vec<Interval>, Error> {
        use alloc::collections::BTreeSet;
        let mut pos = 0u32;
        let (mut start, mut end) = (BTreeMap::new(), BTreeMap::new());
        let mut def: BTreeMap<ValueId, u32> = BTreeMap::new();
        let mut last_use: BTreeMap<ValueId, u32> = BTreeMap::new();
        let mut calls = Vec::new();
        // per block: values used before any definition in it, values defined in it, its successors
        let mut gen_kill: Vec<(BTreeSet<ValueId>, BTreeSet<ValueId>, Vec<BlockId>)> = Vec::new();
        for &b in blocks {
            start.insert(b, pos);
            let (mut gen_, mut kill) = (BTreeSet::new(), BTreeSet::new());
            for &a in body[b].args.iter() {
                def.insert(a, pos);
                kill.insert(a);
            }
            let mut succ = Vec::new();
            for op in body.block_ops(b) {
                pos += 1;
                for &v in body[op].operands.iter() {
                    last_use.insert(v, pos);
                    if !kill.contains(&v) {
                        gen_.insert(v);
                    }
                }
                for &r in body[op].results.iter() {
                    def.insert(r, pos);
                    kill.insert(r);
                }
                if body[op].name == "llvm.call" {
                    calls.push(pos);
                }
                succ = body[op].successors.iter().copied().collect();
            }
            end.insert(b, pos);
            pos += 1;
            gen_kill.push((gen_, kill, succ));
        }
        let index: BTreeMap<BlockId, usize> = blocks.iter().enumerate().map(|(i, &b)| (b, i)).collect();
        let mut live_in: Vec<BTreeSet<ValueId>> = alloc::vec![BTreeSet::new(); blocks.len()];
        let mut live_out: Vec<BTreeSet<ValueId>> = alloc::vec![BTreeSet::new(); blocks.len()];
        loop {
            let mut changed = false;
            for i in (0..blocks.len()).rev() {
                let out: BTreeSet<ValueId> = gen_kill[i].2.iter().filter_map(|s| index.get(s)).flat_map(|&j| live_in[j].iter().copied()).collect();
                let inn: BTreeSet<ValueId> = gen_kill[i].0.iter().copied().chain(out.iter().filter(|v| !gen_kill[i].1.contains(v)).copied()).collect();
                if out != live_out[i] || inn != live_in[i] {
                    changed = true;
                    live_out[i] = out;
                    live_in[i] = inn;
                }
            }
            if !changed {
                break;
            }
        }
        let mut out = Vec::new();
        for (&value, &d) in &def {
            let (mut lo, mut hi) = (d, last_use.get(&value).copied().unwrap_or(d).max(d));
            for (i, &b) in blocks.iter().enumerate() {
                if live_in[i].contains(&value) {
                    lo = lo.min(start[&b]);
                    hi = hi.max(start[&b]);
                }
                if live_out[i].contains(&value) {
                    hi = hi.max(end[&b]);
                }
            }
            let float = matches!(Kind::of(&body[value].ty)?, Kind::F64);
            let across_call = calls.iter().any(|&c| lo < c && c < hi);
            out.push(Interval { value, lo, hi, float, across_call });
        }
        out.sort_by_key(|iv| (iv.lo, iv.hi));
        Ok(out)
    }

    /// Linear scan: each interval gets a free register of its class (none free: it stays in a stack slot). Gives
    /// the registers given and the callee-saved ones used.
    fn allocate(intervals: &[Interval]) -> (BTreeMap<ValueId, Loc>, Vec<Gpr>) {
        let mut locs = BTreeMap::new();
        let mut active: Vec<(u32, Loc)> = Vec::new();
        let mut used: Vec<Gpr> = Vec::new();
        for iv in intervals {
            active.retain(|&(hi, _)| hi >= iv.lo);
            let busy = |l: Loc| active.iter().any(|&(_, a)| a == l);
            let pick = if iv.float {
                if iv.across_call { None } else { Pool::XMM.iter().map(|&x| Loc::Xmm(x)).find(|&l| !busy(l)) }
            } else {
                let scratch = (!iv.across_call).then_some(Pool::SCRATCH.iter()).into_iter().flatten();
                scratch.chain(Pool::SAVED.iter()).map(|&r| Loc::Gpr(r)).find(|&l| !busy(l))
            };
            if let Some(l) = pick {
                if let Loc::Gpr(r) = l
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

    fn slot(&self, v: ValueId) -> Result<Loc, Error> {
        self.slots.get(&v).copied().ok_or_else(|| Error("a value defined outside the function".into()))
    }

    /// A value's 64 bits into general register `dst`.
    fn get64(&mut self, dst: Gpr, at: Loc) {
        match at {
            Loc::Slot(d) => self.asm.load64(dst, Gpr::Rbp, d),
            Loc::Gpr(r) if r == dst => {}
            Loc::Gpr(r) => self.asm.mov_rr(dst, r),
            // movq r64, xmm
            Loc::Xmm(x) => self.asm.rr(Some(0x66), true, &[0x0f, 0x7e], x, dst as u8),
        }
    }

    /// General register `src`'s 64 bits into a value's location.
    fn put64(&mut self, at: Loc, src: Gpr) {
        match at {
            Loc::Slot(d) => self.asm.store64(Gpr::Rbp, d, src),
            Loc::Gpr(r) if r == src => {}
            Loc::Gpr(r) => self.asm.mov_rr(r, src),
            // movq xmm, r64
            Loc::Xmm(x) => self.asm.rr(Some(0x66), true, &[0x0f, 0x6e], x, src as u8),
        }
    }

    /// A value's f64 into `xmm`.
    fn getsd(&mut self, xmm: u8, at: Loc) {
        match at {
            Loc::Slot(d) => self.asm.movsd_load(xmm, Gpr::Rbp, d),
            Loc::Xmm(x) if x == xmm => {}
            // movapd xmm, x
            Loc::Xmm(x) => self.asm.rr(Some(0x66), false, &[0x0f, 0x28], xmm, x),
            Loc::Gpr(r) => self.asm.rr(Some(0x66), true, &[0x0f, 0x6e], xmm, r as u8),
        }
    }

    /// `xmm`'s f64 into a value's location.
    fn putsd(&mut self, at: Loc, xmm: u8) {
        match at {
            Loc::Slot(d) => self.asm.movsd_store(Gpr::Rbp, d, xmm),
            Loc::Xmm(x) if x == xmm => {}
            Loc::Xmm(x) => self.asm.rr(Some(0x66), false, &[0x0f, 0x28], x, xmm),
            Loc::Gpr(r) => self.asm.rr(Some(0x66), true, &[0x0f, 0x7e], xmm, r as u8),
        }
    }

    /// `leave; ret`, the callee-saved registers restored first.
    fn epilogue(&mut self) {
        for &(r, at) in &self.saved.clone() {
            self.asm.load64(r, Gpr::Rbp, at);
        }
        self.asm.bytes(&[0xc9, 0xc3]);
    }

    fn kind(&self, v: ValueId) -> Result<Kind, Error> {
        Kind::of(&self.body[v].ty)
    }

    fn function(&mut self, f: OpId) -> Result<(), Error> {
        let body = self.body;
        let region = body[f].regions[0];
        let blocks: Vec<BlockId> = body[region].blocks.iter().copied().collect();
        // prologue
        self.asm.byte(0x55);
        self.asm.mov_rr(Gpr::Rbp, Gpr::Rsp);
        if self.frame > 0 {
            self.asm.bytes(&[0x48, 0x81, 0xec]);
            self.asm.bytes(&self.frame.to_le_bytes());
        }
        for &(r, at) in &self.saved.clone() {
            self.asm.store64(Gpr::Rbp, at, r);
        }
        // parameters into their slots
        let (mut ints, mut floats) = (0usize, 0u8);
        for &arg in body[blocks[0]].args.iter() {
            let at = self.slot(arg)?;
            match self.kind(arg)? {
                Kind::Int(_) => {
                    let r = *Gpr::ARGS.get(ints).ok_or_else(|| Error("more than six integer parameters".into()))?;
                    self.put64(at, r);
                    ints += 1;
                }
                Kind::F64 if floats < XMM_ARGS => {
                    self.putsd(at, floats);
                    floats += 1;
                }
                Kind::F64 => return Err(Error("more than eight float parameters".into())),
            }
        }
        for &block in &blocks {
            self.blocks.insert(block, self.asm.here());
            for op in body.block_ops(block) {
                self.op(op)?;
            }
        }
        for (at, block) in core::mem::take(&mut self.fixups) {
            let target = self.blocks[&block];
            self.asm.patch(at, target);
        }
        Ok(())
    }

    /// Operand `i` of `op`.
    fn operand(&self, op: OpId, i: usize) -> Result<ValueId, Error> {
        self.body[op].operands.get(i).copied().ok_or_else(|| Error(format!("{} needs operand {i}", self.body[op].name)))
    }

    fn result(&self, op: OpId) -> Result<(ValueId, Loc), Error> {
        let r = *self.body[op].results.first().ok_or_else(|| Error(format!("{} has no result", self.body[op].name)))?;
        Ok((r, self.slot(r)?))
    }

    /// An integer operand into `dst`, extended from its width.
    fn int(&mut self, dst: Gpr, v: ValueId, signed: bool) -> Result<u32, Error> {
        let Kind::Int(bits) = self.kind(v)? else { return Err(Error("an integer operand is a float".into())) };
        let at = self.slot(v)?;
        self.get64(dst, at);
        // narrow integers are kept zero-extended; a signed use sign-extends: shl then sar back
        if signed && bits < 64 {
            let k = u8::try_from(64 - bits).unwrap_or(0);
            self.asm.rr(None, true, &[0xc1], 4, dst as u8);
            self.asm.byte(k);
            self.asm.rr(None, true, &[0xc1], 7, dst as u8);
            self.asm.byte(k);
        }
        Ok(bits)
    }

    /// rax (a `bits`-wide result) into slot `at`, zero-extended.
    fn put_int(&mut self, at: Loc, bits: u32) {
        match bits {
            1 => self.asm.bytes(&[0x83, 0xe0, 0x01]),
            8 => self.asm.bytes(&[0x0f, 0xb6, 0xc0]),
            16 => self.asm.bytes(&[0x0f, 0xb7, 0xc0]),
            32 => self.asm.bytes(&[0x89, 0xc0]),
            _ => {}
        }
        self.put64(at, Gpr::Rax);
    }

    fn op(&mut self, op: OpId) -> Result<(), Error> {
        let body = self.body;
        let name: &str = &body[op].name;
        match name {
            "llvm.mlir.constant" => self.constant(op),
            "llvm.mlir.zero" | "llvm.mlir.undef" | "llvm.mlir.poison" => {
                let (_, at) = self.result(op)?;
                self.asm.bytes(&[0x31, 0xc0]);
                self.put64(at, Gpr::Rax);
                Ok(())
            }
            "llvm.add" | "llvm.sub" | "llvm.mul" | "llvm.and" | "llvm.or" | "llvm.xor" => self.int_binary(op, name),
            "llvm.shl" | "llvm.lshr" | "llvm.ashr" => self.shift(op, name),
            "llvm.sdiv" | "llvm.udiv" | "llvm.srem" | "llvm.urem" => self.divide(op, name),
            "llvm.icmp" => self.icmp(op),
            "llvm.fadd" | "llvm.fsub" | "llvm.fmul" | "llvm.fdiv" => self.float_binary(op, name),
            "llvm.fneg" => self.fneg(op),
            "llvm.fcmp" => self.fcmp(op),
            "llvm.select" => self.select(op),
            "llvm.zext" | "llvm.sext" | "llvm.trunc" | "llvm.ptrtoint" | "llvm.inttoptr" => self.int_cast(op, name == "llvm.sext"),
            "llvm.sitofp" | "llvm.uitofp" => self.int_to_float(op),
            "llvm.fptosi" | "llvm.fptoui" => self.float_to_int(op),
            "llvm.bitcast" => self.copy(op),
            "llvm.load" => self.load(op),
            "llvm.store" => self.store(op),
            "llvm.getelementptr" => self.gep(op),
            "llvm.call" => self.call(op),
            "llvm.br" => self.branch(op),
            "llvm.cond_br" => self.cond_branch(op),
            "llvm.return" => self.ret(op),
            "llvm.unreachable" => {
                self.asm.bytes(&[0x0f, 0x0b]);
                Ok(())
            }
            other => Err(Error(format!("{other} is not supported"))),
        }
    }

    fn constant(&mut self, op: OpId) -> Result<(), Error> {
        let (r, at) = self.result(op)?;
        let value = self.body[op].get("value").ok_or_else(|| Error("llvm.mlir.constant without a value".into()))?;
        let bits: u64 = match (value, self.kind(r)?) {
            (Attribute::Bool(b), _) => u64::from(*b),
            (Attribute::Float { lit, .. }, Kind::F64) => lit.parse::<f64>().map_err(|_| Error(format!("bad float {lit}")))?.to_bits(),
            // `0x…`: the bits as written (a float's sign bit included); decimal: a signed integer
            (Attribute::Int { lit, .. }, _) => match lit.strip_prefix("0x") {
                Some(h) => u64::from_str_radix(h, 16).map_err(|_| Error(format!("bad integer {lit}")))?,
                None => Attrs::as_int(value)?.cast_unsigned(),
            },
            (a, _) => return Err(Error(format!("constant {a} is not supported"))),
        };
        let bits = match self.kind(r)? {
            Kind::Int(w) if w < 64 => bits & ((1u64 << w) - 1),
            _ => bits,
        };
        self.asm.mov_imm64(Gpr::Rax, bits);
        self.put64(at, Gpr::Rax);
        Ok(())
    }

    fn int_binary(&mut self, op: OpId, name: &str) -> Result<(), Error> {
        let (_, at) = self.result(op)?;
        let bits = self.int(Gpr::Rax, self.operand(op, 0)?, false)?;
        self.int(Gpr::Rcx, self.operand(op, 1)?, false)?;
        let w = bits > 32;
        match name {
            "llvm.add" => self.asm.rr(None, w, &[0x01], Gpr::Rcx as u8, Gpr::Rax as u8),
            "llvm.sub" => self.asm.rr(None, w, &[0x29], Gpr::Rcx as u8, Gpr::Rax as u8),
            "llvm.and" => self.asm.rr(None, w, &[0x21], Gpr::Rcx as u8, Gpr::Rax as u8),
            "llvm.or" => self.asm.rr(None, w, &[0x09], Gpr::Rcx as u8, Gpr::Rax as u8),
            "llvm.xor" => self.asm.rr(None, w, &[0x31], Gpr::Rcx as u8, Gpr::Rax as u8),
            // imul rax, rcx
            _ => self.asm.rr(None, w, &[0x0f, 0xaf], Gpr::Rax as u8, Gpr::Rcx as u8),
        }
        self.put_int(at, bits);
        Ok(())
    }

    fn shift(&mut self, op: OpId, name: &str) -> Result<(), Error> {
        let (_, at) = self.result(op)?;
        let signed = name == "llvm.ashr";
        let bits = self.int(Gpr::Rax, self.operand(op, 0)?, signed)?;
        self.int(Gpr::Rcx, self.operand(op, 1)?, false)?;
        let ext = match name {
            "llvm.shl" => 4,
            "llvm.lshr" => 5,
            _ => 7,
        };
        // shl / shr / sar rax, cl (64-bit after the extension: the sign or zeros fill the high bits correctly)
        self.asm.rr(None, true, &[0xd3], ext, Gpr::Rax as u8);
        self.put_int(at, bits);
        Ok(())
    }

    fn divide(&mut self, op: OpId, name: &str) -> Result<(), Error> {
        let (_, at) = self.result(op)?;
        let signed = matches!(name, "llvm.sdiv" | "llvm.srem");
        let bits = self.int(Gpr::Rax, self.operand(op, 0)?, signed)?;
        self.int(Gpr::Rcx, self.operand(op, 1)?, signed)?;
        if signed {
            // cqo; idiv rcx
            self.asm.bytes(&[0x48, 0x99]);
            self.asm.rr(None, true, &[0xf7], 7, Gpr::Rcx as u8);
        } else {
            // xor edx, edx; div rcx
            self.asm.bytes(&[0x31, 0xd2]);
            self.asm.rr(None, true, &[0xf7], 6, Gpr::Rcx as u8);
        }
        if matches!(name, "llvm.srem" | "llvm.urem") {
            self.asm.mov_rr(Gpr::Rax, Gpr::Rdx);
        }
        self.put_int(at, bits);
        Ok(())
    }

    fn icmp(&mut self, op: OpId) -> Result<(), Error> {
        let (_, at) = self.result(op)?;
        let pred = self.body.head::<ICmpOp>(op)?.predicate;
        let signed = matches!(pred, ICmpPredicate::Slt | ICmpPredicate::Sle | ICmpPredicate::Sgt | ICmpPredicate::Sge);
        self.int(Gpr::Rax, self.operand(op, 0)?, signed)?;
        self.int(Gpr::Rcx, self.operand(op, 1)?, signed)?;
        // cmp rax, rcx (both extended to 64 bits)
        self.asm.rr(None, true, &[0x39], Gpr::Rcx as u8, Gpr::Rax as u8);
        let cc = match pred {
            ICmpPredicate::Eq => Cc::E,
            ICmpPredicate::Ne => Cc::NE,
            ICmpPredicate::Slt => Cc::L,
            ICmpPredicate::Sle => Cc::LE,
            ICmpPredicate::Sgt => Cc::G,
            ICmpPredicate::Sge => Cc::GE,
            ICmpPredicate::Ult => Cc::B,
            ICmpPredicate::Ule => Cc::BE,
            ICmpPredicate::Ugt => Cc::A,
            ICmpPredicate::Uge => Cc::AE,
        };
        self.asm.setcc(cc);
        self.put_int(at, 1);
        Ok(())
    }

    /// Two f64 operands into xmm0 / xmm1.
    fn floats(&mut self, a: ValueId, b: ValueId) -> Result<(), Error> {
        let (sa, sb) = (self.slot(a)?, self.slot(b)?);
        self.getsd(0, sa);
        self.getsd(1, sb);
        Ok(())
    }

    fn float_binary(&mut self, op: OpId, name: &str) -> Result<(), Error> {
        let (_, at) = self.result(op)?;
        self.floats(self.operand(op, 0)?, self.operand(op, 1)?)?;
        let code = match name {
            "llvm.fadd" => 0x58,
            "llvm.fmul" => 0x59,
            "llvm.fsub" => 0x5c,
            _ => 0x5e,
        };
        // addsd / mulsd / subsd / divsd xmm0, xmm1
        self.asm.rr(Some(0xf2), false, &[0x0f, code], 0, 1);
        self.putsd(at, 0);
        Ok(())
    }

    fn fneg(&mut self, op: OpId) -> Result<(), Error> {
        let (_, at) = self.result(op)?;
        let src = self.slot(self.operand(op, 0)?)?;
        self.get64(Gpr::Rax, src);
        self.asm.mov_imm64(Gpr::Rcx, 1 << 63);
        self.asm.rr(None, true, &[0x31], Gpr::Rcx as u8, Gpr::Rax as u8);
        self.put64(at, Gpr::Rax);
        Ok(())
    }

    fn fcmp(&mut self, op: OpId) -> Result<(), Error> {
        let (_, at) = self.result(op)?;
        let pred = self.body.head::<FCmpOp>(op)?.predicate;
        let (a, b) = (self.operand(op, 0)?, self.operand(op, 1)?);
        // ucomisd x, y: x > y ⇒ CF = ZF = 0; x < y ⇒ CF = 1; x = y ⇒ ZF = 1; unordered ⇒ ZF = PF = CF = 1
        let (swap, cc, extra) = match pred {
            FCmpPredicate::False => (false, None, None),
            FCmpPredicate::True => (false, None, Some(true)),
            FCmpPredicate::Ogt => (false, Some(Cc::A), None),
            FCmpPredicate::Oge => (false, Some(Cc::AE), None),
            FCmpPredicate::Olt => (true, Some(Cc::A), None),
            FCmpPredicate::Ole => (true, Some(Cc::AE), None),
            FCmpPredicate::Ugt => (true, Some(Cc::B), None),
            FCmpPredicate::Uge => (true, Some(Cc::BE), None),
            FCmpPredicate::Ult => (false, Some(Cc::B), None),
            FCmpPredicate::Ule => (false, Some(Cc::BE), None),
            FCmpPredicate::One => (false, Some(Cc::NE), None),
            FCmpPredicate::Ueq => (false, Some(Cc::E), None),
            FCmpPredicate::Ord => (false, Some(Cc::NP), None),
            FCmpPredicate::Uno => (false, Some(Cc::P), None),
            FCmpPredicate::Oeq | FCmpPredicate::Une => (false, None, None),
        };
        if let Some(c) = extra {
            self.asm.mov_imm64(Gpr::Rax, u64::from(c));
            self.put64(at, Gpr::Rax);
            return Ok(());
        }
        let (x, y) = if swap { (b, a) } else { (a, b) };
        self.floats(x, y)?;
        // ucomisd xmm0, xmm1
        self.asm.rr(Some(0x66), false, &[0x0f, 0x2e], 0, 1);
        match (pred, cc) {
            (FCmpPredicate::Oeq, _) => {
                // sete al; setnp cl; and al, cl
                self.asm.bytes(&[0x0f, 0x94, 0xc0, 0x0f, 0x9b, 0xc1, 0x20, 0xc8, 0x0f, 0xb6, 0xc0]);
            }
            (FCmpPredicate::Une, _) => {
                // setne al; setp cl; or al, cl
                self.asm.bytes(&[0x0f, 0x95, 0xc0, 0x0f, 0x9a, 0xc1, 0x08, 0xc8, 0x0f, 0xb6, 0xc0]);
            }
            (_, Some(cc)) => self.asm.setcc(cc),
            (_, None) => self.asm.bytes(&[0x31, 0xc0]),
        }
        self.put_int(at, 1);
        Ok(())
    }

    fn select(&mut self, op: OpId) -> Result<(), Error> {
        let (_, at) = self.result(op)?;
        let (c, t, f) = (self.slot(self.operand(op, 0)?)?, self.slot(self.operand(op, 1)?)?, self.slot(self.operand(op, 2)?)?);
        // rax = false value; if cond != 0: rax = true value (bit patterns, so floats too)
        self.get64(Gpr::Rax, f);
        self.get64(Gpr::Rcx, t);
        self.get64(Gpr::Rdx, c);
        // test edx, edx; cmovne rax, rcx
        self.asm.bytes(&[0x85, 0xd2]);
        self.asm.rr(None, true, &[0x0f, 0x45], Gpr::Rax as u8, Gpr::Rcx as u8);
        self.put64(at, Gpr::Rax);
        Ok(())
    }

    fn int_cast(&mut self, op: OpId, signed: bool) -> Result<(), Error> {
        let (r, at) = self.result(op)?;
        self.int(Gpr::Rax, self.operand(op, 0)?, signed)?;
        let Kind::Int(bits) = self.kind(r)? else { return Err(Error("an integer cast to a float".into())) };
        self.put_int(at, bits);
        Ok(())
    }

    fn copy(&mut self, op: OpId) -> Result<(), Error> {
        let (_, at) = self.result(op)?;
        let src = self.slot(self.operand(op, 0)?)?;
        self.get64(Gpr::Rax, src);
        self.put64(at, Gpr::Rax);
        Ok(())
    }

    fn int_to_float(&mut self, op: OpId) -> Result<(), Error> {
        let (_, at) = self.result(op)?;
        let signed = self.body[op].name == "llvm.sitofp";
        self.int(Gpr::Rax, self.operand(op, 0)?, signed)?;
        // cvtsi2sd xmm0, rax (an unsigned 64-bit above 2^63 is not handled)
        self.asm.rr(Some(0xf2), true, &[0x0f, 0x2a], 0, Gpr::Rax as u8);
        self.putsd(at, 0);
        Ok(())
    }

    fn float_to_int(&mut self, op: OpId) -> Result<(), Error> {
        let (r, at) = self.result(op)?;
        let src = self.slot(self.operand(op, 0)?)?;
        self.getsd(0, src);
        // cvttsd2si rax, xmm0
        self.asm.rr(Some(0xf2), true, &[0x0f, 0x2c], Gpr::Rax as u8, 0);
        let Kind::Int(bits) = self.kind(r)? else { return Err(Error("a float cast to a float".into())) };
        self.put_int(at, bits);
        Ok(())
    }

    fn load(&mut self, op: OpId) -> Result<(), Error> {
        let (r, at) = self.result(op)?;
        let ptr = self.slot(self.operand(op, 0)?)?;
        self.get64(Gpr::Rcx, ptr);
        match self.kind(r)? {
            Kind::Int(bits) => self.asm.load_int(Gpr::Rax, Gpr::Rcx, 0, bits.max(8).next_power_of_two(), false),
            Kind::F64 => self.asm.load64(Gpr::Rax, Gpr::Rcx, 0),
        }
        self.put64(at, Gpr::Rax);
        Ok(())
    }

    fn store(&mut self, op: OpId) -> Result<(), Error> {
        let (v, p) = (self.operand(op, 0)?, self.operand(op, 1)?);
        let bytes = Kind::size(&self.body[v].ty)?;
        let (sv, sp) = (self.slot(v)?, self.slot(p)?);
        self.get64(Gpr::Rax, sv);
        self.get64(Gpr::Rcx, sp);
        self.asm.store_int(Gpr::Rcx, 0, Gpr::Rax, bytes);
        Ok(())
    }

    /// `getelementptr base[index]` over a scalar element type: base + index × size.
    fn gep(&mut self, op: OpId) -> Result<(), Error> {
        let (_, at) = self.result(op)?;
        let elem = match self.body[op].get("elem_type") {
            Some(Attribute::Type(t)) => t.clone(),
            _ => return Err(Error("getelementptr without an element type".into())),
        };
        let size = i64::from(Kind::size(&elem).map_err(|_| Error(format!("getelementptr over {elem} is not supported")))?);
        let raw: Vec<i64> = match self.body[op].get("rawConstantIndices") {
            Some(Attribute::DenseArray { values, .. }) => values.iter().map(|v| v.parse::<i64>().map_err(|_| Error(format!("bad index {v}")))).collect::<Result<_, _>>()?,
            _ => return Err(Error("getelementptr without indices".into())),
        };
        let [index] = raw[..] else { return Err(Error("getelementptr with more than one index is not supported".into())) };
        let base = self.slot(self.operand(op, 0)?)?;
        self.get64(Gpr::Rax, base);
        /// `rawConstantIndices`' marker of a dynamic index
        const DYNAMIC: i64 = i32::MIN as i64;
        if index == DYNAMIC {
            self.int(Gpr::Rcx, self.operand(op, 1)?, true)?;
            // imul rcx, rcx, size; add rax, rcx
            self.asm.rr(None, true, &[0x69], Gpr::Rcx as u8, Gpr::Rcx as u8);
            self.asm.bytes(&i32::try_from(size).unwrap_or(1).to_le_bytes());
        } else {
            self.asm.mov_imm64(Gpr::Rcx, (index * size).cast_unsigned());
        }
        self.asm.rr(None, true, &[0x01], Gpr::Rcx as u8, Gpr::Rax as u8);
        self.put64(at, Gpr::Rax);
        Ok(())
    }

    fn call(&mut self, op: OpId) -> Result<(), Error> {
        let callee = match self.body[op].get("callee") {
            Some(a) => Attrs::as_symbol(a)?.to_string(),
            None => return Err(Error("an indirect call is not supported".into())),
        };
        let (mut ints, mut floats) = (0usize, 0u8);
        let args: Vec<ValueId> = self.body[op].operands.iter().copied().collect();
        for v in args {
            let at = self.slot(v)?;
            match self.kind(v)? {
                Kind::Int(_) => {
                    let r = *Gpr::ARGS.get(ints).ok_or_else(|| Error("a call with more than six integer arguments".into()))?;
                    self.get64(r, at);
                    ints += 1;
                }
                Kind::F64 if floats < XMM_ARGS => {
                    self.getsd(floats, at);
                    floats += 1;
                }
                Kind::F64 => return Err(Error("a call with more than eight float arguments".into())),
            }
        }
        let offset = self.asm.mov_imm64(Gpr::Rax, 0);
        self.relocs.push(X86_64Reloc { offset, symbol: callee });
        // call rax
        self.asm.bytes(&[0xff, 0xd0]);
        if let Some(&r) = self.body[op].results.first() {
            let at = self.slot(r)?;
            match self.kind(r)? {
                Kind::Int(bits) => self.put_int(at, bits),
                Kind::F64 => self.putsd(at, 0),
            }
        }
        Ok(())
    }

    /// Block arguments of a jump: the operands into the scratch area, then into the arguments (a parallel copy).
    fn pass(&mut self, values: &[ValueId], to: BlockId) -> Result<(), Error> {
        let args: Vec<ValueId> = self.body[to].args.iter().copied().collect();
        if args.len() != values.len() {
            return Err(Error("a jump with the wrong number of block arguments".into()));
        }
        for (i, &v) in (0i32..).zip(values) {
            let s = self.slot(v)?;
            self.get64(Gpr::Rax, s);
            self.asm.store64(Gpr::Rbp, self.scratch + 8 * i, Gpr::Rax);
        }
        for (i, &a) in (0i32..).zip(&args) {
            let d = self.slot(a)?;
            self.asm.load64(Gpr::Rax, Gpr::Rbp, self.scratch + 8 * i);
            self.put64(d, Gpr::Rax);
        }
        Ok(())
    }

    fn jump_to(&mut self, cc: Option<u8>, to: BlockId) {
        let at = self.asm.jump(cc);
        self.fixups.push((at, to));
    }

    fn branch(&mut self, op: OpId) -> Result<(), Error> {
        let to = *self.body[op].successors.first().ok_or_else(|| Error("llvm.br without a successor".into()))?;
        let values: Vec<ValueId> = self.body[op].operands.iter().copied().collect();
        self.pass(&values, to)?;
        self.jump_to(None, to);
        Ok(())
    }

    fn cond_branch(&mut self, op: OpId) -> Result<(), Error> {
        let succ: Vec<BlockId> = self.body[op].successors.iter().copied().collect();
        let [t, f] = succ[..] else { return Err(Error("llvm.cond_br needs two successors".into())) };
        let sizes: Vec<usize> = match self.body[op].get("operandSegmentSizes") {
            Some(Attribute::DenseArray { values, .. }) => values.iter().map(|v| v.parse::<usize>().unwrap_or(0)).collect(),
            _ => alloc::vec![1, 0, 0],
        };
        let ops: Vec<ValueId> = self.body[op].operands.iter().copied().collect();
        let (nt, nf) = (sizes.get(1).copied().unwrap_or(0), sizes.get(2).copied().unwrap_or(0));
        let cond = self.slot(ops[0])?;
        self.get64(Gpr::Rax, cond);
        // test eax, eax; je false-side
        self.asm.bytes(&[0x85, 0xc0]);
        let to_false = self.asm.jump(Some(Cc::E));
        self.pass(&ops[1..=nt], t)?;
        self.jump_to(None, t);
        let here = self.asm.here();
        self.asm.patch(to_false, here);
        self.pass(&ops[1 + nt..1 + nt + nf], f)?;
        self.jump_to(None, f);
        Ok(())
    }

    fn ret(&mut self, op: OpId) -> Result<(), Error> {
        if let Some(&v) = self.body[op].operands.first() {
            let at = self.slot(v)?;
            match self.kind(v)? {
                Kind::Int(_) => self.get64(Gpr::Rax, at),
                Kind::F64 => self.getsd(0, at),
            }
        }
        self.epilogue();
        Ok(())
    }
}
