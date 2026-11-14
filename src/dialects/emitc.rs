use alloc::vec;
use alloc::vec::Vec;

use crate::{Body, EffectInstance, EffectKind, OpId, OpInterfaces};

pub struct EmitcDialect;

impl OpInterfaces for EmitcDialect {
    fn namespace(&self) -> &str {
        "emitc"
    }

    fn effects(&self, b: &Body<'_>, op: OpId) -> Option<Vec<EffectInstance>> {
        (b[op].name == "emitc.cast").then(|| if b[op].get("pure").is_some() { Vec::new() } else { vec![EffectInstance::on(EffectKind::Read, None), EffectInstance::on(EffectKind::Write, None)] })
    }

    fn speculatability(&self, b: &Body<'_>, op: OpId) -> Option<bool> {
        (b[op].name == "emitc.cast" && b[op].get("pure").is_some()).then_some(false)
    }
}
