//! The `spirv` dialect's op interfaces.

use crate::{BlockId, Body, BranchLayout, DialectInliner, OpData, OpId, OpInterfaces, ValueId};

/// The `spirv` dialect.
pub struct SpirvDialect;

impl OpInterfaces for SpirvDialect {
    fn namespace(&self) -> &str {
        "spirv"
    }

    fn inliner(&self) -> Option<&dyn DialectInliner> {
        Some(self)
    }

    fn branch_layout(&self, b: &Body<'_>, op: OpId) -> Option<BranchLayout> {
        Some(match &*b[op].name {
            "spirv.Branch" => BranchLayout::All,
            "spirv.BranchConditional" => BranchLayout::Groups { first: 1 },
            "spirv.Switch" => BranchLayout::Cases { default: Some(1), cases: 2, split: "case_operand_segments" },
            _ => return None,
        })
    }
}

/// `SPIRVInlinerInterface`.
impl DialectInliner for SpirvDialect {
    fn legal_call(&self, _: &Body<'_>, _: OpId, _: OpId) -> bool {
        true
    }

    /// Into a function, a selection or a loop.
    fn legal_region(&self, b: &Body<'_>, dest: crate::RegionId) -> bool {
        matches!(&*b[b[dest].parent].name, "spirv.func" | "spirv.mlir.selection" | "spirv.mlir.loop")
    }

    /// Not a selection or loop that returns, not a kill.
    fn legal_op(&self, b: &Body<'_>, op: OpId) -> bool {
        let returns = |r: crate::RegionId| b[r].blocks.iter().any(|blk| b[*blk].ops.last().is_some_and(|t| matches!(&*b[*t].name, "spirv.Return" | "spirv.ReturnValue")));
        if matches!(&*b[op].name, "spirv.mlir.selection" | "spirv.mlir.loop") && b[op].regions.first().is_some_and(|r| returns(*r)) {
            return false;
        }
        b[op].name != "spirv.Kill"
    }

    /// `spirv.Return` / `spirv.ReturnValue` as a `spirv.Branch` to `dest`.
    fn branch_terminator(&self, b: &mut Body<'_>, op: OpId, dest: BlockId) {
        if !matches!(&*b[op].name, "spirv.Return" | "spirv.ReturnValue") {
            return;
        }
        let mut data = OpData::build("spirv.Branch").operands(&b[op].operands.clone());
        data.successors = alloc::vec![dest];
        data.loc = b[op].loc.clone();
        let br = b.create(data, &[]);
        b.insert_before(br, op);
        b.erase(op);
    }

    fn replace_with_terminator(&self, b: &mut Body<'_>, op: OpId, results: &[ValueId]) {
        if b[op].name != "spirv.ReturnValue" {
            return;
        }
        let v = b[op].operands[0];
        b.replace_all_uses(results[0], v);
    }
}
