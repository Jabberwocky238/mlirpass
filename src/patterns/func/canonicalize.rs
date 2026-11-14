use mlirformat::Attribute;

use crate::OpData;

pub struct FuncCanon;

#[crate::patterns]
impl FuncCanon {
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
    pub fn canonicalization(set: &mut crate::PatternSet) {
        set.add(CallIndirectOfConstant);
    }
}
