//! `llvm-request-c-wrappers`: every function asks for its C wrapper.

use mlirformat::{Attribute, Error};

use crate::{Body, OpId, Options, Pass};

pub struct RequestCWrappers;

impl TryFrom<&Options<'_>> for RequestCWrappers {
    type Error = Error;
    fn try_from(o: &Options<'_>) -> Result<Self, Error> {
        o.only("llvm-request-c-wrappers", &[])?;
        Ok(Self)
    }
}

impl Pass for RequestCWrappers {
    fn name(&self) -> &str {
        "llvm-request-c-wrappers"
    }

    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        body[op].set("llvm.emit_c_interface", Attribute::Unit);
        Ok(())
    }
}
