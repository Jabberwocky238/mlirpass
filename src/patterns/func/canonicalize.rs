//! `func` canonicalization patterns, as `FuncOps.cpp`.

use mlirformat::Attribute;

use crate::OpData;

/// `func` canonicalization: its rewrite patterns, folds and constant materialization.
pub struct FuncCanon;

#[crate::patterns]
impl FuncCanon {
    /// `CallIndirectOp::canonicalize`: an indirect call of a constant function is a direct
    /// call.
    #[rewrite("func.call_indirect")]
    fn call_indirect_of_constant(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
        let b = &*rw.body;
        let Some(callee @ Attribute::SymbolRef(_)) = b.constant_of(b[op].operands[0]) else { return false };
        let args = b[op].operands[1..].to_vec();
        let types = b.types(&b[op].results);
        rw.replace_with(op, OpData::build("func.call").operands(&args).with("callee", callee), &types);
        true
    }
}

impl FuncCanon {
    /// The func canonicalization patterns.
    pub fn canonicalization(set: &mut crate::PatternSet) {
        set.add(CallIndirectOfConstant);
    }
}
