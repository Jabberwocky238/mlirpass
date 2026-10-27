//! The `bufferization` dialect's op interfaces.

use alloc::vec::Vec;

use crate::{Body, EffectInstance, EffectKind, OpId, OpInterfaces};

/// The `bufferization` dialect.
pub struct BufferizationDialect;

impl OpInterfaces for BufferizationDialect {
    fn namespace(&self) -> &str {
        "bufferization"
    }

    fn effects(&self, b: &Body<'_>, op: OpId) -> Option<Vec<EffectInstance>> {
        if b[op].name != "bufferization.materialize_in_destination" {
            return None;
        }
        let memref = |i: usize| b[op].operands.get(i).copied().filter(|v| b.is_memref(*v));
        let mut out = Vec::new();
        out.extend(memref(0).map(|v| EffectInstance::on(EffectKind::Read, Some(v))));
        out.extend(memref(1).map(|v| EffectInstance::on(EffectKind::Write, Some(v))));
        Some(out)
    }
}
