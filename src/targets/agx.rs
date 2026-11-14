use alloc::borrow::ToOwned;
use alloc::string::String;
use alloc::vec::Vec;

use mlirformat::{Error, Op};

use crate::{Agx, AgxKernel, Body, Emit, Heads, ImageEmit, ImageTarget, Kernels, OpId, ShaderStage, Symbol, Usc};

#[derive(Clone, Debug, PartialEq, Eq)]
pub struct AgxCode {
    pub name: String,
    pub stage: Option<ShaderStage>,
    pub params: u32,
    pub gprs: u32,
    pub align: u64,
    pub bytes: Vec<u8>,
}

impl AgxCode {
    pub fn of(body: &Body<'_>, k: OpId) -> Result<AgxCode, Error> {
        let head = body.head::<AgxKernel>(k)?;
        let mut bytes = Vec::new();
        for op in body.ops(body.top_block(k)) {
            bytes.extend(Usc::encode(&body[op].name, &body[op].all_attrs())?);
        }
        Ok(AgxCode { name: Symbol::defined(&head.sym_name)?.to_owned(), stage: head.stage, params: head.params.unwrap_or(0), gprs: head.gprs.unwrap_or(0), align: head.align.unwrap_or(1), bytes })
    }
}

pub struct AgxEmit;

impl Emit for AgxEmit {
    type Output = Vec<AgxCode>;

    fn emit(&self, body: &Body<'_>, op: OpId) -> Result<Vec<AgxCode>, Error> {
        Kernels::all(body, op, AgxKernel::NAME).into_iter().map(|k| AgxCode::of(body, k)).collect()
    }
}

pub struct AgxImage;

impl ImageTarget for AgxImage {
    const BASE: u64 = 1 << 32;
    const PAGE: u64 = 0x4000;

    fn stream(&self, body: &Body<'_>, stream: OpId) -> Result<Vec<u8>, Error> {
        let mut bytes = Vec::new();
        for op in body.ops(body.top_block(stream)) {
            bytes.extend(Agx::bytes(body, op)?);
        }
        Ok(bytes)
    }

    fn item(&self, body: &Body<'_>, op: OpId) -> Result<Vec<u8>, Error> {
        match &*body[op].name {
            n if n == AgxKernel::NAME => Ok(AgxCode::of(body, op)?.bytes),
            _ => Agx::bytes(body, op),
        }
    }
}

pub const AGX_IMAGE: ImageEmit<'_, AgxImage> = ImageEmit(&AgxImage);
