use crate::{llvm_target};
use crate::{FuncToLlvm, LlvmConverter, LlvmOptions};
use crate::pass;
use mlirformat::Error;
use crate::{Body, ConversionConfig, ConversionPatterns, Converter, Mode, OpId, Run};

#[pass("convert-func-to-llvm", on = "builtin.module")]
pub struct ConvertFuncToLlvm {
    #[opt("use-bare-ptr-memref-call-conv")]
    bare_ptr: bool,
    #[opt("index-bitwidth")]
    index_bitwidth: u32,
}

impl Run for ConvertFuncToLlvm {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let options = LlvmOptions { index_bitwidth: self.index_bitwidth, bare_ptr: self.bare_ptr, ..LlvmOptions::default() }.at(body, op);
        let registry = LlvmConverter::identified_in(body, op);
        let mut tc = LlvmConverter::build(options);
        LlvmConverter::with_identified(&mut tc, options, &registry);
        let mut patterns = ConversionPatterns::default();
        let i = patterns.converter(&tc);
        FuncToLlvm::populate(&mut patterns, i, options);
        let target = llvm_target();
        Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
    }
}
