//! `fold-memref-alias-ops`' rules, as `FoldMemRefAliasOps.cpp`: a load or store through a
//! `memref.subview`, `memref.expand_shape` or `memref.collapse_shape` goes to the aliased
//! memref, its indices resolved (`affine.apply`, `affine.linearize_index`,
//! `affine.delinearize_index`); a subview of a subview is one subview.

use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{AffineExpr, AffineMap, Attribute, Type};

use crate::{MemrefLayout, MemrefOfr as Ofr, OpData, OpId, Rewriter, ValueId};

/// `populateFoldMemRefAliasOpPatterns`.
pub struct FoldAlias;

#[crate::patterns]
impl FoldAlias {
    /// `LoadOpOfSubViewOpFolder<memref::LoadOp>`.
    #[rewrite("memref.load")]
    fn load_of_subview(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        Self::subview(rw, op)
    }

    /// `LoadOpOfSubViewOpFolder<nvgpu::LdMatrixOp>`.
    #[rewrite("nvgpu.ldmatrix")]
    fn ldmatrix_of_subview(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        Self::subview(rw, op)
    }

    /// `LoadOpOfSubViewOpFolder<vector::LoadOp>`.
    #[rewrite("vector.load")]
    fn vector_load_of_subview(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        Self::subview(rw, op)
    }

    /// `LoadOpOfSubViewOpFolder<vector::MaskedLoadOp>`.
    #[rewrite("vector.maskedload")]
    fn masked_load_of_subview(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        Self::subview(rw, op)
    }

    /// `LoadOpOfSubViewOpFolder<vector::TransferReadOp>`.
    #[rewrite("vector.transfer_read")]
    fn transfer_read_of_subview(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        Self::subview(rw, op)
    }

    /// `LoadOpOfSubViewOpFolder<gpu::SubgroupMmaLoadMatrixOp>`.
    #[rewrite("gpu.subgroup_mma_load_matrix")]
    fn mma_load_of_subview(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        Self::subview(rw, op)
    }

    /// `StoreOpOfSubViewOpFolder<memref::StoreOp>`.
    #[rewrite("memref.store")]
    fn store_of_subview(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        Self::subview(rw, op)
    }

    /// `StoreOpOfSubViewOpFolder<vector::TransferWriteOp>`.
    #[rewrite("vector.transfer_write")]
    fn transfer_write_of_subview(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        Self::subview(rw, op)
    }

    /// `StoreOpOfSubViewOpFolder<vector::StoreOp>`.
    #[rewrite("vector.store")]
    fn vector_store_of_subview(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        Self::subview(rw, op)
    }

    /// `StoreOpOfSubViewOpFolder<vector::MaskedStoreOp>`.
    #[rewrite("vector.maskedstore")]
    fn masked_store_of_subview(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        Self::subview(rw, op)
    }

    /// `StoreOpOfSubViewOpFolder<gpu::SubgroupMmaStoreMatrixOp>`.
    #[rewrite("gpu.subgroup_mma_store_matrix")]
    fn mma_store_of_subview(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        Self::subview(rw, op)
    }

    /// `LoadOpOfExpandShapeOpFolder<memref::LoadOp>`.
    #[rewrite("memref.load")]
    fn load_of_expand(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        Self::expand(rw, op)
    }

    /// `LoadOpOfExpandShapeOpFolder<vector::LoadOp>`.
    #[rewrite("vector.load")]
    fn vector_load_of_expand(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        Self::expand(rw, op)
    }

    /// `LoadOpOfExpandShapeOpFolder<vector::MaskedLoadOp>`.
    #[rewrite("vector.maskedload")]
    fn masked_load_of_expand(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        Self::expand(rw, op)
    }

    /// `LoadOpOfExpandShapeOpFolder<vector::TransferReadOp>`.
    #[rewrite("vector.transfer_read")]
    fn transfer_read_of_expand(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        Self::expand(rw, op)
    }

    /// `StoreOpOfExpandShapeOpFolder<memref::StoreOp>`.
    #[rewrite("memref.store")]
    fn store_of_expand(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        Self::expand(rw, op)
    }

    /// `StoreOpOfExpandShapeOpFolder<vector::StoreOp>`.
    #[rewrite("vector.store")]
    fn vector_store_of_expand(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        Self::expand(rw, op)
    }

    /// `StoreOpOfExpandShapeOpFolder<vector::MaskedStoreOp>`.
    #[rewrite("vector.maskedstore")]
    fn masked_store_of_expand(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        Self::expand(rw, op)
    }

    /// `LoadOpOfCollapseShapeOpFolder<memref::LoadOp>`.
    #[rewrite("memref.load")]
    fn load_of_collapse(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        Self::collapse(rw, op)
    }

    /// `LoadOpOfCollapseShapeOpFolder<vector::LoadOp>`.
    #[rewrite("vector.load")]
    fn vector_load_of_collapse(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        Self::collapse(rw, op)
    }

    /// `LoadOpOfCollapseShapeOpFolder<vector::MaskedLoadOp>`.
    #[rewrite("vector.maskedload")]
    fn masked_load_of_collapse(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        Self::collapse(rw, op)
    }

    /// `StoreOpOfCollapseShapeOpFolder<memref::StoreOp>`.
    #[rewrite("memref.store")]
    fn store_of_collapse(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        Self::collapse(rw, op)
    }

    /// `StoreOpOfCollapseShapeOpFolder<vector::StoreOp>`.
    #[rewrite("vector.store")]
    fn vector_store_of_collapse(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        Self::collapse(rw, op)
    }

    /// `StoreOpOfCollapseShapeOpFolder<vector::MaskedStoreOp>`.
    #[rewrite("vector.maskedstore")]
    fn masked_store_of_collapse(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        Self::collapse(rw, op)
    }

    /// `SubViewOfSubViewFolder`: unit strides both, the offsets resolved into the source's.
    #[rewrite("memref.subview")]
    fn subview_of_subview(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let Some(inner) = rw.body.def_named(rw.body[op].operands[0], "memref.subview") else { return false };
        let [offsets, sizes, strides] = rw.body.slice_lists(op);
        let [src_offsets, src_sizes, src_strides] = rw.body.slice_lists(inner);
        if !Self::unit(rw, &strides) || !Self::unit(rw, &src_strides) {
            return false;
        }
        let dropped = Self::dropped(rw, inner);
        // `resolveSizesIntoOpWithSizes`.
        let mut outer = sizes.iter();
        let resolved_sizes: Vec<Ofr> = src_sizes.iter().zip(&dropped).map(|(s, d)| if *d { *s } else { *outer.next().expect("a size") }).collect();
        let indices: Vec<Ofr> = offsets;
        rw.set_before(op);
        let resolved = Self::resolve(rw, &src_offsets, &src_strides, &dropped, &indices);
        // `getAsOpFoldResult`: a constant offset is static.
        let resolved: Vec<Ofr> = resolved.into_iter().map(|v| rw.body.const_index(v).map_or(Ofr::V(v), Ofr::C)).collect();
        let src = rw.body[inner].operands[0];
        let ty = rw.body[rw.body[op].results[0]].ty.clone();
        rw.replace_with(op, OpData::sliced("memref.subview", &[src], &[resolved, resolved_sizes, src_strides]), &[ty]);
        true
    }

    /// `NVGPUAsyncCopyOpSubViewOpFolder`: a subview source or destination folded into the copy,
    /// the source's indices resolved first.
    #[rewrite("nvgpu.device_async_copy")]
    fn async_copy_of_subview(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let segs = rw.body.segments(op, "operandSegmentSizes").unwrap_or_default();
        let ops = rw.body[op].operands.to_vec();
        let (Some(&nd), Some(&ns)) = (segs.get(1), segs.get(3)) else { return false };
        let (dst, src) = (ops[0], ops[1 + nd]);
        let (dst_idx, src_idx) = (ops[1..1 + nd].to_vec(), ops[2 + nd..2 + nd + ns].to_vec());
        let (src_sv, dst_sv) = (rw.body.def_named(src, "memref.subview"), rw.body.def_named(dst, "memref.subview"));
        if src_sv.is_none() && dst_sv.is_none() {
            return false;
        }
        rw.set_before(op);
        let fold = |rw: &mut Rewriter<'_, '_>, sv: Option<OpId>, base: ValueId, idx: Vec<ValueId>| match sv {
            Some(sv) => {
                let [offsets, _, strides] = rw.body.slice_lists(sv);
                let dropped = Self::dropped(rw, sv);
                let idx: Vec<Ofr> = idx.into_iter().map(Ofr::V).collect();
                (rw.body[sv].operands[0], Self::resolve(rw, &offsets, &strides, &dropped, &idx))
            }
            None => (base, idx),
        };
        let (src, src_idx) = fold(rw, src_sv, src, src_idx);
        let (dst, dst_idx) = fold(rw, dst_sv, dst, dst_idx);
        let mut operands = vec![dst];
        operands.extend(&dst_idx);
        operands.push(src);
        operands.extend(&src_idx);
        operands.extend(&ops[2 + nd + ns..]);
        let old = rw.body[op].clone();
        let mut data = OpData::named(old.name.clone()).operands(&operands);
        data.properties.clone_from(&old.properties);
        let ty = rw.body[old.results[0]].ty.clone();
        let new = rw.replace_with(op, data, &[ty]);
        rw.body.set_segments(new, "operandSegmentSizes", &[1, dst_idx.len(), 1, src_idx.len(), segs.get(4).copied().unwrap_or(0)]);
        true
    }
}

impl FoldAlias {
    /// Where the memref an access op reads or writes sits among its operands.
    fn base(name: &str) -> Option<usize> {
        Some(match name {
            "memref.load" | "vector.load" | "vector.maskedload" | "vector.transfer_read" | "gpu.subgroup_mma_load_matrix" | "nvgpu.ldmatrix" | "vector.maskedstore" => 0,
            "memref.store" | "vector.store" | "vector.transfer_write" | "gpu.subgroup_mma_store_matrix" => 1,
            _ => return None,
        })
    }

    /// The memref of access `op`, its operand position and the indices into it.
    fn access(rw: &Rewriter<'_, '_>, op: OpId) -> Option<(usize, ValueId, Vec<ValueId>)> {
        let b = &*rw.body;
        let at = Self::base(&b[op].name)?;
        let base = *b[op].operands.get(at)?;
        let rank = b[base].ty.dims()?.len();
        Some((at, base, b[op].operands.get(at + 1..at + 1 + rank)?.to_vec()))
    }

    /// Whether every one of `strides` is 1 (`hasUnitStride`).
    fn unit(rw: &Rewriter<'_, '_>, strides: &[Ofr]) -> bool {
        strides.iter().all(|s| rw.body.ofr_int(*s) == Some(1))
    }

    /// `SubViewOp::getDroppedDims` (`computeMemRefRankReductionMask`): the static unit sizes,
    /// and when there are more of them than dims dropped, those whose stride the result lost.
    fn dropped(rw: &Rewriter<'_, '_>, subview: OpId) -> Vec<bool> {
        let b = &*rw.body;
        let (src, res) = (&b[b[subview].operands[0]].ty, &b[b[subview].results[0]].ty);
        let (rank, reduced) = (src.dims().unwrap_or_default().len(), res.dims().unwrap_or_default().len());
        let mut unused: Vec<bool> = b.slice_lists(subview)[1].iter().map(|s| *s == Ofr::C(1)).collect();
        if rank == reduced {
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
        let count = |v: &[i64], x: i64| v.iter().filter(|y| **y == x).count();
        let mut unaccounted: alloc::collections::BTreeMap<i64, usize> = original.iter().map(|s| (*s, count(&original, *s))).collect();
        for (d, u) in unused.iter_mut().enumerate() {
            if !*u {
                continue;
            }
            let stride = original[d];
            let left = unaccounted.get(&stride).copied().unwrap_or(0);
            if left > count(&candidate, stride) {
                unaccounted.insert(stride, left - 1);
            } else {
                *u = false;
            }
        }
        unused
    }

    /// `resolveIndicesIntoOpWithOffsetsAndStrides`: each index (0 in a dropped dim) is
    /// `offset + index * stride`, composed and folded.
    fn resolve(rw: &mut Rewriter<'_, '_>, offsets: &[Ofr], strides: &[Ofr], dropped: &[bool], indices: &[Ofr]) -> Vec<ValueId> {
        let mut consumer = indices.iter();
        let map = AffineMap { dims: 0, syms: 3, results: vec![AffineExpr::Sym(0).add(AffineExpr::Sym(1).mul(AffineExpr::Sym(2)))] };
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

    /// `op` rebuilt on `base` at `indices` (the operands around them, its properties kept), a
    /// transfer with `permutation`.
    fn rebuild(rw: &mut Rewriter<'_, '_>, op: OpId, at: usize, base: ValueId, indices: &[ValueId], permutation: Option<AffineMap>) {
        let old = rw.body[op].clone();
        let rank = rw.body[old.operands[at]].ty.dims().unwrap_or_default().len();
        let mut operands: Vec<ValueId> = old.operands[..at].to_vec();
        operands.push(base);
        operands.extend(indices);
        operands.extend(&old.operands[at + 1 + rank..]);
        let mut data = OpData::named(old.name.clone()).operands(&operands);
        data.properties.clone_from(&old.properties);
        data.attributes.clone_from(&old.attributes);
        // Their builders take `nontemporal` and set it, `false` included.
        if matches!(&*old.name, "memref.load" | "memref.store" | "vector.load" | "vector.store") && data.get("nontemporal").is_none() {
            data.set("nontemporal", Attribute::Bool(false));
        }
        if let Some(map) = permutation {
            data.set("permutation_map", Attribute::from(&map));
        }
        let types: Vec<Type<'_>> = old.results.iter().map(|r| rw.body[*r].ty.clone()).collect();
        let new = rw.replace_with(op, data, &types);
        // The indices' operand segment, after the memref's.
        if let Some(mut segs) = rw.body.segments(new, "operandSegmentSizes") {
            let mut start = 0;
            for s in segs.iter_mut() {
                if start == at + 1 {
                    *s = indices.len();
                    break;
                }
                start += *s;
            }
            rw.body.set_segments(new, "operandSegmentSizes", &segs);
        }
    }

    /// A transfer reads or writes out of bounds somewhere (`hasOutOfBoundsDim`).
    fn out_of_bounds(rw: &Rewriter<'_, '_>, op: OpId) -> bool {
        match rw.body[op].get("in_bounds") {
            Some(Attribute::Array(a)) => a.iter().any(|x| !matches!(x, Attribute::Bool(true))),
            _ => true,
        }
    }

    /// `LoadOpOfSubViewOpFolder` / `StoreOpOfSubViewOpFolder`.
    fn subview(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let Some((at, base, indices)) = Self::access(rw, op) else { return false };
        let Some(sv) = rw.body.def_named(base, "memref.subview") else { return false };
        let [offsets, _, strides] = rw.body.slice_lists(sv);
        let transfer = rw.body[op].name.starts_with("vector.transfer_");
        // `preconditionsFoldSubViewOp`.
        if transfer && (Self::out_of_bounds(rw, op) || !Self::unit(rw, &strides)) {
            return false;
        }
        let dropped = Self::dropped(rw, sv);
        let src = rw.body[sv].operands[0];
        rw.set_before(op);
        let indices: Vec<Ofr> = indices.into_iter().map(Ofr::V).collect();
        let resolved = Self::resolve(rw, &offsets, &strides, &dropped, &indices);
        // `expandDimsToRank`: the permutation over the source's rank.
        let permutation = transfer.then(|| {
            let map = rw.body[op].get("permutation_map").and_then(|a| AffineMap::try_from(a).ok()).expect("a permutation map");
            let kept: Vec<AffineExpr> = (0..dropped.len() as u32).filter(|d| !dropped[*d as usize]).map(AffineExpr::Dim).collect();
            map.compose(&AffineMap { dims: dropped.len() as u32, syms: 0, results: kept })
        });
        Self::rebuild(rw, op, at, src, &resolved, permutation);
        true
    }

    /// `LoadOpOfExpandShapeOpFolder` / `StoreOpOfExpandShapeOpFolder`
    /// (`resolveSourceIndicesExpandShape`): a group's indices linearized by the output shape.
    fn expand(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let Some((at, base, indices)) = Self::access(rw, op) else { return false };
        let Some(ex) = rw.body.def_named(base, "memref.expand_shape") else { return false };
        let name = rw.body[op].name.clone();
        if !matches!(&*name, "memref.load" | "memref.store" | "vector.load" | "vector.store" | "vector.maskedload" | "vector.maskedstore" | "vector.transfer_read") {
            return false;
        }
        // memref.load / store start in bounds; the vector ops need not.
        let disjoint = matches!(&*name, "memref.load" | "memref.store");
        let shape = Ofr::mixed(&rw.body.dense_i64(ex, "static_output_shape"), &rw.body[ex].operands[1..]);
        let groups = rw.body.reassociation(ex);
        rw.set_before(op);
        let mut sources = Vec::new();
        for g in &groups {
            if let [d] = g.as_slice() {
                sources.push(indices[*d as usize]);
                continue;
            }
            let basis: Vec<Ofr> = g.iter().map(|d| shape[*d as usize]).collect();
            let mut operands: Vec<ValueId> = g.iter().map(|d| indices[*d as usize]).collect();
            let dynamic: Vec<ValueId> = basis.iter().filter_map(|o| if let Ofr::V(v) = o { Some(*v) } else { None }).collect();
            operands.extend(&dynamic);
            let statics: Vec<i64> = basis.iter().map(|o| if let Ofr::C(c) = o { *c } else { mlirformat::Dim::DYNAMIC }).collect();
            let mut data = OpData::build("affine.linearize_index").operands(&operands).with("static_basis", Attribute::dense_i64(&statics)).segments(&[g.len(), dynamic.len()]);
            data = if disjoint { data.flag("disjoint") } else { data.with("disjoint", Attribute::Bool(false)) };
            let l = rw.create(data, &[Type::Index]);
            sources.push(rw.body[l].results[0]);
        }
        let src = rw.body[ex].operands[0];
        let mut permutation = None;
        if &*name == "vector.transfer_read" {
            // Only a minor identity permutation, onto a source of at least the vector's rank.
            let map = rw.body[op].get("permutation_map").and_then(|a| AffineMap::try_from(a).ok()).expect("a permutation map");
            let vrank = rw.body[rw.body[op].results[0]].ty.dims().unwrap_or_default().len();
            let minor = map.syms == 0 && map.results.len() <= map.dims as usize && map.results.iter().enumerate().all(|(i, e)| *e == AffineExpr::Dim(map.dims - map.results.len() as u32 + i as u32));
            if !minor || sources.len() < vrank {
                return false;
            }
            let rank = sources.len() as u32;
            permutation = Some(AffineMap { dims: rank, syms: 0, results: (rank - vrank as u32..rank).map(AffineExpr::Dim).collect() });
        }
        Self::rebuild(rw, op, at, src, &sources, permutation);
        true
    }

    /// `LoadOpOfCollapseShapeOpFolder` / `StoreOpOfCollapseShapeOpFolder`
    /// (`resolveSourceIndicesCollapseShape`): a group's index delinearized by the source's sizes.
    fn collapse(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let Some((at, base, indices)) = Self::access(rw, op) else { return false };
        let Some(co) = rw.body.def_named(base, "memref.collapse_shape") else { return false };
        if !matches!(&*rw.body[op].name, "memref.load" | "memref.store" | "vector.load" | "vector.store" | "vector.maskedload" | "vector.maskedstore") {
            return false;
        }
        let src = rw.body[co].operands[0];
        let groups = rw.body.reassociation(co);
        rw.set_before(op);
        // `getConstifiedMixedSizes` of the source's metadata.
        let meta = rw.extract_metadata(src);
        let dims = rw.body[src].ty.dims().unwrap_or_default();
        let sizes: Vec<Ofr> = dims.iter().enumerate().map(|(i, d)| if *d == mlirformat::Dim::DYNAMIC { Ofr::V(rw.body[meta].results[2 + i]) } else { Ofr::C(*d) }).collect();
        let mut sources = Vec::new();
        for (index, g) in indices.iter().zip(&groups) {
            if g.len() == 1 {
                sources.push(*index);
                continue;
            }
            let basis: Vec<Ofr> = g.iter().map(|d| sizes[*d as usize]).collect();
            let mut operands = vec![*index];
            operands.extend(basis.iter().filter_map(|o| if let Ofr::V(v) = o { Some(*v) } else { None }));
            let statics: Vec<i64> = basis.iter().map(|o| if let Ofr::C(c) = o { *c } else { mlirformat::Dim::DYNAMIC }).collect();
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
        Self::rebuild(rw, op, at, src, &sources, None);
        true
    }
}
