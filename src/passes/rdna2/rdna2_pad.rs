use mlirformat::Error;

use crate::{Body, OpId, Pm4, pass};

#[pass("rdna2-pad", on = "builtin.module")]
pub fn rdna2_pad<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    Pm4::pad(body, op);
    Ok(())
}
