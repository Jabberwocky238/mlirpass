//! `populateGpuRewritePatterns`, as `AllReduceLowering.cpp`, `GlobalIdRewriter.cpp` and
//! `ShuffleRewriter.cpp`: uniform `gpu.all_reduce` as subgroup shuffles through a workgroup
//! buffer, `gpu.global_id` from block and thread ids, 64-bit shuffles as two 32-bit ones.

use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{Attribute, Dim, Shaped, ShapedKind, Type};

use super::attrs::{AllReduceOp, Dimension};
use crate::{BlockId, Mapping, OpData, OpId, RegionId, Rewriter, ValueId};

type Rw<'r, 'a> = Rewriter<'r, 'a>;

/// `kSubgroupSize`.
const SUBGROUP: i64 = 32;

/// How two values combine: a `gpu.all_reduce` op kind, or its body.
#[derive(Clone, Copy)]
enum Accum<'k> {
    Kind(&'k str),
    Body(RegionId),
}

/// `GpuAllReduceRewriter` for one reduction.
struct AllReduce<'k> {
    func: OpId,
    op: OpId,
    value_ty: Type<'static>,
    accum: Accum<'k>,
}

fn mk<'a>(rw: &mut Rw<'_, 'a>, data: OpData<'a>, ty: Type<'a>) -> ValueId {
    let o = rw.create(data, &[ty]);
    rw.body[o].results[0]
}

fn int<'a>(rw: &mut Rw<'_, 'a>, v: i64) -> ValueId {
    mk(rw, OpData::build("arith.constant").with("value", Attribute::of_int(v.into(), Type::int(32))), Type::int(32))
}

fn bin<'a>(rw: &mut Rw<'_, 'a>, name: &str, a: ValueId, b: ValueId) -> ValueId {
    let ty = rw.body[a].ty.clone();
    mk(rw, OpData::build(name).operands(&[a, b]), ty)
}

fn cmp<'a>(rw: &mut Rw<'_, 'a>, pred: i64, a: ValueId, b: ValueId) -> ValueId {
    mk(rw, OpData::build("arith.cmpi").operands(&[a, b]).with("predicate", Attribute::i64(pred)), Type::int(1))
}

/// `splitBlock` at the insertion point; the new block.
fn split_here(rw: &mut Rw<'_, '_>) -> BlockId {
    let ip = rw.ip.expect("an insertion point");
    match ip.before {
        Some(at) => rw.split_block(ip.block, at),
        None => {
            let region = rw.body[ip.block].parent.expect("in a region");
            let new = rw.body.add_block(region, &[]);
            let blocks = &mut rw.body[region].blocks;
            blocks.pop();
            let pos = blocks.iter().position(|b| *b == ip.block).expect("in region");
            blocks.insert(pos + 1, new);
            new
        }
    }
}

fn br<'a>(rw: &mut Rw<'_, 'a>, dest: BlockId, args: &[ValueId]) {
    rw.create(OpData::build("cf.br").operands(args).successors(&[dest]), &[]);
}

impl<'k> AllReduce<'k> {
    fn dim<'a>(rw: &mut Rw<'_, 'a>, name: &str, d: &str) -> ValueId {
        let v = mk(rw, OpData::build(name).with("dimension", Attribute::dialect("gpu", &alloc::format!("<dim {d}>"))), Type::Index);
        mk(rw, OpData::build("arith.index_cast").operands(&[v]), Type::int(32))
    }

    /// `createIf`: then / else blocks branching to a continuation taking what they yield.
    fn create_if<'a>(rw: &mut Rw<'_, 'a>, cond: ValueId, then: &mut dyn FnMut(&mut Rw<'_, 'a>) -> Vec<ValueId>, other: &mut dyn FnMut(&mut Rw<'_, 'a>) -> Vec<ValueId>) {
        let current = rw.ip.expect("an insertion point").block;
        let then_b = split_here(rw);
        rw.set_start(then_b);
        let else_b = split_here(rw);
        rw.set_start(else_b);
        let cont = split_here(rw);
        rw.set_end(current);
        rw.create(OpData::build("cf.cond_br").operands(&[cond]).segments(&[1, 0, 0]).successors(&[then_b, else_b]), &[]);
        rw.set_start(then_b);
        let t = then(rw);
        br(rw, cont, &t);
        rw.set_start(else_b);
        let e = other(rw);
        br(rw, cont, &e);
        rw.set_start(cont);
        for v in t {
            let ty = rw.body[v].ty.clone();
            let loc = rw.body[v].loc.clone();
            let a = rw.body.add_arg(cont, ty);
            rw.body[a].loc = loc;
        }
    }

    fn predicated<'a>(rw: &mut Rw<'_, 'a>, cond: ValueId, f: &mut dyn FnMut(&mut Rw<'_, 'a>)) {
        Self::create_if(
            rw,
            cond,
            &mut |rw| {
                f(rw);
                Vec::new()
            },
            &mut |_| Vec::new(),
        );
    }

    /// The accumulator factory applied to `lhs` and `rhs`.
    fn accumulate<'a>(&self, rw: &mut Rw<'_, 'a>, lhs: ValueId, rhs: ValueId) -> ValueId {
        match self.accum {
            Accum::Kind(k) => Self::combine(rw, k, lhs, rhs),
            Accum::Body(body) => {
                let block = rw.ip.expect("an insertion point").block;
                let split = split_here(rw);
                let region = rw.body[block].parent.expect("in a region");
                let entry = rw.body[body].blocks[0];
                let mut map = Mapping::default();
                let args = rw.body[entry].args.clone();
                map.map(args[0], lhs);
                map.map(args[1], rhs);
                rw.clone_region_before(body, region, Some(split), &mut map);
                let blocks = rw.body[region].blocks.clone();
                let at = blocks.iter().position(|b| *b == block).expect("in region");
                rw.set_end(block);
                br(rw, blocks[at + 1], &[]);
                for b in &blocks[at + 1..] {
                    if *b == split {
                        break;
                    }
                    let Some(&term) = rw.body[*b].ops.last() else { continue };
                    if rw.body[term].name != "gpu.yield" {
                        continue;
                    }
                    let v = rw.body[term].operands[0];
                    rw.set_end(*b);
                    rw.replace_with(term, OpData::build("cf.br").operands(&[v]).successors(&[split]), &[]);
                }
                rw.set_start(split);
                let ty = rw.body[lhs].ty.clone();
                let loc = rw.body[lhs].loc.clone();
                let a = rw.body.add_arg(split, ty);
                rw.body[a].loc = loc;
                a
            }
        }
    }

    /// `vector::makeArithReduction` of `convertReductionKind(op)`.
    fn combine<'a>(rw: &mut Rw<'_, 'a>, kind: &str, a: ValueId, b: ValueId) -> ValueId {
        let ty = rw.body[a].ty.clone();
        let float = matches!(ty, Type::Float(_));
        let name = match (kind, float) {
            ("add", false) => "arith.addi",
            ("add", true) => "arith.addf",
            ("mul", false) => "arith.muli",
            ("mul", true) => "arith.mulf",
            ("and", _) => "arith.andi",
            ("or", _) => "arith.ori",
            ("xor", _) => "arith.xori",
            ("maxnumf", _) => "arith.maxnumf",
            ("maximumf", _) => "arith.maximumf",
            ("minnumf", _) => "arith.minnumf",
            ("minimumf", _) => "arith.minimumf",
            ("maxsi", _) => "arith.maxsi",
            ("minsi", _) => "arith.minsi",
            ("maxui", _) => "arith.maxui",
            _ => "arith.minui",
        };
        rw.create_or_fold(OpData::build(name).operands(&[a, b]), &[ty])[0]
    }

    fn shuffle<'a>(&self, rw: &mut Rw<'_, 'a>, value: ValueId, offset: ValueId, width: ValueId) -> (ValueId, ValueId) {
        let data = OpData::build("gpu.shuffle").operands(&[value, offset, width]).with("mode", Attribute::dialect("gpu", "<shuffle_mode xor>"));
        let o = rw.create(data, &[self.value_ty.clone(), Type::int(1)]);
        (rw.body[o].results[0], rw.body[o].results[1])
    }

    /// `createSubgroupReduce`.
    fn subgroup_reduce<'a>(&self, rw: &mut Rw<'_, 'a>, active: ValueId, operand: ValueId) -> ValueId {
        let size = int(rw, SUBGROUP);
        let partial = cmp(rw, 2, active, size);
        Self::create_if(
            rw,
            partial,
            &mut |rw| {
                let mut value = operand;
                let mut i = 1;
                while i < SUBGROUP {
                    let offset = int(rw, i);
                    let (v, valid) = self.shuffle(rw, value, offset, active);
                    let cur = value;
                    Self::create_if(rw, valid, &mut |rw| vec![self.accumulate(rw, cur, v)], &mut |_| vec![cur]);
                    let blk = rw.ip.expect("an insertion point").block;
                    value = rw.body[blk].args[0];
                    i <<= 1;
                }
                vec![value]
            },
            &mut |rw| {
                let mut value = operand;
                let mut i = 1;
                while i < SUBGROUP {
                    let offset = int(rw, i);
                    let (v, _) = self.shuffle(rw, value, offset, size);
                    value = self.accumulate(rw, value, v);
                    i <<= 1;
                }
                vec![value]
            },
        );
        let blk = rw.ip.expect("an insertion point").block;
        rw.body[blk].args[0]
    }

    fn div_subgroup<'a>(rw: &mut Rw<'_, 'a>, v: ValueId) -> ValueId {
        let s = int(rw, SUBGROUP);
        bin(rw, "arith.divsi", v, s)
    }

    /// `addWorkgroupAttribution`: a `memref<32 x value, workgroup>` block argument after the
    /// existing workgroup attributions.
    fn workgroup_buffer<'a>(&self, rw: &mut Rw<'_, 'a>) -> ValueId {
        let ty = Type::Shaped(Shaped { kind: ShapedKind::MemRef, shape: Some(vec![Dim::Static(SUBGROUP)]), elem: self.value_ty.clone().into(), extras: vec![Attribute::dialect("gpu.address_space", "<workgroup>")] });
        let b = &*rw.body;
        let Some(Attribute::Type(Type::Function(fty))) = b[self.func].get("function_type") else { unreachable!("gpu.func") };
        let n_in = fty.inputs.len();
        let n_wg: usize = match b[self.func].get("workgroup_attributions") {
            Some(Attribute::Int { lit, .. }) => lit.parse().unwrap_or(0),
            _ => 0,
        };
        let entry = b[b[self.func].regions[0]].blocks[0];
        let v = rw.body.insert_arg(entry, n_in + n_wg, ty, Some("unknown".into()));
        let f = self.func;
        rw.modify(f, |b| b[f].set("workgroup_attributions", Attribute::i64((n_wg + 1) as i64)));
        v
    }

    fn rewrite(&self, rw: &mut Rw<'_, '_>) {
        rw.set_before(self.op);
        let value = rw.body[self.op].operands[0];
        let [dim_x, dim_y, dim_z] = ["x", "y", "z"].map(|d| Self::dim(rw, "gpu.block_dim", d));
        let [tid_x, tid_y, tid_z] = ["x", "y", "z"].map(|d| Self::dim(rw, "gpu.thread_id", d));
        let t1 = bin(rw, "arith.muli", tid_z, dim_y);
        let t2 = bin(rw, "arith.addi", t1, tid_y);
        let t3 = bin(rw, "arith.muli", t2, dim_x);
        let t4 = bin(rw, "arith.muli", dim_x, dim_y);
        let invocation = bin(rw, "arith.addi", t3, tid_x);
        let wg_size = bin(rw, "arith.muli", t4, dim_z);
        let mask = int(rw, SUBGROUP - 1);
        let lane = bin(rw, "arith.andi", invocation, mask);
        let zero32 = int(rw, 0);
        let first = cmp(rw, 0, lane, zero32);
        let smaller = bin(rw, "arith.subi", invocation, lane);
        let active = bin(rw, "arith.subi", wg_size, smaller);
        let reduced = self.subgroup_reduce(rw, active, value);
        let buffer = self.workgroup_buffer(rw);
        let vt = self.value_ty.clone();
        Self::predicated(rw, first, &mut |rw| {
            let sid = Self::div_subgroup(rw, invocation);
            let idx = mk(rw, OpData::build("arith.index_cast").operands(&[sid]), Type::Index);
            rw.create(OpData::build("memref.store").operands(&[reduced, buffer, idx]), &[]);
        });
        rw.create(OpData::build("gpu.barrier"), &[]);
        let biased = bin(rw, "arith.addi", wg_size, mask);
        let n_sub = Self::div_subgroup(rw, biased);
        let valid = cmp(rw, 2, invocation, n_sub);
        let zero = mk(rw, OpData::build("arith.constant").with("value", Attribute::index(0)), Type::Index);
        Self::predicated(rw, valid, &mut |rw| {
            let idx = mk(rw, OpData::build("arith.index_cast").operands(&[invocation]), Type::Index);
            let v = mk(rw, OpData::build("memref.load").operands(&[buffer, idx]), vt.clone());
            let r = self.subgroup_reduce(rw, n_sub, v);
            rw.create(OpData::build("memref.store").operands(&[r, buffer, zero]), &[]);
        });
        rw.create(OpData::build("gpu.barrier"), &[]);
        let r = mk(rw, OpData::build("memref.load").operands(&[buffer, zero]), self.value_ty.clone());
        rw.replace_op(self.op, &[r]);
    }
}

/// `populateGpuRewritePatterns`.
pub struct GpuRewrite;

#[crate::patterns]
impl GpuRewrite {
    /// `GpuAllReduceRewrite`: every uniform reduction of a `gpu.func`.
    #[rewrite("gpu.func")]
    fn gpu_all_reduce_rewrite(rw: &mut Rw<'_, '_>, func: OpId) -> bool {
        let mut reduces = Vec::new();
        for o in rw.body.ops_in(func) {
            if rw.body[o].name != "gpu.all_reduce" {
                continue;
            }
            if rw.body[o].get("uniform").is_none() {
                return false;
            }
            reduces.push(o);
        }
        if reduces.is_empty() {
            return false;
        }
        for op in reduces {
            let value_ty = rw.body[rw.body[op].operands[0]].ty.clone().owned();
            let body = rw.body[op].regions[0];
            let kind = rw.body[op].get("op").and_then(|a| AllReduceOp::try_from(a).ok());
            let accum = if !rw.body[body].blocks.is_empty() {
                Accum::Body(body)
            } else if let Some(k) = kind {
                Accum::Kind(k.name())
            } else {
                return false;
            };
            let r = AllReduce { func, op, value_ty, accum };
            r.rewrite(rw);
        }
        true
    }

    /// `GpuGlobalIdRewriter`.
    #[rewrite("gpu.global_id")]
    fn gpu_global_id_rewriter(rw: &mut Rw<'_, '_>, op: OpId) -> bool {
        let Some(d) = rw.body[op].get("dimension").cloned() else { return false };
        if Dimension::try_from(&d).is_err() {
            return false;
        }
        rw.set_before(op);
        let id = mk(rw, OpData::build("gpu.block_id").with("dimension", d.clone()), Type::Index);
        let dim = mk(rw, OpData::build("gpu.block_dim").with("dimension", d.clone()), Type::Index);
        let tmp = bin(rw, "arith.muli", id, dim);
        let tid = mk(rw, OpData::build("gpu.thread_id").with("dimension", d), Type::Index);
        rw.replace_with(op, OpData::build("arith.addi").operands(&[tid, tmp]), &[Type::Index]);
        true
    }

    /// `GpuShuffleRewriter`: a 64-bit shuffle as its two halves.
    #[rewrite("gpu.shuffle")]
    fn gpu_shuffle_rewriter<'a>(rw: &mut Rw<'_, 'a>, op: OpId) -> bool {
        let ops = rw.body[op].operands.clone();
        let vt = rw.body[ops[0]].ty.clone();
        if !matches!(vt, Type::Integer { .. } | Type::Float(_)) || vt.bit_width() != Some(64) {
            return false;
        }
        let mode = rw.body[op].get("mode").cloned();
        let (i32t, i64t) = (Type::int(32), Type::int(64));
        rw.set_before(op);
        let float = matches!(vt, Type::Float(_));
        let mut value = ops[0];
        if float {
            value = mk(rw, OpData::build("arith.bitcast").operands(&[value]), i64t.clone());
        }
        let lo = mk(rw, OpData::build("arith.trunci").operands(&[value]), i32t.clone());
        let c32 = mk(rw, OpData::build("arith.constant").with("value", Attribute::of_int(32, i64t.clone())), i64t.clone());
        let hi = bin(rw, "arith.shrui", value, c32);
        let hi = mk(rw, OpData::build("arith.trunci").operands(&[hi]), i32t.clone());
        let shuffle = |rw: &mut Rw<'_, 'a>, v: ValueId| {
            let mut d = OpData::build("gpu.shuffle").operands(&[v, ops[1], ops[2]]);
            if let Some(m) = &mode {
                d.set("mode", m.clone());
            }
            let o = rw.create(d, &[Type::int(32), Type::int(1)]);
            (rw.body[o].results[0], rw.body[o].results[1])
        };
        let (lo_v, lo_ok) = shuffle(rw, lo);
        let (hi_v, hi_ok) = shuffle(rw, hi);
        let lo = mk(rw, OpData::build("arith.extui").operands(&[lo_v]), i64t.clone());
        let hi = mk(rw, OpData::build("arith.extui").operands(&[hi_v]), i64t.clone());
        let hi = bin(rw, "arith.shli", hi, c32);
        let mut v = bin(rw, "arith.ori", hi, lo);
        if float {
            v = mk(rw, OpData::build("arith.bitcast").operands(&[v]), vt);
        }
        let ok = bin(rw, "arith.andi", lo_ok, hi_ok);
        rw.replace_op(op, &[v, ok]);
        true
    }
}

/// `populateGpuPromoteShuffleToAMDGPUPatterns`: a 64-wide constant xor shuffle as an
/// `amdgpu.swizzle_bitmode` (offset below 32) ...
pub struct GpuPromoteShuffleToSwizzle;

/// ... or, on gfx950 and later, an `amdgpu.permlane_swap` (offset 16 or 32).
pub struct GpuPromoteShuffleToPermlane;

/// The constant offset of a 64-wide xor shuffle.
fn xor64_offset(rw: &Rw<'_, '_>, op: OpId) -> Option<i64> {
    let b = &*rw.body;
    let mode = b[op].get("mode").and_then(|a| super::attrs::ShuffleMode::try_from(a).ok())?;
    if mode != super::attrs::ShuffleMode::Xor || b.int_constant(b[op].operands[2]) != Some(64) {
        return None;
    }
    b.int_constant(b[op].operands[1]).map(|o| o as i64)
}

fn promoted<'a>(rw: &mut Rw<'_, 'a>, op: OpId, data: OpData<'a>) {
    let ty = rw.body[rw.body[op].results[0]].ty.clone();
    rw.set_before(op);
    let r = mk(rw, data, ty);
    let valid = mk(rw, OpData::build("arith.constant").with("value", Attribute::Bool(true)), Type::int(1));
    rw.replace_op(op, &[r, valid]);
}

#[crate::patterns]
impl GpuPromoteShuffleToSwizzle {
    /// `PromoteShuffleToSwizzlePattern`.
    #[rewrite("gpu.shuffle")]
    fn promote_shuffle_to_swizzle_pattern(rw: &mut Rw<'_, '_>, op: OpId) -> bool {
        let Some(offset) = xor64_offset(rw, op).filter(|o| (0..32).contains(o)) else { return false };
        let v = rw.body[op].operands[0];
        let i32a = |n: i64| Attribute::of_int(n.into(), Type::int(32));
        promoted(rw, op, OpData::build("amdgpu.swizzle_bitmode").operands(&[v]).with("and_mask", i32a(31)).with("or_mask", i32a(0)).with("xor_mask", i32a(offset)));
        true
    }
}

#[crate::patterns]
impl GpuPromoteShuffleToPermlane {
    /// `PromoteShuffleToPermlanePattern`.
    #[rewrite("gpu.shuffle", benefit = 2)]
    fn promote_shuffle_to_permlane_pattern(rw: &mut Rw<'_, '_>, op: OpId) -> bool {
        let Some(offset) = xor64_offset(rw, op).filter(|o| matches!(o, 16 | 32)) else { return false };
        let v = rw.body[op].operands[0];
        promoted(rw, op, OpData::build("amdgpu.permlane_swap").operands(&[v]).with("row_length", Attribute::of_int(offset.into(), Type::int(32))));
        true
    }
}
