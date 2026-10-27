//! The `affine` dialect's op interfaces.

use alloc::vec;
use alloc::vec::Vec;

use mlirformat::Attribute;

use crate::{Body, OpId, OpInterfaces, Operand, Point, Succ, ValueId};

/// The `affine` dialect.
pub struct AffineDialect;

impl AffineDialect {
    /// `getTrivialConstantTripCount` of an `affine.for`.
    fn trip_count(b: &Body<'_>, op: OpId) -> Option<i64> {
        let step = b.for_step(op);
        let (lb, ub) = (b.for_constant_bound(op, true)?, b.for_constant_bound(op, false)?);
        (step > 0).then(|| if ub - lb <= 0 { 0 } else { (ub - lb + step - 1) / step })
    }
}

impl OpInterfaces for AffineDialect {
    fn namespace(&self) -> &str {
        "affine"
    }

    fn speculatability(&self, b: &Body<'_>, op: OpId) -> Option<bool> {
        let step = || b[op].get("step").and_then(|a| if let Attribute::Int { lit, .. } = a { lit.parse::<i64>().ok() } else { None });
        match &*b[op].name {
            "affine.for" => (step() == Some(1)).then_some(true),
            _ => None,
        }
    }

    fn is_region_branch(&self, b: &Body<'_>, op: OpId) -> bool {
        b[op].name == "affine.for"
    }

    fn region_successors(&self, b: &Body<'_>, op: OpId, point: Point) -> Vec<(Succ, Vec<ValueId>)> {
        if b[op].name != "affine.for" {
            return Vec::new();
        }
        let results = b[op].results.clone();
        let body = (Succ::Region(0), b.region_args(op, 0, 1));
        match (Self::trip_count(b, op), point) {
            (Some(1), Point::Terminator(_)) | (Some(0), Point::Parent) => vec![(Succ::Parent, results)],
            (Some(0), Point::Terminator(_)) => Vec::new(),
            (Some(_), Point::Parent) => vec![body],
            _ => vec![body, (Succ::Parent, results)],
        }
    }

    fn entry_operands(&self, b: &Body<'_>, op: OpId) -> Vec<Operand> {
        if b[op].name != "affine.for" {
            return Vec::new();
        }
        let seg = b.segments(op, "operandSegmentSizes").unwrap_or_default();
        let start = seg.iter().take(2).sum();
        (start..b[op].operands.len()).map(|i| (op, i)).collect()
    }

    fn is_region_terminator(&self, b: &Body<'_>, t: OpId) -> bool {
        b[t].name == "affine.yield"
    }
}
