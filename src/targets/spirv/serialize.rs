use alloc::vec;
use alloc::vec::Vec;

use mlirbinary::{SpirvReader, SpirvWriter};
use mlirformat::{Error, Item, Module};

use crate::{Body, Ctx, Emit, OpId};

/// A `spirv.module` as SPIR-V words and back, through mlirbinary (as `mlir-translate
/// --serialize-spirv` / `--deserialize-spirv`)
#[derive(Debug, Clone, Copy)]
pub struct SpirvBinary {
    /// `OpName`s for the module's symbols
    pub symbol_names: bool,
}

impl Default for SpirvBinary {
    fn default() -> Self {
        Self { symbol_names: true }
    }
}

impl SpirvBinary {
    /// A terminator's attribute naming the block a selection merges at
    pub const SELECTION_MERGE: &'static str = SpirvWriter::SELECTION_MERGE;

    pub fn bytes(words: &[u32]) -> Vec<u8> {
        SpirvWriter::bytes(words)
    }

    /// The `spirv.module` SPIR-V `bytes` hold, as a body of its own
    pub fn read<'a>(ctx: Ctx<'a>, bytes: &[u8]) -> Result<Body<'a>, Error> {
        let op = SpirvReader::read(bytes)?;
        Body::import(ctx, Module { items: vec![Item::Op(op)] })
    }
}

impl Emit for SpirvBinary {
    type Output = Vec<u32>;

    fn emit(&self, body: &Body<'_>, op: OpId) -> Result<Vec<u32>, Error> {
        SpirvWriter { symbol_names: self.symbol_names }.words(&body.operation(op))
    }
}
