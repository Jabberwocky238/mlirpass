//! `decorate-spirv-composite-type-layout`.

use alloc::format;
use alloc::vec::Vec;
use mlirformat::spirv_types::SpirvType;
use mlirformat::{Attribute, Error};
use crate::VulkanLayout;
use crate::{Body, OpId};

/// `decorate-spirv-composite-type-layout`: each `spirv.module`'s globals of buffer structs
/// get Vulkan offsets and strides, and their `spirv.mlir.addressof`s the new type.
#[crate::pass("decorate-spirv-composite-type-layout", on = "builtin.module")]
pub fn decorate_spirv_composite_type_layout<'a>(body: &mut Body<'a>, module: OpId) -> Result<(), Error> {
    let modules: Vec<OpId> = body[body.top_block(module)].ops.iter().copied().filter(|o| body[*o].name == "spirv.module").collect();
    for m in modules {
        let mut retyped = Vec::new();
        for g in body[body.top_block(m)].ops.clone() {
            let Some(Attribute::Type(t)) = body[g].get("type").cloned().filter(|_| body[g].name == "spirv.GlobalVariable") else { continue };
            if VulkanLayout::is_legal(&t) {
                continue;
            }
            let Ok(SpirvType::Ptr { pointee, storage }) = SpirvType::try_from(&t) else { continue };
            let Some((decorated, ..)) = VulkanLayout::decorate(&pointee) else {
                return Err(Error(format!("'spirv.GlobalVariable' op failed to decorate (unsuported pointee type: '{pointee}')")));
            };
            let ty = SpirvType::ptr(decorated, &storage);
            body[g].set("type", Attribute::Type(ty.clone()));
            let name = body[g].get("sym_name").and_then(crate::spirv_symbol_text).unwrap_or_default();
            retyped.push((name, ty));
        }
        let mut addrs = Vec::new();
        body.walk(m, &mut |o| addrs.push(o));
        for o in addrs {
            if body[o].name != "spirv.mlir.addressof" {
                continue;
            }
            let Some(name) = body[o].get("variable").and_then(crate::spirv_symbol_text) else { continue };
            if let Some((_, ty)) = retyped.iter().find(|(n, _)| *n == name) {
                let r = body[o].results[0];
                body[r].ty = ty.clone();
            }
        }
    }
    Ok(())
}
