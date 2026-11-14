use mlirformat::Error;

use crate::{pass, Body, FoldAlias, GreedyConfig, OpId, PatternSet};

#[pass("fold-memref-alias-ops")]
pub fn fold_memref_alias_ops<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let mut set = PatternSet::default();
    FoldAlias::patterns(&mut set);
    for r in body[op].regions.clone() {
        body.apply_greedily(r, &set, &GreedyConfig::default());
    }
    Ok(())
}
