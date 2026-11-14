use crate::{pass, Body, GreedyConfig, OpId, PrepareVectorToMma, VectorToXegpu};

#[pass("convert-vector-to-xegpu")]
pub struct ConvertVectorToXegpu;

impl crate::Run for ConvertVectorToXegpu {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), mlirformat::Error> {
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
