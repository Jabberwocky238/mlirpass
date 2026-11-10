//! `amdgpu` rule sets.

mod canonicalize;
pub use canonicalize::AmdgpuCanon;

#[cfg(feature = "target.llvm")]
mod buffer_to_rocdl;
#[cfg(feature = "target.llvm")]
mod cvt_to_rocdl;
#[cfg(feature = "target.llvm")]
mod mem_to_rocdl;
#[cfg(feature = "target.llvm")]
mod mma_to_rocdl;
#[cfg(feature = "target.llvm")]
mod to_rocdl;
#[cfg(feature = "target.llvm")]
pub use to_rocdl::AmdgpuToRocdl;

/// What the amdgpu ⇒ rocdl patterns need: the converter's options and the chipset.
#[cfg(feature = "target.llvm")]
#[derive(Debug, Clone, Copy)]
pub struct AmdgpuRocdlOptions {
    pub llvm: crate::LlvmOptions,
    pub chipset: crate::AmdChipset,
}

/// `amdgpu` ops' adaptor: the converted operands by `operandSegmentSizes` group (an op without
/// them: its first operand, then the rest).
#[cfg(feature = "target.llvm")]
struct AmdgpuOperands<'o> {
    groups: alloc::vec::Vec<&'o [alloc::vec::Vec<crate::ValueId>]>,
}

#[cfg(feature = "target.llvm")]
impl<'o> AmdgpuOperands<'o> {
    fn new(cr: &crate::ConversionRewriter<'_, '_, '_>, op: crate::OpId, operands: &'o [alloc::vec::Vec<crate::ValueId>]) -> Self {
        // Without segment sizes: one operand, then the variadic rest.
        let Some(sizes) = cr.rw.body.segments(op, "operandSegmentSizes") else { return Self { groups: alloc::vec![&operands[..1.min(operands.len())], &operands[1.min(operands.len())..]] } };
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
