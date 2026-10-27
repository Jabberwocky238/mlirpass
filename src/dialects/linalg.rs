//! The `linalg` dialect's op interfaces.

use alloc::vec::Vec;

use mlirformat::{Attribute, Dim};

use crate::{Body, EffectInstance, EffectKind, OpId, OpInterfaces};

/// The `linalg` dialect.
pub struct LinalgDialect;

impl LinalgDialect {
    /// `linalg.pack` / `linalg.unpack`: speculatable when every tiled dimension is static and
    /// every tile size a constant.
    fn pack_speculatability(b: &Body<'_>, op: OpId) -> Option<bool> {
        let pack = b[op].name == "linalg.pack";
        let segs = b.segments(op, "operandSegmentSizes");
        if pack && segs.as_ref().is_some_and(|s| s.get(2) == Some(&1)) {
            return Some(false);
        }
        let tiles: Vec<i64> = match b[op].get("static_inner_tiles") {
            Some(Attribute::DenseArray { values, .. }) => values.iter().map(|v| v.parse().unwrap_or(0)).collect(),
            _ => Vec::new(),
        };
        let first_dynamic = if pack { segs.as_ref().map_or(2, |s| s[..3].iter().sum()) } else { 2 };
        let mut dynamic = b[op].operands[first_dynamic..].iter();
        let packed = &b[b[op].operands[usize::from(pack)]].ty;
        let shape = packed.shape()?;
        let dims = &shape[shape.len() - tiles.len()..];
        for (d, t) in dims.iter().zip(&tiles) {
            let constant = *t != i64::MIN || dynamic.next().is_some_and(|v| b.int_constant(*v).is_some());
            if !constant || !matches!(d, Dim::Static(_)) {
                return None;
            }
        }
        Some(false)
    }
}

impl OpInterfaces for LinalgDialect {
    fn namespace(&self) -> &str {
        "linalg"
    }

    /// `getGenericEffectsImpl` of a structured op: memref inputs are read, memref inits
    /// written (and read when the payload uses them).
    fn effects(&self, b: &Body<'_>, op: OpId) -> Option<Vec<EffectInstance>> {
        use EffectKind::{Read, Write};
        let (ins, outs) = (b.operand_group(op, 0), b.operand_group(op, 1));
        let entry = b[op].regions.first().and_then(|r| b[*r].blocks.first()).map(|blk| &b[*blk].args);
        let mut out: Vec<_> = ins.iter().filter(|v| b.is_memref(**v)).map(|v| EffectInstance::on(Read, Some(*v))).collect();
        for (j, v) in outs.iter().enumerate().filter(|(_, v)| b.is_memref(**v)) {
            let used = entry.and_then(|args| args.get(ins.len() + j)).is_some_and(|a| !b[*a].uses.is_empty());
            if used {
                out.push(EffectInstance::on(Read, Some(*v)));
            }
            out.push(EffectInstance::on(Write, Some(*v)));
        }
        Some(out)
    }

    fn speculatability(&self, b: &Body<'_>, op: OpId) -> Option<bool> {
        match &*b[op].name {
            "linalg.pack" | "linalg.unpack" => Self::pack_speculatability(b, op),
            _ => b[op].operands.iter().all(|v| !b.is_memref(*v)).then_some(true),
        }
    }
}
