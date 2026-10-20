//! `strip-debuginfo`: every location becomes `unknown`.

use mlirpass_macros::pass;
use mlirformat::{Error, Str};

use crate::{Body, OpId};

#[pass("strip-debuginfo", ty = StripDebugInfo)]
pub fn strip_debuginfo<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    body.set_locs(op, Some("unknown".into()));
    Ok(())
}

impl<'a> Body<'a> {
    /// Sets the location of `op`, every op in it, and their block arguments.
    pub fn set_locs(&mut self, op: OpId, loc: Option<Str<'a>>) {
        for o in self.ops_in(op) {
            self[o].loc = loc.clone();
            let args: alloc::vec::Vec<_> = self[o].regions.iter().flat_map(|r| &self[*r].blocks).flat_map(|b| self[*b].args.clone()).collect();
            args.into_iter().for_each(|v| self[v].loc = loc.clone());
        }
    }
}
