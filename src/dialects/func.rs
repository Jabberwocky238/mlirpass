//! The `func` dialect's op interfaces.

use core::ops::Range;

use crate::{Body, OpId, OpInterfaces, ValueId};

/// The `func` dialect.
pub struct FuncDialect;

impl OpInterfaces for FuncDialect {
    fn namespace(&self) -> &str {
        "func"
    }

    fn call_args(&self, b: &Body<'_>, call: OpId) -> Option<Range<usize>> {
        (b[call].name == "func.call_indirect").then(|| 1..b[call].operands.len())
    }

    fn indirect_callee(&self, b: &Body<'_>, call: OpId) -> Option<ValueId> {
        (b[call].name == "func.call_indirect").then(|| b[call].operands[0])
    }
}
