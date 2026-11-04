//! Dialect-independent passes (and the memory-slot interfaces of `mem2reg` / `sroa`), as `mlir/lib/Transforms`.

mod canonicalize;
mod cse;
mod inline;
mod licm;
mod mem2reg;
mod memref_slots;
mod memslot;
mod remove_dead_values;
mod sccp;
mod sroa;
mod strip_debuginfo;
mod symbol_dce;
mod symbol_privatize;

pub use canonicalize::Canonicalize;
pub use cse::Cse;
pub use inline::Inline;
pub use licm::LoopInvariantCodeMotion;
pub use mem2reg::Mem2Reg;
pub use memslot::{Deletion, Destructurable, DestructurableMemorySlot, MemorySlot, Promotable, Slots};
pub use remove_dead_values::RemoveDeadValues;
pub use sccp::Sccp;
pub use sroa::Sroa;
pub use strip_debuginfo::StripDebugInfo;
pub use symbol_dce::SymbolDce;
pub use symbol_privatize::SymbolPrivatize;

/// The dialect-independent transforms, as `mlir/lib/Transforms`.
#[crate::pass_set(Canonicalize, Cse, Inline, LoopInvariantCodeMotion, Mem2Reg, RemoveDeadValues, Sccp, Sroa, StripDebugInfo, SymbolDce, SymbolPrivatize)]
pub struct TransformPasses;
