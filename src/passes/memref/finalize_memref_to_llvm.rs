use crate::{llvm_target};
use crate::{LlvmConverter, LlvmOptions, MemrefOptions, MemrefToLlvm};
use crate::pass;
use mlirformat::Error;
use crate::{Body, ConversionConfig, ConversionPatterns, Converter, Mode, OpId, Run};

#[pass("finalize-memref-to-llvm")]
pub struct FinalizeMemrefToLlvm {
    #[opt("use-aligned-alloc")]
    aligned_alloc: bool,
    #[opt("index-bitwidth")]
    index_bitwidth: u32,
    #[opt("use-generic-functions")]
    generic: bool,
}

impl Run for FinalizeMemrefToLlvm {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let options = MemrefOptions { llvm: LlvmOptions::bitwidth(self.index_bitwidth).at(body, op), aligned_alloc: self.aligned_alloc, generic: self.generic };
        let tc = LlvmConverter::build(options.llvm);
        let mut patterns = ConversionPatterns::default();
        let i = patterns.converter(&tc);
        MemrefToLlvm::populate(&mut patterns, i, options);
        let mut target = llvm_target();
        target.legal_op("func.func");
        Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
    }
}
