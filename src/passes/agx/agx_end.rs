//! `agx-end`: every stream ended by its engine's Stream Terminate, every kernel by its footer ([`Agx::end`]).

use mlirformat::Error;

use crate::{Agx, Body, OpId, pass};

/// `agx-end`.
#[pass("agx-end", on = "builtin.module")]
pub fn agx_end<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    Agx::end(body, op)
}
