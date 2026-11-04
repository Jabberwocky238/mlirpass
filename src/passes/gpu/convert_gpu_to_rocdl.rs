//! `convert-gpu-to-rocdl`.

use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;

use mlirformat::{Attribute, Error, FloatKind, Type};

use crate::{AmdChipset, AmdgpuToRocdl, Body, CConv, ConversionConfig, ConversionPatterns, Converter, DialectInterfaces, GpuLlvmOptions, GpuRocdlOptions, GpuSpaces, GpuToLlvm, GpuToRocdl, LlvmConverter, LlvmEnv, LlvmOptions, MathRocdlOptions, MathToRocdl, Mode, OpId, Printf, PrintfCall, ToLlvmInterfaces};

/// `amdgpu::populateCommonGPUTypeAndAttributeConversions`: global 1, shared 3, private 5.
const ROCDL_SPACES: GpuSpaces = GpuSpaces { global: 1, workgroup: 3, private: 5 };

/// `amdgcnDataLayout`.
const AMDGCN_DATA_LAYOUT: &str = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128:128:48-p9:192:256:256:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9";

/// The llvm intrinsics `configureGpuToROCDLConversionLegality` keeps out.
const ILLEGAL_LLVM: [&str; 9] = ["llvm.intr.cos", "llvm.intr.exp2", "llvm.intr.ceil", "llvm.intr.floor", "llvm.frem", "llvm.intr.log10", "llvm.intr.log2", "llvm.intr.pow", "llvm.intr.sin"];

/// `gpu::amd::Runtime`.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Default)]
pub enum AmdRuntime {
    #[default]
    Unknown,
    Hip,
    OpenCl,
}

impl core::str::FromStr for AmdRuntime {
    type Err = ();
    fn from_str(s: &str) -> Result<Self, ()> {
        match s {
            "Unknown" => Ok(Self::Unknown),
            "HIP" => Ok(Self::Hip),
            "OpenCL" => Ok(Self::OpenCl),
            _ => Err(()),
        }
    }
}

/// `convert-gpu-to-rocdl`, as `LowerGpuOpsToROCDLOpsPass`.
#[crate::pass("convert-gpu-to-rocdl", on = "gpu.module")]
pub struct ConvertGpuToRocdl {
    #[opt("chipset", default = String::from("gfx000"))]
    chipset: String,
    #[opt("index-bitwidth")]
    index_bitwidth: u32,
    #[opt("use-bare-ptr-memref-call-conv")]
    bare_ptr: bool,
    #[opt("runtime", default = AmdRuntime::Unknown, from_str)]
    runtime: AmdRuntime,
    #[opt("allowed-dialects")]
    allowed: Vec<String>,
    counter: core::sync::atomic::AtomicU32,
    interfaces: ToLlvmInterfaces,
}

impl ConvertGpuToRocdl {
    /// `canBeCalledWithBarePointers` of every `gpu.func`.
    fn bare_ptr_ok(body: &Body<'_>, op: OpId) -> bool {
        body.ops_in(op).into_iter().filter(|f| body[*f].name == "gpu.func").all(|f| match body[f].get("function_type") {
            Some(Attribute::Type(Type::Function(fty))) => fty.inputs.iter().all(|t| match t {
                Type::Shaped(s) if s.kind == mlirformat::ShapedKind::MemRef => s.shape.as_ref().is_some_and(|sh| sh.iter().all(|d| matches!(d, mlirformat::Dim::Static(_)))) && s.extras.iter().all(|a| !a.is_layout()),
                _ => true,
            }),
            _ => true,
        })
    }
}

impl crate::Run for ConvertGpuToRocdl {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        if body[op].get("llvm.data_layout").is_none() {
            body[op].set("llvm.data_layout", Attribute::str(AMDGCN_DATA_LAYOUT));
        }
        let blk = body.top_block(op);
        let funcs: Vec<OpId> = body[blk].ops.iter().copied().filter(|f| body[*f].name == "func.func").collect();
        for f in funcs {
            body[f].set("llvm.emit_c_interface", Attribute::Unit);
        }
        let chipset = AmdChipset::try_from(&*self.chipset).map_err(|_| Error(format!("Invalid chipset name: {}", self.chipset)))?;
        let mut llvm = LlvmOptions { bare_ptr: self.bare_ptr, gpu_spaces: Some(ROCDL_SPACES), amdgpu_spaces: true, ..LlvmOptions::derived() }.at(body, op);
        if self.index_bitwidth != 0 {
            llvm.index_bitwidth = self.index_bitwidth;
        }
        if self.bare_ptr && !Self::bare_ptr_ok(body, op) {
            return Err(Error(String::from("bare pointer calling convention requires all memrefs to have static shape and use the identity map")));
        }
        // In-dialect lowering first.
        let mut set = crate::PatternSet::default();
        crate::GpuRewrite::patterns(&mut set);
        crate::GpuPromoteShuffleToSwizzle::patterns(&mut set);
        if chipset >= AmdChipset::new(9, 5, 0) {
            crate::GpuPromoteShuffleToPermlane::patterns(&mut set);
        }
        let config = crate::GreedyConfig { region_simplify: crate::RegionSimplify::Aggressive, ..crate::GreedyConfig::default() };
        for r in body[op].regions.clone() {
            body.apply_greedily(r, &set, &config);
        }
        let tc = LlvmConverter::build(llvm);
        let mut patterns = ConversionPatterns::default();
        let i = patterns.converter(&tc);
        // Ahead of the dialects' own lowerings: mlir-opt picks the OCML calls where both apply.
        MathToRocdl::populate(&mut patterns, i, MathRocdlOptions::new(Some(chipset)));
        let env = LlvmEnv { llvm, counter: &self.counter };
        let mut target = crate::llvm_target();
        for d in self.interfaces.dialects() {
            if !self.allowed.is_empty() && !self.allowed.iter().any(|a| a == d) {
                continue;
            }
            self.interfaces.populate(d, &mut patterns, i, &env);
        }
        if let Some(d) = self.allowed.iter().find(|d| !self.interfaces.knows(d)) {
            return Err(Error(format!("dialect does not implement ConvertToLLVMPatternInterface: {d}")));
        }
        AmdgpuToRocdl::populate(&mut patterns, i, chipset);
        GpuToRocdl::populate(&mut patterns, i, GpuRocdlOptions { llvm, chipset });
        let printf = match self.runtime {
            AmdRuntime::Hip => Some(Printf::Hip),
            AmdRuntime::OpenCl => Some(Printf::Call(PrintfCall { space: 4, cconv: CConv::C, name: "printf" })),
            AmdRuntime::Unknown => None,
        };
        let gpu = GpuLlvmOptions {
            llvm,
            alloca_space: ROCDL_SPACES.private,
            workgroup_space: ROCDL_SPACES.workgroup,
            kernel_attr: Some("rocdl.kernel"),
            block_size_attr: Some("rocdl.reqd_work_group_size"),
            cluster_size_attr: None,
            kernel_cconv: CConv::C,
            func_cconv: CConv::C,
            workgroup_args: false,
            printf,
        };
        GpuToLlvm::populate(&mut patterns, i, gpu);
        // `configureGpuToROCDLConversionLegality`.
        target.illegal_op("func.func").legal_dialect("llvm").legal_dialect("rocdl");
        target.dialect("gpu", crate::Action::Illegal);
        for o in ILLEGAL_LLVM {
            target.illegal_op(o);
        }
        let f32_operand = |b: &Body<'_>, o: OpId| Some(b[o].operands.iter().any(|v| b[*v].ty == Type::Float(FloatKind::F32)));
        target.op("llvm.intr.exp", crate::Action::Dynamic(alloc::boxed::Box::new(f32_operand)));
        target.op("llvm.intr.log", crate::Action::Dynamic(alloc::boxed::Box::new(f32_operand)));
        target.op("gpu.yield", crate::Action::Legal).op("gpu.module", crate::Action::Legal);
        Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)?;
        // `rocdl.flat_work_group_size` from `rocdl.reqd_work_group_size`.
        let funcs: Vec<OpId> = body.ops_in(op).into_iter().filter(|f| body[*f].name == "llvm.func").collect();
        for f in funcs {
            let Some(sizes) = body[f].get("rocdl.reqd_work_group_size").and_then(Attribute::dense_values) else { continue };
            let flat: i64 = sizes.iter().product();
            body[f].set("rocdl.flat_work_group_size", Attribute::str(&format!("{flat},{flat}")));
        }
        Ok(())
    }
}
