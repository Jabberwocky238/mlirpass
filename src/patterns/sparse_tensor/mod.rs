use alloc::vec::Vec;

use mlirformat::Attribute;

use crate::{OpId, Rewriter};

pub struct SparseTensorCanon;

#[crate::patterns]
impl SparseTensorCanon {
    #[rewrite("sparse_tensor.iterate")]
    fn remove_unused_lvl_crds(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        const LEVELS: u32 = 64;
        let b = &*rw.body;
        let Some(Attribute::Int { lit, .. }) = b[op].get("crdUsedLvls") else { return false };
        let Ok(used) = lit.parse::<u64>() else { return false };
        let Some(&block) = b[op].regions.first().and_then(|r| b[*r].blocks.first()) else { return false };
        let args = &b[block].args;
        let Some(iter_args) = args.len().checked_sub(1 + used.count_ones() as usize) else { return false };
        let (mut kept, mut dead) = (0u64, Vec::new());
        let mut at = iter_args;
        for lvl in (0..LEVELS).filter(|l| used >> l & 1 == 1) {
            if b[args[at]].uses.is_empty() {
                dead.push(at);
            } else {
                kept |= 1 << lvl;
            }
            at += 1;
        }
        if dead.is_empty() {
            return false;
        }
        rw.modify(op, |body| {
            body[op].set("crdUsedLvls", Attribute::i64(kept as i64));
            body.erase_args(block, &dead);
        });
        true
    }
}

impl SparseTensorCanon {
    pub fn canonicalization(set: &mut crate::PatternSet) {
        set.add(RemoveUnusedLvlCrds);
    }
}
