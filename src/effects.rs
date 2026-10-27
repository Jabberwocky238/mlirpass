//! Memory effects of ops, as `mlir/Interfaces/SideEffectInterfaces.cpp`.
//!
//! What ODS declares comes from the generated table; the ops that compute their effects in C++
//! (`DeclareOpInterfaceMethods<MemoryEffectOpInterface>`) answer through their dialect's
//! [`OpInterfaces`](crate::OpInterfaces).

use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{Attribute, ShapedKind, Type};

use crate::{Body, EffectKind, EffectOn, Effects, OpId, Trait, ValueId};

/// One effect, on a value when it names one.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct EffectInstance {
    pub kind: EffectKind,
    pub value: Option<ValueId>,
    pub resource: &'static str,
}

impl EffectInstance {
    pub const fn on(kind: EffectKind, value: Option<ValueId>) -> Self {
        Self { kind, value, resource: "DefaultResource" }
    }
}

impl Body<'_> {
    /// Whether `v` is a memref.
    pub fn is_memref(&self, v: ValueId) -> bool {
        matches!(&self[v].ty, Type::Shaped(s) if s.kind == ShapedKind::MemRef)
    }

    /// The `i`th group of `op`'s operands, by `operandSegmentSizes` when it has one.
    pub fn operand_group(&self, op: OpId, i: usize) -> &[ValueId] {
        let operands = &self[op].operands;
        match self[op].get("operandSegmentSizes") {
            Some(Attribute::DenseArray { values, .. }) => {
                let sizes: Vec<usize> = values.iter().map(|v| v.parse().unwrap_or(0)).collect();
                let start: usize = sizes.iter().take(i).sum();
                operands.get(start..start + sizes.get(i).copied().unwrap_or(0)).unwrap_or(&[])
            }
            _ => operands.get(i..=i).unwrap_or(&[]),
        }
    }

    /// ⭐ `MemoryEffectOpInterface::getEffects`; `None`: the op does not implement it.
    pub fn effects_of(&self, op: OpId) -> Option<Vec<EffectInstance>> {
        match self.effects(op) {
            Effects::Unknown => None,
            Effects::Known(list) => Some(
                list.iter()
                    .flat_map(|e| {
                        let values: Vec<Option<ValueId>> = match e.on {
                            EffectOn::Op => vec![None],
                            EffectOn::Operand(i) => self.operand_group(op, i as usize).iter().map(|v| Some(*v)).collect(),
                            EffectOn::Result(i) => vec![self[op].results.get(i as usize).copied()],
                        };
                        values.into_iter().map(|value| EffectInstance { kind: e.kind, value, resource: e.resource })
                    })
                    .collect(),
            ),
            Effects::Custom => Some(self.custom_effects(op)),
        }
    }

    /// The effects of the ops whose `getEffects` is C++, from their dialect's interfaces.
    fn custom_effects(&self, op: OpId) -> Vec<EffectInstance> {
        self.interfaces(op).and_then(|i| i.effects(self, op)).unwrap_or_else(|| vec![EffectInstance::on(EffectKind::Write, None), EffectInstance::on(EffectKind::Read, None)])
    }

    /// Whether `op` is registered: known to the op table.
    pub fn registered(&self, op: OpId) -> bool {
        self.ctx.opt.op_info(&self[op].name).is_some()
    }

    /// `mightHaveTrait`: an unregistered op might have any.
    pub fn might_have(&self, op: OpId, t: Trait) -> bool {
        !self.registered(op) || self.has(op, t)
    }

    fn recursive_effects(&self, op: OpId) -> bool {
        self.has(op, Trait::HasRecursiveMemoryEffects)
    }

    fn nested_ops(&self, op: OpId) -> Vec<OpId> {
        self[op].regions.iter().flat_map(|r| &self[*r].blocks).flat_map(|b| self[*b].ops.iter().copied()).collect()
    }

    /// `isMemoryEffectFree`.
    pub fn is_memory_effect_free(&self, op: OpId) -> bool {
        match self.effects_of(op) {
            Some(e) if !e.is_empty() => return false,
            Some(_) if !self.recursive_effects(op) => return true,
            None if !self.recursive_effects(op) => return false,
            _ => {}
        }
        self.nested_ops(op).into_iter().all(|o| self.is_memory_effect_free(o))
    }

    /// `getSpeculatability`: `None` not speculatable, `Some(false)` speculatable, `Some(true)`
    /// recursively (as far as its regions are).
    fn speculatability(&self, op: OpId) -> Option<bool> {
        if self.has(op, Trait::AlwaysSpeculatableImplTrait) {
            return Some(false);
        }
        if self.has(op, Trait::RecursivelySpeculatableImplTrait) {
            return Some(true);
        }
        if !self.has(op, Trait::ConditionallySpeculatable) {
            return None;
        }
        self.interfaces(op).and_then(|i| i.speculatability(self, op))
    }

    /// `isSpeculatable`.
    pub fn is_speculatable(&self, op: OpId) -> bool {
        match self.speculatability(op) {
            None => false,
            Some(false) => true,
            Some(true) => self.nested_ops(op).into_iter().all(|o| self.is_speculatable(o)),
        }
    }

    /// `isPure`: speculatable and free of memory effects.
    pub fn is_pure(&self, op: OpId) -> bool {
        self.is_speculatable(op) && self.is_memory_effect_free(op)
    }

    /// `hasSingleEffect<kind>(op)`: it has effects, and all of them are `kind`.
    pub fn has_only_effect(&self, op: OpId, kind: EffectKind) -> bool {
        self.effects_of(op).is_some_and(|e| !e.is_empty() && e.iter().all(|x| x.kind == kind))
    }

    /// `hasEffect<kind>(op)`.
    pub fn has_effect(&self, op: OpId, kind: EffectKind) -> bool {
        self.effects_of(op).is_some_and(|e| e.iter().any(|x| x.kind == kind))
    }

    /// `getEffectsRecursively`; `None` when some op's effects are unknown.
    pub fn effects_recursively(&self, op: OpId) -> Option<Vec<EffectInstance>> {
        let mut out = Vec::new();
        let mut work = vec![op];
        while let Some(o) = work.pop() {
            let recursive = self.recursive_effects(o);
            if recursive {
                work.extend(self.nested_ops(o));
            }
            match self.effects_of(o) {
                Some(e) => out.extend(e),
                None if !recursive => return None,
                None => {}
            }
        }
        Some(out)
    }

    /// `wouldOpBeTriviallyDead`: erasable if its results were unused.
    pub fn would_be_trivially_dead(&self, op: OpId) -> bool {
        if self.might_have(op, Trait::IsTerminator) || self.has(op, Trait::SymbolOpInterface) {
            return false;
        }
        let mut work = vec![op];
        while let Some(o) = work.pop() {
            let recursive = self.recursive_effects(o);
            if recursive {
                // Upstream walks nested ops last-in first-out too; only the verdict matters.
                work.extend(self.nested_ops(o));
            }
            match self.effects_of(o) {
                Some(effects) => {
                    // Allocating its own results is fine, and so is reading.
                    let own = |v: Option<ValueId>| v.is_some_and(|v| self.def_op(v) == Some(o));
                    let allocs: Vec<_> = effects.iter().filter(|e| e.kind == EffectKind::Allocate && own(e.value)).map(|e| e.value).collect();
                    if !effects.iter().all(|e| (e.value.is_some() && allocs.contains(&e.value)) || e.kind == EffectKind::Read) {
                        return false;
                    }
                }
                None if recursive => {}
                None => return false,
            }
        }
        true
    }

    /// `isOpTriviallyDead`: no result is used, and nothing else would notice it gone.
    pub fn is_trivially_dead(&self, op: OpId) -> bool {
        self[op].results.iter().all(|r| self[*r].uses.is_empty()) && self.would_be_trivially_dead(op)
    }
}
