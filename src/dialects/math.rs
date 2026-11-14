use crate::{DialectInliner, InlineAll, OpInterfaces};

pub struct MathDialect;

impl OpInterfaces for MathDialect {
    fn namespace(&self) -> &str {
        "math"
    }

    fn inliner(&self) -> Option<&dyn DialectInliner> {
        Some(&InlineAll { calls: false, regions: false })
    }
}
