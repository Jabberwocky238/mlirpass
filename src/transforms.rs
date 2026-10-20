//! Dialect-independent passes, as `mlir/lib/Transforms`.

mod buffer_results_to_out_params;
mod canonicalize;
mod cse;
mod expand_strided_metadata;
mod licm;
mod mem2reg;
mod memslot;
mod promote_buffers;
mod remove_dead_values;
mod request_c_wrappers;
mod sccp;
mod sroa;
mod strip_debuginfo;
mod symbol_dce;
mod symbol_privatize;

pub use buffer_results_to_out_params::BufferResultsToOutParams;
pub use canonicalize::Canonicalize;
pub use cse::Cse;
pub use expand_strided_metadata::ExpandStridedMetadata;
pub use licm::LoopInvariantCodeMotion;
pub use mem2reg::Mem2Reg;
pub use memslot::{Deletion, DestructurableMemorySlot, MemorySlot, Promotable};
pub use promote_buffers::PromoteBuffersToStack;
pub use remove_dead_values::RemoveDeadValues;
pub use request_c_wrappers::RequestCWrappers;
pub use sccp::Sccp;
pub use sroa::Sroa;
pub use strip_debuginfo::StripDebugInfo;
pub use symbol_dce::SymbolDce;
pub use symbol_privatize::SymbolPrivatize;
