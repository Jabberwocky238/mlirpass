//! `convert-index-to-spirv`.

use crate::{IndexToSpirv, SpirvOptions, SpirvTypes, TargetEnv};

/// `convert-index-to-spirv`.
#[crate::pass("convert-index-to-spirv")]
pub struct ConvertIndexToSpirv {
    #[opt("use-64bit-index")]
    index64: bool,
}

impl crate::Run for ConvertIndexToSpirv {
    fn run<'a>(&self, body: &mut crate::Body<'a>, op: crate::OpId) -> Result<(), mlirformat::Error> {
        let env = TargetEnv::lookup(body, op);
        let types = SpirvTypes { env: &env, opts: SpirvOptions { index64: self.index64, ..SpirvOptions::default() } };
        let tc = types.converter();
        let mut patterns = crate::ConversionPatterns::default();
        let i = patterns.converter(&tc);
        IndexToSpirv::populate(&mut patterns, i);
        let mut target = env.conversion_target();
        target.legal_op("builtin.unrealized_conversion_cast").legal_dialect("spirv").illegal_dialect("index");
        crate::Converter::new(&target, &patterns, crate::ConversionConfig::default()).apply(body, &[op], crate::Mode::Partial)
    }
}
