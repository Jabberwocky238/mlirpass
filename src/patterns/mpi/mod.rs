//! `mpi` canonicalization (`MPIOps.cpp`): `comm_rank` / `comm_size` of the world
//! communicator from the DLTI entries, and the static source of a `memref.cast` buffer.

use mlirformat::{arith, Attribute, Dim, Type};

use crate::{Body, OpId, Rewriter, ValueId};

/// The DLTI keys `FoldToDLTIConst` reads.
const WORLD_RANK: &str = "MPI:comm_world_rank";
const WORLD_SIZE: &str = "MPI:comm_world_size";

/// `mpi`'s rewrite patterns.
pub struct MpiCanon;

impl MpiCanon {
    /// `dlti::query(op, {key})`: the integer `key` maps to in the closest `#dlti.map` of an
    /// enclosing op.
    fn dlti(b: &Body<'_>, op: OpId, key: &str) -> Option<i64> {
        let quoted = alloc::format!("\"{key}\"");
        let mut at = b.parent_op(op);
        while let Some(p) = at {
            for a in b[p].all_attrs() {
                let Some(Attribute::Extended { ext, .. }) = &a.value else { continue };
                if ext.name != "dlti.map" {
                    continue;
                }
                let body = ext.body.as_deref().unwrap_or("").trim_start_matches('<').trim_end_matches('>');
                for entry in body.split(',') {
                    let Some((k, v)) = entry.split_once('=') else { continue };
                    if k.trim() == quoted {
                        return v.split(':').next()?.trim().parse().ok();
                    }
                }
            }
            at = b.parent_op(p);
        }
        None
    }

    /// `FoldToDLTIConst`: of the world communicator, an `i32` constant.
    fn fold_to_dlti(rw: &mut Rewriter<'_, '_>, op: OpId, key: &str) -> bool {
        let b = &*rw.body;
        if b.def_named(b[op].operands[0], "mpi.comm_world").is_none() || b[op].results.len() != 1 {
            return false;
        }
        let Some(v) = Self::dlti(b, op, key) else { return false };
        let i32 = Type::int(32);
        rw.set_before(op);
        let c = rw.emit(&arith::Constant::new(Attribute::of_int(v.into(), i32.clone()), i32));
        let r = rw.body[c].results[0];
        rw.replace_op(op, &[r]);
        true
    }

    /// `FoldCast`: a dynamically shaped buffer that is a `memref.cast` of a static one.
    fn fold_cast(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let b = &*rw.body;
        let static_shape = |v: ValueId| b[v].ty.dims().is_some_and(|d| !d.contains(&Dim::DYNAMIC));
        let buf = b[op].operands[0];
        if static_shape(buf) {
            return false;
        }
        let Some(cast) = b.def_named(buf, "memref.cast") else { return false };
        let src = b[cast].operands[0];
        if !static_shape(src) {
            return false;
        }
        rw.modify(op, |body| body.set_operand(op, 0, src));
        true
    }
}

#[crate::patterns]
impl MpiCanon {
    #[rewrite("mpi.comm_rank")]
    fn fold_rank(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        Self::fold_to_dlti(rw, op, WORLD_RANK)
    }

    #[rewrite("mpi.comm_size")]
    fn fold_size(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        Self::fold_to_dlti(rw, op, WORLD_SIZE)
    }

    #[rewrite("mpi.send", name = "FoldCastSend")]
    fn fold_cast_send(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        Self::fold_cast(rw, op)
    }

    #[rewrite("mpi.recv", name = "FoldCastRecv")]
    fn fold_cast_recv(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        Self::fold_cast(rw, op)
    }

    #[rewrite("mpi.isend", name = "FoldCastISend")]
    fn fold_cast_isend(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        Self::fold_cast(rw, op)
    }

    #[rewrite("mpi.irecv", name = "FoldCastIRecv")]
    fn fold_cast_irecv(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        Self::fold_cast(rw, op)
    }
}

impl MpiCanon {
    pub fn canonicalization(set: &mut crate::PatternSet) {
        set.add(FoldCastSend).add(FoldCastRecv).add(FoldCastISend).add(FoldCastIRecv).add(FoldRank).add(FoldSize);
    }
}
