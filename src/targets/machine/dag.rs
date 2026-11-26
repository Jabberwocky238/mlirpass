//! The SelectionDAG patterns `scripts/isel.py` generates (`-gen-dag-isel`'s, types inferred):
//! what a tree of nodes looks like and the instructions it becomes.

use super::{Mvt, Sd};

/// A pattern's source: nodes, register-class leaves, complex patterns (addresses), physical
/// registers, integer constants, block targets. `name` is the operand the result refers to.
#[derive(Clone, Copy, Debug)]
pub enum DagSrc<'t, C, R, P, K> {
    Node { op: Sd, vt: Option<Mvt>, kids: &'t [DagSrc<'t, C, R, P, K>], preds: &'t [P], name: Option<u8> },
    Class { class: C, vt: Option<Mvt>, preds: &'t [P], name: Option<u8> },
    /// A complex pattern (an address, a shifted register): the names of what it gives.
    Complex { pat: K, names: &'t [u8] },
    Phys(R),
    Int(i64),
    Bb(u8),
    Any { name: Option<u8> },
}

/// A pattern's result: instructions over the source's named operands, constants, physical
/// registers, and the target-independent nodes (sub-registers, `IMPLICIT_DEF`, `COPY`, transforms).
#[derive(Clone, Copy, Debug)]
pub enum DagDst<'t, O, R, S, X> {
    Inst { op: O, vt: Option<Mvt>, kids: &'t [DagDst<'t, O, R, S, X>] },
    Ref(u8),
    Int(i64),
    Phys(R),
    Extract(&'t DagDst<'t, O, R, S, X>, S),
    Insert(&'t DagDst<'t, O, R, S, X>, &'t DagDst<'t, O, R, S, X>, S),
    SubregToReg(&'t DagDst<'t, O, R, S, X>, S),
    ImplicitDef(Option<Mvt>),
    Copy(&'t DagDst<'t, O, R, S, X>),
    XForm(X, &'t DagDst<'t, O, R, S, X>),
}

#[derive(Clone, Copy, Debug)]
pub struct DagPattern<'t, O, C, R, P, K, S, X> {
    pub complexity: u16,
    pub src: DagSrc<'t, C, R, P, K>,
    pub dst: DagDst<'t, O, R, S, X>,
}

impl<'t, C, R, P, K> DagSrc<'t, C, R, P, K> {
    /// The node a pattern is rooted at.
    pub fn root(&self) -> Option<Sd> {
        match self {
            DagSrc::Node { op, .. } => Some(*op),
            _ => None,
        }
    }
}
