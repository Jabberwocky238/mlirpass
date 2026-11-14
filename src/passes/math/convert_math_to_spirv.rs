use crate::{MathSpirvOptions, MathToSpirv, SpirvOptions, SpirvTypes, TargetEnv};

#[crate::pass("convert-math-to-spirv")]
pub fn convert_math_to_spirv<'a>(body: &mut crate::Body<'a>, op: crate::OpId) -> Result<(), mlirformat::Error> {
    let env = TargetEnv::lookup(body, op);
    let types = SpirvTypes { env: &env, opts: SpirvOptions::default() };
    let tc = types.converter();
    let mut patterns = crate::ConversionPatterns::default();
    let i = patterns.converter(&tc);
    MathToSpirv::populate(&mut patterns, i, MathSpirvOptions { shader: env.allows_cap("Shader") });
    let mut target = env.conversion_target();
    target.legal_op("builtin.unrealized_conversion_cast");
    crate::Converter::new(&target, &patterns, crate::ConversionConfig::default()).apply(body, &[op], crate::Mode::Partial)
}
