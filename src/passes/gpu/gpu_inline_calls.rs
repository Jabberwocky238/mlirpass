use mlirformat::Error;

use crate::{Body, Kernels, OpId, pass};

#[pass("gpu-inline-calls", on = "builtin.module")]
pub fn gpu_inline_calls<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    Kernels::inline_calls(body, op)
}
