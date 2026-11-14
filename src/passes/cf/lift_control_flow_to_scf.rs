use alloc::vec::Vec;

use mlirformat::Error;

use crate::{pass, transform_cfg_to_scf, Body, ControlFlowToScf, OpId};

#[pass("lift-cf-to-scf")]
pub fn lift_cf_to_scf<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let mut funcs = Vec::new();
    body.walk_post(op, &mut |o| {
        if body[o].name == "func.func" && body[o].regions.first().is_some_and(|r| !body[*r].blocks.is_empty()) {
            funcs.push(o);
        }
    });
    let mut interface = ControlFlowToScf;
    for f in funcs {
        let mut ops = Vec::new();
        body.walk_post(f, &mut |o| ops.push(o));
        for o in ops {
            if body[o].parent.is_none() && o != f {
                continue;
            }
            for r in body[o].regions.clone() {
                transform_cfg_to_scf(body, r, &mut interface)?;
            }
        }
    }
    Ok(())
}
