//! `spirv-promote-to-replicated-constants`.

use crate::{is_composite, splat};
use alloc::vec::Vec;
use mlirformat::{Attribute, Error};
use crate::{Body, OpData, OpId};

/// `spirv-promote-to-replicated-constants`: splat composites as `SPV_EXT_replicated_composites`
/// replicates.
#[crate::pass("spirv-promote-to-replicated-constants", on = "spirv.module")]
pub fn spirv_promote_to_replicated_constants<'a>(body: &mut Body<'a>, module: OpId) -> Result<(), Error> {
    let mut ops = Vec::new();
    body.walk_post(module, &mut |o| ops.push(o));
    for o in ops {
        let replacement = match &*body[o].name {
            "spirv.Constant" => {
                let ty = body[body[o].results[0]].ty.clone();
                let Some((value, n)) = body[o].get("value").and_then(|v| splat(v, Some(&ty))) else { continue };
                if n == 1 {
                    continue;
                }
                let c = body.create(OpData::build("spirv.EXT.ConstantCompositeReplicate").with("value", value), &[ty]);
                body.insert_before(c, o);
                let (from, to) = (body[o].results[0], body[c].results[0]);
                body.replace_all_uses(from, to);
                c
            }
            "spirv.SpecConstantComposite" => {
                let Some(Attribute::Type(ty)) = body[o].get("type").cloned() else { continue };
                if !is_composite(&ty) {
                    continue;
                }
                let Some(Attribute::Array(parts)) = body[o].get("constituents").cloned() else { continue };
                if parts.len() == 1 || !parts.iter().all(|p| *p == parts[0]) || !matches!(&parts[0], Attribute::SymbolRef(s) if s.len() == 1) {
                    continue;
                }
                let Some(name) = body[o].get("sym_name").cloned() else { continue };
                let data = OpData::build("spirv.EXT.SpecConstantCompositeReplicate").with("constituent", parts[0].clone()).with("sym_name", name).with("type", Attribute::Type(ty));
                let c = body.create(data, &[]);
                body.insert_before(c, o);
                c
            }
            _ => continue,
        };
        body[replacement].loc = body[o].loc.clone();
        body.erase(o);
    }
    Ok(())
}
