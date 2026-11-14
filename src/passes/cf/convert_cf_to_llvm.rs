use crate::{llvm_target};
use crate::{AssertLowering, CfToLlvm, LlvmConverter, LlvmOptions};
use crate::pass;
use mlirformat::Error;
use crate::{Action, Body, ConversionConfig, ConversionPatterns, Converter, Mode, OpId, Run};

#[pass("convert-cf-to-llvm")]
pub struct ConvertCfToLlvm {
    #[opt("index-bitwidth")]
    index_bitwidth: u32,
    counter: core::sync::atomic::AtomicU32,
}

impl Run for ConvertCfToLlvm {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let tc = LlvmConverter::build(LlvmOptions::bitwidth(self.index_bitwidth).at(body, op));
        let mut patterns = ConversionPatterns::default();
        let i = patterns.converter(&tc);
        CfToLlvm::populate(&mut patterns, i);
        patterns.add_with(i, AssertLowering(&self.counter));
        let mut target = llvm_target();
        target.unknown(Action::Dynamic(alloc::boxed::Box::new(|b: &Body<'_>, o: OpId| Some(!b[o].name.starts_with("cf.")))));
        Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
    }
}
