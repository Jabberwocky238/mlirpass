//! `convert-memref-to-emitc`.

use crate::{Emitc, MemrefToEmitc};
use mlirformat::Error;
use crate::pass;
use crate::{Body, ConversionConfig, ConversionPatterns, ConversionTarget, Converter, Mode, OpId, Run};

/// `convert-memref-to-emitc`.
#[pass("convert-memref-to-emitc", on = "builtin.module")]
pub struct ConvertMemrefToEmitc {
    #[opt("lower-to-cpp")]
    cpp: bool,
}

impl Run for ConvertMemrefToEmitc {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let tc = Emitc::type_converter(false);
        let mut patterns = ConversionPatterns::default();
        let i = patterns.converter(&tc);
        MemrefToEmitc::populate(&mut patterns, i);
        let mut target = ConversionTarget::default();
        target.illegal_dialect("memref").legal_dialect("emitc");
        Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)?;
        MemrefToEmitc::add_headers(body, op, self.cpp);
        Ok(())
    }
}
