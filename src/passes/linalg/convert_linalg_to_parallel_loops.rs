use crate::{LinalgLoops};
use crate::pass;
use crate::{Body, OpId};

#[pass("convert-linalg-to-parallel-loops", on = "func.func")]
pub fn convert_linalg_to_parallel_loops<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), mlirformat::Error> {
    LinalgLoops::Parallel.lower(body, op);
    Ok(())
}
