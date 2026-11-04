//! `convert-ub-to-llvm`.

use crate::{LlvmConverter, LlvmOptions, UbToLlvm};
use crate::pass;
use mlirformat::Error;
use crate::{Action, Body, ConversionConfig, ConversionPatterns, ConversionTarget, Converter, Mode, OpId, Run};

/// `convert-ub-to-llvm`.
#[pass("convert-ub-to-llvm")]
pub struct ConvertUbToLlvm {
    #[opt("index-bitwidth")]
    index_bitwidth: u32,
}

impl Run for ConvertUbToLlvm {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let tc = LlvmConverter::build(LlvmOptions::bitwidth(self.index_bitwidth).at(body, op));
        let mut patterns = ConversionPatterns::default();
        let i = patterns.converter(&tc);
        UbToLlvm::populate(&mut patterns, i);
        let mut target = ConversionTarget::default();
        target.legal_dialect("llvm").op("builtin.unrealized_conversion_cast", Action::Legal);
        Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
    }
}
