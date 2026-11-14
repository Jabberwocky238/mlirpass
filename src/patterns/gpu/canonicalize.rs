use mlirformat::{Attribute, Dim, EffectKind, Type};

use crate::{Body, Fold, Folded, OpData, OpId};

impl Body<'_> {
    fn in_launch_entry(&self, op: OpId) -> bool {
        let Some(launch) = self.parent_op(op).filter(|p| self[*p].name == "gpu.launch") else { return false };
        self[op].parent == self[self[launch].regions[0]].blocks.first().copied()
    }
}

pub struct GpuCanon;

#[crate::patterns]
impl GpuCanon {
    #[rewrite("gpu.launch")]
    fn fold_launch_arguments(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
        let b = &*rw.body;
        let Some(sizes) = b.segments(op, "operandSegmentSizes") else { return false };
        let start: usize = sizes[0];
        let entry = b[b[op].regions[0]].blocks[0];
        let args = b[entry].args.clone();
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

    #[rewrite("gpu.barrier")]
    fn erase_redundant_barrier(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
        let b = &*rw.body;
        let Some(next) = b.next_op(op).filter(|n| b[*n].name == "gpu.barrier") else { return false };
        if b[op].get("scope") != b[next].get("scope") || b[op].operands != b[next].operands {
            return false;
        }
        let spaces = |o: OpId| match b[o].get("address_spaces") {
            Some(Attribute::Array(a)) => Some(a.clone()),
            _ => None,
        };
        if let Some(mut mine) = spaces(op) {
            match spaces(next) {
                None => rw.modify(op, |b| {
                    b[op].remove("address_spaces");
                }),
                Some(theirs) if theirs != mine => {
                    for a in theirs {
                        if !mine.contains(&a) {
                            mine.push(a);
                        }
                    }
                    rw.modify(op, |b| b[op].set("address_spaces", Attribute::Array(mine)));
                }
                Some(_) => {}
            }
        }
        rw.erase_op(next);
        true
    }

    #[rewrite("gpu.memcpy")]
    fn erase_trivial_copy_op(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
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

    #[rewrite("gpu.wait")]
    fn erase_redundant_gpu_wait_op_pairs(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
        let b = &*rw.body;
        let lone = |v: &crate::ValueId| b.def_named(*v, "gpu.wait").is_some_and(|w| b[w].operands.is_empty());
        if !b[op].operands.iter().any(lone) {
            return false;
        }
        let kept: alloc::vec::Vec<_> = b[op].operands.iter().copied().filter(|v| !lone(v)).collect();
        rw.modify(op, |b| b.set_operands(op, kept));
        true
    }

    #[rewrite("gpu.wait")]
    fn simplify_gpu_wait_op(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
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

    #[rewrite("memref.dim")]
    fn simplify_dim_of_alloc_op(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
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

impl GpuCanon {
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

    pub fn canonicalization(set: &mut crate::PatternSet) {
        set.add(FoldLaunchArguments);
        set.add(EraseRedundantBarrier);
        set.add(EraseTrivialCopyOp);
        set.add(EraseRedundantGpuWaitOpPairs);
        set.add(SimplifyGpuWaitOp);
        set.add(SimplifyDimOfAllocOp);
    }
}
