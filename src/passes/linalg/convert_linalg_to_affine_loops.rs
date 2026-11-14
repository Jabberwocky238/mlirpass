use crate::{LinalgLoops};
use crate::pass;
use crate::{Body, OpId};

#[pass("convert-linalg-to-affine-loops", on = "func.func")]
pub fn convert_linalg_to_affine_loops<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), mlirformat::Error> {
    LinalgLoops::Affine.lower(body, op);
    Ok(())
}
