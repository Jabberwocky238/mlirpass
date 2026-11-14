use alloc::borrow::ToOwned;
use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;

use mlirformat::{Error, Op};

use crate::{Body, CmdMiBatchBufferEnd, CmdMiNoop, Emit, Heads, ImageEmit, ImageStream, ImageTarget, Inst, Kernels, OpId, PatternSet, Rewrites, ShaderStage, Symbol, Updates, XE3, Xe3Kernel};

pub const XE3_EOT_GRF: u8 = 112;

pub const XE3_KERNEL_PAD: u64 = 128;

#[derive(Clone, Debug, PartialEq, Eq)]
pub struct Xe3Code {
    pub name: String,
    pub stage: Option<ShaderStage>,
    pub bytes: Vec<u8>,
}

impl Xe3Code {
    pub fn of(body: &Body<'_>, k: OpId) -> Result<Xe3Code, Error> {
        let head = body.head::<Xe3Kernel>(k)?;
        let mut bytes = Vec::new();
        for i in body.ops(body.top_block(k)) {
            bytes.extend(Inst::try_from((&*body[i].name, &body[i].all_attrs()[..]))?.encode());
        }
        Ok(Xe3Code { name: Symbol::defined(&head.sym_name)?.to_owned(), stage: head.stage, bytes })
    }
}

pub struct Xe3Emit;

impl Emit for Xe3Emit {
    type Output = Vec<Xe3Code>;

    fn emit(&self, body: &Body<'_>, op: OpId) -> Result<Vec<Xe3Code>, Error> {
        Kernels::all(body, op, Xe3Kernel::NAME).into_iter().map(|k| Xe3Code::of(body, k)).collect()
    }
}

pub struct Xe3Image;

impl ImageTarget for Xe3Image {
    const BASE: u64 = 0x10_0000;
    const PAGE: u64 = 0x1_0000;

    fn stream(&self, body: &Body<'_>, stream: OpId) -> Result<Vec<u8>, Error> {
        let mut dw = Vec::new();
        for c in body.ops(body.top_block(stream)) {
            dw.extend(XE3.pack(&body[c].name, &body[c].all_attrs())?);
        }
        Ok(Xe3Image::le(&dw))
    }

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

    pub fn pad(body: &mut Body<'_>, op: OpId) {
        let mut patterns = PatternSet::default();
        patterns.add(PadKernel);
        Rewrites::apply(body, op, &patterns);
    }

    pub fn end(body: &mut Body<'_>, op: OpId) {
        let mut patterns = PatternSet::default();
        patterns.add(EndBatch);
        Rewrites::apply(body, op, &patterns);
    }
}

crate::rewrites! {
    PadKernel((Xe3Kernel::NAME), 1) |rw, op| {
        if rw.body.head::<Xe3Kernel>(op).map_or(true, |k| k.pad.is_some()) {
            return false;
        }
        rw.update::<Xe3Kernel>(op, |k| k.pad = Some(XE3_KERNEL_PAD)).is_ok()
    }

    EndBatch((ImageStream::NAME), 1) |rw, op| {
        let block = rw.body.top_block(op);
        let ops = rw.body.block_ops(block);
        if ops.iter().rev().find(|o| rw.body[**o].name != CmdMiNoop::NAME).is_some_and(|o| rw.body[*o].name == CmdMiBatchBufferEnd::NAME) {
            return false;
        }
        let dw: usize = 1 + ops.iter().map(|c| XE3.template(&rw.body[*c].name, &rw.body[*c].all_attrs()).map_or(0, |t| t.dw.len())).sum::<usize>();
        rw.set_end(block);
        rw.emit(&CmdMiBatchBufferEnd::default());
        if !dw.is_multiple_of(2) {
            rw.emit(&CmdMiNoop::default());
        }
        true
    }
}

pub const XE3_IMAGE: ImageEmit<'_, Xe3Image> = ImageEmit(&Xe3Image);
