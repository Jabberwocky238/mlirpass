use crate::{OpData, OpId, Rewriter};

pub struct OmpCanon;

#[crate::patterns]
impl OmpCanon {
    #[rewrite("omp.atomic.update", name = "OmpAtomicUpdate")]
    fn atomic_update(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let b = &*rw.body;
        let Some(&block) = b[op].regions.first().and_then(|r| b[*r].blocks.first()) else { return false };
        let Some(first) = b.first_op(block) else { return false };
        if b[first].name != "omp.yield" {
            return false;
        }
        let (Some(&yielded), Some(&arg)) = (b[first].operands.first(), b[block].args.first()) else { return false };
        if yielded == arg {
            rw.erase_op(op);
            return true;
        }
        let mut data = OpData::build("omp.atomic.write").operands(&[b[op].operands[0], yielded]);
        for name in ["hint", "memory_order"] {
            if let Some(v) = b[op].get(name).cloned() {
                data.set(name, v);
            }
        }
        rw.replace_with(op, data, &[]);
        true
    }
}

impl OmpCanon {
    pub fn canonicalization(set: &mut crate::PatternSet) {
        set.add(OmpAtomicUpdate);
    }
}
