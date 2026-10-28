//! `convert-linalg-to-{loops,affine-loops,parallel-loops}`, as `Linalg/Transforms/Loops.cpp`: a
//! structured op on buffers becomes a loop nest over its iteration domain, with the payload
//! inlined between loads of its operands and stores of what it yields; then the greedy driver
//! runs with the dim / apply canonicalizations and `FoldAffineOp`.

use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{Attribute, Dim, Type};

use crate::canon::MemrefOfr as Ofr;
use crate::pass;
use crate::{AffineExpr, AffineMap, Body, Def, GreedyConfig, Mapping, OpData, OpId, Pattern, Rewriter, ValueId};

/// The loops a structured op becomes.
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum LinalgLoops {
    /// `scf.for`, one per loop.
    Scf,
    /// `affine.for`, one per loop, over `affine.load` / `affine.store`.
    Affine,
    /// `scf.parallel` for each run of parallel loops, `scf.for` for each reduction.
    Parallel,
}

#[pass("convert-linalg-to-loops", on = "func.func")]
pub fn convert_linalg_to_loops<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), mlirformat::Error> {
    LinalgLoops::Scf.lower(body, op);
    Ok(())
}

#[pass("convert-linalg-to-affine-loops", on = "func.func")]
pub fn convert_linalg_to_affine_loops<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), mlirformat::Error> {
    LinalgLoops::Affine.lower(body, op);
    Ok(())
}

#[pass("convert-linalg-to-parallel-loops", on = "func.func")]
pub fn convert_linalg_to_parallel_loops<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), mlirformat::Error> {
    LinalgLoops::Parallel.lower(body, op);
    Ok(())
}

impl LinalgLoops {
    /// `lowerLinalgToLoopsImpl`.
    fn lower(self, body: &mut Body<'_>, op: OpId) {
        // `{memref,tensor}::DimOp` and `AffineApplyOp::getCanonicalizationPatterns`.
        let mut set = crate::canon::patterns();
        set.retain(|p| matches!(p.root(), Some("memref.dim" | "tensor.dim" | "affine.apply")));
        set.add(LinalgRewrite(self));
        set.add(FoldAffineOp);
        for r in body[op].regions.clone() {
            body.apply_greedily(r, &set, &GreedyConfig::default());
        }
    }
}

/// `LinalgRewritePattern`: any structured op on buffers.
struct LinalgRewrite(LinalgLoops);

impl Pattern for LinalgRewrite {
    fn name(&self) -> &str {
        "LinalgRewritePattern"
    }

    fn root(&self) -> Option<&str> {
        None
    }

    fn rewrite(&self, rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        if !rw.body[op].name.starts_with("linalg.") || !rw.body.pure_buffer(op) {
            return false;
        }
        let Some(maps) = rw.body.indexing_maps(op) else { return false };
        rw.set_before(op);
        let Some(ranges) = rw.loop_ranges(op, &maps) else { return false };
        let bounds: Vec<[ValueId; 3]> = ranges.iter().map(|r| [rw.ofr_value(&r[0]), rw.ofr_value(&r[1]), rw.ofr_value(&r[2])]).collect();
        let ivs = match self.0 {
            LinalgLoops::Scf => rw.scf_nest(&bounds),
            LinalgLoops::Affine => rw.affine_nest(&bounds),
            LinalgLoops::Parallel => {
                let reductions = rw.body.iterator_reductions(op, &maps);
                let mut ivs = Vec::new();
                rw.parallel_nest(&bounds, &reductions, &mut ivs);
                ivs
            }
        };
        rw.scalar_implementation(op, &maps, &ivs, self.0 == LinalgLoops::Affine);
        rw.index_to_ivs(&ivs);
        rw.erase_op(op);
        true
    }
}

/// `FoldAffineOp`: an `affine.apply` of one result and at most one input that is a constant or
/// the input itself.
struct FoldAffineOp;

impl Pattern for FoldAffineOp {
    fn name(&self) -> &str {
        "FoldAffineOp"
    }

    fn root(&self) -> Option<&str> {
        Some("affine.apply")
    }

    fn benefit(&self) -> u16 {
        0
    }

    fn rewrite(&self, rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let Some(map) = rw.body.affine_map(op, "map") else { return false };
        let ([e], inputs) = (&map.results[..], map.dims + map.syms) else { return false };
        match (e, inputs) {
            (&AffineExpr::Const(c), 0) => {
                rw.replace_with(op, OpData::build("arith.constant").with("value", Attribute::index(c)), &[Type::Index]);
                true
            }
            (AffineExpr::Dim(_) | AffineExpr::Sym(_), 1) => {
                let v = rw.body[op].operands[0];
                rw.replace_op(op, &[v]);
                true
            }
            _ => false,
        }
    }
}

impl Body<'_> {
    /// `getIteratorTypesArray`, `true` for a reduction: `iterator_types` when the op has it, the
    /// OpDSL table, else a loop is parallel exactly when an init's map uses it (`matmul`,
    /// `contract`, `transpose`, `broadcast`, `map`, `reduce`).
    fn iterator_reductions(&self, op: OpId, maps: &[AffineMap]) -> Vec<bool> {
        let n = maps.first().map_or(0, |m| m.dims);
        if let Some(Attribute::Array(its)) = self[op].get("iterator_types") {
            return its.iter().map(|a| alloc::format!("{a}").contains("reduction")).collect();
        }
        if let Some(dsl) = crate::OpDsl::of(&self[op].name).filter(|d| !d.rank_polymorphic()) {
            return dsl.reductions.to_vec();
        }
        let inits = self.dps_inits(op).unwrap_or(0..0);
        (0..n).map(|d| !maps[inits.clone()].iter().any(|m| m.uses_dim(d))).collect()
    }
}

/// `Range` of a loop: offset, size, stride.
type Range = [Ofr; 3];

impl<'a> Rewriter<'_, 'a> {
    /// `createLoopRanges`: each loop `[0, size, 1)`, its size the first operand dim its
    /// `getLoopsToShapesMap` result names (`createFlatListOfOperandDims`).
    fn loop_ranges(&mut self, op: OpId, maps: &[AffineMap]) -> Option<Vec<Range>> {
        let mut sizes = Vec::new();
        for v in self.body[op].operands.clone() {
            let ty = self.body[v].ty.clone();
            for (i, d) in ty.dims().unwrap_or_default().into_iter().enumerate() {
                sizes.push(match Dim::from(d) {
                    Dim::Static(n) => Ofr::C(n),
                    _ => Ofr::V(self.dim(v, i)),
                });
            }
        }
        let results = maps.iter().flat_map(|m| m.results.iter());
        let mut ranges: Vec<Option<Range>> = vec![None; maps.first()?.dims as usize];
        for (e, size) in results.zip(sizes) {
            if let AffineExpr::Dim(d) = e
                && ranges[*d as usize].is_none()
            {
                ranges[*d as usize] = Some([Ofr::C(0), size, Ofr::C(1)]);
            }
        }
        ranges.into_iter().collect()
    }

    /// `createOrFoldDimOp` on a memref: `memref.dim` of a new index constant.
    fn dim(&mut self, v: ValueId, i: usize) -> ValueId {
        let c = self.index(i64::try_from(i).unwrap_or_default());
        self.create_or_fold(OpData::build("memref.dim").operands(&[v, c]), &[Type::Index])[0]
    }

    /// `arith::ConstantIndexOp::create`.
    fn index(&mut self, v: i64) -> ValueId {
        let c = self.create(OpData::build("arith.constant").with("value", Attribute::index(v)), &[Type::Index]);
        self.body[c].results[0]
    }

    /// `getValueOrCreateConstantIndexOp`.
    fn ofr_value(&mut self, o: &Ofr) -> ValueId {
        match o {
            Ofr::C(c) => self.index(*c),
            Ofr::V(v) => *v,
        }
    }

    /// `GenerateLoopNest<scf::ForOp>` (`scf::buildLoopNest`, the bounds `unpackRanges` made):
    /// nested `scf.for`s, the insertion point left at the start of the innermost body; their
    /// induction variables.
    fn scf_nest(&mut self, bounds: &[[ValueId; 3]]) -> Vec<ValueId> {
        let mut ivs = Vec::new();
        for &[lb, ub, step] in bounds {
            let f = self.with_body(OpData::build("scf.for").operands(&[lb, ub, step]), &[], &[vec![Type::Index]], &mut |rw, _, a| {
                rw.create(OpData::build("scf.yield"), &[]);
                ivs.push(a[0]);
            });
            let blk = self.body.top_block(f);
            self.set_start(blk);
        }
        ivs
    }

    /// `GenerateLoopNest<AffineForOp>` (`affine::buildAffineLoopNest`): nested `affine.for`s,
    /// constant bounds folded into the maps (`buildAffineLoopFromConstants`), others passed as
    /// operands of `(d0) -> (d0)`; the steps must be constants.
    fn affine_nest(&mut self, bounds: &[[ValueId; 3]]) -> Vec<ValueId> {
        let mut ivs = Vec::new();
        for &[lb, ub, step] in bounds {
            let constant = |rw: &Self, v: ValueId| rw.body.int_constant(v).and_then(|c| i64::try_from(c).ok());
            let step = constant(self, step).unwrap_or(1);
            let data = match (constant(self, lb), constant(self, ub)) {
                (Some(l), Some(u)) => OpData::build("affine.for").segments(&[0, 0, 0]).with("lowerBoundMap", Attribute::from(&AffineMap::constant(l))).with("upperBoundMap", Attribute::from(&AffineMap::constant(u))),
                _ => OpData::build("affine.for").operands(&[lb, ub]).segments(&[1, 1, 0]).with("lowerBoundMap", Attribute::from(&AffineMap::identity(1))).with("upperBoundMap", Attribute::from(&AffineMap::identity(1))),
            };
            let f = self.with_body(data.with("step", Attribute::index(step)), &[], &[vec![Type::Index]], &mut |rw, _, a| {
                rw.create(OpData::build("affine.yield"), &[]);
                ivs.push(a[0]);
            });
            let blk = self.body.top_block(f);
            self.set_start(blk);
        }
        ivs
    }

    /// `GenerateLoopNest<scf::ParallelOp>` (`generateParallelLoopNest`, no distribution): the
    /// leading parallel loops as one `scf.parallel`, a leading reduction as one `scf.for`, then
    /// the rest inside it; the insertion point left where the body goes.
    fn parallel_nest(&mut self, bounds: &[[ValueId; 3]], reductions: &[bool], ivs: &mut Vec<ValueId>) {
        if bounds.is_empty() {
            return;
        }
        let n = reductions.iter().take_while(|r| !**r).count();
        if n == 0 {
            ivs.extend(self.scf_nest(&bounds[..1]));
            return self.parallel_nest(&bounds[1..], &reductions[1..], ivs);
        }
        let mut operands = Vec::new();
        for k in 0..3 {
            operands.extend(bounds[..n].iter().map(|b| b[k]));
        }
        let p = self.with_body(OpData::build("scf.parallel").operands(&operands).segments(&[n, n, n, 0]), &[], &[vec![Type::Index; n]], &mut |rw, _, a| {
            rw.create(OpData::build("scf.reduce"), &[]);
            ivs.extend_from_slice(a);
        });
        let blk = self.body.top_block(p);
        self.set_start(blk);
        self.parallel_nest(&bounds[n..], &reductions[n..], ivs);
    }

    /// `makeCanonicalAffineApplies`: one `affine.apply` per result of `map` over `vals`.
    fn applies(&mut self, map: &AffineMap, vals: &[ValueId]) -> Vec<ValueId> {
        map.results
            .iter()
            .map(|e| {
                let mut m = AffineMap { dims: map.dims, syms: map.syms, results: vec![e.clone()] };
                let mut ops = vals.to_vec();
                self.body.canonicalize_map_or_set(&mut m, &mut ops);
                let a = self.create(OpData::build("affine.apply").operands(&ops).with("map", Attribute::from(&m)), &[Type::Index]);
                self.body[a].results[0]
            })
            .collect()
    }

    /// `emitScalarImplementation`: loads of the inputs (scalars as they are) and the inits, the
    /// payload cloned, a store of each yielded value into its init.
    fn scalar_implementation(&mut self, op: OpId, maps: &[AffineMap], ivs: &[ValueId], affine: bool) {
        let inits = self.body.dps_inits(op).unwrap_or(0..0);
        let operands = self.body[op].operands.clone();
        let mut indexed = Vec::new();
        for (i, v) in operands.iter().enumerate() {
            if !inits.contains(&i) && self.body[*v].ty.dims().is_none() {
                indexed.push(*v);
                continue;
            }
            let at = self.applies(&maps[i], ivs);
            indexed.push(self.load(*v, &at, affine));
        }
        let outs: Vec<(ValueId, Vec<ValueId>)> = inits.map(|i| (operands[i], self.applies(&maps[i], ivs))).collect();
        let block = self.body.top_block(op);
        let mut map = Mapping::default();
        for (a, v) in self.body[block].args.clone().into_iter().zip(indexed) {
            map.map(a, v);
        }
        let ops = self.body[block].ops.clone();
        let Some((yielded, payload)) = ops.split_last() else { return };
        for o in payload {
            self.clone(*o, &mut map);
        }
        for (v, (buffer, at)) in self.body[*yielded].operands.clone().into_iter().zip(outs) {
            let mut operands = vec![map.get(v), buffer];
            operands.extend(at);
            let data = if affine { OpData::build("affine.store").with("map", self.access_map(buffer)) } else { OpData::build("memref.store") };
            self.create(data.operands(&operands), &[]);
        }
    }

    /// `memref.load`, or `affine.load` through the identity map (`AffineLoadOp::build`).
    fn load(&mut self, v: ValueId, at: &[ValueId], affine: bool) -> ValueId {
        let ty = self.body[v].ty.element_type().clone();
        let mut operands = vec![v];
        operands.extend_from_slice(at);
        let data = if affine { OpData::build("affine.load").with("map", self.access_map(v)) } else { OpData::build("memref.load") };
        let l = self.create(data.operands(&operands), &[ty]);
        self.body[l].results[0]
    }

    /// The identity map of `memref`'s rank (`() -> ()` at rank zero).
    fn access_map(&self, memref: ValueId) -> Attribute<'a> {
        let rank = self.body[memref].ty.dims().map_or(0, |d| d.len());
        Attribute::from(&AffineMap::identity(u32::try_from(rank).unwrap_or_default()))
    }

    /// `replaceIndexOpsByInductionVariables`: the `linalg.index` ops directly in the innermost
    /// loop's body become its induction variables.
    fn index_to_ivs(&mut self, ivs: &[ValueId]) {
        let Some(&last) = ivs.last() else { return };
        let Def::Arg(block, _) = self.body[last].def else { return };
        for o in self.body[block].ops.clone() {
            if self.body[o].name == "linalg.index"
                && let Some(d) = self.body[o].get("dim").and_then(|d| d.int().ok()).and_then(|d| usize::try_from(d).ok())
            {
                self.replace_op(o, &[ivs[d]]);
            }
        }
    }
}
