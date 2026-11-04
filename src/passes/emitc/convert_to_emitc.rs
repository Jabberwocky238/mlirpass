//! `convert-to-emitc`.

use crate::{DialectInterfaces, Emitc, ToEmitcInterfaces};
use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;
use mlirformat::Error;
use crate::pass;
use crate::{Body, ConversionConfig, ConversionPatterns, ConversionTarget, Converter, Mode, OpId, Run};

/// The dialects that implement `ConvertToEmitCPatternInterface`, by namespace.
/// `convert-to-emitc`: every dialect's `ConvertToEmitCPatternInterface` patterns (or those of
/// `filter-dialects`) with the types EmitC supports.
#[pass("convert-to-emitc")]
pub struct ConvertToEmitc {
    #[opt("filter-dialects")]
    filter: Vec<String>,
    /// The dialects' `ConvertToEmitCPatternInterface`s.
    interfaces: ToEmitcInterfaces,
}

impl Run for ConvertToEmitc {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let dialects: Vec<&str> = if self.filter.is_empty() { self.interfaces.dialects() } else { self.filter.iter().map(String::as_str).collect() };
        if let Some(d) = dialects.iter().find(|d| !self.interfaces.knows(d)) {
            return Err(Error(format!("dialect does not implement ConvertToEmitCPatternInterface: {d}")));
        }
        let mut tc = Emitc::converter(true);
        let size_t = dialects.iter().any(|d| self.interfaces.uses_size_t(d));
        for d in &dialects {
            self.interfaces.types(d, &mut tc, size_t);
        }
        let mut patterns = ConversionPatterns::default();
        let i = patterns.converter(&tc);
        for d in dialects {
            self.interfaces.populate(d, &mut patterns, i, &());
        }
        let mut target = ConversionTarget::default();
        target.legal_dialect("emitc");
        Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
    }
}
