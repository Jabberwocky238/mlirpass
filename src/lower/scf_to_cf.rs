//! `convert-scf-to-cf`, as `SCFToControlFlow.cpp`: structured control flow as blocks and
//! branches.

use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{Attribute, NamedAttr, Type};

use super::Lowering;
use crate::canon::AttrExt;
use crate::{BlockId, ConversionPatterns, ConversionRewriter, OpData, OpId, ValueId};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

/// The scf ⇒ cf patterns.
pub struct ScfToCf;

impl ScfToCf {
    fn br(cr: &mut Cr<'_, '_, '_>, dest: BlockId, args: &[ValueId]) -> OpId {
        cr.rw.create(OpData::build("cf.br").operands(args).successors(&[dest]), &[])
    }

    fn cond_br(cr: &mut Cr<'_, '_, '_>, cond: ValueId, t: BlockId, ta: &[ValueId], f: BlockId, fa: &[ValueId]) -> OpId {
        let mut ops = vec![cond];
        ops.extend(ta);
        ops.extend(fa);
        cr.rw.create(OpData::build("cf.cond_br").operands(&ops).successors(&[t, f]).segments(&[1, ta.len(), fa.len()]), &[])
    }

    /// `propagateLoopAttrs`: the llvm-dialect discardable attributes go to the branch.
    fn loop_attrs(cr: &mut Cr<'_, '_, '_>, from: OpId, to: OpId) {
        let attrs: Vec<NamedAttr> = cr.rw.body[from].attributes.iter().filter(|a| a.value.as_ref().is_some_and(|v| matches!(v, Attribute::Extended { ext, .. } if ext.name.starts_with("llvm.")))).cloned().collect();
        cr.rw.body[to].attributes = attrs;
    }

    fn region_of(cr: &Cr<'_, '_, '_>, op: OpId) -> crate::RegionId {
        cr.rw.body[op].parent.and_then(|b| cr.rw.body[b].parent).expect("placed")
    }

    /// Splits the block of `op` before it: (the block, the rest).
    fn split(cr: &mut Cr<'_, '_, '_>, op: OpId) -> (BlockId, BlockId) {
        let block = cr.rw.body[op].parent.expect("placed");
        (block, cr.rw.split_block(block, op))
    }

    fn for_op(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let (init, end) = Self::split(cr, op);
        let region = cr.rw.body[op].regions[0];
        let cond = cr.rw.body[region].blocks[0];
        let head = cr.rw.body[cond].ops[0];
        let first = cr.rw.split_block(cond, head);
        let last = *cr.rw.body[region].blocks.last().expect("a body");
        let parent = Self::region_of(cr, op);
        cr.inline_region(region, parent, Some(end));
        let iv = cr.rw.body[cond].args[0];
        let term = *cr.rw.body[last].ops.last().expect("terminator");
        cr.rw.set_end(last);
        let ops = cr.rw.body[op].operands.clone();
        let stepped = cr.bin("arith.addi", iv, ops[2]);
        let mut carried = vec![stepped];
        carried.extend(cr.rw.body[term].operands.clone());
        let b = Self::br(cr, cond, &carried);
        Self::loop_attrs(cr, op, b);
        cr.erase(term);
        cr.rw.set_end(init);
        let mut dest = vec![ops[0]];
        dest.extend(&ops[3..]);
        Self::br(cr, cond, &dest);
        cr.rw.set_end(cond);
        let pred = if cr.rw.body[op].get("unsignedCmp").is_some_and(|a| matches!(a, Attribute::Unit | Attribute::Bool(true))) { 6 } else { 2 };
        let cmp = cr.build(OpData::build("arith.cmpi").operands(&[iv, ops[1]]).with("predicate", Attribute::i64(pred)), Type::int(1));
        Self::cond_br(cr, cmp, first, &[], end, &[]);
        let results = cr.rw.body[cond].args[1..].to_vec();
        cr.replace_values(op, &results);
        true
    }

    /// The region's last block ends in a branch to `to` with what its terminator yielded.
    fn yield_to(cr: &mut Cr<'_, '_, '_>, block: BlockId, to: BlockId) {
        let term = *cr.rw.body[block].ops.last().expect("terminator");
        let ops = cr.rw.body[term].operands.clone();
        cr.rw.set_end(block);
        Self::br(cr, to, &ops);
        cr.erase(term);
    }

    fn if_op(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let (cond_block, rest) = Self::split(cr, op);
        let types: Vec<Type> = cr.rw.body[op].results.iter().map(|r| cr.rw.body[*r].ty.clone()).collect();
        let parent = Self::region_of(cr, op);
        let cont = if types.is_empty() {
            rest
        } else {
            let b = cr.rw.create_block(parent, &types);
            cr.rw.body[parent].blocks.pop();
            let at = cr.rw.body[parent].blocks.iter().position(|x| *x == rest).expect("split");
            cr.rw.body[parent].blocks.insert(at, b);
            Self::br(cr, rest, &[]);
            b
        };
        let [then_r, else_r] = [0, 1].map(|i| cr.rw.body[op].regions[i]);
        let then_block = cr.rw.body[then_r].blocks[0];
        let then_last = *cr.rw.body[then_r].blocks.last().expect("then");
        Self::yield_to(cr, then_last, cont);
        cr.inline_region(then_r, parent, Some(cont));
        let mut else_block = cont;
        if !cr.rw.body[else_r].blocks.is_empty() {
            else_block = cr.rw.body[else_r].blocks[0];
            let last = *cr.rw.body[else_r].blocks.last().expect("else");
            Self::yield_to(cr, last, cont);
            cr.inline_region(else_r, parent, Some(cont));
        }
        cr.rw.set_end(cond_block);
        let c = cr.rw.body[op].operands[0];
        Self::cond_br(cr, c, then_block, &[], else_block, &[]);
        let results = cr.rw.body[cont].args.clone();
        cr.replace_values(op, &results);
        true
    }

    fn execute_region(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let (cond_block, rest) = Self::split(cr, op);
        let region = cr.rw.body[op].regions[0];
        cr.rw.set_end(cond_block);
        let entry = cr.rw.body[region].blocks[0];
        Self::br(cr, entry, &[]);
        for b in cr.rw.body[region].blocks.clone() {
            if cr.rw.body[b].ops.last().is_some_and(|t| cr.rw.body[*t].name == "scf.yield") {
                Self::yield_to(cr, b, rest);
            }
        }
        let parent = Self::region_of(cr, op);
        cr.inline_region(region, parent, Some(rest));
        let vals: Vec<ValueId> = cr.rw.body[op].results.clone().iter().map(|r| {
            let ty = cr.rw.body[*r].ty.clone();
            cr.rw.body.add_arg(rest, ty)
        }).collect();
        cr.replace_values(op, &vals);
        true
    }

    fn while_op(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let saved = cr.rw.ip;
        let (current, cont) = Self::split(cr, op);
        let [before_r, after_r] = [0, 1].map(|i| cr.rw.body[op].regions[i]);
        let after = cr.rw.body[after_r].blocks[0];
        let before = cr.rw.body[before_r].blocks[0];
        let parent = Self::region_of(cr, op);
        cr.inline_region(after_r, parent, Some(cont));
        cr.inline_region(before_r, parent, Some(after));
        cr.rw.set_end(current);
        let inits = cr.rw.body[op].operands.clone();
        Self::br(cr, before, &inits);
        let cond = *cr.rw.body[before].ops.last().expect("condition");
        let co = cr.rw.body[cond].operands.clone();
        cr.rw.set_before(cond);
        let new = Self::cond_br(cr, co[0], after, &co[1..], cont, &[]);
        let _ = new;
        cr.erase(cond);
        let y = *cr.rw.body[after].ops.last().expect("yield");
        let yo = cr.rw.body[y].operands.clone();
        cr.rw.set_before(y);
        let latch = Self::br(cr, before, &yo);
        cr.erase(y);
        Self::loop_attrs(cr, op, latch);
        cr.replace_values(op, &co[1..]);
        cr.rw.ip = saved;
        true
    }

    fn do_while(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let after_r = cr.rw.body[op].regions[1];
        let after = cr.rw.body[after_r].blocks[0];
        let [y] = cr.rw.body[after].ops[..] else { return false };
        if cr.rw.body[y].name != "scf.yield" || cr.rw.body[y].operands != cr.rw.body[after].args {
            return false;
        }
        let saved = cr.rw.ip;
        let (current, cont) = Self::split(cr, op);
        let before_r = cr.rw.body[op].regions[0];
        let before = cr.rw.body[before_r].blocks[0];
        let parent = Self::region_of(cr, op);
        cr.inline_region(before_r, parent, Some(cont));
        cr.rw.set_end(current);
        let inits = cr.rw.body[op].operands.clone();
        Self::br(cr, before, &inits);
        let cond = *cr.rw.body[before].ops.last().expect("condition");
        let co = cr.rw.body[cond].operands.clone();
        cr.rw.set_end(before);
        let latch = Self::cond_br(cr, co[0], before, &co[1..], cont, &[]);
        Self::loop_attrs(cr, op, latch);
        cr.replace_values(op, &co[1..]);
        cr.erase(cond);
        cr.rw.ip = saved;
        true
    }

    fn index_switch(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let (cond_block, cont) = Self::split(cr, op);
        let results: Vec<ValueId> = cr.rw.body[op].results.clone().iter().map(|r| {
            let ty = cr.rw.body[*r].ty.clone();
            cr.rw.body.add_arg(cont, ty)
        }).collect();
        let parent = Self::region_of(cr, op);
        let convert = |cr: &mut Cr<'_, '_, '_>, region: crate::RegionId| {
            let block = cr.rw.body[region].blocks[0];
            let y = *cr.rw.body[block].ops.last().expect("yield");
            let yo = cr.rw.body[y].operands.clone();
            cr.rw.set_before(y);
            Self::br(cr, cont, &yo);
            cr.erase(y);
            cr.inline_region(region, parent, Some(cont));
            block
        };
        let regions = cr.rw.body[op].regions.clone();
        let cases = cr.rw.body.segments(op, "cases").unwrap_or_default();
        let succs: Vec<BlockId> = regions[1..].iter().map(|r| convert(cr, *r)).collect();
        let default = convert(cr, regions[0]);
        cr.rw.set_end(cond_block);
        let arg = cr.rw.body[op].operands[0];
        let v = cr.op1("arith.index_cast", &[arg], Type::int(32));
        let mut all = vec![default];
        all.extend(&succs);
        let mut data = OpData::build("cf.switch").operands(&[v]).successors(&all).segments(&[1, 0, 0]).with("case_operand_segments", Attribute::DenseArray { ty: Type::int(32), values: vec!["0".into(); succs.len()] });
        if !cases.is_empty() {
            let ty = Type::Shaped(mlirformat::Shaped { kind: mlirformat::ShapedKind::Vector, shape: Some(vec![mlirformat::Dim::Static(cases.len() as i64)]), elem: Type::int(32).into(), extras: Vec::new() });
            let values = cases.iter().map(|c| crate::Scalar::Int(crate::ApInt::new(32, i128::from(*c as i64 as i32)))).collect();
            data.set("case_values", crate::Const { ty, values, elements: true }.into());
        }
        cr.rw.create(data, &[]);
        cr.replace_values(op, &results);
        true
    }

    /// `scf::ForOp::create` without a body builder: the block, and its `scf.yield` when there
    /// is nothing to carry.
    fn bare_for(cr: &mut Cr<'_, '_, '_>, lb: ValueId, ub: ValueId, step: ValueId, inits: &[ValueId]) -> OpId {
        let types: Vec<Type> = inits.iter().map(|v| cr.rw.body[*v].ty.clone()).collect();
        let mut ops = vec![lb, ub, step];
        ops.extend(inits);
        let mut args = vec![(cr.rw.body[lb].ty.clone(), None)];
        args.extend(types.iter().map(|t| (t.clone(), None)));
        let f = cr.rw.create_with(OpData::build("scf.for").operands(&ops), &types, |b, o| {
            let r = b.add_region(o);
            let blk = b.add_block(r, &args);
            if inits.is_empty() {
                let y = b.create(OpData::build("scf.yield"), &[]);
                b.insert(y, blk, None);
            }
        });
        f
    }

    /// `ParallelLowering`: nested `scf.for`s, the reductions inlined into the innermost.
    fn parallel(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let body = cr.rw.body.top_block(op);
        let Some(reduce) = cr.terminator(body) else { return false };
        if cr.rw.body[reduce].name != "scf.reduce" {
            return false;
        }
        let seg = cr.rw.body.segments(op, "operandSegmentSizes").unwrap_or_default();
        let ops = cr.rw.body[op].operands.clone();
        let n = seg[0];
        let mut iter_args: Vec<ValueId> = ops[3 * n..].to_vec();
        let mut ivs = Vec::new();
        let mut results = iter_args.clone();
        for d in 0..n {
            let f = Self::bare_for(cr, ops[d], ops[n + d], ops[2 * n + d], &iter_args);
            let fb = cr.rw.body.top_block(f);
            ivs.push(cr.rw.body[fb].args[0]);
            iter_args = cr.rw.body[fb].args[1..].to_vec();
            let fr = cr.rw.body[f].results.clone();
            if d == 0 {
                results = fr;
            } else if !fr.is_empty() {
                let blk = cr.rw.ip.expect("inside a loop").block;
                cr.rw.set_end(blk);
                cr.rw.create(OpData::build("scf.yield").operands(&fr), &[]);
            }
            cr.rw.set_start(fb);
        }
        let mut yields = Vec::new();
        for i in 0..cr.rw.body[op].results.len() {
            let rb = cr.rw.body[cr.rw.body[reduce].regions[i]].blocks[0];
            let ret = *cr.rw.body[rb].ops.last().expect("reduce.return");
            yields.push(cr.rw.body[ret].operands[0]);
            cr.erase(ret);
            let arg = iter_args[i];
            let operand = cr.rw.body[reduce].operands[i];
            cr.inline_block_before(rb, body, Some(reduce), &[arg, operand]);
        }
        cr.erase(reduce);
        let new_body = cr.rw.ip.expect("inside a loop").block;
        match cr.rw.body[new_body].ops.last().copied() {
            None => cr.merge_blocks(body, new_body, &ivs),
            Some(t) => cr.inline_block_before(body, new_body, Some(t), &ivs),
        }
        if !yields.is_empty() {
            cr.rw.set_end(new_body);
            cr.rw.create(OpData::build("scf.yield").operands(&yields), &[]);
        }
        cr.replace_values(op, &results);
        true
    }

    /// `ForallLowering` (`forallToParallelLoop`).
    fn forall(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let seg = cr.rw.body.segments(op, "operandSegmentSizes").unwrap_or_default();
        if seg.get(3).copied().unwrap_or(0) != 0 {
            return false;
        }
        let ops = cr.rw.body[op].operands.clone();
        let mut dynamic = ops.into_iter();
        let mut mixed = |cr: &mut Cr<'_, '_, '_>, name: &str| -> Vec<ValueId> {
            let st = cr.rw.body.dense_i64(op, name);
            st.iter().map(|c| if *c == crate::DYNAMIC { dynamic.next().expect("a dynamic bound") } else { cr.cidx(*c) }).collect()
        };
        let lbs = mixed(cr, "staticLowerBound");
        let ubs = mixed(cr, "staticUpperBound");
        let steps = mixed(cr, "staticStep");
        let mut operands = lbs.clone();
        operands.extend(&ubs);
        operands.extend(&steps);
        let k = lbs.len();
        let mut data = OpData::build("scf.parallel").operands(&operands).segments(&[k, k, k, 0]);
        if let Some(m) = cr.rw.body[op].get("mapping").cloned() {
            data.set("mapping", m);
        }
        let region = cr.rw.body[op].regions[0];
        let p = cr.rw.create_with(data, &[], |b, o| {
            b.add_region(o);
        });
        let pr = cr.rw.body[p].regions[0];
        cr.inline_region(region, pr, None);
        let blk = cr.rw.body[pr].blocks[0];
        let term = *cr.rw.body[blk].ops.last().expect("in_parallel");
        cr.rw.set_before(term);
        cr.rw.create_with(OpData::build("scf.reduce"), &[], |_, _| {});
        cr.erase(term);
        cr.replace_values(op, &[]);
        true
    }

    pub fn populate(patterns: &mut ConversionPatterns<'_>) {
        let table: [(&'static str, super::LowerFn); 7] = [("scf.forall", Self::forall), ("scf.parallel", Self::parallel), ("scf.for", Self::for_op), ("scf.if", Self::if_op), ("scf.while", Self::while_op), ("scf.execute_region", Self::execute_region), ("scf.index_switch", Self::index_switch)];
        for (root, f) in table {
            patterns.add(Lowering { root, benefit: 1, f });
        }
        patterns.add(Lowering { root: "scf.while", benefit: 2, f: Self::do_while });
    }
}
