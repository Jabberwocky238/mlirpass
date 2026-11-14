use mlirformat::{Error, Op};

use super::Alloc;
use crate::{AgxKernel, Body, Kernels, OpId, Quiet, Rewriter, pass};

#[pass("agx-wait", on = "builtin.module")]
pub fn agx_wait<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    for k in Kernels::all(body, op, AgxKernel::NAME) {
        let mut quiet = Quiet;
        Alloc { rw: Rewriter::new(body, &mut quiet), kernel: k }.wait()?;
    }
    Ok(())
}
