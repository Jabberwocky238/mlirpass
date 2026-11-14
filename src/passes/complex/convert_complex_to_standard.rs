use crate::{ComplexToStd};
use mlirformat::Error;
use crate::pass;
use crate::{Body, ConversionConfig, ConversionPatterns, ConversionTarget, Converter, Mode, OpId, Run};

#[pass("convert-complex-to-standard")]
pub struct ConvertComplexToStandard {
    #[opt("complex-range", default = ComplexRange::Improved, from_str)]
    range: ComplexRange,
}

#[derive(Clone, Copy, PartialEq, Eq)]
pub enum ComplexRange {
    Improved,
    Basic,
    None,
}

impl core::str::FromStr for ComplexRange {
    type Err = ();
    fn from_str(s: &str) -> Result<Self, ()> {
        match s {
            "improved" => Ok(Self::Improved),
            "basic" => Ok(Self::Basic),
            "none" => Ok(Self::None),
            _ => Err(()),
        }
    }
}

impl Run for ConvertComplexToStandard {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let mut patterns = ConversionPatterns::default();
        ComplexToStd::populate(&mut patterns, self.range == ComplexRange::Improved);
        let mut target = ConversionTarget::default();
        target.legal_dialect("arith").legal_dialect("math").legal_op("complex.create").legal_op("complex.im").legal_op("complex.re");
        Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
    }
}
