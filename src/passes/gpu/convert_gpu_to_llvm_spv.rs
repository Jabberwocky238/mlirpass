//! `convert-gpu-to-llvm-spv`.

use alloc::vec::Vec;

use mlirformat::{Attribute, NamedAttr, Shaped, ShapedKind, Type};

use crate::{Body, CConv, ConversionConfig, ConversionPatterns, Converter, GpuLlvmOptions, GpuSpaces, GpuToLlvm, GpuToLlvmSpv, LlvmConverter, LlvmOptions, Mode, OpId, Printf, PrintfCall};

/// `MemorySpaceToOpenCLMemorySpaceConverter` with the `AttrTypeReplacer` around it: memrefs
/// without a memory space get OpenCL's global one (CrossWorkgroup, 1), everywhere under an op.
struct OpenClGlobal;

impl OpenClGlobal {
    fn map_type<'a>(t: &Type<'a>) -> Type<'a> {
        match t {
            Type::Shaped(s) if s.kind == ShapedKind::MemRef && s.memory_space().is_none() => {
                let mut extras = s.extras.clone();
                // An `i64` memory space prints (and parses back) bare.
                extras.push(Attribute::of_int(GpuSpaces::OPENCL.global.into(), Type::int(64)).untyped());
                Type::Shaped(alloc::boxed::Box::new(Shaped { extras, ..*s.clone() }))
            }
            Type::Function(f) => Type::Function(alloc::boxed::Box::new(mlirformat::FunctionType { inputs: f.inputs.iter().map(Self::map_type).collect(), results: f.results.iter().map(Self::map_type).collect() })),
            Type::Tuple(ts) => Type::Tuple(ts.iter().map(Self::map_type).collect()),
            t => t.clone(),
        }
    }

    fn map_attr<'a>(a: &Attribute<'a>) -> Attribute<'a> {
        match a {
            Attribute::Type(t) => Attribute::Type(Self::map_type(t)),
            Attribute::Array(es) => Attribute::Array(es.iter().map(Self::map_attr).collect()),
            Attribute::Dict(es) => Attribute::Dict(es.iter().map(Self::map_named).collect()),
            a => a.clone(),
        }
    }

    fn map_named<'a>(n: &NamedAttr<'a>) -> NamedAttr<'a> {
        NamedAttr { name: n.name.clone(), value: n.value.as_ref().map(Self::map_attr) }
    }

    /// Every value, block argument and attribute under `op`.
    fn apply(body: &mut Body<'_>, op: OpId) {
        for o in body.ops_in(op) {
            for v in body[o].results.clone() {
                body[v].ty = Self::map_type(&body[v].ty);
            }
            for r in body[o].regions.clone() {
                for b in body[r].blocks.clone() {
                    for a in body[b].args.clone() {
                        body[a].ty = Self::map_type(&body[a].ty);
                    }
                }
            }
            let props: Vec<NamedAttr<'_>> = body[o].properties.iter().map(Self::map_named).collect();
            body[o].properties = props;
            let attrs: Vec<NamedAttr<'_>> = body[o].attributes.iter().map(Self::map_named).collect();
            body[o].attributes = attrs;
        }
    }
}

/// The ops `GPUToLLVMSPVConversionPass` makes illegal.
const ILLEGAL: [&str; 14] = ["gpu.barrier", "gpu.block_dim", "gpu.block_id", "gpu.func", "gpu.global_id", "gpu.grid_dim", "gpu.lane_id", "gpu.num_subgroups", "gpu.return", "gpu.shuffle", "gpu.subgroup_id", "gpu.subgroup_size", "gpu.thread_id", "gpu.printf"];

/// `convert-gpu-to-llvm-spv`.
#[crate::pass("convert-gpu-to-llvm-spv", on = "gpu.module")]
pub struct ConvertGpuToLlvmSpv {
    #[opt("use-64bit-index")]
    index64: bool,
}

impl crate::Run for ConvertGpuToLlvmSpv {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), mlirformat::Error> {
        let llvm = LlvmOptions { index_bitwidth: if self.index64 { 64 } else { 32 }, gpu_spaces: Some(GpuSpaces::OPENCL), ..LlvmOptions::default() };
        OpenClGlobal::apply(body, op);
        let tc = LlvmConverter::build(llvm);
        let mut patterns = ConversionPatterns::default();
        let i = patterns.converter(&tc);
        let gpu = GpuLlvmOptions {
            llvm,
            alloca_space: GpuSpaces::OPENCL.private,
            workgroup_space: GpuSpaces::OPENCL.workgroup,
            kernel_attr: None,
            block_size_attr: Some("reqd_work_group_size"),
            cluster_size_attr: None,
            kernel_cconv: CConv::SpirKernel,
            func_cconv: CConv::SpirFunc,
            workgroup_args: true,
            printf: Some(Printf::Call(PrintfCall { space: 2, cconv: CConv::SpirFunc, name: "_Z6printfPU3AS2Kcz" })),
            dynamic_shmem_align: None,
        };
        GpuToLlvmSpv::populate(&mut patterns, i, llvm);
        GpuToLlvm::populate(&mut patterns, i, gpu);
        let mut target = crate::llvm_target();
        for name in ILLEGAL {
            target.illegal_op(name);
        }
        Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
    }
}
