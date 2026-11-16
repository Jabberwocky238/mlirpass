//! AMD RDNA2 (gfx1036): its instruction set and PM4 command stream (`dialect.rdna2`), and with
//! `target.rdna2` the lowering of `gpu.func` kernels to it, its passes, the encoder and the image.

mod dialect;
#[cfg(feature = "target.rdna2")]
mod dispatch;
#[cfg(feature = "target.rdna2")]
mod emit;
#[cfg(feature = "target.rdna2")]
mod lower;
#[cfg(feature = "target.rdna2")]
mod passes;

pub use dialect::*;
#[cfg(feature = "target.rdna2")]
pub use dispatch::*;
#[cfg(feature = "target.rdna2")]
pub use emit::*;
#[cfg(feature = "target.rdna2")]
pub use lower::*;
#[cfg(feature = "target.rdna2")]
pub use passes::*;

/// AMD RDNA2 (gfx1036) machine code
#[cfg(feature = "target.rdna2")]
pub struct Rdna2Target;

#[cfg(feature = "target.rdna2")]
impl crate::Target for Rdna2Target {
    fn name(&self) -> &'static str {
        "rdna2"
    }

    fn pipeline(&self) -> &'static str {
        "builtin.module(gpu-inline-calls, canonicalize, cse, convert-gpu-to-rdna2, rdna2-regalloc, rdna2-waitcnt)"
    }
}

#[cfg(feature = "target.rdna2")]
impl crate::GpuTarget for Rdna2Target {
    fn kernel(&self) -> &'static str {
        <Rdna2Kernel as mlirformat::Op>::NAME
    }

    fn code(&self, body: &crate::Body<'_>, kernel: crate::OpId) -> Result<crate::KernelCode, mlirformat::Error> {
        let k = Rdna2Code::of(body, kernel)?;
        Ok(crate::KernelCode { name: k.name, align: k.align, pad: k.pad, bytes: k.bytes, info: alloc::vec![("params", u64::from(k.params)), ("sgprs", u64::from(k.sgprs)), ("vgprs", u64::from(k.vgprs))] })
    }

    fn image_pipeline(&self) -> &'static str {
        "builtin.module(rdna2-pm4, rdna2-pad, rdna2-layout)"
    }
}
