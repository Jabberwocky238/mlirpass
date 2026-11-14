use alloc::vec;
use alloc::vec::Vec;

use crate::patterns;
use mlirformat::{arith, Attribute, Type};

use crate::{AffineBin, AffineExpr, AffineMap, Build, ConversionRewriter, OpData, OpId, TypedOp, ValueId};

pub trait AffineExpand<'a>: Build<'a> {
    fn index_constant(&mut self, v: i64) -> ValueId {
        let (data, types) = arith::Constant::new(Attribute::index(v), Type::Index).split();
        let o = self.make(data, &types);
        self.body()[o].results[0]
    }

    fn arith2(&mut self, name: &str, a: ValueId, b: ValueId) -> ValueId {
        let ty = self.body()[a].ty.clone();
        self.make1(OpData::build(name).operands(&[a, b]), ty)
    }

    fn arith2_flags(&mut self, name: &str, a: ValueId, b: ValueId, flags: &str) -> ValueId {
        let ty = self.body()[a].ty.clone();
        self.make1(OpData::build(name).operands(&[a, b]).with("overflowFlags", Attribute::dialect("arith.overflow", flags)), ty)
    }

    fn cmpi(&mut self, pred: i64, a: ValueId, b: ValueId) -> ValueId {
        self.make1(OpData::build("arith.cmpi").operands(&[a, b]).with("predicate", Attribute::i64(pred)), Type::int(1))
    }

    fn select(&mut self, c: ValueId, t: ValueId, f: ValueId) -> ValueId {
        let ty = self.body()[t].ty.clone();
        self.make1(OpData::build("arith.select").operands(&[c, t, f]), ty)
    }

    fn expand(&mut self, e: &AffineExpr, dims: &[ValueId], syms: &[ValueId]) -> Option<ValueId> {
        Some(match e {
            AffineExpr::Const(c) => self.index_constant(*c),
            AffineExpr::Dim(d) => dims[*d as usize],
            AffineExpr::Sym(s) => syms[*s as usize],
            AffineExpr::Bin(k, l, r) => {
                if matches!(k, AffineBin::Mod | AffineBin::FloorDiv | AffineBin::CeilDiv) && r.as_const().is_some_and(|c| c <= 0) {
                    return None;
                }
                let lhs = self.expand(l, dims, syms)?;
                let rhs = self.expand(r, dims, syms)?;
                match k {
                    AffineBin::Add => self.arith2("arith.addi", lhs, rhs),
                    AffineBin::Mul => self.arith2_flags("arith.muli", lhs, rhs, NSW),
                    AffineBin::Mod => {
                        let rem = self.arith2("arith.remsi", lhs, rhs);
                        let zero = self.index_constant(0);
                        let neg = self.cmpi(2, rem, zero);
                        let corrected = self.arith2("arith.addi", rem, rhs);
                        self.select(neg, corrected, rem)
                    }
                    AffineBin::FloorDiv => {
                        let zero = self.index_constant(0);
                        let none = self.index_constant(-1);
                        let neg = self.cmpi(2, lhs, zero);
                        let nd = self.arith2("arith.subi", none, lhs);
                        let dividend = self.select(neg, nd, lhs);
                        let q = self.arith2("arith.divsi", dividend, rhs);
                        let cq = self.arith2("arith.subi", none, q);
                        self.select(neg, cq, q)
                    }
                    AffineBin::CeilDiv => {
                        let zero = self.index_constant(0);
                        let one = self.index_constant(1);
                        let np = self.cmpi(3, lhs, zero);
                        let negated = self.arith2("arith.subi", zero, lhs);
                        let dec = self.arith2("arith.subi", lhs, one);
                        let dividend = self.select(np, negated, dec);
                        let q = self.arith2("arith.divsi", dividend, rhs);
                        let nq = self.arith2("arith.subi", zero, q);
                        let iq = self.arith2("arith.addi", q, one);
                        self.select(np, nq, iq)
                    }
                }
            }
        })
    }

    fn expand_map(&mut self, map: &AffineMap, operands: &[ValueId]) -> Option<Vec<ValueId>> {
        let (dims, syms) = operands.split_at(map.dims as usize);
        map.results.iter().map(|e| self.expand(e, dims, syms)).collect()
    }

    fn min_max(&mut self, map: &AffineMap, operands: &[ValueId], max: bool) -> Option<ValueId> {
        let values = self.expand_map(map, operands)?;
        let mut v = values[0];
        for x in &values[1..] {
            v = self.arith2(if max { "arith.maxsi" } else { "arith.minsi" }, v, *x);
        }
        Some(v)
    }
}

impl<'a, B: Build<'a> + ?Sized> AffineExpand<'a> for B {}

pub struct AffineToStd;

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

const NSW: &str = "<nsw>";
const NSW_NUW: &str = "<nsw, nuw>";

#[patterns]
impl AffineToStd {
    fn map_of(cr: &Cr<'_, '_, '_>, op: OpId, name: &str) -> Option<AffineMap> {
        cr.rw.body.affine_map(op, name)
    }

    #[convert("affine.apply")]
    fn apply(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let Some(map) = Self::map_of(cr, op, "map") else { return false };
        let ops = cr.rw.body[op].operands.clone();
        let Some(v) = cr.expand_map(&map, &ops) else { return false };
        cr.replace_values(op, &v);
        true
    }

    #[convert("affine.min")]
    fn min(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        Self::min_or_max(cr, op, false)
    }

    #[convert("affine.max")]
    fn max(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        Self::min_or_max(cr, op, true)
    }

    fn min_or_max(cr: &mut Cr<'_, '_, '_>, op: OpId, max: bool) -> bool {
        let Some(map) = Self::map_of(cr, op, "map") else { return false };
        let ops = cr.rw.body[op].operands.clone();
        let Some(v) = cr.min_max(&map, &ops, max) else { return false };
        cr.replace_values(op, &[v]);
        true
    }

    #[convert("affine.load", "affine.prefetch", "affine.store", "affine.vector_load", "affine.vector_store")]
    fn access(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let name = alloc::string::String::from(&*cr.rw.body[op].name);
        let start = if name.contains("store") { 2 } else { 1 };
        let Some(map) = Self::map_of(cr, op, "map") else { return false };
        let ops = cr.rw.body[op].operands.clone();
        let Some(idx) = cr.expand_map(&map, &ops[start..]) else { return false };
        let mut operands = ops[..start].to_vec();
        operands.extend(idx);
        let types = cr.rw.body.types(&cr.rw.body[op].results.clone());
        let mut data = match &*name {
            "affine.load" => OpData::build("memref.load"),
            "affine.store" => OpData::build("memref.store"),
            "affine.vector_load" => OpData::build("vector.load"),
            "affine.vector_store" => OpData::build("vector.store"),
            _ => {
                let b = &cr.rw.body[op];
                OpData::build("memref.prefetch").with("isWrite", b.get("isWrite").cloned().unwrap_or(Attribute::Bool(false))).with("localityHint", b.get("localityHint").cloned().unwrap_or(Attribute::Unit)).with("isDataCache", b.get("isDataCache").cloned().unwrap_or(Attribute::Bool(true)))
            }
        };
        data = data.operands(&operands);
        cr.replace_new(op, data, &types);
        true
    }

    #[convert("affine.yield")]
    fn yield_op(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        if cr.rw.body.parent_op(op).is_some_and(|p| cr.rw.body[p].name == "scf.parallel") {
            return false;
        }
        let ops = cr.rw.body[op].operands.clone();
        cr.replace_new(op, OpData::build("scf.yield").operands(&ops), &[]);
        true
    }

    #[convert("affine.for")]
    fn for_op(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let b = &*cr.rw.body;
        let segs = b.segments(op, "operandSegmentSizes").unwrap_or_default();
        let ops = b[op].operands.clone();
        let (lbo, rest) = ops.split_at(segs[0]);
        let (ubo, inits) = rest.split_at(segs[1]);
        let (Some(lbm), Some(ubm)) = (Self::map_of(cr, op, "lowerBoundMap"), Self::map_of(cr, op, "upperBoundMap")) else { return false };
        let step = cr.rw.body.for_step(op);
        let Some(lb) = cr.min_max(&lbm, lbo, true) else { return false };
        let Some(ub) = cr.min_max(&ubm, ubo, false) else { return false };
        let st = cr.index_constant(step);
        let mut operands = vec![lb, ub, st];
        operands.extend(inits);
        let types = cr.rw.body.types(&cr.rw.body[op].results.clone());
        let new = cr.rw.create_with(OpData::build("scf.for").operands(&operands), &types, |b, f| {
            b.add_region(f);
        });
        let (from, into) = (cr.rw.body[op].regions[0], cr.rw.body[new].regions[0]);
        cr.inline_region(from, into, None);
        let r = cr.rw.body[new].results.clone();
        cr.replace_values(op, &r);
        true
    }

    #[convert("affine.if")]
    fn if_op(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let Some(set) = cr.rw.body.integer_set(op, "condition") else { return false };
        let zero = cr.index_constant(0);
        let ops = cr.rw.body[op].operands.clone();
        let (dims, syms) = ops.split_at(set.dims as usize);
        let mut cond: Option<ValueId> = None;
        for (e, eq) in &set.constraints {
            let Some(v) = cr.expand(e, dims, syms) else { return false };
            let c = cr.cmpi(if *eq { 0 } else { 5 }, v, zero);
            cond = Some(match cond {
                Some(p) => cr.arith2("arith.andi", p, c),
                None => c,
            });
        }
        let cond = match cond {
            Some(c) => c,
            None => cr.emit(&arith::Constant::new(Attribute::Bool(true), Type::int(1))),
        };
        let types = cr.rw.body.types(&cr.rw.body[op].results.clone());
        let new = cr.rw.create_with(OpData::build("scf.if").operands(&[cond]), &types, |b, f| {
            b.add_region(f);
            b.add_region(f);
        });
        for i in 0..2 {
            let (from, into) = (cr.rw.body[op].regions[i], cr.rw.body[new].regions[i]);
            cr.inline_region(from, into, None);
        }
        let r = cr.rw.body[new].results.clone();
        cr.replace_values(op, &r);
        true
    }

    #[convert("affine.dma_start")]
    fn dma_start(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let maps = ["src_map", "dst_map", "tag_map"].map(|n| Self::map_of(cr, op, n));
        let [Some(src), Some(dst), Some(tag)] = maps else { return false };
        let ops = cr.rw.body[op].operands.clone();
        let inputs = |m: &AffineMap| (m.dims + m.syms) as usize;
        let src_at = 0;
        let dst_at = src_at + 1 + inputs(&src);
        let tag_at = dst_at + 1 + inputs(&dst);
        let num_at = tag_at + 1 + inputs(&tag);
        let Some(si) = cr.expand_map(&src, &ops[src_at + 1..dst_at]) else { return false };
        let Some(di) = cr.expand_map(&dst, &ops[dst_at + 1..tag_at]) else { return false };
        let Some(ti) = cr.expand_map(&tag, &ops[tag_at + 1..num_at]) else { return false };
        let mut operands = vec![ops[src_at]];
        operands.extend(si);
        operands.push(ops[dst_at]);
        operands.extend(di);
        operands.push(ops[num_at]);
        operands.push(ops[tag_at]);
        operands.extend(ti);
        operands.extend_from_slice(&ops[num_at + 1..]);
        cr.replace_new(op, OpData::build("memref.dma_start").operands(&operands), &[]);
        true
    }

    #[convert("affine.dma_wait")]
    fn dma_wait(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let Some(tag) = Self::map_of(cr, op, "tag_map") else { return false };
        let ops = cr.rw.body[op].operands.clone();
        let n = (tag.dims + tag.syms) as usize;
        let Some(ti) = cr.expand_map(&tag, &ops[1..1 + n]) else { return false };
        let mut operands = vec![ops[0]];
        operands.extend(ti);
        operands.extend_from_slice(&ops[1 + n..]);
        cr.replace_new(op, OpData::build("memref.dma_wait").operands(&operands), &[]);
        true
    }

    #[convert("affine.parallel")]
    fn parallel(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let (Some(lbm), Some(ubm)) = (Self::map_of(cr, op, "lowerBoundsMap"), Self::map_of(cr, op, "upperBoundsMap")) else { return false };
        let b = &*cr.rw.body;
        let groups = |n: &str| b[op].get(n).and_then(|a| mlirformat::Const::try_from(a).ok()).and_then(|c| c.ints());
        let ints = |n: &str| match b[op].get(n) {
            Some(Attribute::Array(xs)) => xs.iter().map(|x| if let Attribute::Int { lit, .. } = x { lit.parse::<i64>().ok() } else { None }).collect::<Option<Vec<_>>>(),
            _ => None,
        };
        let (Some(lg), Some(ug), Some(steps), Some(reductions)) = (groups("lowerBoundsGroups"), groups("upperBoundsGroups"), ints("steps"), ints("reductions")) else { return false };
        let Some(kinds) = reductions.iter().map(|k| Reduction::of(*k)).collect::<Option<Vec<_>>>() else { return false };
        let ops = b[op].operands.clone();
        let (lbo, ubo) = ops.split_at((lbm.dims + lbm.syms) as usize);
        let sub = |m: &AffineMap, groups: &[i64], i: usize| {
            let start: i64 = groups[..i].iter().sum();
            AffineMap { dims: m.dims, syms: m.syms, results: m.results[start as usize..(start + groups[i]) as usize].to_vec() }
        };
        let (mut lbs, mut ubs) = (Vec::new(), Vec::new());
        for i in 0..lg.len() {
            let Some(l) = cr.min_max(&sub(&lbm, &lg, i), lbo, true) else { return false };
            lbs.push(l);
            let Some(u) = cr.min_max(&sub(&ubm, &ug, i), ubo, false) else { return false };
            ubs.push(u);
        }
        let steps: Vec<ValueId> = steps.iter().map(|s| cr.index_constant(*s)).collect();
        let types = cr.rw.body.types(&cr.rw.body[op].results.clone());
        let mut inits = Vec::new();
        for (k, ty) in kinds.iter().zip(&types) {
            let Some(v) = k.identity(ty) else { return false };
            inits.push(cr.emit(&arith::Constant::new(v, ty.clone())));
        }
        let n = lbs.len();
        let mut operands = lbs;
        operands.extend(ubs);
        operands.extend(steps);
        operands.extend(&inits);
        let new = cr.rw.create_with(OpData::build("scf.parallel").operands(&operands).segments(&[n, n, n, inits.len()]), &types, |b, f| {
            b.add_region(f);
        });
        let (from, into) = (cr.rw.body[op].regions[0], cr.rw.body[new].regions[0]);
        cr.inline_region(from, into, None);
        let block = cr.rw.body[into].blocks[0];
        let Some(term) = cr.terminator(block) else { return false };
        let yielded = cr.rw.body[term].operands.clone();
        cr.rw.set_before(term);
        let reduce = cr.rw.create_with(OpData::build("scf.reduce").operands(&yielded), &[], |b, r| {
            for v in &yielded {
                let region = b.add_region(r);
                let ty = b[*v].ty.clone();
                b.add_block(region, &[(ty.clone(), None), (ty, None)]);
            }
        });
        for (i, k) in kinds.iter().enumerate() {
            let region = cr.rw.body[reduce].regions[i];
            let blk = cr.rw.body[region].blocks[0];
            let (l, r) = (cr.rw.body[blk].args[0], cr.rw.body[blk].args[1]);
            cr.rw.set_end(blk);
            let v = cr.arith2(k.op(), l, r);
            cr.rw.create(OpData::build("scf.reduce.return").operands(&[v]), &[]);
        }
        cr.erase(term);
        let r = cr.rw.body[new].results.clone();
        cr.replace_values(op, &r);
        true
    }

    fn strides(cr: &mut Cr<'_, '_, '_>, dynamic: &[ValueId], basis: &[i64], non_negative: bool) -> Vec<ValueId> {
        if basis.is_empty() {
            return Vec::new();
        }
        let flags = if non_negative { NSW_NUW } else { NSW };
        let mut out = Vec::new();
        let mut di = dynamic.len();
        let mut dyn_part: Option<ValueId> = None;
        let mut static_part = 1i64;
        for e in basis.iter().rev() {
            if *e == i64::MIN {
                dyn_part = Some(match dyn_part {
                    Some(p) => cr.arith2_flags("arith.muli", p, dynamic[di - 1], flags),
                    None => dynamic[di - 1],
                });
                di -= 1;
            } else {
                static_part *= e;
            }
            match dyn_part {
                Some(p) if static_part == 1 => out.push(p),
                _ => {
                    let mut s = cr.index_constant(static_part);
                    if let Some(p) = dyn_part {
                        s = cr.arith2_flags("arith.muli", p, s, flags);
                    }
                    out.push(s);
                }
            }
        }
        out.reverse();
        out
    }

    #[convert("affine.delinearize_index")]
    fn delinearize(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let b = &*cr.rw.body;
        let idx = b[op].operands[0];
        let n = b[op].results.len();
        let mut basis = b.dense_i64(op, "static_basis");
        if n == basis.len() {
            basis.remove(0);
        }
        if n == 1 {
            cr.replace_values(op, &[idx]);
            return true;
        }
        let dynamic = b[op].operands[1..].to_vec();
        let strides = Self::strides(cr, &dynamic, &basis, true);
        let zero = cr.index_constant(0);
        let mut results = vec![cr.arith2("arith.floordivsi", idx, strides[0])];
        let modterm = |cr: &mut Cr<'_, '_, '_>, s: ValueId| {
            let rem = cr.arith2("arith.remsi", idx, s);
            let neg = cr.cmpi(2, rem, zero);
            let corrected = cr.arith2_flags("arith.addi", rem, s, NSW);
            cr.select(neg, corrected, rem)
        };
        for i in 0..strides.len() - 1 {
            let m = modterm(cr, strides[i]);
            results.push(cr.arith2("arith.divsi", m, strides[i + 1]));
        }
        let last = *strides.last().expect("strides");
        results.push(modterm(cr, last));
        cr.replace_values(op, &results);
        true
    }

    fn invariant_loops(cr: &Cr<'_, '_, '_>, op: OpId, v: ValueId) -> i64 {
        let b = &*cr.rw.body;
        let def_owner = match b[v].def {
            crate::Def::Result(o, _) => b.parent_op(o),
            crate::Def::Arg(blk, _) => b.block_owner(blk),
        };
        let mut n = 0;
        let mut cur = op;
        loop {
            let mut p = b.parent_op(cur);
            while let Some(x) = p.filter(|x| b.loop_regions(*x).is_none()) {
                p = b.parent_op(x);
            }
            let Some(l) = p else { break };
            if def_owner.is_some_and(|o| b.is_ancestor(l, o)) {
                break;
            }
            cur = l;
            n += 1;
        }
        n
    }

    #[convert("affine.linearize_index")]
    fn linearize(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let b = &*cr.rw.body;
        let segs = b.segments(op, "operandSegmentSizes").unwrap_or_default();
        let multi = b[op].operands[..segs[0]].to_vec();
        if multi.is_empty() {
            cr.replace_by(op, &arith::Constant::new(Attribute::index(0), Type::Index));
            return true;
        }
        let dynamic = b[op].operands[segs[0]..].to_vec();
        let mut basis = b.dense_i64(op, "static_basis");
        if multi.len() == basis.len() {
            basis.remove(0);
        }
        let disjoint = matches!(b[op].get("disjoint"), Some(Attribute::Unit | Attribute::Bool(true)));
        let strides = Self::strides(cr, &dynamic, &basis, disjoint);
        let mut scaled = Vec::new();
        for (s, i) in strides.iter().zip(&multi) {
            let v = cr.arith2_flags("arith.muli", *i, *s, NSW);
            scaled.push((v, Self::invariant_loops(cr, op, *i)));
        }
        let last = *multi.last().expect("an index");
        scaled.push((last, Self::invariant_loops(cr, op, last)));
        scaled.sort_by(|a, b| b.1.cmp(&a.1));
        let mut r = scaled[0].0;
        for (v, _) in &scaled[1..] {
            r = cr.arith2_flags("arith.addi", r, *v, NSW);
        }
        cr.replace_values(op, &[r]);
        true
    }
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum Reduction {
    AddF,
    AddI,
    AndI,
    MaximumF,
    MaxNumF,
    MaxS,
    MaxU,
    MinimumF,
    MinNumF,
    MinS,
    MinU,
    MulF,
    MulI,
    OrI,
    XorI,
}

impl Reduction {
    const TABLE: [(i64, Reduction, &str); 15] = [
        (0, Reduction::AddF, "arith.addf"),
        (1, Reduction::AddI, "arith.addi"),
        (2, Reduction::AndI, "arith.andi"),
        (4, Reduction::MaximumF, "arith.maximumf"),
        (5, Reduction::MaxNumF, "arith.maxnumf"),
        (6, Reduction::MaxS, "arith.maxsi"),
        (7, Reduction::MaxU, "arith.maxui"),
        (8, Reduction::MinimumF, "arith.minimumf"),
        (9, Reduction::MinNumF, "arith.minnumf"),
        (10, Reduction::MinS, "arith.minsi"),
        (11, Reduction::MinU, "arith.minui"),
        (12, Reduction::MulF, "arith.mulf"),
        (13, Reduction::MulI, "arith.muli"),
        (14, Reduction::OrI, "arith.ori"),
        (15, Reduction::XorI, "arith.xori"),
    ];

    fn of(k: i64) -> Option<Self> {
        Self::TABLE.iter().find(|(n, _, _)| *n == k).map(|(_, r, _)| *r)
    }

    fn op(self) -> &'static str {
        Self::TABLE.iter().find(|(_, r, _)| *r == self).map(|(_, _, n)| *n).expect("in the table")
    }

    fn identity<'a>(self, ty: &Type<'a>) -> Option<Attribute<'a>> {
        use mlirformat::{ApFloat, ApInt, Const, Scalar};
        let float = |f: fn(mlirformat::FloatKind) -> Option<ApFloat>| match ty {
            Type::Float(k) => f(*k).map(|v| Const::scalar(Scalar::Float(v), ty.clone()).into()),
            _ => None,
        };
        let int = |f: fn(u32) -> ApInt| ty.int_width().map(|(w, _)| Const::scalar(Scalar::Int(f(w)), ty.clone()).into());
        match self {
            Reduction::AddF | Reduction::AddI | Reduction::MaxU | Reduction::OrI | Reduction::XorI => Scalar::zero(ty).map(|z| Const::scalar(z, ty.clone()).into()),
            Reduction::AndI | Reduction::MinU => int(|w| ApInt::new(w, -1)),
            Reduction::MaxS => int(|w| ApInt::from_bits(w, 1u128 << (w - 1))),
            Reduction::MinS => int(|w| ApInt::from_bits(w, (1u128 << (w - 1)) - 1)),
            Reduction::MulI => int(|w| ApInt::new(w, 1)),
            Reduction::MulF => float(|k| ApFloat::from_f64(k, 1.0)),
            Reduction::MaximumF => float(|k| ApFloat::from_f64(k, f64::NEG_INFINITY)),
            Reduction::MinimumF => float(|k| ApFloat::from_f64(k, f64::INFINITY)),
            Reduction::MaxNumF => float(|k| Some(ApFloat::nan(k).neg())),
            Reduction::MinNumF => float(|k| Some(ApFloat::nan(k))),
        }
    }
}
