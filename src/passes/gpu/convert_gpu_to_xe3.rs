//! `convert-gpu-to-xe3`: the kernels' calls inlined ([`Kernels::inline_calls`]); the compute kernels of each
//! `gpu.module` ⇒ `xe3.kernel`s of virtual EU instructions ([`GpuToXe3`]), structured control flow kept (of
//! registers); then each kernel's parameters read from the inline data, the IEEE prologue, the registers the
//! allocator may use (`reserve`).

use alloc::vec::Vec;

use mlirformat::{Error, Op};

use crate::{Body, ConversionConfig, ConversionPatterns, ConversionTarget, Converter, GpuToXe3, Kernels, Mode, OpId, Quiet, Rewriter, SinkConstants, Xe3Kernel, Xe3Types, pass};

/// `convert-gpu-to-xe3`.
#[pass("convert-gpu-to-xe3", on = "builtin.module")]
pub fn convert_gpu_to_xe3<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    Kernels::inline_calls(body, op)?;
    let mut shaders = Vec::new();
    body.walk(op, &mut |f| {
        if body[f].name == "gpu.func" && body[f].get("gpu.kernel").is_some() {
            shaders.push(f);
        }
    });
    body.sink_constants(&shaders);
    let tc = Xe3Types::converter();
    let mut patterns = ConversionPatterns::default();
    let i = patterns.converter(&tc);
    GpuToXe3::populate(&mut patterns, i);
    let mut target = ConversionTarget::default();
    target.legal_dialect("xe3").illegal_dialect("arith").illegal_dialect("vector").illegal_dialect("math").illegal_dialect("llvm");
    for o in ["gpu.func", "gpu.return", "gpu.block_id", "gpu.thread_id", "gpu.barrier"] {
        target.illegal_op(o);
    }
    // structured control flow stays, of registers
    for o in ["scf.for", "scf.if", "scf.while", "scf.condition", "scf.yield"] {
        target.dynamic_op(o, |b, op| Some(GpuToXe3::structured_legal(b, op)));
    }
    Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &shaders, Mode::Full)?;

    let mut quiet = Quiet;
    let mut rw = Rewriter::new(body, &mut quiet);
    for k in Kernels::all(rw.body, op, Xe3Kernel::NAME) {
        GpuToXe3::place_arguments(&mut rw, k)?;
    }
    Ok(())
}
