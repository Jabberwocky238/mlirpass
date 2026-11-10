//! `convert-vector-to-xegpu`.

use crate::{pass, Body, GreedyConfig, OpId, PrepareVectorToMma, VectorToXegpu};

/// `convert-vector-to-xegpu`, as `ConvertVectorToXeGPUPass`: allocas into SLM, then [`VectorToXegpu`] and
/// [`PrepareVectorToMma`] greedily.
#[pass("convert-vector-to-xegpu")]
pub struct ConvertVectorToXegpu;

impl crate::Run for ConvertVectorToXegpu {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), mlirformat::Error> {
        // Allocations into shared local memory first, for `load_matrix` / `store_matrix`.
        PrepareVectorToMma::promote_allocas(body, op);
        let mut set = crate::PatternSet::default();
        VectorToXegpu::patterns(&mut set);
        PrepareVectorToMma::patterns(&mut set);
        for r in body[op].regions.clone() {
            body.apply_greedily(r, &set, &GreedyConfig::default());
        }
        Ok(())
    }
}
