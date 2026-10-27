//! The `vector` dialect's op interfaces.

use alloc::vec::Vec;

use crate::{Body, EffectInstance, EffectKind, OpId, OpInterfaces};

/// The `vector` dialect.
pub struct VectorDialect;

impl OpInterfaces for VectorDialect {
    fn namespace(&self) -> &str {
        "vector"
    }

    fn effects(&self, b: &Body<'_>, op: OpId) -> Option<Vec<EffectInstance>> {
        let (kind, i) = match &*b[op].name {
            "vector.transfer_read" => (EffectKind::Read, 0),
            "vector.transfer_write" => (EffectKind::Write, 1),
            _ => return None,
        };
        Some(b[op].operands.get(i).copied().filter(|v| b.is_memref(*v)).map(|v| EffectInstance::on(kind, Some(v))).into_iter().collect())
    }

    fn speculatability(&self, b: &Body<'_>, op: OpId) -> Option<bool> {
        match &*b[op].name {
            "vector.transfer_read" | "vector.transfer_write" => b[op].operands.iter().all(|v| !b.is_memref(*v)).then_some(false),
            _ => None,
        }
    }
}
