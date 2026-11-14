use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{Error, Op};

use crate::{A, Apple9Kernel, Apple9Op, BlockId, Body, Kernels, OpData, OpId, Quiet, Rewriter, WithAttrs, pass};

struct Control<'r, 'a> {
    rw: Rewriter<'r, 'a>,
    labels: u32,
}

impl Control<'_, '_> {
    fn put(&mut self, before: OpId, inst: Apple9Op, attrs: Vec<(&str, A)>) {
        self.rw.set_before(before);
        self.rw.create(OpData::build(inst.name()).with_attrs(attrs), &[]);
    }

    fn inline(&mut self, b: BlockId, before: OpId) {
        let parent = self.rw.body[before].parent.expect("placed");
        let ends: Vec<OpId> = self.rw.body.ops(b).filter(|o| matches!(&*self.rw.body[*o].name, "scf.yield" | "scf.condition")).collect();
        self.rw.inline_block_before(b, parent, Some(before), &[]);
        for e in ends {
            self.rw.erase_op(e);
        }
    }

    fn label(&mut self) -> u32 {
        self.labels += 1;
        self.labels
    }

    fn lower(&mut self, op: OpId) -> Result<(), Error> {
        let regions = self.rw.body[op].regions.to_vec();
        let entry = |rw: &Rewriter<'_, '_>, i: usize| regions.get(i).and_then(|r| rw.body[*r].blocks.first().copied());
        let invert = || vec![("invert", A::Bool(true))];
        match &*self.rw.body[op].name {
            "scf.if" => {
                self.put(op, Apple9Op::Push, invert());
                if let Some(then) = entry(&self.rw, 0) {
                    self.inline(then, op);
                }
                if let Some(other) = entry(&self.rw, 1).filter(|b| self.rw.body.ops(*b).any(|o| self.rw.body[o].name != "scf.yield")) {
                    self.put(op, Apple9Op::Else, Vec::new());
                    self.inline(other, op);
                }
                self.put(op, Apple9Op::Pop, Vec::new());
            }
            "scf.while" => {
                let (Some(before), Some(after)) = (entry(&self.rw, 0), entry(&self.rw, 1)) else {
                    return Err(Error("scf.while without its regions".into()));
                };
                let (top, exit) = (self.label(), self.label());
                self.put(op, Apple9Op::LoopPush, Vec::new());
                self.put(op, Apple9Op::Label, vec![("id", A::from(top))]);
                self.inline(before, op);
                self.put(op, Apple9Op::LoopUpdate, invert());
                self.put(op, Apple9Op::JmpNone, vec![("to", A::from(exit))]);
                self.inline(after, op);
                self.put(op, Apple9Op::JmpAny, vec![("to", A::from(top))]);
                self.put(op, Apple9Op::Label, vec![("id", A::from(exit))]);
                self.put(op, Apple9Op::LoopPop, Vec::new());
            }
            n => return Err(Error(alloc::format!("{n}: not structured control flow apple9-control lowers"))),
        }
        self.rw.erase_op(op);
        Ok(())
    }
}

#[pass("apple9-control", on = "builtin.module")]
pub fn apple9_control<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    for k in Kernels::all(body, op, Apple9Kernel::NAME) {
        let mut structured = Vec::new();
        body.walk(k, &mut |o| {
            if matches!(&*body[o].name, "scf.if" | "scf.while") {
                structured.push(o);
            }
        });
        let mut quiet = Quiet;
        let mut c = Control { rw: Rewriter::new(body, &mut quiet), labels: 0 };
        for s in structured {
            c.lower(s)?;
        }
    }
    Ok(())
}
