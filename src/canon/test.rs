//! `test` dialect canonicalization patterns (`mlir/test/lib/Dialect/Test`).

use crate::{OpData, PatternSet};

rewrites! {
    /// `FoldToCallOpPattern`: a `func.call` of the op's callee.
    FoldToCallOp("test.fold_to_call_op", 1) |rw, op| {
        let Some(callee) = rw.body[op].get("callee").cloned() else { return false };
        rw.replace_with(op, OpData::build("func.call").with("callee", callee), &[]);
        true
    }
}

/// The test dialect's canonicalization patterns.
pub fn patterns(set: &mut PatternSet) {
    set.add(FoldToCallOp);
}
