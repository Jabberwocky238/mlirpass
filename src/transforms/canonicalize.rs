//! `canonicalize`: folds and canonicalization patterns, greedily, as `Canonicalizer.cpp`.

use alloc::string::String;
use alloc::vec::Vec;

use mlirpass_macros::pass;
use mlirformat::Error;

use crate::{Body, GreedyConfig, OpId, Run, RegionSimplify};

#[pass("canonicalize")]
pub struct Canonicalize {
    #[opt("top-down", default = true)]
    top_down: bool,
    #[opt("region-simplify", default = RegionSimplify::Normal, from_str)]
    region_simplify: RegionSimplify,
    #[opt("max-iterations", default = 10)]
    max_iterations: i64,
    #[opt("max-num-rewrites", default = -1)]
    max_rewrites: i64,
    #[opt("test-convergence")]
    test_convergence: bool,
    #[opt("disable-patterns")]
    disabled: Vec<String>,
    #[opt("enable-patterns")]
    enabled: Vec<String>,
    #[opt("cse-constants", default = true)]
    cse_constants: bool,
    #[opt("fold", default = true)]
    fold: bool,
}

impl Canonicalize {
    /// The `GreedyRewriteConfig` the options make (a negative limit is no limit).
    fn config(&self) -> GreedyConfig {
        let limit = |v: i64| (v >= 0).then_some(v as u64);
        GreedyConfig { top_down: self.top_down, region_simplify: self.region_simplify, max_iterations: limit(self.max_iterations), max_rewrites: limit(self.max_rewrites), fold: self.fold, cse_constants: self.cse_constants }
    }
}

impl Run for Canonicalize {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let mut patterns = crate::canon::patterns();
        patterns.retain(|p| !self.disabled.iter().any(|d| d == p.name()) && (self.enabled.is_empty() || self.enabled.iter().any(|e| e == p.name())));
        for r in body[op].regions.clone() {
            let converged = body.apply_greedily(r, &patterns, &self.config());
            if !converged && self.test_convergence {
                return Err(Error("Canonicalizer failed to converge".into()));
            }
        }
        Ok(())
    }
}
