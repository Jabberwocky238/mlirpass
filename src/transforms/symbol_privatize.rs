//! `symbol-privatize`: the op's top-level symbols become private, but those in `exclude`.

use alloc::string::String;
use alloc::vec::Vec;

use mlirpass_macros::pass;
use mlirformat::Error;

use crate::{Body, OpId, Run, Visibility};

#[pass("symbol-privatize")]
pub struct SymbolPrivatize {
    #[opt("exclude")]
    exclude: Vec<String>,
}

impl Run for SymbolPrivatize {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        for child in body.children(op) {
            if body.sym_name(child).is_some_and(|n| !self.exclude.iter().any(|e| e == n)) {
                body.set_visibility(child, Visibility::Private);
            }
        }
        Ok(())
    }
}
