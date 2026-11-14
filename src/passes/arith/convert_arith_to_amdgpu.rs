use alloc::format;
use alloc::string::String;

use mlirformat::Error;

use crate::{AmdChipset, ArithToAmdgpu, Body, GreedyConfig, OpId, PatternSet};

#[crate::pass("convert-arith-to-amdgpu")]
pub struct ConvertArithToAmdgpu {
    #[opt("chipset", default = String::from("gfx000"))]
    chipset: String,
    #[opt("saturate-fp8-truncf")]
    saturate: bool,
    #[opt("allow-packed-f16-round-to-zero")]
    packed_f16_rtz: bool,
}

impl crate::Run for ConvertArithToAmdgpu {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let chipset = AmdChipset::try_from(&*self.chipset).map_err(|_| Error(format!("Invalid chipset name: {}", self.chipset)))?;
        let mut set = PatternSet::default();
        ArithToAmdgpu::for_chipset(&mut set, chipset, self.saturate, self.packed_f16_rtz);
        for r in body[op].regions.clone() {
            body.apply_greedily(r, &set, &GreedyConfig { region_simplify: crate::RegionSimplify::Aggressive, ..GreedyConfig::default() });
        }
        Ok(())
    }
}
