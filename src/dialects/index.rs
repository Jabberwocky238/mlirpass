//! The `index` dialect's op interfaces.

use crate::{DialectInliner, InlineAll, OpInterfaces};

/// The `index` dialect.
pub struct IndexDialect;

impl OpInterfaces for IndexDialect {
    fn namespace(&self) -> &str {
        "index"
    }

    /// Every op inlines (`IndexInlinerInterface`).
    fn inliner(&self) -> Option<&dyn DialectInliner> {
        Some(&InlineAll { calls: false, regions: false })
    }
}
