//! The `memref` dialect's op interfaces.

use alloc::vec;
use alloc::vec::Vec;

use crate::{Body, DialectInliner, InlineAll, OpId, OpInterfaces, Point, Succ, ValueId};

/// The `memref` dialect.
pub struct MemrefDialect;

impl OpInterfaces for MemrefDialect {
    fn namespace(&self) -> &str {
        "memref"
    }

    /// Ops inline, and into regions (`MemRefInlinerInterface`).
    fn inliner(&self) -> Option<&dyn DialectInliner> {
        Some(&InlineAll { calls: false, regions: true })
    }

    fn speculatability(&self, b: &Body<'_>, op: OpId) -> Option<bool> {
        if b[op].name == "memref.dim" { b.dim_speculatability(op) } else { None }
    }

    fn is_region_branch(&self, b: &Body<'_>, op: OpId) -> bool {
        b[op].name == "memref.alloca_scope"
    }

    fn region_successors(&self, b: &Body<'_>, op: OpId, point: Point) -> Vec<(Succ, Vec<ValueId>)> {
        if b[op].name != "memref.alloca_scope" {
            return Vec::new();
        }
        match point {
            Point::Parent => (0..b[op].regions.len()).map(|r| (Succ::Region(r), Vec::new())).collect(),
            Point::Terminator(_) => vec![(Succ::Parent, b[op].results.clone())],
        }
    }

    fn is_region_terminator(&self, b: &Body<'_>, t: OpId) -> bool {
        b[t].name == "memref.alloca_scope.return"
    }
}
