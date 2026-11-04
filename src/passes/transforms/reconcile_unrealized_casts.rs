//! `reconcile-unrealized-casts`, as `ReconcileUnrealizedCasts.cpp`: the casts dialect conversion left
//! behind, folded away where they cancel ([`Body::reconcile_casts`]).

use alloc::vec::Vec;

use mlirformat::Error;

use crate::{pass, Body, OpId};

/// `reconcile-unrealized-casts`.
#[pass("reconcile-unrealized-casts")]
pub fn reconcile_unrealized_casts<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let casts: Vec<OpId> = body.ops_in(op).into_iter().filter(|o| body[*o].name == "builtin.unrealized_conversion_cast").collect();
    body.reconcile_casts(&casts);
    Ok(())
}
