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
mod emit;
mod emitc;
mod equivalence;
mod fold;
mod greedy;
mod interfaces;
mod invocation;
mod layout;
mod ir;
mod llvm;
mod lower;
mod parallel;
mod pass;
mod region;
mod region_branch;
mod rewrite;
mod spirv;
mod symbol;
mod traits;
mod transforms;

pub use conversion::*;
pub use dialects::*;
pub use dominance::*;
pub use effects::*;
pub use emit::*;
pub use emitc::*;
pub use fold::*;
pub use greedy::*;
pub use interfaces::*;
pub use ir::*;
pub use llvm::*;
pub use lower::*;
pub use invocation::*;
pub use layout::*;
pub use parallel::*;
pub use pass::*;
pub use region_branch::*;
pub use rewrite::*;
pub use spirv::*;
pub use symbol::*;
pub use transforms::*;
pub use traits::*;
/// The proc macros (`mlirpass-macros`): `#[pass]`, `#[patterns]`, `#[ops]`, `blocks!`.
pub use mlirpass_macros::{blocks, ops, pass, patterns};
pub use mlirformat;
pub use mlirformat::{AffineBin, AffineExpr, AffineMap, ApFloat, ApInt, Const, IntegerSet, Scalar};
