use crate::{ArithSpirvOptions, ArithToSpirv, SpirvOptions, SpirvTypes, TargetEnv};

#[crate::pass("convert-arith-to-spirv")]
pub struct ConvertArithToSpirv {
    #[opt("emulate-lt-32-bit-scalar-types", default = true)]
    emulate_lt32: bool,
    #[opt("emulate-unsupported-float-types", default = true)]
    emulate_floats: bool,
}

impl crate::Run for ConvertArithToSpirv {
    fn run<'a>(&self, body: &mut crate::Body<'a>, op: crate::OpId) -> Result<(), mlirformat::Error> {
        let env = TargetEnv::lookup(body, op);
        let types = SpirvTypes { env: &env, opts: SpirvOptions { emulate_lt32: self.emulate_lt32, emulate_unsupported_floats: self.emulate_floats, ..SpirvOptions::default() } };
        let tc = types.converter();
        let mut patterns = crate::ConversionPatterns::default();
        let i = patterns.converter(&tc);
        ArithToSpirv::populate(&mut patterns, i, ArithSpirvOptions { no_wrap: env.allows_ext("SPV_KHR_no_integer_wrap_decoration"), emulate_floats: self.emulate_floats });
        let mut target = env.conversion_target();
        target.legal_op("builtin.unrealized_conversion_cast").illegal_dialect("arith");
        crate::Converter::new(&target, &patterns, crate::ConversionConfig::default()).apply(body, &[op], crate::Mode::Partial)
    }
}
