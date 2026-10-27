//! The `tensor` dialect's op interfaces.

use crate::{Body, OpId, OpInterfaces};

/// The `tensor` dialect.
pub struct TensorDialect;

impl OpInterfaces for TensorDialect {
    fn namespace(&self) -> &str {
        "tensor"
    }

    fn speculatability(&self, b: &Body<'_>, op: OpId) -> Option<bool> {
        if b[op].name == "tensor.dim" { b.dim_speculatability(op) } else { None }
    }
}
