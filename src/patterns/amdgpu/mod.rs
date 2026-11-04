//! `amdgpu` rule sets.

#[cfg(feature = "target.llvm")]
mod cvt_to_rocdl;
#[cfg(feature = "target.llvm")]
mod to_rocdl;
#[cfg(feature = "target.llvm")]
pub use to_rocdl::AmdgpuToRocdl;

/// `amdgpu` ops' adaptor: the converted operands by `operandSegmentSizes` group.
#[cfg(feature = "target.llvm")]
struct AmdgpuOperands<'o> {
    groups: alloc::vec::Vec<&'o [alloc::vec::Vec<crate::ValueId>]>,
}

#[cfg(feature = "target.llvm")]
impl<'o> AmdgpuOperands<'o> {
    fn new(cr: &crate::ConversionRewriter<'_, '_, '_>, op: crate::OpId, operands: &'o [alloc::vec::Vec<crate::ValueId>]) -> Self {
        let Some(sizes) = cr.rw.body.segments(op, "operandSegmentSizes") else { return Self { groups: operands.chunks(1).collect() } };
        let mut rest = operands;
        let groups = sizes.into_iter().map(|n| {
            let (g, r) = rest.split_at(n.min(rest.len()));
            rest = r;
            g
        }).collect();
        Self { groups }
    }

    /// Group `k`, one converted value per operand.
    fn group(&self, k: usize) -> impl Iterator<Item = crate::ValueId> + '_ {
        self.groups.get(k).into_iter().flat_map(|g| g.iter().filter_map(|v| v.first().copied()))
    }

    /// The operand of optional group `k`.
    fn one(&self, k: usize) -> Option<crate::ValueId> {
        self.group(k).next()
    }

    /// Integer attribute `name` of `op`.
    fn int(cr: &crate::ConversionRewriter<'_, '_, '_>, op: crate::OpId, name: &str) -> Option<i64> {
        match cr.rw.body[op].get(name)? {
            mlirformat::Attribute::Int { lit, .. } => lit.parse().ok(),
            _ => None,
        }
    }
}
