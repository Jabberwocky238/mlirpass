//! `llvm-request-c-wrappers`: every function asks for its C wrapper.

use crate::pass;
use mlirformat::{Attribute, Error};

use crate::{Body, OpId};

#[pass("llvm-request-c-wrappers", on = "func.func", ty = RequestCWrappers)]
pub fn llvm_request_c_wrappers<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    body[op].set("llvm.emit_c_interface", Attribute::Unit);
    Ok(())
}
