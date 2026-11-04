//! The `tensor` dialect's op interfaces.

use alloc::vec;
use alloc::vec::Vec;

use mlirformat::Dim;

use crate::{AffineExpr, AffineMap, Body, DialectInliner, InlineAll, MemrefOfr as Ofr, OpId, OpInterfaces, Rewriter};

/// The `tensor` dialect.
pub struct TensorDialect;

impl OpInterfaces for TensorDialect {
    fn namespace(&self) -> &str {
        "tensor"
    }

    /// Ops inline, and into regions (`TensorInlinerInterface`).
    fn inliner(&self) -> Option<&dyn DialectInliner> {
        Some(&InlineAll { calls: false, regions: true })
    }

    fn speculatability(&self, b: &Body<'_>, op: OpId) -> Option<bool> {
        if b[op].name == "tensor.dim" { b.dim_speculatability(op) } else { None }
    }

    fn reify<'a>(&self, rw: &mut Rewriter<'_, 'a>, op: OpId) -> Option<Vec<Vec<Ofr>>> {
        let b = &*rw.body;
        let dims = b[*b[op].results.first()?].ty.dims()?;
        let sizes = match &*b[op].name {
            // `EmptyOp`, `GenerateOp`, `SplatOp::reifyResultShapes`: the dynamic sizes are operands.
            "tensor.empty" | "tensor.generate" => Ofr::mixed(&dims, &b[op].operands),
            "tensor.splat" => Ofr::mixed(&dims, &b[op].operands[1..]),
            // `ReifyExpandShapeOp`: `getMixedOutputShape`.
            "tensor.expand_shape" => Ofr::mixed(&b.dense_i64(op, "static_output_shape"), &b[op].operands[1..]),
            "tensor.extract_slice" => Self::slice_sizes(b, op, &dims),
            // `InsertSliceOp::reifyResultShapes`: the destination's sizes.
            "tensor.insert_slice" => {
                let dest = b[op].operands[1];
                rw.mixed_sizes(dest)
            }
            "tensor.pad" => Self::pad(rw, op, &dims),
            "tensor.collapse_shape" => Self::collapse(rw, op, &dims),
            _ => return None,
        };
        Some(vec![sizes])
    }
}

impl TensorDialect {
    /// `ExtractSliceOp::reifyResultShapes`: its sizes but those `getDroppedDims` drops (a 1 the
    /// result does not keep).
    fn slice_sizes(b: &Body<'_>, op: OpId, result: &[i64]) -> Vec<Ofr> {
        let mut at = 0;
        b.slice_lists(op)[1]
            .iter()
            .filter(|s| {
                let kept = b.ofr_int(**s) != Some(1) || result.get(at) == Some(&1);
                at += usize::from(kept);
                kept
            })
            .copied()
            .collect()
    }

    /// `PadOp::reifyResultShapes` (its own, not the `ReifyPadOp` external model): a dynamic size is
    /// the source's plus both pads (`d0 + d1 + d2`, composed and folded).
    fn pad(rw: &mut Rewriter<'_, '_>, op: OpId, result: &[i64]) -> Vec<Ofr> {
        let src = rw.body[op].operands[0];
        let [low, high] = rw.body.pad_lists(op);
        let sum = AffineMap { dims: 3, syms: 0, results: vec![AffineExpr::Dim(0).add(AffineExpr::Dim(1)).add(AffineExpr::Dim(2))] };
        (0..result.len())
            .map(|i| {
                if result[i] != Dim::DYNAMIC {
                    return Ofr::C(result[i]);
                }
                let d = rw.fold_dim(src, i);
                rw.composed_folded_apply(sum.clone(), &[Ofr::V(d), low[i], high[i]])
            })
            .collect()
    }

    /// `ReifyCollapseShapeOp` (`getCollapsedOutputDimFromInputShape`): a dynamic size is the
    /// product of the source's sizes in its group (`s0 * s1 * ..`, composed, not folded).
    fn collapse(rw: &mut Rewriter<'_, '_>, op: OpId, result: &[i64]) -> Vec<Ofr> {
        let src = rw.body[op].operands[0];
        let groups = rw.body.reassociation(op);
        (0..result.len())
            .map(|i| {
                if result[i] != Dim::DYNAMIC {
                    return Ofr::C(result[i]);
                }
                let group = &groups[i];
                let (start, end) = (*group.first().expect("a group") as usize, *group.last().expect("a group") as usize);
                let mut expr: Option<AffineExpr> = None;
                let mut operands = Vec::new();
                for d in start..=end {
                    operands.push(Ofr::V(rw.fold_dim(src, d)));
                    let s = AffineExpr::Sym((d - start) as u32);
                    expr = Some(match expr {
                        Some(e) => e.mul(s),
                        None => s,
                    });
                }
                let map = AffineMap { dims: 0, syms: (end - start + 1) as u32, results: vec![expr.expect("a non-empty group")] };
                Ofr::V(rw.composed_apply(map, &operands))
            })
            .collect()
    }
}
