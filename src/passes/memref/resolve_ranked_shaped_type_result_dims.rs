//! `resolve-ranked-shaped-type-result-dims`, as `ResolveShapedTypeResultDims.cpp`: the
//! [`ResolveDims`] rules greedily.

use alloc::format;

use mlirformat::Error;

use crate::{pass, Body, GreedyConfig, OpId, PatternSet, ResolveDims, Run};

/// `resolve-ranked-shaped-type-result-dims`.
#[pass("resolve-ranked-shaped-type-result-dims")]
pub struct ResolveRankedShapedTypeResultDims {
    #[opt("error-on-pattern-iteration-limit", default = true)]
    error_on_limit: bool,
}

impl ResolveRankedShapedTypeResultDims {
    /// The rules greedily over `op`'s regions; a failure to converge is an error when asked.
    pub(crate) fn resolve(body: &mut Body<'_>, op: OpId, set: &PatternSet, error_on_limit: bool) -> Result<(), Error> {
        let mut converged = true;
        for r in body[op].regions.clone() {
            converged &= body.apply_greedily(r, set, &GreedyConfig::default());
        }
        if error_on_limit && !converged {
            return Err(Error(format!("'{}' op dim operation resolution hit pattern iteration limit", body[op].name)));
        }
        Ok(())
    }
}

impl Run for ResolveRankedShapedTypeResultDims {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let mut set = PatternSet::default();
        ResolveDims::patterns(&mut set);
        Self::resolve(body, op, &set, self.error_on_limit)
    }
}
