//! `sccp`, as `SCCP.cpp`: the rewrite walks blocks in upstream's order, as constants are
//! materialized in it.

use alloc::collections::BTreeMap;
use alloc::string::String;
use alloc::vec::Vec;

use crate::pass;
use mlirformat::{Attribute, Error, Type};

use super::dataflow::{Cv, Solver};
use crate::{Body, BlockId, IdVec, OpId, RegionId, Run, ValueId};

/// The rewrite: constants replace what the analysis proved constant.
struct Rewrite<'s, 'b, 'a> {
    body: &'b mut Body<'a>,
    lat: &'s IdVec<ValueId, Cv<'a>>,
    /// `OperationFolder`'s table: per insertion region, (dialect, value, type) ⇒ the constant.
    folder: BTreeMap<RegionId, Vec<(String, Attribute<'a>, Type<'a>, ValueId)>>,
}

impl Rewrite<'_, '_, '_> {
    fn replace(&mut self, v: ValueId, block: BlockId) -> bool {
        let Cv::Known(attr, dialect) = self.lat.get(v).clone() else { return false };
        let body = &mut *self.body;
        let ty = body[v].ty.clone();
        let region = body.insertion_region(block);
        let table = self.folder.entry(region).or_default();
        let c = match table.iter().find(|k| k.0 == dialect && k.1 == attr && k.2 == ty) {
            Some(k) => k.3,
            None => {
                let Some(data) = body.materialize(&dialect, &attr, &ty) else { return false };
                let made: String = data.name.split_once('.').map_or(&*data.name, |(ns, _)| ns).into();
                // `tryGetOrCreateConstant`: a constant one dialect materializes as another's
                // (`math` ⇒ `arith.constant`) is that dialect's too: one it already has wins.
                let existing = (made != dialect).then(|| table.iter().find(|k| k.0 == made && k.1 == attr && k.2 == ty).map(|k| k.3)).flatten();
                let r = match existing {
                    Some(r) => r,
                    None => {
                        let op = body.create(data, core::slice::from_ref(&ty));
                        let entry = body[region].blocks[0];
                        body.insert(op, entry, Some(0));
                        let r = body[op].results[0];
                        if made != dialect {
                            table.push((made, attr.clone(), ty.clone(), r));
                        }
                        r
                    }
                };
                table.push((dialect, attr, ty, r));
                r
            }
        };
        self.body.replace_all_uses(v, c);
        true
    }

    /// The blocks of `top`'s regions and below, as upstream walks them (a stack), past the ops
    /// in `done` (rewritten already, each on its own).
    fn run(&mut self, top: OpId, done: &[OpId]) {
        let mut work: Vec<BlockId> = Vec::new();
        Self::add(self.body, &mut work, top);
        self.drain(work, done);
    }

    /// `op` itself, as the walk meets it in its block, then the blocks under it: what [`run`](Self::run) does for one op of
    /// the top's block.
    fn run_op(&mut self, op: OpId) {
        let Some(block) = self.body[op].parent else { return };
        if self.op(op, block) {
            let mut work = Vec::new();
            Self::add(self.body, &mut work, op);
            self.drain(work, &[]);
        }
    }

    fn add(body: &Body<'_>, work: &mut Vec<BlockId>, op: OpId) {
        for r in &body[op].regions {
            work.extend(body[*r].blocks.iter().rev());
        }
    }

    fn drain(&mut self, mut work: Vec<BlockId>, done: &[OpId]) {
        while let Some(block) = work.pop() {
            for op in self.body[block].ops.clone() {
                if done.binary_search(&op).is_ok() {
                    continue;
                }
                if self.op(op, block) {
                    Self::add(self.body, &mut work, op);
                }
            }
            for a in self.body[block].args.clone() {
                self.replace(a, block);
            }
        }
    }

    /// `op`'s results replaced where constant, `op` erased when that leaves it dead; whether it
    /// is still there (its blocks to walk).
    fn op(&mut self, op: OpId, block: BlockId) -> bool {
        let results = self.body[op].results.clone();
        let mut all = !results.is_empty();
        for r in results {
            all &= self.replace(r, block);
        }
        if all && self.body.would_be_trivially_dead(op) {
            self.body.erase(op);
            return false;
        }
        true
    }
}

/// `sccp`.
#[pass("sccp")]
pub struct Sccp;

impl Run for Sccp {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        self.run_in(body, op, &crate::PassManager::one_thread())
    }

    /// The analysis over the whole of `op`; the rewrite, which needs only what it found, op by op of
    /// `op`'s block, each function on its own thread ([`Body::for_each_child`]): a function's
    /// constants go into its own region.
    fn run_in<'a>(&self, body: &mut Body<'a>, op: OpId, exec: &crate::Threads) -> Result<(), Error> {
        let lat = Solver::solve_in(body, op, exec);
        let lat = &lat;
        let mut done = body.for_each_child(op, exec, &|b: &mut Body<'a>, c| Rewrite { body: b, lat, folder: BTreeMap::new() }.run_op(c));
        done.sort_unstable();
        Rewrite { body, lat, folder: BTreeMap::new() }.run(op, &done);
        Ok(())
    }
}
