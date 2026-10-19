//! `symbol-privatize`: the op's top-level symbols become private, but those in `exclude`.

use alloc::string::String;
use alloc::vec::Vec;

use mlirformat::Error;

use crate::{Body, OpId, Options, Pass, Visibility};

pub struct SymbolPrivatize {
    exclude: Vec<String>,
}

impl TryFrom<&Options<'_>> for SymbolPrivatize {
    type Error = Error;
    fn try_from(o: &Options<'_>) -> Result<Self, Error> {
        let exclude = o.only("symbol-privatize", &["exclude"])?.list("exclude").into_iter().map(String::from).collect();
        Ok(Self { exclude })
    }
}

impl Pass for SymbolPrivatize {
    fn name(&self) -> &str {
        "symbol-privatize"
    }

    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        for child in body.children(op) {
            if body.sym_name(child).is_some_and(|n| !self.exclude.iter().any(|e| e == n)) {
                body.set_visibility(child, Visibility::Private);
            }
        }
        Ok(())
    }
}
