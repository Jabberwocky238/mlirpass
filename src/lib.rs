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

mod branch;
#[macro_use]
mod canon;
mod conversion;
mod dataflow;
mod dialects;
mod dominance;
mod effects;
mod emits;
mod equivalence;
mod greedy;
mod interfaces;
mod invocation;
mod layout;
mod ir;
mod lower;
mod parallel;
mod pass;
mod region;
mod rewrite;
mod symbol;
mod transforms;
mod verify;

pub use branch::*;
pub use canon::{Fold, Folded};
pub use conversion::*;
pub use dialects::*;
pub use dominance::*;
pub use effects::*;
pub use emits::*;
pub use greedy::*;
pub use interfaces::*;
pub use ir::*;
pub use lower::*;
pub use invocation::*;
pub use layout::*;
pub use parallel::*;
pub use pass::*;
pub use rewrite::*;
pub use symbol::*;
pub use transforms::*;
/// The proc macros (`mlirpass-macros`): `#[pass]`, `#[patterns]`, `#[ops]`, `blocks!`.
pub use mlirpass_macros::{blocks, ops, pass, patterns};
pub use mlirformat;
pub use mlirformat::{AffineBin, AffineExpr, AffineMap, ApFloat, ApInt, Const, IntegerSet, Scalar};
