use alloc::format;
use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{Attribute, Error, NamedAttr};

use crate::Attrs;

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Apple9Op {
    GetSr,
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
    Fma,
    Fmin,
    Fmax,
    Rcp,
    Rsq,
    Floor,
    Ceil,
    Trunc,
    Roundeven,
    Load,
    Store,
    Atomic,
    Cmpxchg,
    SharedAtomic,
    SharedLoad,
    SharedStore,
    Barrier,
    Pred,
    Push,
    Else,
    Pop,
    LoopPush,
    LoopUpdate,
    LoopPop,
    JmpAny,
    JmpNone,
    Label,
    Halt,
}

impl Apple9Op {
    const ALL: [(&'static str, Apple9Op); 51] = [
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
        ("apple9.atomic", Apple9Op::Atomic),
        ("apple9.cmpxchg", Apple9Op::Cmpxchg),
        ("apple9.shared_atomic", Apple9Op::SharedAtomic),
        ("apple9.shared_load", Apple9Op::SharedLoad),
        ("apple9.shared_store", Apple9Op::SharedStore),
        ("apple9.barrier", Apple9Op::Barrier),
        ("apple9.pred", Apple9Op::Pred),
        ("apple9.push", Apple9Op::Push),
        ("apple9.else", Apple9Op::Else),
        ("apple9.pop", Apple9Op::Pop),
        ("apple9.loop_push", Apple9Op::LoopPush),
        ("apple9.loop_update", Apple9Op::LoopUpdate),
        ("apple9.loop_pop", Apple9Op::LoopPop),
        ("apple9.jmp_any", Apple9Op::JmpAny),
        ("apple9.jmp_none", Apple9Op::JmpNone),
        ("apple9.label", Apple9Op::Label),
        ("apple9.halt", Apple9Op::Halt),
    ];

    pub fn of(name: &str) -> Option<Apple9Op> {
        Apple9Op::ALL.iter().find(|(n, _)| *n == name).map(|(_, o)| *o)
    }

    pub fn name(self) -> &'static str {
        Apple9Op::ALL.iter().find(|(_, o)| *o == self).map(|(n, _)| *n).expect("every form is named")
    }

    pub fn sources(self) -> &'static [&'static str] {
        use Apple9Op::*;
        match self {
            GetSr | GetSr16 | MovImm | Halt | Barrier | Push | Else | Pop | LoopPush | LoopUpdate | LoopPop | JmpAny | JmpNone | Label => &[],
            Mov | I2f | F2i | Rcp | Rsq | Floor | Ceil | Trunc | Roundeven => &["a"],
            Iadd | Isub | Shl | Shr | Asr | And | Or | Xor | Smin | Smax | Umin | Umax | Fadd | Fsub | Fmul | Fmin | Fmax | Pred => &["a", "b"],
            Imad | Fma => &["a", "b", "c"],
            Select => &["a", "b", "t", "f"],
            Load | SharedLoad => &["index"],
            Store | SharedStore | Cmpxchg => &["data", "index"],
            Atomic => &["a", "index"],
            SharedAtomic => &["data", "index"],
        }
    }

    pub fn has_dst(self) -> bool {
        !matches!(self, Apple9Op::Store | Apple9Op::SharedStore | Apple9Op::Barrier | Apple9Op::Halt) && !self.controls()
    }

    pub fn controls(self) -> bool {
        use Apple9Op::*;
        matches!(self, Pred | Push | Else | Pop | LoopPush | LoopUpdate | LoopPop | JmpAny | JmpNone | Label)
    }

    pub fn completes(self) -> bool {
        matches!(self, Apple9Op::GetSr | Apple9Op::GetSr16 | Apple9Op::Load | Apple9Op::SharedLoad | Apple9Op::Atomic | Apple9Op::Cmpxchg | Apple9Op::SharedAtomic)
    }

    pub fn releases(self) -> bool {
        use Apple9Op::*;
        matches!(self, Iadd | Isub | Imad | Shl | Shr | Asr | And | Or | Xor | Smin | Smax | Umin | Umax | Fmin | Fmax | Fadd | Fsub | Fmul | Fma | Select | I2f | F2i | Floor | Ceil | Trunc | Roundeven | Load | SharedLoad | Store | SharedStore)
    }

    pub fn slot(self) -> Option<u32> {
        matches!(self, Apple9Op::Atomic | Apple9Op::Cmpxchg).then_some(6)
    }

    pub fn waits(self) -> bool {
        use Apple9Op::*;
        matches!(self, Iadd | Isub | Load | Store | SharedLoad | SharedStore | Atomic | Cmpxchg | SharedAtomic)
    }
}

pub const APPLE9_GPRS: u32 = 96;

const LOAD_TOKEN: [u16; 6] = [0x1100, 0x5100, 0x9100, 0xd100, 0x1101, 0x5101];

const PUBLICATION: [u8; 6] = [2, 4, 3, 5, 6, 1];

const ATOMICS: [(&str, u8); 11] = [("add", 0x10), ("and", 0x11), ("cmpxchg", 0x12), ("smax", 0x14), ("smin", 0x15), ("or", 0x16), ("sub", 0x1b), ("umax", 0x1c), ("umin", 0x1d), ("xchg", 0x1e), ("xor", 0x1f)];

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

pub struct Apple9Isa;

impl Apple9Isa {
    fn set(b: &mut [u8], start: u32, width: u32, value: u32) {
        for i in 0..width {
            let (byte, shift) = (((start + i) / 8) as usize, (start + i) % 8);
            b[byte] = (b[byte] & !(1 << shift)) | ((((value >> i) & 1) as u8) << shift);
        }
    }

    fn wait(b: &mut [u8], mask: u32) -> Result<(), Error> {
        if mask >= 1 << 6 {
            return Err(Error(format!("wait {mask:#x}: slots 1 ..= 6")));
        }
        Self::set(b, 12, 6, mask);
        Ok(())
    }

    fn int_source(b: &mut [u8], src: u32, value_bit: u32, discard_bit: u32, file_bit: u32, released: bool) {
        Self::set(b, value_bit, 7, src);
        Self::set(b, value_bit + 7, 1, u32::from(!released));
        Self::set(b, discard_bit, 1, u32::from(released));
        Self::set(b, file_bit, 1, 1);
    }

    fn retain(b: &mut [u8], pairs: &[(u32, u32)], release: u32) {
        for (s, (live, hold)) in pairs.iter().enumerate() {
            if release & (1 << s) == 0 {
                Self::set(b, *live, 1, 1);
                Self::set(b, *hold, 1, 0);
            }
        }
    }

    fn compact(b: &mut [u8], dst: u32, a: u32, bb: u32) {
        Self::set(b, 4, 4, dst & 0xf);
        Self::set(b, 22, 2, (dst >> 4) & 3);
        Self::set(b, 44, 1, dst >> 6);
        Self::set(b, 9, 6, a & 0x3f);
        Self::set(b, 40, 1, a >> 6);
        Self::set(b, 25, 6, bb & 0x3f);
        Self::set(b, 42, 1, bb >> 6);
    }

    fn retain2(b: &mut [u8], release: u32) {
        Self::retain(b, &[(15, 19), (31, 20)], release);
    }

    fn address(b: &mut [u8], load: bool, offset: u32, shift: u32) -> Result<(), Error> {
        if shift > 4 || offset > 0xffff {
            return Err(Error(format!("shift {shift} (at most 4), offset {offset} (16 bits)")));
        }
        let base = if load { 75 } else { 73 };
        Self::set(b, base + 2, 16, offset);
        Self::set(b, base + 22, 3, if shift == 4 { 0 } else { shift + 1 });
        Ok(())
    }

    pub fn encode(name: &str, attrs: &[NamedAttr<'_>]) -> Result<Vec<u8>, Error> {
        let op = Apple9Op::of(name).ok_or_else(|| Error(format!("{name}: not an Apple9 instruction")))?;
        let f = Fields(attrs);
        let err = |m: &str| Error(format!("{name}: {m}"));
        let release = f.int("release")?;
        if release != 0 && !op.releases() {
            return Err(err("its sources are not released"));
        }
        let released = |s: u32| release & (1 << s) != 0;
        use Apple9Op::*;
        Ok(match op {
            GetSr | GetSr16 => {
                let (dst, sel) = (f.reg("dst")?, f.int("selector")?);
                if dst >= 64 || sel > 0xff {
                    return Err(err("dst past r63 or selector past 0xff"));
                }
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
            Mov => {
                let (dst, a) = (f.reg("dst")?, f.reg("a")?);
                if dst >= 16 || a >= 64 {
                    return Err(err("dst past r15 or a past r63"));
                }
                vec![(dst << 4) as u8 | 0x0b, (a << 1) as u8 | 1, 0x1f, 0x01, 0x02, 0, 0, 0x80, 0, 0]
            }
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
            Iadd | Isub => {
                let mut b = vec![if op == Iadd { 0x9f } else { 0x1f }, 0x01, 0x54, 0x00, 0x02, 0x00, 0x00, 0xa8, 0x17, 0x05];
                Self::set(&mut b, 25, 7, f.reg("dst")?);
                for (s, k) in ["a", "b"].iter().enumerate() {
                    let s = s as u32;
                    Self::int_source(&mut b, f.reg(k)?, 42 + 9 * s, 65 + s, 72 + 2 * s, released(s));
                }
                Self::wait(&mut b, f.int("wait")?)?;
                b
            }
            Imad => {
                let mut b = vec![0x9f, 0x00, 0x54, 0x00, 0x02, 0x00, 0x00, 0x00, 0xd0, 0x2f, 0x2a, 0x00];
                Self::set(&mut b, 25, 7, f.reg("dst")?);
                for (s, k) in ["a", "b", "c"].iter().enumerate() {
                    let s = s as u32;
                    Self::int_source(&mut b, f.reg(k)?, 42 + 9 * s, 73 + s, 81 + 2 * s, released(s));
                }
                b
            }
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
                let flag = if arithmetic { 62 } else { 72 };
                for s in 0..2 {
                    if !released(s) {
                        Self::set(&mut b, flag + s, 1, 0);
                    }
                }
                b.truncate(if arithmetic { 10 } else { 12 });
                b
            }
            And | Or | Xor => {
                let mut b = vec![0x0b, 0x05, 0x1f, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00];
                if op != And {
                    b[4] = 0x02;
                    b[5] = 0x08;
                }
                if op == Xor {
                    b[2] = 0x1e;
                }
                Self::retain2(&mut b, release);
                Self::set(&mut b, 21, 1, 1);
                Self::compact(&mut b, f.reg("dst")?, f.reg("a")?, f.reg("b")?);
                b
            }
            Smin | Smax | Umin | Umax => {
                let select = match op {
                    Umax => 4,
                    Umin => 5,
                    Smax => 6,
                    _ => 7,
                };
                let mut b = vec![0x02, 0x01, 0x1e, 0x05, select, 0x00];
                Self::set(&mut b, 21, 1, 1);
                Self::retain2(&mut b, release);
                Self::compact(&mut b, f.reg("dst")?, f.reg("a")?, f.reg("b")?);
                b
            }
            Select => {
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
                Self::retain(&mut b, &[(15, 19), (31, 20), (47, 39), (79, 71)], release);
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
            I2f | F2i => {
                let (dst, a) = (f.reg("dst")?, f.reg("a")?);
                let signed = f.flag("signed");
                if op == I2f {
                    vec![0xa7, 0x07, 0x54, (dst << 1) as u8, 0x03, ((a & 63) << 2) as u8, if released(0) { 0xac } else { 0x8c } | (a >> 6) as u8, if signed { 0x60 } else { 0x20 }]
                } else {
                    vec![
                        0x27,
                        0x07,
                        0x54,
                        (dst << 1) as u8,
                        0x03,
                        ((a & 63) << 2) as u8,
                        if released(0) { 0xb4 } else { 0x96 } | (a >> 6) as u8,
                        if signed { 0x48 } else { 0x08 },
                        if signed { 0x03 } else { 0x02 },
                        0x00,
                    ]
                }
            }
            Fmin | Fmax => {
                let mut b = vec![0x02, 0x01, 0x1e, 0x05, if op == Fmax { 0 } else { 1 }, 0x00];
                Self::set(&mut b, 21, 1, 1);
                Self::retain2(&mut b, release);
                Self::compact(&mut b, f.reg("dst")?, f.reg("a")?, f.reg("b")?);
                b
            }
            Fma => {
                let mut b = vec![0x09, 0x01, 0x1e, 0x05, 0x81, 0x08, 0x02, 0x00];
                Self::set(&mut b, 21, 1, 1);
                Self::retain(&mut b, &[(15, 19), (31, 20), (47, 39)], release);
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
                let lifetime = match (op == Rcp, released(0)) {
                    (true, false) => 0x00,
                    (true, true) => 0x10,
                    (false, false) => 0x90,
                    (false, true) => 0xb0,
                };
                vec![0x2f | (family << 7), function, 0x54, (dst << 1) as u8, 0x02, ((a & 63) << 2) as u8, (a >> 6) as u8 | lifetime, precision, rounding, 0]
            }
            Fadd | Fsub | Fmul => {
                let mut b = vec![0x09, 0x05, 0x1c, 0x01, 0x00, 0x00, 0, 0, 0, 0, 0, 0];
                Self::set(&mut b, 16, 3, if op == Fmul { 5 } else { 4 });
                Self::set(&mut b, 21, 1, 1);
                Self::retain2(&mut b, release);
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
            Load => {
                let n = f.int("components")?.max(1);
                let (dst, slot) = (f.reg("dst")?, f.int("slot")?);
                let slot = if slot == 0 { 6 } else { slot };
                if !(1..=4).contains(&n) || dst + n > APPLE9_GPRS || !(1..=6).contains(&slot) {
                    return Err(err("1 ..= 4 components, slot 1 ..= 6"));
                }
                let token = LOAD_TOKEN[slot as usize - 1];
                let mut b = vec![0x67, 0x00, 0x44, (dst << 1) as u8, f.int("binding")? as u8, f.reg("index")? as u8 | if released(0) { 0x80 } else { 0 }, 0x20, 0x00, 0x11, 0x00, 0x00, 0x40, 0x46, 0x00];
                b[8] = (token >> 8) as u8 | [0x00, 0x08, 0x0c, 0x06][n as usize - 1];
                b[9] = token as u8;
                b[12] = [0x46, 0x48, 0x40, 0x40][n as usize - 1];
                Self::wait(&mut b, f.int("wait")?)?;
                Self::address(&mut b, true, f.int("offset")?, f.int("shift")?)?;
                b
            }
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
                if released(0) {
                    return Err(err("a store's data is not released"));
                }
                Self::set(&mut b, 48, 1, u32::from(released(1)));
                Self::wait(&mut b, f.int("wait")?)?;
                Self::address(&mut b, false, f.int("offset")?, f.int("shift")?)?;
                b
            }
            Pred => {
                if f.str("cond")? != "ieq" {
                    return Err(err("condition ieq"));
                }
                let (a, bb) = (f.reg("a")?, f.reg("b")?);
                let mut b = vec![0x0a, ((a & 63) << 1) as u8 | 1, 0x23, ((bb & 63) << 1) as u8 | 1, 0x06, 0x00, 0x07, if f.flag("loop") { 0x00 } else { 0xc0 }, 0, 0];
                Self::set(&mut b, 56, 1, a >> 6);
                Self::set(&mut b, 58, 1, bb >> 6);
                b
            }
            Push => vec![0x0f, 0x05, 0x54, 0x01 | if f.flag("invert") { 0x20 } else { 0 }],
            Else => vec![0x0f, 0x04, 0x04, 0x19],
            Pop => vec![0x0f, 0x06, 0x04, 0x01, 0x00, 0x00],
            LoopPush => vec![0x0f, 0x05, 0x54, 0x1a],
            LoopUpdate => vec![0x8f, 0x04, 0x54, 0x02 | if f.flag("invert") { 0x20 } else { 0 }],
            LoopPop => vec![0x0f, 0x06, 0x04, 0x02, 0x00, 0x00],
            JmpAny | JmpNone => return Err(err("a jump is encoded where its label is known (Apple9Isa::jump)")),
            Label => Vec::new(),
            Atomic | Cmpxchg => {
                let code = if op == Cmpxchg {
                    if f.int("components")? != 2 {
                        return Err(err("components = 2 (the value, the one compared with)"));
                    }
                    0x12
                } else {
                    let name = f.str("op")?;
                    ATOMICS.iter().find(|(n, _)| *n == name && *n != "cmpxchg").map(|(_, c)| *c).ok_or_else(|| err(&format!("atomic {name}")))?
                };
                let a = f.reg(if op == Cmpxchg { "data" } else { "a" })?;
                let (dst, index, binding) = (f.reg("dst")?, f.reg("index")?, f.int("binding")?);
                let slot = f.int("slot")?;
                let slot = if slot == 0 { 6 } else { slot };
                if dst >= 64 || binding >= 128 || !(1..=6).contains(&slot) {
                    return Err(err("dst past r63, binding past 127 or slot past 6"));
                }
                let mut b = vec![0x67, 0x01, 0x54, 0, 0, binding as u8 | ((a & 1) << 7) as u8, ((a >> 1) & 0x3f) as u8 | ((index & 1) << 7) as u8, 0x80 | ((index >> 1) & 0x3f) as u8, 0, 0x02, 0, 0, (code << 1) | 0x40, 0x02];
                Self::wait(&mut b, f.int("wait")?)?;
                b.extend([((dst & 0xf) << 4) as u8 | 0x0c, 0x80, 0x09 | (((dst >> 4) & 3) << 6) as u8, 0xa7, 0, PUBLICATION[slot as usize - 1] << 5, 0, ((dst >> 6) << 4) as u8]);
                b
            }
            SharedAtomic => {
                let name = f.str("op")?;
                let code = ATOMICS.iter().find(|(n, _)| *n == name).map(|(_, c)| *c).ok_or_else(|| err(&format!("atomic {name}")))?;
                if (code == 0x12) != (f.int("components")? == 2) {
                    return Err(err("cmpxchg with components = 2, any other with 1"));
                }
                let (dst, data, index) = (f.reg("dst")?, f.reg("data")?, f.reg("index")?);
                let slot = f.int("slot")?;
                let slot = if slot == 0 { 6 } else { slot };
                if dst >= 128 || data >= 128 || index >= 128 || !(1..=6).contains(&slot) {
                    return Err(err("a register past r127 or slot past 6"));
                }
                let mut b = vec![0x67, 0x03, 0x54, dst as u8, 0x02, data as u8, 0x80 | index as u8, 0, 0x10 | (slot << 1) as u8, 0, 0, 0x48];
                Self::set(&mut b, 86, 5, u32::from(code));
                Self::wait(&mut b, f.int("wait")?)?;
                b
            }
            SharedLoad | SharedStore => {
                let load = op == SharedLoad;
                let (data, index, offset) = (f.reg(if load { "dst" } else { "data" })?, f.reg("index")?, f.int("offset")?);
                if data >= 64 || index >= 64 || offset >= 1 << 12 {
                    return Err(err("a register past r63 or an offset past 12 bits"));
                }
                if !load && released(0) {
                    return Err(err("a store's data is not released"));
                }
                let index_released = released(if load { 0 } else { 1 });
                let mut b = vec![if load { 0x67 } else { 0xe7 }, 0x02, 0x54, (data << 1) as u8, 0x04, (index << 2) as u8, if index_released { 0x80 } else { 0 }, 0, 0x44, if load { 0x08 } else { 0x02 }, 0, if load { 0xc0 } else { 0x30 }, if load { 0x08 } else { 0x02 }, 0];
                if load {
                    let slot = f.int("slot")?;
                    let slot = if slot == 0 { 6 } else { slot };
                    if !(1..=6).contains(&slot) {
                        return Err(err("slot 1 ..= 6"));
                    }
                    Self::set(&mut b, 72, 3, slot - 1);
                }
                Self::set(&mut b, if load { 79 } else { 77 }, 12, offset);
                Self::wait(&mut b, f.int("wait")?)?;
                b
            }
            Barrier => vec![0x07, 0x04, 0x54, 0x61, 0x09, 0x00],
            Halt => vec![0x0e, 0, 0, 0],
        })
    }

    pub fn jump(any: bool, displacement: i64) -> Result<Vec<u8>, Error> {
        if displacement & 1 != 0 || !(-(1 << 47)..1 << 47).contains(&displacement) {
            return Err(Error(format!("jump by {displacement}: even, 48 bits")));
        }
        let mut b = vec![0x0f, if any { 0x00 } else { 0x01 }, 0x54];
        b.extend((0..6).map(|k| (displacement >> (8 * k)) as u8));
        b.push(0);
        Ok(b)
    }

    pub const JUMP_BYTES: usize = 10;
}
