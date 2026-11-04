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
            Point::Terminator(_) => vec![(Succ::Parent, b[op].results.clone().to_vec())],
        }
    }

    fn is_region_terminator(&self, b: &Body<'_>, t: OpId) -> bool {
        b[t].name == "memref.alloca_scope.return"
    }

    /// `ExpandShapeOp::reifyResultShapes`: its output shape.
    fn reify<'a>(&self, rw: &mut crate::Rewriter<'_, 'a>, op: OpId) -> Option<Vec<Vec<crate::MemrefOfr>>> {
        let b = &*rw.body;
        (b[op].name == "memref.expand_shape").then(|| vec![crate::MemrefOfr::mixed(&b.dense_i64(op, "static_output_shape"), &b[op].operands[1..])])
    }

    /// `AssumeAlignmentOp::reifyDimOfResult`: its memref's size; the rest as [`reify`](Self::reify).
    fn reify_dim<'a>(&self, rw: &mut crate::Rewriter<'_, 'a>, op: OpId, result: usize, dim: usize) -> Option<crate::MemrefOfr> {
        if rw.body[op].name == "memref.assume_alignment" {
            let src = rw.body[op].operands[0];
            return Some(rw.mixed_size(src, dim));
        }
        self.reify(rw, op)?.get(result)?.get(dim).copied()
    }
}
