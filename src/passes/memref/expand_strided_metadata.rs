//! `expand-strided-metadata`, as `ExpandStridedMetadata.cpp`: [`StridedMetadata`] greedily.

use crate::{pass, Body, GreedyConfig, OpId, StridedMetadata};

#[pass("expand-strided-metadata")]
pub struct ExpandStridedMetadata;

impl crate::Run for ExpandStridedMetadata {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), mlirformat::Error> {
        let set = StridedMetadata::patterns();
        for r in body[op].regions.clone() {
            body.apply_greedily(r, &set, &GreedyConfig::default());
        }
        Ok(())
    }
}

