use alloc::vec::Vec;
use mlirformat::Error;
use crate::{Action, Body, ConversionConfig, ConversionPatterns, ConversionTarget, Converter, Mode, OpId, ScfToGpu};

#[crate::pass("convert-parallel-loops-to-gpu")]
pub fn convert_parallel_loops_to_gpu<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let mut patterns = ConversionPatterns::default();
    ScfToGpu::populate(&mut patterns);
    let mut target = ConversionTarget::default();
    target.unknown(Action::Legal).legal_dialect("memref");
    target.op("scf.parallel", Action::Dynamic(alloc::boxed::Box::new(|b: &Body<'_>, o| (b[o].get("mapping").is_none() || b[o].get("SCFToGPU_visited").is_some()).then_some(true))));
    Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)?;
    let mut loops = Vec::new();
    body.walk(op, &mut |o| {
        if body[o].name == "scf.parallel" {
            loops.push(o);
        }
    });
    for l in loops {
        body[l].remove("SCFToGPU_visited");
    }
    Ok(())
}
