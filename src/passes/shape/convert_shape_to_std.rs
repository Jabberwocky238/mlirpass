use crate::{ShapeToStd};
use mlirformat::Error;
use crate::pass;
use crate::{Body, ConversionConfig, ConversionPatterns, ConversionTarget, Converter, Mode, OpId};

#[pass("convert-shape-to-std", on = "builtin.module")]
pub fn convert_shape_to_std<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let mut patterns = ConversionPatterns::default();
    ShapeToStd::populate(&mut patterns);
    let mut target = ConversionTarget::default();
    target.legal_dialect("arith").legal_dialect("scf").legal_dialect("tensor").legal_op("shape.cstr_require").legal_op("func.func").legal_op("builtin.module");
    Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
}
