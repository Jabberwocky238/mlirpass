//! The `spirv` dialect's op interfaces.

use crate::{Body, BranchLayout, OpId, OpInterfaces};

/// The `spirv` dialect.
pub struct SpirvDialect;

impl OpInterfaces for SpirvDialect {
    fn namespace(&self) -> &str {
        "spirv"
    }

    fn branch_layout(&self, b: &Body<'_>, op: OpId) -> Option<BranchLayout> {
        Some(match &*b[op].name {
            "spirv.Branch" => BranchLayout::All,
            "spirv.BranchConditional" => BranchLayout::Groups { first: 1 },
            "spirv.Switch" => BranchLayout::Cases { default: Some(1), cases: 2, split: "target_operand_segments" },
            _ => return None,
        })
    }
}
