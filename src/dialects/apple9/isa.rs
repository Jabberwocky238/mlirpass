//! ⭐ Apple9 instructions (the GPU of Apple M3 / M4; on an M4, Metal's `applegpu_g16g`): `apple9.<form> {...}` ⇒
//! their bytes ([`Apple9Isa`]).
//!
//! There is no Mesa model of this generation. Each form is packed as GravityLinux Mesa's Apple9 backend packs it
//! (src/asahi/compiler/agx_apple9_ir.c, MIT: the function named on each form), and every form here ran on an M4
//! through Metal (scripts/apple9_metal.swift: the code put into a binary archive's pipeline, run, read back): the
//! instruction set is not Apple's documentation, it is what the hardware did.
//!
//! An instruction's attributes are its fields; absent is zero / false:
//!
//! ```text
//!   dst, a, b, c         32-bit GPRs (r0 ..): the destination, the sources in order
//!   t, f                 a select's values (cond true, false)
//!   data, index          a store's first data register, a load's / store's index register
//!   wait                 the completion slots (1 ..= 6, a bit mask: slot k is bit k - 1) waited for first
//!   slot                 the slot a load completes on (1 ..= 6; 6 when absent)
//!   ...                  a form's own: `selector`, `value`, `cond`, `signed`, `binding`, `components`, `shift`, `offset`
//! ```
//!
//! Every source is retained (its release bit clear): a source released while still used reads back as zero, so a
//! release is the allocator's business (not done yet, nothing is released). Completions: a special register read
//! (`get_sr`, `get_sr16`) and a load complete on their `slot`, one slot to one pending result (`apple9-wait` picks
//! them); a reader waits first.

use alloc::format;
use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{Attribute, Error, NamedAttr};

use crate::Attrs;

/// An Apple9 form.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Apple9Op {
    /// A 32-bit special register (`selector`: 0xa0 + k thread_position_in_grid.k, 0x9c threadgroup_position_in_grid.x).
    GetSr,
    /// A 16-bit special register zero-extended (`selector`: 0xa4 thread_position_in_threadgroup.x).
    GetSr16,
    Mov,
    MovImm,
    Iadd,
    Isub,
    Imad,
    Shl,
    Shr,
    Asr,
    And,
    Or,
    Xor,
    Smin,
    Smax,
    Umin,
    Umax,
    Select,
    I2f,
    F2i,
    Fadd,
    Fsub,
    Fmul,
    /// dst = a * b + c, one rounding (`neg_product`: -(a * b) + c, `neg_c`: a * b - c).
    Fma,
    /// minNum / maxNum: a NaN operand gives the other.
    Fmin,
    Fmax,
    /// The reciprocal and the reciprocal square root (within 1 ulp, measured), the roundings to an integer.
    Rcp,
    Rsq,
    Floor,
    Ceil,
    Trunc,
    Roundeven,
    Load,
    Store,
    Halt,
}

impl Apple9Op {
    const ALL: [(&'static str, Apple9Op); 35] = [
        ("apple9.get_sr", Apple9Op::GetSr),
        ("apple9.get_sr16", Apple9Op::GetSr16),
        ("apple9.mov", Apple9Op::Mov),
        ("apple9.mov_imm", Apple9Op::MovImm),
        ("apple9.iadd", Apple9Op::Iadd),
        ("apple9.isub", Apple9Op::Isub),
        ("apple9.imad", Apple9Op::Imad),
        ("apple9.shl", Apple9Op::Shl),
        ("apple9.shr", Apple9Op::Shr),
        ("apple9.asr", Apple9Op::Asr),
        ("apple9.and", Apple9Op::And),
        ("apple9.or", Apple9Op::Or),
        ("apple9.xor", Apple9Op::Xor),
        ("apple9.smin", Apple9Op::Smin),
        ("apple9.smax", Apple9Op::Smax),
        ("apple9.umin", Apple9Op::Umin),
        ("apple9.umax", Apple9Op::Umax),
        ("apple9.select", Apple9Op::Select),
        ("apple9.i2f", Apple9Op::I2f),
        ("apple9.f2i", Apple9Op::F2i),
        ("apple9.fadd", Apple9Op::Fadd),
        ("apple9.fmul", Apple9Op::Fmul),
        ("apple9.fsub", Apple9Op::Fsub),
        ("apple9.fma", Apple9Op::Fma),
        ("apple9.fmin", Apple9Op::Fmin),
        ("apple9.fmax", Apple9Op::Fmax),
        ("apple9.rcp", Apple9Op::Rcp),
        ("apple9.rsq", Apple9Op::Rsq),
        ("apple9.floor", Apple9Op::Floor),
        ("apple9.ceil", Apple9Op::Ceil),
        ("apple9.trunc", Apple9Op::Trunc),
        ("apple9.roundeven", Apple9Op::Roundeven),
        ("apple9.load", Apple9Op::Load),
        ("apple9.store", Apple9Op::Store),
        ("apple9.halt", Apple9Op::Halt),
    ];

    /// The form an op name is.
    pub fn of(name: &str) -> Option<Apple9Op> {
        Apple9Op::ALL.iter().find(|(n, _)| *n == name).map(|(_, o)| *o)
    }

    /// Its op name.
    pub fn name(self) -> &'static str {
        Apple9Op::ALL.iter().find(|(_, o)| *o == self).map(|(n, _)| *n).expect("every form is named")
    }

    /// The attributes its SSA operands become, in order (a store's `data` a run of `components` registers).
    pub fn sources(self) -> &'static [&'static str] {
        use Apple9Op::*;
        match self {
            GetSr | GetSr16 | MovImm | Halt => &[],
            Mov | I2f | F2i | Rcp | Rsq | Floor | Ceil | Trunc | Roundeven => &["a"],
            Iadd | Isub | Shl | Shr | Asr | And | Or | Xor | Smin | Smax | Umin | Umax | Fadd | Fsub | Fmul | Fmin | Fmax => &["a", "b"],
            Imad | Fma => &["a", "b", "c"],
            Select => &["a", "b", "t", "f"],
            Load => &["index"],
            Store => &["data", "index"],
        }
    }

    /// Whether it writes `dst` (a load: `components` registers from it).
    pub fn has_dst(self) -> bool {
        !matches!(self, Apple9Op::Store | Apple9Op::Halt)
    }

    /// Whether its result completes later than the instruction, on its `slot`.
    pub fn completes(self) -> bool {
        matches!(self, Apple9Op::GetSr | Apple9Op::GetSr16 | Apple9Op::Load)
    }

    /// Whether it carries a wait itself (the six-bit mask at bits 12 ..= 17); else a wait goes before it.
    pub fn waits(self) -> bool {
        matches!(self, Apple9Op::Iadd | Apple9Op::Isub | Apple9Op::Load | Apple9Op::Store)
    }
}

/// The 32-bit GPRs.
pub const APPLE9_GPRS: u32 = 96;

/// A load's completion token per slot (agx_apple9_ir.c `apple9_scalar_load_token_for_slot`).
const LOAD_TOKEN: [u16; 6] = [0x1100, 0x5100, 0x9100, 0xd100, 0x1101, 0x5101];

/// The fields of one instruction, read off its attributes.
struct Fields<'r, 'a>(&'r [NamedAttr<'a>]);

impl Fields<'_, '_> {
    fn int(&self, name: &str) -> Result<u32, Error> {
        match Attrs(self.0).get(name) {
            None => Ok(0),
            Some(a) => u32::try_from(Attrs::as_int(a)?).map_err(|_| Error(format!("{name}: out of range"))),
        }
    }

    fn reg(&self, name: &str) -> Result<u32, Error> {
        let r = self.int(name)?;
        if r >= APPLE9_GPRS {
            return Err(Error(format!("{name} = r{r}: past r{}", APPLE9_GPRS - 1)));
        }
        Ok(r)
    }

    fn flag(&self, name: &str) -> bool {
        matches!(Attrs(self.0).get(name), Some(Attribute::Bool(true) | Attribute::Unit))
    }

    fn str(&self, name: &str) -> Result<&str, Error> {
        match Attrs(self.0).get(name) {
            Some(Attribute::Str { lit, .. }) => Ok(lit),
            _ => Err(Error(format!("no {name}"))),
        }
    }
}

/// ⭐ The Apple9 encoder.
pub struct Apple9Isa;

impl Apple9Isa {
    /// `width` bits from bit `start` (little-endian bit order across the bytes) set to `value`.
    fn set(b: &mut [u8], start: u32, width: u32, value: u32) {
        for i in 0..width {
            let (byte, shift) = (((start + i) / 8) as usize, (start + i) % 8);
            b[byte] = (b[byte] & !(1 << shift)) | ((((value >> i) & 1) as u8) << shift);
        }
    }

    /// MASK_12_17: wait for the slots of `mask`.
    fn wait(b: &mut [u8], mask: u32) -> Result<(), Error> {
        if mask >= 1 << 6 {
            return Err(Error(format!("wait {mask:#x}: slots 1 ..= 6")));
        }
        Self::set(b, 12, 6, mask);
        Ok(())
    }

    /// pack_integer_source, a retained GPR.
    fn int_source(b: &mut [u8], src: u32, value_bit: u32, discard_bit: u32, file_bit: u32) {
        Self::set(b, value_bit, 7, src);
        Self::set(b, value_bit + 7, 1, 1);
        Self::set(b, discard_bit, 1, 0);
        Self::set(b, file_bit, 1, 1);
    }

    /// pack_compact_binary_gprs.
    fn compact(b: &mut [u8], dst: u32, a: u32, bb: u32) {
        Self::set(b, 4, 4, dst & 0xf);
        Self::set(b, 22, 2, (dst >> 4) & 3);
        Self::set(b, 44, 1, dst >> 6);
        Self::set(b, 9, 6, a & 0x3f);
        Self::set(b, 40, 1, a >> 6);
        Self::set(b, 25, 6, bb & 0x3f);
        Self::set(b, 42, 1, bb >> 6);
    }

    /// The retain bits of a compact binary form's two sources (both retained).
    fn retain2(b: &mut [u8]) {
        Self::set(b, 15, 1, 1);
        Self::set(b, 19, 1, 0);
        Self::set(b, 31, 1, 1);
        Self::set(b, 20, 1, 0);
    }

    /// pack_memory_address: a byte `offset`, the index scaled by 1 << `shift` (at most 4).
    fn address(b: &mut [u8], load: bool, offset: u32, shift: u32) -> Result<(), Error> {
        if shift > 4 || offset > 0xffff {
            return Err(Error(format!("shift {shift} (at most 4), offset {offset} (16 bits)")));
        }
        let base = if load { 75 } else { 73 };
        Self::set(b, base + 2, 16, offset);
        Self::set(b, base + 22, 3, if shift == 4 { 0 } else { shift + 1 });
        Ok(())
    }

    /// ⭐ Instruction `name` (`apple9.<form>`) with fields `attrs` ⇒ its bytes.
    pub fn encode(name: &str, attrs: &[NamedAttr<'_>]) -> Result<Vec<u8>, Error> {
        let op = Apple9Op::of(name).ok_or_else(|| Error(format!("{name}: not an Apple9 instruction")))?;
        let f = Fields(attrs);
        let err = |m: &str| Error(format!("{name}: {m}"));
        use Apple9Op::*;
        Ok(match op {
            // agx_apple9_pack_get_sr / _zext16
            GetSr | GetSr16 => {
                let (dst, sel) = (f.reg("dst")?, f.int("selector")?);
                if dst >= 64 || sel > 0xff {
                    return Err(err("dst past r63 or selector past 0xff"));
                }
                // byte 3 bits 5 ..= 7: the completion slot - 1 (Metal gives reads in flight together slots of their own:
                // 0x06, 0x26, 0x46; two on one slot, a wait for it waits for one of them only: measured)
                let slot = f.int("slot")?;
                let slot = if slot == 0 { 1 } else { slot };
                if !(1..=6).contains(&slot) {
                    return Err(err("slot 1 ..= 6"));
                }
                let head = [((dst & 0xf) << 4) as u8 | if op == GetSr { 0x0c } else { 0x04 }, sel as u8, 0x10 | ((dst >> 4) << 6) as u8, 0x06 | ((slot - 1) << 5) as u8];
                let mut b = head.to_vec();
                if op == GetSr16 {
                    b.extend([((dst & 15) << 4) as u8 | 0x03, 0x00, ((dst >> 4) << 6) as u8, 0x01]);
                }
                b
            }
            // agx_apple9_pack_mov
            Mov => {
                let (dst, a) = (f.reg("dst")?, f.reg("a")?);
                if dst >= 16 || a >= 64 {
                    return Err(err("dst past r15 or a past r63"));
                }
                vec![(dst << 4) as u8 | 0x0b, (a << 1) as u8 | 1, 0x1f, 0x01, 0x02, 0, 0, 0x80, 0, 0]
            }
            // agx_apple9_pack_mov_imm (7 bits, r0 ..= r15) or agx_apple9_encode_literal32
            MovImm => {
                let (dst, v) = (f.reg("dst")?, f.int("value")?);
                if dst < 16 && v <= 0x7f {
                    vec![(dst << 4) as u8 | 0x0c, v as u8]
                } else {
                    if dst >= 64 {
                        return Err(err("a 32-bit immediate to past r63"));
                    }
                    vec![
                        ((dst & 0xf) << 4) as u8 | 0x0c,
                        0x80 | (v & 0x7f) as u8,
                        ((dst >> 4) << 6) as u8 | 0x02,
                        ((v >> 24) & 0xfe) as u8,
                        ((v >> 6) & 0x1e) as u8,
                        ((v >> 9) & 0x0c) as u8,
                        ((v >> 13) & 0xff) as u8,
                        ((v >> 21) & 0x0f) as u8,
                    ]
                }
            }
            // pack_iadd
            Iadd | Isub => {
                let mut b = vec![if op == Iadd { 0x9f } else { 0x1f }, 0x01, 0x54, 0x00, 0x02, 0x00, 0x00, 0xa8, 0x17, 0x05];
                Self::set(&mut b, 25, 7, f.reg("dst")?);
                for (s, k) in ["a", "b"].iter().enumerate() {
                    let s = s as u32;
                    Self::int_source(&mut b, f.reg(k)?, 42 + 9 * s, 65 + s, 72 + 2 * s);
                }
                Self::wait(&mut b, f.int("wait")?)?;
                b
            }
            // pack_imad: dst = a * b + c
            Imad => {
                let mut b = vec![0x9f, 0x00, 0x54, 0x00, 0x02, 0x00, 0x00, 0x00, 0xd0, 0x2f, 0x2a, 0x00];
                Self::set(&mut b, 25, 7, f.reg("dst")?);
                for (s, k) in ["a", "b", "c"].iter().enumerate() {
                    let s = s as u32;
                    Self::int_source(&mut b, f.reg(k)?, 42 + 9 * s, 73 + s, 81 + 2 * s);
                }
                b
            }
            // pack_shift, the register amount forms: dst = a << b, a >> b (logical / arithmetic)
            Shl | Shr | Asr => {
                let mut b = vec![0xa7, 0, 0x54, 0, 0x02, 0, 0, 0, 0xf0, 0x11, 0x01, 0];
                let arithmetic = op == Asr;
                if arithmetic {
                    b[1] = 1;
                    b[7] = 0xd8;
                    b[8] = 0xe2;
                    b[9] = 0;
                } else {
                    if op == Shl {
                        b[0] = 0x27;
                    }
                    b[9] = 0x13;
                    b[10] = 0x05;
                }
                Self::set(&mut b, 25, 7, f.reg("dst")?);
                Self::set(&mut b, 42, 7, f.reg("a")?);
                Self::set(&mut b, 51, 7, f.reg("b")?);
                let release = if arithmetic { 62 } else { 72 };
                Self::set(&mut b, release, 2, 0);
                b.truncate(if arithmetic { 10 } else { 12 });
                b
            }
            // pack_logic (LOGIC_EXTENDED)
            And | Or | Xor => {
                let mut b = vec![0x0b, 0x05, 0x1f, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00];
                if op != And {
                    b[4] = 0x02;
                    b[5] = 0x08;
                }
                if op == Xor {
                    b[2] = 0x1e;
                }
                Self::retain2(&mut b);
                Self::set(&mut b, 21, 1, 1);
                Self::compact(&mut b, f.reg("dst")?, f.reg("a")?, f.reg("b")?);
                b
            }
            // pack_minmax (MINMAX_COMPACT)
            Smin | Smax | Umin | Umax => {
                let select = match op {
                    Umax => 4,
                    Umin => 5,
                    Smax => 6,
                    _ => 7,
                };
                let mut b = vec![0x02, 0x01, 0x1e, 0x05, select, 0x00];
                Self::set(&mut b, 21, 1, 1);
                Self::retain2(&mut b);
                Self::compact(&mut b, f.reg("dst")?, f.reg("a")?, f.reg("b")?);
                b
            }
            // pack_select (SELECT_GPR_WIDE): dst = a <cond> b ? t : f
            Select => {
                // AGX_APPLE9_SELECT_*; feq with the equality family's bit (byte 4 bit 2); an ordered compare is false
                // on a NaN (measured)
                let (cond, equality) = match f.str("cond")? {
                    "feq" => (0x00, true),
                    "fgt" => (0x02, false),
                    "flt" => (0x03, false),
                    "ugt" => (0x04, false),
                    "ult" => (0x05, false),
                    "igt" => (0x06, false),
                    "ilt" => (0x07, false),
                    c => return Err(err(&format!("condition {c} (feq / fgt / flt / ugt / ult / igt / ilt)"))),
                };
                let mut b = vec![0x02, 0x01, 0x1f, 0x01, 0x82 | if equality { 0x04 } else { 0 }, 0x00, cond, 0x00, 0x80, 0x00];
                // each source retained: its live bit set, its hold bit clear
                for (live, hold) in [(15, 19), (31, 20), (47, 39), (79, 71)] {
                    Self::set(&mut b, live, 1, 1);
                    Self::set(&mut b, hold, 1, 0);
                }
                let (dst, a, bb, t, fl) = (f.reg("dst")?, f.reg("a")?, f.reg("b")?, f.reg("t")?, f.reg("f")?);
                Self::set(&mut b, 4, 4, dst & 15);
                Self::set(&mut b, 22, 2, (dst >> 4) & 3);
                Self::set(&mut b, 60, 1, dst >> 6);
                Self::set(&mut b, 9, 6, a & 0x3f);
                Self::set(&mut b, 56, 1, a >> 6);
                Self::set(&mut b, 25, 6, bb & 0x3f);
                Self::set(&mut b, 58, 1, bb >> 6);
                Self::set(&mut b, 41, 6, t & 0x3f);
                Self::set(&mut b, 38, 1, t >> 6);
                Self::set(&mut b, 73, 6, fl & 0x3f);
                Self::set(&mut b, 70, 1, fl >> 6);
                b
            }
            // pack_i2f32 / pack_f2i32 (toward zero), the source retained
            I2f | F2i => {
                let (dst, a) = (f.reg("dst")?, f.reg("a")?);
                let signed = f.flag("signed");
                if op == I2f {
                    vec![0xa7, 0x07, 0x54, (dst << 1) as u8, 0x03, ((a & 63) << 2) as u8, 0x8c | (a >> 6) as u8, if signed { 0x60 } else { 0x20 }]
                } else {
                    vec![
                        0x27,
                        0x07,
                        0x54,
                        (dst << 1) as u8,
                        0x03,
                        ((a & 63) << 2) as u8,
                        0x96 | (a >> 6) as u8,
                        if signed { 0x48 } else { 0x08 },
                        if signed { 0x03 } else { 0x02 },
                        0x00,
                    ]
                }
            }
            // pack_minmax (MINMAX_COMPACT): fmax 0, fmin 1
            Fmin | Fmax => {
                let mut b = vec![0x02, 0x01, 0x1e, 0x05, if op == Fmax { 0 } else { 1 }, 0x00];
                Self::set(&mut b, 21, 1, 1);
                Self::retain2(&mut b);
                Self::compact(&mut b, f.reg("dst")?, f.reg("a")?, f.reg("b")?);
                b
            }
            // pack_fma (FLOAT3_EXTENDED, 8 bytes)
            Fma => {
                let mut b = vec![0x09, 0x01, 0x1e, 0x05, 0x81, 0x08, 0x02, 0x00];
                Self::set(&mut b, 21, 1, 1);
                for (live, hold) in [(15, 19), (31, 20), (47, 39)] {
                    Self::set(&mut b, live, 1, 1);
                    Self::set(&mut b, hold, 1, 0);
                }
                let (dst, a, bb, c) = (f.reg("dst")?, f.reg("a")?, f.reg("b")?, f.reg("c")?);
                Self::set(&mut b, 4, 4, dst & 0xf);
                Self::set(&mut b, 22, 2, (dst >> 4) & 3);
                Self::set(&mut b, 60, 1, dst >> 6);
                Self::set(&mut b, 9, 6, a & 0x3f);
                Self::set(&mut b, 56, 1, a >> 6);
                Self::set(&mut b, 25, 6, bb & 0x3f);
                Self::set(&mut b, 58, 1, bb >> 6);
                Self::set(&mut b, 41, 6, c & 0x3f);
                Self::set(&mut b, 38, 1, c >> 6);
                Self::set(&mut b, 35, 1, 0);
                Self::set(&mut b, 36, 1, u32::from(f.flag("neg_c")));
                Self::set(&mut b, 59, 1, u32::from(f.flag("neg_product")));
                b
            }
            // pack_fspecial (FLOAT_SPECIAL, FP32: the source's type bits 0x90 / the reciprocal's datapath), the source
            // retained
            Rcp | Rsq | Floor | Ceil | Trunc | Roundeven => {
                let (family, function, precision, rounding) = match op {
                    Rcp => (1, 0, 0x48, 0x20),
                    Rsq => (1, 1, 0x40, 0),
                    Floor => (0, 0, 0x40, 2),
                    Ceil => (0, 0, 0x40, 4),
                    Trunc => (0, 0, 0x40, 6),
                    _ => (0, 0, 0x40, 0),
                };
                let (dst, a) = (f.reg("dst")?, f.reg("a")?);
                vec![0x2f | (family << 7), function, 0x54, (dst << 1) as u8, 0x02, ((a & 63) << 2) as u8, (a >> 6) as u8 | if op == Rcp { 0x00 } else { 0x90 }, precision, rounding, 0]
            }
            // pack_float2: FLOAT2_COMPACT (fsub: bit 43 negates b), or FLOAT2_MUL_ABS_EXTENDED with `abs` (a mask of
            // the sources taken absolute)
            Fadd | Fsub | Fmul => {
                let mut b = vec![0x09, 0x05, 0x1c, 0x01, 0x00, 0x00, 0, 0, 0, 0, 0, 0];
                Self::set(&mut b, 16, 3, if op == Fmul { 5 } else { 4 });
                Self::set(&mut b, 21, 1, 1);
                Self::retain2(&mut b);
                Self::compact(&mut b, f.reg("dst")?, f.reg("a")?, f.reg("b")?);
                if op == Fsub {
                    Self::set(&mut b, 43, 1, 1);
                }
                let abs = f.int("abs")?;
                if abs != 0 {
                    if op != Fmul || abs > 3 {
                        return Err(err("abs: a multiply's, a mask of two sources"));
                    }
                    Self::set(&mut b, 32, 2, 2);
                    Self::set(&mut b, 64, 2, abs);
                } else {
                    b.truncate(6);
                }
                b
            }
            // agx_apple9_pack_device_load_vector_u32_raw + pack_memory_address
            Load => {
                let n = f.int("components")?.max(1);
                let (dst, slot) = (f.reg("dst")?, f.int("slot")?);
                let slot = if slot == 0 { 6 } else { slot };
                if !(1..=4).contains(&n) || dst + n > APPLE9_GPRS || !(1..=6).contains(&slot) {
                    return Err(err("1 ..= 4 components, slot 1 ..= 6"));
                }
                let token = LOAD_TOKEN[slot as usize - 1];
                let mut b = vec![0x67, 0x00, 0x44, (dst << 1) as u8, f.int("binding")? as u8, f.reg("index")? as u8, 0x20, 0x00, 0x11, 0x00, 0x00, 0x40, 0x46, 0x00];
                b[8] = (token >> 8) as u8 | [0x00, 0x08, 0x0c, 0x06][n as usize - 1];
                b[9] = token as u8;
                b[12] = [0x46, 0x48, 0x40, 0x40][n as usize - 1];
                Self::wait(&mut b, f.int("wait")?)?;
                Self::address(&mut b, true, f.int("offset")?, f.int("shift")?)?;
                b
            }
            // agx_apple9_pack_device_store_vector_u32 / _scalar (32-bit) + pack_memory_address
            Store => {
                let n = f.int("components")?.max(1);
                let data = f.reg("data")?;
                if !(1..=4).contains(&n) || data + n > APPLE9_GPRS {
                    return Err(err("1 ..= 4 components"));
                }
                let mut b = vec![0xe7, 0x00, 0x54, (data << 1) as u8, f.int("binding")? as u8, f.reg("index")? as u8, 0x20, 0x00, 0x11 | [0x00, 0x08, 0x0c, 0x06][n as usize - 1], 0x00, 0x00, 0x10, [0x11, 0x12, 0x10, 0x10][n as usize - 1], 0x00];
                if n == 1 {
                    b[11] = 0x90;
                    b[12] = 0x11;
                }
                Self::wait(&mut b, f.int("wait")?)?;
                Self::address(&mut b, false, f.int("offset")?, f.int("shift")?)?;
                b
            }
            Halt => vec![0x0e, 0, 0, 0],
        })
    }
}
