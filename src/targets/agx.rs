use alloc::vec::Vec;

use mlirformat::Op;

use crate::{AgxKernel, Body, Emit, ImageEmit, ImageTarget, Kernels, OpId};

pub use mlirbinary::{AgxCode, AgxRecord};

pub struct AgxEmit;

impl Emit for AgxEmit {
    type Output = Vec<AgxCode>;

    fn emit(&self, body: &Body<'_>, op: OpId) -> Result<Vec<AgxCode>, mlirformat::Error> {
        Kernels::all(body, op, AgxKernel::NAME).into_iter().map(|k| AgxCode::of(&body.operation(k))).collect()
    }
}

pub struct AgxImage;

impl ImageTarget for AgxImage {
    const BASE: u64 = <mlirbinary::AgxImage as mlirbinary::ImageTarget>::BASE;
    const PAGE: u64 = <mlirbinary::AgxImage as mlirbinary::ImageTarget>::PAGE;

    fn stream(&self, body: &Body<'_>, stream: OpId) -> Result<Vec<u8>, mlirformat::Error> {
        let mut bytes = Vec::new();
        for op in body.ops(body.top_block(stream)) {
            bytes.extend(AgxRecord::bytes(&body[op].name, &body[op].all_attrs())?);
        }
        Ok(bytes)
    }

    fn item(&self, body: &Body<'_>, op: OpId) -> Result<Vec<u8>, mlirformat::Error> {
        match &*body[op].name {
            n if n == AgxKernel::NAME => Ok(AgxCode::of(&body.operation(op))?.bytes),
            n => AgxRecord::bytes(n, &body[op].all_attrs()),
        }
    }
}

pub const AGX_IMAGE: ImageEmit<'_, AgxImage> = ImageEmit(&AgxImage);
