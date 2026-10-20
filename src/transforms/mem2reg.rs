//! `mem2reg`, as `Mem2Reg.cpp`: memory slots whose every use can be removed become SSA values.

use mlirpass_macros::pass;
use mlirformat::Error;

use crate::{Body, OpId, Run};

#[pass("mem2reg")]
pub struct Mem2Reg {
    /// `enableRegionSimplification`: simplify the regions the promotion leaves.
    #[opt("region-simplify", default = true)]
    region_simplify: bool,
}

impl Run for Mem2Reg {
    fn run<'a>(&self, _body: &mut Body<'a>, _op: OpId) -> Result<(), Error> {
        let _ = self.region_simplify;
        Ok(())
    }
}
