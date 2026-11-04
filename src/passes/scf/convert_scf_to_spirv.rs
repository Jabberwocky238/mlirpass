//! `convert-scf-to-spirv`.

use crate::{ArithSpirvOptions, ArithToSpirv, FuncToSpirv, IndexToSpirv, MemrefSpirvOptions, MemrefToSpirv, ScfToSpirv, SpirvOptions, SpirvTypes, TargetEnv};

/// `convert-scf-to-spirv`.
#[crate::pass("convert-scf-to-spirv")]
pub fn convert_scf_to_spirv<'a>(body: &mut crate::Body<'a>, op: crate::OpId) -> Result<(), mlirformat::Error> {
    let env = TargetEnv::lookup(body, op);
    let types = SpirvTypes { env: &env, opts: SpirvOptions::default() };
    let tc = types.converter();
    let mut patterns = crate::ConversionPatterns::default();
    let i = patterns.converter(&tc);
    ScfToSpirv::populate(&mut patterns, i);
    ArithToSpirv::populate(&mut patterns, i, ArithSpirvOptions { no_wrap: env.allows_ext("SPV_KHR_no_integer_wrap_decoration"), emulate_floats: true });
    FuncToSpirv::populate(&mut patterns, i);
    MemrefToSpirv::populate(&mut patterns, i, MemrefSpirvOptions { index64: false, kernel: env.allows_cap("Kernel"), bool_bits: 8 });
    IndexToSpirv::populate(&mut patterns, i);
    let mut target = env.conversion_target();
    target.legal_op("builtin.unrealized_conversion_cast");
    crate::Converter::new(&target, &patterns, crate::ConversionConfig::default()).apply(body, &[op], crate::Mode::Partial)
}
