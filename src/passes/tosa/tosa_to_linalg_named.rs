use crate::{TosaToLinalgNamed, TosaToTensor};
use mlirformat::Error;
use crate::pass;
use crate::{Action, Body, ConversionConfig, ConversionPatterns, ConversionTarget, Converter, Mode, OpId, Run};

#[pass("tosa-to-linalg-named", on = "func.func")]
pub struct TosaToLinalgNamedPass {
    #[opt("prefer-conv2d-kernel-layout-hwcf")]
    hwcf: bool,
}

impl Run for TosaToLinalgNamedPass {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let tc = TosaToTensor::converter();
        let mut patterns = ConversionPatterns::default();
        let i = patterns.converter(&tc);
        TosaToLinalgNamed::populate(&mut patterns, i, self.hwcf);
        let mut target = ConversionTarget::default();
        target.legal_dialect("linalg").legal_dialect("tosa").legal_dialect("tensor").legal_dialect("scf");
        for o in ["tosa.conv2d", "tosa.conv3d", "tosa.depthwise_conv2d", "tosa.max_pool2d", "tosa.avg_pool2d", "tosa.matmul", "tosa.transpose"] {
            target.illegal_op(o);
        }
        target.unknown(Action::Legal);
        Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Full)
    }
}
