use crate::{LinalgLoops};
use crate::pass;
use crate::{Body, OpId};

#[pass("convert-linalg-to-loops", on = "func.func")]
pub fn convert_linalg_to_loops<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), mlirformat::Error> {
    LinalgLoops::Scf.lower(body, op);
    Ok(())
}
