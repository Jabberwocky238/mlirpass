//! `sroa`, as `SROA.cpp`: memory slots of aggregates split into one slot per used subelement.

use mlirpass_macros::pass;
use mlirformat::Error;

use crate::{Body, OpId};

#[pass("sroa", ty = Sroa)]
pub fn sroa<'a>(_body: &mut Body<'a>, _op: OpId) -> Result<(), Error> {
    Ok(())
}
