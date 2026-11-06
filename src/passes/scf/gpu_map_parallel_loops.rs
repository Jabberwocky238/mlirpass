//! `gpu-map-parallel-loops`.

use alloc::string::String;
use alloc::vec::Vec;
use mlirformat::Error;
use crate::{Body, OpId};

/// `gpu-map-parallel-loops`.
#[crate::pass("gpu-map-parallel-loops")]
pub struct GpuMapParallelLoops {
    #[opt("mapping-policy", default = String::from("outermost-first"))]
    policy: String,
}

impl crate::Run for GpuMapParallelLoops {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let innermost = match &*self.policy.trim().to_lowercase() {
            "innermost-first" => true,
            "outermost-first" => false,
            _ => return Err(Error(String::from("Invalid mapping policy specified."))),
        };
        let mut loops = Vec::new();
        for r in body[op].regions.clone() {
            for b in body[r].blocks.clone() {
                for o in body.block_ops(b) {
                    body.walk_post(o, &mut |x| {
                        if body[x].name == "scf.parallel" {
                            loops.push(x);
                        }
                    });
                }
            }
        }
        for l in loops {
            body.map_parallel(l, 0, innermost);
        }
        Ok(())
    }
}
