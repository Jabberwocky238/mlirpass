//! ⭐ Register allocation for every GPU target: a linear scan over one block in SSA form, its ops' regions in it (structured
//! control flow: [`LinearScan::run_with`]).
//!
//! Each value lives in one register file (Intel: the GRF; AMD: SGPRs or VGPRs; Apple: the 16-bit halves) and takes
//! `size` consecutive registers starting at a multiple of `align`. Going down the block: an op's results take the
//! lowest free run; a value [`LinearScan::fixed`] has its register given; a group (a message's payload, its values
//! defined in order) is one run, placed with its first value. An operand's registers are free once its last reader
//! read it, before that reader's results are placed unless the target keeps them apart (a send's response may not
//! overlap its payload). The vendor says how its ops and values are ([`RegTarget`]) and rewrites its instructions
//! with the registers after.


use alloc::collections::{BTreeMap, BTreeSet};
use alloc::vec::Vec;
use core::ops::Range;

use mlirformat::Error;

use crate::{BlockId, Body, Def, OpId, ValueId};

/// ⭐ What a vendor says about its kernels' ops and values.
pub trait RegTarget {
    /// Ops whose results are where the thread got them: the first register of the first result (a payload).
    fn preset(&self, body: &Body<'_>, op: OpId) -> Result<Option<u32>, Error>;
    /// Whether `op`'s results may take the registers its operands free (no: they must not overlap).
    fn reuses_sources(&self, body: &Body<'_>, op: OpId) -> bool;
    /// Whether `op` is a loop: what is read in it is read again each time around (its own operands too).
    fn is_loop(&self, _body: &Body<'_>, _op: OpId) -> bool {
        false
    }
    /// The register file of `v`.
    fn file(&self, body: &Body<'_>, v: ValueId) -> Result<usize, Error>;
    /// How many registers `v` takes, and the alignment of the first.
    fn size(&self, body: &Body<'_>, v: ValueId) -> Result<(u32, u32), Error>;
}

/// A group: values that take one consecutive run, by the first of them.
pub type Groups = BTreeMap<ValueId, Vec<ValueId>>;

/// ⭐ One allocation: the registers each file may use, the values whose registers are given, the groups.
pub struct LinearScan {
    pub files: Vec<Range<u32>>,
    pub fixed: BTreeMap<ValueId, u32>,
    pub groups: Groups,
}

/// Where things happen in a kernel laid out as one sequence: each op where it starts, a region op (a loop, a branch)
/// also where it ends (after everything in it). Values' lifetimes are in these positions.
struct Sequence {
    events: Vec<Event>,
    start: BTreeMap<OpId, usize>,
    end: BTreeMap<OpId, usize>,
}

#[derive(Clone, Copy)]
enum Event {
    Start(OpId),
    End(OpId),
}

impl Sequence {
    fn of(body: &Body<'_>, block: BlockId) -> Sequence {
        let mut s = Sequence { events: Vec::new(), start: BTreeMap::new(), end: BTreeMap::new() };
        s.block(body, block);
        s
    }

    fn block(&mut self, body: &Body<'_>, block: BlockId) {
        for op in body.ops(block) {
            self.start.insert(op, self.events.len());
            self.events.push(Event::Start(op));
            if body[op].regions.is_empty() {
                self.end.insert(op, self.events.len() - 1);
                continue;
            }
            for &r in &body[op].regions {
                for &b in &body[r].blocks {
                    self.block(body, b);
                }
            }
            self.end.insert(op, self.events.len());
            self.events.push(Event::End(op));
        }
    }
}

impl LinearScan {
    /// ⭐ A register (the first of its run) for every value defined in `block`.
    pub fn run(&self, target: &impl RegTarget, body: &Body<'_>, block: BlockId) -> Result<BTreeMap<ValueId, u32>, Error> {
        self.run_with(target, body, block, &[])
    }

    /// [`run`](Self::run) of a block whose ops may hold regions (structured control flow), each of `webs` one register
    /// for all its values (a loop-carried value: its initial copy, the body's argument, what the body yields, the loop's
    /// result). Inside a region op the sequence goes on into its regions; a value read inside a loop
    /// ([`RegTarget::is_loop`]) but defined outside it, or read by the loop op itself, lives until the loop's end; a
    /// region op's results are defined at its end, its regions' arguments at its start.
    pub fn run_with(&self, target: &impl RegTarget, body: &Body<'_>, block: BlockId, webs: &[Vec<ValueId>]) -> Result<BTreeMap<ValueId, u32>, Error> {
        let seq = Sequence::of(body, block);
        let web: BTreeMap<ValueId, usize> = webs.iter().enumerate().flat_map(|(i, w)| w.iter().map(move |v| (*v, i))).collect();
        // where each value is last read (`None`: never), a web's the last of its members'
        let mut last: BTreeMap<ValueId, usize> = BTreeMap::new();
        for (&op, &at) in &seq.start {
            for &v in &body[op].operands {
                let mut p = if target.is_loop(body, op) { seq.end[&op] } else { at };
                let mut up = body.parent_op(op);
                while let Some(a) = up {
                    if !seq.start.contains_key(&a) {
                        break;
                    }
                    if target.is_loop(body, a) && !Self::inside(body, v, a) {
                        p = p.max(seq.end[&a]);
                    }
                    up = body.parent_op(a);
                }
                let e = last.entry(v).or_insert(p);
                *e = (*e).max(p);
            }
        }
        for w in webs {
            if let Some(m) = w.iter().filter_map(|v| last.get(v)).max().copied() {
                for v in w {
                    last.insert(*v, m);
                }
            }
        }
        let mut reg = BTreeMap::new();
        let mut files = self.files.clone();
        // preset results, and nothing below them: a payload is the bottom of its file
        for op in seq.start.keys() {
            if let Some(first) = target.preset(body, *op)? {
                let mut at = first;
                for v in body[*op].results.clone() {
                    let f = target.file(body, v)?;
                    reg.insert(v, at);
                    at += target.size(body, v)?.0;
                    files[f].start = files[f].start.max(at);
                }
            }
        }
        // the values each position frees: those read there last (a web once, by its first member)
        let mut frees: BTreeMap<usize, Vec<ValueId>> = BTreeMap::new();
        for (&v, &p) in &last {
            if self.fixed.contains_key(&v) || web.get(&v).is_some_and(|w| webs[*w][0] != v) {
                continue;
            }
            frees.entry(p).or_default().push(v);
        }
        let mut free: Vec<BTreeSet<u32>> = files.iter().map(|r| r.clone().collect()).collect();
        let mut web_reg: BTreeMap<usize, u32> = BTreeMap::new();
        for (i, event) in seq.events.iter().enumerate() {
            let done: Vec<(usize, u32)> = frees.get(&i).into_iter().flatten().map(|v| Self::registers(target, body, &files, &reg, &web, &web_reg, *v)).collect::<Result<Vec<_>, _>>()?.into_iter().flatten().collect();
            match *event {
                Event::Start(op) => {
                    if target.preset(body, op)?.is_some() {
                        continue;
                    }
                    // freed before the results are placed when they may reuse them, after when they must stay apart
                    let reuse = target.reuses_sources(body, op);
                    if reuse {
                        Self::release(&mut free, &done);
                    }
                    if body[op].regions.is_empty() {
                        self.results(target, body, &body[op].results, &web, &mut web_reg, &mut free, &mut reg)?;
                    } else {
                        // its regions' arguments, defined as it starts
                        let args: Vec<ValueId> = body[op].regions.iter().flat_map(|r| body[*r].blocks.iter().flat_map(|b| body[*b].args.clone())).collect();
                        for a in args {
                            self.results(target, body, &[a], &web, &mut web_reg, &mut free, &mut reg)?;
                        }
                    }
                    if !reuse {
                        Self::release(&mut free, &done);
                    }
                }
                Event::End(op) => {
                    Self::release(&mut free, &done);
                    self.results(target, body, &body[op].results, &web, &mut web_reg, &mut free, &mut reg)?;
                }
            }
        }
        Ok(reg)
    }

    /// Whether value `v` is defined inside op `a` (in one of its regions).
    fn inside(body: &Body<'_>, v: ValueId, a: OpId) -> bool {
        let mut at = match body[v].def {
            Def::Result(d, _) => body.parent_op(d),
            // a block argument: its block's op
            Def::Arg(b, _) => body.block_owner(b),
        };
        while let Some(o) = at {
            if o == a {
                return true;
            }
            at = body.parent_op(o);
        }
        false
    }

    /// The registers `v` holds (none when it has none, or they are outside `files`, the ones allocated: below a preset
    /// payload they stay).
    fn registers(target: &impl RegTarget, body: &Body<'_>, files: &[Range<u32>], reg: &BTreeMap<ValueId, u32>, web: &BTreeMap<ValueId, usize>, web_reg: &BTreeMap<usize, u32>, v: ValueId) -> Result<Vec<(usize, u32)>, Error> {
        let r = match web.get(&v) {
            Some(w) => web_reg.get(w).copied(),
            None => reg.get(&v).copied(),
        };
        let (Some(r), f) = (r, target.file(body, v)?) else { return Ok(Vec::new()) };
        if !files[f].contains(&r) {
            return Ok(Vec::new());
        }
        Ok((r..r + target.size(body, v)?.0).map(|x| (f, x)).collect())
    }

    fn release(free: &mut [BTreeSet<u32>], done: &[(usize, u32)]) {
        for (f, r) in done {
            free[*f].insert(*r);
        }
    }

    /// Registers for `results` (an op's): several (outside webs), or a group, one run; else each its own, a web's,
    /// fixed or the lowest.
    #[allow(clippy::too_many_arguments, reason = "the allocation's state")]
    fn results(&self, target: &impl RegTarget, body: &Body<'_>, results: &[ValueId], web: &BTreeMap<ValueId, usize>, web_reg: &mut BTreeMap<usize, u32>, free: &mut [BTreeSet<u32>], reg: &mut BTreeMap<ValueId, u32>) -> Result<(), Error> {
        if results.len() > 1 && results.iter().all(|v| !web.contains_key(v)) {
            return LinearScan::place(target, body, results, free, reg);
        }
        for &v in results {
            // a later member of a group has its register from the first
            if reg.contains_key(&v) {
                continue;
            }
            // a web's member: the web's register, placed with its first member
            if let Some(w) = web.get(&v) {
                match web_reg.get(w) {
                    Some(r) => {
                        reg.insert(v, *r);
                    }
                    None => {
                        LinearScan::place(target, body, &[v], free, reg)?;
                        web_reg.insert(*w, reg[&v]);
                    }
                }
                continue;
            }
            if let Some(group) = self.groups.get(&v) {
                LinearScan::place(target, body, group, free, reg)?;
                continue;
            }
            match self.fixed.get(&v) {
                Some(r) => {
                    reg.insert(v, *r);
                }
                None => LinearScan::place(target, body, &[v], free, reg)?,
            }
        }
        Ok(())
    }

    /// `values` one after another in the lowest free run of their file that is aligned for the first.
    fn place(target: &impl RegTarget, body: &Body<'_>, values: &[ValueId], free: &mut [BTreeSet<u32>], reg: &mut BTreeMap<ValueId, u32>) -> Result<(), Error> {
        let f = target.file(body, values[0])?;
        let sizes: Vec<u32> = values.iter().map(|v| target.size(body, *v).map(|s| s.0)).collect::<Result<_, _>>()?;
        let (n, align) = (sizes.iter().sum::<u32>(), target.size(body, values[0])?.1.max(1));
        let at = free[f].iter().copied().find(|r| r % align == 0 && (*r..*r + n).all(|x| free[f].contains(&x))).ok_or_else(|| Error("out of registers".into()))?;
        let mut r = at;
        for (v, s) in values.iter().zip(sizes) {
            reg.insert(*v, r);
            for x in r..r + s {
                free[f].remove(&x);
            }
            r += s;
        }
        Ok(())
    }
}
