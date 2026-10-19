//! Every pass `mlir-opt` can name, with the op it is anchored on (`Passes.td`'s `Pass<"name", "op">`).

use alloc::boxed::Box;

use mlirformat::Error;

use super::{Options, Pass};
use crate::lower::*;
use crate::transforms::*;

/// A registered pass.
pub struct PassInfo {
    pub name: &'static str,
    /// The op it runs on; `None`: any op.
    pub anchor: Option<&'static str>,
    pub make: fn(&Options<'_>) -> Result<Box<dyn Pass>, Error>,
}

impl PassInfo {
    pub fn find(name: &str) -> Option<&'static PassInfo> {
        PASSES.iter().find(|p| p.name == name)
    }
}

macro_rules! registry {
    (@anchor) => { None };
    (@anchor $on:literal) => { Some($on) };
    ($($name:literal $(on $on:literal)? => $ty:ty,)*) => {
        /// The registry, by `mlir-opt` argument.
        pub const PASSES: &[PassInfo] = &[$(PassInfo {
            name: $name,
            anchor: registry!(@anchor $($on)?),
            make: |o| Ok(Box::new(<$ty>::try_from(o)?)),
        },)*];
    };
}

registry! {
    "convert-arith-to-llvm" => ConvertArithToLlvm,
    "convert-to-llvm" => ConvertToLlvm,
    "reconcile-unrealized-casts" => ReconcileUnrealizedCasts,
    "canonicalize" => Canonicalize,
    "cse" => Cse,
    "strip-debuginfo" => StripDebugInfo,
    "symbol-dce" => SymbolDce,
    "symbol-privatize" => SymbolPrivatize,
}
