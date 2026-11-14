use crate::{DialectInliner, InlineAll, OpInterfaces};

pub struct ComplexDialect;

impl OpInterfaces for ComplexDialect {
    fn namespace(&self) -> &str {
        "complex"
    }

    fn asm_result_names(&self, b: &crate::Body<'_>, op: crate::OpId) -> alloc::vec::Vec<(crate::ValueId, alloc::borrow::Cow<'static, str>)> {
        if b[op].name == "complex.constant" { b.result_named(op, "cst") } else { alloc::vec::Vec::new() }
    }

    fn inliner(&self) -> Option<&dyn DialectInliner> {
        Some(&InlineAll { calls: false, regions: false })
    }
}
