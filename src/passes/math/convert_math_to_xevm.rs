//! `convert-math-to-xevm`.

use crate::{Body, ConversionConfig, ConversionPatterns, ConversionTarget, Converter, MathToXevm, MathXevmOptions, Mode, OpId};

/// `convert-math-to-xevm`, as `ConvertMathToXeVMPass`: builtin and llvm legal, the rest
/// converted where a pattern applies.
#[crate::pass("convert-math-to-xevm")]
pub struct ConvertMathToXevm {
    #[opt("convert-arith", default = true)]
    convert_arith: bool,
}

impl crate::Run for ConvertMathToXevm {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), mlirformat::Error> {
        let mut patterns = ConversionPatterns::default();
        MathToXevm::populate(&mut patterns, MathXevmOptions { convert_arith: self.convert_arith });
        let mut target = ConversionTarget::default();
        target.legal_dialect("builtin").legal_dialect("llvm");
        Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
    }
}
