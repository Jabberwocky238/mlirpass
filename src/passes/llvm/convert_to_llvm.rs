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
#[pass("convert-to-llvm", check = Self::check)]
pub struct ConvertToLlvm {
    #[opt("filter-dialects")]
    filter: Vec<String>,
    #[opt("allow-pattern-rollback", default = true)]
    rollback: bool,
    /// `dynamic`: the conversion attributes of the op (a `gpu.module`'s targets) add theirs.
    #[opt("dynamic")]
    dynamic: bool,
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

impl ConvertToLlvm {
    /// Whether the `gpu.module` at or around `op` targets NVVM (`getConvertToLLVMConversionAttrs`).
    fn nvvm_target(body: &Body<'_>, op: OpId) -> bool {
        let mut at = Some(op);
        while let Some(o) = at.filter(|o| body[*o].name != "gpu.module") {
            at = body.parent_op(o);
        }
        let Some(m) = at else { return false };
        matches!(body[m].get("targets"), Some(mlirformat::Attribute::Array(ts)) if ts.iter().any(|t| matches!(t, mlirformat::Attribute::Extended { ext, .. } if ext.name == "nvvm.target")))
    }
}

impl ConvertToLlvm {
    #[cfg(all(feature = "dialect.gpu", feature = "dialect.nvvm"))]
    fn gpu_spaces(nvvm: bool) -> Option<crate::GpuSpaces> {
        nvvm.then_some(crate::NVVM_GPU_SPACES)
    }

    #[cfg(not(all(feature = "dialect.gpu", feature = "dialect.nvvm")))]
    fn gpu_spaces(_: bool) -> Option<crate::GpuSpaces> {
        None
    }

    #[cfg(all(feature = "dialect.gpu", feature = "dialect.nvvm"))]
    fn configure<'p>(nvvm: bool, patterns: &mut ConversionPatterns<'p>, i: usize, llvm: LlvmOptions, target: &mut ConversionTarget<'_>) {
        if nvvm {
            crate::configure_nvvm(patterns, i, llvm, target);
        }
    }

    #[cfg(not(all(feature = "dialect.gpu", feature = "dialect.nvvm")))]
    fn configure<'p>(_: bool, _: &mut ConversionPatterns<'p>, _: usize, _: LlvmOptions, _: &mut ConversionTarget<'_>) {}
}

impl Run for ConvertToLlvm {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let nvvm = self.dynamic && Self::nvvm_target(body, op);
        // (the ptr dialect's interface converts `#ptr.generic_space` and its types)
        let llvm = LlvmOptions { gpu_spaces: Self::gpu_spaces(nvvm), ptr_spaces: cfg!(feature = "dialect.ptr"), ..LlvmOptions::derived() }.at(body, op);
        let registry = LlvmConverter::identified_in(body, op);
        let mut tc = LlvmConverter::build(llvm);
        LlvmConverter::with_identified(&mut tc, llvm, &registry);
        #[cfg(feature = "dialect.ptr")]
        crate::PtrToLlvm::convert(&mut tc, llvm, body.ctx.opt);
        let mut patterns = ConversionPatterns::default();
        let i = patterns.converter(&tc);
        let dialects: Vec<&str> = if self.filter.is_empty() { self.interfaces.dialects() } else { self.filter.iter().map(String::as_str).collect() };
        let env = LlvmEnv { llvm, counter: &self.counter };
        let mut target = ConversionTarget::default();
        target.legal_dialect("llvm");
        for d in dialects {
            if !self.interfaces.knows(d) {
                return Err(Error(format!("dialect does not implement ConvertToLLVMPatternInterface: {d}")));
            }
            self.interfaces.populate(d, &mut patterns, i, &env);
            self.interfaces.target(d, &mut target);
        }
        // `populateOpConvertToLLVMConversionPatterns`: `#nvvm.target`'s
        // `NVVMTargetConvertToLLVMAttrInterface`.
        Self::configure(nvvm, &mut patterns, i, llvm, &mut target);
        Converter::new(&target, &patterns, ConversionConfig { rollback: self.rollback, ..ConversionConfig::default() }).apply(body, &[op], Mode::Partial)
    }

    /// Function by function on `exec`: what goes into the module (runtime declarations) comes
    /// back in the serial order; anything needing more of the module is done again on it
    /// ([`Body::run_local`]).
    fn run_in<'a>(&self, body: &mut Body<'a>, op: OpId, exec: &crate::Exec<'_>) -> Result<(), Error> {
        body.run_local(op, exec, &|b, o| Run::run(self, b, o))
    }
}
