//! ⭐ Xe3 out: each `xe3.kernel` (registers allocated, SWSB set) ⇒ its instructions' bytes ([`Xe3Code`]); a module
//! of memories ⇒ an [`Image`](crate::Image) ([`Xe3Image`], [`XE3_IMAGE`]); and what the last passes do:
//!
//! - `xe3-pad`: every `xe3.kernel` gets `pad = 128`, the zeros after its instructions (the EU prefetches past the
//!   end);
//! - `xe3-end`: every `image.stream` (a batch buffer) ends with `xe3.cmd.mi_batch_buffer_end`, and an
//!   `xe3.cmd.mi_noop` when that leaves it an odd number of dwords (a batch is qwords);
//! - `xe3-layout`: GPU addresses ([`ImageLayout`](crate::ImageLayout) for Xe3).

use alloc::borrow::ToOwned;
use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;

use mlirformat::{Error, Op};

use crate::{Body, CmdMiBatchBufferEnd, CmdMiNoop, Emit, Heads, ImageEmit, ImageStream, ImageTarget, Inst, Kernels, OpId, PatternSet, Rewrites, ShaderStage, Symbol, Updates, XE3, Xe3Kernel};

/// Where an EOT message's payload starts (EOT sources must be in r112 ..= r127).
pub const XE3_EOT_GRF: u8 = 112;

/// Zeros after a kernel (the EU prefetches past its end).
pub const XE3_KERNEL_PAD: u64 = 128;

/// ⭐ One kernel's machine code (its instructions, no padding) and its head (what the driver needs to run it).
#[derive(Clone, Debug, PartialEq, Eq)]
pub struct Xe3Code {
    pub name: String,
    pub stage: Option<ShaderStage>,
    pub bytes: Vec<u8>,
}

impl Xe3Code {
    /// Kernel `k`'s.
    pub fn of(body: &Body<'_>, k: OpId) -> Result<Xe3Code, Error> {
        let head = body.head::<Xe3Kernel>(k)?;
        let mut bytes = Vec::new();
        for i in body.ops(body.top_block(k)) {
            bytes.extend(Inst::try_from((&*body[i].name, &body[i].all_attrs()[..]))?.encode());
        }
        Ok(Xe3Code { name: Symbol::defined(&head.sym_name)?.to_owned(), stage: head.stage, bytes })
    }
}

/// ⭐ Xe3 as an [`Emit`] target: every kernel under an op.
pub struct Xe3Emit;

impl Emit for Xe3Emit {
    type Output = Vec<Xe3Code>;

    fn emit(&self, body: &Body<'_>, op: OpId) -> Result<Vec<Xe3Code>, Error> {
        Kernels::all(body, op, Xe3Kernel::NAME).into_iter().map(|k| Xe3Code::of(body, k)).collect()
    }
}

/// ⭐ Xe3 as an image target.
pub struct Xe3Image;

impl ImageTarget for Xe3Image {
    /// Below 4 GB: the state pointers are 32 bits.
    const BASE: u64 = 0x10_0000;
    const PAGE: u64 = 0x1_0000;

    /// A batch buffer: its `xe3.cmd` ops (ended by `xe3-end`).
    fn stream(&self, body: &Body<'_>, stream: OpId) -> Result<Vec<u8>, Error> {
        let mut dw = Vec::new();
        for c in body.ops(body.top_block(stream)) {
            dw.extend(XE3.pack(&body[c].name, &body[c].all_attrs())?);
        }
        Ok(Xe3Image::le(&dw))
    }

    /// An `xe3.kernel` (its instructions, then its `pad` zeros) or a state struct.
    fn item(&self, body: &Body<'_>, op: OpId) -> Result<Vec<u8>, Error> {
        match &*body[op].name {
            n if n == Xe3Kernel::NAME => {
                let mut bytes = Xe3Code::of(body, op)?.bytes;
                let pad = body.head::<Xe3Kernel>(op)?.pad.unwrap_or(0);
                bytes.resize(bytes.len() + pad as usize, 0);
                Ok(bytes)
            }
            name if name.starts_with("xe3.state.") => Ok(Xe3Image::le(&XE3.pack(name, &body[op].all_attrs())?)),
            name => Err(Error(format!("{name} cannot be placed in memory"))),
        }
    }
}

impl Xe3Image {
    fn le(dw: &[u32]) -> Vec<u8> {
        dw.iter().flat_map(|d| d.to_le_bytes()).collect()
    }

    /// ⭐ `xe3-pad`: every kernel's `pad`.
    pub fn pad(body: &mut Body<'_>, op: OpId) {
        let mut patterns = PatternSet::default();
        patterns.add(PadKernel);
        Rewrites::apply(body, op, &patterns);
    }

    /// ⭐ `xe3-end`: every batch ended.
    pub fn end(body: &mut Body<'_>, op: OpId) {
        let mut patterns = PatternSet::default();
        patterns.add(EndBatch);
        Rewrites::apply(body, op, &patterns);
    }
}

crate::rewrites! {
    /// A kernel without its `pad` gets the zeros the EU prefetches into.
    PadKernel((Xe3Kernel::NAME), 1) |rw, op| {
        if rw.body.head::<Xe3Kernel>(op).map_or(true, |k| k.pad.is_some()) {
            return false;
        }
        rw.update::<Xe3Kernel>(op, |k| k.pad = Some(XE3_KERNEL_PAD)).is_ok()
    }

    /// A batch not ended yet ends with MI_BATCH_BUFFER_END, and an MI_NOOP when that leaves it an odd number of
    /// dwords (a batch is qwords).
    EndBatch((ImageStream::NAME), 1) |rw, op| {
        let block = rw.body.top_block(op);
        let ops = rw.body.block_ops(block);
        if ops.iter().rev().find(|o| rw.body[**o].name != CmdMiNoop::NAME).is_some_and(|o| rw.body[*o].name == CmdMiBatchBufferEnd::NAME) {
            return false;
        }
        // MI_BATCH_BUFFER_END, and every command's length (one that does not pack fails the layout later)
        let dw: usize = 1 + ops.iter().map(|c| XE3.template(&rw.body[*c].name, &rw.body[*c].all_attrs()).map_or(0, |t| t.dw.len())).sum::<usize>();
        rw.set_end(block);
        rw.emit(&CmdMiBatchBufferEnd::default());
        if !dw.is_multiple_of(2) {
            rw.emit(&CmdMiNoop::default());
        }
        true
    }
}

/// ⭐ A module (after `xe3-layout`) as an [`Image`](crate::Image).
pub const XE3_IMAGE: ImageEmit<'_, Xe3Image> = ImageEmit(&Xe3Image);
