use mlirformat::Error;

use crate::{Body, OpId, Xe3Image, pass};

#[pass("xe3-pad", on = "builtin.module")]
pub fn xe3_pad<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    Xe3Image::pad(body, op);
    Ok(())
}
