//! `memref`: folds, as `MemRefOps.cpp`.

use alloc::format;
use alloc::vec::Vec;

use mlirformat::{Attribute, Dim, ShapedKind, Type};

use crate::{Body, Const, Def, Fold, Folded, LlvmOptions, OpData, OpId, ValueId, DYNAMIC};

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

fn index_attr<'a>(v: i64) -> Attribute<'a> {
    Attribute::Int { lit: format!("{v}").into(), ty: Some(Type::Index) }
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

    /// A shaped type's dims, `DYNAMIC` for `?`.
    pub fn dims_of(&self, v: ValueId) -> Option<Vec<i64>> {
        Some(crate::attr::shape_of(&self[v].ty)?.iter().map(|d| if let Dim::Static(n) = d { *n } else { DYNAMIC }).collect())
    }

    pub fn dense_i64(&self, op: OpId, name: &str) -> Vec<i64> {
        match self[op].get(name) {
            Some(Attribute::DenseArray { values, .. }) => values.iter().map(|v| v.parse().unwrap_or(0)).collect(),
            _ => Vec::new(),
        }
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
            out[k] = self.dense_i64(op, name).into_iter().map(|s| if s == DYNAMIC { Ofr::V(*d.next().expect("dynamic")) } else { Ofr::C(s) }).collect();
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
        let orig: Vec<i64> = self.mixed_osz(op)[1].iter().map(|s| self.ofr_int(*s).unwrap_or(DYNAMIC)).collect();
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
        "memref.rank" => match crate::attr::shape_of(&b[b[op].operands[0]].ty) {
            Some(s) => Folded::Attr(index_attr(s.len() as i64)).into(),
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
            let static_shape = b.dims_of(res).is_some_and(|d| !d.contains(&DYNAMIC));
            if b[src].ty == b[res].ty && static_shape && b.ofr_int(Ofr::V(b[op].operands[1])) == Some(0) {
                return Folded::Value(src).into();
            }
            Fold::Failed
        }
        "memref.extract_strided_metadata" => fold_extract_strided_metadata(b, op),
        _ => Fold::Failed,
    }
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
    if dims[i] != DYNAMIC {
        return Folded::Attr(index_attr(dims[i])).into();
    }
    let dyn_index = dims[..i].iter().filter(|d| **d == DYNAMIC).count();
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
    let static_shape = b.dims_of(res).is_some_and(|d| !d.contains(&DYNAMIC));
    if static_shape && b[src].ty == b[res].ty && b.dense_i64(op, "static_offsets").first() == Some(&0) {
        return Folded::Value(src).into();
    }
    Fold::Failed
}

fn fold_subview<'a>(b: &mut Body<'a>, op: OpId) -> Fold<'a> {
    let (src, res) = (b[op].operands[0], b[op].results[0]);
    let static_layout = |t: &Type<'_>| match t {
        Type::Shaped(s) => LlvmOptions::default().strides_and_offset(s).is_some_and(|(st, o)| !st.contains(&DYNAMIC) && o != DYNAMIC) || !s.extras.iter().any(|a| matches!(a, Attribute::Builtin { name, .. } if name == "strided")),
        _ => false,
    };
    let static_shape = b.dims_of(res).is_some_and(|d| !d.contains(&DYNAMIC));
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
    let Some((strides, offset)) = LlvmOptions::default().strides_and_offset(&s) else { return Fold::Failed };
    let dims = b.dims_of(src).unwrap_or_default();
    let rank = dims.len();
    let results = b[op].results.clone();
    let mut known: Vec<(ValueId, i64)> = Vec::new();
    let mut constify = |v: ValueId, st: i64| {
        if st != DYNAMIC {
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
        let k = b.create(OpData::build("arith.constant").with("value", index_attr(c)), &[Type::Index]);
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
