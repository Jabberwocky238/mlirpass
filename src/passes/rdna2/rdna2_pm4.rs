//! `rdna2-pm4`: every register in a stream into SET_*_REG packets, as few as the addresses allow ([`Pm4::into_packets`]).

use mlirformat::Error;

use crate::{Body, OpId, Pm4, pass};

/// `rdna2-pm4`.
#[pass("rdna2-pm4", on = "builtin.module")]
pub fn rdna2_pm4<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    Pm4::into_packets(body, op)
}
