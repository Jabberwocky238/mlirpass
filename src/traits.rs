//! ⭐ What ODS says about each op, as passes ask it: the table itself is mlirformat's
//! ([`OpInfo`]).

use crate::{Body, OpId};

pub use mlirformat::{Effect, EffectKind, EffectOn, Effects, OpInfo, OpRegistry, Trait};

impl Body<'_> {
    /// Whether `op` has trait (or interface) `t`.
    pub fn has(&self, op: OpId, t: Trait) -> bool {
        self.ctx.0.op_info(&self[op].name).is_some_and(|i| i.has(t))
    }

    /// `op`'s own memory effects (not its regions').
    pub fn effects(&self, op: OpId) -> Effects {
        self.ctx.0.op_info(&self[op].name).map_or(Effects::Unknown, |i| i.effects)
    }
}
