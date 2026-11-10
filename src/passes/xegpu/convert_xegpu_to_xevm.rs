//! `convert-xegpu-to-xevm`.

use mlirformat::Error;

use crate::{Action, Body, ConversionConfig, ConversionPatterns, ConversionTarget, Converter, Mode, OpId, XegpuToXevm};

/// `convert-xegpu-to-xevm`, as `ConvertXeGPUToXeVMPass`: xegpu illegal; xevm, llvm, vector,
/// arith, memref, gpu and index legal.
#[crate::pass("convert-xegpu-to-xevm")]
pub fn convert_xegpu_to_xevm<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let tc = XegpuToXevm::converter();
    let mut patterns = ConversionPatterns::default();
    let i = patterns.converter(&tc);
    XegpuToXevm::populate(&mut patterns, i);
    let mut target = ConversionTarget::default();
    for d in ["xevm", "llvm", "vector", "arith", "memref", "gpu", "index"] {
        target.legal_dialect(d);
    }
    target.dialect("xegpu", Action::Illegal);
    // (arith.extf / truncf between MX narrow floats and f16 / bf16 become xevm's)
    target.dynamic_op("arith.extf", |b: &Body<'_>, o: OpId| Some(!XegpuToXevm::is_xevm_extf(b, o)));
    target.dynamic_op("arith.truncf", |b: &Body<'_>, o: OpId| Some(!XegpuToXevm::is_xevm_truncf(b, o)));
    // `populateSCFStructuralTypeConversionsAndLegality`'s legality: scf ops on converted types.
    let tcr = &tc;
    target.dialect("scf", Action::Dynamic(alloc::boxed::Box::new(move |b: &Body<'_>, o: OpId| Some(tcr.is_legal_op(b, o)))));
    Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
}
