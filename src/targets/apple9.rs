use alloc::borrow::ToOwned;
use alloc::collections::BTreeMap;
use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;

use mlirformat::{Error, Op};

use crate::{Apple9Isa, Apple9Kernel, Apple9Op, Attrs, Body, Emit, Heads, Kernels, OpId, ShaderStage, Symbol};

#[derive(Clone, Debug, PartialEq, Eq)]
pub struct Apple9Code {
    pub name: String,
    pub stage: Option<ShaderStage>,
    pub params: u32,
    pub gprs: u32,
    pub shared: u32,
    pub workgroup: u32,
    pub bytes: Vec<u8>,
}

impl Apple9Code {
    pub fn of(body: &Body<'_>, k: OpId) -> Result<Apple9Code, Error> {
        let head = body.head::<Apple9Kernel>(k)?;
        let ops: Vec<OpId> = body.ops(body.top_block(k)).collect();
        let int = |op: OpId, n: &str| body[op].get(n).map(Attrs::as_int).transpose().map(Option::unwrap_or_default);
        let jump = |op: OpId| match Apple9Op::of(&body[op].name) {
            Some(Apple9Op::JmpAny) => Some(true),
            Some(Apple9Op::JmpNone) => Some(false),
            _ => None,
        };
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
        Ok(Apple9Code { name: Symbol::defined(&head.sym_name)?.to_owned(), stage: head.stage, params: head.params.unwrap_or(0), gprs: head.gprs.unwrap_or(0), shared: head.shared.unwrap_or(0), workgroup: head.workgroup.unwrap_or(32), bytes })
    }
}

pub struct Apple9Emit;

impl Emit for Apple9Emit {
    type Output = Vec<Apple9Code>;

    fn emit(&self, body: &Body<'_>, op: OpId) -> Result<Vec<Apple9Code>, Error> {
        Kernels::all(body, op, Apple9Kernel::NAME).into_iter().map(|k| Apple9Code::of(body, k)).collect()
    }
}
