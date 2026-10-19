//! Memory effects of ops, as `mlir/Interfaces/SideEffectInterfaces.cpp`.
//!
//! What ODS declares comes from the generated table; the ops that compute their effects in C++
//! (`DeclareOpInterfaceMethods<MemoryEffectOpInterface>`) are written out in
//! [`Body::custom_effects`].

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
    const fn on(kind: EffectKind, value: Option<ValueId>) -> Self {
        Self { kind, value, resource: "DefaultResource" }
    }
}

impl Body<'_> {
    fn is_memref(&self, v: ValueId) -> bool {
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

    /// The effects of the ops whose `getEffects` is C++.
    fn custom_effects(&self, op: OpId) -> Vec<EffectInstance> {
        use EffectKind::{Read, Write};
        let d = &self[op];
        let operand = |i: usize| d.operands.get(i).copied();
        // Volatile or (stronger than unordered) atomic: arbitrary reads and writes besides.
        let synchronizing = || d.get("volatile_").is_some() || matches!(d.get("ordering"), Some(Attribute::Int { lit, .. }) if !matches!(&**lit, "0" | "1"));
        match &*d.name {
            "cf.assert" => vec![EffectInstance::on(Write, None)],
            "llvm.load" | "llvm.store" => {
                let (kind, addr) = if d.name == "llvm.load" { (Read, 0) } else { (Write, 1) };
                let mut out = vec![EffectInstance::on(kind, operand(addr))];
                if synchronizing() {
                    out.extend([EffectInstance::on(Write, None), EffectInstance::on(Read, None)]);
                }
                out
            }
            "llvm.inline_asm" if d.get("has_side_effects").is_some() => vec![EffectInstance::on(Write, None), EffectInstance::on(Read, None)],
            "llvm.inline_asm" => Vec::new(),
            "vector.transfer_read" => operand(0).filter(|v| self.is_memref(*v)).map(|v| EffectInstance::on(Read, Some(v))).into_iter().collect(),
            "vector.transfer_write" => operand(1).filter(|v| self.is_memref(*v)).map(|v| EffectInstance::on(Write, Some(v))).into_iter().collect(),
            "bufferization.materialize_in_destination" => {
                let mut out = Vec::new();
                out.extend(operand(0).filter(|v| self.is_memref(*v)).map(|v| EffectInstance::on(Read, Some(v))));
                out.extend(operand(1).filter(|v| self.is_memref(*v)).map(|v| EffectInstance::on(Write, Some(v))));
                out
            }
            n if n.starts_with("linalg.") => self.linalg_effects(op),
            // Not ported yet: assume the worst an interface can say.
            _ => vec![EffectInstance::on(Write, None), EffectInstance::on(Read, None)],
        }
    }

    /// `getGenericEffectsImpl` of a linalg structured op: memref inputs are read, memref inits
    /// written (and read when the payload uses them).
    fn linalg_effects(&self, op: OpId) -> Vec<EffectInstance> {
        use EffectKind::{Read, Write};
        let (ins, outs) = (self.operand_group(op, 0), self.operand_group(op, 1));
        let entry = self[op].regions.first().and_then(|r| self[*r].blocks.first()).map(|b| &self[*b].args);
        let mut out: Vec<_> = ins.iter().filter(|v| self.is_memref(**v)).map(|v| EffectInstance::on(Read, Some(*v))).collect();
        for (j, v) in outs.iter().enumerate().filter(|(_, v)| self.is_memref(**v)) {
            let used = entry.and_then(|args| args.get(ins.len() + j)).is_some_and(|a| !self[*a].uses.is_empty());
            if used {
                out.push(EffectInstance::on(Read, Some(*v)));
            }
            out.push(EffectInstance::on(Write, Some(*v)));
        }
        out
    }

    /// Whether `op` is registered: known to the op table.
    pub fn registered(&self, op: OpId) -> bool {
        crate::OpInfo::of(&self[op].name).is_some()
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
