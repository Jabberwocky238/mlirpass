use crate::{CfToSpirv, SpirvOptions, SpirvTypes, TargetEnv};

#[crate::pass("convert-cf-to-spirv")]
pub struct ConvertCfToSpirv {
    #[opt("emulate-lt-32-bit-scalar-types", default = true)]
    emulate_lt32: bool,
    #[opt("emulate-unsupported-float-types", default = true)]
    emulate_floats: bool,
}

impl crate::Run for ConvertCfToSpirv {
    fn run<'a>(&self, body: &mut crate::Body<'a>, op: crate::OpId) -> Result<(), mlirformat::Error> {
        let env = TargetEnv::lookup(body, op);
        let types = SpirvTypes { env: &env, opts: SpirvOptions { emulate_lt32: self.emulate_lt32, emulate_unsupported_floats: self.emulate_floats, ..SpirvOptions::default() } };
        let tc = types.converter();
        let mut patterns = crate::ConversionPatterns::default();
        let i = patterns.converter(&tc);
        CfToSpirv::populate(&mut patterns, i);
        let target = env.conversion_target();
        crate::Converter::new(&target, &patterns, crate::ConversionConfig::default()).apply(body, &[op], crate::Mode::Partial)
    }
}
