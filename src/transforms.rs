//! Dialect-independent passes, as `mlir/lib/Transforms`.

mod canonicalize;
mod cse;
mod request_c_wrappers;
mod strip_debuginfo;
mod symbol_dce;
mod symbol_privatize;

pub use canonicalize::Canonicalize;
pub use cse::Cse;
pub use request_c_wrappers::RequestCWrappers;
pub use strip_debuginfo::StripDebugInfo;
pub use symbol_dce::SymbolDce;
pub use symbol_privatize::SymbolPrivatize;
