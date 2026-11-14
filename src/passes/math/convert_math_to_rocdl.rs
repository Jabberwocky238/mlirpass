use alloc::format;
use alloc::string::String;

use mlirformat::Error;

use crate::{AmdChipset, Body, ConversionConfig, ConversionPatterns, ConversionTarget, Converter, LlvmConverter, LlvmOptions, MathRocdlOptions, MathToRocdl, Mode, OpId};

const ILLEGAL_LLVM: [&str; 13] = ["llvm.intr.cos", "llvm.intr.exp", "llvm.intr.exp2", "llvm.intr.fabs", "llvm.intr.ceil", "llvm.intr.floor", "llvm.frem", "llvm.intr.log", "llvm.intr.log10", "llvm.intr.log2", "llvm.intr.pow", "llvm.intr.sin", "llvm.intr.sqrt"];

#[crate::pass("convert-math-to-rocdl", on = "builtin.module")]
pub struct ConvertMathToRocdl {
    #[opt("chipset")]
    chipset: String,
}

impl crate::Run for ConvertMathToRocdl {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let chipset = match &*self.chipset {
            "" => None,
            c => Some(AmdChipset::try_from(c).map_err(|_| Error(format!("invalid chipset name: {c}")))?),
        };
        let tc = LlvmConverter::build(LlvmOptions::derived().at(body, op));
        let mut patterns = ConversionPatterns::default();
        let i = patterns.converter(&tc);
        MathToRocdl::populate(&mut patterns, i, MathRocdlOptions::new(chipset));
        let mut target = ConversionTarget::default();
        for d in ["builtin", "func", "vector", "llvm", "rocdl"] {
            target.legal_dialect(d);
        }
        for o in ILLEGAL_LLVM {
            target.illegal_op(o);
        }
        Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
    }
}
