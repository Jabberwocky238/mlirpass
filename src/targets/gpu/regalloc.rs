use alloc::collections::{BTreeMap, BTreeSet};
use alloc::vec::Vec;
use core::ops::Range;

use mlirformat::Error;

use crate::{BlockId, Body, Def, OpId, ValueId};

pub trait RegTarget {
    fn preset(&self, body: &Body<'_>, op: OpId) -> Result<Option<u32>, Error>;
    fn reuses_sources(&self, body: &Body<'_>, op: OpId) -> bool;
    fn is_loop(&self, _body: &Body<'_>, _op: OpId) -> bool {
        false
    }
    fn file(&self, body: &Body<'_>, v: ValueId) -> Result<usize, Error>;
    fn size(&self, body: &Body<'_>, v: ValueId) -> Result<(u32, u32), Error>;
}

pub type Groups = BTreeMap<ValueId, Vec<ValueId>>;

pub struct LinearScan {
    pub files: Vec<Range<u32>>,
    pub fixed: BTreeMap<ValueId, u32>,
    pub groups: Groups,
}

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
    pub fn run(&self, target: &impl RegTarget, body: &Body<'_>, block: BlockId) -> Result<BTreeMap<ValueId, u32>, Error> {
        self.run_with(target, body, block, &[])
    }

    pub fn run_with(&self, target: &impl RegTarget, body: &Body<'_>, block: BlockId, webs: &[Vec<ValueId>]) -> Result<BTreeMap<ValueId, u32>, Error> {
        let seq = Sequence::of(body, block);
        let web: BTreeMap<ValueId, usize> = webs.iter().enumerate().flat_map(|(i, w)| w.iter().map(move |v| (*v, i))).collect();
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
                    let reuse = target.reuses_sources(body, op);
                    if reuse {
                        Self::release(&mut free, &done);
                    }
                    if body[op].regions.is_empty() {
                        self.results(target, body, &body[op].results, &web, &mut web_reg, &mut free, &mut reg)?;
                    } else {
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

    fn inside(body: &Body<'_>, v: ValueId, a: OpId) -> bool {
        let mut at = match body[v].def {
            Def::Result(d, _) => body.parent_op(d),
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

    #[allow(clippy::too_many_arguments, reason = "the allocation's state")]
    fn results(&self, target: &impl RegTarget, body: &Body<'_>, results: &[ValueId], web: &BTreeMap<ValueId, usize>, web_reg: &mut BTreeMap<usize, u32>, free: &mut [BTreeSet<u32>], reg: &mut BTreeMap<ValueId, u32>) -> Result<(), Error> {
        if results.len() > 1 && results.iter().all(|v| !web.contains_key(v)) {
            return LinearScan::place(target, body, results, free, reg);
        }
        for &v in results {
            if reg.contains_key(&v) {
                continue;
            }
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
