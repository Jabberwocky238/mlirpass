//! `convert-vector-to-scf`.

use crate::pass;
use mlirformat::Error;
use crate::{Body, GreedyConfig, OpId, PatternSet, Run, VectorToScfOptions};

/// `convert-vector-to-scf`.
#[pass("convert-vector-to-scf")]
pub struct ConvertVectorToScf {
    #[opt("full-unroll")]
    unroll: bool,
    #[opt("target-rank", default = 1)]
    target_rank: usize,
    #[opt("lower-tensors")]
    lower_tensors: bool,
    #[opt("lower-scalable")]
    lower_scalable: bool,
}

impl Run for ConvertVectorToScf {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let o = VectorToScfOptions { unroll: self.unroll, target_rank: self.target_rank, lower_tensors: self.lower_tensors, lower_scalable: self.lower_scalable };
        let mut first = PatternSet::default();
        o.prepare_patterns(&mut first);
        for r in body[op].regions.clone() {
            body.apply_greedily(r, &first, &GreedyConfig::default());
        }
        let mut set = PatternSet::default();
        o.patterns(&mut set);
        for r in body[op].regions.clone() {
            body.apply_greedily(r, &set, &GreedyConfig::default());
        }
        Ok(())
    }
}
