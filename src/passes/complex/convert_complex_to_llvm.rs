//! `convert-complex-to-llvm`.

use crate::{ComplexToLlvm, LlvmConverter, LlvmOptions};
use crate::pass;
use mlirformat::Error;
use crate::{Body, ComplexRange, ConversionConfig, ConversionPatterns, ConversionTarget, Converter, Mode, OpId, Run};

/// `convert-complex-to-llvm`.
#[pass("convert-complex-to-llvm")]
pub struct ConvertComplexToLlvm {
    #[opt("complex-range", default = ComplexRange::Basic, from_str)]
    range: ComplexRange,
}

impl Run for ConvertComplexToLlvm {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let tc = LlvmConverter::build(LlvmOptions::derived().at(body, op));
        let mut patterns = ConversionPatterns::default();
        let i = patterns.converter(&tc);
        ComplexToLlvm::populate(&mut patterns, i, self.range == ComplexRange::Improved);
        let mut target = ConversionTarget::default();
        target.legal_dialect("llvm").illegal_dialect("complex");
        Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
    }
}
