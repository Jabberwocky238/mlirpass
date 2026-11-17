pub use mlirformat::glsl::*;

use alloc::vec;

use mlirbinary::{GlslFormat, Read};
use mlirformat::{Error, Item, Module};

use crate::{Body, OpId, Shift};

/// Reads GLSL source into a body with mlirbinary's `GlslFormat`: the `glsl.shader` op goes at the end
/// of the body's top block
pub struct GlslReader;

impl GlslReader {
    pub fn read(body: &mut Body<'_>, src: &str, stage: GlslStage) -> Result<OpId, Error> {
        let op = GlslFormat::new(Some(stage)).read(src.as_bytes(), &moremath::ThreadSingle)?;
        let sub = Body::import(body.ctx, Module { items: vec![Item::Op(op)] })?;
        let shader = sub.first_op(sub.top_block(sub.root)).ok_or_else(|| Error::from("glsl: no shader was read"))?;
        let moved = shader.shift(&body.absorb(sub));
        body.detach(moved);
        let top = body.top_block(body.root);
        body.insert(moved, top, None);
        Ok(moved)
    }
}
