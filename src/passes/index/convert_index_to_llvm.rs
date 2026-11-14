use crate::{IndexToLlvm, LlvmConverter, LlvmOptions};
use crate::pass;
use mlirformat::Error;
use crate::{Body, ConversionConfig, ConversionPatterns, ConversionTarget, Converter, Mode, OpId, Run};

#[pass("convert-index-to-llvm")]
pub struct ConvertIndexToLlvm {
    #[opt("index-bitwidth")]
    index_bitwidth: u32,
}

impl Run for ConvertIndexToLlvm {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let tc = LlvmConverter::build(LlvmOptions::bitwidth(self.index_bitwidth).at(body, op));
        let mut patterns = ConversionPatterns::default();
        let i = patterns.converter(&tc);
        IndexToLlvm::populate(&mut patterns, i);
        let mut target = ConversionTarget::default();
        target.illegal_dialect("index").legal_dialect("llvm");
        Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
    }
}
