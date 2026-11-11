//! `fold-memref-alias-ops`' rules, as `FoldMemRefAliasOps.cpp`: an indexed access, an
//! indexed copy or a vector transfer through a `memref.subview`, `memref.expand_shape` or
//! `memref.collapse_shape` goes to the aliased memref in place, its indices resolved
//! (`affine.apply`, `affine.linearize_index`, `affine.delinearize_index`); a subview of a
//! subview is one subview.

use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{AffineExpr, AffineMap, Attribute, Dim, Type};

use crate::rewrite::Build;
use crate::{MemrefLayout, MemrefOfr as Ofr, OpData, OpId, Rewriter, ValueId};

/// `populateFoldMemRefAliasOpPatterns`.
pub struct FoldAlias;

/// What an `IndexedAccessOpInterface` op reads or writes at its indices.
#[derive(Clone, Copy, PartialEq, Eq)]
enum Access {
    /// One element (`memref.load` and the like): starts in bounds.
    Scalar,
    /// A vector (`vector.load` and the like): its accessed shape is the vector's without
    /// leading unit dims (a rank-0 access only when `rank_zero`); not known in bounds.
    Vector { rank_zero: bool },
    /// A row of memory (`gpu.subgroup_mma_*_matrix`, `nvgpu.ldmatrix`): starts in bounds.
    Row,
}

/// The alias an access goes through.
#[derive(Clone, Copy, PartialEq, Eq)]
enum Alias {
    SubView,
    Expand,
    Collapse,
}

impl Alias {
    fn of(name: &str) -> Option<Self> {
        Some(match name {
            "memref.subview" => Self::SubView,
            "memref.expand_shape" => Self::Expand,
            "memref.collapse_shape" => Self::Collapse,
            _ => return None,
        })
    }
}

#[crate::patterns]
impl FoldAlias {
    /// `AccessOpOfSubViewOpFolder` / `AccessOpOfExpandShapeOpFolder` /
    /// `AccessOpOfCollapseShapeOpFolder`.
    #[rewrite("_")]
    fn access_op_of_alias(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        Self::access(rw, op)
    }

    /// `IndexedMemCopyOpOf{SubView,ExpandShape,CollapseShape}OpFolder`.
    #[rewrite("_")]
    fn indexed_mem_copy_op_of_alias(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        Self::mem_copy(rw, op)
    }

    /// `TransferOpOf{SubView,ExpandShape,CollapseShape}OpFolder`.
    #[rewrite("_")]
    fn transfer_op_of_alias(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        Self::transfer(rw, op)
    }

    /// `SubViewOfSubViewFolder` (`mergeOffsetsSizesAndStrides`): offsets
    /// `producer offset + consumer offset * producer stride`, strides multiplied, the producer's
    /// dropped dims kept.
    #[rewrite("memref.subview")]
    fn subview_of_subview(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let Some(inner) = rw.body.def_named(rw.body[op].operands[0], "memref.subview") else { return false };
        let [offsets, sizes, strides] = rw.body.slice_lists(op);
        let [p_offsets, p_sizes, p_strides] = rw.body.slice_lists(inner);
        let dropped = Self::dropped(rw, inner);
        rw.set_before(op);
        let (madd, mul) = (Self::map(AffineExpr::Sym(0).mul(AffineExpr::Sym(1)).add(AffineExpr::Sym(2))), Self::map(AffineExpr::Sym(0).mul(AffineExpr::Sym(1))));
        let (mut o, mut s, mut t) = (Vec::new(), Vec::new(), Vec::new());
        let mut consumer = 0;
        for i in 0..p_offsets.len() {
            if dropped[i] {
                o.push(p_offsets[i]);
                s.push(p_sizes[i]);
                t.push(p_strides[i]);
                continue;
            }
            o.push(rw.composed_folded_apply(madd.clone(), &[offsets[consumer], p_strides[i], p_offsets[i]]));
            s.push(sizes[consumer]);
            t.push(rw.composed_folded_apply(mul.clone(), &[strides[consumer], p_strides[i]]));
            consumer += 1;
        }
        let src = rw.body[inner].operands[0];
        let ty = rw.body[rw.body[op].results[0]].ty.clone();
        rw.replace_with(op, OpData::sliced("memref.subview", &[src], &[o, s, t]), &[ty]);
        true
    }
}

impl FoldAlias {
    /// `affine_map<()[s0, s1, s2] -> (e)>`.
    fn map(e: AffineExpr) -> AffineMap {
        AffineMap { dims: 0, syms: 3, results: vec![e] }
    }

    /// An access op's memref operand position and kind.
    fn access_kind(name: &str) -> Option<(usize, Access)> {
        let vector = |rank_zero| Access::Vector { rank_zero };
        Some(match name {
            "memref.load" | "memref.prefetch" | "memref.generic_atomic_rmw" => (0, Access::Scalar),
            "memref.store" | "memref.atomic_rmw" => (1, Access::Scalar),
            "vector.load" => (0, vector(true)),
            "vector.store" => (1, vector(true)),
            "vector.maskedload" | "vector.maskedstore" | "vector.expandload" | "vector.compressstore" => (0, vector(false)),
            "gpu.subgroup_mma_load_matrix" | "nvgpu.ldmatrix" => (0, Access::Row),
            "gpu.subgroup_mma_store_matrix" => (1, Access::Row),
            _ => return None,
        })
    }

    /// The vector a vector access reads or writes: its result, else its stored value.
    fn access_vector<'a>(rw: &Rewriter<'_, 'a>, op: OpId) -> Option<Type<'a>> {
        let b = &*rw.body;
        let v = match (b[op].results.first(), &*b[op].name) {
            (Some(r), _) => *r,
            (None, "vector.store") => b[op].operands[0],
            (None, _) => *b[op].operands.last()?,
        };
        Some(b[v].ty.clone())
    }

    /// The leading unit (not scalable) dims of a vector type.
    fn leading_units(t: &Type<'_>) -> usize {
        t.shape().map_or(0, |d| d.iter().take_while(|x| matches!(x, Dim::Static(1))).count())
    }

    /// `getAccessedShape`'s rank.
    fn accessed_rank(rw: &Rewriter<'_, '_>, op: OpId, kind: Access) -> Option<usize> {
        Some(match kind {
            Access::Scalar => 0,
            Access::Row => 1,
            Access::Vector { rank_zero } => {
                let t = Self::access_vector(rw, op)?;
                let rank = t.shape()?.len();
                let mut lead = Self::leading_units(&t);
                if !rank_zero && lead == rank {
                    lead -= 1;
                }
                rank - lead
            }
        })
    }

    /// Whether the last `n` static strides of `subview` are 1 (`hasTrailingUnitStrides`).
    fn trailing_unit_strides(rw: &Rewriter<'_, '_>, subview: OpId, n: usize) -> bool {
        let strides = rw.body.dense_i64(subview, "static_strides");
        n <= strides.len() && strides[strides.len() - n..].iter().all(|s| *s == 1)
    }

    /// Whether the last `n` reassociation groups are single dims (`hasTrivialReassociationSuffix`).
    fn trivial_suffix(rw: &Rewriter<'_, '_>, reshape: OpId, n: usize) -> bool {
        let groups = rw.body.reassociation(reshape);
        n <= groups.len() && groups[groups.len() - n..].iter().all(|g| g.len() == 1)
    }

    /// The source rank of an alias op.
    fn src_rank(rw: &Rewriter<'_, '_>, alias: OpId) -> usize {
        rw.body[rw.body[alias].operands[0]].ty.dims().unwrap_or_default().len()
    }

    /// The indices into the alias's source for `indices` into it (`startsInbounds` for the
    /// reshapes).
    fn resolve_through(rw: &mut Rewriter<'_, '_>, alias: OpId, kind: Alias, indices: &[ValueId], inbounds: bool) -> Vec<ValueId> {
        match kind {
            Alias::SubView => {
                let [offsets, _, strides] = rw.body.slice_lists(alias);
                let dropped = Self::dropped(rw, alias);
                let indices: Vec<Ofr> = indices.iter().map(|v| Ofr::V(*v)).collect();
                Self::resolve(rw, &offsets, &strides, &dropped, &indices)
            }
            Alias::Expand => Self::resolve_expand(rw, alias, indices, inbounds),
            Alias::Collapse => Self::resolve_collapse(rw, alias, indices, inbounds),
        }
    }

    /// The access ops' fold through an alias.
    fn access(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let Some((at, kind)) = Self::access_kind(&rw.body[op].name) else { return false };
        let base = rw.body[op].operands[at];
        let Some(alias) = rw.body.def_op(base) else { return false };
        let Some(how) = Alias::of(&rw.body[alias].name) else { return false };
        let Some(rank) = rw.body[base].ty.dims().map(|d| d.len()) else { return false };
        let Some(accessed) = Self::accessed_rank(rw, op, kind) else { return false };
        let src_rank = Self::src_rank(rw, alias);
        match how {
            Alias::SubView => {
                if !Self::trailing_unit_strides(rw, alias, accessed) {
                    return false;
                }
                // Reintroducing a dropped dim among the accessed ones would change the access.
                let dropped = Self::dropped(rw, alias);
                if accessed > 0 && (src_rank + 1 - accessed..src_rank).any(|d| dropped[d]) {
                    return false;
                }
            }
            Alias::Expand | Alias::Collapse => {
                if src_rank < accessed || !Self::trivial_suffix(rw, alias, accessed.saturating_sub(1)) {
                    return false;
                }
            }
        }
        let indices = rw.body[op].operands[at + 1..at + 1 + rank].to_vec();
        rw.set_before(op);
        let inbounds = kind != (Access::Vector { rank_zero: true }) && kind != (Access::Vector { rank_zero: false });
        let resolved = Self::resolve_through(rw, alias, how, &indices, inbounds);
        let src = rw.body[alias].operands[0];
        Self::update_access(rw, op, at, rank, kind, src, &resolved);
        true
    }

    /// `updateMemrefAndIndices`: in place; a vector access of fewer indices than its rank drops
    /// that many leading unit dims, its vector operands shape-cast down (a load cloned at the
    /// lower rank and its result cast back).
    fn update_access(rw: &mut Rewriter<'_, '_>, op: OpId, at: usize, rank: usize, kind: Access, src: ValueId, indices: &[ValueId]) {
        let mut operands = rw.body[op].operands[..at].to_vec();
        operands.push(src);
        operands.extend(indices);
        operands.extend(&rw.body[op].operands[at + 1 + rank..]);
        let vt = match kind {
            Access::Vector { .. } => Self::access_vector(rw, op),
            _ => None,
        };
        let drop = vt.as_ref().and_then(|t| t.shape()?.len().checked_sub(indices.len())).filter(|n| *n > 0);
        let (Some(vt), Some(n)) = (vt, drop) else {
            rw.modify(op, |b| b.set_operands(op, operands));
            return;
        };
        let Type::Shaped(vs) = &vt else { return };
        // A vector operand of the access's vector type, without the `n` leading dims.
        fn lower<'a>(t: &Type<'a>, vs: &mlirformat::Shaped<'_>, n: usize) -> Option<Type<'a>> {
            let Type::Shaped(s) = t else { return None };
            (s.kind == vs.kind && s.shape == vs.shape).then(|| Type::Shaped(alloc::boxed::Box::new(mlirformat::Shaped { shape: s.shape.as_ref().map(|d| d[n..].to_vec()), ..*s.clone() })))
        }
        let mut cast: Vec<(ValueId, ValueId)> = Vec::new();
        for i in 0..operands.len() {
            let v = operands[i];
            if let Some(&(_, c)) = cast.iter().find(|(from, _)| *from == v) {
                operands[i] = c;
                continue;
            }
            let Some(t) = lower(&rw.body[v].ty, vs, n) else { continue };
            let c = rw.make1(OpData::build("vector.shape_cast").operands(&[v]), t);
            cast.push((v, c));
            operands[i] = c;
        }
        match rw.body[op].results.first().copied() {
            Some(r) => {
                let Some(low) = lower(&rw.body[r].ty, vs, n) else { return };
                let old = rw.body[op].clone();
                let mut data = OpData::named(old.name.clone()).operands(&operands);
                data.properties.clone_from(&old.properties);
                data.attributes.clone_from(&old.attributes);
                let new = rw.create(data, &[low]);
                let nr = rw.body[new].results[0];
                let back = rw.make1(OpData::build("vector.shape_cast").operands(&[nr]), vt.clone());
                rw.replace_op(op, &[back]);
            }
            None => rw.modify(op, |b| b.set_operands(op, operands)),
        }
    }

    /// The indexed copies' fold through aliases of their source and destination.
    fn mem_copy(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let b = &*rw.body;
        if !matches!(&*b[op].name, "memref.dma_start" | "nvgpu.device_async_copy") {
            return false;
        }
        let ops = b[op].operands.to_vec();
        let rank = |v: ValueId| b[v].ty.dims().map_or(0, |d| d.len());
        // (source, its indices, destination, its indices) as operand positions.
        let (src_at, dst_at) = match &*b[op].name {
            "memref.dma_start" => (0, 1 + rank(ops[0])),
            _ => {
                let nd = rank(ops[0]);
                (1 + nd, 0)
            }
        };
        let (src, dst) = (ops[src_at], ops[dst_at]);
        let alias = |v: ValueId| b.def_op(v).and_then(|a| Some((a, Alias::of(&b[a].name)?)));
        let (sa, da) = (alias(src), alias(dst));
        if sa.is_none() && da.is_none() {
            return false;
        }
        let (src_idx, dst_idx) = (ops[src_at + 1..src_at + 1 + rank(src)].to_vec(), ops[dst_at + 1..dst_at + 1 + rank(dst)].to_vec());
        rw.set_before(op);
        let fold = |rw: &mut Rewriter<'_, '_>, a: Option<(OpId, Alias)>, base: ValueId, idx: Vec<ValueId>| match a {
            Some((a, how)) => (rw.body[a].operands[0], Self::resolve_through(rw, a, how, &idx, true)),
            None => (base, idx),
        };
        let (nsrc, nsrc_idx) = fold(rw, sa, src, src_idx.clone());
        let (ndst, ndst_idx) = fold(rw, da, dst, dst_idx.clone());
        let (first, second) = if src_at < dst_at { ((nsrc, &nsrc_idx, src_idx.len()), (ndst, &ndst_idx, dst_idx.len())) } else { ((ndst, &ndst_idx, dst_idx.len()), (nsrc, &nsrc_idx, src_idx.len())) };
        let mut operands = vec![first.0];
        operands.extend(first.1);
        operands.push(second.0);
        operands.extend(second.1);
        operands.extend(&ops[2 + first.2 + second.2..]);
        let segs = rw.body.segments(op, "operandSegmentSizes");
        let (n1, n2) = (first.1.len(), second.1.len());
        rw.modify(op, |b| {
            b.set_operands(op, operands);
            if let Some(mut s) = segs {
                s[1] = n1;
                s[3] = n2;
                b.set_segments(op, "operandSegmentSizes", &s);
            }
        });
        true
    }

    /// A transfer reads or writes out of bounds somewhere (`hasOutOfBoundsDim`).
    fn out_of_bounds(rw: &Rewriter<'_, '_>, op: OpId) -> bool {
        match rw.body[op].get("in_bounds") {
            Some(Attribute::Array(a)) => a.iter().any(|x| !matches!(x, Attribute::Bool(true))),
            _ => true,
        }
    }

    /// The transfers' fold through an alias (`updateStartingPosition`).
    fn transfer(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let b = &*rw.body;
        if !matches!(&*b[op].name, "vector.transfer_read" | "vector.transfer_write") {
            return false;
        }
        let read = b[op].name == "vector.transfer_read";
        let at = usize::from(!read);
        let base = b[op].operands[at];
        let Some(alias) = b.def_op(base) else { return false };
        let Some(how) = Alias::of(&b[alias].name) else { return false };
        let Some(perm) = b[op].get("permutation_map").and_then(|a| AffineMap::try_from(a).ok()) else { return false };
        let vt = if read { b[b[op].results[0]].ty.clone() } else { b[b[op].operands[0]].ty.clone() };
        let vrank = vt.shape().map_or(0, |d| d.len());
        let rank = b[base].ty.dims().map_or(0, |d| d.len());
        let src_rank = Self::src_rank(rw, alias);
        let segs = b.segments(op, "operandSegmentSizes").unwrap_or_default();
        let masked = segs.last().is_some_and(|m| *m > 0);
        if Self::out_of_bounds(rw, op) {
            return false;
        }
        let new_perm = match how {
            Alias::SubView => {
                if !Self::trailing_unit_strides(rw, alias, vrank) {
                    return false;
                }
                // `expandDimsToRank`.
                let dropped = Self::dropped(rw, alias);
                let kept: Vec<AffineExpr> = (0..dropped.len() as u32).filter(|d| !dropped[*d as usize]).map(AffineExpr::Dim).collect();
                perm.compose(&AffineMap { dims: dropped.len() as u32, syms: 0, results: kept })
            }
            Alias::Expand => {
                if src_rank < vrank {
                    return false;
                }
                // Each result dim must be the innermost of its group.
                let groups = rw.body.reassociation(alias);
                let mut results = Vec::new();
                for e in &perm.results {
                    let AffineExpr::Dim(d) = e else { return false };
                    let Some(g) = groups.iter().position(|g| g.last() == Some(&i64::from(*d))) else { return false };
                    results.push(AffineExpr::Dim(g as u32));
                }
                AffineMap { dims: src_rank as u32, syms: 0, results }
            }
            Alias::Collapse => {
                let minor = perm.syms == 0 && perm.results.len() <= perm.dims as usize && perm.results.iter().enumerate().all(|(i, e)| *e == AffineExpr::Dim(perm.dims - perm.results.len() as u32 + i as u32));
                if !minor || src_rank < vrank || !Self::trivial_suffix(rw, alias, vrank) {
                    return false;
                }
                let r = src_rank as u32;
                AffineMap { dims: r, syms: 0, results: (r - vrank as u32..r).map(AffineExpr::Dim).collect() }
            }
        };
        let indices = rw.body[op].operands[at + 1..at + 1 + rank].to_vec();
        rw.set_before(op);
        let resolved = Self::resolve_through(rw, alias, how, &indices, !masked);
        let src = rw.body[alias].operands[0];
        let mut operands = rw.body[op].operands[..at].to_vec();
        operands.push(src);
        operands.extend(&resolved);
        operands.extend(&rw.body[op].operands[at + 1 + rank..]);
        let n = resolved.len();
        rw.modify(op, |b| {
            b.set_operands(op, operands);
            b[op].set("permutation_map", Attribute::from(&new_perm));
            if let Some(mut s) = b.segments(op, "operandSegmentSizes") {
                s[at + 1] = n;
                b.set_segments(op, "operandSegmentSizes", &s);
            }
        });
        true
    }

    /// `SubViewOp::getDroppedDims` (`computeMemRefRankReductionMask`): the static unit sizes;
    /// when there are more of them than dims dropped, by the strides the result lost (when a
    /// stride but the innermost is static), else by position (each result size matched to the
    /// next source size equal to it).
    fn dropped(rw: &Rewriter<'_, '_>, subview: OpId) -> Vec<bool> {
        let b = &*rw.body;
        let (src, res) = (&b[b[subview].operands[0]].ty, &b[b[subview].results[0]].ty);
        let (rank, reduced) = (src.dims().unwrap_or_default().len(), res.dims().unwrap_or_default().len());
        let sizes: Vec<i64> = b.slice_lists(subview)[1].iter().map(|s| b.ofr_int(*s).unwrap_or(Dim::DYNAMIC)).collect();
        let unused: Vec<bool> = sizes.iter().map(|s| *s == 1).collect();
        if rank <= reduced {
            return vec![false; rank];
        }
        if unused.iter().filter(|u| **u).count() + reduced == rank {
            return unused;
        }
        let strides = |t: &Type<'_>| match t {
            Type::Shaped(s) => s.strides_and_offset().map(|(st, _)| st),
            _ => None,
        };
        let (Some(original), Some(candidate)) = (strides(src), strides(res)) else { return unused };
        let static_outer = |s: &[i64]| s.len() > 1 && s[..s.len() - 1].iter().any(|x| *x != Dim::DYNAMIC);
        if static_outer(&original) || static_outer(&candidate) {
            if let Some(by_strides) = Self::dropped_by_strides(&original, &candidate, unused.clone(), reduced) {
                return by_strides;
            }
        }
        // `computeMemRefRankReductionMaskByPosition`.
        let mut used = vec![false; rank];
        let mut start = 0;
        for r in res.dims().unwrap_or_default() {
            let Some(j) = (start..rank).find(|j| sizes[*j] == r) else { return unused };
            used[j] = true;
            start = j + 1;
        }
        used.into_iter().map(|u| !u).collect()
    }

    /// `computeMemRefRankReductionMaskByStrides`: a unit dim is dropped while the source has
    /// its stride more often than the result.
    fn dropped_by_strides(original: &[i64], candidate: &[i64], mut unused: Vec<bool>, reduced: usize) -> Option<Vec<bool>> {
        let count = |v: &[i64], x: i64| v.iter().filter(|y| **y == x).count();
        let mut unaccounted: alloc::collections::BTreeMap<i64, usize> = original.iter().map(|s| (*s, count(original, *s))).collect();
        for (d, u) in unused.iter_mut().enumerate() {
            if !*u {
                continue;
            }
            let stride = original[d];
            let (left, want) = (unaccounted.get(&stride).copied().unwrap_or(0), count(candidate, stride));
            match left.cmp(&want) {
                core::cmp::Ordering::Greater => {
                    unaccounted.insert(stride, left - 1);
                }
                core::cmp::Ordering::Equal => *u = false,
                core::cmp::Ordering::Less => return None,
            }
        }
        (unused.iter().filter(|u| **u).count() + reduced == original.len()).then_some(unused)
    }

    /// `resolveIndicesIntoOpWithOffsetsAndStrides`: each index (0 in a dropped dim) is
    /// `offset + index * stride`, composed and folded.
    fn resolve(rw: &mut Rewriter<'_, '_>, offsets: &[Ofr], strides: &[Ofr], dropped: &[bool], indices: &[Ofr]) -> Vec<ValueId> {
        let mut consumer = indices.iter();
        let map = Self::map(AffineExpr::Sym(0).add(AffineExpr::Sym(1).mul(AffineExpr::Sym(2))));
        offsets
            .iter()
            .zip(strides)
            .zip(dropped)
            .map(|((o, s), d)| {
                let i = if *d { Ofr::C(0) } else { *consumer.next().expect("an index") };
                let r = rw.composed_folded_apply(map.clone(), &[*o, i, *s]);
                rw.value_of(r)
            })
            .collect()
    }

    /// `resolveSourceIndicesExpandShape`: a group's indices linearized by the output shape,
    /// `disjoint` when they start in bounds.
    fn resolve_expand(rw: &mut Rewriter<'_, '_>, ex: OpId, indices: &[ValueId], inbounds: bool) -> Vec<ValueId> {
        let shape = Ofr::mixed(&rw.body.dense_i64(ex, "static_output_shape"), &rw.body[ex].operands[1..]);
        let mut sources = Vec::new();
        for g in &rw.body.reassociation(ex) {
            if let [d] = g.as_slice() {
                sources.push(indices[*d as usize]);
                continue;
            }
            let basis: Vec<Ofr> = g.iter().map(|d| shape[*d as usize]).collect();
            let mut operands: Vec<ValueId> = g.iter().map(|d| indices[*d as usize]).collect();
            let dynamic: Vec<ValueId> = basis.iter().filter_map(|o| if let Ofr::V(v) = o { Some(*v) } else { None }).collect();
            operands.extend(&dynamic);
            let statics: Vec<i64> = basis.iter().map(|o| if let Ofr::C(c) = o { *c } else { Dim::DYNAMIC }).collect();
            let mut data = OpData::build("affine.linearize_index").operands(&operands).with("static_basis", Attribute::dense_i64(&statics)).segments(&[g.len(), dynamic.len()]);
            data = if inbounds { data.flag("disjoint") } else { data.with("disjoint", Attribute::Bool(false)) };
            let l = rw.create(data, &[Type::Index]);
            sources.push(rw.body[l].results[0]);
        }
        sources
    }

    /// `resolveSourceIndicesCollapseShape`: a group's index delinearized by the source's sizes
    /// (without the outermost unless it starts in bounds).
    fn resolve_collapse(rw: &mut Rewriter<'_, '_>, co: OpId, indices: &[ValueId], inbounds: bool) -> Vec<ValueId> {
        let src = rw.body[co].operands[0];
        let groups = rw.body.reassociation(co);
        // `getConstifiedMixedSizes` of the source's metadata.
        let meta = rw.extract_metadata(src);
        let dims = rw.body[src].ty.dims().unwrap_or_default();
        let sizes: Vec<Ofr> = dims.iter().enumerate().map(|(i, d)| if *d == Dim::DYNAMIC { Ofr::V(rw.body[meta].results[2 + i]) } else { Ofr::C(*d) }).collect();
        let mut sources = Vec::new();
        for (index, g) in indices.iter().zip(&groups) {
            if g.len() == 1 {
                sources.push(*index);
                continue;
            }
            let trimmed = &g[usize::from(!inbounds)..];
            let basis: Vec<Ofr> = trimmed.iter().map(|d| sizes[*d as usize]).collect();
            let mut operands = vec![*index];
            operands.extend(basis.iter().filter_map(|o| if let Ofr::V(v) = o { Some(*v) } else { None }));
            let statics: Vec<i64> = basis.iter().map(|o| if let Ofr::C(c) = o { *c } else { Dim::DYNAMIC }).collect();
            let d = rw.create(OpData::build("affine.delinearize_index").operands(&operands).with("static_basis", Attribute::dense_i64(&statics)), &vec![Type::Index; g.len()]);
            sources.extend(rw.body[d].results.iter().copied());
        }
        if groups.is_empty() {
            let zero = rw.composed_folded_apply(AffineMap { dims: 0, syms: 0, results: vec![AffineExpr::Const(0)] }, &[]);
            for _ in 0..dims.len() {
                let v = rw.value_of(zero);
                sources.push(v);
            }
        }
        sources
    }
}
