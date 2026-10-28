//! The `scf` dialect's op interfaces.

use alloc::vec;
use alloc::vec::Vec;

use mlirformat::Attribute;

use crate::{Body, DialectInliner, OpId, OpInterfaces, Operand, Point, Succ, ValueId};

/// The `scf` dialect.
pub struct ScfDialect;

impl OpInterfaces for ScfDialect {
    fn namespace(&self) -> &str {
        "scf"
    }

    fn inliner(&self) -> Option<&dyn DialectInliner> {
        Some(self)
    }

    fn speculatability(&self, b: &Body<'_>, op: OpId) -> Option<bool> {
        match &*b[op].name {
            "scf.for" => (b.int_constant(b[op].operands[2]) == Some(1)).then_some(true),
            _ => None,
        }
    }

    fn is_region_branch(&self, b: &Body<'_>, op: OpId) -> bool {
        matches!(&*b[op].name, "scf.for" | "scf.if" | "scf.while" | "scf.execute_region" | "scf.index_switch")
    }

    fn region_successors(&self, b: &Body<'_>, op: OpId, point: Point) -> Vec<(Succ, Vec<ValueId>)> {
        let results = b[op].results.clone();
        match &*b[op].name {
            "scf.for" => vec![(Succ::Region(0), b.region_args(op, 0, 1)), (Succ::Parent, results)],
            "scf.if" => match point {
                Point::Parent => {
                    let else_empty = b[b[op].regions[1]].blocks.is_empty();
                    vec![(Succ::Region(0), Vec::new()), if else_empty { (Succ::Parent, results) } else { (Succ::Region(1), Vec::new()) }]
                }
                Point::Terminator(_) => vec![(Succ::Parent, results)],
            },
            "scf.while" => match point {
                Point::Parent => vec![(Succ::Region(0), b.region_args(op, 0, 0))],
                Point::Terminator(t) if b[t].name == "scf.condition" => vec![(Succ::Region(1), b.region_args(op, 1, 0)), (Succ::Parent, results)],
                Point::Terminator(_) => vec![(Succ::Region(0), b.region_args(op, 0, 0))],
            },
            "scf.execute_region" | "scf.index_switch" => match point {
                Point::Parent => (0..b[op].regions.len()).map(|r| (Succ::Region(r), Vec::new())).collect(),
                Point::Terminator(_) => vec![(Succ::Parent, results)],
            },
            _ => Vec::new(),
        }
    }

    fn entry_operands(&self, b: &Body<'_>, op: OpId) -> Vec<Operand> {
        let from = match &*b[op].name {
            "scf.for" => 3,
            "scf.while" => 0,
            _ => return Vec::new(),
        };
        (from..b[op].operands.len()).map(|i| (op, i)).collect()
    }

    fn entry_successors<'a>(&self, b: &Body<'a>, op: OpId, c: &[Option<Attribute<'a>>], all: Vec<(Succ, Vec<ValueId>)>) -> Vec<(Succ, Vec<ValueId>)> {
        match &*b[op].name {
            "scf.if" => match Body::selector_of(&c[0]) {
                Some(1) => vec![all[0].clone()],
                Some(_) => vec![all[1].clone()],
                None => all,
            },
            "scf.index_switch" => {
                let Some(v) = Body::selector_of(&c[0]) else { return all };
                let cases = b.segments(op, "cases").unwrap_or_default();
                let i = cases.iter().position(|x| *x as i128 == v).map_or(0, |i| i + 1);
                vec![(Succ::Region(i), Vec::new())]
            }
            _ => all,
        }
    }

    fn is_region_terminator(&self, b: &Body<'_>, t: OpId) -> bool {
        matches!(&*b[t].name, "scf.yield" | "scf.condition")
    }

    fn terminator_skip(&self, b: &Body<'_>, t: OpId) -> usize {
        usize::from(b[t].name == "scf.condition")
    }

    /// `scf.condition`: `[after, parent]`, by the condition.
    fn terminator_successors<'a>(&self, b: &Body<'a>, t: OpId, c: &[Option<Attribute<'a>>], all: Vec<(Succ, Vec<ValueId>)>) -> Vec<(Succ, Vec<ValueId>)> {
        if b[t].name != "scf.condition" {
            return all;
        }
        match Body::selector_of(&c[0]) {
            Some(1) => all.into_iter().filter(|s| s.0 != Succ::Parent).collect(),
            Some(_) => all.into_iter().filter(|s| s.0 == Succ::Parent).collect(),
            None => all,
        }
    }
}

/// `SCFInlinerInterface`.
impl DialectInliner for ScfDialect {
    fn legal_region(&self, _: &Body<'_>, _: crate::RegionId) -> bool {
        true
    }

    fn legal_op(&self, _: &Body<'_>, _: OpId) -> bool {
        true
    }

    fn replace_with_terminator(&self, b: &mut Body<'_>, op: OpId, results: &[ValueId]) {
        if b[op].name != "scf.yield" {
            return;
        }
        for (r, v) in results.iter().zip(b[op].operands.clone()) {
            b.replace_all_uses(*r, v);
        }
    }
}
