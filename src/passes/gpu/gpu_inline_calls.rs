//! `gpu-inline-calls`: every call in a `gpu.func` kernel of a `func.func` of its `gpu.module` inlined
//! ([`Kernels::inline_calls`]): what a GPU target does first, as a pass of its own so that canonicalization can run on
//! the inlined kernels before the lowering.

use mlirformat::Error;

use crate::{Body, Kernels, OpId, pass};

/// `gpu-inline-calls`.
#[pass("gpu-inline-calls", on = "builtin.module")]
pub fn gpu_inline_calls<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    Kernels::inline_calls(body, op)
}
