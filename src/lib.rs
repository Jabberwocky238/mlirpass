#![no_std]

extern crate alloc;
#[cfg(feature = "std")]
extern crate std;

mod aliases;
#[cfg(feature = "dialect.bufferization")]
mod bufferize;
mod cfg_to_scf;
mod conversion;
mod diag;
mod dialects;
mod interfaces;
mod ir;
mod layout;
mod pass;
#[path = "registry.gen.rs"]
mod registry;
mod passes;
mod patterns;
mod region;
mod rewrite;
mod targets;
mod typed;

#[cfg(feature = "dialect.bufferization")]
pub use bufferize::*;
pub use cfg_to_scf::{transform_cfg_to_scf, At as CfgAt, CfgToScfInterface};
pub use conversion::*;
pub use diag::{Diagnostic, Note, Severity};

#[allow(unused_imports)]
pub use dialects::*;
pub use interfaces::*;
pub use ir::*;
pub use layout::*;
pub use pass::*;
pub use passes::*;
pub use patterns::*;
pub use region::*;
pub use rewrite::*;
pub use targets::*;
pub use typed::*;

pub use mlirpass_macros::{blocks, ops, pass, patterns};
pub use mlirformat;
pub use mlirformat::{AffineBin, AffineExpr, AffineMap, ApFloat, ApInt, Const, IntegerSet, Scalar};
