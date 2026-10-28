//! The `func` dialect's op interfaces.

use core::ops::Range;

use crate::{BlockId, Body, DialectInliner, OpData, OpId, OpInterfaces, ValueId};

/// The `func` dialect.
pub struct FuncDialect;

impl OpInterfaces for FuncDialect {
    fn namespace(&self) -> &str {
        "func"
    }

    fn inliner(&self) -> Option<&dyn DialectInliner> {
        Some(self)
    }

    fn call_args(&self, b: &Body<'_>, call: OpId) -> Option<Range<usize>> {
        (b[call].name == "func.call_indirect").then(|| 1..b[call].operands.len())
    }

    fn indirect_callee(&self, b: &Body<'_>, call: OpId) -> Option<ValueId> {
        (b[call].name == "func.call_indirect").then(|| b[call].operands[0])
    }
}

/// `FuncInlinerInterface`.
impl DialectInliner for FuncDialect {
    /// Neither a `no_inline` call nor a `no_inline` function.
    fn legal_call(&self, b: &Body<'_>, call: OpId, callable: OpId) -> bool {
        !(b[call].name == "func.call" && b[call].get("no_inline").is_some()) && !(b[callable].name == "func.func" && b[callable].get("no_inline").is_some())
    }

    fn legal_region(&self, _: &Body<'_>, _: crate::RegionId) -> bool {
        true
    }

    fn legal_op(&self, _: &Body<'_>, _: OpId) -> bool {
        true
    }

    /// `func.return` as a `cf.br` to `dest`.
    fn branch_terminator(&self, b: &mut Body<'_>, op: OpId, dest: BlockId) {
        if b[op].name != "func.return" {
            return;
        }
        let mut data = OpData::build("cf.br").operands(&b[op].operands.clone());
        data.successors = alloc::vec![dest];
        data.loc = b[op].loc.clone();
        let br = b.create(data, &[]);
        b.insert_before(br, op);
        b.erase(op);
    }

    fn replace_with_terminator(&self, b: &mut Body<'_>, op: OpId, results: &[ValueId]) {
        for (r, v) in results.iter().zip(b[op].operands.clone()) {
            b.replace_all_uses(*r, v);
        }
    }
}
