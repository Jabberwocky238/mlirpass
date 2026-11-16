use alloc::borrow::ToOwned;
use alloc::vec::Vec;

use mlirformat::{Attribute, Error};
use serde::{Deserialize, Serialize};

use crate::{Body, Mapping, OpId};

#[derive(Clone, Copy, Debug, PartialEq, Eq, Serialize, Deserialize)]
#[serde(rename_all = "lowercase")]
pub enum ShaderStage {
    Vertex,
    Fragment,
    Compute,
}

pub struct Kernels;

impl Kernels {
    pub fn all(body: &Body<'_>, op: OpId, name: &str) -> Vec<OpId> {
        let mut out = Vec::new();
        body.walk(op, &mut |o| {
            if body[o].name == name {
                out.push(o);
            }
        });
        out
    }
}

impl Kernels {
    pub fn inline_calls(body: &mut Body<'_>, op: OpId) -> Result<(), Error> {
        for _ in 0..64 {
            let mut calls = Vec::new();
            body.walk(op, &mut |o| {
                if body[o].name == "func.call" && Self::in_kernel(body, o) {
                    calls.push(o);
                }
            });
            if calls.is_empty() {
                return Self::erase_unused(body, op);
            }
            for call in calls {
                Self::inline(body, call)?;
            }
        }
        Err(Error("inlining the kernels' calls does not end (a recursive call?)".into()))
    }

    fn in_kernel(body: &Body<'_>, o: OpId) -> bool {
        let mut at = body.parent_op(o);
        while let Some(p) = at {
            if body[p].name == "gpu.func" {
                return true;
            }
            at = body.parent_op(p);
        }
        false
    }

    fn inline(body: &mut Body<'_>, call: OpId) -> Result<(), Error> {
        let name = match body[call].get("callee") {
            Some(Attribute::SymbolRef(p)) if p.len() == 1 => p[0].trim_matches('"').to_owned(),
            _ => return Err(Error("func.call without a callee".into())),
        };
        let module = Self::module_of(body, call).ok_or_else(|| Error("a kernel outside a gpu.module".into()))?;
        let callee = body
            .ops(body.top_block(module))
            .find(|f| body[*f].name == "func.func" && body[*f].get("sym_name").is_some_and(|s| matches!(s, Attribute::Str { lit, .. } if *lit == *name)))
            .ok_or_else(|| Error(alloc::format!("@{name}: no func.func in the kernel's gpu.module")))?;
        let region = body[callee].regions.first().copied().ok_or_else(|| Error(alloc::format!("@{name}: no body")))?;
        let [entry] = body[region].blocks[..] else { return Err(Error(alloc::format!("@{name}: more than one block"))) };
        let mut map = Mapping::default();
        for (a, v) in body[entry].args.clone().into_iter().zip(body[call].operands.clone()) {
            map.map(a, v);
        }
        let mut results = Vec::new();
        for o in body.block_ops(entry) {
            if body[o].name == "func.return" {
                results = body[o].operands.iter().map(|v| map.get(*v)).collect();
                continue;
            }
            let c = body.clone_op(o, &mut map);
            body.insert_before(c, call);
        }
        for (r, v) in body[call].results.clone().into_iter().zip(results) {
            body.replace_all_uses(r, v);
        }
        body.erase(call);
        Ok(())
    }

    fn module_of(body: &Body<'_>, o: OpId) -> Option<OpId> {
        let mut at = body.parent_op(o);
        while let Some(p) = at {
            if body[p].name == "gpu.module" {
                return Some(p);
            }
            at = body.parent_op(p);
        }
        None
    }

    fn erase_unused(body: &mut Body<'_>, op: OpId) -> Result<(), Error> {
        loop {
            let mut called = alloc::collections::BTreeSet::new();
            let mut funcs = Vec::new();
            body.walk(op, &mut |o| {
                if let Some(Attribute::SymbolRef(p)) = body[o].get("callee") {
                    called.insert(p[0].trim_matches('"').to_owned());
                }
                if body[o].name == "func.func" && Self::module_of(body, o).is_some() && body[o].get("sym_visibility").is_some_and(|v| matches!(v, Attribute::Str { lit, .. } if *lit == "private")) {
                    funcs.push(o);
                }
            });
            let unused: Vec<OpId> = funcs.into_iter().filter(|f| body[*f].get("sym_name").is_some_and(|s| matches!(s, Attribute::Str { lit, .. } if !called.contains(&**lit)))).collect();
            if unused.is_empty() {
                return Ok(());
            }
            for f in unused {
                body.erase(f);
            }
        }
    }
}
