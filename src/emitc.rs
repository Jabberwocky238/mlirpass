//! ⭐ Lowerings to `emitc`, as `mlir/lib/Conversion/*ToEmitC`: the EmitC type converter, one
//! file per source dialect, `convert-to-emitc` and the passes.

mod arith_to_emitc;
mod func_to_emitc;
mod interfaces;
mod math_to_emitc;
mod memref_to_emitc;
mod scf_to_emitc;
mod types;

use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;

use mlirformat::Error;

use crate::pass;
use crate::{Action, Body, ConversionConfig, ConversionPatterns, ConversionTarget, Converter, DialectInterfaces, Mode, OpId, Run};

pub use arith_to_emitc::ArithToEmitc;
pub use func_to_emitc::FuncToEmitc;
pub use interfaces::ToEmitcInterfaces;
pub use math_to_emitc::MathToEmitc;
pub use memref_to_emitc::MemrefToEmitc;
pub use scf_to_emitc::ScfToEmitc;
pub use types::Emitc;

/// `convert-arith-to-emitc`.
#[pass("convert-arith-to-emitc")]
pub fn convert_arith_to_emitc<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let mut tc = Emitc::converter(false);
    Emitc::size_t_conversions(&mut tc);
    let mut patterns = ConversionPatterns::default();
    let i = patterns.converter(&tc);
    ArithToEmitc::populate(&mut patterns, i);
    let mut target = ConversionTarget::default();
    target.legal_dialect("emitc").illegal_dialect("arith");
    Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
}

/// `convert-func-to-emitc`.
#[pass("convert-func-to-emitc", on = "builtin.module")]
pub fn convert_func_to_emitc<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let tc = Emitc::converter(false);
    let mut patterns = ConversionPatterns::default();
    let i = patterns.converter(&tc);
    FuncToEmitc::populate(&mut patterns, i);
    let mut target = ConversionTarget::default();
    target.legal_dialect("emitc").illegal_op("func.call").illegal_op("func.func").illegal_op("func.return");
    Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
}

/// `convert-math-to-emitc`.
#[pass("convert-math-to-emitc")]
pub struct ConvertMathToEmitc {
    #[opt("language-target", default = LanguageTarget::C99, from_str)]
    target: LanguageTarget,
}

/// `emitc::LanguageTarget`.
#[derive(Clone, Copy, PartialEq, Eq)]
enum LanguageTarget {
    C99,
    Cpp11,
}

impl core::str::FromStr for LanguageTarget {
    type Err = ();
    fn from_str(s: &str) -> Result<Self, ()> {
        match s {
            "c99" => Ok(Self::C99),
            "cpp11" => Ok(Self::Cpp11),
            _ => Err(()),
        }
    }
}

impl Run for ConvertMathToEmitc {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let mut patterns = ConversionPatterns::default();
        MathToEmitc::populate(&mut patterns, self.target == LanguageTarget::Cpp11);
        let mut target = ConversionTarget::default();
        target.legal_op("emitc.call_opaque");
        for r in MathToEmitc::ROOTS {
            target.illegal_op(r);
        }
        Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
    }
}

/// `convert-scf-to-emitc`.
#[pass("convert-scf-to-emitc")]
pub fn convert_scf_to_emitc<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let mut tc = Emitc::converter(true);
    Emitc::size_t_conversions(&mut tc);
    let mut patterns = ConversionPatterns::default();
    let i = patterns.converter(&tc);
    ScfToEmitc::populate(&mut patterns, i);
    let mut target = ConversionTarget::default();
    target.illegal_op("scf.for").illegal_op("scf.if").illegal_op("scf.index_switch").illegal_op("scf.while").unknown(Action::Legal);
    Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
}

/// `convert-memref-to-emitc`.
#[pass("convert-memref-to-emitc", on = "builtin.module")]
pub struct ConvertMemrefToEmitc {
    #[opt("lower-to-cpp")]
    cpp: bool,
}

impl Run for ConvertMemrefToEmitc {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let mut tc = Emitc::converter(true);
        Emitc::memref_conversions(&mut tc, false);
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

crate::pass_set! {
    /// Every lowering to `emitc`.
    EmitcPasses: ConvertArithToEmitc, ConvertFuncToEmitc, ConvertMathToEmitc, ConvertMemrefToEmitc, ConvertScfToEmitc, ConvertToEmitc
}
