
use alloc::vec::Vec;

use mlirbinary::Apple9Code;
use mlirformat::{Error, Op};

use crate::{Apple9Kernel, Body, Emit, Kernels, OpId};

pub struct Apple9Emit;

impl Emit for Apple9Emit {
    type Output = Vec<Apple9Code>;

    fn emit(&self, body: &Body<'_>, op: OpId) -> Result<Vec<Apple9Code>, Error> {
        Kernels::all(body, op, Apple9Kernel::NAME).into_iter().map(|k| Apple9Code::of(&body.operation(k))).collect()
    }
}
