//! ⭐ RDNA2 instructions: one op per encoding family, `rdna2.isa.{salu, valu, smem, flat, ds} {op = "<mnemonic>", ...}`
//! ⇒ their dwords, encoded as Mesa's ACO does for GFX10.3 (src/amd/compiler/aco_assembler.cpp, `emit_*_instruction`),
//! checked against `llvm-mc -mcpu=gfx1036`. The mnemonic is an [`Opcode`] (its format says which of a family's
//! encodings), every register or constant field an [`Operand`].
//!
//! Operands are spelled as LLVM spells them: `v5`, `s7`, `v[2:3]`, `s[4:5]`, `vcc_lo`, `exec_lo`, `m0`, `null`, `off`,
//! `scc`, an inline constant (`-16 ..= 64`, `0.5`, `1.0`, `2.0`, `4.0` and their negations), anything else a literal
//! (`0x3f800000`: one more dword). A VOP3 source may be `-x` (neg) and `|x|` (abs). They are read into an
//! [`Operand`] once, when the op is read.
//!
//! | op | formats | fields |
//! | --- | --- | --- |
//! | [`Salu`] | SOP1 / SOP2 / SOPC / SOPK / SOPP | `dst`, `src0`, `src1`, `simm16` (SOPK, SOPP) |
//! | [`Smem`] | SMEM | `dst` (`data` for a store), `sbase`, `offset` (bytes) or `soffset`, `glc`, `dlc` |
//! | [`Valu`] | VOP1 / VOP2 / VOPC / VOP3 | `dst`, `sdst` (VOP3b), `src0`, `src1`, `src2`, `clamp`, `omod`; `vop3`: the 64-bit encoding |
//! | [`Flat`] | GLOBAL / FLAT / SCRATCH | `dst` (a load), `addr`, `data` (a store), `saddr` (`off`: none), `offset`, `glc`, `slc`, `dlc` |
//! | [`Ds`] | DS | `dst`, `addr`, `data0`, `data1`, `offset0`, `offset1`, `gds` |
//!
//! Before rdna2-regalloc an instruction is virtual: its SSA `operands` go to the fields its `slots` name, in order,
//! its results to `dst`; the allocation writes the registers into those fields and drops both.

use alloc::format;
use alloc::string::ToString;
use alloc::vec;
use alloc::vec::Vec;
use core::fmt;

use mlirformat::{Attribute, Error, Type, Value, mlir};
use serde::{Deserialize, Deserializer, Serialize, Serializer};

use super::{HASHES, Opcode};
use crate::{Body, OpData, OpId, ValueId};

/// An instruction's encoding family (Mesa ACO's `Format`).
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Format {
    Sop1,
    Sop2,
    Sopk,
    Sopp,
    Sopc,
    Smem,
    Ds,
    Flat,
    Global,
    Scratch,
    Vop1,
    Vop2,
    Vopc,
    Vop3,
    Vop3p,
    Mubuf,
    Mtbuf,
    Mimg,
    Exp,
    Vintrp,
}

/// `sgpr_null` on GFX10 (aco_ir.h).
const NULL: u32 = 125;
/// `SQ_SRC_LITERAL`: the source is the dword after the instruction.
const LITERAL: u32 = 255;
/// The first VGPR's source code.
const VGPR: u32 = 256;

/// aco_ir.h's fixed registers (SSRC codes) as LLVM spells them; the first spelling of a code is how it prints.
const FIXED: &[(&str, u32)] = &[
    ("vcc_lo", 106),
    ("vcc", 106),
    ("vcc_hi", 107),
    ("m0", 124),
    ("null", NULL),
    ("off", NULL),
    ("exec_lo", 126),
    ("exec", 126),
    ("exec_hi", 127),
    ("vccz", 251),
    ("execz", 252),
    ("scc", 253),
];

/// The float inline constants of the GFX10 ISA (SSRC 240 ..= 247).
const FLOATS: &[(&str, u32)] = &[("0.5", 240), ("-0.5", 241), ("1.0", 242), ("-1.0", 243), ("2.0", 244), ("-2.0", 245), ("4.0", 246), ("-4.0", 247)];

/// ⭐ An operand: its 9-bit source code (VGPRs from 256), how many registers from there (a range), a literal if it
/// takes one, its modifiers.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct Operand {
    pub code: u32,
    pub len: u32,
    pub literal: Option<u32>,
    pub neg: bool,
    pub abs: bool,
}

impl Operand {
    const fn plain(code: u32) -> Self {
        Operand { code, len: 1, literal: None, neg: false, abs: false }
    }

    /// `n` registers from SGPR `r`.
    pub const fn sgpr(r: u32, n: u32) -> Self {
        Operand { len: n, ..Self::plain(r) }
    }

    /// `n` registers from VGPR `r`.
    pub const fn vgpr(r: u32, n: u32) -> Self {
        Operand { len: n, ..Self::plain(VGPR + r) }
    }

    /// The VGPRs it names (none for anything else).
    pub fn vgprs(&self) -> core::ops::Range<u32> {
        match self.code {
            c @ VGPR.. => c - VGPR..c - VGPR + self.len,
            _ => 0..0,
        }
    }
}

/// An inline integer constant or a literal.
impl From<i64> for Operand {
    fn from(v: i64) -> Self {
        match v {
            0..=64 => Self::plain(128 + v as u32),
            -16..=-1 => Self::plain((192 - v) as u32),
            _ => Operand { literal: Some(v as u32), ..Self::plain(LITERAL) },
        }
    }
}

impl TryFrom<&str> for Operand {
    type Error = Error;

    fn try_from(s: &str) -> Result<Operand, Error> {
        let s = s.trim();
        if let Some(r) = s.strip_prefix('-').filter(|r| !r.starts_with(|c: char| c.is_ascii_digit() || c == '.')) {
            return Operand::try_from(r).map(|o| Operand { neg: true, ..o });
        }
        if let Some(r) = s.strip_prefix('|').and_then(|r| r.strip_suffix('|')) {
            return Operand::try_from(r).map(|o| Operand { abs: true, ..o });
        }
        // a register or a range `x[a:b]`
        let range = |p: &str| -> Option<(u32, u32)> {
            let r = s.strip_prefix(p)?;
            match r.strip_prefix('[').and_then(|r| r.strip_suffix(']')) {
                Some(r) => {
                    let (a, b) = r.split_once(':')?;
                    let (a, b) = (a.parse::<u32>().ok()?, b.parse::<u32>().ok()?);
                    (b >= a).then_some((a, b - a + 1))
                }
                None => Some((r.parse().ok()?, 1)),
            }
        };
        if let Some((r, n)) = range("v") {
            return Ok(Operand::vgpr(r, n));
        }
        if let Some((r, n)) = range("s") {
            return Ok(Operand::sgpr(r, n));
        }
        if let Some((_, c)) = FIXED.iter().chain(FLOATS).find(|(n, _)| *n == s) {
            // `vcc` / `exec`: the pair
            return Ok(Operand { len: if matches!(s, "vcc" | "exec") { 2 } else { 1 }, ..Operand::plain(*c) });
        }
        let v = match s.strip_prefix("0x") {
            Some(h) => i64::from_str_radix(h, 16),
            None => s.parse(),
        };
        v.map(Operand::from).map_err(|_| Error(format!("{s}: not an operand")))
    }
}

/// As LLVM spells it.
impl fmt::Display for Operand {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        let (open, close) = if self.abs { ("|", "|") } else { ("", "") };
        let neg = if self.neg { "-" } else { "" };
        write!(f, "{neg}{open}")?;
        let range = |f: &mut fmt::Formatter<'_>, file: &str, r: u32| if self.len == 1 { write!(f, "{file}{r}") } else { write!(f, "{file}[{r}:{}]", r + self.len - 1) };
        match self.code {
            c @ VGPR.. => range(f, "v", c - VGPR)?,
            c @ 0..106 => range(f, "s", c)?,
            LITERAL => write!(f, "{:#x}", self.literal.unwrap_or(0))?,
            c @ 128..=192 => write!(f, "{}", c - 128)?,
            c @ 193..=208 => write!(f, "-{}", c - 192)?,
            c => match FIXED.iter().chain(FLOATS).find(|(_, k)| *k == c) {
                Some((n, _)) if self.len == 2 && matches!(*n, "vcc_lo" | "exec_lo") => f.write_str(&n[..n.len() - 3])?,
                Some((n, _)) => f.write_str(n)?,
                None => return Err(fmt::Error),
            },
        }
        f.write_str(close)
    }
}

/// As an op's property holds it (its LLVM spelling).
impl From<Operand> for Attribute<'_> {
    fn from(o: Operand) -> Self {
        Attribute::Str { lit: o.to_string().into(), ty: None }
    }
}

impl Serialize for Operand {
    fn serialize<S: Serializer>(&self, s: S) -> Result<S::Ok, S::Error> {
        s.collect_str(self)
    }
}

impl<'de> Deserialize<'de> for Operand {
    fn deserialize<D: Deserializer<'de>>(d: D) -> Result<Self, D::Error> {
        struct V;
        impl serde::de::Visitor<'_> for V {
            type Value = Operand;
            fn expecting(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
                f.write_str("an operand as LLVM spells it")
            }
            fn visit_str<E: serde::de::Error>(self, s: &str) -> Result<Operand, E> {
                Operand::try_from(s).map_err(E::custom)
            }
            fn visit_i64<E: serde::de::Error>(self, v: i64) -> Result<Operand, E> {
                Ok(v.into())
            }
            fn visit_u64<E: serde::de::Error>(self, v: u64) -> Result<Operand, E> {
                i64::try_from(v).map(Operand::from).map_err(E::custom)
            }
        }
        d.deserialize_any(V)
    }
}

impl TryFrom<&str> for Opcode {
    type Error = Error;

    /// By mnemonic: its hash searched in [`HASHES`], then the name compared once.
    fn try_from(s: &str) -> Result<Opcode, Error> {
        let h = s.bytes().fold(0xcbf2_9ce4_8422_2325, |h, b| (h ^ u64::from(b)).wrapping_mul(0x0100_0000_01b3));
        HASHES.binary_search_by_key(&h, |(k, _)| *k).ok().map(|k| HASHES[k].1).filter(|o| o.name() == s).ok_or_else(|| Error(format!("{s}: not a GFX10 instruction")))
    }
}

impl Serialize for Opcode {
    fn serialize<S: Serializer>(&self, s: S) -> Result<S::Ok, S::Error> {
        s.serialize_str(self.name())
    }
}

impl<'de> Deserialize<'de> for Opcode {
    fn deserialize<D: Deserializer<'de>>(d: D) -> Result<Self, D::Error> {
        struct V;
        impl serde::de::Visitor<'_> for V {
            type Value = Opcode;
            fn expecting(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
                f.write_str("a GFX10 mnemonic")
            }
            fn visit_str<E: serde::de::Error>(self, s: &str) -> Result<Opcode, E> {
                Opcode::try_from(s).map_err(E::custom)
            }
        }
        d.deserialize_str(V)
    }
}

/// ⭐ The field a virtual instruction's SSA operand goes to.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Slot {
    Src0,
    Src1,
    Src2,
    Addr,
    Data,
    Data0,
    Data1,
    Saddr,
    Sbase,
}

impl Slot {
    /// The field's name (an op's property key).
    pub const fn key(self) -> &'static str {
        match self {
            Slot::Src0 => "src0",
            Slot::Src1 => "src1",
            Slot::Src2 => "src2",
            Slot::Addr => "addr",
            Slot::Data => "data",
            Slot::Data0 => "data0",
            Slot::Data1 => "data1",
            Slot::Saddr => "saddr",
            Slot::Sbase => "sbase",
        }
    }
}

/// By its key (`"src0"`): how both the typed ops and [`Build`] spell it.
impl Serialize for Slot {
    fn serialize<S: Serializer>(&self, s: S) -> Result<S::Ok, S::Error> {
        s.serialize_str(self.key())
    }
}

impl<'de> Deserialize<'de> for Slot {
    fn deserialize<D: Deserializer<'de>>(d: D) -> Result<Self, D::Error> {
        struct V;
        impl serde::de::Visitor<'_> for V {
            type Value = Slot;
            fn expecting(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
                f.write_str("a slot")
            }
            fn visit_str<E: serde::de::Error>(self, s: &str) -> Result<Slot, E> {
                Slot::try_from(s).map_err(E::custom)
            }
        }
        d.deserialize_str(V)
    }
}

/// `rdna2.isa.salu`: SOP1 / SOP2 / SOPC / SOPK / SOPP.
#[mlir::op("rdna2.isa.salu", format = "(`(` $operands^ `:` type($operands) `)`)? attr-dict (`->` type($results)^)?", results(results))]
pub struct Salu<'a> {
    pub op: Opcode,
    pub dst: Option<Operand>,
    pub src0: Option<Operand>,
    pub src1: Option<Operand>,
    pub simm16: Option<i64>,
    #[slot(types)]
    pub operands: Vec<Value<'a>>,
    pub types: Vec<Type<'a>>,
    pub slots: Option<Vec<Slot>>,
    pub results: Vec<Type<'a>>,
}

/// `rdna2.isa.valu`: VOP1 / VOP2 / VOPC (`vop3`: in the VOP3 encoding) / VOP3.
#[mlir::op("rdna2.isa.valu", format = "(`(` $operands^ `:` type($operands) `)`)? attr-dict (`->` type($results)^)?", results(results))]
pub struct Valu<'a> {
    pub op: Opcode,
    pub dst: Option<Operand>,
    pub sdst: Option<Operand>,
    pub src0: Option<Operand>,
    pub src1: Option<Operand>,
    pub src2: Option<Operand>,
    pub vop3: bool,
    pub clamp: bool,
    pub omod: Option<u32>,
    #[slot(types)]
    pub operands: Vec<Value<'a>>,
    pub types: Vec<Type<'a>>,
    pub slots: Option<Vec<Slot>>,
    pub results: Vec<Type<'a>>,
}

/// `rdna2.isa.smem`: SMEM.
#[mlir::op("rdna2.isa.smem", format = "(`(` $operands^ `:` type($operands) `)`)? attr-dict (`->` type($results)^)?", results(results))]
pub struct Smem<'a> {
    pub op: Opcode,
    pub dst: Option<Operand>,
    pub data: Option<Operand>,
    pub sbase: Option<Operand>,
    pub soffset: Option<Operand>,
    pub offset: Option<i64>,
    pub glc: bool,
    pub dlc: bool,
    #[slot(types)]
    pub operands: Vec<Value<'a>>,
    pub types: Vec<Type<'a>>,
    pub slots: Option<Vec<Slot>>,
    pub results: Vec<Type<'a>>,
}

/// `rdna2.isa.flat`: GLOBAL / FLAT / SCRATCH.
#[mlir::op("rdna2.isa.flat", format = "(`(` $operands^ `:` type($operands) `)`)? attr-dict (`->` type($results)^)?", results(results))]
pub struct Flat<'a> {
    pub op: Opcode,
    pub dst: Option<Operand>,
    pub addr: Option<Operand>,
    pub data: Option<Operand>,
    pub saddr: Option<Operand>,
    pub offset: Option<i64>,
    pub glc: bool,
    pub slc: bool,
    pub dlc: bool,
    #[slot(types)]
    pub operands: Vec<Value<'a>>,
    pub types: Vec<Type<'a>>,
    pub slots: Option<Vec<Slot>>,
    pub results: Vec<Type<'a>>,
}

/// `rdna2.isa.ds`: DS.
#[mlir::op("rdna2.isa.ds", format = "(`(` $operands^ `:` type($operands) `)`)? attr-dict (`->` type($results)^)?", results(results))]
pub struct Ds<'a> {
    pub op: Opcode,
    pub dst: Option<Operand>,
    pub addr: Option<Operand>,
    pub data0: Option<Operand>,
    pub data1: Option<Operand>,
    pub offset0: Option<i64>,
    pub offset1: Option<i64>,
    pub gds: bool,
    #[slot(types)]
    pub operands: Vec<Value<'a>>,
    pub types: Vec<Type<'a>>,
    pub slots: Option<Vec<Slot>>,
    pub results: Vec<Type<'a>>,
}

/// The instruction ops.
#[mlir::dialect("rdna2", ops = [Salu, Valu, Smem, Flat, Ds])]
pub(crate) struct IsaOps;

/// A modifier or encoding switch of an instruction (its unit property).
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Flag {
    Vop3,
    Clamp,
    Glc,
    Slc,
    Dlc,
    Gds,
}

impl Flag {
    const fn key(self) -> &'static str {
        match self {
            Flag::Vop3 => "vop3",
            Flag::Clamp => "clamp",
            Flag::Glc => "glc",
            Flag::Slc => "slc",
            Flag::Dlc => "dlc",
            Flag::Gds => "gds",
        }
    }
}

/// ⭐ A virtual instruction built straight into an [`OpData`] (the compiler makes thousands; going through the typed
/// op's generic form costs more than the rest of the lowering): family `O`, its mnemonic, SSA operands into `slots`,
/// results (`dst`). What it builds reads back as `O` ([`Isa::read`]).
pub struct Build<'a> {
    data: OpData<'a>,
    results: Vec<Type<'a>>,
}

impl<'a> Build<'a> {
    pub fn new<O: mlirformat::Op>(op: Opcode, operands: &[ValueId], slots: &[Slot], results: Vec<Type<'a>>) -> Self {
        let mut data = OpData::build(O::NAME).operands(operands).with("op", Attribute::Str { lit: op.name().into(), ty: None });
        if !slots.is_empty() {
            data.set("slots", Attribute::Array(slots.iter().map(|s| Attribute::Str { lit: s.key().into(), ty: None }).collect()));
        }
        Build { data, results }
    }

    /// Constant source `slot`.
    pub fn source(mut self, slot: Slot, o: Operand) -> Self {
        self.data.set(slot.key(), o.into());
        self
    }

    pub fn flag(mut self, f: Flag) -> Self {
        self.data.set(f.key(), Attribute::Unit);
        self
    }

    /// SOPK / SOPP's immediate.
    pub fn simm16(mut self, v: i64) -> Self {
        self.data.set("simm16", Attribute::integer(v.into(), Type::int(64)));
        self
    }

    /// The op and its results' types, for `create`.
    pub fn split(self) -> (OpData<'a>, Vec<Type<'a>>) {
        (self.data, self.results)
    }
}

/// ⭐ A field of an instruction op (its property key), read into this first.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Key {
    Op,
    Slots,
    Reg(Reg),
    Flag(Flag),
    Int(Int),
}

/// A register or constant field (an [`Operand`]).
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Reg {
    Dst,
    Sdst,
    Src0,
    Src1,
    Src2,
    Addr,
    Data,
    Data0,
    Data1,
    Saddr,
    Sbase,
    Soffset,
}

/// An integer field.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Int {
    Simm16,
    Offset,
    Offset0,
    Offset1,
    Omod,
}

impl Reg {
    const ALL: usize = 12;
}

impl From<Slot> for Reg {
    fn from(s: Slot) -> Self {
        match s {
            Slot::Src0 => Reg::Src0,
            Slot::Src1 => Reg::Src1,
            Slot::Src2 => Reg::Src2,
            Slot::Addr => Reg::Addr,
            Slot::Data => Reg::Data,
            Slot::Data0 => Reg::Data0,
            Slot::Data1 => Reg::Data1,
            Slot::Saddr => Reg::Saddr,
            Slot::Sbase => Reg::Sbase,
        }
    }
}

impl TryFrom<&str> for Key {
    type Error = Error;

    fn try_from(k: &str) -> Result<Key, Error> {
        Ok(match k {
            "op" => Key::Op,
            "slots" => Key::Slots,
            "dst" => Key::Reg(Reg::Dst),
            "sdst" => Key::Reg(Reg::Sdst),
            "src0" => Key::Reg(Reg::Src0),
            "src1" => Key::Reg(Reg::Src1),
            "src2" => Key::Reg(Reg::Src2),
            "addr" => Key::Reg(Reg::Addr),
            "data" => Key::Reg(Reg::Data),
            "data0" => Key::Reg(Reg::Data0),
            "data1" => Key::Reg(Reg::Data1),
            "saddr" => Key::Reg(Reg::Saddr),
            "sbase" => Key::Reg(Reg::Sbase),
            "soffset" => Key::Reg(Reg::Soffset),
            "vop3" => Key::Flag(Flag::Vop3),
            "clamp" => Key::Flag(Flag::Clamp),
            "glc" => Key::Flag(Flag::Glc),
            "slc" => Key::Flag(Flag::Slc),
            "dlc" => Key::Flag(Flag::Dlc),
            "gds" => Key::Flag(Flag::Gds),
            "simm16" => Key::Int(Int::Simm16),
            "offset" => Key::Int(Int::Offset),
            "offset0" => Key::Int(Int::Offset0),
            "offset1" => Key::Int(Int::Offset1),
            "omod" => Key::Int(Int::Omod),
            _ => return Err(Error(format!("{k}: not an instruction field"))),
        })
    }
}

impl TryFrom<&str> for Slot {
    type Error = Error;

    fn try_from(k: &str) -> Result<Slot, Error> {
        match Key::try_from(k)? {
            Key::Reg(Reg::Src0) => Ok(Slot::Src0),
            Key::Reg(Reg::Src1) => Ok(Slot::Src1),
            Key::Reg(Reg::Src2) => Ok(Slot::Src2),
            Key::Reg(Reg::Addr) => Ok(Slot::Addr),
            Key::Reg(Reg::Data) => Ok(Slot::Data),
            Key::Reg(Reg::Data0) => Ok(Slot::Data0),
            Key::Reg(Reg::Data1) => Ok(Slot::Data1),
            Key::Reg(Reg::Saddr) => Ok(Slot::Saddr),
            Key::Reg(Reg::Sbase) => Ok(Slot::Sbase),
            _ => Err(Error(format!("{k}: not a slot"))),
        }
    }
}

/// The five instruction ops.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Family {
    Salu,
    Valu,
    Smem,
    Flat,
    Ds,
}

impl Family {
    /// The family of an op named `name`, if it is an instruction.
    pub fn of(name: &str) -> Option<Family> {
        use mlirformat::Op;
        [(Salu::NAME, Family::Salu), (Valu::NAME, Family::Valu), (Smem::NAME, Family::Smem), (Flat::NAME, Family::Flat), (Ds::NAME, Family::Ds)].into_iter().find(|(n, _)| *n == name).map(|(_, f)| f)
    }

    /// The family of a format.
    const fn holds(format: Format) -> Option<Family> {
        Some(match format {
            Format::Sop1 | Format::Sop2 | Format::Sopk | Format::Sopp | Format::Sopc => Family::Salu,
            Format::Vop1 | Format::Vop2 | Format::Vopc | Format::Vop3 => Family::Valu,
            Format::Smem => Family::Smem,
            Format::Global | Format::Flat | Format::Scratch => Family::Flat,
            Format::Ds => Family::Ds,
            _ => return None,
        })
    }
}

/// ⭐ An instruction read in one pass over its attributes, no generic form (the encoder and the passes after the
/// lowering read every instruction; the typed ops [`Salu`] ... are for reading and printing modules).
#[derive(Clone, Debug)]
pub struct Fields {
    pub family: Family,
    pub op: Opcode,
    regs: [Option<Operand>; Reg::ALL],
    flags: u8,
    ints: [Option<i64>; 5],
    pub slots: Vec<Slot>,
    /// How many results it has (virtual: its `dst`).
    pub results: usize,
}

impl Fields {
    pub fn reg(&self, r: Reg) -> Option<Operand> {
        self.regs[r as usize]
    }

    pub fn flag(&self, f: Flag) -> bool {
        self.flags & (1 << f as u8) != 0
    }

    pub fn int(&self, i: Int) -> Option<i64> {
        self.ints[i as usize]
    }

    /// Its register and constant fields that are there (allocated: what it reads and writes).
    pub fn fields(&self) -> impl Iterator<Item = Operand> + '_ {
        self.regs.iter().flatten().copied()
    }

    /// A global load: its destination written some time later (VM_CNT).
    pub fn global_load(&self) -> bool {
        self.op.format() == Format::Global && (self.results > 0 || self.reg(Reg::Dst).is_some())
    }

    /// Instruction `d` of family `family`.
    fn read(family: Family, d: &OpData<'_>) -> Result<Fields, Error> {
        let mut op = None;
        let mut f = Fields { family, op: Opcode::SNop, regs: [None; Reg::ALL], flags: 0, ints: [None; 5], slots: Vec::new(), results: d.results.len() };
        let int = |v: &Attribute<'_>| crate::Attrs::as_int(v);
        for a in d.properties.iter().chain(&d.attributes) {
            // a unit attribute has no value
            let v = a.value.as_ref().unwrap_or(&Attribute::Unit);
            match Key::try_from(&*a.name)? {
                Key::Op => match v {
                    Attribute::Str { lit, .. } => op = Some(Opcode::try_from(&**lit)?),
                    _ => return Err(Error(format!("op = {v}"))),
                },
                Key::Slots => match v {
                    Attribute::Array(s) => {
                        f.slots = s
                            .iter()
                            .map(|x| match x {
                                Attribute::Str { lit, .. } => Slot::try_from(&**lit),
                                _ => Err(Error(format!("slot {x}"))),
                            })
                            .collect::<Result<_, _>>()?
                    }
                    _ => return Err(Error(format!("slots = {v}"))),
                },
                Key::Reg(r) => {
                    f.regs[r as usize] = Some(match v {
                        Attribute::Str { lit, .. } => Operand::try_from(&**lit)?,
                        _ => Operand::from(int(v)?),
                    })
                }
                Key::Flag(g) => f.flags |= u8::from(matches!(v, Attribute::Unit | Attribute::Bool(true))) << g as u8,
                Key::Int(i) => f.ints[i as usize] = Some(int(v)?),
            }
        }
        f.op = op.ok_or_else(|| Error(format!("{}: no op", d.name)))?;
        if Family::holds(f.op.format()) != Some(family) {
            return Err(Error(format!("{:?} is {:?}, not in {family:?}", f.op, f.op.format())));
        }
        Ok(f)
    }
}

/// Its source code, `default` when absent.
fn code(o: Option<Operand>, default: u32) -> u32 {
    o.map_or(default, |o| o.code)
}

/// ⭐ An instruction's dwords: the encoding's, then the literal one of its sources takes.
pub struct Words(pub Vec<u32>);

impl TryFrom<&Fields> for Words {
    type Error = Error;

    fn try_from(i: &Fields) -> Result<Words, Error> {
        let (op, c) = (i.op, i.op.code());
        let r = |x: Reg| i.reg(x);
        let need = |x: Reg| r(x).map(|o| o.code).ok_or_else(|| Error(format!("{op:?} needs {x:?}")));
        let n = |x: Int| i.int(x).unwrap_or(0);
        let simm16 = n(Int::Simm16) as u32 & 0xffff;
        let (dw, sources) = match op.format() {
            Format::Sop2 => (vec![(0b10 << 30) | (c << 23) | (code(r(Reg::Dst), 0) << 16) | (code(r(Reg::Src1), 0) << 8) | code(r(Reg::Src0), 0)], [Reg::Src0, Reg::Src1].as_slice()),
            // the destination field holds the source when there is no destination (s_cmpk_*)
            Format::Sopk => (vec![(0b1011 << 28) | (c << 23) | (code(r(Reg::Dst).or(r(Reg::Src0)), 0) << 16) | simm16], [].as_slice()),
            Format::Sop1 => (vec![(0b1_0111_1101 << 23) | (code(r(Reg::Dst), 0) << 16) | (c << 8) | code(r(Reg::Src0), 0)], [Reg::Src0].as_slice()),
            Format::Sopc => (vec![(0b1_0111_1110 << 23) | (c << 16) | (code(r(Reg::Src1), 0) << 8) | code(r(Reg::Src0), 0)], [Reg::Src0, Reg::Src1].as_slice()),
            Format::Sopp => (vec![(0b1_0111_1111 << 23) | (c << 16) | simm16], [].as_slice()),
            Format::Smem => {
                let w0 = (0b11_1101 << 26) | (c << 18) | (u32::from(i.flag(Flag::Glc)) << 16) | (u32::from(i.flag(Flag::Dlc)) << 14) | (code(r(Reg::Dst).or(r(Reg::Data)), 0) << 6) | (need(Reg::Sbase)? >> 1);
                (vec![w0, (code(r(Reg::Soffset), NULL) << 25) | (n(Int::Offset) as u32 & 0x1f_ffff)], [].as_slice())
            }
            Format::Vop2 if !i.flag(Flag::Vop3) => (vec![(c << 25) | ((need(Reg::Dst)? & 0xff) << 17) | ((need(Reg::Src1)? & 0xff) << 9) | need(Reg::Src0)?], [Reg::Src0, Reg::Src1].as_slice()),
            Format::Vop1 if !i.flag(Flag::Vop3) => (vec![(0b011_1111 << 25) | ((code(r(Reg::Dst), 0) & 0xff) << 17) | (c << 9) | code(r(Reg::Src0), 0)], [Reg::Src0].as_slice()),
            Format::Vopc if !i.flag(Flag::Vop3) => (vec![(0b011_1110 << 25) | (c << 17) | ((need(Reg::Src1)? & 0xff) << 9) | need(Reg::Src0)?], [Reg::Src0, Reg::Src1].as_slice()),
            f @ (Format::Vop1 | Format::Vop2 | Format::Vopc | Format::Vop3) => {
                // emit_vop3_instruction: VOP2 at 0x100 +, VOP1 at 0x180 +, VOPC as it is; unused sources inline 0
                let c = c + match f {
                    Format::Vop2 => 0x100,
                    Format::Vop1 => 0x180,
                    _ => 0,
                };
                let srcs = [r(Reg::Src0), r(Reg::Src1), r(Reg::Src2)];
                let bits = |f: fn(&Operand) -> bool| srcs.iter().enumerate().map(|(k, o)| u32::from(o.as_ref().is_some_and(f)) << k).sum::<u32>();
                let sdst = r(Reg::Sdst).map_or(0, |o| o.code << 8);
                let w0 = (0b11_0101 << 26) | (c << 16) | (u32::from(i.flag(Flag::Clamp)) << 15) | (bits(|o| o.abs) << 8) | sdst | (code(r(Reg::Dst), 0) & 0xff);
                let w1 = (bits(|o| o.neg) << 29) | ((n(Int::Omod) as u32 & 3) << 27) | (code(srcs[2], 128) << 18) | (code(srcs[1], 128) << 9) | code(srcs[0], 128);
                (vec![w0, w1], [Reg::Src0, Reg::Src1, Reg::Src2].as_slice())
            }
            f @ (Format::Global | Format::Flat | Format::Scratch) => {
                // emit_flatlike_instruction (GFX10): 12-bit offset (not for FLAT), seg 1 scratch / 2 global
                let seg = match f {
                    Format::Scratch => 1,
                    Format::Global => 2,
                    _ => 0,
                };
                let offset = n(Int::Offset);
                if f == Format::Flat && offset != 0 || !(-2048..=2047).contains(&offset) {
                    return Err(Error(format!("{op:?}: offset {offset}")));
                }
                let w0 = (0b11_0111 << 26) | (c << 18) | (u32::from(i.flag(Flag::Slc)) << 17) | (u32::from(i.flag(Flag::Glc)) << 16) | (seg << 14) | (u32::from(i.flag(Flag::Dlc)) << 12) | (offset as u32 & 0xfff);
                let w1 = ((code(r(Reg::Dst), VGPR) & 0xff) << 24) | (code(r(Reg::Saddr), NULL) << 16) | ((code(r(Reg::Data), VGPR) & 0xff) << 8) | (need(Reg::Addr)? & 0xff);
                (vec![w0, w1], [].as_slice())
            }
            Format::Ds => {
                let w0 = (0b11_0110 << 26) | (c << 18) | (u32::from(i.flag(Flag::Gds)) << 17) | ((n(Int::Offset1) as u32 & 0xff) << 8) | (n(Int::Offset0) as u32 & 0xffff);
                let v = |x: Reg| code(r(x), VGPR) & 0xff;
                (vec![w0, (v(Reg::Dst) << 24) | (v(Reg::Data1) << 16) | (v(Reg::Data0) << 8) | v(Reg::Addr)], [].as_slice())
            }
            f => return Err(Error(format!("{op:?}: {f:?} is not encoded yet"))),
        };
        let mut literal = None;
        for l in sources.iter().filter_map(|s| r(*s)?.literal) {
            match literal {
                Some(m) if m != l => return Err(Error(format!("{op:?}: two different literals"))),
                _ => literal = Some(l),
            }
        }
        let mut dw = dw;
        dw.extend(literal);
        Ok(Words(dw))
    }
}

/// ⭐ The encoder.
pub struct Isa;

impl Isa {
    /// ⭐ Instruction `op` of `body`, read; `None` when it is not one.
    pub fn read(body: &Body<'_>, op: OpId) -> Result<Option<Fields>, Error> {
        let d = &body[op];
        Family::of(&d.name).map(|f| Fields::read(f, d)).transpose()
    }

    /// ⭐ The dwords of instruction `op` of `body` (allocated: its registers in its fields).
    pub fn encode(body: &Body<'_>, op: OpId) -> Result<Vec<u32>, Error> {
        let i = Isa::read(body, op)?.ok_or_else(|| Error(format!("{}: not an RDNA2 instruction", body[op].name)))?;
        Words::try_from(&i).map(|w| w.0)
    }
}
