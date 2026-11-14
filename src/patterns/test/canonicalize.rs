use mlirformat::{arith, Attribute, Type};

use crate::OpData;

const DIALECT_CANONICAL: i32 = 42;

pub struct TestCanon;

#[crate::patterns]
impl TestCanon {
    #[rewrite("test.fold_to_call_op")]
    fn fold_to_call_op(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
        let Some(callee) = rw.body[op].get("callee").cloned() else { return false };
        rw.replace_with(op, OpData::build("func.call").with("callee", callee), &[]);
        true
    }

    #[rewrite("test.op_with_region_pattern", name = "TestRemoveOpWithInnerOps")]
    fn remove_op_with_inner_ops(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
        rw.erase_op(op);
        true
    }

    #[rewrite("test.dialect_canonicalizable")]
    fn dialect_canonicalization(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
        let i32 = Type::int(32);
        rw.set_before(op);
        let c = rw.emit(&arith::Constant::new(Attribute::of_int(DIALECT_CANONICAL.into(), i32.clone()), i32));
        let r = rw.body[c].results[0];
        rw.replace_op(op, &[r]);
        true
    }
}

impl TestCanon {
    pub fn canonicalization(set: &mut crate::PatternSet) {
        set.add(FoldToCallOp).add(TestRemoveOpWithInnerOps).add(DialectCanonicalization);
    }
}
