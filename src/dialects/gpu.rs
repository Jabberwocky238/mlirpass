//! The `gpu` dialect's op interfaces.

use crate::{Body, DialectInliner, InlineAll, OpId, OpInterfaces};

/// The `gpu` dialect.
pub struct GpuDialect;

impl OpInterfaces for GpuDialect {
    fn namespace(&self) -> &str {
        "gpu"
    }

    /// `OpAsmOpInterface::getAsmResultNames`.
    fn asm_result_names(&self, b: &crate::Body<'_>, op: crate::OpId) -> alloc::vec::Vec<(crate::ValueId, alloc::borrow::Cow<'static, str>)> {
        let name = &*b[op].name;
        match name {
            // `<op>_<dimension>`: `%block_id_x`.
            "gpu.block_dim" | "gpu.block_id" | "gpu.cluster_block_id" | "gpu.cluster_dim" | "gpu.cluster_dim_blocks" | "gpu.cluster_id" | "gpu.global_id" | "gpu.grid_dim" | "gpu.thread_id" => {
                let dim = b[op].get("dimension").map(|a| alloc::format!("{a}")).unwrap_or_default();
                let dim = dim.trim_end_matches('>').rsplit([' ', '<']).next().unwrap_or_default();
                b.result_named(op, alloc::format!("{}_{dim}", &name[4..]))
            }
            _ => b.ods_result_names(op),
        }
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
