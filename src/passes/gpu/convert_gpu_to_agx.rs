use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{Error, Op};

use crate::{AGX_KERNEL_ALIGN, AGX_PARAM_UNIFORM, AgxKernel, AgxSlot, AgxType, AgxTypes, Body, ConversionConfig, ConversionPatterns, ConversionTarget, Converter, GpuToAgx, Kernels, Mode, OpId, Quiet, Rewriter, SinkConstants, Updates, UscBuild, UscInput, UscOp, pass};

#[pass("convert-gpu-to-agx", on = "builtin.module")]
pub fn convert_gpu_to_agx<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    Kernels::inline_calls(body, op)?;
    let mut shaders = Vec::new();
    body.walk(op, &mut |f| {
        if body[f].name == "gpu.func" && body[f].gpu_kernel() {
            shaders.push(f);
        }
    });
    body.sink_constants(&shaders);
    let tc = AgxTypes::converter();
    let mut patterns = ConversionPatterns::default();
    let i = patterns.converter(&tc);
    GpuToAgx::populate(&mut patterns, i);
    let mut target = ConversionTarget::default();
    target.legal_dialect("agx").illegal_dialect("arith").illegal_dialect("vector").illegal_dialect("math").illegal_dialect("llvm");
    for o in ["gpu.func", "gpu.return", "gpu.block_id", "gpu.thread_id"] {
        target.illegal_op(o);
    }
    Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &shaders, Mode::Full)?;

    let mut quiet = Quiet;
    let mut rw = Rewriter::new(body, &mut quiet);
    for k in Kernels::all(rw.body, op, AgxKernel::NAME) {
        rw.update::<AgxKernel>(k, |k| k.align = Some(AGX_KERNEL_ALIGN))?;
        let block = rw.body.top_block(k);
        let args = rw.body[block].args.clone();
        rw.set_start(block);
        for (i, arg) in args.iter().enumerate() {
            let u = rw.emit(&UscInput::new(i64::from(AGX_PARAM_UNIFORM) + 2 * i as i64, AgxType::U("i32").into()));
            let u = rw.body[u].results[0];
            let (copy, types) = UscBuild::new(UscOp::Mov, &[u], &[AgxSlot::S0], vec![AgxType::R("i32").into()]).split();
            let v = rw.create(copy, &types);
            let v = rw.body[v].results[0];
            rw.replace_all_uses(*arg, v);
        }
        rw.body[block].args.clear();
    }
    Ok(())
}
