//! `xe3-end`: every batch ended ([`Xe3Image::end`]).

use mlirformat::Error;

use crate::{Body, OpId, Xe3Image, pass};

/// `xe3-end`.
#[pass("xe3-end", on = "builtin.module")]
pub fn xe3_end<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    Xe3Image::end(body, op);
    Ok(())
}
