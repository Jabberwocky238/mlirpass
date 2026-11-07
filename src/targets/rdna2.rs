//! ⭐ RDNA2 out: each `rdna2.kernel` (registers allocated) ⇒ its instructions' bytes and what the driver needs to run
//! it ([`Rdna2Code`]); a module of memories ⇒ an [`Image`](crate::Image) ([`Rdna2Image`], [`RDNA2_IMAGE`]).

use alloc::borrow::ToOwned;
use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;

use mlirformat::{Error, Op};

use crate::{Body, Emit, Heads, ImageEmit, ImageTarget, Kernels, OpId, Pm4, Rdna2Isa, Rdna2Kernel, ShaderStage, Symbol};

/// ⭐ One kernel's machine code: its instructions (no padding), and how to run it.
#[derive(Clone, Debug, PartialEq, Eq)]
pub struct Rdna2Code {
    pub name: String,
    pub stage: Option<ShaderStage>,
    /// Parameter dwords, user SGPRs s0 ... (COMPUTE_USER_DATA_*).
    pub params: u32,
    /// Registers it uses (COMPUTE_PGM_RSRC1's VGPRS / SGPRS).
    pub sgprs: u32,
    pub vgprs: u32,
    /// Zeros the instruction prefetch reads past its end, and its alignment.
    pub pad: u64,
    pub align: u64,
    pub bytes: Vec<u8>,
}

/// ⭐ RDNA2 as an [`Emit`] target: every kernel under an op.
pub struct Rdna2Emit;

impl Emit for Rdna2Emit {
    type Output = Vec<Rdna2Code>;

    fn emit(&self, body: &Body<'_>, op: OpId) -> Result<Vec<Rdna2Code>, Error> {
        Kernels::all(body, op, Rdna2Kernel::NAME).into_iter().map(|k| Rdna2Code::of(body, k)).collect()
    }
}

impl Rdna2Code {
    /// Kernel `k`'s.
    pub fn of(body: &Body<'_>, k: OpId) -> Result<Rdna2Code, Error> {
        let head = body.head::<Rdna2Kernel>(k)?;
        let mut bytes = Vec::new();
        for op in body.ops(body.top_block(k)) {
            bytes.extend(Rdna2Isa::encode(body, op)?.iter().flat_map(|d| d.to_le_bytes()));
        }
        Ok(Rdna2Code {
            name: Symbol::defined(&head.sym_name)?.to_owned(),
            stage: head.stage,
            params: head.params.unwrap_or(0),
            sgprs: head.sgprs.unwrap_or(0),
            vgprs: head.vgprs.unwrap_or(0),
            pad: head.pad.unwrap_or(0),
            align: head.align.unwrap_or(1),
            bytes,
        })
    }
}

/// ⭐ RDNA2 as an image target.
pub struct Rdna2Image;

impl ImageTarget for Rdna2Image {
    /// 16 MiB, inside amdgpu's low VA range (it starts at 2 MiB) and below 4 GiB: shader addresses are 32-bit bytes
    /// (a global access adds them to a zero base, `saddr`).
    const BASE: u64 = 0x100_0000;
    /// The PTE fragment amdgpu maps with (64 KiB).
    const PAGE: u64 = 0x1_0000;

    /// The ops one by one (after `rdna2-pm4`, `rdna2-pad`).
    fn stream(&self, body: &Body<'_>, stream: OpId) -> Result<Vec<u8>, Error> {
        let mut dw = Vec::new();
        for op in body.ops(body.top_block(stream)) {
            dw.extend(Pm4::pack(body, op)?);
        }
        Ok(dw.iter().flat_map(|d| d.to_le_bytes()).collect())
    }

    /// An `rdna2.kernel`: its instructions, then its `pad` zeros.
    fn item(&self, body: &Body<'_>, op: OpId) -> Result<Vec<u8>, Error> {
        if body[op].name != Rdna2Kernel::NAME {
            return Err(Error(format!("{} cannot be placed in memory", body[op].name)));
        }
        let code = Rdna2Code::of(body, op)?;
        let mut bytes = code.bytes;
        bytes.resize(bytes.len() + code.pad as usize, 0);
        Ok(bytes)
    }
}

/// ⭐ A module (after `rdna2-layout`) as an [`Image`](crate::Image).
pub const RDNA2_IMAGE: ImageEmit<'_, Rdna2Image> = ImageEmit(&Rdna2Image);
