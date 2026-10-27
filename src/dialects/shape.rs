//! The `shape` dialect's op interfaces.

use mlirformat::Attribute;

use crate::{Body, OpId, OpInterfaces};

/// The `shape` dialect.
pub struct ShapeDialect;

impl OpInterfaces for ShapeDialect {
    fn namespace(&self) -> &str {
        "shape"
    }

    fn constant_value<'a>(&self, b: &Body<'a>, op: OpId) -> Option<Attribute<'a>> {
        let d = &b[op];
        match &*d.name {
            "shape.const_shape" => d.get("shape").cloned(),
            "shape.const_witness" => d.get("passing").cloned(),
            _ => d.get("value").cloned(),
        }
    }
}
