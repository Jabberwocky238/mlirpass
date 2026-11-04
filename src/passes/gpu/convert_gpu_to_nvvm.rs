//! `convert-gpu-to-nvvm`.

use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;

use mlirformat::{Attribute, Error};

use crate::{Body, CConv, ConversionConfig, ConversionPatterns, Converter, DialectInterfaces, GpuLlvmOptions, GpuSpaces, GpuToLlvm, GpuToNvvm, LlvmConverter, LlvmEnv, LlvmOptions, Mode, OpId, Printf, ToLlvmInterfaces};

/// `nvgpu::populateCommonGPUTypeAndAttributeConversions`: global 1, shared 3, private 0.
const NVVM_SPACES: GpuSpaces = GpuSpaces { global: 1, workgroup: 3, private: 0 };

/// The llvm intrinsics `configureGpuToNVVMConversionLegality` keeps out (libdevice instead).
const ILLEGAL_LLVM: [&str; 17] = [
    "llvm.intr.copysign", "llvm.intr.cos", "llvm.intr.exp", "llvm.intr.exp2", "llvm.intr.fabs", "llvm.intr.ceil", "llvm.intr.floor", "llvm.frem", "llvm.intr.log", "llvm.intr.log10", "llvm.intr.log2", "llvm.intr.pow", "llvm.intr.roundeven", "llvm.intr.round", "llvm.intr.sin", "llvm.intr.sincos", "llvm.intr.sqrt",
];

/// `convert-gpu-to-nvvm`, as `LowerGpuOpsToNVVMOpsPass`.
#[crate::pass("convert-gpu-to-nvvm", on = "gpu.module")]
pub struct ConvertGpuToNvvm {
    #[opt("index-bitwidth")]
    index_bitwidth: u32,
    #[opt("has-redux")]
    has_redux: bool,
    #[opt("use-bare-ptr-memref-call-conv")]
    bare_ptr: bool,
    #[opt("allowed-dialects")]
    allowed: Vec<String>,
    #[opt("allow-pattern-rollback", default = true)]
    rollback: bool,
    counter: core::sync::atomic::AtomicU32,
    interfaces: ToLlvmInterfaces,
}

impl crate::Run for ConvertGpuToNvvm {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        // Request C wrapper emission.
        let blk = body.top_block(op);
        let funcs: Vec<OpId> = body[blk].ops.iter().copied().filter(|f| body[*f].name == "func.func").collect();
        for f in funcs {
            body[f].set("llvm.emit_c_interface", Attribute::Unit);
        }
        let mut llvm = LlvmOptions { bare_ptr: self.bare_ptr, gpu_spaces: Some(NVVM_SPACES), ..LlvmOptions::derived() }.at(body, op);
        if self.index_bitwidth != 0 {
            llvm.index_bitwidth = self.index_bitwidth;
        }
        let _ = self.has_redux;
        let tc = LlvmConverter::build(llvm);
        let mut patterns = ConversionPatterns::default();
        let i = patterns.converter(&tc);
        GpuToNvvm::populate(&mut patterns, i, llvm);
        let gpu = GpuLlvmOptions {
            llvm,
            alloca_space: 0,
            workgroup_space: NVVM_SPACES.workgroup,
            kernel_attr: Some("nvvm.kernel"),
            block_size_attr: Some("nvvm.maxntid"),
            cluster_size_attr: Some("nvvm.cluster_dim"),
            kernel_cconv: CConv::C,
            func_cconv: CConv::C,
            workgroup_args: false,
            printf: Some(Printf::VPrintf),
        };
        GpuToLlvm::populate(&mut patterns, i, gpu);
        let env = LlvmEnv { llvm, counter: &self.counter };
        let mut target = crate::llvm_target();
        for d in self.interfaces.dialects() {
            // math lowers to libdevice instead.
            if d == "math" || (!self.allowed.is_empty() && !self.allowed.iter().any(|a| a == d)) {
                continue;
            }
            self.interfaces.populate(d, &mut patterns, i, &env);
        }
        if let Some(d) = self.allowed.iter().find(|d| !self.interfaces.knows(d)) {
            return Err(Error(format!("dialect does not implement ConvertToLLVMPatternInterface: {d}")));
        }
        // `configureGpuToNVVMConversionLegality`.
        target.illegal_op("func.func").illegal_op("cf.assert").legal_dialect("llvm").legal_dialect("nvvm");
        target.dialect("gpu", crate::Action::Illegal);
        for o in ILLEGAL_LLVM {
            target.illegal_op(o);
        }
        target.op("gpu.yield", crate::Action::Legal).op("gpu.module", crate::Action::Legal);
        Converter::new(&target, &patterns, ConversionConfig { rollback: self.rollback, ..ConversionConfig::default() }).apply(body, &[op], Mode::Partial)
    }
}
