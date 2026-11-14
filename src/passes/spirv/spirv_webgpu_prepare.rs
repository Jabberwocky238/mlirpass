use mlirformat::Error;
use crate::{Body, OpId};

#[crate::pass("spirv-webgpu-prepare", on = "spirv.module")]
pub fn spirv_webgpu_prepare<'a>(body: &mut Body<'a>, module: OpId) -> Result<(), Error> {
    let mut patterns = crate::PatternSet::default();
    crate::WebgpuPrepare::patterns(&mut patterns);
    for r in body[module].regions.clone() {
        body.apply_greedily(r, &patterns, &crate::GreedyConfig::default());
    }
    Ok(())
}
