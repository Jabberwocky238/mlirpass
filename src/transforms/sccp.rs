//! `sccp`, as `SCCP.cpp`: the rewrite walks blocks in upstream's order, as constants are
//! materialized in it.

use alloc::string::String;
use alloc::vec::Vec;

use mlirformat::{Attribute, Error, Type};

use crate::dataflow::{Cv, Solver};
use crate::{Body, BlockId, OpId, Options, Pass, RegionId, ValueId};

/// The rewrite: constants replace what the analysis proved constant.
struct Rewrite<'s, 'b, 'a> {
    s: &'s mut Solver<'b, 'a>,
    /// `OperationFolder`'s table: (insertion region, dialect, value, type) ⇒ the constant.
    folder: Vec<(RegionId, String, Attribute<'a>, Type<'a>, ValueId)>,
}

impl Rewrite<'_, '_, '_> {
    fn replace(&mut self, v: ValueId, block: BlockId) -> bool {
        let Cv::Known(attr, dialect) = self.s.get(v) else { return false };
        let body = &mut *self.s.body;
        let ty = body[v].ty.clone();
        let region = body.insertion_region(block);
        let c = match self.folder.iter().find(|k| k.0 == region && k.1 == dialect && k.2 == attr && k.3 == ty) {
            Some(k) => k.4,
            None => {
                let Some(data) = body.materialize(&dialect, &attr, &ty) else { return false };
                let op = body.create(data, core::slice::from_ref(&ty));
                let entry = body[region].blocks[0];
                body.insert(op, entry, Some(0));
                let r = body[op].results[0];
                self.folder.push((region, dialect, attr, ty, r));
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

pub struct Sccp;

impl TryFrom<&Options<'_>> for Sccp {
    type Error = Error;
    fn try_from(o: &Options<'_>) -> Result<Self, Error> {
        o.only("sccp", &[])?;
        Ok(Self)
    }
}

impl Pass for Sccp {
    fn name(&self) -> &str {
        "sccp"
    }

    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let mut s = Solver::new(body, op);
        s.run();
        Rewrite { s: &mut s, folder: Vec::new() }.run(op);
        Ok(())
    }
}
