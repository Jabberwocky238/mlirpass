//! `convert-amdgpu-to-rocdl`.

use alloc::format;
use alloc::string::String;

use mlirformat::Error;

use crate::{AmdChipset, AmdgpuRocdlOptions, AmdgpuToRocdl, Body, ConversionConfig, ConversionPatterns, Converter, GpuSpaces, LlvmConverter, LlvmOptions, Mode, OpId};

/// `amdgpu::populateCommonGPUTypeAndAttributeConversions`: global 1, shared 3, private 5.
const ROCDL_SPACES: GpuSpaces = GpuSpaces { global: 1, workgroup: 3, private: 5 };

/// `convert-amdgpu-to-rocdl`, as `ConvertAMDGPUToROCDLPass`.
#[crate::pass("convert-amdgpu-to-rocdl")]
pub struct ConvertAmdgpuToRocdl {
    #[opt("chipset", default = String::from("gfx000"))]
    chipset: String,
}

impl crate::Run for ConvertAmdgpuToRocdl {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let chipset = AmdChipset::try_from(&*self.chipset).map_err(|_| Error(format!("Invalid chipset name: {}", self.chipset)))?;
        let llvm = LlvmOptions { gpu_spaces: Some(ROCDL_SPACES), amdgpu_spaces: true, ..LlvmOptions::default() };
        let tc = LlvmConverter::build(llvm);
        let mut patterns = ConversionPatterns::default();
        let i = patterns.converter(&tc);
        AmdgpuToRocdl::populate(&mut patterns, i, AmdgpuRocdlOptions { llvm, chipset });
        let mut target = crate::llvm_target();
        target.dialect("amdgpu", crate::Action::Illegal).legal_dialect("llvm").legal_dialect("rocdl");
        Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
    }
}
