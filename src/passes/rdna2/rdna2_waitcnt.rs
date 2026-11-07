//! `rdna2-waitcnt`: a global load writes its VGPRs some time later (VM_CNT); before an instruction reads or
//! writes one of them, `s_waitcnt vmcnt(0)` (Mesa aco_insert_waitcnt, at its coarsest).

use mlirformat::{Error, Op};

use super::Alloc;
use crate::{Body, Kernels, OpId, Quiet, Rdna2Kernel, Rewriter, pass};

/// `rdna2-waitcnt`.
#[pass("rdna2-waitcnt", on = "builtin.module")]
pub fn rdna2_waitcnt<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    for k in Kernels::all(body, op, Rdna2Kernel::NAME) {
        let mut quiet = Quiet;
        Alloc { rw: Rewriter::new(body, &mut quiet), kernel: k }.waitcnt()?;
    }
    Ok(())
}
