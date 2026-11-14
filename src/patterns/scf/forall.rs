use alloc::vec::Vec;

use mlirformat::{Attribute, Type};

use crate::{Body, BlockId, Mapping, MemrefOfr as Ofr, OpData, OpId, Rewriter, ValueId};

const BOUND_ATTRS: [&str; 3] = ["staticLowerBound", "staticUpperBound", "staticStep"];

struct Forall {
    bounds: [Vec<Ofr>; 3],
    outputs: Vec<ValueId>,
    block: BlockId,
}

impl Forall {
    fn rank(&self) -> usize {
        self.bounds[0].len()
    }

    fn args<'b>(&self, b: &'b Body<'_>) -> (&'b [ValueId], &'b [ValueId]) {
        b[self.block].args.split_at(self.rank())
    }

    fn combining(b: &Body<'_>, arg: ValueId) -> Vec<OpId> {
        b[arg].uses.iter().map(|u| u.op).filter(|o| b[*o].name == "tensor.parallel_insert_slice").collect()
    }

    fn data<'a>(bounds: &[Vec<Ofr>; 3], outputs: &[ValueId]) -> OpData<'a> {
        let mut operands = Vec::new();
        let mut segs = Vec::new();
        let mut data = OpData::build("scf.forall");
        for (list, name) in bounds.iter().zip(BOUND_ATTRS) {
            let (st, dy) = Ofr::split(list);
            segs.push(dy.len());
            operands.extend(dy);
            data.set(name, Attribute::dense_i64(&st));
        }
        segs.push(outputs.len());
        operands.extend_from_slice(outputs);
        data.operands(&operands).segments(&segs)
    }
}

impl Body<'_> {
    fn forall(&self, op: OpId) -> Forall {
        let segs = self.segments(op, "operandSegmentSizes").unwrap_or_default();
        let mut at = 0;
        let bounds = core::array::from_fn(|k| {
            let n = segs.get(k).copied().unwrap_or(0);
            let list = Ofr::mixed(&self.dense_i64(op, BOUND_ATTRS[k]), &self[op].operands[at..at + n]);
            at += n;
            list
        });
        let outputs = self[op].operands[at..].to_vec();
        Forall { bounds, outputs, block: self[self[op].regions[0]].blocks[0] }
    }
}

pub struct ForallCanon;

#[crate::patterns]
impl ForallCanon {
    #[rewrite("tensor.dim")]
    fn dim_of_forall_op(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let b = &*rw.body;
        let src = b[op].operands[0];
        let Some(forall) = b.def_named(src, "scf.forall") else { return false };
        let crate::Def::Result(_, i) = b[src].def else { return false };
        let out = b.forall(forall).outputs[i as usize];
        rw.modify(op, |body| body.set_operand(op, 0, out));
        true
    }

    #[rewrite("scf.forall")]
    fn fold_tensor_cast_of_output_into_forall_op(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let b = &*rw.body;
        let f = b.forall(op);
        let mut outputs = f.outputs.clone();
        let mut casts: Vec<(usize, Type<'_>)> = Vec::new();
        for (i, o) in f.outputs.iter().enumerate() {
            let Some(cast) = b.def_named(*o, "tensor.cast") else { continue };
            let (src, dst) = (b[cast].operands[0], b[cast].results[0]);
            if !Body::preserves_static(&b[dst].ty, &b[src].ty) {
                continue;
            }
            casts.push((i, b[dst].ty.clone()));
            outputs[i] = src;
        }
        if casts.is_empty() {
            return false;
        }
        let loc = b[op].loc.clone();
        let types = b.types(&outputs);
        let mut data = Forall::data(&f.bounds, &outputs);
        if let Some(m) = b[op].get("mapping").cloned() {
            data.set("mapping", m);
        }
        let rank = f.rank();
        rw.set_before(op);
        let new = rw.create_with(OpData { loc: loc.clone(), ..data }, &types, |body, n| {
            let r = body.add_region(n);
            let blk = body.add_block(r, &[]);
            for _ in 0..rank {
                let a = body.add_arg(blk, Type::Index);
                body[a].loc = loc.clone();
            }
            for t in &types {
                let a = body.add_arg(blk, t.clone());
                body[a].loc = loc.clone();
            }
        });
        let nf = rw.body.forall(new);
        let new_args = rw.body[nf.block].args.clone();
        let mut repl = new_args.clone();
        rw.set_start(nf.block);
        for (i, ty) in &casts {
            let c = rw.create(OpData { loc: loc.clone(), ..OpData::build("tensor.cast").operands(&[new_args[rank + i]]) }, core::slice::from_ref(ty));
            repl[rank + i] = rw.body[c].results[0];
        }
        rw.inline_block_before(f.block, nf.block, None, &repl);
        let iter_args = &new_args[rank..];
        let term = rw.body.last_op(nf.block).expect("a terminator");
        let inner = rw.body[rw.body[term].regions[0]].blocks[0];
        for y in rw.body.block_ops(inner) {
            if rw.body[y].name != "tensor.parallel_insert_slice" {
                continue;
            }
            let dest = rw.body[y].operands[1];
            if let Some(c) = rw.body.def_named(dest, "tensor.cast")
                && iter_args.contains(&rw.body[c].operands[0])
            {
                let src = rw.body[c].operands[0];
                rw.modify(y, |body| body.set_operand(y, 1, src));
            }
        }
        rw.set_after(new);
        let mut results = rw.body[new].results.to_vec();
        for (i, ty) in &casts {
            let c = rw.create(OpData { loc: loc.clone(), ..OpData::build("tensor.cast").operands(&[results[*i]]) }, core::slice::from_ref(ty));
            results[*i] = rw.body[c].results[0];
        }
        rw.replace_op(op, &results);
        true
    }

    #[rewrite("scf.forall")]
    fn forall_op_control_operands_folder(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let b = &*rw.body;
        let mut f = b.forall(op);
        let folded = f.bounds.iter_mut().fold(false, |any, list| Ofr::fold_list(b, list, false, false) | any);
        if !folded {
            return false;
        }
        let data = Forall::data(&f.bounds, &f.outputs);
        rw.modify(op, |body| {
            body.set_operands(op, data.operands.clone());
            for name in BOUND_ATTRS.iter().chain(&["operandSegmentSizes"]) {
                if let Some(v) = data.get(name).cloned() {
                    body[op].set(name, v);
                }
            }
        });
        true
    }

    #[rewrite("scf.forall")]
    fn forall_op_iter_args_folder(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let b = &*rw.body;
        let f = b.forall(op);
        let (_, iter_args) = f.args(b);
        let iter_args = iter_args.to_vec();
        let results = b[op].results.to_vec();
        let mut dead = Vec::new();
        let mut kept = Vec::new();
        for (i, (r, arg)) in results.iter().zip(&iter_args).enumerate() {
            if b[*r].uses.is_empty() || Forall::combining(b, *arg).is_empty() {
                dead.push(i);
            } else {
                kept.push(f.outputs[i]);
            }
        }
        if dead.is_empty() {
            return false;
        }
        for i in &dead {
            for c in Forall::combining(rw.body, iter_args[*i]) {
                rw.erase_op(c);
            }
        }
        for i in &dead {
            rw.replace_all_uses(iter_args[*i], f.outputs[*i]);
            rw.replace_all_uses(results[*i], f.outputs[*i]);
        }
        let rank = f.rank();
        let block = f.block;
        rw.modify(op, |body| body.erase_args(block, &dead.iter().map(|i| rank + i).collect::<Vec<_>>()));
        let new = rw.erase_op_results(op, &dead);
        let data = Forall::data(&f.bounds, &kept);
        rw.modify(new, |body| {
            body.set_operands(new, data.operands.clone());
            if let Some(v) = data.get("operandSegmentSizes").cloned() {
                body[new].set("operandSegmentSizes", v);
            }
        });
        true
    }

    #[rewrite("scf.forall")]
    fn forall_op_single_or_zero_iteration_dims_folder(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let b = &*rw.body;
        if matches!(b[op].get("mapping"), Some(Attribute::Array(m)) if !m.is_empty()) {
            return false;
        }
        let f = b.forall(op);
        let ivs = f.args(b).0.to_vec();
        rw.set_before(op);
        let mut map = Mapping::default();
        let mut kept: [Vec<Ofr>; 3] = Default::default();
        for (d, iv) in ivs.iter().enumerate() {
            let [lb, ub, step] = [0, 1, 2].map(|k| f.bounds[k][d]);
            match rw.body.const_trip_count(lb, ub, step, true) {
                Some(n) if n.is_zero() => {
                    rw.replace_op(op, &f.outputs);
                    return true;
                }
                Some(n) if n.signed() == 1 => {
                    let v = rw.value_of(lb);
                    map.map(*iv, v);
                    continue;
                }
                _ => {}
            }
            for (k, x) in [lb, ub, step].into_iter().enumerate() {
                kept[k].push(x);
            }
        }
        if kept[0].is_empty() {
            Self::promote(rw, op);
            return true;
        }
        if kept[0].len() == f.rank() {
            return false;
        }
        let b = &*rw.body;
        let types = b.types(&b[op].results.clone());
        let mut data = Forall::data(&kept, &f.outputs);
        for a in b[op].all_attrs() {
            if BOUND_ATTRS.contains(&&*a.name) || &*a.name == "operandSegmentSizes" {
                continue;
            }
            data.set(&a.name, a.value.clone().unwrap_or(Attribute::Unit));
        }
        let loc = b[op].loc.clone();
        rw.set_before(op);
        let new = rw.create_with(OpData { loc, ..data }, &types, |body, n| {
            body.add_region(n);
        });
        let (from, into) = (rw.body[op].regions[0], rw.body[new].regions[0]);
        rw.clone_region_before(from, into, None, &mut map);
        let res = rw.body[new].results.to_vec();
        rw.replace_op(op, &res);
        true
    }

    #[rewrite("scf.forall")]
    fn forall_op_replace_constant_induction_var(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let b = &*rw.body;
        let f = b.forall(op);
        let ivs = f.args(b).0.to_vec();
        rw.set_before(op);
        let mut changed = false;
        for (d, iv) in ivs.iter().enumerate() {
            if rw.body[*iv].uses.is_empty() {
                continue;
            }
            let [lb, ub, step] = [0, 1, 2].map(|k| f.bounds[k][d]);
            if rw.body.const_trip_count(lb, ub, step, true).is_none_or(|n| n.signed() != 1) {
                continue;
            }
            let v = rw.value_of(lb);
            rw.replace_all_uses(*iv, v);
            changed = true;
        }
        changed
    }
}

impl ForallCanon {
    pub fn canonicalization(set: &mut crate::PatternSet) {
        set.add(DimOfForallOp).add(FoldTensorCastOfOutputIntoForallOp).add(ForallOpControlOperandsFolder).add(ForallOpIterArgsFolder).add(ForallOpSingleOrZeroIterationDimsFolder).add(ForallOpReplaceConstantInductionVar);
    }

    fn promote(rw: &mut Rewriter<'_, '_>, op: OpId) {
        let f = rw.body.forall(op);
        rw.set_before(op);
        let mut args: Vec<ValueId> = f.bounds[0].iter().map(|lb| rw.value_of(*lb)).collect();
        args.extend_from_slice(&f.outputs);
        let term = rw.body.last_op(f.block).expect("a terminator");
        let parent = rw.body[op].parent.expect("placed");
        rw.inline_block_before(f.block, parent, Some(op), &args);
        rw.set_after(op);
        let loc = rw.body[op].loc.clone();
        let inner = rw.body[rw.body[term].regions[0]].blocks[0];
        let mut results = Vec::new();
        for y in rw.body.block_ops(inner) {
            if rw.body[y].name != "tensor.parallel_insert_slice" {
                continue;
            }
            let d = &rw.body[y];
            let dest = d.operands[1];
            let ty = rw.body[dest].ty.clone();
            let mut data = OpData { loc: loc.clone(), ..OpData::build("tensor.insert_slice").operands(&d.operands) };
            for name in ["static_offsets", "static_sizes", "static_strides", "operandSegmentSizes"] {
                if let Some(v) = d.get(name).cloned() {
                    data.set(name, v);
                }
            }
            let s = rw.create(data, &[ty]);
            results.push(rw.body[s].results[0]);
        }
        let old = rw.body[op].results.to_vec();
        for (r, n) in old.iter().zip(&results) {
            rw.replace_all_uses(*r, *n);
        }
        rw.erase_op(term);
        rw.erase_op(op);
    }
}
