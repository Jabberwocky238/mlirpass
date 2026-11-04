//! `convert-memref-to-spirv`.

use crate::{MemrefSpirvOptions, MemrefToSpirv, SpirvOptions, SpirvTypes, TargetEnv};

/// `convert-memref-to-spirv`.
#[crate::pass("convert-memref-to-spirv")]
pub struct ConvertMemrefToSpirv {
    #[opt("bool-num-bits", default = 8)]
    bool_bits: u32,
    #[opt("use-64bit-index")]
    index64: bool,
}

impl crate::Run for ConvertMemrefToSpirv {
    fn run<'a>(&self, body: &mut crate::Body<'a>, op: crate::OpId) -> Result<(), mlirformat::Error> {
        let env = TargetEnv::lookup(body, op);
        let types = SpirvTypes { env: &env, opts: SpirvOptions { bool_bits: self.bool_bits, index64: self.index64, ..SpirvOptions::default() } };
        let tc = types.converter();
        let mut patterns = crate::ConversionPatterns::default();
        let i = patterns.converter(&tc);
        MemrefToSpirv::populate(&mut patterns, i, MemrefSpirvOptions { index64: self.index64, kernel: env.allows_cap("Kernel"), bool_bits: self.bool_bits });
        let mut target = env.conversion_target();
        target.legal_op("builtin.unrealized_conversion_cast");
        crate::Converter::new(&target, &patterns, crate::ConversionConfig::default()).apply(body, &[op], crate::Mode::Partial)
    }
}
