use crate::{ComplexToSpirv, SpirvOptions, SpirvTypes, TargetEnv};

#[crate::pass("convert-complex-to-spirv")]
pub fn convert_complex_to_spirv<'a>(body: &mut crate::Body<'a>, op: crate::OpId) -> Result<(), mlirformat::Error> {
    let env = TargetEnv::lookup(body, op);
    let types = SpirvTypes { env: &env, opts: SpirvOptions::default() };
    let tc = types.converter();
    let mut patterns = crate::ConversionPatterns::default();
    let i = patterns.converter(&tc);
    ComplexToSpirv::populate(&mut patterns, i);
    let mut target = env.conversion_target();
    target.legal_op("builtin.unrealized_conversion_cast");
    crate::Converter::new(&target, &patterns, crate::ConversionConfig::default()).apply(body, &[op], crate::Mode::Partial)
}
