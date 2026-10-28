//! The `tensor` dialect's op interfaces.

use crate::{Body, DialectInliner, InlineAll, OpId, OpInterfaces};

/// The `tensor` dialect.
pub struct TensorDialect;

impl OpInterfaces for TensorDialect {
    fn namespace(&self) -> &str {
        "tensor"
    }

    /// Ops inline, and into regions (`TensorInlinerInterface`).
    fn inliner(&self) -> Option<&dyn DialectInliner> {
        Some(&InlineAll { calls: false, regions: true })
    }

    fn speculatability(&self, b: &Body<'_>, op: OpId) -> Option<bool> {
        if b[op].name == "tensor.dim" { b.dim_speculatability(op) } else { None }
    }
}
