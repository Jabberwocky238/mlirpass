//! PM4 command streams: registers gathered into `SET_*_REG` packets, streams padded.

use alloc::format;
use alloc::vec;
use alloc::vec::Vec;

use mlirformat::rdna2::{Pm4Nop, Pm4Space, RDNA2, Rdna2Word as Word};
use mlirformat::{Attribute, Error, Op};

use crate::{Attrs, BlockOps, Body, ImageStream, OpData, OpId, Pattern, PatternSet, Rewriter, Rewrites};

const REG: &str = Pm4Space::REG;

const PAD_MASK: usize = 7;

pub struct Pm4;

impl Pm4 {
    fn addr(body: &Body<'_>, op: OpId) -> Result<u32, Error> {
        RDNA2.get(&body[op].name).map(|i| i.num).ok_or_else(|| Error(format!("{}: no such register", body[op].name)))
    }

    fn regs<'b, 'a>(body: &'b Body<'a>, op: OpId) -> BlockOps<'b, 'a> {
        body.ops(body.top_block(op))
    }

    fn len(body: &Body<'_>, op: OpId) -> Result<usize, Error> {
        let name = &*body[op].name;
        if Pm4Space::named(name).is_some() {
            return Ok(2 + Pm4::regs(body, op).len());
        }
        let attrs = body[op].all_attrs();
        let words: usize = Attrs(&attrs).array("body")?.iter().map(|e| if matches!(e, Attribute::Array(q) if q.len() == 1) { 2 } else { 1 }).sum();
        Ok(1 + words)
    }

    fn stream_of(body: &Body<'_>, op: OpId) -> Option<OpId> {
        let region = body[op].parent.and_then(|b| body[b].parent)?;
        let parent = body[region].parent;
        (body[parent].name == ImageStream::NAME).then_some(parent)
    }

    fn next(body: &Body<'_>, op: OpId) -> Option<OpId> {
        body.next_op(op)
    }
}

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
        let Some(space) = Pm4::addr(rw.body, op).ok().and_then(Pm4Space::of) else { return false };
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
        if Pm4Space::named(&body[op].name).is_none() {
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

    pub fn pad(body: &mut Body<'_>, op: OpId) {
        let mut patterns = PatternSet::default();
        patterns.add(PadStream);
        Rewrites::apply(body, op, &patterns);
    }
}

crate::rewrites! {
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
        rw.emit(&Pm4Nop { body: zeros, ..Default::default() });
        true
    }
}
