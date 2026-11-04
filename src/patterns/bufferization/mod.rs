//! `bufferization` rule sets.

mod canonicalize;
mod to_memref;

pub use canonicalize::BufferizationCanon;
pub use to_memref::{BufferizationToMemref};
