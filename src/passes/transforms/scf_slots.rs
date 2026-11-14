use alloc::collections::BTreeMap;
use alloc::vec::Vec;

use super::memslot::{MemorySlot, Promotable};
use crate::{BlockId, Body, OpData, OpId, RegionId, Rewriter, ValueId};

pub struct ScfSlots;

#[derive(Clone, Copy, PartialEq, Eq)]
enum RegionOp {
    ExecuteRegion,
    For,
    Forall,
    If,
    IndexSwitch,
    Parallel,
    Reduce,
    While,
}

impl RegionOp {
    const TABLE: &[(&str, RegionOp)] = &[
        ("scf.execute_region", RegionOp::ExecuteRegion),
        ("scf.for", RegionOp::For),
        ("scf.forall", RegionOp::Forall),
        ("scf.if", RegionOp::If),
        ("scf.index_switch", RegionOp::IndexSwitch),
        ("scf.parallel", RegionOp::Parallel),
        ("scf.reduce", RegionOp::Reduce),
        ("scf.while", RegionOp::While),
    ];

    fn of(b: &Body<'_>, op: OpId) -> Option<Self> {
        Self::TABLE.iter().find(|(n, _)| *n == b[op].name).map(|(_, k)| *k)
    }

    fn parallel(self) -> bool {
        matches!(self, RegionOp::Forall | RegionOp::Parallel | RegionOp::Reduce)
    }
}

impl ScfSlots {
    fn update_terminator(b: &mut Body<'_>, block: BlockId, default: ValueId, at_end: &BTreeMap<BlockId, Option<ValueId>>) {
        let v = at_end.get(&block).copied().flatten().unwrap_or(default);
        let t = b.last_op(block).expect("a terminator");
        let mut ops = b[t].operands.to_vec();
        ops.push(v);
        b.set_operands(t, ops);
    }

    fn add_result<'a>(rw: &mut Rewriter<'_, 'a>, op: OpId, slot: &MemorySlot<'a>) -> ValueId {
        let new = rw.with_extra_results(op, core::slice::from_ref(&slot.elem));
        *rw.body[new].results.last().expect("the added result")
    }

    fn add_arg<'a>(b: &mut Body<'a>, region: RegionId, slot: &MemorySlot<'a>) -> ValueId {
        let entry = b[region].blocks[0];
        let arg = b.add_arg(entry, slot.elem.clone());
        b[arg].loc = b[slot.ptr].loc.clone();
        arg
    }
}

impl Promotable for ScfSlots {
    fn dialect(&self) -> &str {
        "scf"
    }

    fn is_region_op(&self, b: &Body<'_>, op: OpId) -> bool {
        RegionOp::of(b, op).is_some()
    }

    fn region_promotable<'a>(&self, b: &Body<'a>, op: OpId, _: &MemorySlot<'a>, _: RegionId, stores: bool) -> Option<bool> {
        let k = RegionOp::of(b, op)?;
        Some(!(k.parallel() && stores))
    }

    fn setup_promotion<'a>(&self, rw: &mut Rewriter<'_, 'a>, op: OpId, slot: &MemorySlot<'a>, reaching: ValueId, stores: bool) -> Vec<(RegionId, ValueId)> {
        let Some(k) = RegionOp::of(rw.body, op) else { return Vec::new() };
        let regions = rw.body[op].regions.to_vec();
        match k {
            RegionOp::For | RegionOp::While if stores => {
                let mut ops = rw.body[op].operands.to_vec();
                ops.push(reaching);
                rw.body.set_operands(op, ops);
                regions.iter().map(|r| (*r, Self::add_arg(rw.body, *r, slot))).collect()
            }
            _ => regions.iter().map(|r| (*r, reaching)).collect(),
        }
    }

    fn finalize_promotion<'a>(&self, rw: &mut Rewriter<'_, 'a>, op: OpId, slot: &MemorySlot<'a>, reaching: ValueId, stores: bool, at_end: &BTreeMap<BlockId, Option<ValueId>>) -> ValueId {
        let Some(k) = RegionOp::of(rw.body, op) else { return reaching };
        if !stores || k.parallel() {
            return reaching;
        }
        let regions = rw.body[op].regions.to_vec();
        match k {
            RegionOp::ExecuteRegion => {
                for block in rw.body[regions[0]].blocks.clone() {
                    if rw.body.last_op(block).is_some_and(|t| rw.body[t].name == "scf.yield") {
                        Self::update_terminator(rw.body, block, reaching, at_end);
                    }
                }
            }
            RegionOp::For | RegionOp::IndexSwitch => {
                for r in &regions {
                    let last = *rw.body[*r].blocks.last().expect("a block");
                    Self::update_terminator(rw.body, last, reaching, at_end);
                }
            }
            RegionOp::If => {
                let then = *rw.body[regions[0]].blocks.last().expect("a then block");
                Self::update_terminator(rw.body, then, reaching, at_end);
                if rw.body[regions[1]].blocks.len() == 1 {
                    let last = rw.body[regions[1]].blocks[0];
                    Self::update_terminator(rw.body, last, reaching, at_end);
                } else {
                    let ip = rw.ip;
                    let block = rw.body.add_block(regions[1], &[]);
                    rw.set_start(block);
                    let loc = rw.body[op].loc.clone();
                    rw.create(OpData { loc, ..OpData::build("scf.yield").operands(&[reaching]) }, &[]);
                    rw.ip = ip;
                }
            }
            RegionOp::While => {
                for r in &regions {
                    let entry = rw.body[*r].blocks[0];
                    let arg = *rw.body[entry].args.last().expect("the slot argument");
                    let last = *rw.body[*r].blocks.last().expect("a block");
                    Self::update_terminator(rw.body, last, arg, at_end);
                }
            }
            RegionOp::Forall | RegionOp::Parallel | RegionOp::Reduce => return reaching,
        }
        Self::add_result(rw, op, slot)
    }
}
