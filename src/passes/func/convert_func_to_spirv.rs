//! `convert-func-to-spirv`.

use crate::{FuncToSpirv, SpirvOptions, SpirvTypes, TargetEnv};

/// `convert-func-to-spirv`.
#[crate::pass("convert-func-to-spirv")]
pub struct ConvertFuncToSpirv {
    #[opt("emulate-lt-32-bit-scalar-types", default = true)]
    emulate_lt32: bool,
    #[opt("emulate-unsupported-float-types", default = true)]
    emulate_floats: bool,
}

impl crate::Run for ConvertFuncToSpirv {
    fn run<'a>(&self, body: &mut crate::Body<'a>, op: crate::OpId) -> Result<(), mlirformat::Error> {
        let env = TargetEnv::lookup(body, op);
        let types = SpirvTypes { env: &env, opts: SpirvOptions { emulate_lt32: self.emulate_lt32, emulate_unsupported_floats: self.emulate_floats, ..SpirvOptions::default() } };
        let tc = types.converter();
        let mut patterns = crate::ConversionPatterns::default();
        let i = patterns.converter(&tc);
        FuncToSpirv::populate(&mut patterns, i);
        let target = env.conversion_target();
        crate::Converter::new(&target, &patterns, crate::ConversionConfig::default()).apply(body, &[op], crate::Mode::Partial)
    }
}
