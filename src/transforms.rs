//! Dialect-independent passes, as `mlir/lib/Transforms`.

mod canonicalize;
mod cse;
mod expand_strided_metadata;
mod licm;
mod promote_buffers;
mod remove_dead_values;
mod request_c_wrappers;
mod sccp;
mod strip_debuginfo;
mod symbol_dce;
mod symbol_privatize;

pub use canonicalize::Canonicalize;
pub use cse::Cse;
pub use expand_strided_metadata::ExpandStridedMetadata;
pub use licm::LoopInvariantCodeMotion;
pub use promote_buffers::PromoteBuffersToStack;
pub use remove_dead_values::RemoveDeadValues;
pub use request_c_wrappers::RequestCWrappers;
pub use sccp::Sccp;
pub use strip_debuginfo::StripDebugInfo;
pub use symbol_dce::SymbolDce;
pub use symbol_privatize::SymbolPrivatize;
