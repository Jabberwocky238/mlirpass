use mlirformat::Error;

use crate::{pass, Body, OpId, PatternSet, ResolveDims, ResolveRankedShapedTypeResultDims, Run};

#[pass("resolve-shaped-type-result-dims")]
pub struct ResolveShapedTypeResultDims {
    #[opt("error-on-pattern-iteration-limit", default = true)]
    error_on_limit: bool,
}

impl Run for ResolveShapedTypeResultDims {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let mut set = PatternSet::default();
        ResolveDims::patterns(&mut set);
        ResolveRankedShapedTypeResultDims::resolve(body, op, &set, self.error_on_limit)
    }
}
