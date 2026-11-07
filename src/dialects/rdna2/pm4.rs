//! ⭐ PM4: an `image.stream` of rdna2 ops is an indirect buffer, as Mesa writes it (src/amd/common ac_cmdbuf.h,
//! sid.h; the padding of radv's winsys). Two passes (`rdna2-pm4`, `rdna2-pad`: [`Pm4::into_packets`], [`Pm4::pad`]) put it in that shape, then every op packs on its own:
//!
//! ```text
//!   image.stream @s {
//!     rdna2.reg.compute_pgm_lo {value = ...}            rdna2-pm4: each register into the SET_*_REG of its space,
//!     rdna2.reg.compute_pgm_hi {...}             ⇒      then neighbours at consecutive addresses into one packet
//!     rdna2.pm4.dispatch_direct {body = [...], compute}   rdna2.pm4.set_sh_reg { rdna2.reg.compute_pgm_lo ...; ...hi }
//!   }                                                     rdna2.pm4.dispatch_direct {...}
//!                                                         rdna2.pm4.nop {body = [0, ...]}   rdna2-pad: to 8 dwords
//! ```
//!
//! - `rdna2.pm4.set_{config,sh,context,uconfig}_reg { registers }`: `PKT3(SET_*_REG, n, 0)`, the first register's
//!   dword offset in its space, the registers (`ac_cmdbuf_set_*_reg_seq`). The registers keep their symbols until
//!   the layout.
//! - `rdna2.pm4.<packet> {body = [...], predicate?, compute?}`: `PKT3(opcode, n - 1, predicate)` (with
//!   `PKT3_SHADER_TYPE_S(1)` for `compute`), then the body: an integer is a dword, `[v]` a qword (low dword first;
//!   `[@x]` an address). `rdna2.pm4.nop {body = []}` is `PKT3_NOP_PAD`, the NOP of no body.
//! - Padding (radv_amdgpu_cs_pad, `ib_pad_dw_mask` 7 for GFX and compute): one NOP to the next multiple of 8 dwords,
//!   8 for an empty buffer.

use alloc::format;
use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{Attribute, Error, Op};

use super::{RDNA2, RDNA2_PM4_OPCODES};
use crate::{Attrs, BlockOps, Body, Fill, ImageStream, OpData, OpId, Pattern, PatternSet, Rewriter, Rewrites};

/// A register space: its byte range and the packet that sets it (sid.h `SI_*_REG_OFFSET` / `_END`, `PKT3_SET_*`).
struct Space {
    start: u32,
    end: u32,
    op: &'static str,
}

const SPACES: &[Space] = &[
    Space { start: 0x8000, end: 0xb000, op: "rdna2.pm4.set_config_reg" },     // SI_CONFIG
    Space { start: 0xb000, end: 0xc000, op: "rdna2.pm4.set_sh_reg" },         // SI_SH
    Space { start: 0x28000, end: 0x30000, op: "rdna2.pm4.set_context_reg" },  // SI_CONTEXT
    Space { start: 0x30000, end: 0x40000, op: "rdna2.pm4.set_uconfig_reg" },  // CIK_UCONFIG
];

const REG: &str = "rdna2.reg.";
const NOP: &str = <super::Pm4Nop as mlirformat::Op>::NAME;

/// ⭐ A dword of a packet's body, or a qword (`[v]`; `[@x]`: an address the layout fills in).
#[derive(Clone, Debug, PartialEq, Eq)]
pub enum Word {
    Dword(u32),
    Qword(Fill),
}

impl<'a> From<&Word> for Attribute<'a> {
    fn from(w: &Word) -> Self {
        match w {
            Word::Dword(v) => Attribute::Int { lit: format!("{v:#x}").into(), ty: None },
            Word::Qword(f) => Attribute::Array(vec![f.into()]),
        }
    }
}

impl TryFrom<&Attribute<'_>> for Word {
    type Error = Error;

    fn try_from(a: &Attribute<'_>) -> Result<Word, Error> {
        match a {
            Attribute::Array(q) if q.len() == 1 => Fill::try_from(&q[0]).map(Word::Qword),
            _ => u32::try_from(Attrs::as_int(a)?).map(Word::Dword).map_err(|_| Error(format!("{a} is not a dword (a qword is [v])"))),
        }
    }
}

/// Through serde as mlirformat carries attributes: `Attribute` itself.
impl serde::Serialize for Word {
    fn serialize<S: serde::Serializer>(&self, s: S) -> Result<S::Ok, S::Error> {
        serde::Serialize::serialize(&Attribute::from(self), s)
    }
}

impl<'de> serde::Deserialize<'de> for Word {
    fn deserialize<D: serde::Deserializer<'de>>(d: D) -> Result<Self, D::Error> {
        Word::try_from(&crate::attribute_of(d)?).map_err(serde::de::Error::custom)
    }
}
/// `PKT3_NOP_PAD`: a NOP of no body (count 0x3fff).
const NOP_PAD: u32 = 0xffff_1000;
/// `ib_pad_dw_mask` of GFX and compute.
const PAD_MASK: usize = 7;

impl Space {
    fn of(addr: u32) -> Option<&'static Space> {
        SPACES.iter().find(|s| (s.start..s.end).contains(&addr))
    }

    fn named(op: &str) -> Option<&'static Space> {
        SPACES.iter().find(|s| s.op == op)
    }
}

/// ⭐ The PM4 of one op: what it packs to.
pub struct Pm4;

impl Pm4 {
    /// `PKT3(op, count, predicate)` (sid.h), with `PKT3_SHADER_TYPE_S(compute)`.
    fn header(opcode: u32, count: u32, predicate: bool, compute: bool) -> u32 {
        (3 << 30) | ((count & 0x3fff) << 16) | ((opcode & 0xff) << 8) | (u32::from(compute) << 1) | u32::from(predicate)
    }

    fn opcode(name: &str) -> Result<u32, Error> {
        RDNA2_PM4_OPCODES.binary_search_by(|(o, _)| o.cmp(&name)).map(|i| RDNA2_PM4_OPCODES[i].1).map_err(|_| Error(format!("{name} is not a PM4 packet")))
    }

    /// A register's byte offset.
    fn addr(body: &Body<'_>, op: OpId) -> Result<u32, Error> {
        RDNA2.get(&body[op].name).map(|i| i.num).ok_or_else(|| Error(format!("{}: no such register", body[op].name)))
    }

    /// The registers of a SET_*_REG packet.
    fn regs<'b, 'a>(body: &'b Body<'a>, op: OpId) -> BlockOps<'b, 'a> {
        body.ops(body.top_block(op))
    }

    /// ⭐ The dwords of one op of a stream (after `rdna2-pm4`; its symbols numbers once the layout ran).
    pub fn pack(body: &Body<'_>, op: OpId) -> Result<Vec<u32>, Error> {
        let name = &*body[op].name;
        if let Some(space) = Space::named(name) {
            let regs = Pm4::regs(body, op);
            let first = Pm4::addr(body, Pm4::regs(body, op).next().ok_or_else(|| Error(format!("{name} without registers")))?)?;
            let mut dw = vec![Pm4::header(Pm4::opcode(name)?, regs.len() as u32, false, false), (first - space.start) >> 2];
            for r in regs {
                dw.extend(RDNA2.pack(&body[r].name, &body[r].all_attrs())?);
            }
            return Ok(dw);
        }
        if name.starts_with(REG) {
            return Err(Error(format!("{name} outside a SET_*_REG packet: run rdna2-pm4")));
        }
        let attrs = body[op].all_attrs();
        let a = Attrs(&attrs);
        // a unit attribute is a name without a value
        let flag = |n: &str| attrs.iter().any(|x| x.name == n && x.value.as_ref().is_none_or(|v| matches!(v, Attribute::Bool(true) | Attribute::Unit)));
        let mut words = Vec::new();
        for e in a.array("body")? {
            match e {
                Attribute::Array(q) if q.len() == 1 => {
                    let v = Attrs::as_int(&q[0])? as u64;
                    words.extend([v as u32, (v >> 32) as u32]);
                }
                _ => words.push(u32::try_from(Attrs::as_int(e)?).map_err(|_| Error(format!("{name}: {e} is not a dword (a qword is [v])")))?),
            }
        }
        let opcode = Pm4::opcode(name)?;
        let head = match words.len() {
            0 if name == NOP => return Ok(vec![NOP_PAD]),
            0 => return Err(Error(format!("{name}: a packet has a body"))),
            n => Pm4::header(opcode, n as u32 - 1, flag("predicate"), flag("compute")),
        };
        Ok([vec![head], words].concat())
    }

    /// How many dwords an op packs to (symbols need no values for that).
    fn len(body: &Body<'_>, op: OpId) -> Result<usize, Error> {
        let name = &*body[op].name;
        if Space::named(name).is_some() {
            return Ok(2 + Pm4::regs(body, op).len());
        }
        let attrs = body[op].all_attrs();
        let words: usize = Attrs(&attrs).array("body")?.iter().map(|e| if matches!(e, Attribute::Array(q) if q.len() == 1) { 2 } else { 1 }).sum();
        Ok(1 + words)
    }

    /// The op the stream `op` is in, if it is directly in one.
    fn stream_of(body: &Body<'_>, op: OpId) -> Option<OpId> {
        let region = body[op].parent.and_then(|b| body[b].parent)?;
        let parent = body[region].parent;
        (body[parent].name == ImageStream::NAME).then_some(parent)
    }

    /// The op after `op` in its block.
    fn next(body: &Body<'_>, op: OpId) -> Option<OpId> {
        body.next_op(op)
    }
}

/// `rdna2.reg.*` directly in a stream ⇒ a SET_*_REG packet of its space holding it.
struct WrapRegister;

impl Pattern for WrapRegister {
    fn name(&self) -> &str {
        "WrapRegister"
    }

    fn root(&self) -> Option<&str> {
        None
    }

    fn rewrite(&self, rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        if !rw.body[op].name.starts_with(REG) || Pm4::stream_of(rw.body, op).is_none() {
            return false;
        }
        let Some(space) = Pm4::addr(rw.body, op).ok().and_then(Space::of) else { return false };
        rw.set_before(op);
        let set = rw.create_with(OpData::build(space.op), &[], |b, set| {
            let r = b.add_region(set);
            b.add_block(r, &[]);
        });
        let block = rw.body.top_block(set);
        rw.move_before(op, block, None);
        true
    }
}

/// A SET_*_REG packet followed by one of the same space whose first register comes right after its last: one packet.
struct MergeSets;

impl Pattern for MergeSets {
    fn name(&self) -> &str {
        "MergeSets"
    }

    fn root(&self) -> Option<&str> {
        None
    }

    fn rewrite(&self, rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let body = &*rw.body;
        if Space::named(&body[op].name).is_none() {
            return false;
        }
        let Some(next) = Pm4::next(body, op).filter(|n| body[*n].name == body[op].name) else { return false };
        let (Some(last), Some(first)) = (Pm4::regs(body, op).next_back(), Pm4::regs(body, next).next()) else { return false };
        let (Ok(last), Ok(first)) = (Pm4::addr(body, last), Pm4::addr(body, first)) else { return false };
        if first != last + 4 {
            return false;
        }
        let into = body.top_block(op);
        for r in Pm4::regs(body, next).collect::<Vec<_>>() {
            rw.move_before(r, into, None);
        }
        rw.erase_op(next);
        true
    }
}

impl Pm4 {
    /// ⭐ `rdna2-pm4`: every register in a stream into SET_*_REG packets, as few as the addresses allow.
    pub fn into_packets(body: &mut Body<'_>, op: OpId) -> Result<(), Error> {
    let mut patterns = PatternSet::default();
    patterns.add(WrapRegister).add(MergeSets);
    Rewrites::apply(body, op, &patterns);
    let mut stray = Vec::new();
    body.walk(op, &mut |o| {
        if body[o].name.starts_with(REG) && Pm4::stream_of(body, o).is_some() {
            stray.push(o);
        }
    });
    match stray.first() {
        Some(o) => Err(Error(format!("{} ({:#x}) is in no register space a packet sets", body[*o].name, Pm4::addr(body, *o).unwrap_or(0)))),
        None => Ok(()),
    }
    }

    /// ⭐ `rdna2-pad`: every stream to a multiple of 8 dwords.
    pub fn pad(body: &mut Body<'_>, op: OpId) {
        let mut patterns = PatternSet::default();
        patterns.add(PadStream);
        Rewrites::apply(body, op, &patterns);
    }
}

crate::rewrites! {
    /// A stream not a multiple of 8 dwords (or empty) ends with the NOP that makes it one: n dwords, the header and
    /// n - 1 of body (none: PKT3_NOP_PAD). One that does not pack is left to the image (it fails there).
    PadStream((ImageStream::NAME), 1) |rw, op| {
        let block = rw.body.top_block(op);
        let Ok(dw) = rw.body.ops(block).map(|o| Pm4::len(rw.body, o)).sum::<Result<usize, _>>() else { return false };
        let n = match dw & PAD_MASK {
            0 if dw == 0 => PAD_MASK + 1,
            0 => return false,
            r => PAD_MASK + 1 - r,
        };
        let zeros = vec![Word::Dword(0); n - 1];
        rw.set_end(block);
        rw.emit(&super::Pm4Nop { body: zeros, ..Default::default() });
        true
    }
}

