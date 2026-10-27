//! The `tosa` dialect's op interfaces.

use mlirformat::Attribute;

use crate::{Body, OpId, OpInterfaces};

/// The `tosa` dialect.
pub struct TosaDialect;

impl OpInterfaces for TosaDialect {
    fn namespace(&self) -> &str {
        "tosa"
    }

    fn constant_value<'a>(&self, b: &Body<'a>, op: OpId) -> Option<Attribute<'a>> {
        let d = &b[op];
        match &*d.name {
            "tosa.const" | "tosa.const_shape" => d.get("values").cloned(),
            _ => d.get("value").cloned(),
        }
    }
}
