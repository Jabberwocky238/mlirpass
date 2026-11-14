use mlirformat::Error;

use crate::{Agx, Body, OpId, pass};

#[pass("agx-end", on = "builtin.module")]
pub fn agx_end<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    Agx::end(body, op)
}
