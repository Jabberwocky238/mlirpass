use alloc::vec::Vec;

use mlirformat::Error;

use crate::{Body, OpData, OpId, Quiet, Rewriter, pass};

/// Flattens `spirv.mlir.selection` / `spirv.mlir.loop` into their parent's blocks and turns
/// `spirv.Branch` / `spirv.BranchConditional` / `spirv.mlir.merge` into `cf` branches, so
/// `mem2reg` and `lift-cf-to-scf` can work on a plain CFG.
#[pass("convert-spirv-cf-to-cf")]
pub struct ConvertSpirvCfToCf;

#[derive(Clone, Copy, PartialEq, Eq)]
enum Spirv {
    Structured,
    Branch,
    BranchConditional,
    Merge,
}

impl Spirv {
    const TABLE: &[(&str, Spirv)] = &[
        ("spirv.mlir.selection", Spirv::Structured),
        ("spirv.mlir.loop", Spirv::Structured),
        ("spirv.Branch", Spirv::Branch),
        ("spirv.BranchConditional", Spirv::BranchConditional),
        ("spirv.mlir.merge", Spirv::Merge),
    ];

    fn of(b: &Body<'_>, op: OpId) -> Option<Self> {
        Self::TABLE.iter().find(|(n, _)| *n == b[op].name).map(|(_, k)| *k)
    }
}

impl ConvertSpirvCfToCf {
    const BR: &str = "cf.br";
    const COND_BR: &str = "cf.cond_br";

    fn ops(body: &Body<'_>, root: OpId, kind: Spirv) -> Vec<OpId> {
        let mut found = Vec::new();
        body.walk(root, &mut |o| found.push(o));
        found.retain(|&o| Spirv::of(body, o) == Some(kind));
        found
    }

    /// Moves the region of one structured op into the parent region, between the op's block and
    /// what followed the op; its merge branches to what followed.
    fn flatten(rw: &mut Rewriter<'_, '_>, op: OpId) -> Result<(), Error> {
        if !rw.body[op].results.is_empty() {
            return Err(Error(alloc::format!("convert-spirv-cf-to-cf: {} with results", rw.body[op].name)));
        }
        let block = rw.body[op].parent.ok_or_else(|| Error(alloc::string::String::from("convert-spirv-cf-to-cf: a detached op")))?;
        let parent = rw.body[block].parent.ok_or_else(|| Error(alloc::string::String::from("convert-spirv-cf-to-cf: a detached block")))?;
        let rest = rw.split_block(block, op);
        let region = rw.body[op].regions[0];
        let blocks = rw.body[region].blocks.clone();
        let entry = *blocks.first().ok_or_else(|| Error(alloc::string::String::from("convert-spirv-cf-to-cf: an empty region")))?;
        for b in &blocks {
            if let Some(t) = rw.body.last_op(*b).filter(|t| Spirv::of(rw.body, *t) == Some(Spirv::Merge)) {
                rw.set_before(t);
                rw.create(OpData::build(Self::BR).successors(&[rest]), &[]);
                rw.erase_op(t);
            }
        }
        rw.inline_region_before(region, parent, Some(rest));
        rw.set_end(block);
        rw.create(OpData::build(Self::BR).successors(&[entry]), &[]);
        rw.erase_op(op);
        Ok(())
    }

    fn branch(rw: &mut Rewriter<'_, '_>, op: OpId, kind: Spirv) {
        let (operands, successors) = (rw.body[op].operands.clone(), rw.body[op].successors.clone());
        let data = match kind {
            Spirv::BranchConditional => {
                let segments = rw.body[op].get("operandSegmentSizes").cloned();
                let data = OpData::build(Self::COND_BR).operands(&operands).successors(&successors);
                match segments {
                    Some(s) => data.with("operandSegmentSizes", s),
                    None => data.segments(&[1, 0, 0]),
                }
            }
            _ => OpData::build(Self::BR).operands(&operands).successors(&successors),
        };
        rw.set_before(op);
        rw.create(data, &[]);
        rw.erase_op(op);
    }
}

impl crate::Run for ConvertSpirvCfToCf {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let mut quiet = Quiet;
        let mut rw = Rewriter::new(body, &mut quiet);
        while let Some(&s) = Self::ops(rw.body, op, Spirv::Structured).first() {
            Self::flatten(&mut rw, s)?;
        }
        for kind in [Spirv::Branch, Spirv::BranchConditional] {
            for b in Self::ops(rw.body, op, kind) {
                Self::branch(&mut rw, b, kind);
            }
        }
        Ok(())
    }
}
