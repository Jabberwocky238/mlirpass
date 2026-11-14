use crate::{MathToEmitc};
use mlirformat::Error;
use crate::pass;
use crate::{Body, ConversionConfig, ConversionPatterns, ConversionTarget, Converter, Mode, OpId, Run};

#[pass("convert-math-to-emitc")]
pub struct ConvertMathToEmitc {
    #[opt("language-target", default = LanguageTarget::C99, from_str)]
    target: LanguageTarget,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum LanguageTarget {
    C99,
    Cpp11,
}

impl core::str::FromStr for LanguageTarget {
    type Err = ();
    fn from_str(s: &str) -> Result<Self, ()> {
        match s {
            "c99" => Ok(Self::C99),
            "cpp11" => Ok(Self::Cpp11),
            _ => Err(()),
        }
    }
}

impl Run for ConvertMathToEmitc {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let mut patterns = ConversionPatterns::default();
        MathToEmitc::populate(&mut patterns, self.target == LanguageTarget::Cpp11);
        let mut target = ConversionTarget::default();
        target.legal_op("emitc.call_opaque");
        for r in MathToEmitc::ROOTS {
            target.illegal_op(r);
        }
        Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
    }
}
