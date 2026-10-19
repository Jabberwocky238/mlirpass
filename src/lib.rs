//! MLIR passes on top of [`mlirformat`]: mutable IR, pattern rewriting, dialect conversion, the
//! pass manager, and the upstream lowerings and transforms.
//!
//! mlirformat owns the syntax (text ⇄ [`Module`](mlirformat::Module) ⇄ typed ops); this crate
//! owns the semantics. Behavior follows `mlir-opt` 22.1.8.
//!
//! `no_std` compatible (needs `alloc`).

#![no_std]

extern crate alloc;

mod dominance;
mod effects;
mod equivalence;
mod invocation;
mod ir;
mod pass;
mod symbol;
mod traits;
mod transforms;

pub use dominance::*;
pub use effects::*;
pub use ir::*;
pub use invocation::*;
pub use pass::*;
pub use symbol::*;
pub use transforms::*;
pub use traits::*;
pub use mlirformat;
