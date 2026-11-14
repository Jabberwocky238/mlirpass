use crate::{TosaToArith};
use mlirformat::Error;
use crate::pass;
use crate::{Body, ConversionConfig, ConversionPatterns, ConversionTarget, Converter, Mode, OpId, Run};

#[pass("tosa-to-arith")]
pub struct TosaToArithPass {
    #[opt("include-apply-rescale")]
    rescale: bool,
    #[opt("use-32-bit")]
    use_32: bool,
}

impl Run for TosaToArithPass {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let mut patterns = ConversionPatterns::default();
        TosaToArith::populate(&mut patterns, self.rescale, self.use_32);
        let mut target = ConversionTarget::default();
        target.illegal_op("tosa.const").legal_dialect("arith");
        if self.rescale {
            target.illegal_op("tosa.apply_scale");
        }
        Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
    }
}
