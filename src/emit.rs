//! ⭐ Out of MLIR, as `mlir-translate`'s translations: a target turns an op (a module) into
//! what it emits — SPIR-V words, GLSL text, or a format of one's own.

use mlirformat::Error;

use crate::{Body, OpId};

/// ⭐ A target `op` translates into.
pub trait Emit {
    type Output;

    fn emit(&self, body: &Body<'_>, op: OpId) -> Result<Self::Output, Error>;
}
