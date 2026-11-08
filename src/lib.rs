//! MLIR passes on top of [`mlirformat`]: mutable IR, pattern rewriting, dialect conversion, the
//! pass manager, and the upstream lowerings and transforms.
//!
//! mlirformat owns the syntax (text ⇄ [`Module`](mlirformat::Module) ⇄ typed ops); this crate
//! owns the semantics. Behavior follows `mlir-opt` 22.1.8.
//!
//! `no_std` compatible (needs `alloc`).

#![no_std]

extern crate alloc;
#[cfg(feature = "std")]
extern crate std;

mod aliases;
#[cfg(feature = "dialect.bufferization")]
mod bufferize;
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
pub use conversion::*;
pub use diag::{Diagnostic, Note, Severity};
// (nothing without a dialect feature)
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
/// The proc macros (`mlirpass-macros`): `#[pass]`, `#[patterns]`, `#[ops]`, `blocks!`.
pub use mlirpass_macros::{blocks, ops, pass, patterns};
pub use mlirformat;
pub use mlirformat::{AffineBin, AffineExpr, AffineMap, ApFloat, ApInt, Const, IntegerSet, Scalar};
