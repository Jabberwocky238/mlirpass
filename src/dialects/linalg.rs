//! The `linalg` dialect's op interfaces.

use alloc::vec::Vec;

use mlirformat::{AffineExpr, AffineMap, Attribute, Dim};

use crate::{Body, EffectInstance, EffectKind, OpId, OpInterfaces};

#[path = "linalg_named.gen.rs"]
mod named;
pub use named::OPDSL;

/// An OpDSL op (`LinalgNamedStructuredOps.yaml`), as mlir-linalg-ods-yaml-gen reads it for
/// `getIndexingMaps` / `getIteratorTypesArray`.
pub struct OpDsl<'s> {
    pub name: &'s str,
    /// Each loop's iterator type, `true` for a reduction; none when the op is rank polymorphic.
    pub reductions: &'s [bool],
    /// `static_indexing_maps` as written.
    pub maps: &'s [&'s str],
    pub attrs: &'s [IndexAttr<'s>],
}

/// An index attribute (`strides`, `dilations`): the symbol each element binds, its defaults.
pub struct IndexAttr<'s> {
    pub name: &'s str,
    pub syms: &'s [u32],
    pub defaults: &'s [i64],
}

impl OpDsl<'_> {
    /// The OpDSL op named `name`.
    pub fn of(name: &str) -> Option<&OpDsl<'_>> {
        OPDSL.iter().find(|o| o.name == name)
    }

    /// The iteration domain has rank zero: the maps follow the operands' ranks.
    pub fn rank_polymorphic(&self) -> bool {
        self.reductions.is_empty()
    }

    /// `getIndexingMaps` of a static-rank op: the symbols an index attribute binds become its
    /// values (`attr(name)`, or the defaults), the others are dropped, and each map is simplified.
    pub fn indexing_maps(&self, attr: impl Fn(&str) -> Option<Vec<i64>>) -> Option<Vec<AffineMap>> {
        let maps: Vec<AffineMap> = self.maps.iter().map(|m| AffineMap::parse(m.strip_prefix("affine_map")?)).collect::<Option<_>>()?;
        let first = maps.first()?;
        let mut syms: Vec<AffineExpr> = (0..first.syms).map(AffineExpr::Sym).collect();
        for a in self.attrs {
            let values = attr(a.name).unwrap_or_else(|| a.defaults.to_vec());
            for (s, v) in a.syms.iter().zip(values) {
                *syms.get_mut(*s as usize)? = AffineExpr::Const(v);
            }
        }
        Some(maps.iter().map(|m| m.replace(&[], &syms, m.dims, 0).simplified()).collect())
    }
}

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
