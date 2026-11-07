//! ⭐ AGX control streams: an `image.stream {cdm}` (compute) or `{vdm}` (vertex) of agx ops is the stream the
//! firmware hands to the CDM / VDM, as Mesa writes it (gallium agx_flush_compute, hk_queue, libagx_dgc.h):
//!
//! - `agx-end`: every stream ends with its `Stream Terminate` word (`agx.cdm_stream_terminate` /
//!   `agx.vdm_stream_terminate`); the command's `cdm_ctrl_stream_end` is the address after it (`Image::stream_end`);
//!   every kernel with eight `trap`s after its `stop` (Mesa agx_pack_binary's footer, "match the blob");
//! - `agx-layout`: GPU addresses ([`ImageLayout`](crate::ImageLayout) for AGX).
//!
//! Then [`Agx`] (and the target's `AgxImage`) packs each op as it is: a struct is its length in bytes (`Item::num`), not always whole dwords.

use alloc::format;
use alloc::string::ToString;
use alloc::vec::Vec;

use mlirformat::{Error, Op};

use super::AGX;
use crate::{Body, Heads, ImageStream, OpData, OpId, PatternSet, Rewrites};

/// ⭐ AGX's structs and streams.
pub struct Agx;

impl Agx {
    /// A struct op's bytes (its symbols numbers).
    pub fn bytes(body: &Body<'_>, op: OpId) -> Result<Vec<u8>, Error> {
        let name = &*body[op].name;
        let item = AGX.get(name).ok_or_else(|| Error(format!("{name} is not an agx struct")))?;
        let dw = AGX.pack(name, &body[op].all_attrs())?;
        Ok(dw.iter().flat_map(|d| d.to_le_bytes()).take(item.num as usize).collect())
    }

    /// ⭐ `agx-end`: every stream ended by its Stream Terminate, every kernel by its footer.
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

    /// The Stream Terminate of a stream's engine: it says `cdm` or `vdm`, not both.
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
    /// A stream that does not end with its engine's Stream Terminate gets it.
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

    /// A kernel without its footer gets the eight traps after its stop.
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

