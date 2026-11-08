//! ⭐ Apple9 out: each `apple9.kernel` (registers allocated, waits placed) ⇒ its instructions' bytes and what running
//! it needs ([`Apple9Code`]).
//!
//! How it runs (the Metal compute ABI this target assumes; scripts/apple9_metal.swift puts it there): a workgroup of
//! 16 threads; binding 0 the memory (a load's / store's address is a byte offset into it), binding 1 the parameter
//! buffer (the kernel reads parameter k at byte 4k at its start).

use alloc::borrow::ToOwned;
use alloc::string::String;
use alloc::vec::Vec;

use mlirformat::{Error, Op};

use crate::{Apple9Isa, Apple9Kernel, Body, Emit, Heads, Kernels, OpId, ShaderStage, Symbol};

/// ⭐ One kernel's machine code and how to run it.
#[derive(Clone, Debug, PartialEq, Eq)]
pub struct Apple9Code {
    pub name: String,
    pub stage: Option<ShaderStage>,
    /// Parameter words.
    pub params: u32,
    /// GPRs it uses: r0 .. r(gprs - 1).
    pub gprs: u32,
    pub bytes: Vec<u8>,
}

impl Apple9Code {
    /// Kernel `k`'s.
    pub fn of(body: &Body<'_>, k: OpId) -> Result<Apple9Code, Error> {
        let head = body.head::<Apple9Kernel>(k)?;
        let mut bytes = Vec::new();
        for op in body.ops(body.top_block(k)) {
            bytes.extend(Apple9Isa::encode(&body[op].name, &body[op].all_attrs())?);
        }
        Ok(Apple9Code { name: Symbol::defined(&head.sym_name)?.to_owned(), stage: head.stage, params: head.params.unwrap_or(0), gprs: head.gprs.unwrap_or(0), bytes })
    }
}

/// ⭐ Apple9 as an [`Emit`] target: every kernel under an op.
pub struct Apple9Emit;

impl Emit for Apple9Emit {
    type Output = Vec<Apple9Code>;

    fn emit(&self, body: &Body<'_>, op: OpId) -> Result<Vec<Apple9Code>, Error> {
        Kernels::all(body, op, Apple9Kernel::NAME).into_iter().map(|k| Apple9Code::of(body, k)).collect()
    }
}
