//! ⭐ Apple9 out: each `apple9.kernel` (registers allocated, waits placed) ⇒ its instructions' bytes and what running
//! it needs ([`Apple9Code`]).
//!
//! How it runs (the Metal compute ABI this target assumes; scripts/apple9_metal.swift puts it there): a workgroup of
//! 32 threads (APPLE9_WORKGROUP); binding 0 the memory (a load's / store's address is a byte offset into it), binding 1 the parameter
//! buffer (the kernel reads parameter k at byte 4k at its start; after the parameters the grid's size in workgroups,
//! x, y, z, which the dispatcher writes); up to APPLE9_SHARED bytes of threadgroup memory (one
//! array, the donor's).

use alloc::borrow::ToOwned;
use alloc::collections::BTreeMap;
use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;

use mlirformat::{Error, Op};

use crate::{Apple9Isa, Apple9Kernel, Apple9Op, Attrs, Body, Emit, Heads, Kernels, OpId, ShaderStage, Symbol};

/// ⭐ One kernel's machine code and how to run it.
#[derive(Clone, Debug, PartialEq, Eq)]
pub struct Apple9Code {
    pub name: String,
    pub stage: Option<ShaderStage>,
    /// Parameter words.
    pub params: u32,
    /// GPRs it uses: r0 .. r(gprs - 1).
    pub gprs: u32,
    /// Bytes of threadgroup memory.
    pub shared: u32,
    pub bytes: Vec<u8>,
}

impl Apple9Code {
    /// Kernel `k`'s.
    pub fn of(body: &Body<'_>, k: OpId) -> Result<Apple9Code, Error> {
        let head = body.head::<Apple9Kernel>(k)?;
        let ops: Vec<OpId> = body.ops(body.top_block(k)).collect();
        let int = |op: OpId, n: &str| body[op].get(n).map(Attrs::as_int).transpose().map(Option::unwrap_or_default);
        let jump = |op: OpId| match Apple9Op::of(&body[op].name) {
            Some(Apple9Op::JmpAny) => Some(true),
            Some(Apple9Op::JmpNone) => Some(false),
            _ => None,
        };
        // every instruction but the jumps encoded; the labels where they are
        let mut code = Vec::new();
        let mut labels = BTreeMap::new();
        let mut at = 0;
        for &op in &ops {
            let bytes = if jump(op).is_some() { Vec::new() } else { Apple9Isa::encode(&body[op].name, &body[op].all_attrs())? };
            if Apple9Op::of(&body[op].name) == Some(Apple9Op::Label) {
                labels.insert(int(op, "id")?, at);
            }
            at += if jump(op).is_some() { Apple9Isa::JUMP_BYTES } else { bytes.len() };
            code.push(bytes);
        }
        let mut bytes = Vec::new();
        for (&op, b) in ops.iter().zip(code) {
            match jump(op) {
                Some(any) => {
                    let to = labels.get(&int(op, "to")?).ok_or_else(|| Error(format!("{}: no label {}", body[op].name, int(op, "to").unwrap_or(-1))))?;
                    bytes.extend(Apple9Isa::jump(any, *to as i64 - bytes.len() as i64)?);
                }
                None => bytes.extend(b),
            }
        }
        Ok(Apple9Code { name: Symbol::defined(&head.sym_name)?.to_owned(), stage: head.stage, params: head.params.unwrap_or(0), gprs: head.gprs.unwrap_or(0), shared: head.shared.unwrap_or(0), bytes })
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
