use mlirformat::Error;

use crate::pass;
use crate::{Body, ComplexToRocdlLibCalls, ConversionConfig, ConversionPatterns, ConversionTarget, Converter, Mode, OpId};

const ILLEGAL: [&str; 10] = ["complex.abs", "complex.cos", "complex.exp", "complex.log", "complex.pow", "complex.powi", "complex.sin", "complex.sqrt", "complex.tan", "complex.tanh"];

#[pass("convert-complex-to-rocdl-library-calls", on = "builtin.module")]
pub fn convert_complex_to_rocdl_library_calls<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let mut patterns = ConversionPatterns::default();
    ComplexToRocdlLibCalls::populate(&mut patterns);
    let mut target = ConversionTarget::default();
    target.legal_dialect("arith").legal_dialect("func");
    target.op("complex.create", crate::Action::Legal).op("complex.mul", crate::Action::Legal);
    for o in ILLEGAL {
        target.illegal_op(o);
    }
    Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
}
