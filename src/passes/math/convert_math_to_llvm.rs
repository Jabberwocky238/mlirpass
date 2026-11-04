//! `convert-math-to-llvm`.

use crate::{llvm_target};
use crate::{LlvmConverter, LlvmOptions, MathToLlvm};
use crate::pass;
use mlirformat::Error;
use crate::{Body, ConversionConfig, ConversionPatterns, Converter, Mode, OpId, Run};

/// `convert-math-to-llvm`.
#[pass("convert-math-to-llvm")]
pub struct ConvertMathToLlvm {
    #[opt("approximate-log1p", default = true)]
    approximate_log1p: bool,
}

impl Run for ConvertMathToLlvm {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let tc = LlvmConverter::build(LlvmOptions::derived().at(body, op));
        let mut patterns = ConversionPatterns::default();
        let i = patterns.converter(&tc);
        MathToLlvm::populate(&mut patterns, i, self.approximate_log1p);
        let target = llvm_target();
        Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
    }
}
