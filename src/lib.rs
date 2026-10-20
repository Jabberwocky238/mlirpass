//! MLIR passes on top of [`mlirformat`]: mutable IR, pattern rewriting, dialect conversion, the
//! pass manager, and the upstream lowerings and transforms.
//!
//! mlirformat owns the syntax (text ⇄ [`Module`](mlirformat::Module) ⇄ typed ops); this crate
//! owns the semantics. Behavior follows `mlir-opt` 22.1.8.
//!
//! `no_std` compatible (needs `alloc`).

#![no_std]

extern crate alloc;

mod branch;
#[macro_use]
mod canon;
mod conversion;
mod data_layout;
mod dataflow;
mod dominance;
mod effects;
mod equivalence;
mod fold;
mod greedy;
mod invocation;
mod ir;
mod llvm;
mod lower;
mod pass;
mod region;
mod region_branch;
mod rewrite;
mod symbol;
mod traits;
mod transforms;

pub use conversion::*;
pub use data_layout::DataLayout;
pub use dominance::*;
pub use effects::*;
pub use fold::*;
pub use greedy::*;
pub use ir::*;
pub use llvm::*;
pub use lower::*;
pub use invocation::*;
pub use pass::*;
pub use region_branch::*;
pub use rewrite::*;
pub use symbol::*;
pub use transforms::*;
pub use traits::*;
pub use mlirformat;
pub use mlirformat::{AffineBin, AffineExpr, AffineMap, ApFloat, ApInt, Const, IntegerSet, Scalar};
