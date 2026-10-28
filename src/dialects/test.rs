//! The `test` dialect's op interfaces (`mlir/test/lib/Dialect/Test`).

use alloc::vec;
use alloc::vec::Vec;
use core::ops::Range;

use crate::{BlockId, Body, BranchLayout, DialectInliner, InsertPoint, OpData, OpId, OpInterfaces, Operand, Point, Succ, ValueId};

/// The `test` dialect.
pub struct TestDialect;

impl OpInterfaces for TestDialect {
    fn namespace(&self) -> &str {
        "test"
    }

    fn inliner(&self) -> Option<&dyn DialectInliner> {
        Some(self)
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

/// `TestInlinerInterface`.
impl DialectInliner for TestDialect {
    fn legal_call(&self, b: &Body<'_>, call: OpId, _: OpId) -> bool {
        b[call].get("noinline").is_none()
    }

    fn legal_region(&self, _: &Body<'_>, _: crate::RegionId) -> bool {
        true
    }

    fn legal_op(&self, _: &Body<'_>, _: OpId) -> bool {
        true
    }

    /// A functional region op is a scope of its own.
    fn analyze_recursively(&self, b: &Body<'_>, op: OpId) -> bool {
        b[op].name != "test.functional_region_op"
    }

    fn replace_with_terminator(&self, b: &mut Body<'_>, op: OpId, results: &[ValueId]) {
        if b[op].name != "test.return" {
            return;
        }
        for (r, v) in results.iter().zip(b[op].operands.clone()) {
            b.replace_all_uses(*r, v);
        }
    }

    /// `test.cast` between `i16` and `i32`.
    fn call_conversion<'a>(&self, b: &mut Body<'a>, input: ValueId, ty: &mlirformat::Type<'a>, at: InsertPoint, loc: Option<mlirformat::Str<'a>>) -> Option<OpId> {
        let ok = |t: &mlirformat::Type<'_>| *t == mlirformat::Type::int(16) || *t == mlirformat::Type::int(32);
        if !ok(ty) || !ok(&b[input].ty) {
            return None;
        }
        let mut data = OpData::build("test.cast").operands(&[input]);
        data.loc = loc;
        let c = b.create(data, core::slice::from_ref(ty));
        b.put(c, at);
        Some(c)
    }

    /// A `test.type_changer` for an argument or result marked `test.handle_argument` /
    /// `test.handle_result`.
    fn handle_value<'a>(&self, b: &mut Body<'a>, call: OpId, value: ValueId, attrs: Option<&mlirformat::Attribute<'a>>, result: bool, at: InsertPoint) -> ValueId {
        let key = if result { "test.handle_result" } else { "test.handle_argument" };
        if !matches!(attrs, Some(mlirformat::Attribute::Dict(d)) if d.iter().any(|e| e.name == key)) {
            return value;
        }
        let mut data = OpData::build("test.type_changer").operands(&[value]);
        data.loc = b[call].loc.clone();
        let ty = b[value].ty.clone();
        let c = b.create(data, &[ty]);
        b.put(c, at);
        b[c].results[0]
    }

    /// Ops inlined through a `test.conversion_call_op` are marked `inlined_conversion`.
    fn process_inlined(&self, b: &mut Body<'_>, call: OpId, blocks: &[BlockId]) {
        if b[call].name != "test.conversion_call_op" {
            return;
        }
        let mut ops = Vec::new();
        for blk in blocks {
            for o in &b[*blk].ops {
                b.walk(*o, &mut |x| ops.push(x));
            }
        }
        for o in ops {
            b[o].set("inlined_conversion", mlirformat::Attribute::Unit);
        }
    }
}
