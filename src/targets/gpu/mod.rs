//! What the GPU machine-code targets share: the `GpuTarget` trait, kernels and stages, register
//! allocation, a draw described without the GPU, and the lane-by-lane lowering helpers.

#[cfg(feature = "target.gpu")]
mod draw;
#[cfg(feature = "target.gpu")]
mod lanes;
#[cfg(feature = "target.gpu")]
mod regalloc;
mod shader;

#[cfg(feature = "target.gpu")]
pub use draw::*;
#[cfg(feature = "target.gpu")]
pub use regalloc::*;
pub use shader::*;

use alloc::string::String;
use alloc::vec::Vec;

use mlirformat::Error;

use crate::{Body, OpId, Target};

/// One kernel's machine code as a `#gpu.object` carries it.
#[derive(Clone, Debug, PartialEq, Eq)]
pub struct KernelCode {
    pub name: String,
    /// The code's start is a multiple of this many bytes
    pub align: u64,
    /// Zero bytes after the code (instruction prefetch past the end)
    pub pad: u64,
    pub bytes: Vec<u8>,
    /// What a launch needs to know, by name (registers, parameters, workgroup)
    pub info: Vec<(&'static str, u64)>,
}

/// A GPU's own machine code: kernels of one op, each encoded on its own.
pub trait GpuTarget: Target {
    /// The kernel op its lowering produces
    fn kernel(&self) -> &'static str;

    fn code(&self, body: &Body<'_>, kernel: OpId) -> Result<KernelCode, Error>;

    /// The passes from encoded kernels and command streams to the image's layout
    fn image_pipeline(&self) -> &'static str;

    fn kernels(&self, body: &Body<'_>, module: OpId) -> Result<Vec<KernelCode>, Error> {
        Kernels::all(body, module, self.kernel()).into_iter().map(|k| self.code(body, k)).collect()
    }

    /// Whether `module` holds this target's kernels
    fn holds(&self, body: &Body<'_>, module: OpId) -> bool {
        body.ops(body.top_block(module)).any(|o| body[o].name == self.kernel())
    }
}
