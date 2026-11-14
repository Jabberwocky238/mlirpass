use crate::{llvm_target};
use crate::{ArithToLlvm, LlvmConverter, LlvmOptions};
use crate::pass;
use mlirformat::Error;
use crate::{Body, ConversionConfig, ConversionPatterns, Converter, Mode, OpId, Run};

#[pass("convert-arith-to-llvm")]
pub struct ConvertArithToLlvm {
    #[opt("index-bitwidth")]
    index_bitwidth: u32,
}

impl Run for ConvertArithToLlvm {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let tc = LlvmConverter::build(LlvmOptions::bitwidth(self.index_bitwidth).at(body, op));
        let mut patterns = ConversionPatterns::default();
        let i = patterns.converter(&tc);
        ArithToLlvm::populate(&mut patterns, i);
        let target = llvm_target();
        Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
    }
}
