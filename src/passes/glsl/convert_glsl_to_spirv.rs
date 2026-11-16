use mlirformat::{Attribute, Error};

use crate::{
    ArithSpirvOptions, ArithToSpirv, Body, ConversionConfig, ConversionPatterns, Converter, FuncToSpirv, GlslClient, GlslToSpirv, MathSpirvOptions, MathToSpirv, Mode, OpId, Run, ScfToSpirv, SpirvOptions, SpirvTypes, TargetEnv,
    SpirvUpdateVce, VectorSpirvOptions, VectorToSpirv, pass,
};

#[pass("convert-glsl-to-spirv", on = "builtin.module")]
pub struct ConvertGlslToSpirv {
    #[opt("client", default = GlslClient::Opengl, from_str)]
    client: GlslClient,
}

impl ConvertGlslToSpirv {
    const ENV_ATTR: &'static str = "spirv.target_env";
    const ENV_BODY: &'static str = "<#spirv.vce<v1.0, [Shader, ImageQuery], []>, #spirv.resource_limits<>>";
    const TARGET_ENV: &'static str = "#spirv.target_env<#spirv.vce<v1.0, [Shader, ImageQuery], []>, #spirv.resource_limits<>>";
}

impl Run for ConvertGlslToSpirv {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let modules = GlslToSpirv::modules(body, op, self.client)?;
        let env = TargetEnv::parse(ConvertGlslToSpirv::TARGET_ENV).ok_or_else(|| Error(alloc::string::String::from("convert-glsl-to-spirv: a bad target env")))?;
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
        Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &modules, Mode::Full)?;
        GlslToSpirv::seal_kills(body, &modules);
        for m in modules {
            body[m].set(ConvertGlslToSpirv::ENV_ATTR, Attribute::dialect(ConvertGlslToSpirv::ENV_ATTR, ConvertGlslToSpirv::ENV_BODY));
            SpirvUpdateVce.run(body, m)?;
        }
        Ok(())
    }
}
