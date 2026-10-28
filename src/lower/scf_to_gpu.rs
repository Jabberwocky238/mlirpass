//! Loops onto the GPU: `gpu-map-parallel-loops` (`ParallelLoopMapper.cpp`),
//! `convert-parallel-loops-to-gpu` and `convert-affine-for-to-gpu` (`SCFToGPU.cpp`).

use alloc::format;
use alloc::string::String;
use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{AffineExpr, AffineMap, Attribute, EffectKind, Error, Type};

use super::AffineExpand;
use crate::{Action, Body, BlockId, ConversionConfig, ConversionPattern, ConversionPatterns, ConversionRewriter, ConversionTarget, Converter, InsertPoint, Mapping, Mode, OpData, OpId, Rewriter, ValueId};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

/// `gpu::Processor`, in `getLaunchOpArgumentNum` order, then sequential.
const PROCESSORS: [&str; 7] = ["block_x", "block_y", "block_z", "thread_x", "thread_y", "thread_z", "sequential"];

/// One `#gpu.loop_dim_map<processor = .., map = .., bound = ..>`.
struct DimMapping {
    /// Index into [`PROCESSORS`].
    processor: usize,
    map: AffineMap,
    bound: AffineMap,
}

impl TryFrom<&Attribute<'_>> for DimMapping {
    type Error = ();

    fn try_from(a: &Attribute<'_>) -> Result<Self, ()> {
        let Attribute::Extended { ext, .. } = a else { return Err(()) };
        let body = ext.body.as_deref().ok_or(())?.trim().trim_start_matches('<').trim_end_matches('>');
        let field = |key: &str| {
            let (_, rest) = body.split_once(&*format!("{key} = ")).ok_or(())?;
            Ok::<&str, ()>(rest.split(", map = ").next().unwrap_or(rest).split(", bound = ").next().unwrap_or(rest).trim())
        };
        let name = field("processor")?;
        let processor = PROCESSORS.iter().position(|p| *p == name).ok_or(())?;
        Ok(Self { processor, map: AffineMap::parse(field("map")?).ok_or(())?, bound: AffineMap::parse(field("bound")?).ok_or(())? })
    }
}

impl DimMapping {
    fn attr<'a>(processor: usize) -> Attribute<'a> {
        Attribute::dialect("gpu.loop_dim_map", &format!("<processor = {}, map = (d0) -> (d0), bound = (d0) -> (d0)>", PROCESSORS[processor]))
    }
}

impl Body<'_> {
    /// `mapParallelOp`: the hardware ids for a parallel loop at `level` (grid, block,
    /// sequential), its nested loops at the next level.
    fn map_parallel(&mut self, op: OpId, level: usize, innermost: bool) {
        if self[op].get("mapping").is_some() || (level == 0 && self.parent_of_named(op, "scf.parallel")) {
            return;
        }
        let n = self.segments(op, "operandSegmentSizes").map_or(0, |s| s[0]);
        let mapped = n.min(3);
        let attrs = (0..n)
            .map(|i| {
                let hw = if i < mapped { if innermost { mapped - 1 - i } else { i } } else { 3 };
                DimMapping::attr(if hw >= 3 || level >= 2 { 6 } else { level * 3 + hw })
            })
            .collect();
        self[op].set("mapping", Attribute::Array(attrs));
        let body = self[self[op].regions[0]].blocks[0];
        for o in self[body].ops.clone() {
            if self[o].name == "scf.parallel" {
                self.map_parallel(o, (level + 1).min(2), innermost);
            }
        }
    }

    fn parent_of_named(&self, op: OpId, name: &str) -> bool {
        let mut p = self.parent_op(op);
        while let Some(o) = p {
            if self[o].name == name {
                return true;
            }
            p = self.parent_op(o);
        }
        false
    }

    /// `LocalAliasAnalysis::alias` as far as the lowering asks: through views to the
    /// underlying value; distinct allocations, or an allocation and a function argument, do not
    /// alias.
    fn may_alias(&self, a: ValueId, b: ValueId) -> bool {
        let base = |mut v: ValueId| {
            while let Some(d) = self.def_op(v).filter(|d| matches!(&*self[*d].name, "memref.subview" | "memref.cast" | "memref.view" | "memref.reinterpret_cast" | "memref.collapse_shape" | "memref.expand_shape")) {
                v = self[d].operands[0];
            }
            v
        };
        let (a, b) = (base(a), base(b));
        if a == b {
            return true;
        }
        let alloc = |v: ValueId| self.def_op(v).is_some_and(|d| matches!(&*self[d].name, "memref.alloc" | "memref.alloca"));
        let arg = |v: ValueId| self.def_op(v).is_none();
        !((alloc(a) && alloc(b)) || (alloc(a) && arg(b)) || (arg(a) && alloc(b)))
    }

    /// `getConstantIntValue`.
    fn int_value(&self, v: ValueId) -> Option<i64> {
        self.int_constant(v).map(|i| i as i64)
    }
}

/// `gpu-map-parallel-loops`.
#[crate::pass("gpu-map-parallel-loops")]
pub struct GpuMapParallelLoops {
    #[opt("mapping-policy", default = String::from("outermost-first"))]
    policy: String,
}

impl crate::Run for GpuMapParallelLoops {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let innermost = match &*self.policy.trim().to_lowercase() {
            "innermost-first" => true,
            "outermost-first" => false,
            _ => return Err(Error(String::from("Invalid mapping policy specified."))),
        };
        let mut loops = Vec::new();
        for r in body[op].regions.clone() {
            for b in body[r].blocks.clone() {
                for o in body[b].ops.clone() {
                    body.walk_post(o, &mut |x| {
                        if body[x].name == "scf.parallel" {
                            loops.push(x);
                        }
                    });
                }
            }
        }
        for l in loops {
            body.map_parallel(l, 0, innermost);
        }
        Ok(())
    }
}

/// What is left to do while lowering a loop nest into a launch.
enum Work {
    Op(OpId),
    /// Leave the `scf.if` / `scf.for` the insertion point is in.
    Leave,
}

/// `ParallelToGpuLaunchLowering`.
struct ParallelToLaunch;

impl ParallelToLaunch {
    /// A constant index at the insertion point.
    fn index(cr: &mut Cr<'_, '_, '_>, v: i64) -> ValueId {
        cr.index_constant(v)
    }

    /// `ensureLaunchIndependent`: a value usable outside the launch (a constant rebuilt).
    fn independent(cr: &mut Cr<'_, '_, '_>, launch: OpId, v: ValueId) -> Option<ValueId> {
        if Self::launch_independent(&cr.rw.body, launch, v) {
            return Some(v);
        }
        let c = cr.rw.body.int_value(v)?;
        Some(Self::index(cr, c))
    }

    /// The value's region holds the launch.
    fn launch_independent(b: &Body<'_>, launch: OpId, v: ValueId) -> bool {
        let Some(vr) = b.value_block(v).and_then(|blk| b[blk].parent) else { return false };
        let mut r = b[launch].parent.and_then(|blk| b[blk].parent);
        while let Some(rr) = r {
            if rr == vr {
                return true;
            }
            r = b[b[rr].parent].parent.and_then(|blk| b[blk].parent);
        }
        false
    }

    /// `deriveStaticUpperBound`.
    fn static_upper_bound(cr: &mut Cr<'_, '_, '_>, ub: ValueId) -> Option<ValueId> {
        let b = &cr.rw.body;
        let def = b.def_op(ub)?;
        match &*b[def].name {
            "arith.constant" if b[ub].ty == Type::Index => Some(ub),
            "affine.min" => {
                let map = b.affine_map(def, "map")?;
                let c = map.results.iter().find_map(AffineExpr::as_const)?;
                Some(Self::index(cr, c))
            }
            "arith.minsi" => {
                let ops = b[def].operands.clone();
                ops.into_iter().find_map(|o| Self::static_upper_bound(cr, o))
            }
            "arith.muli" => {
                let ops = b[def].operands.clone();
                let l = Self::static_upper_bound(cr, ops[0]).and_then(|v| cr.rw.body.int_value(v))?;
                let r = Self::static_upper_bound(cr, ops[1]).and_then(|v| cr.rw.body.int_value(v))?;
                if (l < 0) != (r < 0) {
                    return None;
                }
                Some(Self::index(cr, l * r))
            }
            _ => None,
        }
    }

    /// `processParallelLoop`.
    fn process(cr: &mut Cr<'_, '_, '_>, par: OpId, launch: OpId, map: &mut Mapping, work: &mut Vec<Work>, bounds: &mut Vec<(usize, ValueId)>) -> bool {
        let Some(Attribute::Array(mapping)) = cr.rw.body[par].get("mapping").cloned() else { return false };
        if cr.rw.body[par].results.len() > 1 {
            return false;
        }
        let loc = cr.rw.body[par].loc.clone();
        let segs = cr.rw.body.segments(par, "operandSegmentSizes").unwrap_or_default();
        let ops = cr.rw.body[par].operands.clone();
        let n = segs[0];
        let entry = cr.rw.body[cr.rw.body[par].regions[0]].blocks[0];
        let ivs = cr.rw.body[entry].args.clone();
        let launch_args = cr.rw.body[cr.rw.body[cr.rw.body[launch].regions[0]].blocks[0]].args.clone();
        for (i, attr) in mapping.iter().enumerate().take(n) {
            let (iv, lb, ub, step) = (ivs[i], ops[i], ops[n + i], ops[2 * n + i]);
            let Ok(dm) = DimMapping::try_from(attr) else { return false };
            let new_index;
            if dm.processor < 6 {
                let operand = launch_args[dm.processor];
                let lower_and_step = AffineMap { dims: 1, syms: 2, results: vec![AffineExpr::Dim(0).mul(AffineExpr::Sym(0)).add(AffineExpr::Sym(1))] };
                let (Some(st), Some(lo)) = (Self::independent(cr, launch, map.get(step)), Self::independent(cr, launch, map.get(lb))) else { return false };
                let m = dm.map.compose(&lower_and_step);
                new_index = cr.build(OpData::build("affine.apply").operands(&[operand, st, lo]).with("map", Attribute::from(&m)), Type::Index);
                let b = &cr.rw.body;
                if !Self::launch_independent(b, launch, lb) && b.int_value(lb).is_none() {
                    return false;
                }
                if !Self::launch_independent(b, launch, step) && b.int_value(step).is_none() {
                    return false;
                }
                let precise = Self::launch_independent(b, launch, ub) || b.int_value(ub).is_some();
                let saved = cr.rw.ip;
                cr.rw.set_before(launch);
                let mut upper = ub;
                if !precise {
                    match Self::static_upper_bound(cr, ub) {
                        Some(u) => upper = u,
                        None => {
                            cr.rw.ip = saved;
                            return false;
                        }
                    }
                }
                let step_map = AffineMap { dims: 1, syms: 2, results: vec![AffineExpr::Dim(0).sub(AffineExpr::Sym(0)).ceil_div(AffineExpr::Sym(1))] };
                let bm = dm.bound.compose(&step_map);
                let (u, l, s) = (Self::independent(cr, launch, map.get(upper)), Self::independent(cr, launch, map.get(lb)), Self::independent(cr, launch, map.get(step)));
                let (Some(u), Some(l), Some(s)) = (u, l, s) else {
                    cr.rw.ip = saved;
                    return false;
                };
                let bound = cr.build(OpData::build("affine.apply").operands(&[u, l, s]).with("map", Attribute::from(&bm)), Type::Index);
                if bounds.iter().any(|(p, _)| *p == dm.processor) {
                    cr.rw.ip = saved;
                    return false;
                }
                bounds.push((dm.processor, bound));
                cr.rw.ip = saved;
                if !precise {
                    let cmp = cr.build(OpData::build("arith.cmpi").operands(&[new_index, map.get(ub)]).with("predicate", Attribute::i64(2)), Type::I1);
                    let mut data = OpData::build("scf.if").operands(&[cmp]);
                    data.loc = loc.clone();
                    let if_op = cr.rw.create_with(data, &[], |b, o| {
                        let then = b.add_region(o);
                        b.add_region(o);
                        let blk = b.add_block(then, &[]);
                        let y = b.create(OpData::build("scf.yield"), &[]);
                        b.insert(y, blk, None);
                    });
                    let then = cr.rw.body[cr.rw.body[if_op].regions[0]].blocks[0];
                    cr.rw.set_start(then);
                    work.push(Work::Leave);
                }
            } else {
                let mut data = OpData::build("scf.for").operands(&[map.get(lb), map.get(ub), map.get(step)]);
                data.loc = loc.clone();
                let for_op = cr.rw.create_with(data, &[], |b, o| {
                    let r = b.add_region(o);
                    let blk = b.add_block(r, &[(Type::Index, loc.clone())]);
                    let y = b.create(OpData::build("scf.yield"), &[]);
                    b.insert(y, blk, None);
                });
                let blk = cr.rw.body[cr.rw.body[for_op].regions[0]].blocks[0];
                new_index = cr.rw.body[blk].args[0];
                cr.rw.set_start(blk);
                work.push(Work::Leave);
            }
            map.map(iv, new_index);
        }
        for a in cr.rw.body[par].all_attrs() {
            if a.name == "mapping" || a.name == "operandSegmentSizes" {
                continue;
            }
            cr.rw.body[launch].set(&a.name, a.value.unwrap_or(Attribute::Unit));
        }
        let ops = cr.rw.body[entry].ops.clone();
        let (term, rest) = ops.split_last().expect("a terminator");
        if cr.rw.body[*term].name == "scf.reduce" && cr.rw.body[*term].operands.len() == 1 {
            work.push(Work::Op(*term));
        }
        work.extend(rest.iter().rev().map(|o| Work::Op(*o)));
        true
    }

    /// The read / write effects of a nested loop touch nothing written so far.
    fn independent_of(b: &Body<'_>, par: OpId, written: &[ValueId]) -> bool {
        b.ops_in(par).into_iter().all(|o| {
            if b.is_memory_effect_free(o) {
                return true;
            }
            let Some(effects) = b.effects_of(o) else { return true };
            effects.iter().filter(|e| matches!(e.kind, EffectKind::Read | EffectKind::Write)).all(|e| e.value.is_some_and(|v| written.iter().all(|w| !b.may_alias(v, *w))))
        })
    }

    fn lower(cr: &mut Cr<'_, '_, '_>, par: OpId) -> bool {
        cr.rw.body[par].set("SCFToGPU_visited", Attribute::Unit);
        if cr.rw.body.parent_of_named(par, "scf.parallel") {
            return false;
        }
        let loc = cr.rw.body[par].loc.clone();
        cr.rw.set_before(par);
        let one = Self::index(cr, 1);
        let mut data = OpData::build("gpu.launch").operands(&[one; 6]).with("operandSegmentSizes", Attribute::dense_i32(&[0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0])).with("workgroup_attributions", Attribute::integer(0, Type::int(64)));
        data.loc = loc.clone();
        let launch = cr.rw.create_with(data, &[], |b, o| {
            let r = b.add_region(o);
            let blk = b.add_block(r, &vec![(Type::Index, loc.clone()); 12]);
            let mut t = OpData::build("gpu.terminator");
            t.loc = loc.clone();
            let t = b.create(t, &[]);
            b.insert(t, blk, None);
        });
        let block = cr.rw.body[cr.rw.body[launch].regions[0]].blocks[0];
        cr.rw.set_start(block);
        let mut map = Mapping::default();
        let mut bounds = Vec::new();
        let mut work = Vec::new();
        if !Self::process(cr, par, launch, &mut map, &mut work, &mut bounds) {
            return false;
        }
        let (mut side_effects, mut left_scope) = (false, false);
        let mut written: Vec<ValueId> = Vec::new();
        while let Some(w) = work.pop() {
            match w {
                Work::Leave => {
                    let ip = cr.rw.ip.expect("an insertion point");
                    let parent = cr.rw.body.block_owner(ip.block).expect("in an op");
                    cr.rw.set_after(parent);
                    left_scope = true;
                    side_effects = false;
                    written.clear();
                }
                Work::Op(op) if cr.rw.body[op].name == "scf.parallel" => {
                    if side_effects && !Self::independent_of(&cr.rw.body, op, &written) {
                        return false;
                    }
                    if !Self::process(cr, op, launch, &mut map, &mut work, &mut bounds) {
                        return false;
                    }
                }
                Work::Op(op) if cr.rw.body[op].name == "scf.reduce" => {
                    let Some(parent) = cr.rw.body.parent_op(op).filter(|p| cr.rw.body[*p].name == "scf.parallel") else { return false };
                    let operand = cr.rw.body[op].operands[0];
                    let Some(&value) = map.values.get(&operand) else { return false };
                    if !matches!(cr.rw.body[operand].ty, Type::Integer { signedness: mlirformat::Signedness::Signless, .. } | Type::Float(_)) {
                        return false;
                    }
                    let region = cr.rw.body[op].regions[0];
                    if !cr.rw.body.used_values_defined_above(region).is_empty() {
                        return false;
                    }
                    let ty = cr.rw.body[value].ty.clone();
                    let mut data = OpData::build("gpu.all_reduce").operands(&[value]);
                    data.loc = loc.clone();
                    let red = cr.rw.create_with(data, &[ty], |b, o| {
                        b.add_region(o);
                    });
                    let r0 = cr.rw.body[parent].results[0];
                    let rr = cr.rw.body[red].results[0];
                    map.map(r0, rr);
                    let into = cr.rw.body[red].regions[0];
                    cr.rw.inline_region_before(region, into, None);
                    let first = cr.rw.body[into].blocks[0];
                    let ret = *cr.rw.body[first].ops.last().expect("a terminator");
                    let v = cr.rw.body[ret].operands[0];
                    let saved = cr.rw.ip;
                    cr.rw.set_end(first);
                    let y = cr.rw.create(OpData::build("gpu.yield").operands(&[v]), &[]);
                    cr.rw.body[y].loc = cr.rw.body[ret].loc.clone();
                    cr.rw.erase_op(ret);
                    cr.rw.ip = saved;
                }
                Work::Op(op) => {
                    let c = cr.rw.clone(op, &mut map);
                    let b = &cr.rw.body;
                    let free = b.is_memory_effect_free(c);
                    if !free && let Some(effects) = b.effects_of(c) {
                        for e in effects.iter().filter(|e| e.kind == EffectKind::Write) {
                            let Some(v) = e.value else { return false };
                            written.push(v);
                        }
                    }
                    side_effects |= !free || !b[c].regions.is_empty();
                    if side_effects && left_scope {
                        return false;
                    }
                }
            }
        }
        for (p, v) in bounds {
            cr.rw.body.set_operand(launch, p, v);
        }
        cr.erase(par);
        true
    }
}

impl ConversionPattern for ParallelToLaunch {
    fn name(&self) -> &str {
        "ParallelToGpuLaunchLowering"
    }

    fn root(&self) -> Option<&str> {
        Some("scf.parallel")
    }

    fn rewrite(&self, cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        Self::lower(cr, op)
    }
}

/// `convert-parallel-loops-to-gpu`.
#[crate::pass("convert-parallel-loops-to-gpu")]
pub fn convert_parallel_loops_to_gpu<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let mut patterns = ConversionPatterns::default();
    patterns.add(ParallelToLaunch);
    let mut target = ConversionTarget::default();
    target.unknown(Action::Legal).legal_dialect("memref");
    target.op("scf.parallel", Action::Dynamic(alloc::boxed::Box::new(|b: &Body<'_>, o| (b[o].get("mapping").is_none() || b[o].get("SCFToGPU_visited").is_some()).then_some(true))));
    Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)?;
    let mut loops = Vec::new();
    body.walk(op, &mut |o| {
        if body[o].name == "scf.parallel" {
            loops.push(o);
        }
    });
    for l in loops {
        body[l].remove("SCFToGPU_visited");
    }
    Ok(())
}

/// `convert-affine-for-to-gpu`.
#[crate::pass("convert-affine-for-to-gpu")]
pub struct ConvertAffineForToGpu {
    #[opt("gpu-block-dims", default = 1)]
    blocks: u64,
    #[opt("gpu-thread-dims", default = 1)]
    threads: u64,
}

impl ConvertAffineForToGpu {
    /// `checkAffineLoopNestMappable`.
    fn mappable(&self, body: &Body<'_>, root: OpId) -> Result<(), Error> {
        if self.blocks < 1 || self.threads < 1 {
            return Ok(());
        }
        if self.blocks > 3 {
            return Err(Error(String::from("'affine.for' op cannot map to more than 3 block dimensions")));
        }
        if self.threads > 3 {
            return Err(Error(String::from("'affine.for' op cannot map to more than 3 thread dimensions")));
        }
        let limit = body[root].regions[0];
        let mut f = root;
        let n = (self.blocks + self.threads) as usize;
        for i in 0..n {
            let segs = body.segments(f, "operandSegmentSizes").unwrap_or_default();
            let bounds = &body[f].operands[..segs[0] + segs[1]];
            let above = bounds.iter().all(|v| body.value_block(*v).and_then(|b| body[b].parent).is_none_or(|r| !Self::within(body, r, limit)));
            if !above {
                return Err(Error(String::from("'affine.for' op loops with bounds depending on other mapped loops are not supported")));
            }
            if i == n - 1 {
                break;
            }
            let blk = body[body[f].regions[0]].blocks[0];
            if body[blk].ops.len() != 2 {
                return Err(Error(String::from("'affine.for' op expected perfectly nested loops in the body")));
            }
            let nested = body[blk].ops[0];
            if body[nested].name != "affine.for" {
                return Err(Error(format!("'{}' op expected a nested loop", body[nested].name)));
            }
            f = nested;
        }
        Ok(())
    }

    fn within(body: &Body<'_>, mut r: crate::RegionId, of: crate::RegionId) -> bool {
        loop {
            if r == of {
                return true;
            }
            match body[body[r].parent].parent.and_then(|b| body[b].parent) {
                Some(up) => r = up,
                None => return false,
            }
        }
    }

    /// `AffineLoopToGpuConverter`: the bounds of the nest, a launch over them, the innermost
    /// body in it.
    fn convert(&self, rw: &mut Rewriter<'_, '_>, root: OpId) -> Option<()> {
        let n = (self.blocks + self.threads) as usize;
        let (blocks, threads) = (self.blocks as usize, self.threads as usize);
        rw.set_before(root);
        let (mut dims, mut lbs, mut ivs, mut steps) = (Vec::new(), Vec::new(), Vec::new(), Vec::new());
        let mut cur = root;
        for i in 0..n {
            let segs = rw.body.segments(cur, "operandSegmentSizes").unwrap_or_default();
            let ops = rw.body[cur].operands.clone();
            let (lbo, ubo) = (&ops[..segs[0]], &ops[segs[0]..segs[0] + segs[1]]);
            let (lbm, ubm) = (rw.body.affine_map(cur, "lowerBoundMap")?, rw.body.affine_map(cur, "upperBoundMap")?);
            let lb = rw.min_max(&lbm, lbo, true)?;
            let ub = rw.min_max(&ubm, ubo, false)?;
            let mut range = rw.arith2("arith.subi", ub, lb);
            let step_v = rw.body.for_step(cur);
            let step = rw.index_constant(step_v);
            if step_v != 1 {
                range = rw.arith2("arith.ceildivsi", range, step);
            }
            dims.push(range);
            lbs.push(lb);
            let blk = rw.body[rw.body[cur].regions[0]].blocks[0];
            ivs.push(rw.body[blk].args[0]);
            steps.push((step, step_v));
            if i != n - 1 {
                cur = rw.body[blk].ops[0];
            }
        }
        let loc = rw.body[root].loc.clone();
        let one = (blocks < 3 || threads < 3).then(|| rw.index_constant(1));
        let size = |k: usize, have: usize, off: usize| if k < have { Some(dims[off + k]) } else { one };
        let sizes: Vec<ValueId> = (0..3).map(|k| size(k, blocks, 0)).chain((0..3).map(|k| size(k, threads, blocks))).collect::<Option<_>>()?;
        let mut data = OpData::build("gpu.launch").operands(&sizes).with("operandSegmentSizes", Attribute::dense_i32(&[0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0])).with("workgroup_attributions", Attribute::integer(0, Type::int(64)));
        data.loc = loc.clone();
        let launch = rw.create_with(data, &[], |b, o| {
            let r = b.add_region(o);
            b.add_block(r, &vec![(Type::Index, loc.clone()); 12]);
        });
        let inner = rw.body[rw.body[cur].regions[0]].blocks[0];
        let term = *rw.body[inner].ops.last()?;
        let mut t = OpData::build("gpu.terminator");
        t.loc = rw.body[term].loc.clone();
        rw.body.erase(term);
        let t = rw.body.create(t, &[]);
        rw.body.insert(t, inner, None);
        let lblock: BlockId = rw.body[rw.body[launch].regions[0]].blocks[0];
        let count = rw.body[inner].ops.len();
        rw.body.splice(inner, 0..count, lblock, Some(0));
        rw.ip = Some(InsertPoint { block: lblock, before: rw.body[lblock].ops.first().copied() });
        let args = rw.body[lblock].args.clone();
        for (i, iv) in ivs.iter().enumerate() {
            let mut id = if i < blocks { args[i] } else { args[3 + i - blocks] };
            let (step, sv) = steps[i];
            if sv != 1 {
                id = rw.arith2("arith.muli", step, id);
            }
            let repl = rw.arith2("arith.addi", lbs[i], id);
            rw.body.replace_all_uses(*iv, repl);
        }
        rw.body.erase(root);
        Some(())
    }
}

impl crate::Run for ConvertAffineForToGpu {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let Some(&region) = body[op].regions.first() else { return Ok(()) };
        let loops: Vec<OpId> = body[region].blocks.iter().flat_map(|b| body[*b].ops.clone()).filter(|o| body[*o].name == "affine.for").collect();
        for f in loops {
            self.mappable(body, f)?;
            let mut quiet = crate::Quiet;
            let mut rw = Rewriter::new(body, &mut quiet);
            self.convert(&mut rw, f).ok_or_else(|| Error(String::from("convert-affine-for-to-gpu failed")))?;
        }
        Ok(())
    }
}
