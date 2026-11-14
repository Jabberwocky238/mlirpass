use mlirformat::Error;

use crate::{AgxImage, Body, ImageLayout, OpId, pass};

#[pass("agx-layout", on = "builtin.module")]
pub fn agx_layout<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    ImageLayout(&AgxImage).run(body, op)
}
