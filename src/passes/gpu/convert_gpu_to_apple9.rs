use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{Error, Op};

use crate::{A, APPLE9_PARAMETERS, Apple9Kernel, Apple9Op, Apple9Type, Apple9Types, Body, ConversionConfig, ConversionPatterns, ConversionTarget, Converter, GpuToApple9, Kernels, Mode, OpData, OpId, Quiet, Rewriter, SinkConstants, WithAttrs, pass};

#[pass("convert-gpu-to-apple9", on = "builtin.module")]
pub fn convert_gpu_to_apple9<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    Kernels::inline_calls(body, op)?;
    let mut shaders = Vec::new();
    body.walk(op, &mut |f| {
        if body[f].name == "gpu.func" && body[f].gpu_kernel() {
            shaders.push(f);
        }
    });
    GpuToApple9::half_workgroups(body, &shaders)?;
    GpuToApple9::for_to_while(body, &shaders);
    body.sink_constants(&shaders);
    let tc = Apple9Types::converter();
    let mut patterns = ConversionPatterns::default();
    let i = patterns.converter(&tc);
    GpuToApple9::populate(&mut patterns, i);
    let mut target = ConversionTarget::default();
    target.legal_dialect("apple9").illegal_dialect("arith").illegal_dialect("vector").illegal_dialect("math").illegal_dialect("llvm");
    for o in ["gpu.func", "gpu.return", "gpu.block_id", "gpu.thread_id", "gpu.block_dim", "gpu.barrier", "scf.for"] {
        target.illegal_op(o);
    }
    for o in ["scf.if", "scf.while", "scf.condition", "scf.yield"] {
        target.dynamic_op(o, |b, op| Some(GpuToApple9::structured_legal(b, op)));
    }
    Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &shaders, Mode::Full)?;

    let mut quiet = Quiet;
    let mut rw = Rewriter::new(body, &mut quiet);
    for k in Kernels::all(rw.body, op, Apple9Kernel::NAME) {
        let block = rw.body.top_block(k);
        let args = rw.body[block].args.clone();
        rw.set_start(block);
        for (i, arg) in args.iter().enumerate() {
            let zero = rw.create(OpData::build(Apple9Op::MovImm.name()).with_attrs(vec![("value", A::from(0u32))]), &[Apple9Type("i32").into()]);
            let zero = rw.body[zero].results[0];
            let attrs = vec![("binding", A::from(APPLE9_PARAMETERS)), ("offset", A::from(4 * i as u32)), ("shift", A::from(0u32))];
            let load = rw.create(OpData::build(Apple9Op::Load.name()).operands(&[zero]).with_attrs(attrs), &[Apple9Type("i32").into()]);
            let v = rw.body[load].results[0];
            rw.replace_all_uses(*arg, v);
        }
        rw.body[block].args.clear();
        let mut grid = Vec::new();
        rw.body.walk(k, &mut |o| {
            if rw.body[o].get("grid").is_some() {
                grid.push(o);
            }
        });
        for g in grid {
            let d = rw.body[g].get("grid").map(crate::Attrs::as_int).transpose().ok().flatten().unwrap_or(0) as u32;
            let offset = 4 * (args.len() as u32 + d);
            rw.modify(g, |b| {
                b[g].remove("grid");
                b[g].set("offset", A::from(offset).into());
            });
        }
    }
    Ok(())
}
