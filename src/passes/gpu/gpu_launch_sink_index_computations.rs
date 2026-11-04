//! `gpu-launch-sink-index-computations`.

use alloc::vec::Vec;
use mlirformat::Error;
use crate::{Body, OpId};

/// `gpu-launch-sink-index-computations`.
#[crate::pass("gpu-launch-sink-index-computations")]
pub fn gpu_launch_sink_index_computations<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let mut launches = Vec::new();
    body.walk_post(op, &mut |o| {
        if body[o].name == "gpu.launch" {
            launches.push(o);
        }
    });
    for l in launches {
        body.sink_into_launch(l);
    }
    Ok(())
}
