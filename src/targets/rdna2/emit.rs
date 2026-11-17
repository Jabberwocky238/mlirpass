use alloc::vec::Vec;

use mlirbinary::{ImageTarget as _, Ir};
use mlirformat::{Error, Op};

use crate::{Body, Emit, ImageEmit, ImageTarget, Kernels, OpId, Rdna2Kernel};

pub use mlirbinary::Rdna2Code;

pub struct Rdna2Emit;

impl Emit for Rdna2Emit {
    type Output = Vec<Rdna2Code>;

    fn emit(&self, body: &Body<'_>, op: OpId) -> Result<Vec<Rdna2Code>, Error> {
        Kernels::all(body, op, Rdna2Kernel::NAME).into_iter().map(|k| Rdna2Code::of(&body.operation(k))).collect()
    }
}

pub struct Rdna2Image;

impl ImageTarget for Rdna2Image {
    const BASE: u64 = <mlirbinary::Rdna2Image as mlirbinary::ImageTarget>::BASE;
    const PAGE: u64 = <mlirbinary::Rdna2Image as mlirbinary::ImageTarget>::PAGE;

    fn stream(&self, body: &Body<'_>, stream: OpId) -> Result<Vec<u8>, Error> {
        let op = body.operation(stream);
        let ir = Ir::new(&op)?;
        mlirbinary::Rdna2Image.stream(&ir, ir.root)
    }

    fn item(&self, body: &Body<'_>, op: OpId) -> Result<Vec<u8>, Error> {
        let op = body.operation(op);
        let ir = Ir::new(&op)?;
        mlirbinary::Rdna2Image.item(&ir, ir.root)
    }
}

pub const RDNA2_IMAGE: ImageEmit<'_, Rdna2Image> = ImageEmit(&Rdna2Image);
