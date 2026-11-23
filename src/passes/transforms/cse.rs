use alloc::collections::BTreeMap;
use alloc::vec::Vec;
use mlirformat::Error;
use crate::{pass, Body, BlockId, DomTree, EffectKind, OpId, RegionId, Trait, ValueId};

#[pass("cse")]
pub fn cse<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    body.cse(op);
    Ok(())
}

#[derive(Default)]
struct Known {
    ops: Vec<(u64, OpId)>,
    buckets: Vec<Vec<(u64, OpId)>>,
    scopes: Vec<usize>,
}

impl Known {
    fn open(&mut self) {
        self.scopes.push(self.ops.len());
    }

    fn close(&mut self) {
        let n = self.scopes.pop().expect("no scope");
        let mask = self.buckets.len().wrapping_sub(1);
        for (key, _) in self.ops.drain(n..).rev() {
            self.buckets[key as usize & mask].pop();
        }
    }

    fn push(&mut self, key: u64, op: OpId) {
        if self.ops.len() >= self.buckets.len() {
            let size = (self.buckets.len() * 2).max(64);
            self.buckets = (0..size).map(|_| Vec::new()).collect();
            for &(k, o) in &self.ops {
                self.buckets[k as usize & (size - 1)].push((k, o));
            }
        }
        self.ops.push((key, op));
        let mask = self.buckets.len() - 1;
        self.buckets[key as usize & mask].push((key, op));
    }

    fn find(&self, body: &Body<'_>, key: u64, op: OpId) -> Option<OpId> {
        let bucket = self.buckets.get(key as usize & self.buckets.len().wrapping_sub(1))?;
        bucket.iter().rev().find(|(k, o)| *k == key && body.equivalent(*o, op)).map(|(_, o)| *o)
    }

    fn lookup(&self, body: &Body<'_>, op: OpId) -> Option<OpId> {
        self.find(body, body.cse_key(op), op)
    }
}

struct Mix(u64);

impl Mix {
    const K: u64 = 0x517c_c1b7_2722_0a95;

    fn word(&mut self, w: u64) {
        self.0 = (self.0.rotate_left(5) ^ w).wrapping_mul(Self::K);
    }

    fn bytes(&mut self, b: &[u8]) {
        let mut chunks = b.chunks_exact(8);
        for c in &mut chunks {
            self.word(u64::from_le_bytes(c.try_into().expect("eight bytes")));
        }
        let mut tail = [0u8; 8];
        tail[..chunks.remainder().len()].copy_from_slice(chunks.remainder());
        self.word(u64::from_le_bytes(tail) ^ (b.len() as u64) << 56);
    }
}

impl Body<'_> {
    fn cse_key(&self, op: OpId) -> u64 {
        let d = &self[op];
        let mut h = Mix(0);
        h.bytes(d.name.as_bytes());
        if d.operands.len() > 1 && self.has(op, Trait::IsCommutative) {
            let mut operands: Vec<u64> = d.operands.iter().map(|v| v.raw()).collect();
            operands.sort_unstable();
            operands.into_iter().for_each(|w| h.word(w));
        } else {
            d.operands.iter().for_each(|v| h.word(v.raw()));
        }
        h.word((d.results.len() as u64) << 32 | d.regions.len() as u64);
        for a in d.properties.iter().chain(d.attributes.iter()) {
            match &a.value {
                Some(mlirformat::Attribute::Int { lit, .. } | mlirformat::Attribute::Float { lit, .. } | mlirformat::Attribute::Str { lit, .. }) => h.bytes(lit.as_bytes()),
                Some(mlirformat::Attribute::Bool(b)) => h.word(u64::from(*b)),
                _ => h.word(a.name.len() as u64),
            }
        }
        h.0
    }
}

#[derive(Default)]
struct Driver {
    erase: Vec<OpId>,
}

impl Driver {
    fn write_between(&self, body: &Body<'_>, from: OpId, to: OpId) -> bool {
        let reads: Vec<_> = body.effects_of(from).unwrap_or_default().into_iter().filter(|e| e.kind == EffectKind::Read).collect();
        let mut at = body.next_op(from);
        while let Some(o) = at.filter(|o| *o != to) {
            if body.effects_recursively(o).is_none_or(|e| e.iter().any(|w| w.kind == EffectKind::Write && reads.iter().any(|r| w.conflicts(r)))) {
                return true;
            }
            at = body.next_op(o);
        }
        false
    }

    fn replace(&mut self, body: &mut Body<'_>, known: &Known, op: OpId, existing: OpId, ssa: bool) {
        let pairs: Vec<_> = body[op].results.iter().copied().zip(body[existing].results.iter().copied()).collect();
        if ssa {
            pairs.into_iter().for_each(|(from, to)| body.replace_all_uses(from, to));
            self.erase.push(op);
        } else {
            for (from, to) in pairs {
                for u in body[from].uses.clone() {
                    if known.lookup(body, u.op).is_none() {
                        body.set_operand(u.op, u.index as usize, to);
                    }
                }
            }
            if body[op].results.iter().all(|r| body[*r].uses.is_empty()) {
                self.erase.push(op);
            }
        }
        if body[existing].loc.as_deref() == Some("unknown") && body[op].loc.as_deref().is_some_and(|l| l != "unknown") {
            body[existing].loc = body[op].loc.clone();
        }
    }

    fn operation(&mut self, body: &mut Body<'_>, known: &mut Known, op: OpId, ssa: bool) -> bool {
        if body.has(op, Trait::IsTerminator) {
            return false;
        }
        if body.is_trivially_dead(op) {
            self.erase.push(op);
            return true;
        }
        if !body[op].regions.iter().all(|r| body[*r].blocks.len() <= 1) {
            return false;
        }
        if !body.is_memory_effect_free(op) {
            if !body.has_only_effect(op, EffectKind::Read) {
                return false;
            }
            let key = body.cse_key(op);
            if let Some(existing) = known.find(body, key, op)
                && body[existing].parent == body[op].parent
                && !self.write_between(body, existing, op)
            {
                self.replace(body, known, op, existing, ssa);
                return true;
            }
            known.push(key, op);
            return false;
        }
        let key = body.cse_key(op);
        if let Some(existing) = known.find(body, key, op) {
            self.replace(body, known, op, existing, ssa);
            return true;
        }
        known.push(key, op);
        false
    }

    fn block(&mut self, body: &mut Body<'_>, known: &mut Known, block: BlockId, ssa: bool) {
        for op in body.block_ops(block) {
            let regions = body[op].regions.clone();
            if !regions.is_empty() {
                if body.might_have(op, Trait::IsIsolatedFromAbove) {
                    let mut nested = Known::default();
                    regions.into_iter().for_each(|r| self.region(body, &mut nested, r));
                } else {
                    regions.into_iter().for_each(|r| self.region(body, known, r));
                }
            }
            self.operation(body, known, op, ssa);
        }
    }

    fn region(&mut self, body: &mut Body<'_>, known: &mut Known, region: RegionId) {
        let Some(&entry) = body[region].blocks.first() else { return };
        let ssa = body.has_ssa_dominance(region);
        if body[region].blocks.len() == 1 {
            known.open();
            self.block(body, known, entry, ssa);
            known.close();
            return;
        }
        if !ssa {
            return;
        }
        let tree = body.dom_tree(region);
        self.node(body, known, &tree, tree.root, ssa);
    }

    fn node(&mut self, body: &mut Body<'_>, known: &mut Known, tree: &DomTree, b: BlockId, ssa: bool) {
        known.open();
        self.block(body, known, b, ssa);
        for c in tree.children(b) {
            self.node(body, known, tree, *c, ssa);
        }
        known.close();
    }
}

impl Body<'_> {
    pub fn cse(&mut self, op: OpId) -> bool {
        let mut d = Driver::default();
        let mut known = Known::default();
        for r in self[op].regions.clone() {
            d.region(self, &mut known, r);
        }
        let changed = !d.erase.is_empty();
        d.erase.into_iter().for_each(|o| self.erase(o));
        changed
    }
}

#[derive(Default)]
struct Equivalence {
    values: BTreeMap<ValueId, ValueId>,
}

impl Equivalence {
    fn check(&self, l: ValueId, r: ValueId) -> bool {
        l == r || self.values.get(&l) == Some(&r)
    }

    fn check_commutative(&self, l: &[ValueId], r: &[ValueId]) -> bool {
        if l.len() != r.len() {
            return false;
        }
        if l.iter().zip(r).all(|(a, b)| self.check(*a, *b)) {
            return true;
        }
        let (mut ls, mut rs): (Vec<_>, Vec<_>) = (l.to_vec(), r.to_vec());
        ls.sort();
        rs.sort();
        ls.iter().zip(&rs).all(|(a, b)| self.check(*a, *b))
    }
}

impl Body<'_> {
    pub fn equivalent(&self, l: OpId, r: OpId) -> bool {
        self.equivalent_in(l, r, &mut Equivalence::default())
    }

    fn equivalent_in(&self, l: OpId, r: OpId, eq: &mut Equivalence) -> bool {
        if l == r {
            return true;
        }
        let (a, b) = (&self[l], &self[r]);
        if a.attributes != b.attributes || a.name != b.name || a.regions.len() != b.regions.len() || a.successors.len() != b.successors.len() || a.operands.len() != b.operands.len() || a.results.len() != b.results.len() || a.properties != b.properties {
            return false;
        }
        if self.has(l, Trait::IsCommutative) {
            if !eq.check_commutative(&a.operands, &b.operands) {
                return false;
            }
        } else if !a.operands.iter().zip(&b.operands).all(|(x, y)| x == y || (self[*x].ty == self[*y].ty && eq.check(*x, *y))) {
            return false;
        }
        for (x, y) in a.results.iter().zip(&b.results) {
            if self[*x].ty != self[*y].ty {
                return false;
            }
            eq.values.insert(*x, *y);
        }
        a.regions.iter().zip(&b.regions).all(|(x, y)| self.regions_equivalent(*x, *y, eq))
    }

    fn regions_equivalent(&self, l: RegionId, r: RegionId, eq: &mut Equivalence) -> bool {
        let mut blocks: BTreeMap<BlockId, BlockId> = BTreeMap::new();
        let (lb, rb) = (&self[l].blocks, &self[r].blocks);
        if lb.len() != rb.len() {
            return false;
        }
        for (x, y) in lb.iter().zip(rb) {
            let (bx, by) = (&self[*x], &self[*y]);
            if bx.args.len() != by.args.len() || *blocks.entry(*x).or_insert(*y) != *y {
                return false;
            }
            for (p, q) in bx.args.iter().zip(&by.args) {
                if self[*p].ty != self[*q].ty {
                    return false;
                }
                eq.values.insert(*p, *q);
            }
            if self.len_ops(*x) != self.len_ops(*y) {
                return false;
            }
            for (o, p) in self.ops(*x).zip(self.ops(*y)) {
                let (o, p) = (&o, &p);
                if !self.equivalent_in(*o, *p, eq) {
                    return false;
                }
                for (s, t) in self[*o].successors.iter().zip(&self[*p].successors) {
                    if *blocks.entry(*s).or_insert(*t) != *t {
                        return false;
                    }
                }
            }
        }
        true
    }
}
