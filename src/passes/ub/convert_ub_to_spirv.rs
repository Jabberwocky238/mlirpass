//! `convert-ub-to-spirv`.

use crate::{SpirvOptions, SpirvTypes, TargetEnv, UbToSpirv};

/// `convert-ub-to-spirv`.
#[crate::pass("convert-ub-to-spirv")]
pub fn convert_ub_to_spirv<'a>(body: &mut crate::Body<'a>, op: crate::OpId) -> Result<(), mlirformat::Error> {
    let env = TargetEnv::lookup(body, op);
    let types = SpirvTypes { env: &env, opts: SpirvOptions::default() };
    let tc = types.converter();
    let mut patterns = crate::ConversionPatterns::default();
    let i = patterns.converter(&tc);
    UbToSpirv::populate(&mut patterns, i);
    let target = env.conversion_target();
    crate::Converter::new(&target, &patterns, crate::ConversionConfig::default()).apply(body, &[op], crate::Mode::Partial)
}
