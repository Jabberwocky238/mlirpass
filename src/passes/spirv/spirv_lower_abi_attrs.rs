//! `spirv-lower-abi-attrs`.

use crate::{Abi};
use alloc::string::String;
use alloc::vec::Vec;
use mlirformat::Error;
use crate::TargetEnv;
use crate::{Body, OpId};

/// `spirv-lower-abi-attrs`.
#[crate::pass("spirv-lower-abi-attrs", on = "spirv.module")]
pub fn spirv_lower_abi_attrs<'a>(body: &mut Body<'a>, module: OpId) -> Result<(), Error> {
    let env = TargetEnv::find(body, module).ok_or_else(|| Error(String::from("'spirv.module' op missing SPIR-V target env attribute")))?;
    let ops = body.block_ops(body.top_block(module));
    let funcs: Vec<OpId> = ops.iter().copied().filter(|o| body[*o].name == "spirv.func" && body[*o].get("spirv.entry_point_abi").is_some()).collect();
    for o in ops {
        match &*body[o].name {
            "spirv.func" if funcs.contains(&o) => Abi::interface_vars(body, o)?,
            "spirv.ARM.Graph" => Abi::graph_vars(body, o)?,
            _ => {}
        }
    }
    for f in funcs {
        Abi::entry_point(body, module, f, &env)?;
    }
    Ok(())
}
