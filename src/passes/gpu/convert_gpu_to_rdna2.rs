//! `convert-gpu-to-rdna2`: the compute kernels of each `gpu.module` ⇒ `rdna2.kernel`s of virtual RDNA2 instructions
//! ([`GpuToRdna2`]); then each kernel's parameters, user SGPRs s0 ..., copied to VGPRs at its start (a VALU source
//! is a VGPR).

use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{Error, Op};

use crate::{Body, ConversionConfig, ConversionPatterns, ConversionTarget, Converter, GpuToRdna2, Kernels, Mode, OpId, Quiet, Rdna2Build, Rdna2Input, Rdna2Kernel, Rdna2Opcode, Rdna2Slot, Rdna2Type, Rdna2Types, Rdna2Valu, Rewriter, SinkConstants, Updates, pass, RDNA2_KERNEL_ALIGN, RDNA2_KERNEL_PAD};

/// `convert-gpu-to-rdna2`.
#[pass("convert-gpu-to-rdna2", on = "builtin.module")]
pub fn convert_gpu_to_rdna2<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let mut shaders = Vec::new();
    body.walk(op, &mut |f| {
        if body[f].name == "gpu.func" && body[f].get("gpu.kernel").is_some() {
            shaders.push(f);
        }
    });
    body.sink_constants(&shaders);
    let tc = Rdna2Types::converter();
    let mut patterns = ConversionPatterns::default();
    let i = patterns.converter(&tc);
    GpuToRdna2::populate(&mut patterns, i);
    let mut target = ConversionTarget::default();
    target.legal_dialect("rdna2").illegal_dialect("arith").illegal_dialect("vector").illegal_dialect("math").illegal_dialect("llvm");
    for o in ["gpu.func", "gpu.return", "gpu.block_id", "gpu.thread_id"] {
        target.illegal_op(o);
    }
    Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &shaders, Mode::Full)?;

    let mut quiet = Quiet;
    let mut rw = Rewriter::new(body, &mut quiet);
    for k in Kernels::all(rw.body, op, Rdna2Kernel::NAME) {
        rw.update::<Rdna2Kernel>(k, |k| (k.pad, k.align) = (Some(RDNA2_KERNEL_PAD), Some(RDNA2_KERNEL_ALIGN)))?;
        let block = rw.body.top_block(k);
        let args = rw.body[block].args.clone();
        rw.set_start(block);
        for (i, arg) in args.iter().enumerate() {
            let s = rw.emit(&Rdna2Input::new(i as i64, Rdna2Type::S("i32").into()));
            let s = rw.body[s].results[0];
            let (copy, types) = Rdna2Build::new::<Rdna2Valu>(Rdna2Opcode::VMovB32, &[s], &[Rdna2Slot::Src0], vec![Rdna2Type::V("i32").into()]).split();
            let v = rw.create(copy, &types);
            let v = rw.body[v].results[0];
            rw.replace_all_uses(*arg, v);
        }
        rw.body[block].args.clear();
    }
    Ok(())
}
