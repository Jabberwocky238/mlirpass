//! `test` dialect canonicalization patterns (`mlir/test/lib/Dialect/Test`).

use crate::OpData;

/// `test` canonicalization: its rewrite patterns, folds and constant materialization.
pub struct TestCanon;

#[crate::patterns]
impl TestCanon {
    /// `FoldToCallOpPattern`: a `func.call` of the op's callee.
    #[rewrite("test.fold_to_call_op")]
    fn fold_to_call_op(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
        let Some(callee) = rw.body[op].get("callee").cloned() else { return false };
        rw.replace_with(op, OpData::build("func.call").with("callee", callee), &[]);
        true
    }
}

impl TestCanon {
    /// The test dialect's canonicalization patterns.
    pub fn canonicalization(set: &mut crate::PatternSet) {
        set.add(FoldToCallOp);
    }
}
