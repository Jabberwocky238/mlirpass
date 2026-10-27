//! The `llvm` dialect's op interfaces.

use alloc::string::String;
use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{Attribute, Extended, Type};

use crate::{Body, BlockId, BranchLayout, EffectInstance, EffectKind, OpId, OpInterfaces};

/// The `llvm` dialect.
pub struct LlvmDialect;

impl LlvmDialect {
    fn ext<'a>(name: &str) -> Attribute<'a> {
        Attribute::Extended { ext: Extended { name: String::from(name).into(), body: None, params: Vec::new() }, ty: None }
    }
}

impl OpInterfaces for LlvmDialect {
    fn namespace(&self) -> &str {
        "llvm"
    }

    fn constant_value<'a>(&self, b: &Body<'a>, op: OpId) -> Option<Attribute<'a>> {
        let d = &b[op];
        match &*d.name {
            // `ZeroOp::fold`: a builtin zero where the type has one.
            "llvm.mlir.zero" => Some(match &b[d.results[0]].ty {
                t @ (Type::Integer { .. } | Type::Index) => Attribute::Int { lit: "0".into(), ty: Some(t.clone()) },
                t @ Type::Float(_) => Attribute::Float { lit: "0.000000e+00".into(), ty: Some(t.clone()) },
                _ => Self::ext("llvm.zero"),
            }),
            "llvm.mlir.undef" => Some(Self::ext("llvm.undef")),
            "llvm.mlir.poison" => Some(Self::ext("llvm.poison")),
            _ => d.get("value").cloned(),
        }
    }

    fn effects(&self, b: &Body<'_>, op: OpId) -> Option<Vec<EffectInstance>> {
        use EffectKind::{Read, Write};
        let d = &b[op];
        // Volatile or (stronger than unordered) atomic: arbitrary reads and writes besides.
        let synchronizing = || d.get("volatile_").is_some() || matches!(d.get("ordering"), Some(Attribute::Int { lit, .. }) if !matches!(&**lit, "0" | "1"));
        Some(match &*d.name {
            "llvm.load" | "llvm.store" => {
                let (kind, addr) = if d.name == "llvm.load" { (Read, 0) } else { (Write, 1) };
                let mut out = vec![EffectInstance::on(kind, d.operands.get(addr).copied())];
                if synchronizing() {
                    out.extend([EffectInstance::on(Write, None), EffectInstance::on(Read, None)]);
                }
                out
            }
            "llvm.inline_asm" if d.get("has_side_effects").is_some() => vec![EffectInstance::on(Write, None), EffectInstance::on(Read, None)],
            "llvm.inline_asm" => Vec::new(),
            _ => return None,
        })
    }

    fn speculatability(&self, b: &Body<'_>, op: OpId) -> Option<bool> {
        let divisor = || b.int_constant(b[op].operands[1]);
        match &*b[op].name {
            "llvm.udiv" => divisor().filter(|v| *v != 0).map(|_| false),
            "llvm.sdiv" => divisor().filter(|v| *v != 0 && *v != -1).map(|_| false),
            _ => None,
        }
    }

    fn branch_layout(&self, b: &Body<'_>, op: OpId) -> Option<BranchLayout> {
        Some(match &*b[op].name {
            "llvm.br" => BranchLayout::All,
            "llvm.cond_br" | "llvm.invoke" => BranchLayout::Groups { first: 1 },
            "llvm.switch" => BranchLayout::Cases { default: Some(1), cases: 2, split: "case_operand_segments" },
            "llvm.indirectbr" => BranchLayout::Cases { default: None, cases: 1, split: "indbr_operand_segments" },
            _ => return None,
        })
    }

    fn successor_for<'a>(&self, b: &Body<'a>, op: OpId, c: &[Option<Attribute<'a>>]) -> Option<BlockId> {
        let succ = &b[op].successors;
        match &*b[op].name {
            "llvm.br" => Some(succ[0]),
            "llvm.cond_br" => Body::selector_of(&c[0]).map(|v| if v & 1 == 1 { succ[0] } else { succ[1] }),
            _ => None,
        }
    }
}
