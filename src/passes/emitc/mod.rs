//! `emitc` passes.

mod convert_to_emitc;
pub use convert_to_emitc::*;

/// The `emitc` passes.
#[crate::pass_set(ConvertToEmitc)]
pub struct EmitcPasses;
