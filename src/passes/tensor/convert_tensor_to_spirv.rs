use crate::{ArithSpirvOptions, ArithToSpirv, FuncToSpirv, SpirvOptions, SpirvTypes, TargetEnv, TensorToSpirv};

#[crate::pass("convert-tensor-to-spirv")]
pub struct ConvertTensorToSpirv {
    #[opt("emulate-lt-32-bit-scalar-types", default = true)]
    emulate_lt32: bool,
    #[opt("emulate-unsupported-float-types", default = true)]
    emulate_floats: bool,
}

impl crate::Run for ConvertTensorToSpirv {
    fn run<'a>(&self, body: &mut crate::Body<'a>, op: crate::OpId) -> Result<(), mlirformat::Error> {
        let env = TargetEnv::lookup(body, op);
        let types = SpirvTypes { env: &env, opts: SpirvOptions { emulate_lt32: self.emulate_lt32, emulate_unsupported_floats: self.emulate_floats, ..SpirvOptions::default() } };
        let tc = types.converter();
        let mut patterns = crate::ConversionPatterns::default();
        let i = patterns.converter(&tc);
        ArithToSpirv::populate(&mut patterns, i, ArithSpirvOptions { no_wrap: env.allows_ext("SPV_KHR_no_integer_wrap_decoration"), emulate_floats: self.emulate_floats });
        FuncToSpirv::populate(&mut patterns, i);
        TensorToSpirv::populate(&mut patterns, i, 64);
        let target = env.conversion_target();
        crate::Converter::new(&target, &patterns, crate::ConversionConfig::default()).apply(body, &[op], crate::Mode::Partial)
    }
}
