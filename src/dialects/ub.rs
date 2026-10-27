//! The `ub` dialect's op interfaces.

use alloc::string::String;
use alloc::vec::Vec;

use mlirformat::{Attribute, Extended};

use crate::{Body, OpId, OpInterfaces};

/// The `ub` dialect.
pub struct UbDialect;

impl OpInterfaces for UbDialect {
    fn namespace(&self) -> &str {
        "ub"
    }

    fn constant_value<'a>(&self, b: &Body<'a>, op: OpId) -> Option<Attribute<'a>> {
        let poison = || Attribute::Extended { ext: Extended { name: String::from("ub.poison").into(), body: None, params: Vec::new() }, ty: None };
        Some(b[op].get("value").cloned().unwrap_or_else(poison))
    }
}
