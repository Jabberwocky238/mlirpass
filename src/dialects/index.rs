//! The `index` dialect's op interfaces.

use crate::{DialectInliner, InlineAll, OpInterfaces};

/// The `index` dialect.
pub struct IndexDialect;

impl OpInterfaces for IndexDialect {
    fn namespace(&self) -> &str {
        "index"
    }

    /// `OpAsmOpInterface::getAsmResultNames`.
    fn asm_result_names(&self, b: &crate::Body<'_>, op: crate::OpId) -> alloc::vec::Vec<(crate::ValueId, alloc::borrow::Cow<'static, str>)> {
        match &*b[op].name {
            // `idx<value>`.
            "index.constant" => match b[op].get("value").and_then(|a| crate::Const::try_from(a).ok()).and_then(|c| c.as_int()) {
                Some(i) => b.result_named(op, alloc::format!("idx{}", i.signed())),
                None => alloc::vec::Vec::new(),
            },
            "index.bool.constant" => b.result_named(op, if b[op].get("value").is_some_and(|a| matches!(a, mlirformat::Attribute::Bool(true))) { "true" } else { "false" }),
            _ => alloc::vec::Vec::new(),
        }
    }

    /// Every op inlines (`IndexInlinerInterface`).
    fn inliner(&self) -> Option<&dyn DialectInliner> {
        Some(&InlineAll { calls: false, regions: false })
    }
}
