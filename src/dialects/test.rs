//! The `test` dialect's op interfaces (`mlir/test/lib/Dialect/Test`).

use alloc::vec;
use alloc::vec::Vec;
use core::ops::Range;

use crate::{Body, BranchLayout, OpId, OpInterfaces, Operand, Point, Succ, ValueId};

/// The `test` dialect.
pub struct TestDialect;

impl OpInterfaces for TestDialect {
    fn namespace(&self) -> &str {
        "test"
    }

    fn speculatability(&self, b: &Body<'_>, op: OpId) -> Option<bool> {
        match &*b[op].name {
            "test.conditionally_speculatable_op" => b.def_named(b[op].operands[0], "arith.constant").map(|_| false),
            _ => None,
        }
    }

    fn branch_layout(&self, b: &Body<'_>, op: OpId) -> Option<BranchLayout> {
        (b[op].name == "test.br").then_some(BranchLayout::All)
    }

    /// `test.internal_br`: successor `i` gets `i` produced arguments, then operand group `i`.
    fn produced_successor_operands(&self, b: &Body<'_>, op: OpId, i: usize) -> Option<(usize, Range<usize>)> {
        if b[op].name != "test.internal_br" {
            return None;
        }
        let seg = b.segments(op, "operandSegmentSizes").unwrap_or_default();
        let start: usize = seg.iter().take(i).sum();
        Some((i, start..start + seg.get(i).copied().unwrap_or(0)))
    }

    fn is_region_branch(&self, b: &Body<'_>, op: OpId) -> bool {
        b[op].name == "test.region_if"
    }

    /// `test.region_if`: the then and else regions take the operands, both go to the join
    /// region.
    fn region_successors(&self, b: &Body<'_>, op: OpId, point: Point) -> Vec<(Succ, Vec<ValueId>)> {
        if b[op].name != "test.region_if" {
            return Vec::new();
        }
        match point {
            Point::Parent => vec![(Succ::Region(0), b.region_args(op, 0, 0)), (Succ::Region(1), b.region_args(op, 1, 0))],
            Point::Terminator(t) if b[t].parent.and_then(|blk| b[blk].parent) == Some(b[op].regions[2]) => vec![(Succ::Parent, b[op].results.clone())],
            Point::Terminator(_) => vec![(Succ::Region(2), b.region_args(op, 2, 0))],
        }
    }

    fn entry_operands(&self, b: &Body<'_>, op: OpId) -> Vec<Operand> {
        if b[op].name != "test.region_if" {
            return Vec::new();
        }
        (0..b[op].operands.len()).map(|i| (op, i)).collect()
    }

    fn is_region_terminator(&self, b: &Body<'_>, t: OpId) -> bool {
        b[t].name == "test.region_if_yield"
    }

    fn call_args(&self, b: &Body<'_>, call: OpId) -> Option<Range<usize>> {
        if b[call].name != "test.call_with_segments" {
            return None;
        }
        let seg = b.segments(call, "operandSegmentSizes").unwrap_or_default();
        Some(seg[0]..seg[0] + seg[1])
    }
}
