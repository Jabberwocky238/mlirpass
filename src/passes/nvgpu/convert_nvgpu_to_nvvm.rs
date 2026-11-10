//! `convert-nvgpu-to-nvvm`.

use mlirformat::Error;

use crate::{Action, Body, ConversionConfig, ConversionPatterns, Converter, GpuSpaces, LlvmConverter, LlvmOptions, Mode, NvgpuToNvvm, NvgpuType, OpId};

/// `nvgpu::populateCommonGPUTypeAndAttributeConversions`: global 1, shared 3, private 0.
const NVVM_SPACES: GpuSpaces = GpuSpaces { global: 1, workgroup: 3, private: 0, constant: 4 };

/// `convert-nvgpu-to-nvvm`, as `ConvertNVGPUToNVVMPass`: nvgpu illegal; llvm, arith, memref and
/// nvvm legal; scf legal on converted types.
#[crate::pass("convert-nvgpu-to-nvvm")]
pub fn convert_nvgpu_to_nvvm<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let llvm = LlvmOptions { gpu_spaces: Some(NVVM_SPACES), ..LlvmOptions::default() };
    let mut tc = LlvmConverter::build(llvm);
    NvgpuType::convert(&mut tc, llvm, body.ctx.opt);
    let mut patterns = ConversionPatterns::default();
    let i = patterns.converter(&tc);
    NvgpuToNvvm::populate(&mut patterns, i, llvm);
    let mut target = crate::llvm_target();
    for d in ["llvm", "arith", "memref", "nvvm"] {
        target.legal_dialect(d);
    }
    target.dialect("nvgpu", Action::Illegal);
    let tcr = &tc;
    target.dialect("scf", Action::Dynamic(alloc::boxed::Box::new(move |b: &Body<'_>, o: OpId| Some(tcr.scf_structural_legal(b, o)))));
    Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
}
