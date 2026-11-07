//! `agx-wait`: a load writes its registers later (its wait group, `a`); before an instruction reads or writes one of
//! them, `wait a` (Mesa agx_insert_waits, at its coarsest).

use mlirformat::{Error, Op};

use super::Alloc;
use crate::{AgxKernel, Body, Kernels, OpId, Quiet, Rewriter, pass};

/// `agx-wait`.
#[pass("agx-wait", on = "builtin.module")]
pub fn agx_wait<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    for k in Kernels::all(body, op, AgxKernel::NAME) {
        let mut quiet = Quiet;
        Alloc { rw: Rewriter::new(body, &mut quiet), kernel: k }.wait()?;
    }
    Ok(())
}
