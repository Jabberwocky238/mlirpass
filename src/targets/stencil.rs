use alloc::collections::BTreeMap;
use alloc::string::String;
use alloc::vec::Vec;

use mlirformat::Error;

use crate::{Body, Ctx, OpId, PassManager};

/// Where a stencil's code takes a value it only learns when it is copied.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum HoleKind {
    /// Eight bytes, an absolute value (a constant, an address).
    Abs64,
    /// Four bytes, a signed displacement written as is (a frame slot's offset).
    Disp32,
    /// Four bytes, a jump: the target's position minus the end of the four bytes.
    Rel32,
}

#[derive(Clone, Debug, PartialEq, Eq)]
pub struct Hole {
    pub at: usize,
    pub kind: HoleKind,
    /// The symbol the template named for it (`@hole.0`, `@slot.1`, `@jump.0`, a runtime function).
    pub name: String,
}

/// Machine code compiled once from one template function, to be copied and patched.
#[derive(Clone, Debug, PartialEq, Eq)]
pub struct Stencil {
    pub name: String,
    pub code: Vec<u8>,
    pub holes: Vec<Hole>,
}

impl Stencil {
    /// Appends the code to `out` and returns where it starts; its holes are at `start + hole.at`.
    pub fn stamp(&self, out: &mut Vec<u8>) -> usize {
        let start = out.len();
        out.extend_from_slice(&self.code);
        start
    }

    pub fn abs64(out: &mut [u8], at: usize, value: u64) {
        out[at..at + 8].copy_from_slice(&value.to_le_bytes());
    }

    pub fn disp32(out: &mut [u8], at: usize, value: i32) {
        out[at..at + 4].copy_from_slice(&value.to_le_bytes());
    }

    pub fn rel32(out: &mut [u8], at: usize, target: usize) {
        let rel = target as i64 - (at as i64 + 4);
        Self::disp32(out, at, i32::try_from(rel).unwrap_or(i32::MAX));
    }
}

/// A backend that emits each template function as a stencil.
pub trait StencilEmit {
    fn stencils(&self, body: &Body<'_>, root: OpId) -> Result<Vec<Stencil>, Error>;
}

/// The fast path: templates go through the pipeline and the backend once; afterwards code is only
/// copied and patched.
pub struct Stencils {
    all: Vec<Stencil>,
    by_name: BTreeMap<String, usize>,
}

impl Stencils {
    pub fn compile(ctx: Ctx<'_>, templates: &str, pipeline: &PassManager, emit: &dyn StencilEmit) -> Result<Self, Error> {
        let mut body = Body::parse(ctx, templates)?;
        let root = body.root;
        pipeline.run_on(&mut body, root, &moremath::ThreadSingle)?;
        let all = emit.stencils(&body, root)?;
        let by_name = all.iter().enumerate().map(|(i, s)| (s.name.clone(), i)).collect();
        Ok(Self { all, by_name })
    }

    pub fn get(&self, name: &str) -> Option<&Stencil> {
        self.by_name.get(name).map(|&i| &self.all[i])
    }

    pub fn all(&self) -> &[Stencil] {
        &self.all
    }
}
