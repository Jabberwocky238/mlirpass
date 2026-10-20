//! `promote-buffers-to-stack`, as `BufferOptimizations.cpp` (with `BufferViewFlowAnalysis` and
//! `BufferPlacementAllocs`): small heap buffers that do not escape become `memref.alloca`.

use alloc::collections::{BTreeMap, BTreeSet};
use alloc::vec::Vec;

use crate::pass;
use mlirformat::{Error, FloatKind, ShapedKind, Type};

use crate::{Body, EffectKind, OpData, OpId, Run, RegionId, Trait, ValueId};

#[pass("promote-buffers-to-stack", on = "func.func")]
pub struct PromoteBuffersToStack {
    #[opt("max-alloc-size-in-bytes", default = 1024)]
    max_bytes: u64,
    #[opt("max-rank-of-allocated-memref", default = 1)]
    max_rank: usize,
}

/// `BufferViewFlowAnalysis`: which values may alias which.
struct ViewFlow {
    deps: BTreeMap<ValueId, BTreeSet<ValueId>>,
}

impl ViewFlow {
    fn new(b: &Body<'_>, root: OpId) -> Self {
        let mut f = Self { deps: BTreeMap::new() };
        for op in b.ops_in(root) {
            let d = &b[op];
            if d.name == "arith.select" {
                f.add(d.operands[1], d.results[0]);
                f.add(d.operands[2], d.results[0]);
            } else if b.has(op, Trait::ViewLikeOpInterface) {
                if let (Some(s), Some(r)) = (d.operands.first(), d.results.first()) {
                    f.add(*s, *r);
                }
            } else if !d.successors.is_empty() {
                for (i, succ) in d.successors.iter().enumerate() {
                    let Some(range) = b.successor_operands(op, i) else { continue };
                    for (v, a) in d.operands[range].iter().zip(&b[*succ].args) {
                        f.add(*v, *a);
                    }
                }
            } else if b.is_region_branch(op) {
                for ((owner, i), inputs) in b.operand_inputs(op) {
                    for input in inputs {
                        f.add(b[owner].operands[i], input);
                    }
                }
            } else if b.has(op, Trait::RegionBranchTerminatorOpInterface) {
            } else if b.has(op, Trait::CallOpInterface) {
                for v in &d.operands {
                    for r in &d.results {
                        f.add(*v, *r);
                    }
                }
            }
        }
        f
    }

    fn add(&mut self, from: ValueId, to: ValueId) {
        self.deps.entry(from).or_default().insert(to);
    }

    /// `resolve`: everything reachable from `v`.
    fn resolve(&self, v: ValueId) -> BTreeSet<ValueId> {
        let mut out = BTreeSet::new();
        let mut queue = alloc::vec![v];
        while let Some(x) = queue.pop() {
            if out.insert(x)
                && let Some(ds) = self.deps.get(&x)
            {
                queue.extend(ds.iter().copied());
            }
        }
        out
    }
}

impl Body<'_> {
    /// `memref::findDealloc`: `None` when several ops free `v`.
    fn find_dealloc(&self, v: ValueId) -> Option<Option<OpId>> {
        let mut found = None;
        for u in &self[v].uses {
            let frees = self.effects_of(u.op).is_some_and(|es| es.iter().any(|e| e.kind == EffectKind::Free && e.value == Some(v)));
            if frees {
                if found.is_some_and(|f| f != u.op) {
                    return None;
                }
                found = Some(u.op);
            }
        }
        Some(found)
    }

    /// `isLoop`.
    fn is_loop(&self, op: OpId) -> bool {
        self.has(op, Trait::LoopLikeOpInterface) || self[op].name == "scf.while"
    }

    /// `hasAllocationScope`.
    fn has_allocation_scope(&self, alloc: ValueId, aliases: &BTreeSet<ValueId>) -> bool {
        let Some(def) = self.def_op(alloc) else { return false };
        let mut region: Option<RegionId> = self[def].parent.and_then(|blk| self[blk].parent);
        while let Some(r) = region {
            let parent = self[r].parent;
            if self.has(parent, Trait::AutomaticAllocationScope) && !self.leaves_scope(r, aliases) {
                return true;
            }
            if self.is_loop(parent) || !(self.has(parent, Trait::LoopLikeOpInterface) || self.is_region_branch(parent)) {
                break;
            }
            region = self[parent].parent.and_then(|blk| self[blk].parent);
        }
        false
    }

    /// `leavesAllocationScope`: an alias is returned from `region`.
    fn leaves_scope(&self, region: RegionId, aliases: &BTreeSet<ValueId>) -> bool {
        aliases.iter().any(|a| {
            self[*a].uses.iter().any(|u| self.has(u.op, Trait::RegionBranchTerminatorOpInterface) && self[u.op].parent.and_then(|blk| self[blk].parent) == Some(region))
        })
    }

    /// The default `DataLayout` size of a memref element type, in bits.
    fn element_bits(t: &Type<'_>, index: u64) -> Option<u64> {
        match t {
            Type::Index => Some(index),
            Type::Integer { width, .. } => Some(u64::from(*width)),
            Type::Float(k) => Some(match k {
                FloatKind::F16 | FloatKind::BF16 => 16,
                FloatKind::F32 | FloatKind::TF32 => 32,
                FloatKind::F64 => 64,
                FloatKind::F80 => 80,
                FloatKind::F128 => 128,
                _ => 8,
            }),
            Type::Complex(e) => Self::element_bits(e, index).map(|b| 2 * b),
            Type::Shaped(s) if s.kind == ShapedKind::Vector => {
                let n = t.element_count()? as u64;
                Some(n * Self::element_bits(&s.elem, index)?)
            }
            _ => None,
        }
    }

    /// `defaultIsSmallAlloc`.
    fn is_small_alloc(&self, v: ValueId, max_bytes: u64, max_rank: usize) -> bool {
        let Some(def) = self.def_named(v, "memref.alloc") else { return false };
        let Type::Shaped(s) = &self[v].ty else { return false };
        let Some(dims) = &s.shape else { return false };
        match self[v].ty.element_count() {
            Some(n) => Self::element_bits(&s.elem, u64::from(crate::LlvmOptions { index_bitwidth: 0, ..crate::LlvmOptions::default() }.at(self, def).index_bitwidth)).is_some_and(|bits| n as u64 * bits <= max_bytes * 8),
            None => dims.len() <= max_rank && self[def].operands.iter().all(|o| self.def_named(*o, "memref.rank").is_some()),
        }
    }
}

impl Run for PromoteBuffersToStack {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let flow = ViewFlow::new(body, op);
        let mut allocs = Vec::new();
        for o in body.ops_in(op) {
            let Some(es) = body.effects_of(o) else { continue };
            let heap: Vec<ValueId> = es.iter().filter(|e| e.kind == EffectKind::Allocate && e.resource != "AutomaticAllocationScopeResource").filter_map(|e| e.value).filter(|v| body[o].results.contains(v)).collect();
            let [v] = heap[..] else { continue };
            if let Some(dealloc) = body.find_dealloc(v) {
                allocs.push((v, dealloc));
            }
        }
        for (v, dealloc) in allocs {
            if !body.is_small_alloc(v, self.max_bytes, self.max_rank) || dealloc.is_some() || !body.has_allocation_scope(v, &flow.resolve(v)) {
                continue;
            }
            let Some(alloc) = body.def_op(v) else { continue };
            let d = body[alloc].clone();
            let data = OpData { name: "memref.alloca".into(), results: Vec::new(), regions: Vec::new(), parent: None, ..d };
            let new = body.create(data, core::slice::from_ref(&body[v].ty.clone()));
            body.insert_before(new, alloc);
            let r = body[new].results[0];
            body.replace_all_uses(v, r);
            body.erase(alloc);
        }
        Ok(())
    }
}
