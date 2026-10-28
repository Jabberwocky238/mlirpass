//! The `complex` dialect's op interfaces.

use crate::{DialectInliner, InlineAll, OpInterfaces};

/// The `complex` dialect.
pub struct ComplexDialect;

impl OpInterfaces for ComplexDialect {
    fn namespace(&self) -> &str {
        "complex"
    }

    /// Every op inlines (`ComplexInlinerInterface`).
    fn inliner(&self) -> Option<&dyn DialectInliner> {
        Some(&InlineAll { calls: false, regions: false })
    }
}
