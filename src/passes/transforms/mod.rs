mod canonicalize;
mod cse;
mod dataflow;
mod inline;
mod licm;
mod reconcile_unrealized_casts;
mod mem2reg;
#[cfg(feature = "dialect.llvm")]
mod llvm_slots;
#[cfg(feature = "dialect.memref")]
mod memref_slots;
mod memslot;
#[cfg(feature = "dialect.scf")]
mod scf_slots;
mod remove_dead_values;
mod sccp;
mod sroa;
mod strip_debuginfo;
mod symbol_dce;
mod symbol_privatize;

pub use canonicalize::Canonicalize;
pub use cse::Cse;
pub use inline::Inline;
pub use reconcile_unrealized_casts::ReconcileUnrealizedCasts;
pub use licm::LoopInvariantCodeMotion;
pub use mem2reg::Mem2Reg;
#[cfg(feature = "dialect.llvm")]
pub use llvm_slots::LlvmSlots;
#[cfg(all(feature = "dialect.memref", feature = "dialect.test"))]
pub use memref_slots::TestSlots;
#[cfg(feature = "dialect.memref")]
pub use memslot::MemrefSlots;
pub use memslot::{Deletion, Destructurable, DestructurableMemorySlot, MemorySlot, Promotable, Slots};
#[cfg(feature = "dialect.scf")]
pub use scf_slots::ScfSlots;
pub use remove_dead_values::RemoveDeadValues;
pub use sccp::Sccp;
pub use sroa::Sroa;
pub use strip_debuginfo::StripDebugInfo;
pub use symbol_dce::SymbolDce;
pub use symbol_privatize::SymbolPrivatize;
