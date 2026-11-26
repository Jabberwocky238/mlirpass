//! AArch64 encoding, as `AArch64MCCodeEmitter` writes an instruction: its fixed bits and each
//! operand's value (`EncoderMethod`) placed where `Inst` says.

use alloc::vec::Vec;

use super::isel::{Encoder, Encoding, Opcode, Reg};

/// `AArch64CC::CondCode`.
#[allow(dead_code)]
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
#[repr(u8)]
pub enum Cond {
    Eq = 0,
    Ne = 1,
    Hs = 2,
    Lo = 3,
    Mi = 4,
    Pl = 5,
    Vs = 6,
    Vc = 7,
    Hi = 8,
    Ls = 9,
    Ge = 10,
    Lt = 11,
    Gt = 12,
    Le = 13,
}

impl Cond {
    /// `AArch64CC::getInvertedCondCode`.
    pub const fn invert(self) -> Cond {
        match self {
            Cond::Eq => Cond::Ne,
            Cond::Ne => Cond::Eq,
            Cond::Hs => Cond::Lo,
            Cond::Lo => Cond::Hs,
            Cond::Mi => Cond::Pl,
            Cond::Pl => Cond::Mi,
            Cond::Vs => Cond::Vc,
            Cond::Vc => Cond::Vs,
            Cond::Hi => Cond::Ls,
            Cond::Ls => Cond::Hi,
            Cond::Ge => Cond::Lt,
            Cond::Lt => Cond::Ge,
            Cond::Gt => Cond::Le,
            Cond::Le => Cond::Gt,
        }
    }
}

/// An instruction operand, in the instruction's order (outs, then ins).
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum A {
    R(Reg),
    /// An immediate as the machine instruction holds it (a scaled offset, a shift amount).
    I(i64),
    /// A pc-relative target, patched once known.
    Rel,
}

/// Where a pc-relative field went: the instruction and the field's bits.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct Placed {
    pub at: usize,
    pub field: Option<(u8, u8)>,
}

#[derive(Default)]
pub struct Asm {
    pub bytes: Vec<u8>,
}

impl Reg {
    pub fn code(self) -> u32 {
        Reg::ENCODINGS[self as usize].into()
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
}

impl Encoder {
    /// The operand's encoded value (`getAddSubImmOpValue` with no shift, a scaled offset, a
    /// move-wide chunk, a memory extend: the immediate as it is; a target: words, patched).
    fn value(self, a: A) -> u32 {
        match a {
            A::R(r) => r.code(),
            A::I(v) => v as u32,
            A::Rel => 0,
        }
    }

    fn pc_relative(self) -> bool {
        matches!(self, Encoder::GetBranchTargetOpValue | Encoder::GetCondBranchTargetOpValue | Encoder::GetLoadLiteralOpValue)
    }
}

impl Asm {
    pub fn here(&self) -> usize {
        self.bytes.len()
    }

    pub fn word(&mut self, w: u32) {
        self.bytes.extend_from_slice(&w.to_le_bytes());
    }

    /// Encodes `op`; panics on a pseudo instruction or operands that do not fit it.
    pub fn inst(&mut self, op: Opcode, ops: &[A]) -> Placed {
        let desc = op.desc();
        let e: Encoding = desc.encoding.unwrap_or_else(|| panic!("{} is a pseudo instruction", op.name()));
        assert_eq!(ops.len(), desc.operands.len(), "{}: operands", op.name());
        let mut w = e.bits;
        let mut field = None;
        for f in e.fields {
            let o = desc.operands[usize::from(f.operand)];
            let v = o.encoder.value(ops[usize::from(f.operand)]);
            let mask = if f.width >= 32 { u32::MAX } else { (1u32 << f.width) - 1 };
            w |= ((v >> f.from) & mask) << f.at;
            if o.encoder.pc_relative() && ops[usize::from(f.operand)] == A::Rel {
                field = Some((f.at, f.width));
            }
        }
        let at = self.here();
        self.word(w);
        Placed { at, field }
    }

    /// Points the pc-relative field of the instruction `p` at `target`.
    pub fn patch(&mut self, p: Placed, target: usize) {
        let Some((lo, width)) = p.field else { return };
        let words = (target as i64 - p.at as i64) / 4;
        let mask = (1u32 << width) - 1;
        let mut w = u32::from_le_bytes([self.bytes[p.at], self.bytes[p.at + 1], self.bytes[p.at + 2], self.bytes[p.at + 3]]);
        w = (w & !(mask << lo)) | ((words as u32 & mask) << lo);
        self.bytes[p.at..p.at + 4].copy_from_slice(&w.to_le_bytes());
    }
}
