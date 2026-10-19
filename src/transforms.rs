//! Dialect-independent passes, as `mlir/lib/Transforms`.

mod strip_debuginfo;
mod symbol_dce;
mod symbol_privatize;

pub use strip_debuginfo::StripDebugInfo;
pub use symbol_dce::SymbolDce;
pub use symbol_privatize::SymbolPrivatize;
