//! `convert-gpu-to-nvvm`.

use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;

use mlirformat::{Attribute, Error};

use crate::{Body, CConv, ConversionConfig, ConversionPatterns, Converter, DialectInterfaces, GpuLlvmOptions, GpuSpaces, GpuToLlvm, GpuToNvvm, LlvmConverter, LlvmEnv, LlvmOptions, Mode, OpId, Printf, ToLlvmInterfaces};

/// `nvgpu::populateCommonGPUTypeAndAttributeConversions`: global 1, shared 3, private 0.
const NVVM_SPACES: GpuSpaces = GpuSpaces { global: 1, workgroup: 3, private: 0, constant: 4 };

/// The llvm intrinsics `configureGpuToNVVMConversionLegality` keeps out (libdevice instead).
const ILLEGAL_LLVM: [&str; 17] = [
    "llvm.intr.copysign", "llvm.intr.cos", "llvm.intr.exp", "llvm.intr.exp2", "llvm.intr.fabs", "llvm.intr.ceil", "llvm.intr.floor", "llvm.frem", "llvm.intr.log", "llvm.intr.log10", "llvm.intr.log2", "llvm.intr.pow", "llvm.intr.roundeven", "llvm.intr.round", "llvm.intr.sin", "llvm.intr.sincos", "llvm.intr.sqrt",
];

/// `populateGpuToNVVMConversionPatterns` with `configureGpuToNVVMConversionLegality`: the
/// NVVM half of the conversion, shared with `convert-to-llvm{dynamic}` (`#nvvm.target`).
pub fn configure_nvvm<'p>(patterns: &mut ConversionPatterns<'p>, i: usize, llvm: LlvmOptions, target: &mut crate::ConversionTarget<'_>) {
    GpuToNvvm::populate(patterns, i, llvm);
    crate::AssertToNvvm::populate(patterns, i);
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
    GpuToLlvm::populate(patterns, i, gpu);
    target.illegal_op("func.func").illegal_op("cf.assert").legal_dialect("llvm").legal_dialect("nvvm");
    target.dialect("gpu", crate::Action::Illegal);
    for o in ILLEGAL_LLVM {
        target.illegal_op(o);
    }
    target.op("gpu.yield", crate::Action::Legal).op("gpu.module", crate::Action::Legal);
}

/// `configureGpuToNVVMTypeConverter`'s memory spaces.
pub const NVVM_GPU_SPACES: GpuSpaces = NVVM_SPACES;

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
        let funcs: Vec<OpId> = body.ops(blk).filter(|f| body[*f].name == "func.func").collect();
        for f in funcs {
            body[f].set("llvm.emit_c_interface", Attribute::Unit);
        }
        // In-dialect lowering first: what needs lowering further than one conversion goes.
        let mut set = crate::PatternSet::default();
        crate::GpuRewrite::patterns(&mut set);
        // `applyPatternsGreedily`'s default config: aggressive region simplification.
        let config = crate::GreedyConfig { region_simplify: crate::RegionSimplify::Aggressive, ..crate::GreedyConfig::default() };
        for r in body[op].regions.clone() {
            body.apply_greedily(r, &set, &config);
        }
        let mut llvm = LlvmOptions { bare_ptr: self.bare_ptr, gpu_spaces: Some(NVVM_SPACES), ..LlvmOptions::derived() }.at(body, op);
        if self.index_bitwidth != 0 {
            llvm.index_bitwidth = self.index_bitwidth;
        }
        let mut tc = LlvmConverter::build(llvm);
        crate::convert_mma_types(&mut tc);
        // A named barrier is its id and thread count.
        tc.conversion(|t| matches!(t, mlirformat::Type::Extended(e) if e.name == "gpu.named_barrier").then(|| Some(alloc::vec![mlirformat::llvm_types::LlvmType::literal(alloc::vec![mlirformat::Type::int(32), mlirformat::Type::int(32)])])));
        let mut patterns = ConversionPatterns::default();
        let i = patterns.converter(&tc);
        if self.has_redux {
            crate::GpuReduxToNvvm::populate(&mut patterns, i);
        }
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
        configure_nvvm(&mut patterns, i, llvm, &mut target);
        crate::WmmaToNvvm::populate(&mut patterns, i, llvm);
        Converter::new(&target, &patterns, ConversionConfig { rollback: self.rollback, ..ConversionConfig::default() }).apply(body, &[op], Mode::Partial)
    }
}
