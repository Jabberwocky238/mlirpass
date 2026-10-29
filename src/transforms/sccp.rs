//! `sccp`, as `SCCP.cpp`: the rewrite walks blocks in upstream's order, as constants are
//! materialized in it.

use alloc::collections::BTreeMap;
use alloc::string::String;
use alloc::vec::Vec;

use crate::pass;
use mlirformat::{Attribute, Error, Type};

use crate::dataflow::{Cv, Solver};
use crate::{Body, BlockId, OpId, RegionId, ValueId};

/// The rewrite: constants replace what the analysis proved constant.
struct Rewrite<'s, 'b, 'a> {
    s: &'s mut Solver<'b, 'a>,
    /// `OperationFolder`'s table: per insertion region, (dialect, value, type) ⇒ the constant.
    folder: BTreeMap<RegionId, Vec<(String, Attribute<'a>, Type<'a>, ValueId)>>,
}

impl Rewrite<'_, '_, '_> {
    fn replace(&mut self, v: ValueId, block: BlockId) -> bool {
        let Cv::Known(attr, dialect) = self.s.get(v) else { return false };
        let body = &mut *self.s.body;
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
        self.s.body.replace_all_uses(v, c);
        true
    }

    fn run(&mut self, top: OpId) {
        let mut work: Vec<BlockId> = Vec::new();
        let add = |body: &Body<'_>, work: &mut Vec<BlockId>, op: OpId| {
            for r in &body[op].regions {
                work.extend(body[*r].blocks.iter().rev());
            }
        };
        add(self.s.body, &mut work, top);
        while let Some(block) = work.pop() {
            for op in self.s.body[block].ops.clone() {
                let results = self.s.body[op].results.clone();
                let mut all = !results.is_empty();
                for r in results {
                    all &= self.replace(r, block);
                }
                if all && self.s.body.would_be_trivially_dead(op) {
                    self.s.body.erase(op);
                    continue;
                }
                add(self.s.body, &mut work, op);
            }
            for a in self.s.body[block].args.clone() {
                self.replace(a, block);
            }
        }
    }
}

#[pass("sccp")]
pub fn sccp<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let mut s = Solver::new(body, op);
    s.run();
    Rewrite { s: &mut s, folder: BTreeMap::new() }.run(op);
    Ok(())
}
