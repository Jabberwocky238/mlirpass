//! `func` canonicalization patterns, as `FuncOps.cpp`.

use mlirformat::Attribute;

use crate::{OpData, PatternSet};

rewrites! {
    /// `CallIndirectOp::canonicalize`: an indirect call of a constant function is a direct
    /// call.
    CallIndirectOfConstant("func.call_indirect", 1) |rw, op| {
        let b = &*rw.body;
        let Some(callee @ Attribute::SymbolRef(_)) = b.constant_of(b[op].operands[0]) else { return false };
        let args = b[op].operands[1..].to_vec();
        let types = b.types(&b[op].results);
        rw.replace_with(op, OpData::build("func.call").operands(&args).with("callee", callee), &types);
        true
    }
}

/// The func canonicalization patterns.
pub fn patterns(set: &mut PatternSet) {
    set.add(CallIndirectOfConstant);
}
