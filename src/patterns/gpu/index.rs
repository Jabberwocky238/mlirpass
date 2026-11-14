use alloc::format;
use alloc::vec;

use mlirformat::{Attribute, Type};

use super::attrs::Dimension;
use crate::{ConversionRewriter, LlvmOptions, OpData, OpId, ValueId};

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum IndexKind {
    Other,
    Block,
    Grid,
    Cluster,
}

impl IndexKind {
    const fn known(self) -> Option<(&'static str, &'static str)> {
        match self {
            IndexKind::Block => Some(("gpu.known_block_size", "known_block_size")),
            IndexKind::Grid => Some(("gpu.known_grid_size", "known_grid_size")),
            IndexKind::Cluster => Some(("gpu.known_cluster_size", "known_cluster_size")),
            IndexKind::Other => None,
        }
    }
}

pub fn constant_range<'a>(lo: i64, hi: i64) -> Attribute<'a> {
    Attribute::dialect("llvm.constant_range", &format!("<i32, {lo}, {hi}>"))
}

impl<'a> ConversionRewriter<'_, 'a, '_> {
    pub fn fit_index(&mut self, v: ValueId, o: LlvmOptions) -> ValueId {
        match o.index_bitwidth {
            32 => v,
            w if w > 32 => self.build(OpData::build("llvm.sext").operands(&[v]), Type::int(w)),
            w => self.build(OpData::build("llvm.trunc").operands(&[v]), Type::int(w)),
        }
    }

    pub(crate) fn known_bound(&self, op: OpId, kind: IndexKind, d: Dimension) -> Option<i64> {
        let (attr, prop) = kind.known()?;
        let f = self.parent_function(op)?;
        let b = &*self.rw.body;
        let a = if b[f].name == "gpu.func" { b[f].get(prop) } else { b[f].get(attr) }?;
        a.dense_values()?.get(d as usize).copied()
    }

    pub fn gpu_index(&mut self, op: OpId, o: LlvmOptions, name: &str, kind: IndexKind, dim: bool) -> bool {
        let Some(d) = self.rw.body[op].get("dimension").and_then(|a| Dimension::try_from(a).ok()) else { return false };
        let axis = ["x", "y", "z"][d as usize];
        let known = self.known_bound(op, kind, d);
        let mut data = OpData::build(&format!("{name}.{axis}"));
        match known {
            Some(k) if dim && k < i64::from(u32::MAX) => data.set("range", constant_range(k, k + 1)),
            _ => {
                let bound = match self.rw.body[op].get("upper_bound") {
                    Some(Attribute::Int { lit, .. }) => lit.parse().ok(),
                    _ => known,
                };
                if let Some(ub) = bound {
                    data.set("range", constant_range(i64::from(dim), (ub + i64::from(dim)).min(i64::from(u32::MAX))));
                }
            }
        }
        self.rw.set_before(op);
        let r = self.build(data, Type::int(32));
        let r = self.fit_index(r, o);
        self.replace(op, vec![vec![r]]);
        true
    }
}
