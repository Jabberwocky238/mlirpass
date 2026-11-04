//! `convert-vector-to-xegpu`.

use crate::{pass, Body, GreedyConfig, OpId, VectorToXegpu};

/// `convert-vector-to-xegpu`, as `ConvertVectorToXeGPUPass`: [`VectorToXegpu`] greedily.
#[pass("convert-vector-to-xegpu")]
pub struct ConvertVectorToXegpu;

impl crate::Run for ConvertVectorToXegpu {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), mlirformat::Error> {
        let mut set = crate::PatternSet::default();
        VectorToXegpu::patterns(&mut set);
        for r in body[op].regions.clone() {
            body.apply_greedily(r, &set, &GreedyConfig::default());
        }
        Ok(())
    }
}
