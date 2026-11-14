use mlirformat::Error;

use crate::{Body, OpId, Pm4, pass};

#[pass("rdna2-pm4", on = "builtin.module")]
pub fn rdna2_pm4<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    Pm4::into_packets(body, op)
}
