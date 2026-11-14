use crate::{Emitc, FuncToEmitc};
use mlirformat::Error;
use crate::pass;
use crate::{Body, ConversionConfig, ConversionPatterns, ConversionTarget, Converter, Mode, OpId, Run};

#[pass("convert-func-to-emitc", on = "builtin.module")]
pub struct ConvertFuncToEmitc {
    #[opt("lower-to-cpp", default = true)]
    lower_to_cpp: bool,
}

impl Run for ConvertFuncToEmitc {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let tc = Emitc::type_converter(false);
        let mut patterns = ConversionPatterns::default();
        let i = patterns.converter(&tc);
        FuncToEmitc::populate(&mut patterns, i, self.lower_to_cpp);
        let mut target = ConversionTarget::default();
        target.legal_dialect("emitc").illegal_op("func.call").illegal_op("func.func").illegal_op("func.return");
        Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
    }
}
