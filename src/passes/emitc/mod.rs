//! `emitc` passes.

use crate::{ConvertArithToEmitc, ConvertFuncToEmitc, ConvertMathToEmitc, ConvertMemrefToEmitc, ConvertScfToEmitc};
mod convert_to_emitc;
pub use convert_to_emitc::*;

/// Every lowering to `emitc`.
#[crate::pass_set(ConvertArithToEmitc, ConvertFuncToEmitc, ConvertMathToEmitc, ConvertMemrefToEmitc, ConvertScfToEmitc, ConvertToEmitc)]
pub struct EmitcPasses;
