use mlirformat::Error;

use crate::{Body, OpId, Xe3Image, pass};

#[pass("xe3-end", on = "builtin.module")]
pub fn xe3_end<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    Xe3Image::end(body, op);
    Ok(())
}
