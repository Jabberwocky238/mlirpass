//! `memref`: folds, as `MemRefOps.cpp`.

use alloc::vec::Vec;

use mlirformat::{arith, Attribute, Dim, ShapedKind, StridedLayout, Type};

use crate::{Body, Const, Def, Fold, Folded, MemrefLayout, OpData, OpId, ValueId};

/// `MemRefDialect::materializeConstant`.
pub fn materialize<'a>(value: &Attribute<'a>, ty: &Type<'a>) -> Option<OpData<'a>> {
    super::arith::materialize(value, ty)
}

/// An `OpFoldResult` of offsets, sizes and strides.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Ofr {
    C(i64),
    V(ValueId),
}

impl<'a> Body<'a> {
    pub fn is_ranked_memref(&self, v: ValueId) -> bool {
        matches!(&self[v].ty, Type::Shaped(s) if s.kind == ShapedKind::MemRef && s.shape.is_some())
    }

    /// `memref::foldMemRefCast(op, inner)`: casts from ranked memrefs fold into `op`.
    pub fn fold_memref_cast(&mut self, op: OpId, inner: Option<ValueId>) -> bool {
        let mut folded = false;
        for i in 0..self[op].operands.len() {
            let v = self[op].operands[i];
            let Some(c) = self.def_named(v, "memref.cast") else { continue };
            let src = self[c].operands[0];
            if Some(v) != inner && self.is_ranked_memref(src) {
                self.set_operand(op, i, src);
                folded = true;
            }
        }
        folded
    }

    /// A shaped type's dims, `Dim::DYNAMIC` for `?`.
    pub fn dims_of(&self, v: ValueId) -> Option<Vec<i64>> {
        self[v].ty.dims()
    }

    pub fn dense_i64(&self, op: OpId, name: &str) -> Vec<i64> {
        self[op].get(name).and_then(Attribute::dense_values).unwrap_or_default()
    }

    /// The mixed `offsets`, `sizes` and `strides` of a subview / reinterpret_cast: operand
    /// groups 1, 2, 3 against `static_*`.
    pub fn mixed_osz(&self, op: OpId) -> [Vec<Ofr>; 3] {
        let segs = self.segments(op, "operandSegmentSizes").unwrap_or_default();
        let mut at = segs.first().copied().unwrap_or(1);
        let names = ["static_offsets", "static_sizes", "static_strides"];
        let mut out: [Vec<Ofr>; 3] = Default::default();
        for (k, name) in names.iter().enumerate() {
            let n = segs.get(k + 1).copied().unwrap_or(0);
            let mut d = self[op].operands[at..at + n].iter();
            out[k] = self.dense_i64(op, name).into_iter().map(|s| if s == Dim::DYNAMIC { Ofr::V(*d.next().expect("dynamic")) } else { Ofr::C(s) }).collect();
            at += n;
        }
        out
    }

    pub fn ofr_int(&self, o: Ofr) -> Option<i64> {
        match o {
            Ofr::C(c) => Some(c),
            Ofr::V(v) => {
                let c = Const::try_from(&self.constant_of(v)?).ok().filter(|c| !c.elements)?;
                Some(c.as_int()?.signed() as i64)
            }
        }
    }

    /// `getDroppedDims` of a subview, as `computeRankReductionMask` over its sizes.
    pub fn subview_dropped_dims(&self, op: OpId) -> Vec<bool> {
        let Some(res) = self.dims_of(self[op].results[0]) else { return Vec::new() };
        let orig: Vec<i64> = self.mixed_osz(op)[1].iter().map(|s| self.ofr_int(*s).unwrap_or(Dim::DYNAMIC)).collect();
        let mut dropped = alloc::vec![false; orig.len()];
        let mut j = 0;
        for (i, o) in orig.iter().enumerate() {
            if j < res.len() && *o == res[j] {
                j += 1;
                continue;
            }
            dropped[i] = true;
        }
        dropped
    }
}

/// The fold of a `memref` op.
pub fn fold<'a>(b: &mut Body<'a>, op: OpId) -> Fold<'a> {
    let name = b[op].name.clone();
    match &*name {
        "memref.assume_alignment" => {
            let src = b[op].operands[0];
            match b.def_named(src, "memref.assume_alignment") {
                Some(p) if b[p].get("alignment") == b[op].get("alignment") => Folded::Value(src).into(),
                _ => Fold::Failed,
            }
        }
        "memref.cast" | "memref.dealloc" | "memref.load" | "memref.prefetch" => in_place(b.fold_memref_cast(op, None)),
        "memref.store" => {
            let v = b[op].operands[0];
            in_place(b.fold_memref_cast(op, Some(v)))
        }
        "memref.atomic_rmw" => {
            let v = b[op].operands[0];
            in_place(b.fold_memref_cast(op, Some(v)))
        }
        "memref.copy" => {
            for i in 0..b[op].operands.len() {
                let v = b[op].operands[i];
                if let Some(c) = b.def_named(v, "memref.cast") {
                    let src = b[c].operands[0];
                    if crate::canon::memref_cast_foldable(&b[src].ty, &b[v].ty) {
                        b.set_operand(op, i, src);
                        return Fold::InPlace;
                    }
                }
            }
            Fold::Failed
        }
        "memref.dim" => fold_dim(b, op),
        "memref.rank" => match b[b[op].operands[0]].ty.shape() {
            Some(s) => Folded::Attr(Attribute::index(s.len() as i64)).into(),
            None => Fold::Failed,
        },
        "memref.memory_space_cast" => match b.def_named(b[op].operands[0], "memref.memory_space_cast") {
            Some(p) => {
                let s = b[p].operands[0];
                b.set_operand(op, 0, s);
                Fold::InPlace
            }
            None => Fold::Failed,
        },
        "memref.reinterpret_cast" => fold_reinterpret_cast(b, op),
        "memref.expand_shape" => b.fold_reshape(op, "memref.collapse_shape", None),
        "memref.collapse_shape" => b.fold_reshape(op, "memref.expand_shape", None),
        "memref.subview" => fold_subview(b, op),
        "memref.view" => {
            let (src, res) = (b[op].operands[0], b[op].results[0]);
            let static_shape = b.dims_of(res).is_some_and(|d| !d.contains(&Dim::DYNAMIC));
            if b[src].ty == b[res].ty && static_shape && b.ofr_int(Ofr::V(b[op].operands[1])) == Some(0) {
                return Folded::Value(src).into();
            }
            Fold::Failed
        }
        "memref.extract_strided_metadata" => fold_extract_strided_metadata(b, op),
        "memref.transpose" => fold_transpose(b, op),
        _ => Fold::Failed,
    }
}

/// `TransposeOp::fold`: an identity of the same type is its input; a transpose of a
/// transpose takes the inner one's input with the composed permutation.
fn fold_transpose<'a>(b: &mut Body<'a>, op: OpId) -> Fold<'a> {
    let (src, res) = (b[op].operands[0], b[op].results[0]);
    let Some(perm) = b.affine_map(op, "permutation") else { return Fold::Failed };
    if perm.is_identity() && b[src].ty == b[res].ty {
        return Folded::Value(src).into();
    }
    let Some(inner) = b.def_named(src, "memref.transpose") else { return Fold::Failed };
    let Some(other) = b.affine_map(inner, "permutation") else { return Fold::Failed };
    let composed = perm.compose(&other);
    let input = b[inner].operands[0];
    b.set_operand(op, 0, input);
    b[op].set("permutation", Attribute::from(&composed));
    Fold::InPlace
}

fn in_place<'a>(changed: bool) -> Fold<'a> {
    if changed { Fold::InPlace } else { Fold::Failed }
}

fn fold_dim<'a>(b: &mut Body<'a>, op: OpId) -> Fold<'a> {
    let Some(index) = b.ofr_int(Ofr::V(b[op].operands[1])) else { return Fold::Failed };
    let src = b[op].operands[0];
    let Some(dims) = b.dims_of(src).filter(|_| b.is_ranked_memref(src)) else { return Fold::Failed };
    if index < 0 || index as usize >= dims.len() {
        return Fold::Failed;
    }
    let i = index as usize;
    if dims[i] != Dim::DYNAMIC {
        return Folded::Attr(Attribute::index(dims[i])).into();
    }
    let dyn_index = dims[..i].iter().filter(|d| **d == Dim::DYNAMIC).count();
    if let Def::Result(d, _) = b[src].def {
        match &*b[d].name {
            "memref.alloc" | "memref.alloca" => return Folded::Value(b[d].operands[dyn_index]).into(),
            "memref.view" => return Folded::Value(b[d].operands[2 + dyn_index]).into(),
            "memref.subview" => {
                let dropped = b.subview_dropped_dims(d);
                let mut ri = 0;
                let mut si = 0;
                for (k, dr) in dropped.iter().enumerate() {
                    if *dr {
                        continue;
                    }
                    if ri == i {
                        si = k;
                        break;
                    }
                    ri += 1;
                }
                if let Ofr::V(v) = b.mixed_osz(d)[1][si] {
                    return Folded::Value(v).into();
                }
                return Fold::Failed;
            }
            _ => {}
        }
    }
    in_place(b.fold_memref_cast(op, None))
}

fn fold_reinterpret_cast<'a>(b: &mut Body<'a>, op: OpId) -> Fold<'a> {
    let src = b[op].operands[0];
    let prev = if let Some(p) = b.def_named(src, "memref.reinterpret_cast") {
        Some(b[p].operands[0])
    } else if let Some(p) = b.def_named(src, "memref.cast") {
        Some(b[p].operands[0])
    } else if let Some(p) = b.def_named(src, "memref.subview") {
        b.mixed_osz(p)[0].iter().all(|o| b.ofr_int(*o) == Some(0)).then(|| b[p].operands[0])
    } else {
        None
    };
    if let Some(p) = prev {
        b.set_operand(op, 0, p);
        return Fold::InPlace;
    }
    let res = b[op].results[0];
    let static_shape = b.dims_of(res).is_some_and(|d| !d.contains(&Dim::DYNAMIC));
    if static_shape && b[src].ty == b[res].ty && b.dense_i64(op, "static_offsets").first() == Some(&0) {
        return Folded::Value(src).into();
    }
    Fold::Failed
}

fn fold_subview<'a>(b: &mut Body<'a>, op: OpId) -> Fold<'a> {
    let (src, res) = (b[op].operands[0], b[op].results[0]);
    let static_layout = |t: &Type<'_>| match t {
        Type::Shaped(s) => s.strides_and_offset().is_some_and(|(st, o)| !st.contains(&Dim::DYNAMIC) && o != Dim::DYNAMIC) || !s.extras.iter().any(|a| matches!(a, Attribute::Builtin { name, .. } if name == "strided")),
        _ => false,
    };
    let static_shape = b.dims_of(res).is_some_and(|d| !d.contains(&Dim::DYNAMIC));
    if b[src].ty == b[res].ty && static_shape && static_layout(&b[res].ty) {
        return Folded::Value(src).into();
    }
    if let Some(p) = b.def_named(src, "memref.subview") {
        let [offs, sizes, strides] = b.mixed_osz(op);
        let psizes = &b.mixed_osz(p)[1];
        let zero = offs.iter().all(|o| b.ofr_int(*o) == Some(0));
        let one = strides.iter().all(|o| b.ofr_int(*o) == Some(1));
        if zero && one && sizes == *psizes && b[src].ty == b[res].ty {
            return Folded::Value(src).into();
        }
    }
    Fold::Failed
}

/// `ExtractStridedMetadataOp::fold`: results the source type knows statically are replaced
/// by constants, and a ranked `memref.cast` source folds.
fn fold_extract_strided_metadata<'a>(b: &mut Body<'a>, op: OpId) -> Fold<'a> {
    let src = b[op].operands[0];
    let Type::Shaped(s) = b[src].ty.clone() else { return Fold::Failed };
    let Some((strides, offset)) = s.strides_and_offset() else { return Fold::Failed };
    let dims = b.dims_of(src).unwrap_or_default();
    let rank = dims.len();
    let results = b[op].results.clone();
    let mut known: Vec<(ValueId, i64)> = Vec::new();
    let mut constify = |v: ValueId, st: i64| {
        if st != Dim::DYNAMIC {
            known.push((v, st));
        } else if let Some(c) = b.ofr_int(Ofr::V(v)) {
            known.push((v, c));
        }
    };
    constify(results[1], offset);
    for i in 0..rank {
        constify(results[2 + i], dims[i]);
    }
    for i in 0..rank {
        constify(results[2 + rank + i], strides[i]);
    }
    let mut changed = false;
    for (v, c) in known {
        // `replaceConstantUsesOf`: unused results and constants already in place stay.
        if b[v].uses.is_empty() {
            continue;
        }
        let k = b.emit(&arith::Constant::new(Attribute::index(c), Type::Index));
        b.insert_before(k, op);
        let kv = b[k].results[0];
        for u in b[v].uses.clone().into_iter().rev() {
            b.set_operand(u.op, u.index as usize, kv);
            changed = true;
        }
    }
    if let Some(c) = b.def_named(src, "memref.cast")
        && b.is_ranked_memref(b[c].operands[0])
    {
        let s = b[c].operands[0];
        b.set_operand(op, 0, s);
        changed = true;
    }
    in_place(changed)
}

rewrites! {
    /// `AllocaScopeInliner`: a scope that allocates nothing (or that ends its parent scope)
    /// goes, its body inlined.
    AllocaScopeInliner("memref.alloca_scope", 1) |rw, op| {
        let b = &*rw.body;
        // `isOpItselfPotentialAutomaticAllocation`, pre-order, not entering nested scopes.
        let children = |o: OpId| -> Vec<OpId> { b[o].regions.iter().flat_map(|r| &b[*r].blocks).flat_map(|k| b[*k].ops.iter().copied()).collect() };
        let mut work: Vec<OpId> = children(op);
        let mut potential = false;
        while let Some(o) = work.pop() {
            if !b.has(o, crate::Trait::MemoryEffectOpInterface) || b[o].name == "memref.alloca" {
                potential = true;
                break;
            }
            if !b.has(o, crate::Trait::AutomaticAllocationScope) {
                work.extend(children(o));
            }
        }
        if potential {
            let Some(parent) = b.parent_op(op) else { return false };
            let block = b[op].parent.expect("placed");
            let ops = &b[block].ops;
            let last = ops.len() >= 2 && ops[ops.len() - 2] == op;
            if !b.has(parent, crate::Trait::AutomaticAllocationScope) || !last {
                return false;
            }
        }
        let block = b[b[op].regions[0]].blocks[0];
        let term = *b[block].ops.last().expect("terminator");
        let results = b[term].operands.clone();
        let parent = b[op].parent.expect("placed");
        rw.inline_block_before(block, parent, Some(op), &[]);
        rw.replace_op(op, &results);
        rw.erase_op(term);
        true
    }
}

rewrites! {
    /// `OpWithOffsetSizesAndStridesConstantArgumentFolder<SubViewOp>`: constant offsets, sizes
    /// and strides made static; the new subview's type inferred, cast back to the old one.
    SubViewConstantArguments("memref.subview", 1) |rw, op| {
        let b = &*rw.body;
        let [mut o, mut s, mut t] = b.slice_lists(op);
        let sizes = s.clone();
        let changed = [Ofr::fold_list(b, &mut o, true, false), Ofr::fold_list(b, &mut s, true, false), Ofr::fold_list(b, &mut t, false, false)];
        if !changed.contains(&true) {
            return false;
        }
        let src = b[op].operands[0];
        let (Type::Shaped(st), rt) = (b[src].ty.clone(), b[b[op].results[0]].ty.clone()) else { return false };
        let dims = |t: &Type<'_>| t.shape().map(|d| d.iter().map(|d| if let Dim::Static(n) = d { *n } else { Dim::DYNAMIC }).collect::<Vec<_>>()).unwrap_or_default();
        if !Ofr::in_bounds(&dims(&b[src].ty), &o, &s, &t) {
            return false;
        }
        let Some(ty) = Ofr::subview_type(&st, &o, &s, &t, &Ofr::dropped(&sizes, &dims(&rt))) else { return false };
        let lists = [o, s, t];
        rw.set_before(op);
        let new = rw.create(OpData::sliced("memref.subview", &[src], &lists), &[ty]);
        let new = rw.body[new].results[0];
        rw.replace_with(op, OpData::build("memref.cast").operands(&[new]), &[rt]);
        true
    }

    /// `TrivialSubViewOpFolder`: no offset, unit strides, the whole source ⇒ the source (cast
    /// when the types differ).
    TrivialSubViewOpFolder("memref.subview", 1) |rw, op| {
        let b = &*rw.body;
        let src = b[op].operands[0];
        let (st, rt) = (b[src].ty.clone(), b[b[op].results[0]].ty.clone());
        let (Some(shape), Some(rshape)) = (st.shape(), rt.shape()) else { return false };
        let [o, s, t] = b.slice_lists(op);
        let trivial = shape.len() == rshape.len()
            && o.iter().all(|x| matches!(x, Ofr::C(0)))
            && t.iter().all(|x| matches!(x, Ofr::C(1)))
            && s.iter().zip(shape).all(|(x, d)| matches!((x, d), (Ofr::C(n), Dim::Static(m)) if n == m));
        if !trivial {
            return false;
        }
        if st == rt {
            rw.replace_op(op, &[src]);
        } else {
            rw.replace_with(op, OpData::build("memref.cast").operands(&[src]), &[rt]);
        }
        true
    }

    /// `SubViewOpMemRefCastFolder`: a subview of a foldable cast takes the cast's source; its
    /// result is cast back.
    SubViewOpMemRefCastFolder("memref.subview", 1) |rw, op| {
        let b = &*rw.body;
        if b[op].operands.iter().any(|v| b.const_index(*v).is_some()) {
            return false;
        }
        let Some(cast) = b.def_named(b[op].operands[0], "memref.cast") else { return false };
        let (from, cur) = (b[cast].operands[0], b[op].operands[0]);
        if !crate::canon::memref_cast_foldable(&b[from].ty, &b[cur].ty) {
            return false;
        }
        let Type::Shaped(st) = b[from].ty.clone() else { return false };
        let rt = b[b[op].results[0]].ty.clone();
        let [o, s, t] = b.slice_lists(op);
        let dims = rt.shape().map(|d| d.iter().map(|d| if let Dim::Static(n) = d { *n } else { Dim::DYNAMIC }).collect::<Vec<_>>()).unwrap_or_default();
        let Some(ty) = Ofr::subview_type(&st, &o, &s, &t, &Ofr::dropped(&s, &dims)) else { return false };
        let mut data = OpData { operands: b[op].operands.clone(), ..OpData::named(b[op].name.clone()) };
        data.properties = b[op].properties.clone();
        data.operands[0] = from;
        rw.set_before(op);
        let new = rw.create(data, &[ty]);
        let new = rw.body[new].results[0];
        rw.replace_with(op, OpData::build("memref.cast").operands(&[new]), &[rt]);
        true
    }
}

/// `SimplifyAllocConst`: constant non-negative dynamic sizes made static; the new alloc cast
/// back to the old type.
fn simplify_alloc_const(rw: &mut crate::Rewriter<'_, '_>, op: OpId) -> bool {
    let b = &*rw.body;
    let segs = b.segments(op, "operandSegmentSizes").unwrap_or_default();
    let n = segs.first().copied().unwrap_or(0);
    let sizes = &b[op].operands[..n];
    let constant = |v: &ValueId| b.ofr_int(Ofr::V(*v)).filter(|c| *c >= 0);
    if !sizes.iter().any(|v| constant(v).is_some()) {
        return false;
    }
    let rt = b[b[op].results[0]].ty.clone();
    let Type::Shaped(s) = &rt else { return false };
    let mut dynamic = Vec::new();
    let mut next = sizes.iter();
    let shape = s.shape.as_ref().map(|dims| dims.iter().map(|d| match d {
        Dim::Dynamic => {
            let v = next.next().expect("a size per dynamic dim");
            match constant(v) {
                Some(c) => Dim::Static(c),
                None => {
                    dynamic.push(*v);
                    Dim::Dynamic
                }
            }
        }
        d => d.clone(),
    }).collect());
    let ty = Type::Shaped(mlirformat::Shaped { shape, ..s.clone() });
    let mut ops = dynamic.clone();
    ops.extend(&b[op].operands[n..]);
    let mut data = OpData::build(&b[op].name).operands(&ops).segments(&[dynamic.len(), b[op].operands.len() - n]);
    if let Some(a) = b[op].get("alignment") {
        data.set("alignment", a.clone());
    }
    rw.set_before(op);
    let new = rw.create(data, &[ty]);
    let new = rw.body[new].results[0];
    rw.replace_with(op, OpData::build("memref.cast").operands(&[new]), &[rt]);
    true
}

/// `SimplifyDeadAlloc`: an alloc only stored into and deallocated goes, with those uses.
fn simplify_dead_alloc(rw: &mut crate::Rewriter<'_, '_>, op: OpId) -> bool {
    let b = &*rw.body;
    let v = b[op].results[0];
    let users: Vec<OpId> = b[v].uses.iter().map(|u| u.op).collect();
    let dead = users.iter().zip(&b[v].uses).all(|(u, use_)| match &*b[*u].name {
        "memref.store" => use_.index != 0,
        "memref.dealloc" => true,
        _ => false,
    });
    if !dead {
        return false;
    }
    let mut seen = Vec::new();
    for u in users {
        if !seen.contains(&u) {
            seen.push(u);
            rw.erase_op(u);
        }
    }
    rw.erase_op(op);
    true
}

rewrites! {
    /// `SimplifyAllocConst<AllocOp>`.
    SimplifyAllocConst("memref.alloc", 1) |rw, op| { simplify_alloc_const(rw, op) }
    /// `SimplifyDeadAlloc<AllocOp>`.
    SimplifyDeadAlloc("memref.alloc", 1) |rw, op| { simplify_dead_alloc(rw, op) }
    /// `SimplifyAllocConst<AllocaOp>`.
    SimplifyAllocaConst("memref.alloca", 1) |rw, op| { simplify_alloc_const(rw, op) }
    /// `SimplifyDeadAlloc<AllocaOp>`.
    SimplifyDeadAlloca("memref.alloca", 1) |rw, op| { simplify_dead_alloc(rw, op) }
}

rewrites! {
    /// `FoldEmptyCopy`: a copy of or into a memref with a zero dimension goes.
    FoldEmptyCopy("memref.copy", 1) |rw, op| {
        let b = &*rw.body;
        let empty = |v: &ValueId| b[*v].ty.shape().is_some_and(|d| d.contains(&Dim::Static(0)));
        if !b[op].operands.iter().any(empty) {
            return false;
        }
        rw.erase_op(op);
        true
    }

    /// `FoldSelfCopy`: a copy of a memref into itself goes.
    FoldSelfCopy("memref.copy", 1) |rw, op| {
        if rw.body[op].operands[0] != rw.body[op].operands[1] {
            return false;
        }
        rw.erase_op(op);
        true
    }

    /// `DimOfMemRefReshape`: the dim of a `memref.reshape` loaded from its shape, right after it,
    /// when the index is known there.
    DimOfMemRefReshape("memref.dim", 1) |rw, op| {
        let b = &*rw.body;
        let Some(reshape) = b.def_named(b[op].operands[0], "memref.reshape") else { return false };
        let idx = b[op].operands[1];
        let rblock = b[reshape].parent;
        let idx_block = match b[idx].def {
            Def::Result(d, _) => b[d].parent,
            Def::Arg(blk, _) => Some(blk),
        };
        if idx_block == rblock {
            if let Some(d) = b.def_op(idx) && b.position(reshape) < b.position(d) {
                return false;
            }
        } else if b[op].parent != rblock {
            let (Some(ib), Some(rb)) = (idx_block, rblock) else { return false };
            let (Some(ir), Some(mut r)) = (b[ib].parent, b[rb].parent) else { return false };
            // Whether the index's region is a proper ancestor of the reshape's.
            let mut ancestor = false;
            while let Some(up) = b[b[r].parent].parent.and_then(|blk| b[blk].parent) {
                if up == ir {
                    ancestor = true;
                    break;
                }
                r = up;
            }
            if !ancestor {
                return false;
            }
        }
        let shape = b[reshape].operands[1];
        let elem = b[shape].ty.element_type().clone();
        let ty = b[b[op].results[0]].ty.clone();
        rw.set_after(reshape);
        let load = rw.create(OpData::build("memref.load").operands(&[shape, idx]), &[elem.clone()]);
        let mut v = rw.body[load].results[0];
        if elem != ty {
            let c = rw.create(OpData::build("arith.index_cast").operands(&[v]), &[ty]);
            v = rw.body[c].results[0];
        }
        rw.replace_op(op, &[v]);
        true
    }

    /// `CollapseShapeOpMemRefCastFolder`, for a cast from an identity layout: the collapse takes
    /// the cast's source (and is cast back when its type changes).
    CollapseShapeOpMemRefCastFolder("memref.collapse_shape", 1) |rw, op| {
        let b = &*rw.body;
        let Some(cast) = b.def_named(b[op].operands[0], "memref.cast") else { return false };
        let (from, cur) = (b[cast].operands[0], b[op].operands[0]);
        if !crate::canon::memref_cast_foldable(&b[from].ty, &b[cur].ty) {
            return false;
        }
        let Type::Shaped(st) = &b[from].ty else { return false };
        if !st.identity_layout() {
            return false;
        }
        let r = b.reassociation(op);
        let dims: Vec<Dim> = st.shape.clone().unwrap_or_default();
        let mut at = 0;
        let mut shape = Vec::new();
        for g in &r {
            let band = &dims[at..at + g.len()];
            shape.push(if band.iter().any(|d| !matches!(d, Dim::Static(_))) { Dim::Dynamic } else { Dim::Static(band.iter().map(|d| if let Dim::Static(n) = d { *n } else { 1 }).product()) });
            at += g.len();
        }
        let ty = Type::Shaped(mlirformat::Shaped { shape: Some(shape), ..st.clone() });
        let rt = b[b[op].results[0]].ty.clone();
        if ty == rt {
            rw.modify(op, |b| b.set_operand(op, 0, from));
        } else {
            let data = OpData { operands: alloc::vec![from], properties: b[op].properties.clone(), ..OpData::build("memref.collapse_shape") };
            rw.set_before(op);
            let new = rw.create(data, &[ty]);
            let new = rw.body[new].results[0];
            rw.replace_with(op, OpData::build("memref.cast").operands(&[new]), &[rt]);
        }
        true
    }
}

rewrites! {
    /// `ExpandShapeOpMemRefCastFolder`, for a cast from an identity layout: constant output sizes
    /// made static, the expansion of the cast's source (cast back when its type changes).
    ExpandShapeOpMemRefCastFolder("memref.expand_shape", 1) |rw, op| {
        let b = &*rw.body;
        let Some(cast) = b.def_named(b[op].operands[0], "memref.cast") else { return false };
        let (from, cur) = (b[cast].operands[0], b[op].operands[0]);
        if !crate::canon::memref_cast_foldable(&b[from].ty, &b[cur].ty) {
            return false;
        }
        let Type::Shaped(st) = &b[from].ty else { return false };
        if !st.identity_layout() {
            return false;
        }
        let mut shape = b.mixed_output_shape(op);
        for o in shape.iter_mut() {
            if let Some(c) = b.ofr_int(*o) {
                *o = Ofr::C(c);
            }
        }
        let r = b.reassociation(op);
        let src_dims = st.shape.clone().unwrap_or_default();
        let mut at = 0;
        for (g, d) in r.iter().zip(&src_dims) {
            let dynamic = shape[at..at + g.len()].iter().any(|o| matches!(o, Ofr::V(_)));
            if dynamic != matches!(d, Dim::Dynamic) {
                return false;
            }
            at += g.len();
        }
        let dims = shape.iter().map(|o| if let Ofr::C(n) = o { Dim::Static(*n) } else { Dim::Dynamic }).collect();
        let ty = Type::Shaped(mlirformat::Shaped { shape: Some(dims), ..st.clone() });
        let rt = b[b[op].results[0]].ty.clone();
        if ty == rt {
            rw.modify(op, |b| b.set_operand(op, 0, from));
        } else {
            let data = crate::Rewriter::expand_data("memref", from, &r, &shape);
            rw.set_before(op);
            let new = rw.create(data, &[ty]);
            let new = rw.body[new].results[0];
            rw.replace_with(op, OpData::build("memref.cast").operands(&[new]), &[rt]);
        }
        true
    }
}

impl Ofr {
    /// `constifyIndexValues`: the static values of the type first, then constant values.
    fn constify(b: &Body<'_>, list: &mut [Ofr], statics: &[i64]) {
        for (o, s) in list.iter_mut().zip(statics) {
            if *s != Dim::DYNAMIC {
                *o = Ofr::C(*s);
            } else if let Some(c) = b.ofr_int(*o) {
                *o = Ofr::C(c);
            }
        }
    }

    /// A memref's static sizes, strides and offset (`Dim::DYNAMIC` where not).
    fn statics(t: &Type<'_>) -> Option<(Vec<i64>, Vec<i64>, i64)> {
        let Type::Shaped(s) = t else { return None };
        let sizes = s.shape.as_ref()?.iter().map(|d| if let Dim::Static(n) = d { *n } else { Dim::DYNAMIC }).collect();
        let (strides, offset) = s.strides_and_offset()?;
        Some((sizes, strides, offset))
    }
}

/// A `memref.reinterpret_cast`'s constified offset, sizes and strides
/// (`getConstifiedMixed*`, from its result type).
fn reinterpret_lists(b: &Body<'_>, op: OpId) -> Option<[Vec<Ofr>; 3]> {
    let [mut o, mut s, mut t] = b.slice_lists(op);
    let (sizes, strides, offset) = Ofr::statics(&b[b[op].results[0]].ty)?;
    Ofr::constify(b, &mut o, &[offset]);
    Ofr::constify(b, &mut s, &sizes);
    Ofr::constify(b, &mut t, &strides);
    Some([o, s, t])
}

rewrites! {
    /// `ReinterpretCastOpExtractStridedMetadataFolder`: of what `extract_strided_metadata` took
    /// apart, the source itself when nothing changes, else the cast reads that source.
    ReinterpretCastOpExtractStridedMetadataFolder("memref.reinterpret_cast", 1) |rw, op| {
        let b = &*rw.body;
        let Some(meta) = b.def_named(b[op].operands[0], "memref.extract_strided_metadata") else { return false };
        let src = b[meta].operands[0];
        let rank = b[meta].results.len().saturating_sub(2) / 2;
        let Some((sizes, strides, offset)) = Ofr::statics(&b[src].ty) else { return false };
        let r = &b[meta].results;
        let mut mo = alloc::vec![Ofr::V(r[1])];
        let mut ms: Vec<Ofr> = r[2..2 + rank].iter().map(|v| Ofr::V(*v)).collect();
        let mut mt: Vec<Ofr> = r[2 + rank..].iter().map(|v| Ofr::V(*v)).collect();
        Ofr::constify(b, &mut mo, &[offset]);
        Ofr::constify(b, &mut ms, &sizes);
        Ofr::constify(b, &mut mt, &strides);
        let Some([o, s, t]) = reinterpret_lists(b, op) else { return false };
        if (mt, ms, mo) != (t, s, o) {
            rw.modify(op, |b| b.set_operand(op, 0, src));
            return true;
        }
        let rt = b[b[op].results[0]].ty.clone();
        if b[src].ty == rt {
            rw.replace_op(op, &[src]);
        } else {
            rw.replace_with(op, OpData::build("memref.cast").operands(&[src]), &[rt]);
        }
        true
    }

    /// `ReinterpretCastOpConstantFolder`: the constified lists, when they are more static; the
    /// new cast's type `strided` by them, cast back.
    ReinterpretCastOpConstantFolder("memref.reinterpret_cast", 1) |rw, op| {
        let b = &*rw.body;
        let before = b.slice_lists(op).iter().flatten().filter(|o| matches!(o, Ofr::C(_))).count();
        let Some(lists) = reinterpret_lists(b, op) else { return false };
        if lists.iter().flatten().filter(|o| matches!(o, Ofr::C(_))).count() == before {
            return false;
        }
        let src = b[op].operands[0];
        let Type::Shaped(st) = &b[src].ty else { return false };
        let c = |o: &Ofr| if let Ofr::C(c) = o { *c } else { Dim::DYNAMIC };
        let layout = StridedLayout { strides: lists[2].iter().map(c).collect(), offset: c(&lists[0][0]) };
        let mut extras = alloc::vec![layout.into()];
        extras.extend(st.extras.iter().filter(|a| !a.is_layout()).cloned());
        let shape = lists[1].iter().map(|o| if let Ofr::C(n) = o { Dim::Static(*n) } else { Dim::Dynamic }).collect();
        let ty = Type::Shaped(mlirformat::Shaped { kind: ShapedKind::MemRef, shape: Some(shape), elem: st.elem.clone(), extras });
        let rt = b[b[op].results[0]].ty.clone();
        rw.set_before(op);
        let new = rw.create(OpData::sliced("memref.reinterpret_cast", &[src], &lists), &[ty]);
        let new = rw.body[new].results[0];
        rw.replace_with(op, OpData::build("memref.cast").operands(&[new]), &[rt]);
        true
    }
}

impl Ofr {
    /// `computeRankReductionMask`: which of `sizes` the shape `reduced` drops (unit sizes, left
    /// to right).
    fn dropped(sizes: &[Ofr], reduced: &[i64]) -> Vec<bool> {
        let mut j = 0;
        sizes.iter().map(|s| {
            let n = if let Ofr::C(c) = s { *c } else { Dim::DYNAMIC };
            if reduced.get(j) == Some(&n) {
                j += 1;
                false
            } else {
                n == 1
            }
        }).collect()
    }
}

impl Ofr {
    /// `SubViewOp::inferResultType` of memref `src`, then the `dropped` dims taken out
    /// (`SubViewReturnTypeCanonicalizer`): a `strided` layout from the source's.
    fn subview_type<'a>(src: &mlirformat::Shaped<'a>, offsets: &[Ofr], sizes: &[Ofr], strides: &[Ofr], dropped: &[bool]) -> Option<Type<'a>> {
        let (src_strides, src_offset) = src.strides_and_offset()?;
        let c = |o: &Ofr| if let Ofr::C(c) = o { *c } else { Dim::DYNAMIC };
        // `hasValidSizesOffsets`, `hasValidStrides`.
        if offsets.iter().chain(sizes).any(|o| matches!(o, Ofr::C(n) if *n < 0)) || strides.iter().any(|o| matches!(o, Ofr::C(0))) {
            return None;
        }
        let mut offset = src_offset;
        for (o, s) in offsets.iter().map(c).zip(&src_strides) {
            offset = if offset == Dim::DYNAMIC || o == Dim::DYNAMIC || *s == Dim::DYNAMIC { Dim::DYNAMIC } else { offset + o * s };
        }
        let mut shape = Vec::new();
        let mut out_strides = Vec::new();
        for (i, (z, (t, s))) in sizes.iter().map(c).zip(strides.iter().map(c).zip(&src_strides)).enumerate() {
            if dropped.get(i) == Some(&true) {
                continue;
            }
            shape.push(if z == Dim::DYNAMIC { Dim::Dynamic } else { Dim::Static(z) });
            out_strides.push(if t == Dim::DYNAMIC || *s == Dim::DYNAMIC { Dim::DYNAMIC } else { t * s });
        }
        let mut extras = alloc::vec![StridedLayout { strides: out_strides, offset }.into()];
        extras.extend(src.extras.iter().filter(|a| !a.is_layout()).cloned());
        Some(Type::Shaped(mlirformat::Shaped { kind: ShapedKind::MemRef, shape: Some(shape), elem: src.elem.clone(), extras }))
    }
}

pub fn patterns(set: &mut crate::PatternSet) {
    set.add(SimplifyAllocConst).add(SimplifyDeadAlloc).add(SimplifyAllocaConst).add(SimplifyDeadAlloca);
    set.add_boxed(alloc::boxed::Box::new(super::reshape::ComposeReassociative { name: "ComposeExpandOfExpand", dialect: "memref", root: "memref.expand_shape", expand: true }));
    set.add_boxed(alloc::boxed::Box::new(super::reshape::ComposeExpandOfCollapse { name: "ComposeExpandOfCollapseOp", dialect: "memref" }));
    set.add(ExpandShapeOpMemRefCastFolder);
    set.add_boxed(alloc::boxed::Box::new(super::reshape::ComposeReassociative { name: "ComposeCollapseOfCollapse", dialect: "memref", root: "memref.collapse_shape", expand: false }));
    set.add_boxed(alloc::boxed::Box::new(super::reshape::ComposeCollapseOfExpand { name: "ComposeCollapseOfExpandOp", dialect: "memref" }));
    set.add(CollapseShapeOpMemRefCastFolder);
    set.add(ReinterpretCastOpExtractStridedMetadataFolder).add(ReinterpretCastOpConstantFolder);
    set.add(FoldEmptyCopy).add(FoldSelfCopy).add(DimOfMemRefReshape);
    set.add(AllocaScopeInliner);
    set.add(SubViewConstantArguments).add(SubViewOpMemRefCastFolder).add(TrivialSubViewOpFolder);
}
