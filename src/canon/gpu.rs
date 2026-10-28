//! `gpu` folds and canonicalization patterns, as `GPUDialect.cpp`.

use mlirformat::{Attribute, Dim, EffectKind, Type};

use crate::{Body, Fold, Folded, OpData, OpId, PatternSet};

impl Body<'_> {
    /// `canMakeGroupOpUniform`: `op` sits in the entry block of a `gpu.launch`.
    fn in_launch_entry(&self, op: OpId) -> bool {
        let Some(launch) = self.parent_op(op).filter(|p| self[*p].name == "gpu.launch") else { return false };
        self[op].parent == self[self[launch].regions[0]].blocks.first().copied()
    }
}

/// The `gpu` fold hooks.
pub fn fold<'a>(b: &mut Body<'a>, op: OpId) -> Fold<'a> {
    let uniform = |b: &mut Body<'a>| {
        if b[op].get("uniform").is_none() && b.in_launch_entry(op) {
            b[op].set("uniform", Attribute::Unit);
            return Fold::InPlace;
        }
        Fold::Failed
    };
    let name = alloc::string::String::from(&*b[op].name);
    match &*name {
        "gpu.all_reduce" => uniform(b),
        "gpu.subgroup_reduce" if b[op].get("cluster_size").and_then(|a| mlirformat::Const::try_from(a).ok()?.as_int()).is_some_and(|i| i.signed() == 1) => {
            Fold::Results(alloc::vec![Folded::Value(b[op].operands[0])])
        }
        "gpu.subgroup_reduce" => uniform(b),
        "gpu.subgroup_broadcast" => match b.def_named(b[op].operands[0], "gpu.subgroup_broadcast") {
            Some(prev) => Fold::Results(alloc::vec![Folded::Value(b[prev].results[0])]),
            None => Fold::Failed,
        },
        "gpu.memcpy" | "gpu.memset" if b.fold_memref_cast(op, None) => Fold::InPlace,
        _ => Fold::Failed,
    }
}

rewrites! {
    /// `FoldLaunchArguments`: a block or thread id over a range of one is zero.
    FoldLaunchArguments("gpu.launch", 1) |rw, op| {
        let b = &*rw.body;
        let Some(sizes) = b.segments(op, "operandSegmentSizes") else { return false };
        let start: usize = sizes[0];
        let entry = b[b[op].regions[0]].blocks[0];
        let args = b[entry].args.clone();
        // Grid sizes give the block ids (args 0..3), block sizes the thread ids (3..6).
        let pairs: alloc::vec::Vec<_> = (0..6).filter_map(|i| Some((args[i], *b[op].operands.get(start + i)?))).collect();
        let mut zero = None;
        for (id, size) in pairs {
            let one = rw.body.int_constant(size) == Some(1);
            if !one || rw.body[id].uses.is_empty() {
                continue;
            }
            let z = *zero.get_or_insert_with(|| {
                rw.set_start(entry);
                let c = rw.create(OpData::build("arith.constant").with("value", Attribute::index(0)), &[Type::Index]);
                rw.body[c].results[0]
            });
            rw.replace_all_uses(id, z);
        }
        zero.is_some()
    }

    /// `eraseRedundantGpuBarrierOps`: a barrier right before another goes.
    EraseRedundantBarrier("gpu.barrier", 1) |rw, op| {
        let b = &*rw.body;
        let Some(block) = b[op].parent else { return false };
        let at = b.position(op);
        if !b[block].ops.get(at + 1).is_some_and(|n| b[*n].name == "gpu.barrier") {
            return false;
        }
        rw.erase_op(op);
        true
    }

    /// `EraseTrivialCopyOp`: a copy into a fresh allocation only ever freed.
    EraseTrivialCopyOp("gpu.memcpy", 1) |rw, op| {
        let b = &*rw.body;
        let Some(sizes) = b.segments(op, "operandSegmentSizes").or_else(|| Some(alloc::vec![b[op].operands.len() - 2, 1, 1])) else { return false };
        let deps = b[op].operands[..sizes[0]].to_vec();
        let dst = b[op].operands[sizes[0]];
        let Some(def) = b.def_op(dst) else { return false };
        let single = |o: OpId, kind: EffectKind| b.effects_of(o).is_some_and(|es| !es.is_empty() && es.iter().all(|e| e.kind == kind && e.value.is_none_or(|v| v == dst)));
        if !single(def, EffectKind::Allocate) || b[dst].uses.iter().any(|u| u.op != op && !single(u.op, EffectKind::Free)) {
            return false;
        }
        let token = b[op].results.first().copied();
        if deps.len() > 1 || (deps.is_empty() && token.is_some()) || (!deps.is_empty() && token.is_none()) {
            return false;
        }
        rw.replace_op(op, &deps);
        true
    }

    /// `EraseRedundantGpuWaitOpPairs`: dependencies on a wait without dependencies drop.
    EraseRedundantGpuWaitOpPairs("gpu.wait", 1) |rw, op| {
        let b = &*rw.body;
        let lone = |v: &crate::ValueId| b.def_named(*v, "gpu.wait").is_some_and(|w| b[w].operands.is_empty());
        if !b[op].operands.iter().any(lone) {
            return false;
        }
        let kept: alloc::vec::Vec<_> = b[op].operands.iter().copied().filter(|v| !lone(v)).collect();
        rw.modify(op, |b| b.set_operands(op, kept));
        true
    }

    /// `SimplifyGpuWaitOp`.
    SimplifyGpuWaitOp("gpu.wait", 1) |rw, op| {
        let b = &*rw.body;
        let (deps, token) = (b[op].operands.clone(), b[op].results.first().copied());
        match (deps.len(), token) {
            (0, None) => rw.erase_op(op),
            (1, Some(_)) => rw.replace_op(op, &deps),
            (_, Some(t)) if b[t].uses.is_empty() => rw.erase_op(op),
            _ => return false,
        }
        true
    }

    /// `SimplifyDimOfAllocOp`: a dynamic dim of a `gpu.alloc` is its size operand.
    SimplifyDimOfAllocOp("memref.dim", 1) |rw, op| {
        let b = &*rw.body;
        let Some(index) = b.int_constant(b[op].operands[1]) else { return false };
        let src = b[op].operands[0];
        let Some(dims) = b[src].ty.shape() else { return false };
        if index < 0 || index as usize >= dims.len() || dims[index as usize] != Dim::Dynamic {
            return false;
        }
        let Some(alloc) = b.def_named(src, "gpu.alloc") else { return false };
        let Some(sizes) = b.segments(alloc, "operandSegmentSizes") else { return false };
        let nth = dims[..index as usize].iter().filter(|d| **d == Dim::Dynamic).count();
        let v = b[alloc].operands[sizes[0] + nth];
        rw.replace_op(op, &[v]);
        true
    }
}

/// The gpu canonicalization patterns, in op registration order.
pub fn patterns(set: &mut PatternSet) {
    set.add(FoldLaunchArguments);
    set.add(EraseRedundantBarrier);
    set.add(EraseTrivialCopyOp);
    set.add(EraseRedundantGpuWaitOpPairs);
    set.add(SimplifyGpuWaitOp);
    set.add(SimplifyDimOfAllocOp);
}
