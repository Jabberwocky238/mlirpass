use alloc::string::String;
use crate::pass;
use mlirformat::{Attribute, Error};
use crate::{Body, OpId, Run};

#[pass("set-llvm-module-datalayout")]
pub struct SetLlvmModuleDataLayout {
    #[opt("data-layout")]
    layout: String,
}

impl Run for SetLlvmModuleDataLayout {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        body[op].set("llvm.data_layout", Attribute::str(&self.layout));
        Ok(())
    }
}
