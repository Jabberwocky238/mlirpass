//! The `spirv` dialect's op interfaces.

use crate::{BlockId, Body, BranchLayout, DialectInliner, OpData, OpId, OpInterfaces, ValueId};

/// The `spirv` dialect.
pub struct SpirvDialect;

impl OpInterfaces for SpirvDialect {
    fn namespace(&self) -> &str {
        "spirv"
    }

    /// `OpAsmOpInterface::getAsmResultNames`.
    fn asm_result_names(&self, b: &crate::Body<'_>, op: crate::OpId) -> alloc::vec::Vec<(crate::ValueId, alloc::borrow::Cow<'static, str>)> {
        match &*b[op].name {
            "spirv.Constant" => b.result_named(op, Self::constant_name(b, op)),
            // `<variable>_addr`.
            "spirv.mlir.addressof" => match b[op].get("variable") {
                Some(mlirformat::Attribute::SymbolRef(path)) => match path.last() {
                    Some(leaf) => b.result_named(op, alloc::format!("{}_addr", leaf.trim_matches('"'))),
                    None => alloc::vec::Vec::new(),
                },
                _ => alloc::vec::Vec::new(),
            },
            _ => alloc::vec::Vec::new(),
        }
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
        let returns = |r: crate::RegionId| b[r].blocks.iter().any(|blk| b.last_op(*blk).is_some_and(|t| matches!(&*b[t].name, "spirv.Return" | "spirv.ReturnValue")));
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
        data.successors = smallvec::smallvec![dest];
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

impl SpirvDialect {
    /// `ConstantOp::getAsmResultNames`: `%true` / `%false` for an `i1`; else `%cst`, the integer
    /// value as its signedness reads it, `_<type>` for an integer or float, `_vec_<n>x<element>`
    /// for a vector.
    fn constant_name(b: &Body<'_>, op: OpId) -> alloc::borrow::Cow<'static, str> {
        use mlirformat::{ShapedKind, Signedness, Type};
        let ty = &b[b[op].results[0]].ty;
        let mut name = alloc::string::String::from("cst");
        let int = b[op].get("value").and_then(|a| crate::Const::try_from(a).ok()).filter(|c| !c.elements).and_then(|c| c.as_int());
        if let (Some(i), Type::Integer { signedness, width }) = (int, ty) {
            if *width == 1 {
                return alloc::borrow::Cow::Borrowed(if i.is_zero() { "false" } else { "true" });
            }
            name += &match signedness {
                Signedness::Unsigned => alloc::format!("{}", i.unsigned()),
                _ => alloc::format!("{}", i.signed()),
            };
        }
        if matches!(ty, Type::Integer { .. } | Type::Float(_)) {
            name += &alloc::format!("_{ty}");
        }
        if let Type::Shaped(s) = ty
            && s.kind == ShapedKind::Vector
        {
            name += &alloc::format!("_vec_{}", s.dims().and_then(|d| d.first().copied()).unwrap_or_default());
            if matches!(*s.elem, Type::Integer { .. } | Type::Float(_)) {
                name += &alloc::format!("x{}", s.elem);
            }
        }
        alloc::borrow::Cow::Owned(name)
    }
}
