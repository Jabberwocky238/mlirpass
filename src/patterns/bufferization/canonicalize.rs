//! `bufferization`: folds and canonicalization patterns, as `BufferizationOps.cpp`.

use alloc::vec::Vec;

use mlirformat::{Dim, Shaped, Type};

use crate::{Body, Def, EffectKind, Fold, Folded, OpData, OpId, Rewriter, Trait, ValueId};

/// `bufferization` canonicalization: its rewrite patterns and folds.
pub struct BufferizationCanon;

#[crate::patterns]
impl BufferizationCanon {
    /// `FoldDimOfAllocTensorOp`: a dynamic size of an `alloc_tensor` is its size operand (or
    /// its copy's dim).
    #[rewrite("tensor.dim")]
    fn fold_dim_of_alloc_tensor_op(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let b = &*rw.body;
        let Some(a) = b.def_named(b[op].operands[0], "bufferization.alloc_tensor") else { return false };
        let Some(i) = b.const_index(b[op].operands[1]) else { return false };
        let dims = b[b[a].results[0]].ty.dims().unwrap_or_default();
        let Some(d) = usize::try_from(i).ok().filter(|i| *i < dims.len()) else { return false };
        if dims[d] != Dim::DYNAMIC {
            return false;
        }
        rw.set_before(op);
        let segs = rw.body.segments(a, "operandSegmentSizes").unwrap_or_default();
        let v = if segs.get(1).copied() == Some(1) {
            let copy = rw.body[a].operands[segs[0]];
            rw.fold_dim(copy, d)
        } else {
            let k = dims[..d].iter().filter(|x| **x == Dim::DYNAMIC).count();
            rw.body[a].operands[k]
        };
        rw.replace_op(op, &[v]);
        true
    }

    /// `ReplaceStaticShapeDims`: constant dynamic sizes made static, through a `tensor.cast`.
    #[rewrite("bufferization.alloc_tensor")]
    fn replace_static_shape_dims(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let b = &*rw.body;
        let segs = b.segments(op, "operandSegmentSizes").unwrap_or_default();
        if segs.get(1).copied() == Some(1) {
            return false;
        }
        let ty = b[b[op].results[0]].ty.clone();
        let Type::Shaped(t) = &ty else { return false };
        let mut shape = t.dims().unwrap_or_default();
        let mut dynamic: Vec<ValueId> = Vec::new();
        let mut at = 0;
        for d in shape.iter_mut() {
            if *d != Dim::DYNAMIC {
                continue;
            }
            let v = b[op].operands[at];
            at += 1;
            match b.const_index(v).or_else(|| b.int_constant(v).map(|c| c as i64)) {
                Some(c) if c >= 0 => *d = c,
                _ => dynamic.push(v),
            }
        }
        let new_ty = Type::Shaped(Shaped { shape: Some(shape.iter().map(|d| Dim::from(*d)).collect()), ..t.clone() });
        if new_ty == ty {
            return false;
        }
        rw.set_before(op);
        let n = rw.create(OpData::build("bufferization.alloc_tensor").operands(&dynamic).segments(&[dynamic.len(), 0, 0]), &[new_ty]);
        let nv = rw.body[n].results[0];
        rw.replace_with(op, OpData::build("tensor.cast").operands(&[nv]), &[ty]);
        true
    }

    /// `DimOfToTensorFolder`: the dim of a `to_tensor` is its buffer's.
    #[rewrite("tensor.dim")]
    fn dim_of_to_tensor_folder(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let b = &*rw.body;
        let Some(t) = b.def_named(b[op].operands[0], "bufferization.to_tensor") else { return false };
        let (buffer, index) = (b[t].operands[0], b[op].operands[1]);
        rw.set_before(op);
        rw.replace_with(op, OpData::build("memref.dim").operands(&[buffer, index]), &[Type::Index]);
        true
    }

    /// `DimOfCastOp`: the dim of a `to_buffer` is its tensor's.
    #[rewrite("memref.dim")]
    fn dim_of_cast_op(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let b = &*rw.body;
        let Some(t) = b.def_named(b[op].operands[0], "bufferization.to_buffer") else { return false };
        let (tensor, index) = (b[t].operands[0], b[op].operands[1]);
        rw.set_before(op);
        rw.replace_with(op, OpData::build("tensor.dim").operands(&[tensor, index]), &[Type::Index]);
        true
    }

    /// `LoadOfToBuffer`: a load of a `to_buffer` is an extract of its tensor.
    #[rewrite("memref.load")]
    fn load_of_to_buffer(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let b = &*rw.body;
        let Some(t) = b.def_named(b[op].operands[0], "bufferization.to_buffer") else { return false };
        let mut operands = alloc::vec![b[t].operands[0]];
        operands.extend(b[op].operands[1..].iter().copied());
        let ty = b[b[op].results[0]].ty.clone();
        rw.set_before(op);
        rw.replace_with(op, OpData::build("tensor.extract").operands(&operands), &[ty]);
        true
    }

    /// `ToBufferOfCast`: a `to_buffer` of a `tensor.cast` of a ranked tensor is a `memref.cast` of
    /// the source's `to_buffer`.
    #[rewrite("bufferization.to_buffer")]
    fn to_buffer_of_cast(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let b = &*rw.body;
        let Some(c) = b.def_named(b[op].operands[0], "tensor.cast") else { return false };
        let src = b[c].operands[0];
        let Type::Shaped(st) = &b[src].ty else { return false };
        if st.shape.is_none() {
            return false;
        }
        let out = b[b[op].results[0]].ty.clone();
        let Type::Shaped(m) = &out else { return false };
        let ty = Type::Shaped(Shaped { shape: st.shape.clone(), elem: st.elem.clone(), ..m.clone() });
        let mut data = OpData::build("bufferization.to_buffer").operands(&[src]);
        if b[op].get("read_only").is_some() {
            data = data.flag("read_only");
        }
        rw.set_before(op);
        let n = rw.create(data, &[ty]);
        let nv = rw.body[n].results[0];
        rw.replace_with(op, OpData::build("memref.cast").operands(&[nv]), &[out]);
        true
    }

    /// `ToBufferToTensorFolding`: `foldToBufferToTensorPair` (no buffer alignment).
    #[rewrite("bufferization.to_buffer")]
    fn to_buffer_to_tensor_folding(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        if rw.body.def_named(rw.body[op].operands[0], "bufferization.to_tensor").is_none() {
            return false;
        }
        let o = crate::BufferizationOptions { buffer_alignment: 0, ..crate::BufferizationOptions::default() };
        rw.set_before(op);
        crate::fold_to_buffer_to_tensor(rw, &o, op)
    }

    /// `SimplifyClones`: a clone whose source or itself is deallocated in its block (and
    /// nothing frees in between) becomes its source (through a `memref.cast`).
    #[rewrite("bufferization.clone")]
    fn simplify_clones(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let b = &*rw.body;
        let out = b[op].results[0];
        if b[out].uses.is_empty() {
            rw.erase_op(op);
            return true;
        }
        let source = b[op].operands[0];
        let (sty, cty) = (b[source].ty.clone(), b[out].ty.clone());
        if sty != cty && !crate::memref_cast_compatible(&sty, &cty) {
            return false;
        }
        let mut canonical = source;
        while let Def::Result(d, 0) = b[canonical].def
            && b.has(d, Trait::ViewLikeOpInterface)
            && let Some(src) = b[d].operands.first()
        {
            canonical = *src;
        }
        let (Some(clone_dealloc), Some(source_dealloc)) = (b.find_dealloc(out), b.find_dealloc(canonical)) else { return false };
        if let (Some(c), Some(s)) = (clone_dealloc, source_dealloc)
            && b[c].parent == b[s].parent
        {
            return false;
        }
        let block = b[op].parent;
        let Some(redundant) = clone_dealloc.filter(|c| b[*c].parent == block).or(source_dealloc.filter(|s| b[*s].parent == block)) else { return false };
        let ops = &b[block.expect("placed")].ops;
        let Some(at) = ops.iter().position(|o| *o == op) else { return false };
        let Some(end) = ops.iter().position(|o| *o == redundant).filter(|e| *e > at) else { return false };
        if ops[at + 1..end].iter().any(|o| b.has_effect(*o, EffectKind::Free)) {
            return false;
        }
        rw.set_before(op);
        let v = if sty == cty {
            source
        } else {
            let c = rw.create(OpData::build("memref.cast").operands(&[source]), &[cty]);
            rw.body[c].results[0]
        };
        rw.replace_op(op, &[v]);
        rw.erase_op(redundant);
        true
    }

    /// `DeallocRemoveDuplicateDeallocMemrefs`: a memref deallocated once, under the `arith.ori`
    /// of its conditions.
    #[rewrite("bufferization.dealloc")]
    fn dealloc_remove_duplicate_dealloc_memrefs(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let d = Dealloc::of(rw.body, op);
        let (mut memrefs, mut conditions): (Vec<ValueId>, Vec<ValueId>) = (Vec::new(), Vec::new());
        rw.set_before(op);
        for (m, c) in d.memrefs.iter().zip(&d.conditions) {
            match memrefs.iter().position(|x| x == m) {
                Some(k) if conditions[k] != *c => {
                    let o = rw.create(OpData::build("arith.ori").operands(&[conditions[k], *c]), &[rw.body[*c].ty.clone()]);
                    conditions[k] = rw.body[o].results[0];
                }
                Some(_) => {}
                None => {
                    memrefs.push(*m);
                    conditions.push(*c);
                }
            }
        }
        Dealloc::update(rw, op, memrefs, conditions)
    }

    /// `DeallocRemoveDuplicateRetainedMemrefs`: each retained memref once, its updated
    /// condition shared.
    #[rewrite("bufferization.dealloc")]
    fn dealloc_remove_duplicate_retained_memrefs(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let d = Dealloc::of(rw.body, op);
        let mut retained: Vec<ValueId> = Vec::new();
        let mut index = Vec::new();
        for r in &d.retained {
            match retained.iter().position(|x| x == r) {
                Some(k) => index.push(k),
                None => {
                    index.push(retained.len());
                    retained.push(*r);
                }
            }
        }
        if retained.len() == d.retained.len() {
            return false;
        }
        let new = Dealloc { retained, ..d };
        let types = alloc::vec![Type::Integer { signedness: mlirformat::Signedness::Signless, width: 1 }; new.retained.len()];
        rw.set_before(op);
        let n = rw.create(OpData::build("bufferization.dealloc").operands(&new.operands()).segments(&[new.memrefs.len(), new.conditions.len(), new.retained.len()]), &types);
        let results: Vec<ValueId> = index.iter().map(|k| rw.body[n].results[*k]).collect();
        rw.replace_op(op, &results);
        true
    }

    /// `EraseEmptyDealloc`: nothing to deallocate ⇒ every updated condition `false`.
    #[rewrite("bufferization.dealloc")]
    fn erase_empty_dealloc(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        if !Dealloc::of(rw.body, op).memrefs.is_empty() {
            return false;
        }
        let n = rw.body[op].results.len();
        rw.set_before(op);
        let f = rw.create(OpData::build("arith.constant").with("value", mlirformat::Attribute::Bool(false)), &[Type::Integer { signedness: mlirformat::Signedness::Signless, width: 1 }]);
        let v = rw.body[f].results[0];
        rw.replace_op(op, &alloc::vec![v; n]);
        true
    }

    /// `EraseAlwaysFalseDealloc`: memrefs under a `false` condition dropped.
    #[rewrite("bufferization.dealloc")]
    fn erase_always_false_dealloc(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let d = Dealloc::of(rw.body, op);
        let (memrefs, conditions): (Vec<ValueId>, Vec<ValueId>) = d.memrefs.iter().zip(&d.conditions).filter(|(_, c)| rw.body.int_constant(**c) != Some(0)).map(|(m, c)| (*m, *c)).unzip();
        Dealloc::update(rw, op, memrefs, conditions)
    }

    /// `SkipExtractMetadataOfAlloc`: the base buffer of an allocation is the allocation.
    #[rewrite("bufferization.dealloc")]
    fn skip_extract_metadata_of_alloc(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let b = &*rw.body;
        let d = Dealloc::of(b, op);
        let memrefs = d
            .memrefs
            .iter()
            .map(|m| match b.def_named(*m, "memref.extract_strided_metadata") {
                Some(e) => {
                    let a = b[e].operands[0];
                    match b[a].def {
                        Def::Result(alloc, _) if b.effect_on(alloc, EffectKind::Allocate, a) => a,
                        _ => *m,
                    }
                }
                None => *m,
            })
            .collect();
        Dealloc::update(rw, op, memrefs, d.conditions)
    }

    /// `RemoveAllocDeallocPairWhenNoOtherUsers`: an allocation only deallocated here is
    /// erased with its entry.
    #[rewrite("bufferization.dealloc")]
    fn remove_alloc_dealloc_pair_when_no_other_users(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let b = &*rw.body;
        let d = Dealloc::of(b, op);
        let (mut memrefs, mut conditions, mut erase) = (Vec::new(), Vec::new(), Vec::new());
        for (m, c) in d.memrefs.iter().zip(&d.conditions) {
            if let Def::Result(alloc, _) = b[*m].def
                && b.effect_on(alloc, EffectKind::Allocate, *m)
                && b.single_effect_on(alloc, EffectKind::Allocate, *m)
                && b[*m].uses.len() == 1
            {
                erase.push(alloc);
                continue;
            }
            memrefs.push(*m);
            conditions.push(*c);
        }
        if !Dealloc::update(rw, op, memrefs, conditions) {
            return false;
        }
        for a in erase {
            rw.erase_op(a);
        }
        true
    }
}

/// A `bufferization.dealloc`'s operand groups: memrefs, conditions, retained.
struct Dealloc {
    memrefs: Vec<ValueId>,
    conditions: Vec<ValueId>,
    retained: Vec<ValueId>,
}

impl Dealloc {
    fn of(b: &Body<'_>, op: OpId) -> Self {
        let segs = b.segments(op, "operandSegmentSizes").unwrap_or_default();
        let ops = &b[op].operands;
        let (m, c) = (segs.first().copied().unwrap_or(0), segs.get(1).copied().unwrap_or(0));
        Self { memrefs: ops[..m].to_vec(), conditions: ops[m..m + c].to_vec(), retained: ops[m + c..].to_vec() }
    }

    fn operands(&self) -> Vec<ValueId> {
        self.memrefs.iter().chain(&self.conditions).chain(&self.retained).copied().collect()
    }

    /// `updateDeallocIfChanged`: `op` modified in place to deallocate `memrefs` under
    /// `conditions`, when they differ.
    fn update(rw: &mut Rewriter<'_, '_>, op: OpId, memrefs: Vec<ValueId>, conditions: Vec<ValueId>) -> bool {
        let old = Self::of(rw.body, op);
        if old.memrefs == memrefs && old.conditions == conditions {
            return false;
        }
        let new = Self { memrefs, conditions, retained: old.retained };
        let segs = [new.memrefs.len(), new.conditions.len(), new.retained.len()];
        rw.modify(op, |b| {
            b.set_operands(op, new.operands());
            b.set_segments(op, "operandSegmentSizes", &segs);
        });
        true
    }
}

impl Body<'_> {
    /// `getEffectOnValue<kind>`: `op` has a `kind` effect on `v`.
    fn effect_on(&self, op: OpId, kind: EffectKind, v: ValueId) -> bool {
        self.effects_of(op).is_some_and(|e| e.iter().any(|x| x.kind == kind && x.value == Some(v)))
    }

    /// `hasSingleEffect<kind>(op, v)`: every effect of `op` is a `kind` on `v`.
    fn single_effect_on(&self, op: OpId, kind: EffectKind, v: ValueId) -> bool {
        self.effects_of(op).is_some_and(|e| !e.is_empty() && e.iter().all(|x| x.kind == kind && x.value == Some(v)))
    }

    /// `memref::findDealloc`: the one user freeing `v` (`Some(None)` when none); `None` with
    /// several, or a `memref.realloc`.
    pub(crate) fn find_dealloc(&self, v: ValueId) -> Option<Option<OpId>> {
        let mut found = None;
        for u in self[v].uses.iter() {
            if !self.effect_on(u.op, EffectKind::Free, v) {
                continue;
            }
            if self[u.op].name == "memref.realloc" || found.is_some_and(|f| f != u.op) {
                return None;
            }
            found = Some(u.op);
        }
        Some(found)
    }
}

impl BufferizationCanon {
    /// The canonicalization patterns, in the ops' order.
    pub fn canonicalization(set: &mut crate::PatternSet) {
        set.add(FoldDimOfAllocTensorOp).add(ReplaceStaticShapeDims);
        set.add(SimplifyClones);
        set.add(DimOfToTensorFolder);
        set.add(DimOfCastOp).add(LoadOfToBuffer).add(ToBufferOfCast).add(ToBufferToTensorFolding);
        set.add(DeallocRemoveDuplicateDeallocMemrefs).add(DeallocRemoveDuplicateRetainedMemrefs).add(EraseEmptyDealloc);
        set.add(EraseAlwaysFalseDealloc).add(SkipExtractMetadataOfAlloc).add(RemoveAllocDeallocPairWhenNoOtherUsers);
    }

    /// `CloneOp::fold`, `ToTensorOp::fold` and `ToBufferOp::fold`.
    pub fn fold<'a>(b: &mut Body<'a>, op: OpId) -> Fold<'a> {
        if b[op].name == "bufferization.clone" {
            return if b.fold_memref_cast(op, None) { Fold::InPlace } else { Fold::Failed };
        }
        match &*b[op].name {
            // A `to_buffer` right before it in its block.
            "bufferization.to_tensor" => match b[b[op].operands[0]].def {
                Def::Result(m, _) if b[m].name == "bufferization.to_buffer" && b[m].parent.is_some() && b[m].parent == b[op].parent && { let ops = &b[b[m].parent.expect("placed")].ops; ops.iter().position(|o| *o == m).map(|i| i + 1) == ops.iter().position(|o| *o == op) } => Folded::Value(b[m].operands[0]).into(),
                _ => Fold::Failed,
            },
            // A `to_tensor` of a buffer of its type.
            "bufferization.to_buffer" => match b.def_named(b[op].operands[0], "bufferization.to_tensor") {
                Some(t) if b[b[t].operands[0]].ty == b[b[op].results[0]].ty => Folded::Value(b[t].operands[0]).into(),
                _ => Fold::Failed,
            },
            _ => Fold::Failed,
        }
    }
}
