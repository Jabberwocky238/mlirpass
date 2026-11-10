//! `acc` (OpenACC) canonicalization (`OpenACC.cpp`, `OpenACCCG.cpp`).

use alloc::vec;
use alloc::vec::Vec;

use crate::{OpData, OpId, Rewriter};

/// The operand group of the `if` condition of `enter_data` / `exit_data` / `update` /
/// `host_data`.
const IF_COND: usize = 0;

/// `acc.kernel_environment`'s operand groups (data, async, wait device, waits).
const KE_WAIT_DEVNUM: usize = 2;
const KE_WAITS: usize = 3;

/// `acc`'s rewrite patterns.
pub struct AccCanon;

impl AccCanon {
    /// The constant `if` condition of `op`, when it has one.
    fn constant_if(rw: &Rewriter<'_, '_>, op: OpId) -> Option<bool> {
        let b = &*rw.body;
        let segs = b.segments(op, "operandSegmentSizes")?;
        if segs.get(IF_COND) != Some(&1) {
            return None;
        }
        b.int_constant(b[op].operands[0]).map(|v| v != 0)
    }

    /// `if(true)`: the condition goes, its operand group emptied.
    fn drop_if(rw: &mut Rewriter<'_, '_>, op: OpId) {
        rw.modify(op, |body| {
            let mut segs = body.segments(op, "operandSegmentSizes").unwrap_or_default();
            segs[IF_COND] = 0;
            body.erase_operands(op, &[0]);
            body.set_segments(op, "operandSegmentSizes", &segs);
        });
    }

    /// `RemoveConstantIfCondition`: `if(false)` drops the op.
    fn constant_if_condition(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let Some(c) = Self::constant_if(rw, op) else { return false };
        if c {
            Self::drop_if(rw, op);
        } else {
            rw.erase_op(op);
        }
        true
    }
}

#[crate::patterns]
impl AccCanon {
    #[rewrite("acc.enter_data", name = "RemoveConstantIfConditionEnterData")]
    fn remove_constant_if_enter_data(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        Self::constant_if_condition(rw, op)
    }

    #[rewrite("acc.exit_data", name = "RemoveConstantIfConditionExitData")]
    fn remove_constant_if_exit_data(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        Self::constant_if_condition(rw, op)
    }

    #[rewrite("acc.update", name = "RemoveConstantIfConditionUpdate")]
    fn remove_constant_if_update(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        Self::constant_if_condition(rw, op)
    }

    /// `RemoveConstantIfConditionWithRegion`: `if(false)` keeps the body, inlined in place.
    #[rewrite("acc.host_data", name = "RemoveConstantIfConditionWithRegionHostData")]
    fn remove_constant_if_host_data(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let Some(c) = Self::constant_if(rw, op) else { return false };
        if c {
            Self::drop_if(rw, op);
            return true;
        }
        // `replaceOpWithRegion`: the block inlined before the op, its terminator's operands
        // the results.
        let block = rw.body[rw.body[op].regions[0]].blocks[0];
        let term = rw.body.last_op(block).expect("a terminator");
        let parent = rw.body[op].parent.expect("placed");
        rw.inline_block_before(block, parent, Some(op), &[]);
        let results = rw.body[term].operands.to_vec();
        rw.replace_op(op, &results);
        rw.erase_op(term);
        true
    }

    /// `AtomicUpdateOp::canonicalize`: a body yielding its argument does nothing; one yielding
    /// another value first thing is an `acc.atomic.write` of it (the `if` condition kept).
    #[rewrite("acc.atomic.update", name = "AccAtomicUpdate")]
    fn atomic_update(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let b = &*rw.body;
        let Some(&block) = b[op].regions.first().and_then(|r| b[*r].blocks.first()) else { return false };
        let Some(first) = b.first_op(block) else { return false };
        if b[first].name != "acc.yield" {
            return false;
        }
        let (Some(&yielded), Some(&arg)) = (b[first].operands.first(), b[block].args.first()) else { return false };
        if yielded == arg {
            rw.erase_op(op);
            return true;
        }
        let mut operands = vec![b[op].operands[0], yielded];
        operands.extend(b[op].operands.get(1).copied());
        rw.replace_with(op, OpData::build("acc.atomic.write").operands(&operands), &[]);
        true
    }

    /// `RemoveEmptyKernelEnvironment`: an empty one goes, an `acc.wait` kept for its waits.
    #[rewrite("acc.kernel_environment")]
    fn remove_empty_kernel_environment(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let b = &*rw.body;
        let block = b[b[op].regions[0]].blocks[0];
        if b.first_op(block).is_some() {
            return false;
        }
        let waits = b.operand_group(op, KE_WAITS).to_vec();
        let devnum = b.operand_group(op, KE_WAIT_DEVNUM).to_vec();
        if waits.is_empty() && b[op].get("waitOnly").is_none() {
            rw.erase_op(op);
            return true;
        }
        let mut operands: Vec<_> = waits.clone();
        operands.extend(&devnum);
        rw.replace_with(op, OpData::build("acc.wait").operands(&operands).segments(&[waits.len(), 0, devnum.len(), 0]), &[]);
        true
    }
}

impl AccCanon {
    pub fn canonicalization(set: &mut crate::PatternSet) {
        set.add(RemoveConstantIfConditionEnterData).add(RemoveConstantIfConditionExitData).add(RemoveConstantIfConditionUpdate).add(RemoveConstantIfConditionWithRegionHostData).add(RemoveEmptyKernelEnvironment).add(AccAtomicUpdate);
    }
}
