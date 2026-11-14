use alloc::collections::{BTreeMap, BTreeSet};
use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{Error, Str, Type};

use crate::{BlockId, Body, DomTree, OpId, RegionId, ValueId};

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct At {
    pub block: BlockId,
    pub before: Option<OpId>,
}

impl At {
    pub fn end(block: BlockId) -> Self {
        Self { block, before: None }
    }

    pub fn begin(body: &Body<'_>, block: BlockId) -> Self {
        Self { block, before: body.first_op(block) }
    }

    pub fn terminator(body: &Body<'_>, block: BlockId) -> Self {
        Self { block, before: body.last_op(block) }
    }

    pub fn place(self, body: &mut Body<'_>, op: OpId) -> OpId {
        match self.before {
            Some(b) => body.insert_before(op, b),
            None => body.insert(op, self.block, None),
        }
        op
    }
}

pub trait CfgToScfInterface<'a> {
    fn branch_region_op(&mut self, body: &mut Body<'a>, at: At, cond: OpId, result_types: &[Type<'a>], regions: Vec<Vec<BlockId>>) -> Result<OpId, Error>;

    fn branch_region_terminator(&mut self, body: &mut Body<'a>, at: At, loc: Option<Str<'a>>, op: OpId, replaced: Option<OpId>, results: &[ValueId]) -> Result<(), Error>;

    fn do_while_loop(&mut self, body: &mut Body<'a>, at: At, replaced: OpId, init: &[ValueId], condition: ValueId, next: &[ValueId], loop_body: Vec<BlockId>) -> Result<OpId, Error>;

    fn switch_value(&mut self, body: &mut Body<'a>, at: At, loc: Option<Str<'a>>, value: u32) -> ValueId;

    #[expect(clippy::too_many_arguments, reason = "createCFGSwitchOp's parameters")]
    fn cfg_switch(&mut self, body: &mut Body<'a>, at: At, loc: Option<Str<'a>>, flag: ValueId, case_values: &[u32], case_dests: &[BlockId], case_args: &[Vec<ValueId>], default: BlockId, default_args: &[ValueId]) -> OpId;

    fn undef_value(&mut self, body: &mut Body<'a>, at: At, loc: Option<Str<'a>>, ty: &Type<'a>) -> ValueId;

    fn unreachable_terminator(&mut self, body: &mut Body<'a>, at: At, loc: Option<Str<'a>>, region: RegionId) -> Result<OpId, Error>;

    fn can_convert_multi_successor(&self, _body: &Body<'a>, _op: OpId) -> bool {
        true
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
struct Edge {
    term: OpId,
    index: usize,
}

struct Lift<'i, 'a> {
    interface: &'i mut dyn CfgToScfInterface<'a>,
    region: RegionId,
    loc: Option<Str<'a>>,
    switch_values: Vec<Option<ValueId>>,
    undef: Vec<(Type<'a>, ValueId)>,
    preds: BTreeMap<BlockId, Vec<Edge>>,
    dom: BTreeMap<RegionId, DomTree>,
    exits: Vec<(OpId, BlockId)>,
}

struct Multiplexer {
    block: BlockId,
    mapping: Vec<(BlockId, usize)>,
    discriminator: Option<ValueId>,
}

struct Scc {
    visit_num: u32,
    numbers: BTreeMap<BlockId, u32>,
    node_stack: Vec<BlockId>,
    visit_stack: Vec<(BlockId, usize, u32)>,
    current: Vec<BlockId>,
}

impl Scc {
    fn new(body: &Body<'_>, entry: BlockId) -> Self {
        let mut s = Self { visit_num: 0, numbers: BTreeMap::new(), node_stack: Vec::new(), visit_stack: Vec::new(), current: Vec::new() };
        s.visit_one(entry);
        s.next_scc(body);
        s
    }

    fn visit_one(&mut self, n: BlockId) {
        self.visit_num += 1;
        self.numbers.insert(n, self.visit_num);
        self.node_stack.push(n);
        self.visit_stack.push((n, 0, self.visit_num));
    }

    fn visit_children(&mut self, body: &Body<'_>) {
        loop {
            let (n, next, _) = *self.visit_stack.last().expect("visiting");
            let succ = body.successors(n);
            if next >= succ.len() {
                return;
            }
            let child = succ[next];
            self.visit_stack.last_mut().expect("visiting").1 += 1;
            match self.numbers.get(&child) {
                None => self.visit_one(child),
                Some(&num) => {
                    let top = self.visit_stack.last_mut().expect("visiting");
                    if top.2 > num {
                        top.2 = num;
                    }
                }
            }
        }
    }

    fn next_scc(&mut self, body: &Body<'_>) {
        self.current.clear();
        while !self.visit_stack.is_empty() {
            self.visit_children(body);
            let (n, _, min) = self.visit_stack.pop().expect("visiting");
            if let Some(top) = self.visit_stack.last_mut()
                && top.2 > min
            {
                top.2 = min;
            }
            if min != self.numbers[&n] {
                continue;
            }
            loop {
                let x = self.node_stack.pop().expect("on the stack");
                self.current.push(x);
                self.numbers.insert(x, u32::MAX);
                if x == n {
                    break;
                }
            }
            return;
        }
    }

    fn at_end(&self) -> bool {
        self.current.is_empty()
    }

    fn has_cycle(&self, body: &Body<'_>) -> bool {
        self.current.len() > 1 || body.successors(self.current[0]).contains(&self.current[0])
    }
}

impl<'i, 'a> Lift<'i, 'a> {
    fn from(&self, body: &Body<'_>, e: Edge) -> BlockId {
        body[e.term].parent.expect("terminator in a block")
    }

    fn successor(body: &Body<'_>, e: Edge) -> BlockId {
        body[e.term].successors[e.index]
    }

    fn term(body: &Body<'_>, b: BlockId) -> OpId {
        body.last_op(b).expect("block with a terminator")
    }

    fn successor_edges(body: &Body<'_>, b: BlockId) -> Vec<Edge> {
        let t = Self::term(body, b);
        (0..body[t].successors.len()).map(|index| Edge { term: t, index }).collect()
    }

    fn preds(&self, b: BlockId) -> Vec<Edge> {
        self.preds.get(&b).cloned().unwrap_or_default()
    }

    fn single_pred(&self, body: &Body<'_>, b: BlockId) -> Option<BlockId> {
        match self.preds(b)[..] {
            [e] => Some(self.from(body, e)),
            _ => None,
        }
    }

    fn add_uses(&mut self, body: &Body<'_>, term: OpId) {
        for (index, s) in body[term].successors.clone().into_iter().enumerate() {
            self.preds.entry(s).or_default().insert(0, Edge { term, index });
        }
    }

    fn drop_uses(&mut self, body: &Body<'_>, term: OpId) {
        for s in body[term].successors.clone() {
            if let Some(l) = self.preds.get_mut(&s) {
                l.retain(|e| e.term != term);
            }
        }
    }

    fn set_successor(&mut self, body: &mut Body<'_>, e: Edge, to: BlockId) {
        let old = Self::successor(body, e);
        if let Some(l) = self.preds.get_mut(&old) {
            l.retain(|x| *x != e);
        }
        body[e.term].successors[e.index] = to;
        self.preds.entry(to).or_default().insert(0, e);
    }

    fn replace_block_uses(&mut self, body: &mut Body<'_>, from: BlockId, to: BlockId) {
        let moved = self.preds.remove(&from).unwrap_or_default();
        for e in &moved {
            body[e.term].successors[e.index] = to;
            self.preds.entry(to).or_default().insert(0, *e);
        }
    }

    fn succ_operands(body: &Body<'_>, e: Edge) -> Vec<ValueId> {
        let r = body.successor_operands(e.term, e.index).unwrap_or(0..0);
        body[e.term].operands[r].to_vec()
    }

    fn set_succ_operands(body: &mut Body<'_>, e: Edge, values: &[ValueId]) {
        let n = body.successor_operands(e.term, e.index).map_or(0, |r| r.len());
        let all: Vec<usize> = (0..n).collect();
        body.erase_successor_operands(e.term, e.index, &all);
        body.append_successor_operands(e.term, e.index, values);
    }

    fn append_succ_operands(body: &mut Body<'_>, e: Edge, values: &[ValueId]) {
        body.append_successor_operands(e.term, e.index, values);
    }

    fn entry(&self, body: &Body<'_>) -> BlockId {
        body[self.region].blocks[0]
    }

    fn switch_value(&mut self, body: &mut Body<'a>, n: u32) -> ValueId {
        if let Some(Some(v)) = self.switch_values.get(n as usize) {
            return *v;
        }
        let at = At::begin(body, self.entry(body));
        let v = self.interface.switch_value(body, at, self.loc.clone(), n);
        if self.switch_values.len() <= n as usize {
            self.switch_values.resize(n as usize + 1, None);
        }
        self.switch_values[n as usize] = Some(v);
        v
    }

    fn undef(&mut self, body: &mut Body<'a>, ty: &Type<'a>) -> ValueId {
        if let Some((_, v)) = self.undef.iter().find(|(t, _)| t == ty) {
            return *v;
        }
        let at = At::begin(body, self.entry(body));
        let v = self.interface.undef_value(body, at, self.loc.clone(), ty);
        self.undef.push((ty.clone(), v));
        v
    }

    fn cfg_switch(&mut self, body: &mut Body<'a>, at: At, loc: Option<Str<'a>>, flag: ValueId, cases: &[u32], dests: &[BlockId], args: &[Vec<ValueId>], default: BlockId, default_args: &[ValueId]) -> OpId {
        let op = self.interface.cfg_switch(body, at, loc, flag, cases, dests, args, default, default_args);
        self.add_uses(body, op);
        op
    }

    fn branch_to(&mut self, body: &mut Body<'a>, at: At, loc: Option<Str<'a>>, dest: BlockId, args: &[ValueId]) -> OpId {
        let flag = self.switch_value(body, 0);
        self.cfg_switch(body, at, loc, flag, &[], &[], &[], dest, args)
    }

    fn new_block_after(body: &mut Body<'a>, region: RegionId, after: Option<BlockId>, args: Vec<(Type<'a>, Option<Str<'a>>)>) -> BlockId {
        let b = body.add_block(region, &args);
        if let Some(a) = after {
            body.remove_block(b);
            let at = body[region].blocks.iter().position(|x| *x == a).expect("in region") + 1;
            body.region_insert(region, at, b);
            body[b].parent = Some(region);
        }
        b
    }

    fn args_of(body: &Body<'a>, b: BlockId) -> Vec<(Type<'a>, Option<Str<'a>>)> {
        body[b].args.iter().map(|a| (body[*a].ty.clone(), body[*a].loc.clone())).collect()
    }

    fn add_args_from(body: &mut Body<'a>, b: BlockId, other: BlockId) {
        for (ty, loc) in Self::args_of(body, other) {
            let a = body.add_arg(b, ty);
            body[a].loc = loc;
        }
    }

    fn detach_block(body: &mut Body<'_>, b: BlockId) -> BlockId {
        body.remove_block(b);
        b
    }

    fn erase_block(&mut self, body: &mut Body<'_>, b: BlockId) {
        self.preds.remove(&b);
        body.remove_block(b);
    }

    fn dom(&mut self, body: &Body<'_>, region: RegionId) -> &DomTree {
        self.dom.entry(region).or_insert_with(|| body.dom_tree(region))
    }

    fn invalidate(&mut self, region: RegionId) {
        self.dom.remove(&region);
    }

    fn dominates(&mut self, body: &Body<'_>, region: RegionId, a: BlockId, b: BlockId) -> bool {
        let t = self.dom(body, region);
        if a == b || !t.reachable(b) {
            return true;
        }
        if !t.reachable(a) {
            return false;
        }
        t.dominates(a, b)
    }

    fn dominated(&mut self, body: &Body<'_>, region: RegionId, n: BlockId) -> Vec<BlockId> {
        let t = self.dom(body, region);
        let mut out = Vec::new();
        let mut stack = vec![n];
        while let Some(b) = stack.pop() {
            out.push(b);
            stack.extend(t.children(b).iter().rev());
        }
        out
    }

    fn multiplexer(&mut self, body: &mut Body<'a>, loc: Option<Str<'a>>, entries: &[BlockId], extra: &[Type<'a>]) -> Multiplexer {
        let region = body[entries[0]].parent.expect("in region");
        let block = Self::new_block_after(body, region, Some(entries[0]), Vec::new());
        let mut mapping: Vec<(BlockId, usize)> = Vec::new();
        for e in entries {
            if !mapping.iter().any(|(b, _)| b == e) {
                mapping.push((*e, body[block].args.len()));
                Self::add_args_from(body, block, *e);
            }
        }
        let mut discriminator = None;
        if mapping.len() > 1 {
            let flag = self.switch_value(body, 0);
            let ty = body[flag].ty.clone();
            let a = body.add_arg(block, ty);
            body[a].loc.clone_from(&loc);
            discriminator = Some(a);
        }
        for ty in extra {
            let a = body.add_arg(block, ty.clone());
            body[a].loc.clone_from(&loc);
        }
        Multiplexer { block, mapping, discriminator }
    }

    fn redirect(&mut self, body: &mut Body<'a>, m: &Multiplexer, e: Edge, extra: &[ValueId]) {
        let succ = Self::successor(body, e);
        let (slot, offset) = m.mapping.iter().enumerate().find(|(_, (b, _))| *b == succ).map(|(i, (_, o))| (i, *o)).expect("an entry block");
        let operands = Self::succ_operands(body, e);
        let n = body[m.block].args.len();
        let extra_begin = n - extra.len();
        let disc = m.discriminator.map(|_| extra_begin - 1);
        let nsucc = body[succ].args.len();
        let mut new = Vec::with_capacity(n);
        for index in 0..n {
            let v = if index >= offset && index < offset + nsucc {
                operands[index - offset]
            } else if Some(index) == disc {
                self.switch_value(body, slot as u32)
            } else if index >= extra_begin {
                extra[index - extra_begin]
            } else {
                let ty = body[body[m.block].args[index]].ty.clone();
                self.undef(body, &ty)
            };
            new.push(v);
        }
        self.set_successor(body, e, m.block);
        Self::set_succ_operands(body, e, &new);
    }

    fn create_switch(&mut self, body: &mut Body<'a>, m: &Multiplexer, at: At, loc: Option<Str<'a>>, excluded: &[BlockId]) {
        let mut values = Vec::new();
        let mut dests = Vec::new();
        let mut args = Vec::new();
        for (index, (succ, offset)) in m.mapping.iter().enumerate() {
            if excluded.contains(succ) {
                continue;
            }
            values.push(index as u32);
            let n = body[*succ].args.len();
            args.push(body[m.block].args[*offset..*offset + n].to_vec());
            dests.push(*succ);
        }
        let flag = match m.discriminator {
            Some(d) if args.len() != 1 => d,
            _ => self.switch_value(body, 0),
        };
        values.pop();
        let default = dests.pop().expect("a destination");
        let default_args = args.pop().expect("a destination");
        self.cfg_switch(body, at, loc, flag, &values, &dests, &args, default, &default_args);
    }

    fn single_entry(&mut self, body: &mut Body<'a>, loc: Option<Str<'a>>, edges: &[Edge]) -> Multiplexer {
        let entries: Vec<BlockId> = edges.iter().map(|e| Self::successor(body, *e)).collect();
        let m = self.multiplexer(body, loc.clone(), &entries, &[]);
        for e in edges {
            self.redirect(body, &m, *e, &[]);
        }
        let at = At::begin(body, m.block);
        self.create_switch(body, &m, at, loc, &[]);
        m
    }

    fn equivalent(body: &Body<'_>, a: OpId, b: OpId) -> bool {
        body[a].name == body[b].name && body[a].properties == body[b].properties && body[a].attributes == body[b].attributes && body.types(&body[a].operands) == body.types(&body[b].operands)
    }

    fn combine_exit(&mut self, body: &mut Body<'a>, ret: OpId) {
        let found = self.exits.iter().find(|(r, _)| Self::equivalent(body, *r, ret)).copied();
        if let Some((r, _)) = found
            && r == ret
        {
            return;
        }
        let exit = match found {
            Some((_, e)) => e,
            None => {
                let loc = body[ret].loc.clone();
                let args: Vec<_> = body.types(&body[ret].operands).into_iter().map(|t| (t, loc.clone())).collect();
                let e = Self::new_block_after(body, self.region, None, args);
                self.exits.push((ret, e));
                e
            }
        };
        let block = body[ret].parent.expect("in a block");
        let operands = body[ret].operands.to_vec();
        let loc = body[ret].loc.clone();
        let at = At::terminator(body, block);
        self.branch_to(body, at, loc, exit, &operands);
        if found.is_some() {
            body.erase(ret);
            return;
        }
        body.detach(ret);
        body.insert(ret, exit, None);
        let args = body[exit].args.to_vec();
        body.set_operands(ret, args.into_iter().collect::<crate::Ids<ValueId>>());
    }

    fn cycle_edges(&self, body: &Body<'_>, cycle: &[BlockId]) -> (Vec<Edge>, Vec<Edge>, Vec<Edge>) {
        let (mut entry, mut exit, mut back) = (Vec::new(), Vec::new(), Vec::new());
        let mut entry_blocks = BTreeSet::new();
        for &b in cycle {
            for e in self.preds(b) {
                if cycle.contains(&self.from(body, e)) {
                    continue;
                }
                entry.push(e);
                entry_blocks.insert(b);
            }
            for e in Self::successor_edges(body, b) {
                if !cycle.contains(&Self::successor(body, e)) {
                    exit.push(e);
                }
            }
        }
        for &b in cycle {
            for e in Self::successor_edges(body, b) {
                if entry_blocks.contains(&Self::successor(body, e)) {
                    back.push(e);
                }
            }
        }
        (entry, exit, back)
    }

    fn single_exiting_latch(&mut self, body: &mut Body<'a>, loc: Option<Str<'a>>, back: &[Edge], exits: &[Edge]) -> Result<(BlockId, ValueId, BlockId), Error> {
        let mut succs: Vec<BlockId> = back.iter().map(|e| Self::successor(body, *e)).collect();
        succs.extend(exits.iter().map(|e| Self::successor(body, *e)));
        let flag_ty = {
            let f = self.switch_value(body, 0);
            body[f].ty.clone()
        };
        let m = self.multiplexer(body, loc.clone(), &succs, &[flag_ty]);
        let latch = m.block;
        let region = body[latch].parent.expect("in region");
        let exit = Self::new_block_after(body, region, Some(latch), Vec::new());
        let header = Self::successor(body, back[0]);
        let one = self.switch_value(body, 1);
        for e in back {
            self.redirect(body, &m, *e, &[one]);
        }
        let zero = self.switch_value(body, 0);
        for e in exits {
            self.redirect(body, &m, *e, &[zero]);
        }
        let repeat = *body[latch].args.last().expect("the flag");
        let nh = body[header].args.len();
        let header_args = body[latch].args[..nh].to_vec();
        let at = At::begin(body, latch);
        self.cfg_switch(body, at, loc.clone(), repeat, &[0], &[exit], &[Vec::new()], header, &header_args);
        let at = At::begin(body, exit);
        if exits.is_empty() {
            let t = self.interface.unreachable_terminator(body, at, loc, self.region)?;
            self.combine_exit(body, t);
        } else {
            self.create_switch(body, &m, at, loc, &[header]);
        }
        Ok((latch, repeat, exit))
    }

    fn reduce_loop(&mut self, body: &mut Body<'a>, header: BlockId, exit: BlockId, loop_blocks: &[BlockId]) -> Vec<ValueId> {
        let latch = self.single_pred(body, exit).expect("the latch alone leads to the exit block");
        let region = body[header].parent.expect("in region");
        let lt = Self::term(body, latch);
        let (hi, ei) = if body[lt].successors[0] == header { (0, 1) } else { (1, 0) };
        let header_edge = Edge { term: lt, index: hi };
        let exit_edge = Edge { term: lt, index: ei };
        let mut header_operands = Self::succ_operands(body, header_edge);
        let in_loop = |body: &Body<'_>, o: OpId| body[o].parent.is_some_and(|b| loop_blocks.contains(&b));
        for &arg in &header_operands.clone() {
            let ty = body[arg].ty.clone();
            let loc = body.value_loc(arg);
            let ea = body.add_arg(exit, ty);
            body[ea].loc = loc;
            Self::append_succ_operands(body, exit_edge, &[arg]);
            for u in body[arg].uses.iter().cloned().collect::<Vec<_>>() {
                if !in_loop(body, u.op) {
                    body.set_operand(u.op, u.index as usize, ea);
                }
            }
        }
        let latch_prior = body[latch].args.to_vec();
        let header_prior = body[header].args.to_vec();
        for &lb in loop_blocks {
            let mut cache: BTreeMap<BlockId, bool> = BTreeMap::new();
            let mut values: Vec<ValueId> = if lb == latch {
                latch_prior.clone()
            } else if lb == header {
                header_prior.clone()
            } else {
                body[lb].args.to_vec()
            };
            for o in body.block_ops(lb) {
                values.extend(body[o].results.iter().copied());
            }
            for value in values {
                let mut arg: Option<ValueId> = None;
                let uses: Vec<_> = body[value].uses.iter().cloned().collect();
                for u in uses {
                    let mut cur = body[u.op].parent;
                    while let Some(c) = cur
                        && body[c].parent != Some(region)
                    {
                        cur = body.block_owner(c).and_then(|o| body[o].parent);
                    }
                    if cur.is_some_and(|c| loop_blocks.contains(&c)) {
                        continue;
                    }
                    if arg.is_none() {
                        let ty = body[value].ty.clone();
                        let loc = body.value_loc(value);
                        let ea = body.add_arg(exit, ty.clone());
                        body[ea].loc.clone_from(&loc);
                        let ha = body.add_arg(header, ty.clone());
                        body[ha].loc.clone_from(&loc);
                        arg = Some(ea);
                        let mut argument = value;
                        let dominates = |s: &mut Self, body: &Body<'_>, cache: &mut BTreeMap<BlockId, bool>, p: BlockId| *cache.entry(p).or_insert_with(|| s.dominates(body, region, lb, p));
                        let latch_preds = self.preds(latch);
                        let defined_in_latch = body.value_block(value) == Some(latch);
                        let not_all = !defined_in_latch && latch_preds.iter().any(|e| {
                            let p = self.from(body, *e);
                            !dominates(self, body, &mut cache, p)
                        });
                        if not_all {
                            let la = body.add_arg(latch, ty.clone());
                            body[la].loc = loc;
                            argument = la;
                            for e in latch_preds {
                                let p = self.from(body, e);
                                let operand = if dominates(self, body, &mut cache, p) { value } else { self.undef(body, &ty) };
                                Self::append_succ_operands(body, e, &[operand]);
                            }
                        }
                        header_operands.push(argument);
                        for e in Self::successor_edges(body, latch) {
                            Self::append_succ_operands(body, e, &[argument]);
                        }
                    }
                    body.set_operand(u.op, u.index as usize, arg.expect("made above"));
                }
            }
        }
        for e in self.preds(header) {
            if self.from(body, e) == latch {
                continue;
            }
            let have = Self::succ_operands(body, e).len();
            let extra: Vec<Type<'a>> = body[header].args[have..].iter().map(|a| body[*a].ty.clone()).collect();
            let undefs: Vec<ValueId> = extra.iter().map(|t| self.undef(body, t)).collect();
            Self::append_succ_operands(body, e, &undefs);
        }
        header_operands
    }

    fn cycles(&mut self, body: &mut Body<'a>, region_entry: BlockId) -> Result<Vec<BlockId>, Error> {
        let mut out = Vec::new();
        let mut scc = Scc::new(body, region_entry);
        while !scc.at_end() {
            if !scc.has_cycle(body) {
                scc.next_scc(body);
                continue;
            }
            let mut cycle: Vec<BlockId> = scc.current.clone();
            scc.next_scc(body);
            let (entry, exits, back) = self.cycle_edges(body, &cycle);
            let mut header = Self::successor(body, entry[0]);
            if entry.len() > 1 {
                let mut edges = entry.clone();
                edges.extend(back.iter().copied());
                let loc = body[Self::term(body, header)].loc.clone();
                let m = self.single_entry(body, loc, &edges);
                header = m.block;
            }
            if !cycle.contains(&header) {
                cycle.push(header);
            }
            let loc = body[back[0].term].loc.clone();
            let (latch, condition, exit) = self.single_exiting_latch(body, loc, &back, &exits)?;
            if !cycle.contains(&latch) {
                cycle.push(latch);
            }
            let next = self.reduce_loop(body, header, exit, &cycle);
            let region = body[region_entry].parent.expect("in region");
            let parent_args = Self::args_of(body, header);
            let at_header = body[region].blocks.iter().position(|b| *b == header).expect("in region");
            let new_parent = body.add_block(region, &parent_args);
            body.remove_block(new_parent);
            body.region_insert(region, at_header, new_parent);
            body[new_parent].parent = Some(region);
            let mut loop_body = vec![Self::detach_block(body, header)];
            for &b in &cycle {
                if b != latch && b != header {
                    loop_body.push(Self::detach_block(body, b));
                }
            }
            loop_body.push(Self::detach_block(body, latch));
            let old = Self::term(body, latch);
            body.detach(old);
            let init = body[new_parent].args.to_vec();
            let at = At::begin(body, new_parent);
            let op = self.interface.do_while_loop(body, at, old, &init, condition, &next, loop_body)?;
            self.drop_uses(body, old);
            body.erase(old);
            out.push(header);
            let results = body[op].results.to_vec();
            for (o, n) in body[exit].args.to_vec().into_iter().zip(results) {
                body.replace_all_uses(o, n);
            }
            self.replace_block_uses(body, header, new_parent);
            body.splice(exit, None, new_parent, None);
            self.erase_block(body, exit);
        }
        Ok(out)
    }

    fn single_exit_branch_region(&mut self, body: &mut Body<'a>, branch: &[BlockId], continuation: BlockId, empty: &mut Vec<(BlockId, Vec<ValueId>)>) -> Vec<BlockId> {
        let region = body[branch[0]].parent.expect("in region");
        let mut single: Option<BlockId> = None;
        let mut previous: Option<Edge> = None;
        let mut blocks = Vec::new();
        for &b in branch {
            for e in Self::successor_edges(body, b) {
                if Self::successor(body, e) != continuation {
                    continue;
                }
                let Some(p) = previous else {
                    previous = Some(e);
                    continue;
                };
                if single.is_none() {
                    let args = Self::args_of(body, continuation);
                    let s = Self::new_block_after(body, region, None, args);
                    body.remove_block(s);
                    self.set_successor(body, p, s);
                    empty.push((s, body[s].args.to_vec()));
                    single = Some(s);
                }
                self.set_successor(body, e, single.expect("made above"));
            }
            blocks.push(Self::detach_block(body, b));
        }
        if let Some(s) = single {
            blocks.push(s);
        }
        blocks
    }

    fn branches(&mut self, body: &mut Body<'a>, entry: BlockId) -> Result<Vec<BlockId>, Error> {
        let region = body[entry].parent.expect("in region");
        let succs = body.successors(entry).to_vec();
        if succs.is_empty() {
            return Ok(Vec::new());
        }
        let et = Self::term(body, entry);
        if succs.len() == 1 {
            let s = succs[0];
            let operands = Self::succ_operands(body, Edge { term: et, index: 0 });
            for (o, n) in body[s].args.to_vec().into_iter().zip(operands) {
                body.replace_all_uses(o, n);
            }
            self.drop_uses(body, et);
            body.erase(et);
            body.splice(s, None, entry, None);
            self.erase_block(body, s);
            return Ok(vec![entry]);
        }
        let mut not_cont: BTreeSet<BlockId> = BTreeSet::from([entry]);
        let mut branch_regions: Vec<Vec<BlockId>> = vec![Vec::new(); succs.len()];
        for (i, s) in succs.iter().enumerate() {
            if self.single_pred(body, *s) != Some(entry) {
                continue;
            }
            for b in self.dominated(body, region, *s) {
                branch_regions[i].push(b);
                not_cont.insert(b);
            }
        }
        let entry_edges = Self::successor_edges(body, entry);
        let mut cont_edges: Vec<Edge> = Vec::new();
        let mut post_dominates_all = true;
        let mut no_cont_edge = true;
        for (e, br) in entry_edges.iter().zip(&branch_regions) {
            if br.is_empty() {
                cont_edges.push(*e);
                no_cont_edge = false;
                continue;
            }
            for &b in br {
                if body.successors(b).is_empty() {
                    post_dominates_all = false;
                    cont_edges.extend(self.preds(b));
                    continue;
                }
                for se in Self::successor_edges(body, b) {
                    if not_cont.contains(&Self::successor(body, se)) {
                        continue;
                    }
                    cont_edges.push(se);
                    no_cont_edge = false;
                }
            }
        }
        if no_cont_edge {
            return Ok(succs);
        }
        let first = Self::successor(body, cont_edges[0]);
        let mut continuation = cont_edges.iter().all(|e| Self::successor(body, *e) == first).then_some(first);
        if continuation.is_none() || !post_dominates_all {
            let loc = body[cont_edges[0].term].loc.clone();
            let m = self.single_entry(body, loc, &cont_edges);
            continuation = Some(m.block);
        }
        if !post_dominates_all {
            self.invalidate(region);
            return Ok(vec![entry]);
        }
        let continuation = continuation.expect("set above");
        let mut new_regions = Vec::new();
        let mut empty: Vec<(BlockId, Vec<ValueId>)> = Vec::new();
        let mut regions: Vec<Vec<BlockId>> = Vec::new();
        for (br, e) in branch_regions.iter().zip(&entry_edges) {
            if br.is_empty() {
                let b = Self::new_block_after(body, region, None, Vec::new());
                body.remove_block(b);
                empty.push((b, Self::succ_operands(body, *e)));
                regions.push(vec![b]);
                continue;
            }
            let blocks = self.single_exit_branch_region(body, br, continuation, &mut empty);
            let sub_entry = blocks[0];
            let operands = Self::succ_operands(body, *e);
            for (o, n) in body[sub_entry].args.to_vec().into_iter().zip(operands) {
                body.replace_all_uses(o, n);
            }
            let all: Vec<usize> = (0..body[sub_entry].args.len()).collect();
            body.erase_args(sub_entry, &all);
            new_regions.push(sub_entry);
            regions.push(blocks);
        }
        let result_types: Vec<Type<'a>> = body[continuation].args.iter().map(|a| body[*a].ty.clone()).collect();
        let at = At::terminator(body, entry);
        let op = self.interface.branch_region_op(body, at, et, &result_types, regions)?;
        self.drop_uses(body, et);
        body.erase(et);
        for (b, values) in empty {
            let loc = body[op].loc.clone();
            self.interface.branch_region_terminator(body, At::end(b), loc, op, None, &values)?;
        }
        for e in self.preds(continuation) {
            let user = e.term;
            let block = body[user].parent.expect("in a block");
            let operands = Self::succ_operands(body, Edge { term: user, index: 0 });
            let loc = body[user].loc.clone();
            let at = At::terminator(body, block);
            self.interface.branch_region_terminator(body, at, loc, op, Some(user), &operands)?;
            self.drop_uses(body, user);
            body.erase(user);
        }
        let results = body[op].results.to_vec();
        for (o, n) in body[continuation].args.to_vec().into_iter().zip(results) {
            body.replace_all_uses(o, n);
        }
        body.splice(continuation, None, entry, None);
        self.erase_block(body, continuation);
        new_regions.push(entry);
        Ok(new_regions)
    }

    fn preconditions(&self, body: &mut Body<'a>) -> bool {
        let blocks = body[self.region].blocks.to_vec();
        let mut reachable = alloc::collections::BTreeSet::new();
        let mut stack = vec![blocks[0]];
        while let Some(b) = stack.pop() {
            if reachable.insert(b) {
                stack.extend(body.successors(b).iter().copied());
            }
        }
        for &b in &blocks {
            if !reachable.contains(&b) {
                if let Some(first) = body.first_op(b) {
                    let msg = alloc::format!("'{}' op transformation does not support unreachable blocks", body[first].name);
                    body.emit_error(first, msg);
                }
                return false;
            }
        }
        let mut ops = Vec::new();
        for &b in &blocks {
            for o in body.block_ops(b) {
                body.walk(o, &mut |x| ops.push(x));
            }
        }
        for o in ops {
            if body[o].successors.is_empty() {
                continue;
            }
            if !body.is_branch(o) {
                let msg = alloc::format!("'{}' op transformation does not support terminators with successors not implementing BranchOpInterface", body[o].name);
                body.emit_error(o, msg);
                return false;
            }
            if !body.is_memory_effect_free(o) {
                let msg = alloc::format!("'{}' op transformation does not support terminators with side effects", body[o].name);
                body.emit_error(o, msg);
                return false;
            }
            for i in 0..body[o].successors.len() {
                if body.successor_layout(o, i).is_some_and(|(produced, _)| produced > 0) {
                    let msg = alloc::format!("'{}' op transformation does not support operations with operation-produced successor operands", body[o].name);
                    body.emit_error(o, msg);
                    return false;
                }
            }
        }
        for &b in &blocks {
            if body.successors(b).len() <= 1 {
                continue;
            }
            let t = Lift::term(body, b);
            if !self.interface.can_convert_multi_successor(body, t) {
                let msg = alloc::format!("'{}' op cannot convert unknown control flow op to structured control flow", body[t].name);
                body.emit_error(t, msg);
                return false;
            }
        }
        true
    }
}

pub fn transform_cfg_to_scf<'a>(body: &mut Body<'a>, region: RegionId, interface: &mut dyn CfgToScfInterface<'a>) -> Result<bool, Error> {
    if body[region].blocks.len() <= 1 {
        return Ok(false);
    }
    let owner = body[region].parent;
    let loc = body[owner].loc.clone();
    let mut s = Lift { interface, region, loc, switch_values: Vec::new(), undef: Vec::new(), preds: BTreeMap::new(), dom: BTreeMap::new(), exits: Vec::new() };
    for b in body[region].blocks.to_vec() {
        for o in body.block_ops(b) {
            let mut nested = Vec::new();
            body.walk(o, &mut |x| nested.push(x));
            for x in nested {
                if !body[x].successors.is_empty() {
                    s.add_uses(body, x);
                }
            }
        }
    }
    if !s.preconditions(body) {
        return Err(Error::from("transformation preconditions not met"));
    }
    for b in body[region].blocks.to_vec() {
        if !body.successors(b).is_empty() {
            continue;
        }
        let t = Lift::term(body, b);
        s.combine_exit(body, t);
    }
    s.invalidate(region);
    let mut work = vec![body[region].blocks[0]];
    while let Some(current) = work.pop() {
        let made = s.cycles(body, current)?;
        work.extend(made.iter().copied());
        if !made.is_empty() {
            let r = body[current].parent.expect("in region");
            s.invalidate(r);
        }
        let more = s.branches(body, current)?;
        work.extend(more);
    }
    Ok(true)
}
