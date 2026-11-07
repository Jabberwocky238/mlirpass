//! `convert-gpu-to-xe3`: the kernels' calls inlined ([`Kernels::inline_calls`]); every shader (a `gpu.func` kernel,
//! a `func.func {spirv.execution_model}`) ⇒ an `xe3.kernel` of virtual EU instructions ([`GpuToXe3`]), its structured control
//! flow kept (of registers: `xe3-control` makes it branches); then each kernel's arguments where the thread finds
//! them, its IEEE prologue and its `reserve` ([`GpuToXe3::place_arguments`]).

use alloc::vec::Vec;

use mlirformat::Error;

use crate::{Body, ConversionConfig, ConversionPatterns, ConversionTarget, Converter, GpuToXe3, Kernels, Mode, OpId, SinkConstants, Xe3Types, pass};

/// `convert-gpu-to-xe3`.
#[pass("convert-gpu-to-xe3", on = "builtin.module")]
pub fn convert_gpu_to_xe3<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    Kernels::inline_calls(body, op)?;
    let mut shaders = Vec::new();
    body.walk(op, &mut |f| {
        if GpuToXe3::stage_of(body, f).is_some() {
            shaders.push(f);
        }
    });
    body.sink_constants(&shaders);
    GpuToXe3::resources(body, &shaders)?;
    let tc = Xe3Types::converter();
    let mut patterns = ConversionPatterns::default();
    let i = patterns.converter(&tc);
    GpuToXe3::populate(&mut patterns, i);
    let mut target = ConversionTarget::default();
    target.legal_dialect("xe3").illegal_dialect("spirv").illegal_dialect("arith").illegal_dialect("vector").illegal_dialect("math").illegal_dialect("llvm");
    for o in ["func.func", "func.return", "gpu.func", "gpu.return", "gpu.block_id", "gpu.thread_id", "gpu.barrier"] {
        target.illegal_op(o);
    }
    // structured control flow stays, of registers
    for o in ["scf.for", "scf.if", "scf.while", "scf.condition", "scf.yield"] {
        target.dynamic_op(o, |b, op| Some(GpuToXe3::structured_legal(b, op)));
    }
    Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &shaders, Mode::Full)?;
    GpuToXe3::place_arguments(body, op)
}
