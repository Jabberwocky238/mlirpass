//! `lower-affine`, as `AffineToStandard.cpp`, the affine expression expansion of
//! `Affine/Utils/Utils.cpp` and `AffineExpandIndexOps.cpp`.

use alloc::vec;
use alloc::vec::Vec;

use mlirpass_macros::patterns;
use mlirformat::{arith, Attribute, Type};

use crate::{AffineBin, AffineExpr, AffineMap, ConversionRewriter, OpData, OpId, ValueId};

/// The affine ⇒ arith / scf / memref / vector patterns.
pub struct AffineToStd;

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

const NSW: &str = "<nsw>";
const NSW_NUW: &str = "<nsw, nuw>";

#[patterns]
impl AffineToStd {
    fn constant(cr: &mut Cr<'_, '_, '_>, v: i64) -> ValueId {
        cr.emit(&arith::Constant::new(Attribute::index(v), Type::Index))
    }

    fn binary(cr: &mut Cr<'_, '_, '_>, name: &str, a: ValueId, b: ValueId) -> ValueId {
        let ty = cr.rw.body[a].ty.clone();
        cr.build(OpData::build(name).operands(&[a, b]), ty)
    }

    fn binary_flags(cr: &mut Cr<'_, '_, '_>, name: &str, a: ValueId, b: ValueId, flags: &str) -> ValueId {
        let ty = cr.rw.body[a].ty.clone();
        cr.build(OpData::build(name).operands(&[a, b]).with("overflowFlags", Attribute::dialect("arith.overflow", flags)), ty)
    }

    fn cmp(cr: &mut Cr<'_, '_, '_>, pred: i64, a: ValueId, b: ValueId) -> ValueId {
        cr.build(OpData::build("arith.cmpi").operands(&[a, b]).with("predicate", Attribute::i64(pred)), Type::int(1))
    }

    fn select(cr: &mut Cr<'_, '_, '_>, c: ValueId, t: ValueId, f: ValueId) -> ValueId {
        let ty = cr.rw.body[t].ty.clone();
        cr.build(OpData::build("arith.select").operands(&[c, t, f]), ty)
    }

    /// `AffineApplyExpander::visit`.
    fn expand(cr: &mut Cr<'_, '_, '_>, e: &AffineExpr, dims: &[ValueId], syms: &[ValueId]) -> Option<ValueId> {
        Some(match e {
            AffineExpr::Const(c) => Self::constant(cr, *c),
            AffineExpr::Dim(d) => dims[*d as usize],
            AffineExpr::Sym(s) => syms[*s as usize],
            AffineExpr::Bin(k, l, r) => {
                if matches!(k, AffineBin::Mod | AffineBin::FloorDiv | AffineBin::CeilDiv) && r.as_const().is_some_and(|c| c <= 0) {
                    return None;
                }
                let lhs = Self::expand(cr, l, dims, syms)?;
                let rhs = Self::expand(cr, r, dims, syms)?;
                match k {
                    AffineBin::Add => Self::binary(cr, "arith.addi", lhs, rhs),
                    AffineBin::Mul => Self::binary_flags(cr, "arith.muli", lhs, rhs, NSW),
                    AffineBin::Mod => {
                        let rem = Self::binary(cr, "arith.remsi", lhs, rhs);
                        let zero = Self::constant(cr, 0);
                        let neg = Self::cmp(cr, 2, rem, zero);
                        let corrected = Self::binary(cr, "arith.addi", rem, rhs);
                        Self::select(cr, neg, corrected, rem)
                    }
                    AffineBin::FloorDiv => {
                        let zero = Self::constant(cr, 0);
                        let none = Self::constant(cr, -1);
                        let neg = Self::cmp(cr, 2, lhs, zero);
                        let nd = Self::binary(cr, "arith.subi", none, lhs);
                        let dividend = Self::select(cr, neg, nd, lhs);
                        let q = Self::binary(cr, "arith.divsi", dividend, rhs);
                        let cq = Self::binary(cr, "arith.subi", none, q);
                        Self::select(cr, neg, cq, q)
                    }
                    AffineBin::CeilDiv => {
                        let zero = Self::constant(cr, 0);
                        let one = Self::constant(cr, 1);
                        let np = Self::cmp(cr, 3, lhs, zero);
                        let negated = Self::binary(cr, "arith.subi", zero, lhs);
                        let dec = Self::binary(cr, "arith.subi", lhs, one);
                        let dividend = Self::select(cr, np, negated, dec);
                        let q = Self::binary(cr, "arith.divsi", dividend, rhs);
                        let nq = Self::binary(cr, "arith.subi", zero, q);
                        let iq = Self::binary(cr, "arith.addi", q, one);
                        Self::select(cr, np, nq, iq)
                    }
                }
            }
        })
    }

    /// `expandAffineMap`.
    fn expand_map(cr: &mut Cr<'_, '_, '_>, map: &AffineMap, operands: &[ValueId]) -> Option<Vec<ValueId>> {
        let (dims, syms) = operands.split_at(map.dims as usize);
        map.results.iter().map(|e| Self::expand(cr, e, dims, syms)).collect()
    }

    /// `buildMinMaxReductionSeq` over the expanded results.
    fn min_max(cr: &mut Cr<'_, '_, '_>, map: &AffineMap, operands: &[ValueId], max: bool) -> Option<ValueId> {
        let values = Self::expand_map(cr, map, operands)?;
        let mut v = values[0];
        for x in &values[1..] {
            v = Self::binary(cr, if max { "arith.maxsi" } else { "arith.minsi" }, v, *x);
        }
        Some(v)
    }

    fn map_of(cr: &Cr<'_, '_, '_>, op: OpId, name: &str) -> Option<AffineMap> {
        cr.rw.body.affine_map(op, name)
    }

    #[lowering("affine.apply")]
    fn apply(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let Some(map) = Self::map_of(cr, op, "map") else { return false };
        let ops = cr.rw.body[op].operands.clone();
        let Some(v) = Self::expand_map(cr, &map, &ops) else { return false };
        cr.replace_values(op, &v);
        true
    }

    #[lowering("affine.min")]
    fn min(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        Self::min_or_max(cr, op, false)
    }

    #[lowering("affine.max")]
    fn max(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        Self::min_or_max(cr, op, true)
    }

    fn min_or_max(cr: &mut Cr<'_, '_, '_>, op: OpId, max: bool) -> bool {
        let Some(map) = Self::map_of(cr, op, "map") else { return false };
        let ops = cr.rw.body[op].operands.clone();
        let Some(v) = Self::min_max(cr, &map, &ops, max) else { return false };
        cr.replace_values(op, &[v]);
        true
    }

    /// `affine.load` / `affine.store` / `affine.prefetch` / `affine.vector_load` / `affine.vector_store`.
    #[lowering("affine.load", "affine.prefetch", "affine.store", "affine.vector_load", "affine.vector_store")]
    fn access(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let name = alloc::string::String::from(&*cr.rw.body[op].name);
        let start = if name.contains("store") { 2 } else { 1 };
        let Some(map) = Self::map_of(cr, op, "map") else { return false };
        let ops = cr.rw.body[op].operands.clone();
        let Some(idx) = Self::expand_map(cr, &map, &ops[start..]) else { return false };
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

    #[lowering("affine.yield")]
    fn yield_op(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        if cr.rw.body.parent_op(op).is_some_and(|p| cr.rw.body[p].name == "scf.parallel") {
            return false;
        }
        let ops = cr.rw.body[op].operands.clone();
        cr.replace_new(op, OpData::build("scf.yield").operands(&ops), &[]);
        true
    }

    #[lowering("affine.for")]
    fn for_op(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let b = &*cr.rw.body;
        let segs = b.segments(op, "operandSegmentSizes").unwrap_or_default();
        let ops = b[op].operands.clone();
        let (lbo, rest) = ops.split_at(segs[0]);
        let (ubo, inits) = rest.split_at(segs[1]);
        let (Some(lbm), Some(ubm)) = (Self::map_of(cr, op, "lowerBoundMap"), Self::map_of(cr, op, "upperBoundMap")) else { return false };
        let step = cr.rw.body.for_step(op);
        let Some(lb) = Self::min_max(cr, &lbm, lbo, true) else { return false };
        let Some(ub) = Self::min_max(cr, &ubm, ubo, false) else { return false };
        let st = Self::constant(cr, step);
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

    #[lowering("affine.if")]
    fn if_op(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let Some(set) = cr.rw.body.integer_set(op, "condition") else { return false };
        let zero = Self::constant(cr, 0);
        let ops = cr.rw.body[op].operands.clone();
        let (dims, syms) = ops.split_at(set.dims as usize);
        let mut cond: Option<ValueId> = None;
        for (e, eq) in &set.constraints {
            let Some(v) = Self::expand(cr, e, dims, syms) else { return false };
            let c = Self::cmp(cr, if *eq { 0 } else { 5 }, v, zero);
            cond = Some(match cond {
                Some(p) => Self::binary(cr, "arith.andi", p, c),
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

    /// `computeStrides` of the index-op expansion.
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
                    Some(p) => Self::binary_flags(cr, "arith.muli", p, dynamic[di - 1], flags),
                    None => dynamic[di - 1],
                });
                di -= 1;
            } else {
                static_part *= e;
            }
            match dyn_part {
                Some(p) if static_part == 1 => out.push(p),
                _ => {
                    let mut s = Self::constant(cr, static_part);
                    if let Some(p) = dyn_part {
                        s = Self::binary_flags(cr, "arith.muli", p, s, flags);
                    }
                    out.push(s);
                }
            }
        }
        out.reverse();
        out
    }

    #[lowering("affine.delinearize_index")]
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
        let zero = Self::constant(cr, 0);
        let mut results = vec![Self::binary(cr, "arith.floordivsi", idx, strides[0])];
        let modterm = |cr: &mut Cr<'_, '_, '_>, s: ValueId| {
            let rem = Self::binary(cr, "arith.remsi", idx, s);
            let neg = Self::cmp(cr, 2, rem, zero);
            let corrected = Self::binary_flags(cr, "arith.addi", rem, s, NSW);
            Self::select(cr, neg, corrected, rem)
        };
        for i in 0..strides.len() - 1 {
            let m = modterm(cr, strides[i]);
            results.push(Self::binary(cr, "arith.divsi", m, strides[i + 1]));
        }
        let last = *strides.last().expect("strides");
        results.push(modterm(cr, last));
        cr.replace_values(op, &results);
        true
    }

    /// `numEnclosingInvariantLoops` of operand `v` of `op`.
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

    #[lowering("affine.linearize_index")]
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
            let v = Self::binary_flags(cr, "arith.muli", *i, *s, NSW);
            scaled.push((v, Self::invariant_loops(cr, op, *i)));
        }
        let last = *multi.last().expect("an index");
        scaled.push((last, Self::invariant_loops(cr, op, last)));
        scaled.sort_by(|a, b| b.1.cmp(&a.1));
        let mut r = scaled[0].0;
        for (v, _) in &scaled[1..] {
            r = Self::binary_flags(cr, "arith.addi", r, *v, NSW);
        }
        cr.replace_values(op, &[r]);
        true
    }

}
