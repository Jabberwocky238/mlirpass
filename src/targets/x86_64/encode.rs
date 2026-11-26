//! Legacy x86 encoding, as `X86MCCodeEmitter` writes an instruction from its `TSFlags`: prefixes,
//! REX, the opcode map, the opcode, ModRM / SIB / displacement, immediates.

use alloc::vec::Vec;

use super::isel::{Encoding, Form, ImmT, Map, OpSize, Opcode, Prefix, Reg};
use crate::targets::OperandKind;

/// `X86::CondCode`.
#[allow(dead_code)]
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
#[repr(u8)]
pub enum Cc {
    O = 0,
    No = 1,
    B = 2,
    Ae = 3,
    E = 4,
    Ne = 5,
    Be = 6,
    A = 7,
    S = 8,
    Ns = 9,
    P = 10,
    Np = 11,
    L = 12,
    Ge = 13,
    Le = 14,
    G = 15,
}

/// `base + index * scale + disp`; `wide` keeps a four-byte displacement (a hole patched later).
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct Mem {
    pub base: Reg,
    pub index: Option<(Reg, u8)>,
    pub disp: i32,
    pub wide: bool,
}

impl Mem {
    pub const fn at(base: Reg, disp: i32) -> Mem {
        Mem { base, index: None, disp, wide: false }
    }

    pub const fn wide(base: Reg, disp: i32) -> Mem {
        Mem { base, index: None, disp, wide: true }
    }
}

/// An instruction operand, in the instruction's order (outs, then ins).
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum X {
    R(Reg),
    I(i64),
    M(Mem),
    /// A pc-relative target, patched once known.
    Rel,
    C(Cc),
}

/// Where an encoded instruction's patchable fields are.
#[derive(Clone, Copy, Debug, Default, PartialEq, Eq)]
pub struct Placed {
    pub imm: Option<usize>,
    pub disp: Option<usize>,
}

#[derive(Default)]
pub struct Asm {
    pub bytes: Vec<u8>,
}

/// ModRM `mod`: register direct, memory with no / one-byte / four-byte displacement.
struct Mod;

impl Mod {
    const MEM: u8 = 0b00;
    const DISP8: u8 = 0b01;
    const DISP32: u8 = 0b10;
    const REG: u8 = 0b11;
}

const REX: u8 = 0x40;
const REX_W: u8 = 0x08;
const REX_R: u8 = 0x04;
const REX_X: u8 = 0x02;
const REX_B: u8 = 0x01;
const OPSIZE_PREFIX: u8 = 0x66;
/// Mandatory prefixes: `66`, `f3`, `f2`.
const PREFIX_PD: u8 = 0x66;
const PREFIX_XS: u8 = 0xf3;
const PREFIX_XD: u8 = 0xf2;
const ESCAPE: u8 = 0x0f;
/// The SIB byte for `[rsp]` / `[r12]` with no index.
const SIB_NO_INDEX: u8 = 0x24;
/// The low three bits of `rsp` / `r12` (a SIB follows) and `rbp` / `r13` (no plain `[base]`).
const RM_SIB: u8 = 4;
const RM_DISP32: u8 = 5;

impl Reg {
    pub fn code(self) -> u8 {
        Reg::ENCODINGS[self as usize]
    }

    fn low(self) -> u8 {
        self.code() & 7
    }

    fn high(self) -> bool {
        self.code() >= 8
    }

    /// `spl` / `bpl` / `sil` / `dil`: only with a REX prefix.
    fn wants_rex(self) -> bool {
        matches!(self, Reg::SPL | Reg::BPL | Reg::SIL | Reg::DIL)
    }

    pub fn unit(self) -> Reg {
        Reg::UNITS[self as usize]
    }
}

impl Opcode {
    pub fn desc<'t>(self) -> &'t super::isel::Desc<'t> {
        &Opcode::DESCS[self as usize]
    }

    pub fn name<'t>(self) -> &'t str {
        Opcode::NAMES[self as usize]
    }

    /// `X86II::getOperandBias`: the first operand encoded, past a destination tied to the source.
    fn bias(self) -> usize {
        let tied = self.desc().tied;
        if tied.contains(&(1, 0)) {
            if tied.contains(&(3, 1)) && tied.contains(&(2, 0)) { 2 } else { 1 }
        } else {
            0
        }
    }
}

impl Asm {
    pub fn here(&self) -> usize {
        self.bytes.len()
    }

    fn byte(&mut self, b: u8) {
        self.bytes.push(b);
    }

    fn le(&mut self, v: i64, n: usize) {
        self.bytes.extend_from_slice(&v.to_le_bytes()[..n]);
    }

    /// Encodes `op` with its operands; panics on a pseudo instruction or operands that do not fit
    /// it (the selector's mistake, not the input's).
    pub fn inst(&mut self, op: Opcode, ops: &[X]) -> Placed {
        let desc = op.desc();
        let e: Encoding = desc.encoding.unwrap_or_else(|| panic!("{} is a pseudo instruction", op.name()));
        assert_eq!(ops.len(), desc.operands.len(), "{}: operands", op.name());
        let mut c = op.bias();
        let cond = desc.operands.iter().position(|o| o.kind == OperandKind::Cond).map(|i| match ops[i] {
            X::C(cc) => cc as u8,
            x => panic!("{}: condition {x:?}", op.name()),
        });
        let reg = |x: X| match x {
            X::R(r) => r,
            x => panic!("{}: register expected, got {x:?}", op.name()),
        };
        // (reg field, rm: a register or memory) by form.
        let (field, rm): (Option<u8>, Option<X>) = match e.form {
            Form::RawFrm | Form::AddCCFrm => (None, None),
            Form::AddRegFrm => {
                c += 1;
                (None, None)
            }
            Form::MRMDestReg | Form::MRMDestMem => {
                let (rm, r) = (ops[c], reg(ops[c + 1]));
                c += 2;
                (Some(r.code()), Some(rm))
            }
            Form::MRMSrcReg | Form::MRMSrcMem | Form::MRMSrcRegCC | Form::MRMSrcMemCC => {
                let (r, rm) = (reg(ops[c]), ops[c + 1]);
                c += 2;
                (Some(r.code()), Some(rm))
            }
            Form::MRMXrCC | Form::MRMXmCC => {
                c += 1;
                (Some(0), Some(ops[c - 1]))
            }
            Form::MRM0r | Form::MRM1r | Form::MRM2r | Form::MRM3r | Form::MRM4r | Form::MRM5r | Form::MRM6r | Form::MRM7r | Form::MRM0m | Form::MRM1m | Form::MRM2m | Form::MRM3m | Form::MRM4m | Form::MRM5m | Form::MRM6m | Form::MRM7m => {
                c += 1;
                (Some(e.form.digit()), Some(ops[c - 1]))
            }
        };
        let regs = ops.iter().filter_map(|x| match x {
            X::R(r) => Some(*r),
            _ => None,
        });
        let mut rex = if e.rex_w { REX | REX_W } else { 0 };
        if regs.clone().any(Reg::wants_rex) {
            rex |= REX;
        }
        if field.is_some_and(|f| f >= 8) {
            rex |= REX | REX_R;
        }
        match rm {
            Some(X::R(r)) if r.high() => rex |= REX | REX_B,
            Some(X::M(m)) => {
                if m.base.high() {
                    rex |= REX | REX_B;
                }
                if m.index.is_some_and(|(i, _)| i.high()) {
                    rex |= REX | REX_X;
                }
            }
            _ => {}
        }
        if e.form == Form::AddRegFrm && reg(ops[c - 1]).high() {
            rex |= REX | REX_B;
        }
        if e.opsize == OpSize::OpSize16 {
            self.byte(OPSIZE_PREFIX);
        }
        match e.prefix {
            Prefix::NoPrfx => {}
            Prefix::PD => self.byte(PREFIX_PD),
            Prefix::XS => self.byte(PREFIX_XS),
            Prefix::XD => self.byte(PREFIX_XD),
        }
        if rex != 0 {
            self.byte(rex);
        }
        if e.map == Map::TB {
            self.byte(ESCAPE);
        }
        let opcode = match e.form {
            Form::AddRegFrm => e.opcode | reg(ops[c - 1]).low(),
            Form::AddCCFrm | Form::MRMXrCC | Form::MRMSrcRegCC | Form::MRMXmCC | Form::MRMSrcMemCC => e.opcode | cond.unwrap_or(0),
            _ => e.opcode,
        };
        self.byte(opcode);
        let mut placed = Placed::default();
        if let (Some(f), Some(rm)) = (field, rm) {
            let f = (f & 7) << 3;
            match rm {
                X::R(r) => self.byte(Mod::REG << 6 | f | r.low()),
                X::M(m) => placed.disp = self.modrm_mem(f, m),
                x => panic!("{}: r/m {x:?}", op.name()),
            }
        }
        let size = match e.imm {
            ImmT::NoImm => 0,
            ImmT::Imm8 | ImmT::Imm8PCRel => 1,
            ImmT::Imm16 => 2,
            ImmT::Imm32 | ImmT::Imm32S | ImmT::Imm32PCRel => 4,
            ImmT::Imm64 => 8,
        };
        if size > 0 {
            let x = ops[c..].iter().find(|x| !matches!(x, X::C(_))).copied().unwrap_or_else(|| panic!("{}: immediate", op.name()));
            placed.imm = Some(self.here());
            match x {
                X::I(v) => self.le(v, size),
                X::Rel => self.le(0, size),
                x => panic!("{}: immediate {x:?}", op.name()),
            }
        }
        placed
    }

    fn modrm_mem(&mut self, field: u8, m: Mem) -> Option<usize> {
        let base = m.base.low();
        let md = if m.wide || i8::try_from(m.disp).is_err() {
            Mod::DISP32
        } else if m.disp == 0 && base != RM_DISP32 {
            Mod::MEM
        } else {
            Mod::DISP8
        };
        match m.index {
            Some((index, scale)) => {
                self.byte(md << 6 | field | RM_SIB);
                let ss = u8::try_from(scale.trailing_zeros()).unwrap_or(0) & 3;
                self.byte(ss << 6 | index.low() << 3 | base);
            }
            None => {
                self.byte(md << 6 | field | base);
                if base == RM_SIB {
                    self.byte(SIB_NO_INDEX);
                }
            }
        }
        match md {
            Mod::DISP8 => {
                self.le(m.disp.into(), 1);
                None
            }
            Mod::DISP32 => {
                let at = self.here();
                self.le(m.disp.into(), 4);
                Some(at)
            }
            _ => None,
        }
    }

    /// The next instruction's position minus the end of the field at `at` (`width` bytes).
    pub fn patch(&mut self, at: usize, width: usize, target: usize) {
        let rel = target as i64 - (at + width) as i64;
        self.bytes[at..at + width].copy_from_slice(&rel.to_le_bytes()[..width]);
    }
}

impl Form {
    /// The ModRM reg field an `MRM<n>r` / `MRM<n>m` form fixes.
    const fn digit(self) -> u8 {
        match self {
            Form::MRM0r | Form::MRM0m => 0,
            Form::MRM1r | Form::MRM1m => 1,
            Form::MRM2r | Form::MRM2m => 2,
            Form::MRM3r | Form::MRM3m => 3,
            Form::MRM4r | Form::MRM4m => 4,
            Form::MRM5r | Form::MRM5m => 5,
            Form::MRM6r | Form::MRM6m => 6,
            Form::MRM7r | Form::MRM7m => 7,
            _ => panic!("not an MRM<n>r form"),
        }
    }
}
