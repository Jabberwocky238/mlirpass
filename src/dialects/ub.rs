use alloc::string::String;
use alloc::vec::Vec;

use mlirformat::{Attribute, Extended};

use crate::{Body, DialectInliner, InlineAll, OpId, OpInterfaces};

pub struct UbDialect;

impl OpInterfaces for UbDialect {
    fn namespace(&self) -> &str {
        "ub"
    }

    fn inliner(&self) -> Option<&dyn DialectInliner> {
        Some(&InlineAll { calls: false, regions: false })
    }

    fn constant_value<'a>(&self, b: &Body<'a>, op: OpId) -> Option<Attribute<'a>> {
        let poison = || Attribute::Extended { ext: alloc::boxed::Box::new(Extended { name: String::from("ub.poison").into(), body: None, params: Vec::new() }), ty: None };
        Some(b[op].get("value").cloned().unwrap_or_else(poison))
    }
}
