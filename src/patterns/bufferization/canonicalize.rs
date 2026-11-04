//! `bufferization`: folds and canonicalization patterns, as `BufferizationOps.cpp`.

use alloc::vec::Vec;

use mlirformat::{Dim, Shaped, Type};

use crate::{Body, Def, Fold, Folded, OpData, OpId, Rewriter, ValueId};

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
}

impl BufferizationCanon {
    /// The canonicalization patterns, in the ops' order.
    pub fn canonicalization(set: &mut crate::PatternSet) {
        set.add(FoldDimOfAllocTensorOp).add(ReplaceStaticShapeDims);
        set.add(DimOfToTensorFolder);
        set.add(DimOfCastOp).add(LoadOfToBuffer).add(ToBufferOfCast).add(ToBufferToTensorFolding);
    }

    /// `ToTensorOp::fold` and `ToBufferOp::fold`.
    pub fn fold<'a>(b: &mut Body<'a>, op: OpId) -> Fold<'a> {
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
