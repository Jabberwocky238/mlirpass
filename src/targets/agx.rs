//! ⭐ AGX out: each `agx.kernel` (registers allocated) ⇒ its instructions' bytes and what the driver needs to run it
//! ([`AgxCode`]); a module of memories ⇒ an [`Image`](crate::Image) ([`AgxImage`], [`AGX_IMAGE`]).

use alloc::borrow::ToOwned;
use alloc::string::String;
use alloc::vec::Vec;

use mlirformat::{Error, Op};

use crate::{Agx, AgxKernel, Body, Emit, Heads, ImageEmit, ImageTarget, Kernels, OpId, ShaderStage, Symbol, Usc};

/// ⭐ One kernel's machine code: its instructions (the footer of traps included), and how to run it.
#[derive(Clone, Debug, PartialEq, Eq)]
pub struct AgxCode {
    pub name: String,
    pub stage: Option<ShaderStage>,
    /// Parameter dwords: uniforms after the 64-bit base.
    pub params: u32,
    /// GPR halves it uses (USC Registers).
    pub gprs: u32,
    pub align: u64,
    pub bytes: Vec<u8>,
}

impl AgxCode {
    /// Kernel `k`'s.
    pub fn of(body: &Body<'_>, k: OpId) -> Result<AgxCode, Error> {
        let head = body.head::<AgxKernel>(k)?;
        let mut bytes = Vec::new();
        for op in body.ops(body.top_block(k)) {
            bytes.extend(Usc::encode(&body[op].name, &body[op].all_attrs())?);
        }
        Ok(AgxCode { name: Symbol::defined(&head.sym_name)?.to_owned(), stage: head.stage, params: head.params.unwrap_or(0), gprs: head.gprs.unwrap_or(0), align: head.align.unwrap_or(1), bytes })
    }
}

/// ⭐ AGX as an [`Emit`] target: every kernel under an op.
pub struct AgxEmit;

impl Emit for AgxEmit {
    type Output = Vec<AgxCode>;

    fn emit(&self, body: &Body<'_>, op: OpId) -> Result<Vec<AgxCode>, Error> {
        Kernels::all(body, op, AgxKernel::NAME).into_iter().map(|k| AgxCode::of(body, k)).collect()
    }
}

/// ⭐ AGX as an image target.
pub struct AgxImage;

impl ImageTarget for AgxImage {
    /// The USC window of an asahi VM (4 GiB, when the VM starts low): shaders are there, and everything else with
    /// them, so a shader's 32-bit address is its offset from the window (`usc_exec_base`) and a buffer's too.
    const BASE: u64 = 1 << 32;
    /// The GPU's page (UAT): 16 KiB.
    const PAGE: u64 = 0x4000;

    /// The ops one after another (ended by `agx-end`).
    fn stream(&self, body: &Body<'_>, stream: OpId) -> Result<Vec<u8>, Error> {
        let mut bytes = Vec::new();
        for op in body.ops(body.top_block(stream)) {
            bytes.extend(Agx::bytes(body, op)?);
        }
        Ok(bytes)
    }

    /// An `agx.kernel` (its instructions), or a descriptor (texture, sampler, PBE ...) placed in memory.
    fn item(&self, body: &Body<'_>, op: OpId) -> Result<Vec<u8>, Error> {
        match &*body[op].name {
            n if n == AgxKernel::NAME => Ok(AgxCode::of(body, op)?.bytes),
            _ => Agx::bytes(body, op),
        }
    }
}

/// ⭐ A module (after `agx-layout`) as an [`Image`](crate::Image).
pub const AGX_IMAGE: ImageEmit<'_, AgxImage> = ImageEmit(&AgxImage);
