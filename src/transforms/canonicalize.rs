//! `canonicalize`: folds and canonicalization patterns, greedily, as `Canonicalizer.cpp`.

use alloc::string::String;
use alloc::vec::Vec;

use mlirformat::Error;

use crate::{Body, GreedyConfig, OpId, Options, Pass, RegionSimplify};

pub struct Canonicalize {
    config: GreedyConfig,
    test_convergence: bool,
    disabled: Vec<String>,
    enabled: Vec<String>,
}

impl TryFrom<&Options<'_>> for Canonicalize {
    type Error = Error;
    fn try_from(o: &Options<'_>) -> Result<Self, Error> {
        o.only("canonicalize", &["top-down", "region-simplify", "max-iterations", "max-num-rewrites", "test-convergence", "disable-patterns", "enable-patterns", "cse-constants", "fold"])?;
        let region_simplify = match o.get("region-simplify").unwrap_or("normal") {
            "disabled" => RegionSimplify::Disabled,
            "normal" => RegionSimplify::Normal,
            "aggressive" => RegionSimplify::Aggressive,
            v => return Err(Error(alloc::format!("canonicalize: bad region-simplify `{v}`"))),
        };
        let limit = |v: i64| (v >= 0).then_some(v as u64);
        let config = GreedyConfig {
            top_down: o.flag("top-down", true)?,
            region_simplify,
            max_iterations: limit(o.value("max-iterations", 10i64)?),
            max_rewrites: limit(o.value("max-num-rewrites", -1i64)?),
            fold: o.flag("fold", true)?,
            cse_constants: o.flag("cse-constants", true)?,
        };
        let names = |k| o.list(k).into_iter().map(String::from).collect();
        Ok(Self { config, test_convergence: o.flag("test-convergence", false)?, disabled: names("disable-patterns"), enabled: names("enable-patterns") })
    }
}

impl Pass for Canonicalize {
    fn name(&self) -> &str {
        "canonicalize"
    }

    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let mut patterns = crate::canon::patterns();
        patterns.retain(|p| !self.disabled.iter().any(|d| d == p.name()) && (self.enabled.is_empty() || self.enabled.iter().any(|e| e == p.name())));
        for r in body[op].regions.clone() {
            let converged = body.apply_greedily(r, &patterns, &self.config);
            if !converged && self.test_convergence {
                return Err(Error("Canonicalizer failed to converge".into()));
            }
        }
        Ok(())
    }
}
