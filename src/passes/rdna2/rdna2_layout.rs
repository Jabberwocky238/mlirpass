use mlirformat::Error;

use crate::{Body, ImageLayout, OpId, Rdna2Image, pass};

#[pass("rdna2-layout", on = "builtin.module")]
pub fn rdna2_layout<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    ImageLayout(&Rdna2Image).run(body, op)
}
