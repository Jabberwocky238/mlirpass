//! `affine`: folds and canonicalization patterns, as `AffineOps.cpp`.

use alloc::collections::BTreeMap;
use alloc::format;
use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{arith, Attribute, Type};

use crate::{AffineExpr, AffineMap, Body, Const, Def, Fold, Folded, IntegerSet, OpData, OpId, RegionId, Trait, ValueId};

/// `AffineDialect::materializeConstant`.
pub fn materialize<'a>(value: &Attribute<'a>, ty: &Type<'a>) -> Option<OpData<'a>> {
    super::arith::materialize(value, ty)
}

/// An `affine_map<...>` attribute.
pub fn map_attr<'a>(m: &AffineMap) -> Attribute<'a> {
    Attribute::Builtin { name: "affine_map".into(), body: format!("<{m}>").into(), ty: None }
}

/// An `affine_set<...>` attribute.
pub fn set_attr<'a>(s: &IntegerSet) -> Attribute<'a> {
    Attribute::Builtin { name: "affine_set".into(), body: format!("<{s}>").into(), ty: None }
}

/// A map or a set, for the operand canonicalizations shared by both.
pub trait MapOrSet: Clone {
    fn dims(&self) -> u32;
    fn syms(&self) -> u32;
    fn exprs(&self) -> Vec<&AffineExpr>;
    fn replace(&self, dims: &[AffineExpr], syms: &[AffineExpr], nd: u32, ns: u32) -> Self;
}

impl MapOrSet for AffineMap {
    fn dims(&self) -> u32 {
        self.dims
    }

    fn syms(&self) -> u32 {
        self.syms
    }

    fn exprs(&self) -> Vec<&AffineExpr> {
        self.results.iter().collect()
    }

    fn replace(&self, dims: &[AffineExpr], syms: &[AffineExpr], nd: u32, ns: u32) -> Self {
        AffineMap::replace(self, dims, syms, nd, ns)
    }
}

impl MapOrSet for IntegerSet {
    fn dims(&self) -> u32 {
        self.dims
    }

    fn syms(&self) -> u32 {
        self.syms
    }

    fn exprs(&self) -> Vec<&AffineExpr> {
        self.constraints.iter().map(|c| &c.0).collect()
    }

    fn replace(&self, dims: &[AffineExpr], syms: &[AffineExpr], nd: u32, ns: u32) -> Self {
        IntegerSet { dims: nd, syms: ns, constraints: self.constraints.iter().map(|(e, eq)| (e.replace(dims, syms), *eq)).collect() }
    }
}

impl AffineMap {
    /// `AffineMap::replace(expr, replacement, numDims, numSymbols)`.
    pub fn replace_expr(&self, from: &AffineExpr, to: &AffineExpr, nd: u32, ns: u32) -> Self {
        Self { dims: nd, syms: ns, results: self.results.iter().map(|r| r.replace_sub(from, to)).collect() }
    }

    /// `shiftDims(n)` then `shiftSymbols(m)`.
    pub fn shifted(&self, nd: u32, ns: u32) -> Self {
        let dims: Vec<AffineExpr> = (0..self.dims).map(|d| AffineExpr::Dim(d + nd)).collect();
        let syms: Vec<AffineExpr> = (0..self.syms).map(|s| AffineExpr::Sym(s + ns)).collect();
        self.replace(&dims, &syms, self.dims + nd, self.syms + ns)
    }

    /// `partialConstantFold` / `constantFold`: the results when all fold, `Err` on poison.
    pub fn constant_fold(&self, consts: &[Option<i64>]) -> Result<Option<Vec<i64>>, ()> {
        let mut out = Vec::new();
        for r in &self.results {
            match r.const_eval(self.dims, consts)? {
                Some(v) => out.push(v),
                None => return Ok(None),
            }
        }
        Ok(Some(out))
    }
}

impl AffineExpr {
    /// `replace(DenseMap{from: to})`.
    pub fn replace_sub(&self, from: &AffineExpr, to: &AffineExpr) -> AffineExpr {
        if self == from {
            return to.clone();
        }
        match self {
            AffineExpr::Bin(k, l, r) => {
                let (nl, nr) = (l.replace_sub(from, to), r.replace_sub(from, to));
                if nl == **l && nr == **r {
                    return self.clone();
                }
                AffineExpr::binary(*k, nl, nr)
            }
            _ => self.clone(),
        }
    }

    /// `AffineExprConstantFolder`: `Err` on poison (division by zero, mod by < 1).
    pub fn const_eval(&self, dims: u32, consts: &[Option<i64>]) -> Result<Option<i64>, ()> {
        use crate::AffineBin as B;
        Ok(match self {
            AffineExpr::Const(c) => Some(*c),
            AffineExpr::Dim(d) => consts.get(*d as usize).copied().flatten(),
            AffineExpr::Sym(s) => consts.get((dims + s) as usize).copied().flatten(),
            AffineExpr::Bin(k, l, r) => {
                let (Some(a), Some(b)) = (l.const_eval(dims, consts)?, r.const_eval(dims, consts)?) else { return Ok(None) };
                match k {
                    B::Add => Some(a.wrapping_add(b)),
                    B::Mul => Some(a.wrapping_mul(b)),
                    B::Mod => {
                        if b < 1 {
                            return Err(());
                        }
                        Some(a.rem_euclid(b))
                    }
                    B::FloorDiv | B::CeilDiv => {
                        if b == 0 {
                            return Err(());
                        }
                        let q = a / b;
                        let exact = a % b == 0;
                        Some(match k {
                            B::FloorDiv if !exact && ((a < 0) != (b < 0)) => q - 1,
                            B::CeilDiv if !exact && ((a < 0) == (b < 0)) => q + 1,
                            _ => q,
                        })
                    }
                }
            }
        })
    }
}

impl<'a> Body<'a> {
    /// The affine map in attribute `name` of `op`.
    pub fn affine_map(&self, op: OpId, name: &str) -> Option<AffineMap> {
        match self[op].get(name)? {
            Attribute::Builtin { name, body, .. } if name == "affine_map" => AffineMap::parse(body),
            _ => None,
        }
    }

    pub fn integer_set(&self, op: OpId, name: &str) -> Option<IntegerSet> {
        match self[op].get(name)? {
            Attribute::Builtin { name, body, .. } if name == "affine_set" => IntegerSet::parse(body),
            _ => None,
        }
    }

    fn parent_region_of(&self, v: ValueId) -> Option<RegionId> {
        match self[v].def {
            Def::Result(o, _) => self[o].parent.and_then(|b| self[b].parent),
            Def::Arg(b, _) => self[b].parent,
        }
    }

    /// `isTopLevelValue`: defined at the top level of an affine scope.
    pub fn is_top_level_value(&self, v: ValueId) -> bool {
        let owner = match self[v].def {
            Def::Arg(b, _) => self.block_owner(b),
            Def::Result(o, _) => self.parent_op(o),
        };
        owner.is_some_and(|p| self.has(p, Trait::AffineScope))
    }

    /// `getAffineScope`: the region of the closest enclosing affine scope.
    pub fn affine_scope(&self, op: OpId) -> Option<RegionId> {
        let mut cur = op;
        while let Some(p) = self.parent_op(cur) {
            if self.has(p, Trait::AffineScope) {
                return self[cur].parent.and_then(|b| self[b].parent);
            }
            cur = p;
        }
        None
    }

    fn is_index(&self, v: ValueId) -> bool {
        matches!(self[v].ty, Type::Index)
    }

    /// `affine.for` / `affine.parallel` induction variable owner.
    pub fn affine_iv_owner(&self, v: ValueId) -> Option<OpId> {
        let Def::Arg(b, _) = self[v].def else { return None };
        let o = self.block_owner(b)?;
        matches!(&*self[o].name, "affine.for" | "affine.parallel").then_some(o)
    }

    pub fn affine_for_iv_owner(&self, v: ValueId) -> Option<OpId> {
        self.affine_iv_owner(v).filter(|o| self[*o].name == "affine.for")
    }

    /// `isValidDim(value)`.
    pub fn is_valid_dim(&self, v: ValueId) -> bool {
        if !self.is_index(v) {
            return false;
        }
        if let Def::Result(o, _) = self[v].def {
            return self.is_valid_dim_in(v, self.affine_scope(o));
        }
        if self.affine_iv_owner(v).is_some() {
            return true;
        }
        let Def::Arg(b, _) = self[v].def else { unreachable!() };
        self.block_owner(b).is_some_and(|p| self.has(p, Trait::AffineScope))
    }

    /// `isValidDim(value, region)`.
    pub fn is_valid_dim_in(&self, v: ValueId, region: Option<RegionId>) -> bool {
        if !self.is_index(v) {
            return false;
        }
        if self.is_valid_symbol_in(v, region) {
            return true;
        }
        let Def::Result(op, _) = self[v].def else { return self.affine_iv_owner(v).is_some() };
        match &*self[op].name {
            "affine.apply" | "affine.delinearize_index" | "affine.linearize_index" => self[op].operands.iter().all(|o| self.is_valid_dim_in(*o, region)),
            "memref.dim" | "tensor.dim" => self.is_top_level_value(self[op].operands[0]),
            _ => false,
        }
    }

    /// `isValidSymbol(value)`.
    pub fn is_valid_symbol(&self, v: ValueId) -> bool {
        if !self.is_index(v) {
            return false;
        }
        if self.is_top_level_value(v) {
            return true;
        }
        match self[v].def {
            Def::Result(o, _) => self.is_valid_symbol_in(v, self.affine_scope(o)),
            Def::Arg(..) => false,
        }
    }

    fn top_level_or_above(&self, v: ValueId, region: RegionId) -> bool {
        let pr = self.parent_region_of(v);
        let mut r = Some(region);
        while let Some(reg) = r {
            if pr == Some(reg) {
                return true;
            }
            let op = self[reg].parent;
            if self.has(op, Trait::IsIsolatedFromAbove) {
                break;
            }
            r = self[op].parent.and_then(|b| self[b].parent);
        }
        false
    }

    /// `isValidSymbol(value, region)`.
    pub fn is_valid_symbol_in(&self, v: ValueId, region: Option<RegionId>) -> bool {
        if !self.is_index(v) {
            return false;
        }
        if let Some(r) = region
            && self.top_level_or_above(v, r)
        {
            return true;
        }
        let Def::Result(d, _) = self[v].def else { return false };
        if self.has(d, Trait::ConstantLike) {
            return true;
        }
        if self.is_pure(d) && self[d].operands.iter().all(|o| self.is_valid_symbol_in(*o, region)) {
            return true;
        }
        if matches!(&*self[d].name, "memref.dim" | "tensor.dim") {
            return self.dim_op_valid_symbol(d, region);
        }
        false
    }

    fn dim_op_valid_symbol(&self, d: OpId, region: Option<RegionId>) -> bool {
        let shaped = self[d].operands[0];
        if self.is_top_level_value(shaped) {
            return true;
        }
        let Def::Result(mut op, _) = self[shaped].def else { return false };
        let Some(index) = self.const_index(self[d].operands[1]) else { return false };
        while self[op].name == "memref.cast" {
            let s = self[op].operands[0];
            if crate::attr::shape_of(&self[s].ty).is_none() {
                return false;
            }
            let Def::Result(o, _) = self[s].def else { return false };
            op = o;
        }
        if !matches!(&*self[op].name, "memref.view" | "memref.subview" | "memref.alloc") {
            return false;
        }
        let rt = &self[self[op].results[0]].ty;
        let Some(shape) = crate::attr::shape_of(rt) else { return false };
        let Some(dim) = shape.get(index as usize) else { return false };
        if matches!(dim, mlirformat::Dim::Static(_)) {
            return true;
        }
        let pos = shape[..index as usize].iter().filter(|d| !matches!(d, mlirformat::Dim::Static(_))).count();
        let sizes = match &*self[op].name {
            "memref.alloc" => self[op].operands.clone(),
            "memref.view" => self[op].operands[2..].to_vec(),
            _ => {
                let segs = self.segments(op, "operandSegmentSizes").unwrap_or_default();
                let start: usize = segs.iter().take(2).sum();
                self[op].operands[start..start + segs.get(2).copied().unwrap_or(0)].to_vec()
            }
        };
        sizes.get(pos).is_some_and(|s| self.is_valid_symbol_in(*s, region))
    }

    /// `getConstantIntValue` of an index or integer.
    pub fn const_index(&self, v: ValueId) -> Option<i64> {
        let c = Const::try_from(&self.constant_of(v)?).ok().filter(|c| !c.elements)?;
        Some(c.as_int()?.signed() as i64)
    }

    // ---- map and operand canonicalization ---------------------------------------------

    /// `canonicalizePromotedSymbols`: dims that are valid symbols become symbols.
    fn promote_symbols<M: MapOrSet>(&self, m: &mut M, ops: &mut Vec<ValueId>) {
        if ops.is_empty() {
            return;
        }
        let (nd, ns) = (m.dims(), m.syms());
        let mut result = Vec::new();
        let mut promoted = Vec::new();
        let mut remap = Vec::new();
        let mut next_dim = 0;
        for (i, v) in ops.iter().enumerate() {
            if (i as u32) < nd {
                if self.is_valid_symbol(*v) {
                    remap.push(AffineExpr::Sym(ns + promoted.len() as u32));
                    promoted.push(*v);
                } else {
                    remap.push(AffineExpr::Dim(next_dim));
                    next_dim += 1;
                    result.push(*v);
                }
            } else {
                result.push(*v);
            }
        }
        let n = promoted.len() as u32;
        result.extend(promoted);
        *ops = result;
        *m = m.replace(&remap, &[], next_dim, ns + n);
    }

    /// `legalizeDemotedDims`: symbols that are only valid dims become dims.
    fn demote_dims<M: MapOrSet>(&self, m: &mut M, ops: &mut Vec<ValueId>) {
        if ops.is_empty() {
            return;
        }
        let nd = m.dims();
        let mut result: Vec<ValueId> = ops[..nd as usize].to_vec();
        let mut dims = Vec::new();
        let mut syms = Vec::new();
        let mut remap = Vec::new();
        for v in &ops[nd as usize..] {
            if self.is_valid_dim(*v) && !self.is_valid_symbol(*v) {
                remap.push(AffineExpr::Dim(nd + dims.len() as u32));
                dims.push(*v);
            } else {
                remap.push(AffineExpr::Sym(syms.len() as u32));
                syms.push(*v);
            }
        }
        let (a, b) = (dims.len() as u32, syms.len() as u32);
        result.extend(dims);
        result.extend(syms);
        *ops = result;
        *m = m.replace(&[], &remap, nd + a, b);
    }

    /// `canonicalizeMapOrSetAndOperands`.
    pub fn canonicalize_map_or_set<M: MapOrSet>(&self, m: &mut M, ops: &mut Vec<ValueId>) {
        if ops.is_empty() {
            return;
        }
        self.promote_symbols(m, ops);
        self.demote_dims(m, ops);
        let (nd, ns) = (m.dims(), m.syms());
        let mut used_dims = vec![false; nd as usize];
        let mut used_syms = vec![false; ns as usize];
        for e in m.exprs() {
            e.walk(&mut |x| match x {
                AffineExpr::Dim(d) => used_dims[*d as usize] = true,
                AffineExpr::Sym(s) => used_syms[*s as usize] = true,
                _ => {}
            });
        }
        let mut result = Vec::new();
        let mut seen: BTreeMap<ValueId, AffineExpr> = BTreeMap::new();
        let mut dim_remap = vec![AffineExpr::Const(0); nd as usize];
        let mut next = 0;
        for i in 0..nd as usize {
            if !used_dims[i] {
                continue;
            }
            match seen.get(&ops[i]) {
                Some(e) => dim_remap[i] = e.clone(),
                None => {
                    dim_remap[i] = AffineExpr::Dim(next);
                    next += 1;
                    result.push(ops[i]);
                    seen.insert(ops[i], dim_remap[i].clone());
                }
            }
        }
        let mut seen_syms: BTreeMap<ValueId, AffineExpr> = BTreeMap::new();
        let mut sym_remap = vec![AffineExpr::Const(0); ns as usize];
        let mut next_sym = 0;
        for i in 0..ns as usize {
            if !used_syms[i] {
                continue;
            }
            let v = ops[i + nd as usize];
            if let Some(c) = self.const_index_attr(v) {
                sym_remap[i] = AffineExpr::Const(c);
                continue;
            }
            match seen_syms.get(&v) {
                Some(e) => sym_remap[i] = e.clone(),
                None => {
                    sym_remap[i] = AffineExpr::Sym(next_sym);
                    next_sym += 1;
                    result.push(v);
                    seen_syms.insert(v, sym_remap[i].clone());
                }
            }
        }
        *m = m.replace(&dim_remap, &sym_remap, next, next_sym);
        *ops = result;
    }

    /// `m_Constant(&IntegerAttr)`: an integer constant op's value.
    fn const_index_attr(&self, v: ValueId) -> Option<i64> {
        let d = self.def_op(v)?;
        if !self.has(d, Trait::ConstantLike) {
            return None;
        }
        self.const_index(v)
    }

    /// `replaceDimOrSym`: an `affine.apply` operand inlined into the map.
    fn replace_dim_or_sym(&self, map: &mut AffineMap, pos: usize, dims: &mut Vec<Option<ValueId>>, syms: &mut Vec<Option<ValueId>>) -> bool {
        let is_dim = pos < dims.len();
        let p = if is_dim { pos } else { pos - dims.len() };
        let Some(v) = (if is_dim { dims[p] } else { syms[p] }) else { return false };
        if let Some(d) = self.def_named(v, "affine.delinearize_index") {
            return self.replace_delinearize_inverse(d, v, map, dims, syms);
        }
        let Some(apply) = self.def_named(v, "affine.apply") else { return false };
        if is_dim {
            dims[p] = None;
        } else {
            syms[p] = None;
        }
        let Some(mut cm) = self.affine_map(apply, "map") else { return false };
        let mut cops = self[apply].operands.clone();
        self.canonicalize_map_or_set(&mut cm, &mut cops);
        let repl = cm.shifted(dims.len() as u32, syms.len() as u32).results[0].clone();
        let to_replace = if is_dim { AffineExpr::Dim(p as u32) } else { AffineExpr::Sym(p as u32) };
        dims.extend(cops[..cm.dims as usize].iter().map(|v| Some(*v)));
        syms.extend(cops[cm.dims as usize..].iter().map(|v| Some(*v)));
        *map = map.replace_expr(&to_replace, &repl, dims.len() as u32, syms.len() as u32);
        true
    }

    /// `replaceAffineDelinearizeIndexInverseExpression`: `q * s + r` over all the results of a
    /// delinearization becomes its input.
    fn replace_delinearize_inverse(&self, d: OpId, v: ValueId, map: &mut AffineMap, dims: &mut Vec<Option<ValueId>>, syms: &mut Vec<Option<ValueId>>) -> bool {
        if !self.dynamic_basis(d).is_empty() || self[d].results.last() != Some(&v) {
            return false;
        }
        let n = self[d].results.len();
        let mut res: Vec<Option<AffineExpr>> = vec![None; n];
        for (pos, x) in dims.iter().enumerate() {
            if let Some(x) = x
                && let Def::Result(o, r) = self[*x].def
                && o == d
            {
                res[r as usize] = Some(AffineExpr::Dim(pos as u32));
            }
        }
        for (pos, x) in syms.iter().enumerate() {
            if let Some(x) = x
                && let Def::Result(o, r) = self[*x].def
                && o == d
            {
                res[r as usize] = Some(AffineExpr::Sym(pos as u32));
            }
        }
        let Some(res) = res.into_iter().collect::<Option<Vec<AffineExpr>>>() else { return false };
        let is_dim = res.iter().all(|e| matches!(e, AffineExpr::Dim(_)));
        let basis = self.static_basis(d);
        let mut stride = 1i64;
        let mut expected = Vec::new();
        for (bnd, size) in res.iter().rev().zip(basis.iter().rev()) {
            expected.push(bnd.clone().mul_const(stride));
            stride *= size;
        }
        if res.len() != basis.len() {
            expected.push(res[0].clone().mul_const(stride));
        }
        let input = if is_dim { AffineExpr::Dim(dims.len() as u32) } else { AffineExpr::Sym(syms.len() as u32) };
        let mut repl: Vec<(AffineExpr, AffineExpr)> = Vec::new();
        for e in &map.results {
            shorten_add_chains(e, &expected, &input, &mut repl);
        }
        if repl.is_empty() {
            return false;
        }
        if is_dim {
            dims.push(Some(self[d].operands[0]));
        } else {
            syms.push(Some(self[d].operands[0]));
        }
        *map = AffineMap { dims: dims.len() as u32, syms: syms.len() as u32, results: map.results.iter().map(|r| r.replace_all(&repl)).collect() };
        for e in &res {
            match e {
                AffineExpr::Dim(p) if !map.uses_dim(*p) => dims[*p as usize] = None,
                AffineExpr::Sym(p) if !map.uses_sym(*p) => syms[*p as usize] = None,
                _ => {}
            }
        }
        true
    }

    /// `composeAffineMapAndOperands`.
    pub fn compose_map(&self, map: &mut AffineMap, ops: &mut Vec<ValueId>) {
        if map.results.is_empty() {
            self.canonicalize_map_or_set(map, ops);
            *map = map.simplified();
            return;
        }
        let mut dims: Vec<Option<ValueId>> = ops[..map.dims as usize].iter().map(|v| Some(*v)).collect();
        let mut syms: Vec<Option<ValueId>> = ops[map.dims as usize..].iter().map(|v| Some(*v)).collect();
        loop {
            let mut changed = false;
            let mut pos = 0;
            while pos != dims.len() + syms.len() {
                if self.replace_dim_or_sym(map, pos, &mut dims, &mut syms) {
                    changed = true;
                    break;
                }
                pos += 1;
            }
            if !changed {
                break;
            }
        }
        ops.clear();
        let (mut nd, mut ns) = (0, 0);
        let mut dr = Vec::new();
        for v in &dims {
            match v {
                Some(v) => {
                    dr.push(AffineExpr::Dim(nd));
                    nd += 1;
                    ops.push(*v);
                }
                None => dr.push(AffineExpr::Const(0)),
            }
        }
        let mut sr = Vec::new();
        for v in &syms {
            match v {
                Some(v) => {
                    sr.push(AffineExpr::Sym(ns));
                    ns += 1;
                    ops.push(*v);
                }
                None => sr.push(AffineExpr::Const(0)),
            }
        }
        *map = map.replace(&dr, &sr, nd, ns);
        self.canonicalize_map_or_set(map, ops);
        *map = map.simplified();
    }

    /// `fullyComposeAffineMapAndOperands`.
    pub fn fully_compose_map(&self, map: &mut AffineMap, ops: &mut Vec<ValueId>) {
        while ops.iter().any(|v| self.def_named(*v, "affine.apply").is_some()) {
            self.compose_map(map, ops);
        }
    }

    // ---- bounds ------------------------------------------------------------------------

    pub fn for_constant_bound(&self, f: OpId, lower: bool) -> Option<i64> {
        self.affine_map(f, if lower { "lowerBoundMap" } else { "upperBoundMap" })?.single_constant().filter(|_| {
            let m = self.affine_map(f, if lower { "lowerBoundMap" } else { "upperBoundMap" }).expect("map");
            m.dims == 0 && m.syms == 0
        })
    }

    pub fn for_step(&self, f: OpId) -> i64 {
        match self[f].get("step") {
            Some(Attribute::Int { lit, .. }) => lit.parse().unwrap_or(1),
            _ => 1,
        }
    }

    fn iv_lower_bound(&self, iv: ValueId) -> Option<i64> {
        self.affine_for_iv_owner(iv).and_then(|f| self.for_constant_bound(f, true))
    }

    fn iv_upper_bound(&self, iv: ValueId) -> Option<i64> {
        let f = self.affine_for_iv_owner(iv)?;
        let ub = self.for_constant_bound(f, false)?;
        Some(match self.for_constant_bound(f, true) {
            Some(lb) => ub - 1 - (ub - lb - 1).rem_euclid(self.for_step(f)),
            None => ub - 1,
        })
    }

    fn operand_bounds(&self, ops: &[ValueId]) -> (Vec<Option<i64>>, Vec<Option<i64>>) {
        (ops.iter().map(|v| self.iv_lower_bound(*v)).collect(), ops.iter().map(|v| self.iv_upper_bound(*v)).collect())
    }

    fn expr_largest_divisor(&self, e: &AffineExpr, ops: &[ValueId]) -> i64 {
        let div = e.largest_known_divisor();
        let AffineExpr::Dim(d) = e else { return div };
        let Some(f) = self.affine_for_iv_owner(ops[*d as usize]) else { return 1 };
        let step = self.for_step(f);
        if self.for_constant_bound(f, true) == Some(0) {
            return step;
        }
        let lb = self.affine_map(f, "lowerBoundMap").map_or(1, |m| m.results.iter().fold(0u64, |g, r| crate::affine::gcd_u64(g, r.largest_known_divisor().unsigned_abs())));
        crate::affine::gcd_u64(lb, step.unsigned_abs()) as i64
    }

    fn non_negative_bounded_by(&self, e: &AffineExpr, ops: &[ValueId], k: i64) -> bool {
        if let AffineExpr::Const(c) = e {
            return *c >= 0 && *c < k;
        }
        let AffineExpr::Dim(d) = e else { return false };
        let Some(f) = self.affine_for_iv_owner(ops[*d as usize]) else { return false };
        self.for_constant_bound(f, true).is_some_and(|lb| lb >= 0) && self.for_constant_bound(f, false).is_some_and(|ub| ub <= k)
    }

    /// `simplifyExprAndOperands`.
    fn simplify_expr_with(&self, expr: &AffineExpr, nd: u32, ns: u32, ops: &[ValueId]) -> AffineExpr {
        use crate::AffineBin as B;
        let AffineExpr::Bin(k, l, r) = expr else { return expr.clone() };
        let e = AffineExpr::binary(*k, self.simplify_expr_with(l, nd, ns, ops), self.simplify_expr_with(r, nd, ns, ops));
        let AffineExpr::Bin(k @ (B::FloorDiv | B::CeilDiv | B::Mod), l, r) = &e else { return e };
        let Some(c) = r.as_const().filter(|c| *c > 0) else { return e };
        let (lbs, ubs) = self.operand_bounds(ops);
        let bound = |upper: bool| if let Some(v) = l.as_const() { Some(v) } else { l.bound(nd, ns, &lbs, &ubs, upper) };
        if let (Some(lb), Some(ub)) = (bound(false), bound(true)) {
            let fd = |a: i64| a.div_euclid(c);
            let cd = |a: i64| -((-a).div_euclid(c));
            match k {
                B::FloorDiv if fd(lb) == fd(ub) => return AffineExpr::Const(fd(lb)),
                B::CeilDiv if cd(lb) == cd(ub) => return AffineExpr::Const(cd(lb)),
                B::Mod if lb >= 0 && lb < c && ub < c => return (**l).clone(),
                _ => {}
            }
        }
        // `isQTimesDPlusR`.
        if let AffineExpr::Bin(B::Add, ll, lr) = &**l {
            let mut found = None;
            let div = self.expr_largest_divisor(ll, ops);
            if self.non_negative_bounded_by(lr, ops, div) {
                found = Some((div, (**ll).clone(), (**lr).clone()));
            } else {
                let div = self.expr_largest_divisor(lr, ops);
                if self.non_negative_bounded_by(ll, ops, div) {
                    found = Some((div, (**lr).clone(), (**ll).clone()));
                }
            }
            if let Some((div, q, rem)) = found {
                if c % div == 0 && *k == B::FloorDiv {
                    return q.floor_div(AffineExpr::Const(c));
                }
                if div % c == 0 && *k == B::Mod {
                    return rem.modulo(AffineExpr::Const(c));
                }
                return e;
            }
        }
        if (self.non_negative_bounded_by(l, ops, c) && *k == B::FloorDiv) || (self.expr_largest_divisor(l, ops) % c == 0 && *k == B::Mod) {
            return AffineExpr::Const(0);
        }
        e
    }

    /// `simplifyMapWithOperands`.
    pub fn simplify_map_with(&self, map: &AffineMap, ops: &[ValueId]) -> AffineMap {
        AffineMap { results: map.results.iter().map(|r| self.simplify_expr_with(r, map.dims, map.syms, ops)).collect(), ..map.clone() }
    }

    /// `simplifyMinOrMaxExprWithOperands`.
    pub fn simplify_min_max_with(&self, map: &AffineMap, ops: &[ValueId], is_max: bool) -> AffineMap {
        if ops.is_empty() {
            return map.clone();
        }
        let (lbs, ubs) = self.operand_bounds(ops);
        let (mut lower, mut upper) = (Vec::new(), Vec::new());
        for e in &map.results {
            match e.as_const() {
                Some(c) => {
                    lower.push(Some(c));
                    upper.push(Some(c));
                }
                None => {
                    lower.push(e.bound(map.dims, map.syms, &lbs, &ubs, false));
                    upper.push(e.bound(map.dims, map.syms, &lbs, &ubs, true));
                }
            }
        }
        let mut kept = Vec::new();
        for (i, e) in map.results.iter().enumerate() {
            let e = match (lower[i], upper[i]) {
                (Some(l), Some(u)) if l == u => AffineExpr::Const(l),
                _ => e.clone(),
            };
            let redundant = if is_max {
                let Some(ui) = upper[i] else {
                    kept.push(e);
                    continue;
                };
                lower.iter().enumerate().any(|(pos, other)| {
                    let Some(o) = *other else { return false };
                    if pos == i {
                        return false;
                    }
                    if o > ui {
                        return true;
                    }
                    if o < ui {
                        return false;
                    }
                    !(upper[pos].is_some() && lower[i].is_some() && lower[i] == upper[i] && Some(o) == upper[pos] && i < pos)
                })
            } else {
                let Some(li) = lower[i] else {
                    kept.push(e);
                    continue;
                };
                upper.iter().enumerate().any(|(pos, other)| {
                    let Some(o) = *other else { return false };
                    if pos == i {
                        return false;
                    }
                    if o < li {
                        return true;
                    }
                    if o > li {
                        return false;
                    }
                    !(lower[pos].is_some() && upper[i].is_some() && lower[i] == upper[i] && Some(o) == lower[pos] && i < pos)
                })
            };
            if !redundant {
                kept.push(e);
            }
        }
        AffineMap { results: kept, ..map.clone() }
    }
}

impl AffineExpr {
    /// `getBoundForAffineExpr`.
    pub fn bound(&self, nd: u32, ns: u32, lbs: &[Option<i64>], ubs: &[Option<i64>], upper: bool) -> Option<i64> {
        use crate::AffineBin as B;
        if let AffineExpr::Bin(k, l, r) = self {
            match k {
                B::FloorDiv => {
                    let c = r.as_const().filter(|c| *c >= 1)?;
                    return Some(l.bound(nd, ns, lbs, ubs, upper)?.div_euclid(c));
                }
                B::CeilDiv => {
                    let c = r.as_const().filter(|c| *c >= 1)?;
                    let b = l.bound(nd, ns, lbs, ubs, upper)?;
                    return Some(-((-b).div_euclid(c)));
                }
                B::Mod => {
                    if let Some(c) = r.as_const().filter(|c| *c >= 1) {
                        let lb = l.bound(nd, ns, lbs, ubs, false);
                        let ub = l.bound(nd, ns, lbs, ubs, upper);
                        if let (Some(lb), Some(ub)) = (lb, ub)
                            && lb.div_euclid(c) == ub.div_euclid(c)
                        {
                            return Some(if upper { ub.rem_euclid(c) } else { lb.rem_euclid(c) });
                        }
                        return Some(if upper { c - 1 } else { 0 });
                    }
                }
                _ => {}
            }
        }
        let (flat, locals) = self.flatten(nd, ns)?;
        if locals > 0 {
            return None;
        }
        let mut b: i64 = 0;
        for i in 0..(nd + ns) as usize {
            if flat[i] > 0 {
                b += (if upper { ubs[i] } else { lbs[i] })? * flat[i];
            } else if flat[i] < 0 {
                b += (if upper { lbs[i] } else { ubs[i] })? * flat[i];
            }
        }
        Some(b + flat.last()?)
    }
}

/// `shortenAddChainsContainingAll`: an add chain holding every expected term maps to `new`
/// plus the rest.
fn shorten_add_chains(e: &AffineExpr, expected: &[AffineExpr], new: &AffineExpr, repl: &mut Vec<(AffineExpr, AffineExpr)>) {
    use crate::AffineBin as B;
    let AffineExpr::Bin(k, l, r) = e else { return };
    if *k != B::Add {
        shorten_add_chains(l, expected, new, repl);
        shorten_add_chains(r, expected, new, repl);
        return;
    }
    let mut keep = Vec::new();
    let mut tracker: Vec<AffineExpr> = expected.to_vec();
    let mut this: Option<&AffineExpr> = Some(r);
    let mut next: Option<&AffineExpr> = Some(l);
    while let Some(t) = this {
        if let Some(i) = tracker.iter().position(|x| x == t) {
            tracker.remove(i);
        } else {
            keep.push(t.clone());
            shorten_add_chains(t, expected, new, repl);
        }
        match next {
            Some(AffineExpr::Bin(B::Add, nl, nr)) => {
                this = Some(nr);
                next = Some(nl);
            }
            other => {
                this = other;
                next = None;
            }
        }
    }
    if !tracker.is_empty() {
        return;
    }
    let mut n = new.clone();
    for k in keep.into_iter().rev() {
        n = n.add(k);
    }
    if !repl.iter().any(|(f, _)| f == e) {
        repl.push((e.clone(), n));
    }
}

impl AffineExpr {
    /// `replace(DenseMap)`: whole subexpressions found in `map` are swapped.
    pub fn replace_all(&self, map: &[(AffineExpr, AffineExpr)]) -> AffineExpr {
        if let Some((_, to)) = map.iter().find(|(f, _)| f == self) {
            return to.clone();
        }
        match self {
            AffineExpr::Bin(k, l, r) => {
                let (nl, nr) = (l.replace_all(map), r.replace_all(map));
                if nl == **l && nr == **r {
                    return self.clone();
                }
                AffineExpr::binary(*k, nl, nr)
            }
            _ => self.clone(),
        }
    }
}

// ---- folds -----------------------------------------------------------------------------

/// The fold of an `affine` op.
pub fn fold<'a>(b: &mut Body<'a>, op: OpId) -> Fold<'a> {
    match &*b[op].name {
        "affine.apply" => fold_apply(b, op),
        "affine.delinearize_index" => fold_delinearize(b, op),
        "affine.min" | "affine.max" => fold_min_max(b, op),
        "affine.for" => fold_for(b, op),
        "affine.if" => fold_if(b, op),
        "affine.linearize_index" => fold_linearize(b, op),
        _ => Fold::Failed,
    }
}

fn index_attr<'a>(v: i64) -> Attribute<'a> {
    Attribute::Int { lit: format!("{v}").into(), ty: Some(Type::Index) }
}

fn fold_apply<'a>(b: &mut Body<'a>, op: OpId) -> Fold<'a> {
    let Some(map) = b.affine_map(op, "map") else { return Fold::Failed };
    let Some(e) = map.results.first() else { return Fold::Failed };
    match e {
        AffineExpr::Dim(d) => return Folded::Value(b[op].operands[*d as usize]).into(),
        AffineExpr::Sym(s) => return Folded::Value(b[op].operands[(map.dims + s) as usize]).into(),
        _ => {}
    }
    let consts: Vec<Option<i64>> = b[op].operands.iter().map(|v| b.const_index(*v)).collect();
    match map.constant_fold(&consts) {
        Err(()) => Folded::Attr(Attribute::dialect("ub.poison", "")).into(),
        Ok(Some(r)) => Folded::Attr(index_attr(r[0])).into(),
        Ok(None) => Fold::Failed,
    }
}

/// `foldMinMaxOp`.
fn fold_min_max<'a>(b: &mut Body<'a>, op: OpId) -> Fold<'a> {
    let Some(map) = b.affine_map(op, "map") else { return Fold::Failed };
    let consts: Vec<Option<i64>> = b[op].operands.iter().map(|v| b.const_index(*v)).collect();
    let mut folded = map.clone();
    let mut results = Some(Vec::new());
    for r in &mut folded.results {
        match r.const_eval(map.dims, &consts).ok().flatten() {
            Some(c) => {
                *r = AffineExpr::Const(c);
                if let Some(v) = &mut results {
                    v.push(c);
                }
            }
            None => results = None,
        }
    }
    if folded.syms == 1 && folded.results == [AffineExpr::Sym(0)] {
        return Folded::Value(b[op].operands[0]).into();
    }
    let Some(results) = results.filter(|r| !r.is_empty()) else {
        if folded == map {
            return Fold::Failed;
        }
        b[op].set("map", map_attr(&folded));
        return Fold::InPlace;
    };
    let v = if b[op].name == "affine.min" { results.iter().min() } else { results.iter().max() };
    Folded::Attr(index_attr(*v.expect("non-empty"))).into()
}

impl<'a> Body<'a> {
    /// An `affine.for`'s (lower bound, upper bound, inits) operands.
    fn for_operands(&self, f: OpId) -> (Vec<ValueId>, Vec<ValueId>, Vec<ValueId>) {
        let s = self.segments(f, "operandSegmentSizes").unwrap_or_default();
        let o = &self[f].operands;
        (o[..s[0]].to_vec(), o[s[0]..s[0] + s[1]].to_vec(), o[s[0] + s[1]..].to_vec())
    }

    /// `setLowerBound` / `setUpperBound`.
    fn set_for_bound(&mut self, f: OpId, lower: bool, ops: Vec<ValueId>, map: &AffineMap) {
        let (mut lb, mut ub, inits) = self.for_operands(f);
        if lower {
            lb = ops;
        } else {
            ub = ops;
        }
        let segs = [lb.len(), ub.len(), inits.len()];
        let mut all = lb;
        all.extend(ub);
        all.extend(inits);
        self.set_operands(f, all);
        self[f].set("operandSegmentSizes", Attribute::DenseArray { ty: Type::int(32), values: segs.iter().map(|x| format!("{x}").into()).collect() });
        self[f].set(if lower { "lowerBoundMap" } else { "upperBoundMap" }, map_attr(map));
    }

    fn for_constant_bounds(&self, f: OpId) -> Option<(i64, i64)> {
        Some((self.for_constant_bound(f, true)?, self.for_constant_bound(f, false)?))
    }

    /// `getTrivialConstantTripCount`.
    fn trivial_trip_count(&self, f: OpId) -> Option<u64> {
        let step = self.for_step(f);
        let (lb, ub) = self.for_constant_bounds(f)?;
        if step <= 0 {
            return None;
        }
        Some(if ub - lb <= 0 { 0 } else { ((ub - lb + step - 1) / step) as u64 })
    }
}

/// `removeDuplicateExprs`: consecutive repeats go.
fn dedup_consecutive(m: AffineMap) -> AffineMap {
    let mut r: Vec<AffineExpr> = Vec::new();
    for e in m.results {
        if r.last() != Some(&e) {
            r.push(e);
        }
    }
    AffineMap { results: r, ..m }
}

/// `AffineForOp::fold`.
fn fold_for<'a>(b: &mut Body<'a>, f: OpId) -> Fold<'a> {
    let mut folded = false;
    // `foldLoopBounds`.
    for lower in [true, false] {
        if b.for_constant_bound(f, lower).is_some() {
            continue;
        }
        let (lb, ub, _) = b.for_operands(f);
        let ops = if lower { lb } else { ub };
        let consts: Vec<Option<i64>> = ops.iter().map(|v| b.const_index_attr(*v)).collect();
        let Some(map) = b.affine_map(f, if lower { "lowerBoundMap" } else { "upperBoundMap" }) else { continue };
        let Ok(Some(r)) = map.constant_fold(&consts) else { continue };
        let v = if lower { r.iter().max() } else { r.iter().min() };
        b.set_for_bound(f, lower, Vec::new(), &AffineMap::constant(*v.expect("a bound")));
        folded = true;
    }
    // `canonicalizeLoopBounds`.
    let (mut lbo, mut ubo, _) = b.for_operands(f);
    if let (Some(mut lbm), Some(mut ubm)) = (b.affine_map(f, "lowerBoundMap"), b.affine_map(f, "upperBoundMap")) {
        let (plb, pub_) = (lbm.clone(), ubm.clone());
        b.compose_map(&mut lbm, &mut lbo);
        b.canonicalize_map_or_set(&mut lbm, &mut lbo);
        lbm = b.simplify_min_max_with(&lbm, &lbo, true);
        ubm = b.simplify_min_max_with(&ubm, &ubo, false);
        lbm = dedup_consecutive(lbm);
        b.compose_map(&mut ubm, &mut ubo);
        b.canonicalize_map_or_set(&mut ubm, &mut ubo);
        ubm = dedup_consecutive(ubm);
        if lbm != plb {
            b.set_for_bound(f, true, lbo, &lbm);
            folded = true;
        }
        if ubm != pub_ {
            b.set_for_bound(f, false, ubo, &ubm);
            folded = true;
        }
    }
    let (_, _, inits) = b.for_operands(f);
    let mut results: Option<Vec<ValueId>> = None;
    if b.trivial_trip_count(f) == Some(0) && !b[f].results.is_empty() {
        results = Some(inits.clone());
    }
    if let Some(r) = empty_loop_folder(b, f) {
        results = Some(r);
    }
    match results {
        Some(r) => Fold::Results(r.into_iter().map(Folded::Value).collect()),
        None if folded => Fold::InPlace,
        None => Fold::Failed,
    }
}

/// `AffineForEmptyLoopFolder`.
fn empty_loop_folder(b: &Body<'_>, f: OpId) -> Option<Vec<ValueId>> {
    let body = b[b[f].regions[0]].blocks[0];
    if b[body].ops.len() != 1 || b[f].results.is_empty() {
        return None;
    }
    let (_, _, inits) = b.for_operands(f);
    let trip = b.trivial_trip_count(f);
    if trip == Some(0) {
        return Some(inits);
    }
    let y = b[body].ops[0];
    let iter_args = &b[body].args[1..];
    let iv = b[body].args[0];
    let (mut outside, mut unordered) = (false, false);
    let mut repl = Vec::new();
    for (i, v) in b[y].operands.iter().enumerate() {
        if *v == iv {
            return None;
        }
        match iter_args.iter().position(|a| a == v) {
            None => {
                outside = true;
                repl.push(*v);
            }
            Some(pos) => {
                if pos != i {
                    unordered = true;
                }
                repl.push(inits[pos]);
            }
        }
    }
    if trip.is_none() && (outside || unordered) {
        return None;
    }
    if trip.is_some_and(|t| t >= 2) && unordered {
        return None;
    }
    Some(repl)
}

/// `AffineIfOp::fold`: compose and canonicalize the condition and its operands.
fn fold_if<'a>(b: &mut Body<'a>, op: OpId) -> Fold<'a> {
    let Some(old) = b.integer_set(op, "condition") else { return Fold::Failed };
    let old_ops = b[op].operands.clone();
    let mut set = old.clone();
    let mut ops = old_ops.clone();
    // `composeSetAndOperands`.
    if ops.iter().any(|v| b.def_named(*v, "affine.apply").is_some()) {
        let mut map = AffineMap { dims: set.dims, syms: set.syms, results: set.constraints.iter().map(|c| c.0.clone()).collect() };
        b.compose_map(&mut map, &mut ops);
        set = IntegerSet { dims: map.dims, syms: map.syms, constraints: map.results.into_iter().zip(set.constraints.iter().map(|c| c.1)).collect() };
    }
    b.canonicalize_map_or_set(&mut set, &mut ops);
    if set == old && ops == old_ops {
        return Fold::Failed;
    }
    b.set_operands(op, ops);
    b[op].set("condition", set_attr(&set));
    Fold::InPlace
}

/// `canonicalizeMapExprAndTermOrder`: results sorted by their flattened forms.
fn sort_min_max_terms(map: &AffineMap) -> Option<AffineMap> {
    let mut flat = Vec::new();
    for r in &map.results {
        if !r.is_pure_affine() {
            return None;
        }
        let (f, locals) = r.flatten(map.dims, map.syms)?;
        if locals != 0 {
            return None;
        }
        flat.push(f);
    }
    if flat.windows(2).all(|w| w[0] <= w[1]) {
        return None;
    }
    let mut perm: Vec<usize> = (0..map.results.len()).collect();
    perm.sort_by(|a, b| flat[*a].cmp(&flat[*b]));
    Some(AffineMap { results: perm.into_iter().map(|i| map.results[i].clone()).collect(), ..map.clone() })
}

fn replace_min_max(rw: &mut crate::Rewriter<'_, '_>, op: OpId, name: &str, map: &AffineMap, operands: &[ValueId]) -> bool {
    rw.replace_with(op, OpData::build(name).operands(operands).with("map", map_attr(map)), &[Type::Index]);
    true
}

/// `MergeAffineMinMaxOp`: a min (max) of a min (max) flattens.
fn merge_min_max(rw: &mut crate::Rewriter<'_, '_>, op: OpId) -> bool {
    let b = &*rw.body;
    let name = b[op].name.clone();
    let Some(old) = b.affine_map(op, "map") else { return false };
    let ops = &b[op].operands;
    let (dims, syms) = (&ops[..old.dims as usize], &ops[old.dims as usize..]);
    let (mut nd, mut ns) = (dims.to_vec(), syms.to_vec());
    let mut exprs = Vec::new();
    let mut producers = Vec::new();
    for e in &old.results {
        let v = match e {
            AffineExpr::Sym(p) => Some(syms[*p as usize]),
            AffineExpr::Dim(p) => Some(dims[*p as usize]),
            _ => None,
        };
        if let Some(p) = v.and_then(|v| b.def_named(v, &name)) {
            producers.push(p);
            continue;
        }
        exprs.push(e.clone());
    }
    if producers.is_empty() {
        return false;
    }
    let (mut used_d, mut used_s) = (old.dims, old.syms);
    for p in producers {
        let Some(pm) = b.affine_map(p, "map") else { return false };
        let pops = &b[p].operands;
        nd.extend(&pops[..pm.dims as usize]);
        ns.extend(&pops[pm.dims as usize..]);
        let dr: Vec<AffineExpr> = (0..pm.dims).map(|d| AffineExpr::Dim(d + used_d)).collect();
        let sr: Vec<AffineExpr> = (0..pm.syms).map(|s| AffineExpr::Sym(s + used_s)).collect();
        exprs.extend(pm.results.iter().map(|r| r.replace(&dr, &sr)));
        used_d += pm.dims;
        used_s += pm.syms;
    }
    let map = AffineMap { dims: used_d, syms: used_s, results: exprs };
    nd.extend(ns);
    replace_min_max(rw, op, &name, &map, &nd)
}

/// An `OpFoldResult` of a basis: a constant, a value, or nothing (no outer bound).
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum Ofr {
    C(i64),
    V(ValueId),
    None,
}

impl<'a> Body<'a> {
    fn static_basis(&self, op: OpId) -> Vec<i64> {
        match self[op].get("static_basis") {
            Some(Attribute::DenseArray { values, .. }) => values.iter().map(|v| v.parse().unwrap_or(0)).collect(),
            _ => Vec::new(),
        }
    }

    /// The dynamic basis operands of a (de)linearize.
    fn dynamic_basis(&self, op: OpId) -> Vec<ValueId> {
        if self[op].name == "affine.delinearize_index" {
            return self[op].operands[1..].to_vec();
        }
        let segs = self.segments(op, "operandSegmentSizes").unwrap_or_default();
        self[op].operands[segs[0]..].to_vec()
    }

    fn multi_index(&self, op: OpId) -> Vec<ValueId> {
        let segs = self.segments(op, "operandSegmentSizes").unwrap_or_default();
        self[op].operands[..segs[0]].to_vec()
    }

    /// `getMixedBasis`.
    fn mixed_basis(&self, op: OpId) -> Vec<Ofr> {
        let mut d = self.dynamic_basis(op).into_iter();
        self.static_basis(op).into_iter().map(|b| if b == i64::MIN { Ofr::V(d.next().expect("dynamic basis")) } else { Ofr::C(b) }).collect()
    }

    /// `UnitProp` `disjoint`: printed bare when set, `= false` otherwise.
    fn disjoint(&self, op: OpId) -> bool {
        matches!(self[op].get("disjoint"), Some(Attribute::Unit | Attribute::Bool(true)))
    }

    fn has_outer_bound(&self, op: OpId) -> bool {
        let n = if self[op].name == "affine.delinearize_index" { self[op].results.len() } else { self.multi_index(op).len() };
        n == self.static_basis(op).len()
    }

    /// `getPaddedBasis`.
    fn padded_basis(&self, op: OpId) -> Vec<Ofr> {
        let mut b = self.mixed_basis(op);
        if !self.has_outer_bound(op) {
            b.insert(0, Ofr::None);
        }
        b
    }

    fn ofr_const(&self, o: Ofr) -> Option<i64> {
        match o {
            Ofr::C(c) => Some(c),
            Ofr::V(v) => self.const_index(v),
            Ofr::None => None,
        }
    }

    /// `foldCstValueToCstAttrBasis`: constant dynamic basis entries become static.
    fn fold_constant_basis(&mut self, op: OpId) -> bool {
        let dynamic = self.dynamic_basis(op);
        if !dynamic.iter().any(|v| self.const_index(*v).is_some()) {
            return false;
        }
        let mixed = self.mixed_basis(op);
        let statics: Vec<i64> = mixed.iter().map(|o| self.ofr_const(*o).unwrap_or(i64::MIN)).collect();
        let keep: Vec<ValueId> = dynamic.iter().filter(|v| self.const_index(**v).is_none()).copied().collect();
        let delin = self[op].name == "affine.delinearize_index";
        let mut operands = if delin { vec![self[op].operands[0]] } else { self.multi_index(op) };
        let n = operands.len();
        operands.extend(&keep);
        self.set_operands(op, operands);
        if !delin {
            self[op].set("operandSegmentSizes", Attribute::DenseArray { ty: Type::int(32), values: vec![format!("{n}").into(), format!("{}", keep.len()).into()] });
        }
        self[op].set("static_basis", Attribute::DenseArray { ty: Type::int(64), values: statics.iter().map(|x| format!("{x}").into()).collect() });
        true
    }
}

fn fold_delinearize<'a>(b: &mut Body<'a>, op: OpId) -> Fold<'a> {
    if b.fold_constant_basis(op) {
        return Fold::InPlace;
    }
    if b[op].results.len() == 1 {
        return Folded::Value(b[op].operands[0]).into();
    }
    let Some(mut high) = b.const_index(b[op].operands[0]) else { return Fold::Failed };
    if !b.dynamic_basis(op).is_empty() {
        return Fold::Failed;
    }
    let mut basis = b.static_basis(op);
    if b.has_outer_bound(op) {
        basis.remove(0);
    }
    let ty = b[b[op].operands[0]].ty.clone();
    let attr = |v: i64| Attribute::Int { lit: format!("{v}").into(), ty: Some(ty.clone()) };
    let mut out = Vec::new();
    for m in basis.iter().rev() {
        out.push(Folded::Attr(attr(high.rem_euclid(*m))));
        high = high.div_euclid(*m);
    }
    out.push(Folded::Attr(attr(high)));
    out.reverse();
    Fold::Results(out)
}

fn fold_linearize<'a>(b: &mut Body<'a>, op: OpId) -> Fold<'a> {
    if b.fold_constant_basis(op) {
        return Fold::InPlace;
    }
    let multi = b.multi_index(op);
    let ty = b[b[op].results[0]].ty.clone();
    if multi.is_empty() {
        return Folded::Attr(Attribute::Int { lit: "0".into(), ty: Some(ty) }).into();
    }
    if multi.len() == 1 {
        return Folded::Value(multi[0]).into();
    }
    let Some(idx) = multi.iter().map(|v| b.const_index(*v)).collect::<Option<Vec<i64>>>() else { return Fold::Failed };
    if !b.dynamic_basis(op).is_empty() {
        return Fold::Failed;
    }
    let basis = b.static_basis(op);
    let (mut result, mut stride) = (0i64, 1i64);
    for (len, i) in basis.iter().rev().zip(idx.iter().rev()) {
        result += i * stride;
        stride *= len;
    }
    if !b.has_outer_bound(op) {
        result += idx[0] * stride;
    }
    Folded::Attr(Attribute::Int { lit: format!("{result}").into(), ty: Some(ty) }).into()
}

impl<'a> crate::Rewriter<'_, 'a> {
    /// `AffineDelinearizeIndexOp::create(index, basis, hasOuterBound)`.
    fn delinearize(&mut self, index: ValueId, basis: &[Ofr], outer: bool) -> Vec<ValueId> {
        let (basis, outer) = if outer && basis.first() == Some(&Ofr::None) { (&basis[1..], false) } else { (basis, outer) };
        let mut dynamic = Vec::new();
        let statics: Vec<i64> = basis
            .iter()
            .map(|o| match o {
                Ofr::C(c) => *c,
                Ofr::V(v) => {
                    dynamic.push(*v);
                    i64::MIN
                }
                Ofr::None => i64::MIN,
            })
            .collect();
        let n = if outer { statics.len() } else { statics.len() + 1 };
        let ty = self.body[index].ty.clone();
        let mut ops = vec![index];
        ops.extend(dynamic);
        let d = OpData::build("affine.delinearize_index").operands(&ops).with("static_basis", Attribute::DenseArray { ty: Type::int(64), values: statics.iter().map(|x| format!("{x}").into()).collect() });
        let o = self.create(d, &vec![ty; n]);
        self.body[o].results.clone()
    }

    /// `AffineLinearizeIndexOp::create(multiIndex, basis, disjoint)` (a leading `None` dropped).
    fn linearize_data(&self, multi: &[ValueId], basis: &[Ofr], disjoint: bool) -> OpData<'a> {
        let basis = if basis.first() == Some(&Ofr::None) { &basis[1..] } else { basis };
        let mut dynamic = Vec::new();
        let statics: Vec<i64> = basis
            .iter()
            .map(|o| match o {
                Ofr::C(c) => *c,
                Ofr::V(v) => {
                    dynamic.push(*v);
                    i64::MIN
                }
                Ofr::None => i64::MIN,
            })
            .collect();
        let mut ops = multi.to_vec();
        ops.extend(&dynamic);
        OpData::build("affine.linearize_index")
            .operands(&ops)
            .with("disjoint", if disjoint { Attribute::Unit } else { Attribute::Bool(false) })
            .with("operandSegmentSizes", Attribute::DenseArray { ty: Type::int(32), values: vec![format!("{}", multi.len()).into(), format!("{}", dynamic.len()).into()] })
            .with("static_basis", Attribute::DenseArray { ty: Type::int(64), values: statics.iter().map(|x| format!("{x}").into()).collect() })
    }

    fn linearize(&mut self, multi: &[ValueId], basis: &[Ofr], disjoint: bool) -> ValueId {
        let d = self.linearize_data(multi, basis, disjoint);
        let o = self.create(d, &[Type::Index]);
        self.body[o].results[0]
    }

    fn index_constant(&mut self, v: i64) -> ValueId {
        let o = self.emit(&arith::Constant::new(index_attr(v), Type::Index));
        self.body[o].results[0]
    }

    /// `computeProduct`: constants multiply out; anything else goes through an `affine.apply`.
    fn product(&mut self, terms: &[Ofr]) -> Ofr {
        let mut e = AffineExpr::Const(1);
        let mut dynamic = Vec::new();
        for t in terms {
            match self.body.ofr_const(*t) {
                _ if *t == Ofr::None => return Ofr::None,
                Some(c) => e = e.mul(AffineExpr::Const(c)),
                None => {
                    let Ofr::V(v) = t else { unreachable!() };
                    e = e.mul(AffineExpr::Sym(dynamic.len() as u32));
                    dynamic.push(*v);
                }
            }
        }
        if let Some(c) = e.as_const() {
            return Ofr::C(c);
        }
        let mut syms = 0;
        e.walk(&mut |x| {
            if let AffineExpr::Sym(s) = x {
                syms = syms.max(s + 1);
            }
        });
        let map = AffineMap { dims: 0, syms, results: vec![e] };
        let o = self.create(OpData::build("affine.apply").operands(&dynamic).with("map", map_attr(&map)), &[Type::Index]);
        Ofr::V(self.body[o].results[0])
    }
}

// ---- patterns --------------------------------------------------------------------------

/// The map attribute name and the operand range its operands occupy.
fn map_operands(b: &Body<'_>, op: OpId) -> Option<(&'static str, usize)> {
    Some(match &*b[op].name {
        "affine.apply" | "affine.min" | "affine.max" => ("map", 0),
        "affine.load" | "affine.vector_load" | "affine.prefetch" => ("map", 1),
        "affine.store" | "affine.vector_store" => ("map", 2),
        _ => return None,
    })
}

/// `SimplifyAffineOp<...>`: compose, canonicalize and simplify the map and its operands.
fn simplify_affine_op(rw: &mut crate::Rewriter<'_, '_>, op: OpId) -> bool {
    let b = &*rw.body;
    let Some((attr, start)) = map_operands(b, op) else { return false };
    let Some(old) = b.affine_map(op, attr) else { return false };
    let old_ops = b[op].operands[start..].to_vec();
    let mut map = old.clone();
    let mut ops = old_ops.clone();
    b.compose_map(&mut map, &mut ops);
    b.canonicalize_map_or_set(&mut map, &mut ops);
    let map = b.simplify_map_with(&map, &ops);
    if map == old && ops == old_ops {
        return false;
    }
    let mut operands = b[op].operands[..start].to_vec();
    operands.extend(ops);
    let types = b.types(&b[op].results.clone());
    let mut data = OpData::build(&b[op].name.clone()).operands(&operands).attrs(b[op].attributes.clone());
    data.properties = b[op].properties.clone();
    data.set(attr, map_attr(&map));
    rw.replace_with(op, data, &types);
    true
}

rewrites! {
    /// `CancelDelinearizeOfLinearizeDisjointExactTail`.
    CancelDelinearizeOfLinearizeDisjointExactTail("affine.delinearize_index", 1) |rw, op| {
        let b = &*rw.body;
        let Some(lin) = b.def_named(b[op].operands[0], "affine.linearize_index") else { return false };
        if !b.disjoint(lin) {
            return false;
        }
        let ins = b.multi_index(lin);
        let (lb, db) = (b.mixed_basis(lin), b.mixed_basis(op));
        let matches = lb.iter().rev().zip(db.iter().rev()).take_while(|(a, c)| a == c).count();
        if matches == 0 {
            return false;
        }
        if matches == lb.len() && matches == db.len() && ins.len() == b[op].results.len() {
            rw.replace_op(op, &ins);
            return true;
        }
        let outer = b.has_outer_bound(op);
        rw.set_before(op);
        let nl = rw.linearize(&ins[..ins.len() - matches], &lb[..lb.len() - matches], true);
        let mut results = rw.delinearize(nl, &db[..db.len() - matches], outer);
        results.extend(&ins[ins.len() - matches..]);
        rw.replace_op(op, &results);
        true
    }

    /// `DropUnitExtentBasis`.
    DropUnitExtentBasis("affine.delinearize_index", 1) |rw, op| {
        let b = &*rw.body;
        let padded = b.padded_basis(op);
        let n = b[op].results.len();
        let index = b[op].operands[0];
        let unit: Vec<bool> = padded.iter().map(|o| *o != Ofr::None && b.ofr_const(*o) == Some(1)).collect();
        let new_basis: Vec<Ofr> = padded.iter().zip(&unit).filter(|(_, u)| !**u).map(|(o, _)| *o).collect();
        if new_basis.len() == n {
            return false;
        }
        rw.set_before(op);
        let mut zero = None;
        let mut repl = vec![None; n];
        for (i, u) in unit.iter().enumerate() {
            if *u {
                let z = *zero.get_or_insert_with(|| rw.index_constant(0));
                repl[i] = Some(z);
            }
        }
        if !new_basis.is_empty() {
            let mut fresh = rw.delinearize(index, &new_basis, true).into_iter();
            for r in &mut repl {
                if r.is_none() {
                    *r = fresh.next();
                }
            }
        }
        let repl: Vec<ValueId> = repl.into_iter().map(|r| r.expect("replaced")).collect();
        rw.replace_op(op, &repl);
        true
    }

    /// `SplitDelinearizeSpanningLastLinearizeArg`.
    SplitDelinearizeSpanningLastLinearizeArg("affine.delinearize_index", 1) |rw, op| {
        let b = &*rw.body;
        let Some(lin) = b.def_named(b[op].operands[0], "affine.linearize_index") else { return false };
        if !b.disjoint(lin) {
            return false;
        }
        let lsb = b.static_basis(lin);
        let Some(&target) = lsb.last() else { return false };
        if target == i64::MIN {
            return false;
        }
        let basis = b.static_basis(op);
        let (mut size, mut elems) = (1i64, 0usize);
        for e in basis.iter().rev() {
            if *e == i64::MIN {
                return false;
            }
            size *= e;
            elems += 1;
            if size > target {
                return false;
            }
            if size == target {
                break;
            }
        }
        if size < target || elems < 2 {
            return false;
        }
        let ins = b.multi_index(lin);
        let lin_dyn = b.dynamic_basis(lin);
        let lin_basis: Vec<Ofr> = { let mut d = lin_dyn.iter(); lsb[..lsb.len() - 1].iter().map(|x| if *x == i64::MIN { Ofr::V(*d.next().expect("dyn")) } else { Ofr::C(*x) }).collect() };
        let del_dyn = b.dynamic_basis(op);
        let del_basis: Vec<Ofr> = { let mut d = del_dyn.iter(); basis[..basis.len() - elems].iter().map(|x| if *x == i64::MIN { Ofr::V(*d.next().expect("dyn")) } else { Ofr::C(*x) }).collect() };
        let outer = b.has_outer_bound(op);
        let back: Vec<Ofr> = basis[basis.len() - elems..].iter().map(|x| Ofr::C(*x)).collect();
        let last = *ins.last().expect("an index");
        rw.set_before(op);
        let without = rw.linearize(&ins[..ins.len() - 1], &lin_basis, true);
        let mut results = rw.delinearize(without, &del_basis, outer);
        results.extend(rw.delinearize(last, &back, true));
        rw.replace_op(op, &results);
        true
    }

    /// `CancelLinearizeOfDelinearizePortion`.
    CancelLinearizeOfDelinearizePortion("affine.linearize_index", 1) |rw, op| {
        let b = &*rw.body;
        let lin_basis = b.padded_basis(op);
        let multi = b.multi_index(op);
        let disjoint = b.disjoint(op);
        struct M { d: OpId, lin_start: usize, delin_start: usize, len: usize }
        let mut matches: Vec<M> = Vec::new();
        let mut seen = Vec::new();
        let mut i = 0;
        while i < multi.len() {
            let Def::Result(d, r) = b[multi[i]].def else { i += 1; continue };
            if b[d].name != "affine.delinearize_index" {
                i += 1;
                continue;
            }
            let r = r as usize;
            let delin_basis = b.padded_basis(d);
            let (fd, fl) = (delin_basis[r], lin_basis[i]);
            let bounds_match = fd == fl;
            let both_front = i == 0 && r == 0;
            let known = disjoint && r == 0 && fd == Ofr::None;
            if !bounds_match && !both_front && !known {
                i += 1;
                continue;
            }
            let outs = b[d].results.len();
            let mut j = 1;
            while j + i < multi.len() && j + r < outs {
                if multi[i + j] != b[d].results[r + j] || lin_basis[i + j] != delin_basis[r + j] {
                    break;
                }
                j += 1;
            }
            if j <= 1 || seen.contains(&d) {
                i += 1;
                continue;
            }
            seen.push(d);
            matches.push(M { d, lin_start: i, delin_start: r, len: j });
            i += j;
        }
        if matches.is_empty() {
            return false;
        }
        let mut repls: Vec<Vec<ValueId>> = Vec::new();
        let mut new_index = Vec::new();
        let mut new_basis = Vec::new();
        let mut prev = 0;
        for m in &matches {
            new_index.extend(&multi[prev..m.lin_start]);
            new_basis.extend(&lin_basis[prev..m.lin_start]);
            prev = m.lin_start + m.len;
            rw.set_before(m.d);
            let merge = lin_basis[m.lin_start..m.lin_start + m.len].to_vec();
            let size = rw.product(&merge);
            let b = &*rw.body;
            if m.len == b[m.d].results.len() {
                new_index.push(b[m.d].operands[0]);
                new_basis.push(size);
                repls.push(Vec::new());
                continue;
            }
            let mut nb = b.padded_basis(m.d);
            nb.splice(m.delin_start..m.delin_start + m.len, [size]);
            let index = b[m.d].operands[0];
            let fresh = rw.delinearize(index, &nb, true);
            let combined = fresh[m.delin_start];
            let residual = rw.delinearize(combined, &merge, true);
            let mut r = fresh[..m.delin_start].to_vec();
            r.extend(residual);
            r.extend(&fresh[m.delin_start + 1..]);
            repls.push(r);
            new_index.push(combined);
            new_basis.push(size);
        }
        new_index.extend(&multi[prev..]);
        new_basis.extend(&lin_basis[prev..]);
        let data = rw.linearize_data(&new_index, &new_basis, disjoint);
        rw.replace_with(op, data, &[Type::Index]);
        for (m, r) in matches.iter().zip(repls) {
            if !r.is_empty() {
                rw.replace_op(m.d, &r);
            }
        }
        true
    }

    /// `DropLinearizeLeadingZero`.
    DropLinearizeLeadingZero("affine.linearize_index", 1) |rw, op| {
        let b = &*rw.body;
        let multi = b.multi_index(op);
        let Some(&lead) = multi.first() else { return false };
        if b.const_index(lead) != Some(0) {
            return false;
        }
        if multi.len() == 1 {
            rw.replace_op(op, &[lead]);
            return true;
        }
        let mut basis = b.mixed_basis(op);
        if b.has_outer_bound(op) {
            basis.remove(0);
        }
        let disjoint = b.disjoint(op);
        let data = rw.linearize_data(&multi[1..], &basis, disjoint);
        rw.replace_with(op, data, &[Type::Index]);
        true
    }

    /// `DropLinearizeUnitComponentsIfDisjointOrZero`.
    DropLinearizeUnitComponentsIfDisjointOrZero("affine.linearize_index", 1) |rw, op| {
        let b = &*rw.body;
        let multi = b.multi_index(op);
        let n = multi.len();
        let disjoint = b.disjoint(op);
        let (mut idx, mut basis) = (Vec::new(), Vec::new());
        let mut rest = &multi[..];
        if !b.has_outer_bound(op) {
            idx.push(multi[0]);
            rest = &multi[1..];
        }
        for (i, e) in rest.iter().zip(b.mixed_basis(op)) {
            if b.ofr_const(e) != Some(1) {
                idx.push(*i);
                basis.push(e);
                continue;
            }
            if !disjoint && b.const_index(*i) != Some(0) {
                idx.push(*i);
                basis.push(e);
            }
        }
        if idx.len() == n {
            return false;
        }
        if idx.is_empty() {
            rw.replace_by(op, &arith::Constant::new(index_attr(0), Type::Index));
            return true;
        }
        let data = rw.linearize_data(&idx, &basis, disjoint);
        rw.replace_with(op, data, &[Type::Index]);
        true
    }

    /// `SimplifyDeadElse`: an else holding only its terminator goes.
    SimplifyDeadElse("affine.if", 1) |rw, op| {
        let b = &*rw.body;
        let er = b[op].regions[1];
        let Some(&blk) = b[er].blocks.first() else { return false };
        if b[blk].ops.len() != 1 || !b[op].results.is_empty() {
            return false;
        }
        rw.erase_block(blk);
        rw.touched(op);
        true
    }

    /// `AlwaysTrueOrFalseIf`.
    AlwaysTrueOrFalseIf("affine.if", 1) |rw, op| {
        let b = &*rw.body;
        let Some(set) = b.integer_set(op, "condition") else { return false };
        let empty = set.constraints == [(AffineExpr::Const(1), true)];
        let always = set.constraints == [(AffineExpr::Const(0), true)];
        let has_else = b[b[op].regions[1]].blocks.first().is_some();
        let block = if empty {
            if b[op].results.is_empty() && !has_else {
                rw.erase_op(op);
                return true;
            }
            b[b[op].regions[1]].blocks[0]
        } else if always {
            b[b[op].regions[0]].blocks[0]
        } else {
            return false;
        };
        let term = *b[block].ops.last().expect("terminator");
        let vals = b[term].operands.clone();
        rw.inline_block_before(block, b[op].parent.expect("placed"), Some(op), &[]);
        rw.replace_op(op, &vals);
        rw.erase_op(term);
        true
    }

    /// `CanonicalizeSingleResultAffineMinMaxOp<AffineMinOp>`.
    SingleResultAffineMin("affine.min", 1) |rw, op| { single_result_min_max(rw, op) }
    /// `DeduplicateAffineMinMaxExpressions<AffineMinOp>`.
    DeduplicateAffineMin("affine.min", 1) |rw, op| { dedup_min_max(rw, op) }
    /// `MergeAffineMinMaxOp<AffineMinOp>`.
    MergeAffineMin("affine.min", 1) |rw, op| { merge_min_max(rw, op) }
    /// `SimplifyAffineOp<AffineMinOp>`.
    SimplifyAffineMin("affine.min", 1) |rw, op| { simplify_affine_op(rw, op) }
    /// `CanonicalizeAffineMinMaxOpExprAndTermOrder<AffineMinOp>`.
    OrderAffineMin("affine.min", 1) |rw, op| { order_min_max(rw, op) }
    /// `CanonicalizeSingleResultAffineMinMaxOp<AffineMaxOp>`.
    SingleResultAffineMax("affine.max", 1) |rw, op| { single_result_min_max(rw, op) }
    /// `DeduplicateAffineMinMaxExpressions<AffineMaxOp>`.
    DeduplicateAffineMax("affine.max", 1) |rw, op| { dedup_min_max(rw, op) }
    /// `MergeAffineMinMaxOp<AffineMaxOp>`.
    MergeAffineMax("affine.max", 1) |rw, op| { merge_min_max(rw, op) }
    /// `SimplifyAffineOp<AffineMaxOp>`.
    SimplifyAffineMax("affine.max", 1) |rw, op| { simplify_affine_op(rw, op) }
    /// `CanonicalizeAffineMinMaxOpExprAndTermOrder<AffineMaxOp>`.
    OrderAffineMax("affine.max", 1) |rw, op| { order_min_max(rw, op) }

    /// `SimplifyAffineOp<AffineApplyOp>`.
    SimplifyAffineApply("affine.apply", 1) |rw, op| { simplify_affine_op(rw, op) }
    /// `SimplifyAffineOp<AffineLoadOp>`.
    SimplifyAffineLoad("affine.load", 1) |rw, op| { simplify_affine_op(rw, op) }
    /// `SimplifyAffineOp<AffineStoreOp>`.
    SimplifyAffineStore("affine.store", 1) |rw, op| { simplify_affine_op(rw, op) }
    /// `SimplifyAffineOp<AffineVectorLoadOp>`.
    SimplifyAffineVectorLoad("affine.vector_load", 1) |rw, op| { simplify_affine_op(rw, op) }
    /// `SimplifyAffineOp<AffineVectorStoreOp>`.
    SimplifyAffineVectorStore("affine.vector_store", 1) |rw, op| { simplify_affine_op(rw, op) }
    /// `SimplifyAffineOp<AffinePrefetchOp>`.
    SimplifyAffinePrefetch("affine.prefetch", 1) |rw, op| { simplify_affine_op(rw, op) }
}

fn single_result_min_max(rw: &mut crate::Rewriter<'_, '_>, op: OpId) -> bool {
    let b = &*rw.body;
    let Some(map) = b.affine_map(op, "map").filter(|m| m.results.len() == 1) else { return false };
    let ops = b[op].operands.clone();
    replace_min_max(rw, op, "affine.apply", &map, &ops)
}

fn dedup_min_max(rw: &mut crate::Rewriter<'_, '_>, op: OpId) -> bool {
    let b = &*rw.body;
    let Some(map) = b.affine_map(op, "map") else { return false };
    let mut exprs: Vec<AffineExpr> = Vec::new();
    for e in &map.results {
        if !exprs.contains(e) {
            exprs.push(e.clone());
        }
    }
    if exprs.len() == map.results.len() {
        return false;
    }
    let (name, ops) = (b[op].name.clone(), b[op].operands.clone());
    replace_min_max(rw, op, &name, &AffineMap { results: exprs, ..map }, &ops)
}

fn order_min_max(rw: &mut crate::Rewriter<'_, '_>, op: OpId) -> bool {
    let b = &*rw.body;
    let Some(map) = b.affine_map(op, "map").and_then(|m| sort_min_max_terms(&m)) else { return false };
    let (name, ops) = (b[op].name.clone(), b[op].operands.clone());
    replace_min_max(rw, op, &name, &map, &ops)
}

/// The affine dialect's canonicalization patterns.
pub fn patterns(set: &mut crate::PatternSet) {
    set.add(SimplifyAffineApply);
    set.add(SimplifyDeadElse);
    set.add(AlwaysTrueOrFalseIf);
    set.add(SingleResultAffineMin);
    set.add(DeduplicateAffineMin);
    set.add(MergeAffineMin);
    set.add(SimplifyAffineMin);
    set.add(OrderAffineMin);
    set.add(SingleResultAffineMax);
    set.add(DeduplicateAffineMax);
    set.add(MergeAffineMax);
    set.add(SimplifyAffineMax);
    set.add(OrderAffineMax);
    set.add(CancelDelinearizeOfLinearizeDisjointExactTail);
    set.add(DropUnitExtentBasis);
    set.add(SplitDelinearizeSpanningLastLinearizeArg);
    set.add(CancelLinearizeOfDelinearizePortion);
    set.add(DropLinearizeLeadingZero);
    set.add(DropLinearizeUnitComponentsIfDisjointOrZero);
    set.add(SimplifyAffineLoad);
    set.add(SimplifyAffineStore);
    set.add(SimplifyAffineVectorLoad);
    set.add(SimplifyAffineVectorStore);
    set.add(SimplifyAffinePrefetch);
}
