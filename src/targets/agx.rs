use alloc::vec::Vec;

use mlirformat::Op;

use crate::{AgxKernel, Body, Emit, ImageEmit, Kernels, OpId};

pub use mlirbinary::{AgxCode, AgxImage, AgxRecord};

pub struct AgxEmit;

impl Emit for AgxEmit {
    type Output = Vec<AgxCode>;

    fn emit(&self, body: &Body<'_>, op: OpId) -> Result<Vec<AgxCode>, mlirformat::Error> {
        Kernels::all(body, op, AgxKernel::NAME).into_iter().map(|k| AgxCode::of(&body.operation(k))).collect()
    }
}

pub const AGX_IMAGE: ImageEmit<'_, AgxImage> = ImageEmit(&AgxImage);
