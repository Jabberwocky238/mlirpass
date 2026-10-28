//! The `math` dialect's op interfaces.

use crate::{DialectInliner, InlineAll, OpInterfaces};

/// The `math` dialect.
pub struct MathDialect;

impl OpInterfaces for MathDialect {
    fn namespace(&self) -> &str {
        "math"
    }

    /// Every op inlines (`MathInlinerInterface`).
    fn inliner(&self) -> Option<&dyn DialectInliner> {
        Some(&InlineAll { calls: false, regions: false })
    }
}
