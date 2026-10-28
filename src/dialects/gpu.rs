//! The `gpu` dialect's op interfaces.

use crate::{Body, DialectInliner, InlineAll, OpId, OpInterfaces};

/// The `gpu` dialect.
pub struct GpuDialect;

impl OpInterfaces for GpuDialect {
    fn namespace(&self) -> &str {
        "gpu"
    }

    /// Every op inlines (`GPUInlinerInterface`).
    fn inliner(&self) -> Option<&dyn DialectInliner> {
        Some(&InlineAll { calls: false, regions: false })
    }

    /// `SubgroupBroadcastOp::getSpeculatability`: a specific lane is, the first active lane
    /// (which control flow changes) is not.
    fn speculatability(&self, b: &Body<'_>, op: OpId) -> Option<bool> {
        match &*b[op].name {
            "gpu.subgroup_broadcast" => matches!(b[op].get("broadcast_type"), Some(mlirformat::Attribute::Extended { ext, .. }) if ext.body.as_deref().is_some_and(|s| s.contains("specific_lane"))).then_some(false),
            _ => None,
        }
    }
}
