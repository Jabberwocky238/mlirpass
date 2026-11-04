//! `resolve-shaped-type-result-dims`, as `ResolveShapedTypeResultDims.cpp`: the [`ResolveDims`]
//! rules and `DimOfShapedTypeOpInterface` greedily. No op this crate describes implements
//! `InferShapedTypeOpInterface::reifyReturnTypeShapes`, so the latter never applies.

use mlirformat::Error;

use crate::{pass, Body, OpId, PatternSet, ResolveDims, ResolveRankedShapedTypeResultDims, Run};

/// `resolve-shaped-type-result-dims`.
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
