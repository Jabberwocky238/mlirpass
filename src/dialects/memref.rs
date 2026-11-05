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

    /// `getAsmResultNames`: each op's fixed name (`%alloc`, `%subview`, ...).
    fn asm_result_names(&self, b: &crate::Body<'_>, op: crate::OpId) -> alloc::vec::Vec<(crate::ValueId, alloc::borrow::Cow<'static, str>)> {
        let name = match &*b[op].name {
            "memref.alloc" => "alloc",
            "memref.alloca" => "alloca",
            "memref.assume_alignment" => "assume_align",
            "memref.cast" => "cast",
            "memref.dim" => "dim",
            "memref.extract_aligned_pointer_as_index" => "intptr",
            "memref.memory_space_cast" => "memspacecast",
            "memref.reinterpret_cast" => "reinterpret_cast",
            "memref.collapse_shape" => "collapse_shape",
            "memref.expand_shape" => "expand_shape",
            "memref.reshape" => "reshape",
            "memref.subview" => "subview",
            "memref.transpose" => "transpose",
            "memref.view" => "view",
            // `base_buffer`, `offset`, then `sizes` and `strides` when the memref has a rank.
            "memref.extract_strided_metadata" => {
                let r = &b[op].results;
                let rank = (r.len() - 2) / 2;
                let mut out = alloc::vec![(r[0], "base_buffer".into()), (r[1], "offset".into())];
                if rank > 0 {
                    out.extend([(r[2], "sizes".into()), (r[2 + rank], "strides".into())]);
                }
                return out;
            }
            _ => return alloc::vec::Vec::new(),
        };
        b.result_named(op, name)
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
