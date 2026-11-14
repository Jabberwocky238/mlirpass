use alloc::borrow::ToOwned;
use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;

use mlirformat::{Error, Op};

use crate::{Body, Emit, Heads, ImageEmit, ImageTarget, Kernels, OpId, Pm4, Rdna2Isa, Rdna2Kernel, ShaderStage, Symbol};

#[derive(Clone, Debug, PartialEq, Eq)]
pub struct Rdna2Code {
    pub name: String,
    pub stage: Option<ShaderStage>,
    pub params: u32,
    pub sgprs: u32,
    pub vgprs: u32,
    pub pad: u64,
    pub align: u64,
    pub bytes: Vec<u8>,
}

pub struct Rdna2Emit;

impl Emit for Rdna2Emit {
    type Output = Vec<Rdna2Code>;

    fn emit(&self, body: &Body<'_>, op: OpId) -> Result<Vec<Rdna2Code>, Error> {
        Kernels::all(body, op, Rdna2Kernel::NAME).into_iter().map(|k| Rdna2Code::of(body, k)).collect()
    }
}

impl Rdna2Code {
    pub fn of(body: &Body<'_>, k: OpId) -> Result<Rdna2Code, Error> {
        let head = body.head::<Rdna2Kernel>(k)?;
        let mut bytes = Vec::new();
        for op in body.ops(body.top_block(k)) {
            bytes.extend(Rdna2Isa::encode(body, op)?.iter().flat_map(|d| d.to_le_bytes()));
        }
        Ok(Rdna2Code {
            name: Symbol::defined(&head.sym_name)?.to_owned(),
            stage: head.stage,
            params: head.params.unwrap_or(0),
            sgprs: head.sgprs.unwrap_or(0),
            vgprs: head.vgprs.unwrap_or(0),
            pad: head.pad.unwrap_or(0),
            align: head.align.unwrap_or(1),
            bytes,
        })
    }
}

pub struct Rdna2Image;

impl ImageTarget for Rdna2Image {
    const BASE: u64 = 0x100_0000;
    const PAGE: u64 = 0x1_0000;

    fn stream(&self, body: &Body<'_>, stream: OpId) -> Result<Vec<u8>, Error> {
        let mut dw = Vec::new();
        for op in body.ops(body.top_block(stream)) {
            dw.extend(Pm4::pack(body, op)?);
        }
        Ok(dw.iter().flat_map(|d| d.to_le_bytes()).collect())
    }

    fn item(&self, body: &Body<'_>, op: OpId) -> Result<Vec<u8>, Error> {
        if body[op].name != Rdna2Kernel::NAME {
            return Err(Error(format!("{} cannot be placed in memory", body[op].name)));
        }
        let code = Rdna2Code::of(body, op)?;
        let mut bytes = code.bytes;
        bytes.resize(bytes.len() + code.pad as usize, 0);
        Ok(bytes)
    }
}

pub const RDNA2_IMAGE: ImageEmit<'_, Rdna2Image> = ImageEmit(&Rdna2Image);
