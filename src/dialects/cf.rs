use alloc::vec;
use alloc::vec::Vec;

use mlirformat::Attribute;

use crate::{BlockId, Body, BranchLayout, Const, DialectInliner, EffectInstance, EffectKind, InlineAll, OpId, OpInterfaces};

pub struct CfDialect;

impl OpInterfaces for CfDialect {
    fn namespace(&self) -> &str {
        "cf"
    }

    #[cfg(feature = "dialect.bufferization")]
    fn bufferizable(&self, name: &str) -> Option<&dyn crate::Bufferizable> {
        matches!(name, "cf.br" | "cf.cond_br").then_some(&bufferizable::Branch as &dyn crate::Bufferizable)
    }

    fn inliner(&self) -> Option<&dyn DialectInliner> {
        Some(&InlineAll { calls: true, regions: false })
    }

    fn effects(&self, b: &Body<'_>, op: OpId) -> Option<Vec<EffectInstance>> {
        (b[op].name == "cf.assert").then(|| vec![EffectInstance::on(EffectKind::Write, None)])
    }

    fn branch_layout(&self, b: &Body<'_>, op: OpId) -> Option<BranchLayout> {
        Some(match &*b[op].name {
            "cf.br" => BranchLayout::All,
            "cf.cond_br" => BranchLayout::Groups { groups: &crate::CONDITIONAL_GROUPS },
            "cf.switch" => BranchLayout::Cases { default: Some(1), cases: 2, split: "case_operand_segments" },
            _ => return None,
        })
    }

    fn successor_for<'a>(&self, b: &Body<'a>, op: OpId, c: &[Option<Attribute<'a>>]) -> Option<BlockId> {
        let succ = &b[op].successors;
        match &*b[op].name {
            "cf.br" => Some(succ[0]),
            "cf.cond_br" => Body::selector_of(&c[0]).map(|v| if v & 1 == 1 { succ[0] } else { succ[1] }),
            "cf.switch" => {
                let Some(cases) = b[op].get("case_values").and_then(|a| Const::try_from(a).ok()) else { return Some(succ[0]) };
                let v = Body::selector_of(&c[0])?;
                let n = cases.ty.element_count().unwrap_or(0);
                Some((0..n).find(|i| cases.at(*i).int().is_some_and(|x| x.signed() == v)).map_or(succ[0], |i| succ[i + 1]))
            }
            _ => None,
        }
    }
}

#[cfg(feature = "dialect.bufferization")]
mod bufferizable {
    use alloc::vec::Vec;

    use mlirformat::Error;

    use crate::{AliasingValue, AnalysisState, Body, BufferRelation, Bufferizable, BufferizationOptions, OpId, Operand, Rewriter};

    pub(super) struct Branch;

    impl Bufferizable for Branch {
        fn reads(&self, _: &AnalysisState<'_>, _: &Body<'_>, _: Operand) -> bool {
            false
        }

        fn writes(&self, _: &AnalysisState<'_>, _: &Body<'_>, _: Operand) -> bool {
            false
        }

        fn aliasing_values(&self, _: &AnalysisState<'_>, b: &Body<'_>, (op, i): Operand) -> Vec<AliasingValue> {
            b[op]
                .successors
                .iter()
                .enumerate()
                .filter_map(|(k, blk)| {
                    let r = b.successor_operands(op, k)?;
                    r.contains(&i).then(|| AliasingValue { value: b[*blk].args[i - r.start], relation: BufferRelation::Equivalent, definite: false })
                })
                .collect()
        }

        fn bufferize(&self, _: &mut Rewriter<'_, '_>, _: &BufferizationOptions, _: OpId) -> Result<(), Error> {
            Ok(())
        }
    }
}
