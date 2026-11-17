use alloc::vec::Vec;

use mlirformat::{Error, Op};

use crate::{Body, Emit, ImageEmit, Kernels, OpId, Rdna2Kernel};

pub use mlirbinary::{Rdna2Code, Rdna2Image};

pub struct Rdna2Emit;

impl Emit for Rdna2Emit {
    type Output = Vec<Rdna2Code>;

    fn emit(&self, body: &Body<'_>, op: OpId) -> Result<Vec<Rdna2Code>, Error> {
        Kernels::all(body, op, Rdna2Kernel::NAME).into_iter().map(|k| Rdna2Code::of(&body.operation(k))).collect()
    }
}

pub const RDNA2_IMAGE: ImageEmit<'_, Rdna2Image> = ImageEmit(&Rdna2Image);
