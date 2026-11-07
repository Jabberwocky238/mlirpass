//! `rdna2-pad`: every stream to a multiple of 8 dwords ([`Pm4::pad`]).

use mlirformat::Error;

use crate::{Body, OpId, Pm4, pass};

/// `rdna2-pad`.
#[pass("rdna2-pad", on = "builtin.module")]
pub fn rdna2_pad<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    Pm4::pad(body, op);
    Ok(())
}
