use mlirformat::Error;

use crate::{
    ArithSpirvOptions, ArithToSpirv, Body, ConversionConfig, ConversionPatterns, Converter, FuncToSpirv, GlslClient, GlslToSpirv, MathSpirvOptions, MathToSpirv, Mode, OpId, Run, ScfToSpirv, SpirvOptions, SpirvTypes, TargetEnv,
    VectorSpirvOptions, VectorToSpirv, pass,
};

#[pass("convert-glsl-to-spirv", on = "builtin.module")]
pub struct ConvertGlslToSpirv {
    #[opt("client", default = GlslClient::Opengl, from_str)]
    client: GlslClient,
}

impl Run for ConvertGlslToSpirv {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let modules = GlslToSpirv::modules(body, op, self.client)?;
        let env = TargetEnv::default_env();
        let types = SpirvTypes { env: &env, opts: SpirvOptions::default() };
        let tc = types.converter();
        let mut patterns = ConversionPatterns::default();
        let i = patterns.converter(&tc);
        GlslToSpirv::populate(&mut patterns, i, self.client);
        ArithToSpirv::populate(&mut patterns, i, ArithSpirvOptions { no_wrap: false, emulate_floats: true });
        MathToSpirv::populate(&mut patterns, i, MathSpirvOptions { shader: true });
        VectorToSpirv::populate(&mut patterns, i, VectorSpirvOptions { index64: false, kernel: false });
        ScfToSpirv::populate(&mut patterns, i);
        FuncToSpirv::populate(&mut patterns, i);
        let target = env.conversion_target();
        Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &modules, Mode::Full)
    }
}
