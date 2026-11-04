//! `spirv-rewrite-inserts`.

use crate::{insertion_chain};
use alloc::vec::Vec;
use mlirformat::Error;
use crate::{Body, OpData, OpId, ValueId};

/// `spirv-rewrite-inserts`: a chain of inserts filling every element as one
/// `spirv.CompositeConstruct`.
#[crate::pass("spirv-rewrite-inserts", on = "spirv.module")]
pub fn spirv_rewrite_inserts<'a>(body: &mut Body<'a>, module: OpId) -> Result<(), Error> {
    let mut chains = Vec::new();
    body.walk_post(module, &mut |o| {
        if body[o].name == "spirv.CompositeInsert"
            && let Some(c) = insertion_chain(body, o)
        {
            chains.push(c);
        }
    });
    for chain in chains {
        let last = *chain.last().expect("a chain");
        let parts: Vec<ValueId> = chain.iter().map(|o| body[*o].operands[0]).collect();
        let ty = body[body[last].results[0]].ty.clone();
        let mut data = OpData::build("spirv.CompositeConstruct").operands(&parts);
        data.loc = body[last].loc.clone();
        let c = body.create(data, &[ty]);
        body.insert_before(c, last);
        let (from, to) = (body[last].results[0], body[c].results[0]);
        body.replace_all_uses(from, to);
        for o in chain.into_iter().rev() {
            if body[body[o].results[0]].uses.is_empty() {
                body.erase(o);
            }
        }
    }
    Ok(())
}
