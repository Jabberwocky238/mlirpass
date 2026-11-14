use alloc::format;
use alloc::string::ToString;
use alloc::vec::Vec;

use mlirformat::{Error, Op};

use super::AGX;
use crate::{Body, Heads, ImageStream, OpData, OpId, PatternSet, Rewrites};

pub struct Agx;

impl Agx {
    pub fn bytes(body: &Body<'_>, op: OpId) -> Result<Vec<u8>, Error> {
        let name = &*body[op].name;
        let item = AGX.get(name).ok_or_else(|| Error(format!("{name} is not an agx struct")))?;
        let dw = AGX.pack(name, &body[op].all_attrs())?;
        Ok(dw.iter().flat_map(|d| d.to_le_bytes()).take(item.num as usize).collect())
    }

    pub fn end(body: &mut Body<'_>, op: OpId) -> Result<(), Error> {
        let mut streams = Vec::new();
        body.walk(op, &mut |o| {
            if body[o].name == ImageStream::NAME {
                streams.push(o);
            }
        });
        if let Some(s) = streams.into_iter().find(|s| Agx::terminate(body, *s).is_none()) {
            let name = body.head::<ImageStream>(s)?.sym_name.to_string();
            return Err(Error(format!("stream {name}: say cdm or vdm")));
        }
        let mut patterns = PatternSet::default();
        patterns.add(TerminateStream).add(TrapKernel);
        Rewrites::apply(body, op, &patterns);
        Ok(())
    }

    fn terminate(body: &Body<'_>, stream: OpId) -> Option<&'static str> {
        let s = body.head::<ImageStream>(stream).ok()?;
        match (s.cdm, s.vdm) {
            (true, false) => Some("agx.cdm_stream_terminate"),
            (false, true) => Some("agx.vdm_stream_terminate"),
            _ => None,
        }
    }
}

crate::rewrites! {
    TerminateStream((ImageStream::NAME), 1) |rw, op| {
        let Some(terminate) = Agx::terminate(rw.body, op) else { return false };
        let block = rw.body.top_block(op);
        if rw.body.last_op(block).is_some_and(|o| rw.body[o].name == terminate) {
            return false;
        }
        rw.set_end(block);
        rw.create(OpData::build(terminate), &[]);
        true
    }

    TrapKernel((super::AgxKernel::NAME), 1) |rw, op| {
        let block = rw.body.top_block(op);
        if rw.body.last_op(block).is_some_and(|o| rw.body[o].name == "agx.usc.trap") {
            return false;
        }
        rw.set_end(block);
        for _ in 0..8 {
            rw.create(OpData::build("agx.usc.trap"), &[]);
        }
        true
    }
}
