//! `linalg-fold-unit-extent-dims`, as `Linalg/Transforms/DropUnitDims.cpp`: the
//! [`DropUnitDimsStrategy`] rules through `walkAndApplyPatterns`, then its canonicalizations greedily.

use mlirformat::Error;

use crate::{pass, Body, DropUnitDimsStrategy as Strategy, GreedyConfig, OpId, Run};

/// `linalg-fold-unit-extent-dims`.
#[pass("linalg-fold-unit-extent-dims")]
pub struct LinalgFoldUnitExtentDims {
    #[opt("use-rank-reducing-slices")]
    rank_reducing_slices: bool,
}

impl Run for LinalgFoldUnitExtentDims {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let s = if self.rank_reducing_slices { Strategy::ExtractInsertSlice } else { Strategy::ReassociativeReshape };
        body.walk_and_apply(op, &s.patterns());
        let set = s.canonicalizations();
        for r in body[op].regions.clone() {
            body.apply_greedily(r, &set, &GreedyConfig::default());
        }
        Ok(())
    }
}

