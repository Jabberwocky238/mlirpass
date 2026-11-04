//! `resolve-ranked-shaped-type-result-dims`' rules, as `ResolveShapedTypeResultDims.cpp`: a
//! `tensor.dim` / `memref.dim` of an op's result is the size the op reifies for it
//! (`ReifyRankedShapedTypeOpInterface`); one of an `scf.forall`'s shared output is one of its init.

use crate::{Def, OpId, Rewriter};

/// `populateResolveRankedShapedTypeResultDimsPatterns`.
pub struct ResolveDims;

#[crate::patterns]
impl ResolveDims {
    /// `DimOfReifyRankedShapedTypeOpInterface<memref::DimOp>`.
    #[rewrite("memref.dim")]
    fn dim_of_reify_memref(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        Self::reified(rw, op)
    }

    /// `DimOfReifyRankedShapedTypeOpInterface<tensor::DimOp>`.
    #[rewrite("tensor.dim")]
    fn dim_of_reify_tensor(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        Self::reified(rw, op)
    }

    /// `IterArgsToInitArgs`: a `tensor.dim` of an `scf.forall`'s shared output (a block argument)
    /// takes its init instead.
    #[rewrite("tensor.dim")]
    fn iter_args_to_init_args(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let b = &*rw.body;
        let Def::Arg(block, i) = b[b[op].operands[0]].def else { return false };
        let Some(region) = b[block].parent else { return false };
        let forall = b[region].parent;
        if b[forall].name != "scf.forall" {
            return false;
        }
        let seg = b.segments(forall, "operandSegmentSizes").unwrap_or_default();
        let ivs = b.dense_i64(forall, "staticLowerBound").len();
        let Some(k) = (i as usize).checked_sub(ivs) else { return false };
        let init = b[forall].operands[seg.iter().take(3).sum::<usize>() + k];
        rw.modify(op, |b| b.set_operand(op, 0, init));
        true
    }
}

impl ResolveDims {
    /// The dim `op` takes of an op's result, replaced by what that op reifies.
    fn reified(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let (src, index) = (rw.body[op].operands[0], rw.body[op].operands[1]);
        let Def::Result(owner, k) = rw.body[src].def else { return false };
        let Some(dim) = rw.body.const_index(index) else { return false };
        let Ok(dim) = usize::try_from(dim) else { return false };
        rw.set_before(op);
        let Some(size) = rw.reify_dim(owner, k as usize, dim) else { return false };
        let v = rw.value_of(size);
        rw.replace_op(op, &[v]);
        true
    }
}
