//! `spirv-canonicalize-gl`.

use mlirformat::Error;
use crate::{Body, OpId};

/// `spirv-canonicalize-gl`: the GLSL canonicalization patterns, greedily.
#[crate::pass("spirv-canonicalize-gl")]
pub fn spirv_canonicalize_gl<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let mut patterns = crate::PatternSet::default();
    crate::SpirvCanon::gl_patterns(&mut patterns);
    for r in body[op].regions.clone() {
        body.apply_greedily(r, &patterns, &crate::GreedyConfig::default());
    }
    Ok(())
}
