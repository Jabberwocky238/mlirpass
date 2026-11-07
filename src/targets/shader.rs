//! What every GPU target shares about a shader: its stage, and the kernels (one per shader) a lowering made.

use alloc::vec::Vec;

use serde::{Deserialize, Serialize};

use crate::{Body, OpId};

/// ⭐ A shader's stage (SPIR-V's execution models `Vertex`, `Fragment`, `GLCompute`).
#[derive(Clone, Copy, Debug, PartialEq, Eq, Serialize, Deserialize)]
#[serde(rename_all = "lowercase")]
pub enum ShaderStage {
    Vertex,
    Fragment,
    Compute,
}

/// ⭐ The kernels of a target under an op.
pub struct Kernels;

impl Kernels {
    /// The ops named `name` (a target's kernel op) under `op`, in order.
    pub fn all(body: &Body<'_>, op: OpId, name: &str) -> Vec<OpId> {
        let mut out = Vec::new();
        body.walk(op, &mut |o| {
            if body[o].name == name {
                out.push(o);
            }
        });
        out
    }
}
