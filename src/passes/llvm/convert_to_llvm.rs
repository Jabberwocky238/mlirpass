//! `convert-to-llvm`.

use crate::{DialectInterfaces, LlvmConverter, LlvmEnv, LlvmOptions, ToLlvmInterfaces};
use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;
use crate::pass;
use mlirformat::Error;
use crate::{Body, ConversionConfig, ConversionPatterns, ConversionTarget, Converter, Mode, OpId, Run};

/// `convert-to-llvm`: every dialect's `ConvertToLLVMPatternInterface` patterns (or those of
/// `filter-dialects`), against a target where the llvm dialect is legal.
#[pass("convert-to-llvm", extra = ["dynamic"], check = Self::check)]
pub struct ConvertToLlvm {
    #[opt("filter-dialects")]
    filter: Vec<String>,
    #[opt("allow-pattern-rollback", default = true)]
    rollback: bool,
    counter: core::sync::atomic::AtomicU32,
    /// The dialects' `ConvertToLLVMPatternInterface`s.
    interfaces: ToLlvmInterfaces,
}

impl ConvertToLlvm {
    /// A dialect whose lowering is not ported yet makes the pass unsupported, not wrong.
    fn check(&self) -> Result<(), Error> {
        match self.filter.iter().find(|d| !self.interfaces.knows(d)) {
            Some(d) => Err(Error(format!("convert-to-llvm: the {d} lowering is not ported"))),
            None => Ok(()),
        }
    }
}

impl Run for ConvertToLlvm {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let tc = LlvmConverter::build(LlvmOptions::derived().at(body, op));
        let mut patterns = ConversionPatterns::default();
        let i = patterns.converter(&tc);
        let dialects: Vec<&str> = if self.filter.is_empty() { self.interfaces.dialects() } else { self.filter.iter().map(String::as_str).collect() };
        let env = LlvmEnv { llvm: LlvmOptions::derived().at(body, op), counter: &self.counter };
        let mut target = ConversionTarget::default();
        target.legal_dialect("llvm");
        for d in dialects {
            if !self.interfaces.knows(d) {
                return Err(Error(format!("dialect does not implement ConvertToLLVMPatternInterface: {d}")));
            }
            self.interfaces.populate(d, &mut patterns, i, &env);
            self.interfaces.target(d, &mut target);
        }
        Converter::new(&target, &patterns, ConversionConfig { rollback: self.rollback, ..ConversionConfig::default() }).apply(body, &[op], Mode::Partial)
    }
}
