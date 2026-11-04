//! `linalg-fold-unit-extent-dims`, as `Linalg/Transforms/DropUnitDims.cpp`: unit-extent loops of a
//! `linalg.generic` and unit dims of its operands indexed by a constant 0 dropped (operands
//! collapsed, results expanded back), unit dims of a `tensor.pad` likewise; then the
//! fold-unit-extent-dims canonicalizations run greedily.
//!
//! Upstream's two phases: `DropUnitDims` and `DropPadUnitDims` through `walkAndApplyPatterns`
//! ([`Body::walk_and_apply`]), then `MoveInitOperandsToInput`, the rank-reducing slice patterns
//! and the reshape / fill / empty canonicalizations with the greedy driver.

use alloc::collections::{BTreeMap, BTreeSet};
use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{arith, memref, tensor, AffineExpr, AffineMap, Attribute, Dim, Shaped, ShapedKind, Type};

use crate::{MemrefOfr as Ofr, Reshape};
use crate::{ops, Body, Def, Mapping, MemrefLayout, OpData, OpId, PatternSet, Rewriter, Trait, TypedOp, ValueId};

/// `ControlDropUnitDims::RankReductionStrategy`.
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum Strategy {
    ReassociativeReshape,
    ExtractInsertSlice,
}

/// The rewrite patterns of this module.
pub struct Rules;

#[crate::patterns]
impl Rules {
    /// `DropUnitDims` (reassociative reshapes).
    #[rewrite("linalg.generic")]
    fn drop_unit_dims(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool { Unit::generic(rw, op, Strategy::ReassociativeReshape) }

    /// `DropUnitDims` (rank-reducing slices).
    #[rewrite("linalg.generic")]
    fn drop_unit_dims_with_slices(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool { Unit::generic(rw, op, Strategy::ExtractInsertSlice) }

    /// `DropPadUnitDims` (reassociative reshapes).
    #[rewrite("tensor.pad")]
    fn drop_pad_unit_dims(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool { Unit::pad(rw, op, Strategy::ReassociativeReshape) }

    /// `DropPadUnitDims` (rank-reducing slices).
    #[rewrite("tensor.pad")]
    fn drop_pad_unit_dims_with_slices(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool { Unit::pad(rw, op, Strategy::ExtractInsertSlice) }

    /// `MoveInitOperandsToInput`: an all-parallel generic reading an init reads it as an input,
    /// the init a fresh `tensor.empty`.
    #[rewrite("linalg.generic")]
    fn move_init_operands_to_input(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool { Unit::move_init_to_input(rw, op) }

    /// `RankReducedExtractSliceOp`: an extract_slice with unit dims in its result becomes a
    /// rank-reduced one expanded back.
    #[rewrite("tensor.extract_slice")]
    fn rank_reduced_extract_slice_op(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool { Unit::rank_reduced_extract(rw, op) }

    /// `RankReducedInsertSliceOp<tensor::InsertSliceOp>`.
    #[rewrite("tensor.insert_slice")]
    fn rank_reduced_insert_slice_op(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool { Unit::rank_reduced_insert(rw, op, false) }

    /// `RankReducedInsertSliceOp<tensor::ParallelInsertSliceOp>`.
    #[rewrite("tensor.parallel_insert_slice")]
    fn rank_reduced_parallel_insert_slice_op(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool { Unit::rank_reduced_insert(rw, op, true) }

    /// `FoldEmptyTensorWithReshapeOp<tensor::ExpandShapeOp>`.
    #[rewrite("tensor.expand_shape")]
    fn fold_empty_tensor_with_expand_shape_op(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool { Unit::empty_of_reshape(rw, op) }

    /// `FoldEmptyTensorWithReshapeOp<tensor::CollapseShapeOp>`.
    #[rewrite("tensor.collapse_shape")]
    fn fold_empty_tensor_with_collapse_shape_op(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool { Unit::empty_of_reshape(rw, op) }

    /// `FoldEmptyTensorWithExtractSliceOp`.
    #[rewrite("tensor.extract_slice")]
    fn fold_empty_tensor_with_extract_slice_op(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
        if rw.body.def_named(rw.body[op].operands[0], "tensor.empty").is_none() {
            return false;
        }
        let sizes: Vec<ValueId> = rw.body.slice_lists(op)[1].iter().filter_map(Unit::value).collect();
        let rt = rw.body[rw.body[op].results[0]].ty.clone();
        rw.set_before(op);
        let e = Unit::empty(rw, &sizes, rt);
        rw.replace_op(op, &[e]);
        true
    }
}

/// `UnitExtentReplacementInfo`.
struct Info {
    map: AffineMap,
    reassoc: Vec<Vec<i64>>,
    shape: Vec<i64>,
}

/// The index arithmetic `#[ops]` builds (`inferExpandShapeOutputShape`), folded as created.
struct Ix<'w, 'r, 'a> {
    rw: &'w mut Rewriter<'r, 'a>,
}

impl Ix<'_, '_, '_> {
    fn cst(&mut self, v: i64) -> ValueId {
        let (d, t) = arith::Constant::new(Attribute::index(v), Type::Index).split();
        self.rw.create_or_fold(d, &t)[0]
    }

    fn div(&mut self, a: ValueId, b: ValueId) -> ValueId {
        self.rw.create_or_fold(OpData::build("arith.divsi").operands(&[a, b]), &[Type::Index])[0]
    }
}

/// The helpers of the patterns above.
impl Strategy {
    /// `populateFoldUnitExtentDimsPatterns`.
    pub fn patterns(self) -> PatternSet {
        let s = self;
        let mut set = PatternSet::default();
        match s {
            Strategy::ReassociativeReshape => set.add(DropUnitDims).add(DropPadUnitDims),
            Strategy::ExtractInsertSlice => set.add(DropUnitDimsWithSlices).add(DropPadUnitDimsWithSlices),
        };
        set
    }

    /// `populateMoveInitOperandsToInputPattern` + `populateFoldUnitExtentDimsCanonicalizationPatterns`.
    pub fn canonicalizations(self) -> PatternSet {
        let s = self;
        let mut names = vec![
            "FoldConcatsOfFill", "FoldFillWithCopy", "FoldFillWithTensorExtract", "FoldFillWithPack", "FoldFillWithPad", "FoldFillWithCollapse", "FoldFillWithExpand", "FoldInsertPadIntoFill", "FoldFillWithTranspose",
            "FoldEmptyTensorWithCastOp", "FoldEmptyTensorWithDimOp", "ReplaceEmptyTensorStaticShapeDims",
        ];
        if s == Strategy::ReassociativeReshape {
            names.extend(["ComposeCollapseOfCollapse", "ComposeCollapseOfExpandOp", "CollapseWithConstant", "CollapseWithSplat", "CollapseWithFromElements", "FoldCollapseOfCastOp", "ComposeExpandOfExpand", "ComposeExpandOfCollapseOp", "ConvertToStaticExpandShape", "ExpandWithConstant", "ExpandWithSplat", "ExpandWithFromElements"]);
        }
        let mut set = crate::canonicalization_patterns();
        set.retain(|p| names.contains(&p.name()));
        set.add(MoveInitOperandsToInput);
        if s == Strategy::ReassociativeReshape {
            set.add(RankReducedExtractSliceOp).add(RankReducedInsertSliceOp).add(RankReducedParallelInsertSliceOp);
        }
        set.add(FoldEmptyTensorWithExpandShapeOp).add(FoldEmptyTensorWithCollapseShapeOp).add(FoldEmptyTensorWithExtractSliceOp);
        // `memref::populateResolveRankedShapedTypeResultDimsPatterns`.
        crate::ResolveDims::patterns(&mut set);
        set
    }
}

struct Unit;

impl Unit {
    fn value(o: &Ofr) -> Option<ValueId> {
        if let Ofr::V(v) = o { Some(*v) } else { None }
    }

    fn statics(l: &[Ofr]) -> Vec<i64> {
        l.iter().map(|o| if let Ofr::C(c) = o { *c } else { Dim::DYNAMIC }).collect()
    }

    fn maps(b: &Body<'_>, op: OpId) -> Vec<AffineMap> {
        match b[op].get("indexing_maps") {
            Some(Attribute::Array(xs)) => xs.iter().filter_map(|a| match a {
                Attribute::Builtin { name, body, .. } if name == "affine_map" => AffineMap::parse(body),
                _ => None,
            }).collect(),
            _ => Vec::new(),
        }
    }

    fn iterators<'a>(b: &Body<'a>, op: OpId) -> Vec<Attribute<'a>> {
        match b[op].get("iterator_types") {
            Some(Attribute::Array(xs)) => xs.clone(),
            _ => Vec::new(),
        }
    }

    fn ninputs(b: &Body<'_>, op: OpId) -> usize {
        b.segments(op, "operandSegmentSizes").map_or(b[op].operands.len().saturating_sub(1), |s| s[0])
    }

    /// `inversePermutation(concatAffineMaps(maps))`, as the result position of each loop.
    fn inverse(maps: &[AffineMap]) -> Option<Vec<usize>> {
        let n = maps.first().map_or(0, |m| m.dims) as usize;
        let mut seen = vec![None; n];
        for (i, e) in maps.iter().flat_map(|m| m.results.iter()).enumerate() {
            if let AffineExpr::Dim(d) = e
                && seen[*d as usize].is_none()
            {
                seen[*d as usize] = Some(i);
            }
        }
        seen.into_iter().collect()
    }

    /// `getStaticOperandShape`.
    fn shape(b: &Body<'_>, v: ValueId) -> Vec<i64> {
        if matches!(b[v].ty, Type::Shaped(_)) { b[v].ty.dims().unwrap_or_default() } else { Vec::new() }
    }

    /// `dropUnitExtentFromOperandMetadata`.
    fn info(m: &AffineMap, shape: &[i64], old_to_new: &BTreeMap<usize, usize>, repl: &[AffineExpr]) -> Info {
        let exprs = &m.results;
        let n = old_to_new.len() as u32;
        let unit = |d: usize| match &exprs[d] {
            AffineExpr::Dim(p) => !old_to_new.contains_key(&(*p as usize)) && shape[d] == 1,
            e => shape[d] == 1 && e.replace(repl, &[]).simplify(n, m.syms).as_const() == Some(0),
        };
        let mut info = Info { map: AffineMap { dims: n, syms: m.syms, results: Vec::new() }, reassoc: Vec::new(), shape: Vec::new() };
        let mut group = Vec::new();
        let mut d = 0;
        while d < shape.len() && unit(d) {
            group.push(d as i64);
            d += 1;
        }
        while d < shape.len() {
            group.push(d as i64);
            info.map.results.push(exprs[d].replace(repl, &[]).simplify(n, m.syms));
            info.shape.push(shape[d]);
            d += 1;
            while d < shape.len() && unit(d) {
                group.push(d as i64);
                d += 1;
            }
            info.reassoc.push(core::mem::take(&mut group));
        }
        info
    }

    /// `tensor::getMixedSizes` / `memref::getMixedSizes`: dynamic sizes by a folded `dim`.
    fn mixed_sizes(rw: &mut Rewriter<'_, '_>, v: ValueId) -> Vec<Ofr> {
        let dims = rw.body[v].ty.dims().unwrap_or_default();
        let is_memref = matches!(&rw.body[v].ty, Type::Shaped(s) if s.kind == ShapedKind::MemRef);
        dims.iter().enumerate().map(|(i, d)| {
            if *d != Dim::DYNAMIC {
                return Ofr::C(*d);
            }
            let k = Ix { rw }.cst(i as i64);
            let source_ty = rw.body[v].ty.clone();
            let (data, types) = if is_memref {
                memref::DimOp::new(v.into(), k.into(), source_ty, Type::Index, Type::Index).split()
            } else {
                tensor::DimOp::new(v.into(), k.into(), source_ty, Type::Index, Type::Index).split()
            };
            let r = rw.create_or_fold(data, &types)[0];
            rw.body.ofr_int(Ofr::V(r)).map_or(Ofr::V(r), Ofr::C)
        }).collect()
    }

    /// `tensor.empty` of type `ty` with `dynamic` sizes.
    fn empty<'a>(rw: &mut Rewriter<'_, 'a>, dynamic: &[ValueId], ty: Type<'a>) -> ValueId {
        let o = rw.emit(&tensor::EmptyOp::new(dynamic.iter().map(|v| (*v).into()).collect(), Type::Index, ty));
        rw.body[o].results[0]
    }

    /// `ControlDropUnitDims::collapseValue`.
    fn collapse(rw: &mut Rewriter<'_, '_>, v: ValueId, target: &[i64], r: &[Vec<i64>], s: Strategy) -> Option<ValueId> {
        let Type::Shaped(sh) = rw.body[v].ty.clone() else { return None };
        let reassociation = Reshape::attr(&r.to_vec());
        let src_ty = rw.body[v].ty.clone();
        let o = match (sh.kind, s) {
            (ShapedKind::MemRef, _) if !sh.identity_layout() => return None,
            (ShapedKind::MemRef, Strategy::ExtractInsertSlice) => return Some(Self::rank_reduce(rw, v, target, "memref.subview")),
            (ShapedKind::MemRef, Strategy::ReassociativeReshape) => {
                let result = Type::Shaped(Shaped { kind: ShapedKind::MemRef, shape: Some(target.iter().map(|d| Dim::from(*d)).collect()), elem: sh.elem.clone(), extras: sh.extras.iter().filter(|a| !a.is_layout()).cloned().collect() });
                rw.emit(&memref::CollapseShapeOp::new(v.into(), reassociation, src_ty, result))
            }
            (ShapedKind::Tensor, _) if sh.extras.iter().any(|a| !a.is_layout()) => return None,
            (ShapedKind::Tensor, Strategy::ExtractInsertSlice) => return Some(Self::rank_reduce(rw, v, target, "tensor.extract_slice")),
            (ShapedKind::Tensor, Strategy::ReassociativeReshape) => rw.emit(&tensor::CollapseShapeOp::new(v.into(), reassociation, src_ty, Type::tensor(target, (*sh.elem).clone()))),
            _ => return None,
        };
        Some(rw.body[o].results[0])
    }

    /// `SubViewOp::rankReduceIfNeeded` / `ExtractSliceOp::rankReduceIfNeeded`.
    fn rank_reduce(rw: &mut Rewriter<'_, '_>, v: ValueId, target: &[i64], name: &str) -> ValueId {
        let shape = rw.body[v].ty.dims().unwrap_or_default();
        if shape == target {
            return v;
        }
        let rank = shape.len();
        let sizes = Self::mixed_sizes(rw, v);
        let lists = [vec![Ofr::C(0); rank], sizes.clone(), vec![Ofr::C(1); rank]];
        let ty = match &rw.body[v].ty {
            Type::Shaped(sh) if sh.kind == ShapedKind::MemRef => Ofr::subview_type(sh, &lists[0], &lists[1], &lists[2], &Ofr::dropped(&sizes, target)).expect("a strided memref"),
            t => Type::tensor(target, t.element_type().clone()),
        };
        let o = rw.create(OpData::sliced(name, &[v], &lists), &[ty]);
        rw.body[o].results[0]
    }

    /// One dynamic size of an expanded group: the source size over the group's static product.
    #[ops(ix)]
    fn group_size(ix: &mut Ix<'_, '_, '_>, size: ValueId, product: i64) -> ValueId {
        size / ix.cst(product)
    }

    /// `inferExpandShapeOutputShape` from the source's mixed sizes.
    fn expand_output_shape(rw: &mut Rewriter<'_, '_>, src: ValueId, out: &[i64], r: &[Vec<i64>]) -> Vec<Ofr> {
        if rw.body[src].ty.dims().unwrap_or_default().is_empty() {
            return out.iter().map(|_| Ofr::C(1)).collect();
        }
        if !out.contains(&Dim::DYNAMIC) {
            return out.iter().map(|d| Ofr::C(*d)).collect();
        }
        let input = Self::mixed_sizes(rw, src);
        let mut shape: Vec<Ofr> = out.iter().map(|d| Ofr::C(*d)).collect();
        for (i, g) in r.iter().enumerate() {
            let Some(&dynamic) = g.iter().find(|d| out[**d as usize] == Dim::DYNAMIC) else { continue };
            let Ofr::V(size) = input[i] else { continue };
            let product: i64 = g.iter().map(|d| out[*d as usize]).filter(|d| *d != Dim::DYNAMIC).product();
            let q = Self::group_size(&mut Ix { rw }, size, product);
            shape[dynamic as usize] = rw.body.ofr_int(Ofr::V(q)).map_or(Ofr::V(q), Ofr::C);
        }
        shape
    }

    /// A `tensor.expand_shape` of `src` to `ty` (`ExpandShapeOp::build` inferring the output shape).
    fn expand_to<'a>(rw: &mut Rewriter<'_, 'a>, src: ValueId, r: &[Vec<i64>], ty: Type<'a>) -> ValueId {
        let shape = Self::expand_output_shape(rw, src, &ty.dims().unwrap_or_default(), r);
        let o = rw.create(Rewriter::expand_data("tensor", src, &r.to_vec(), &shape), &[ty]);
        rw.body[o].results[0]
    }

    /// `ControlDropUnitDims::expandValue`.
    fn expand(rw: &mut Rewriter<'_, '_>, v: ValueId, orig_dest: ValueId, r: &[Vec<i64>], s: Strategy) -> Option<ValueId> {
        let ot = rw.body[orig_dest].ty.clone();
        let Type::Shaped(sh) = &ot else { return None };
        if sh.extras.iter().any(|a| !a.is_layout()) {
            return None;
        }
        if s == Strategy::ExtractInsertSlice {
            let rank = ot.dims().unwrap_or_default().len();
            let sizes = Self::mixed_sizes(rw, orig_dest);
            let lists = [vec![Ofr::C(0); rank], sizes, vec![Ofr::C(1); rank]];
            return Some(rw.create_or_fold(OpData::sliced("tensor.insert_slice", &[v, orig_dest], &lists), &[ot])[0]);
        }
        Some(Self::expand_to(rw, v, r, ot))
    }

    /// `dropUnitDims` of a `linalg.generic`.
    fn generic(rw: &mut Rewriter<'_, '_>, op: OpId, s: Strategy) -> bool {
        let b = &*rw.body;
        let maps = Self::maps(b, op);
        if maps.is_empty() {
            return false;
        }
        let Some(inv) = Self::inverse(&maps) else { return false };
        let operands = b[op].operands.to_vec();
        let ninputs = Self::ninputs(b, op);
        let shapes: Vec<Vec<i64>> = operands.iter().map(|v| Self::shape(b, *v)).collect();
        let all: Vec<i64> = shapes.iter().flatten().copied().collect();
        let nloops = maps[0].dims as usize;
        let unit: BTreeSet<usize> = inv.iter().enumerate().filter(|(_, pos)| all[**pos] == 1).map(|(d, _)| d).collect();
        let mut old_to_new = BTreeMap::new();
        let mut repl = Vec::new();
        for d in 0..nloops {
            if unit.contains(&d) {
                repl.push(AffineExpr::Const(0));
            } else {
                repl.push(AffineExpr::Dim(old_to_new.len() as u32));
                old_to_new.insert(d, old_to_new.len());
            }
        }
        let infos: Vec<Info> = maps.iter().zip(&shapes).map(|(m, sh)| Self::info(m, sh, &old_to_new, &repl)).collect();
        let new_maps: Vec<AffineMap> = infos.iter().map(|i| i.map.clone()).collect();
        if new_maps == maps || Self::inverse(&new_maps).is_none() {
            return false;
        }
        let collapsed: Vec<bool> = infos.iter().zip(&maps).map(|(i, m)| i.map.results.len() != m.results.len()).collect();
        rw.set_before(op);
        let mut news = Vec::new();
        for (k, v) in operands.iter().enumerate() {
            if !collapsed[k] {
                news.push(*v);
                continue;
            }
            match Self::collapse(rw, *v, &infos[k].shape, &infos[k].reassoc, s) {
                Some(c) => news.push(c),
                None => return false,
            }
        }
        let iters: Vec<Attribute<'_>> = Self::iterators(rw.body, op).into_iter().enumerate().filter(|(i, _)| !unit.contains(i)).map(|(_, a)| a).collect();
        let nres = rw.body[op].results.len();
        let rts: Vec<Type<'_>> = news[ninputs..ninputs + nres].iter().map(|v| rw.body[*v].ty.clone()).collect();
        let d = OpData::build("linalg.generic")
            .operands(&news)
            .with("indexing_maps", Attribute::Array(new_maps.iter().map(Attribute::from).collect()))
            .with("iterator_types", Attribute::Array(iters))
            .segments(&[ninputs, news.len() - ninputs]);
        let old_region = rw.body[op].regions[0];
        let g = rw.create_with(d, &rts, |b, o| {
            let r = b.add_region(o);
            b.clone_region_into(old_region, r, None, &mut Mapping::default());
        });
        Self::replace_index_ops(rw, g, &unit);
        rw.set_before(op);
        let mut results = Vec::new();
        for (i, r) in rw.body[g].results.to_vec().into_iter().enumerate() {
            let k = ninputs + i;
            if !collapsed[k] {
                results.push(r);
                continue;
            }
            match Self::expand(rw, r, operands[k], &infos[k].reassoc, s) {
                Some(x) => results.push(x),
                None => return false,
            }
        }
        rw.replace_op(op, &results);
        true
    }

    /// `replaceUnitDimIndexOps`.
    fn replace_index_ops(rw: &mut Rewriter<'_, '_>, g: OpId, unit: &BTreeSet<usize>) {
        let blk = rw.body[rw.body[g].regions[0]].blocks[0];
        for o in rw.body[blk].ops.clone() {
            if rw.body[o].name != "linalg.index" {
                continue;
            }
            let dim = rw.body[o].get("dim").and_then(|a| a.int().ok()).unwrap_or(0) as usize;
            rw.set_before(o);
            rw.loc = rw.body[o].loc.clone();
            let n = if unit.contains(&dim) {
                rw.emit(&arith::Constant::new(Attribute::index(0), Type::Index))
            } else {
                let dropped = unit.iter().filter(|u| **u < dim).count();
                if dropped == 0 {
                    continue;
                }
                rw.create(OpData::build("linalg.index").with("dim", Attribute::of_int((dim - dropped) as i128, Type::int(64))), &[Type::Index])
            };
            let v = rw.body[n].results[0];
            rw.replace_op(o, &[v]);
        }
    }

    /// `PadOp::getConstantPaddingValue`.
    fn padding_value(b: &Body<'_>, pad: OpId) -> Option<ValueId> {
        let blk = *b[*b[pad].regions.first()?].blocks.first()?;
        let y = *b[blk].ops.last()?;
        let v = *b[y].operands.first()?;
        match b.def_op(v) {
            Some(d) if b[d].parent == Some(blk) => b.has(d, Trait::ConstantLike).then_some(v),
            _ if b[blk].args.contains(&v) => None,
            _ => Some(v),
        }
    }

    /// `DropPadUnitDims`.
    fn pad(rw: &mut Rewriter<'_, '_>, op: OpId, s: Strategy) -> bool {
        let b = &*rw.body;
        let (src, res) = (b[op].operands[0], b[op].results[0]);
        let Type::Shaped(st) = &b[src].ty else { return false };
        if st.extras.iter().any(|a| !a.is_layout()) {
            return false;
        }
        let Some(value) = Self::padding_value(b, op) else { return false };
        let (ss, rs) = (b[src].ty.dims().unwrap_or_default(), b[res].ty.dims().unwrap_or_default());
        let [low, high] = b.pad_lists(op);
        let zero = |o: &Ofr| b.ofr_int(*o) == Some(0);
        let mut unit = BTreeSet::new();
        let (mut ns, mut nr, mut nl, mut nh) = (Vec::new(), Vec::new(), Vec::new(), Vec::new());
        for d in 0..ss.len() {
            if ss[d] == 1 && zero(&low[d]) && zero(&high[d]) {
                unit.insert(d);
            } else {
                ns.push(ss[d]);
                nr.push(rs[d]);
                nl.push(low[d]);
                nh.push(high[d]);
            }
        }
        if unit.is_empty() {
            return false;
        }
        let mut reassoc: Vec<Vec<i64>> = Vec::new();
        let mut group = Vec::new();
        let mut d = 0;
        while d < ss.len() && unit.contains(&d) {
            group.push(d as i64);
            d += 1;
        }
        while d < ss.len() {
            group.push(d as i64);
            d += 1;
            while d < ss.len() && unit.contains(&d) {
                group.push(d as i64);
                d += 1;
            }
            reassoc.push(core::mem::take(&mut group));
        }
        let elem = b[res].ty.element_type().clone();
        let nofold = b[op].get("nofold").is_some();
        rw.set_before(op);
        let Some(c) = Self::collapse(rw, src, &ns, &reassoc, s) else { return false };
        let (dl, dh): (Vec<ValueId>, Vec<ValueId>) = (nl.iter().filter_map(Self::value).collect(), nh.iter().filter_map(Self::value).collect());
        let mut ops = vec![c];
        ops.extend(&dl);
        ops.extend(&dh);
        let mut d = OpData::build("tensor.pad").operands(&ops).segments(&[1, dl.len(), dh.len()]).with("static_low", Attribute::dense_i64(&Self::statics(&nl))).with("static_high", Attribute::dense_i64(&Self::statics(&nh)));
        if nofold {
            d.set("nofold", Attribute::Unit);
        }
        let rank = ns.len();
        let np = rw.create_with(d, &[Type::tensor(&nr, elem.clone())], |b, o| {
            let r = b.add_region(o);
            let blk = b.add_block(r, &vec![(Type::Index, None); rank]);
            let y = b.create(OpData::build("tensor.yield").operands(&[value]), &[]);
            b.insert(y, blk, None);
        });
        let npv = rw.body[np].results[0];
        let mut dest = res;
        if s == Strategy::ExtractInsertSlice {
            let mut sizes = Vec::new();
            let mut n_unit = 0;
            for d in 0..ss.len() {
                if unit.contains(&d) {
                    sizes.push(Ofr::C(1));
                    n_unit += 1;
                } else {
                    sizes.push(Self::mixed_sizes(rw, npv)[d - n_unit]);
                }
            }
            let dynamic: Vec<ValueId> = sizes.iter().filter_map(Self::value).collect();
            dest = Self::empty(rw, &dynamic, Type::tensor(&Self::statics(&sizes), elem));
        }
        let Some(x) = Self::expand(rw, npv, dest, &reassoc, s) else { return false };
        rw.replace_op(op, &[x]);
        true
    }

    /// `MoveInitOperandsToInput`.
    fn move_init_to_input(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let b = &*rw.body;
        let operands = b[op].operands.to_vec();
        if operands.iter().any(|v| matches!(&b[*v].ty, Type::Shaped(s) if s.kind == ShapedKind::MemRef)) {
            return false;
        }
        let iters = Self::iterators(b, op);
        if !iters.iter().all(|a| *a == Attribute::dialect("linalg.iterator_type", "<parallel>")) {
            return false;
        }
        let ninputs = Self::ninputs(b, op);
        let blk = b[b[op].regions[0]].blocks[0];
        let args = b[blk].args.to_vec();
        let candidates: Vec<usize> = (ninputs..operands.len()).filter(|k| !b[args[*k]].uses.is_empty()).collect();
        if candidates.is_empty() {
            return false;
        }
        let maps = Self::maps(b, op);
        let mut new_maps: Vec<AffineMap> = maps[..ninputs].to_vec();
        let mut ins: Vec<ValueId> = operands[..ninputs].to_vec();
        for k in &candidates {
            ins.push(operands[*k]);
            new_maps.push(maps[*k].clone());
        }
        new_maps.extend(maps[ninputs..].iter().cloned());
        let mut outs: Vec<ValueId> = operands[ninputs..].to_vec();
        for k in &candidates {
            let v = operands[*k];
            match rw.body[v].def {
                Def::Result(d, _) => rw.set_after(d),
                Def::Arg(vb, _) => rw.set_start(vb),
            }
            let sizes = Self::mixed_sizes(rw, v);
            let dynamic: Vec<ValueId> = sizes.iter().filter_map(Self::value).collect();
            let ty = Type::tensor(&Self::statics(&sizes), rw.body[v].ty.element_type().clone());
            outs[*k - ninputs] = Self::empty(rw, &dynamic, ty);
        }
        rw.set_before(op);
        let mut all = ins.clone();
        all.extend(&outs);
        let mut d = OpData::build("linalg.generic")
            .operands(&all)
            .with("indexing_maps", Attribute::Array(new_maps.iter().map(Attribute::from).collect()))
            .with("iterator_types", Attribute::Array(iters))
            .segments(&[ins.len(), outs.len()]);
        // `getPrunedAttributeList`: the old op's discardable attributes besides the new ones.
        for a in &rw.body[op].attributes {
            if !d.attributes.iter().any(|x| x.name == a.name) {
                d.attributes.push(a.clone());
            }
        }
        let rts: Vec<Type<'_>> = rw.body[op].results.iter().map(|r| rw.body[*r].ty.clone()).collect();
        let body_ops = rw.body[blk].ops.clone();
        let loc = rw.body[op].loc.clone();
        let g = rw.create_with(d, &rts, |b, o| {
            let r = b.add_region(o);
            let mut types: Vec<_> = args[..ninputs].iter().map(|a| (b[*a].ty.clone(), loc.clone())).collect();
            types.extend(candidates.iter().map(|k| (b[args[*k]].ty.clone(), loc.clone())));
            types.extend(args[ninputs..].iter().map(|a| (b[*a].ty.clone(), loc.clone())));
            let nb = b.add_block(r, &types);
            let nargs = b[nb].args.to_vec();
            let mut map = Mapping::default();
            for (i, a) in args[..ninputs].iter().enumerate() {
                map.map(*a, nargs[i]);
            }
            for (j, k) in candidates.iter().enumerate() {
                map.map(args[*k], nargs[ninputs + j]);
            }
            for (j, a) in args[ninputs..].iter().enumerate() {
                if !candidates.contains(&(ninputs + j)) {
                    map.map(*a, nargs[ninputs + candidates.len() + j]);
                }
            }
            for bo in body_ops {
                let c = b.clone_op(bo, &mut map);
                b.insert(c, nb, None);
            }
        });
        let results = rw.body[g].results.to_vec();
        rw.replace_op(op, &results);
        true
    }

    /// `getReassociationMapForFoldingUnitDims`.
    fn folding_unit_dims(sizes: &[i64]) -> Vec<Vec<i64>> {
        let mut out: Vec<Vec<i64>> = Vec::new();
        let mut cur = Vec::new();
        for (d, s) in sizes.iter().enumerate() {
            cur.push(d as i64);
            if *s != 1 {
                out.push(core::mem::take(&mut cur));
            }
        }
        if !cur.is_empty()
            && let Some(last) = out.last_mut()
        {
            last.extend(cur);
        }
        out
    }

    /// `RankReducedExtractSliceOp`.
    fn rank_reduced_extract(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let rt = rw.body[rw.body[op].results[0]].ty.clone();
        let shape = rt.dims().unwrap_or_default();
        let re = Self::folding_unit_dims(&shape);
        if re.len() == shape.len() {
            return false;
        }
        // `inferCanonicalRankReducedResultType`: the first unit dims projected out.
        let mut drop = shape.len() - re.len();
        let reduced: Vec<i64> = shape.iter().copied().filter(|s| if *s == 1 && drop > 0 { drop -= 1; false } else { true }).collect();
        let lists = rw.body.slice_lists(op);
        let src = rw.body[op].operands[0];
        rw.set_before(op);
        let s = rw.create(OpData::sliced("tensor.extract_slice", &[src], &lists), &[Type::tensor(&reduced, rt.element_type().clone())]);
        let sv = rw.body[s].results[0];
        let x = Self::expand_to(rw, sv, &re, rt);
        rw.replace_op(op, &[x]);
        true
    }

    /// `RankReducedInsertSliceOp<InsertOpTy>`.
    fn rank_reduced_insert(rw: &mut Rewriter<'_, '_>, op: OpId, parallel: bool) -> bool {
        let (src, dest) = (rw.body[op].operands[0], rw.body[op].operands[1]);
        let st = rw.body[src].ty.clone();
        let shape = st.dims().unwrap_or_default();
        let re = Self::folding_unit_dims(&shape);
        if re.len() == shape.len() {
            return false;
        }
        match (parallel, rw.body.parent_op(op)) {
            (true, Some(p)) => rw.set_before(p),
            _ => rw.set_before(op),
        }
        // `CollapseShapeOp::build` without a result type: `computeTensorReshapeCollapsedType`.
        let collapsed: Vec<i64> = re.iter().map(|g| g.iter().map(|d| shape[*d as usize]).try_fold(1i64, |p, d| (d != Dim::DYNAMIC).then_some(p * d)).unwrap_or(Dim::DYNAMIC)).collect();
        let c = rw.emit(&tensor::CollapseShapeOp::new(src.into(), Reshape::attr(&re), st.clone(), Type::tensor(&collapsed, st.element_type().clone())));
        let cv = rw.body[c].results[0];
        let lists = rw.body.slice_lists(op);
        let name = rw.body[op].name.clone();
        let rts: Vec<Type<'_>> = rw.body[op].results.iter().map(|r| rw.body[*r].ty.clone()).collect();
        rw.set_before(op);
        let n = rw.create(OpData::sliced(&name, &[cv, dest], &lists), &rts);
        let nv = rw.body[n].results.to_vec();
        rw.replace_op(op, &nv);
        true
    }

    /// `FoldEmptyTensorWithReshapeOp`: the result shape reified (an expand's output shape; a
    /// collapse's static groups).
    fn empty_of_reshape(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        if rw.body.def_named(rw.body[op].operands[0], "tensor.empty").is_none() {
            return false;
        }
        rw.set_before(op);
        let Some(shapes) = rw.reify(op) else { return false };
        let [sizes] = shapes.as_slice() else { return false };
        let rt = rw.body[rw.body[op].results[0]].ty.clone();
        let dynamic: Vec<ValueId> = sizes.iter().filter_map(Self::value).collect();
        let ty = Type::tensor(&Self::statics(sizes), rt.element_type().clone());
        let e = Self::empty(rw, &dynamic, ty.clone());
        let r = if ty == rt { e } else { let c = rw.create(OpData::build("tensor.cast").operands(&[e]), &[rt]); rw.body[c].results[0] };
        rw.replace_op(op, &[r]);
        true
    }
}
