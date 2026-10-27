//! The `arith` dialect's op interfaces.

use crate::{Body, OpId, OpInterfaces};

/// The `arith` dialect.
pub struct ArithDialect;

impl OpInterfaces for ArithDialect {
    fn namespace(&self) -> &str {
        "arith"
    }

    fn speculatability(&self, b: &Body<'_>, op: OpId) -> Option<bool> {
        let divisor = || b.int_constant(b[op].operands[1]);
        match &*b[op].name {
            "arith.divui" | "arith.ceildivui" => divisor().filter(|v| *v != 0).map(|_| false),
            "arith.divsi" | "arith.ceildivsi" => divisor().filter(|v| *v != 0 && *v != -1).map(|_| false),
            _ => None,
        }
    }
}
