//! `vector`: folds, as `VectorOps.cpp`.

use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{Attribute, Dim, Shaped, ShapedKind, Type};

use super::AttrExt;
use crate::{ApInt, Body, Const, Fold, Folded, OpData, OpId, Scalar, ValueId, attr};

/// `kPoisonIndex` of extract / insert positions and shuffle masks.
const POISON: i64 = -1;
/// `ShapedType::kDynamic`.
const DYNAMIC: i64 = i64::MIN;

/// `VectorDialect::materializeConstant`.
pub fn materialize<'a>(value: &Attribute<'a>, ty: &Type<'a>) -> Option<OpData<'a>> {
    super::arith::materialize(value, ty)
}

/// A vector type's shape and its scalable flags.
fn vshape(t: &Type<'_>) -> Option<(Vec<i64>, Vec<bool>)> {
    match t {
        Type::Shaped(s) if s.kind == ShapedKind::Vector => {
            let dims = s.shape.as_ref()?;
            Some((dims.iter().map(|d| if let Dim::Static(n) | Dim::Scalable(n) = d { *n } else { DYNAMIC }).collect(), dims.iter().map(|d| matches!(d, Dim::Scalable(_))).collect()))
        }
        _ => None,
    }
}

fn vrank(t: &Type<'_>) -> Option<usize> {
    vshape(t).map(|s| s.0.len())
}

fn elem<'x, 'a>(t: &'x Type<'a>) -> &'x Type<'a> {
    attr::element_type(t)
}

/// `computeStrides` of a shape (row-major suffix products).
fn strides(shape: &[i64]) -> Vec<i64> {
    let mut out = vec![1; shape.len()];
    for i in (0..shape.len().saturating_sub(1)).rev() {
        out[i] = out[i + 1] * shape[i + 1];
    }
    out
}

fn linearize(pos: &[i64], strides: &[i64]) -> i64 {
    pos.iter().zip(strides).map(|(p, s)| p * s).sum()
}

/// `isBroadcastableTo` (success only).
pub fn broadcastable(src: &Type<'_>, dst: &Type<'_>) -> bool {
    let Some((dshape, dscal)) = vshape(dst) else { return false };
    let Some((sshape, sscal)) = vshape(src) else { return elem(dst) == src };
    if elem(src) != elem(dst) || sshape.len() > dshape.len() {
        return false;
    }
    let lead = dshape.len() - sshape.len();
    sshape.iter().enumerate().all(|(i, d)| {
        let (dd, ds) = (dshape[lead + i], dscal[lead + i]);
        (*d == 1 && !sscal[i]) || (*d == dd && sscal[i] == ds)
    })
}

impl<'a> Body<'a> {
    fn dense_array(&self, op: OpId, name: &str) -> Vec<i64> {
        match self[op].get(name) {
            Some(Attribute::DenseArray { values, .. }) => values.iter().map(|v| v.parse().unwrap_or(0)).collect(),
            _ => Vec::new(),
        }
    }

    fn set_dense_array(&mut self, op: OpId, name: &str, v: &[i64]) {
        self[op].set(name, Attribute::DenseArray { ty: Type::int(64), values: v.iter().map(|x| alloc::format!("{x}").into()).collect() });
    }

    /// `vector.extract` / `vector.insert` positions: static, dynamic ones as `DYNAMIC`.
    fn static_position(&self, op: OpId) -> Vec<i64> {
        self.dense_array(op, "static_position")
    }

    /// The operands before the dynamic positions: 1 for extract, 2 for insert.
    fn fixed_operands(&self, op: OpId) -> usize {
        if self[op].name == "vector.insert" { 2 } else { 1 }
    }

    fn has_dynamic_position(&self, op: OpId) -> bool {
        self[op].operands.len() > self.fixed_operands(op)
    }

    /// `getMixedPosition`: constants as `Ok`, dynamic values as `Err`.
    fn mixed_position(&self, op: OpId) -> Vec<Result<i64, ValueId>> {
        let mut dynamic = self[op].operands[self.fixed_operands(op)..].iter();
        self.static_position(op).into_iter().map(|p| if p == DYNAMIC { Err(*dynamic.next().expect("dynamic position")) } else { Ok(p) }).collect()
    }

    fn set_mixed_position(&mut self, op: OpId, pos: &[Result<i64, ValueId>]) {
        let mut operands: Vec<ValueId> = self[op].operands[..self.fixed_operands(op)].to_vec();
        operands.extend(pos.iter().filter_map(|p| p.err()));
        let statics: Vec<i64> = pos.iter().map(|p| p.unwrap_or(DYNAMIC)).collect();
        self.set_operands(op, operands);
        self.set_dense_array(op, "static_position", &statics);
    }

    fn result_ty(&self, op: OpId) -> Type<'a> {
        self[self[op].results[0]].ty.clone()
    }

    fn operand_ty(&self, op: OpId, i: usize) -> Type<'a> {
        self[self[op].operands[i]].ty.clone()
    }

    /// `isBroadcastLike`: a broadcast, or a shape_cast that only prepends unit dims.
    fn broadcast_like(&self, op: OpId) -> bool {
        match &*self[op].name {
            "vector.broadcast" => true,
            "vector.shape_cast" => {
                let (Some((s, _)), Some((d, _))) = (vshape(&self.operand_ty(op, 0)), vshape(&self.result_ty(op))) else { return false };
                d.len() >= s.len() && d[d.len() - s.len()..] == s[..]
            }
            _ => false,
        }
    }

    /// `isOrderPreserving` of a transpose.
    fn order_preserving(&self, op: OpId) -> bool {
        let perm = self.dense_array(op, "permutation");
        let Some((shape, scal)) = vshape(&self.operand_ty(op, 0)) else { return false };
        let mut current = 0;
        for p in perm {
            let unit = shape[p as usize] == 1 && !scal[p as usize];
            if !unit {
                if p < current {
                    return false;
                }
                current = p;
            }
        }
        true
    }
}

/// The fold of a `vector` op.
pub struct Folder<'b, 'a> {
    pub b: &'b mut Body<'a>,
    pub op: OpId,
    pub c: &'b [Option<Attribute<'a>>],
}

impl<'a> Folder<'_, 'a> {
    fn value(v: ValueId) -> Fold<'a> {
        Folded::Value(v).into()
    }

    fn attr(a: Attribute<'a>) -> Fold<'a> {
        Folded::Attr(a).into()
    }

    fn poison() -> Fold<'a> {
        Self::attr(Attribute::dialect("ub.poison", ""))
    }

    fn cst(&self, i: usize) -> Option<&Attribute<'a>> {
        self.c.get(i)?.as_ref()
    }

    fn dense(&self, i: usize) -> Option<Const<'a>> {
        Const::try_from(self.cst(i)?).ok().filter(|c| c.elements)
    }

    fn def(&self, i: usize, name: &str) -> Option<OpId> {
        self.b.def_named(self.b[self.op].operands[i], name)
    }

    pub fn fold(&mut self) -> Fold<'a> {
        let name = self.b[self.op].name.clone();
        match name.strip_prefix("vector.").unwrap_or("") {
            "extract" => self.extract(),
            "insert" => self.insert(),
            "broadcast" => self.broadcast(),
            "shuffle" => self.shuffle(),
            "shape_cast" => self.shape_cast(),
            "bitcast" => self.bitcast(),
            "transpose" => self.transpose(),
            "from_elements" => self.from_elements(),
            "to_elements" => self.to_elements(),
            "constant_mask" => self.constant_mask(),
            "mask" => self.mask(),
            "multi_reduction" => {
                let reduced = self.b.dense_array(self.op, "reduction_dims");
                if vrank(&self.b.operand_ty(self.op, 0)) == Some(1) && !reduced.contains(&0) {
                    return Self::value(self.b[self.op].operands[0]);
                }
                Fold::Failed
            }
            "insert_strided_slice" => {
                if self.b.operand_ty(self.op, 0) == self.b.operand_ty(self.op, 1) {
                    return Self::value(self.b[self.op].operands[0]);
                }
                Fold::Failed
            }
            "extract_strided_slice" => self.extract_strided_slice(),
            "load" | "maskedload" | "store" | "maskedstore" => self.memref_cast(),
            _ => Fold::Failed,
        }
    }

    /// `extractInsertFoldConstantOp`: constant dynamic positions become static.
    fn fold_constant_positions(&mut self) -> bool {
        let op = self.op;
        if !self.b.has_dynamic_position(op) {
            return false;
        }
        let fixed = self.b.fixed_operands(op);
        let shape = vshape(&self.b.operand_ty(op, fixed - 1)).map_or(Vec::new(), |s| s.0);
        let mut changed = false;
        let mut pos = self.b.mixed_position(op);
        let mut k = fixed;
        for (i, p) in pos.iter_mut().enumerate() {
            if p.is_ok() {
                continue;
            }
            let v = Const::try_from(self.cst(k).unwrap_or(&Attribute::Unit)).ok().filter(|c| !c.elements).and_then(|c| c.as_int()).map(ApInt::signed).map(|v| v as i64);
            k += 1;
            if let Some(v) = v
                && v >= -1
                && v < shape[i]
            {
                *p = Ok(v);
                changed = true;
            }
        }
        if changed {
            self.b.set_mixed_position(op, &pos);
        }
        changed
    }

    fn extract(&mut self) -> Fold<'a> {
        let (b, op) = (&*self.b, self.op);
        let src = b[op].operands[0];
        if b.static_position(op).is_empty() && b[src].ty == b.result_ty(op) {
            return Self::value(src);
        }
        if self.cst(0).is_some_and(attr::is_poison) {
            return Self::poison();
        }
        let in_place = self.fold_constant_positions();
        if self.b.static_position(op).contains(&POISON) {
            return Self::poison();
        }
        if let Some(f) = self.extract_dense() {
            return f;
        }
        let steps: [fn(&mut Self) -> Option<Fold<'a>>; 8] = [Self::extract_chain, Self::extract_insert_transpose, Self::extract_broadcast, Self::extract_shuffle, Self::extract_shape_cast, Self::extract_strided, Self::extract_insert_strided, Self::extract_from_elements];
        for s in steps {
            if let Some(f) = s(self) {
                return f;
            }
        }
        if in_place { Fold::InPlace } else { Fold::Failed }
    }

    /// `foldDenseElementsAttrSrcExtractOp`.
    fn extract_dense(&self) -> Option<Fold<'a>> {
        let c = self.dense(0)?;
        let rt = self.b.result_ty(self.op);
        if c.is_splat() {
            let v = c.values[0];
            return Some(Self::attr(if vrank(&rt).is_some() { Const::splat(v, rt).into() } else { Const::scalar(v, rt).into() }));
        }
        let (shape, scal) = vshape(&c.ty)?;
        if scal.contains(&true) || self.b.has_dynamic_position(self.op) {
            return None;
        }
        let mut full = vec![0; shape.len()];
        for (i, p) in self.b.static_position(self.op).into_iter().enumerate() {
            full[i] = p;
        }
        let start = linearize(&full, &strides(&shape)) as usize;
        Some(Self::attr(match vshape(&rt) {
            Some((rs, _)) => {
                let n: i64 = rs.iter().product();
                Const { ty: rt, values: c.values[start..start + n as usize].to_vec(), elements: true }.into()
            }
            None => Const::scalar(c.values[start], rt).into(),
        }))
    }

    /// `foldExtractOpFromExtractChain`.
    fn extract_chain(&mut self) -> Option<Fold<'a>> {
        let op = self.op;
        let mut current = self.def(0, "vector.extract")?;
        if self.b.has_dynamic_position(op) {
            return None;
        }
        let mut global: Vec<i64> = self.b.static_position(op).into_iter().rev().collect();
        loop {
            if self.b.has_dynamic_position(current) {
                return None;
            }
            global.extend(self.b.static_position(current).into_iter().rev());
            match self.b.def_named(self.b[current].operands[0], "vector.extract") {
                Some(n) => current = n,
                None => break,
            }
        }
        let src = self.b[current].operands[0];
        self.b.set_operand(op, 0, src);
        global.reverse();
        self.b.set_dense_array(op, "static_position", &global);
        Some(Fold::InPlace)
    }

    /// `ExtractFromInsertTransposeChainState::fold`.
    fn extract_insert_transpose(&mut self) -> Option<Fold<'a>> {
        let op = self.op;
        if self.b.has_dynamic_position(op) {
            return None;
        }
        let vector_rank = vrank(&self.b.operand_ty(op, 0))?;
        let mut extracted_rank = self.b.static_position(op).len();
        let sentinels: Vec<i64> = (0..(vector_rank - extracted_rank) as i64).map(|i| -(i + 1)).collect();
        let mut position = self.b.static_position(op);
        position.extend(&sentinels);
        let can_fold = |position: &[i64], extracted_rank: usize| position[extracted_rank..] == sentinels[..];
        let mut from = self.b[op].operands[0];
        loop {
            let def = self.b.def_op(from);
            let insert = def.filter(|d| self.b[*d].name == "vector.insert");
            let transpose = def.filter(|d| self.b[*d].name == "vector.transpose");
            if insert.is_none() && transpose.is_none() {
                break;
            }
            if let Some(t) = transpose {
                // `inversePermutation` then `applyPermutationMap`.
                let perm = self.b.dense_array(t, "permutation");
                let mut inv = vec![0usize; perm.len()];
                for (i, p) in perm.iter().enumerate() {
                    inv[*p as usize] = i;
                }
                position = inv.iter().map(|i| position[*i]).collect();
                from = self.b[t].operands[0];
                continue;
            }
            let ins = insert.expect("an insert");
            if self.b.has_dynamic_position(ins) {
                return None;
            }
            let inserted = self.b.static_position(ins);
            if inserted[..] == position[..extracted_rank] {
                let v = self.b[ins].operands[0];
                return can_fold(&position, extracted_rank).then(|| Self::value(v));
            }
            if inserted.len() <= position.len() && position[..inserted.len()] == inserted[..] {
                position.drain(..inserted.len());
                extracted_rank = position.len() - sentinels.len();
                let v = self.b[ins].operands[0];
                return self.extract_in_place(v, &position, extracted_rank, can_fold(&position, extracted_rank));
            }
            let contained = position.len() <= inserted.len() && inserted[..position.len()] == position[..];
            let intersects = position.iter().zip(&inserted).all(|(a, b)| *a < 0 || *b < 0 || a == b);
            if contained || intersects {
                return None;
            }
            from = self.b[ins].operands[1];
        }
        let ok = can_fold(&position, extracted_rank);
        self.extract_in_place(from, &position, extracted_rank, ok)
    }

    /// `tryToFoldExtractOpInPlace`.
    fn extract_in_place(&mut self, source: ValueId, position: &[i64], rank: usize, can_fold: bool) -> Option<Fold<'a>> {
        if source == self.b[self.op].operands[0] || !can_fold {
            return None;
        }
        self.b.set_dense_array(self.op, "static_position", &position[..rank]);
        self.b.set_operand(self.op, 0, source);
        Some(Fold::InPlace)
    }

    /// `foldExtractFromBroadcast`.
    fn extract_broadcast(&mut self) -> Option<Fold<'a>> {
        let op = self.op;
        let def = self.b.def_op(self.b[op].operands[0]).filter(|d| self.b.broadcast_like(*d))?;
        let input = self.b[def].operands[0];
        let rt = self.b.result_ty(op);
        if rt == self.b[input].ty {
            return Some(Self::value(input));
        }
        let (in_shape, _) = vshape(&self.b[input].ty).unwrap_or_default();
        let input_rank = in_shape.len();
        let broadcast_rank = vrank(&self.b.operand_ty(op, 0))?;
        let (ex_shape, _) = vshape(&rt).unwrap_or_default();
        let extract_rank = ex_shape.len();
        if extract_rank > input_rank {
            return None;
        }
        if vrank(&rt).is_some() && ex_shape[..] != in_shape[input_rank - extract_rank..] {
            return None;
        }
        let delta_overall = input_rank - extract_rank;
        let delta_broadcast = broadcast_rank - input_rank;
        let old = self.b.mixed_position(op);
        let new: Vec<Result<i64, ValueId>> = (0..delta_overall).map(|i| if in_shape[i] == 1 { Ok(0) } else { old[i + delta_broadcast] }).collect();
        self.b.set_operand(op, 0, input);
        self.b.set_mixed_position(op, &new);
        Some(Fold::InPlace)
    }

    /// `foldExtractFromShuffle`.
    fn extract_shuffle(&mut self) -> Option<Fold<'a>> {
        let op = self.op;
        if self.b.has_dynamic_position(op) {
            return None;
        }
        let sh = self.def(0, "vector.shuffle")?;
        if vrank(&self.b.result_ty(sh)) != Some(1) {
            return None;
        }
        let n = vshape(&self.b.operand_ty(sh, 0))?.0[0];
        let mask = self.b.dense_array(sh, "mask");
        let idx = mask[self.b.static_position(op)[0] as usize];
        let (src, i) = if idx < n { (self.b[sh].operands[0], idx) } else { (self.b[sh].operands[1], idx - n) };
        self.b.set_operand(op, 0, src);
        self.b.set_dense_array(op, "static_position", &[i]);
        Some(Fold::InPlace)
    }

    /// `foldExtractFromShapeCast`.
    fn extract_shape_cast(&mut self) -> Option<Fold<'a>> {
        let op = self.op;
        if self.b.has_dynamic_position(op) {
            return None;
        }
        let sc = self.def(0, "vector.shape_cast")?;
        let (sc_src, _) = vshape(&self.b.operand_ty(sc, 0))?;
        let (ex_src, _) = vshape(&self.b.operand_ty(op, 0))?;
        let rt = self.b.result_ty(op);
        let dest = vshape(&rt).map_or(Vec::new(), |s| s.0);
        let dest_rank = dest.len();
        if dest_rank > sc_src.len() {
            return None;
        }
        let rev = |s: &[i64], n: usize| s[s.len() - n - 1];
        for i in 0..dest_rank {
            if rev(&sc_src, i) != rev(&dest, i) {
                return None;
            }
        }
        let mut pos = self.b.static_position(op);
        pos.reverse();
        let mut st = Vec::new();
        let mut stride = 1;
        for i in 0..pos.len() {
            st.push(stride);
            stride *= rev(&ex_src, i + dest_rank);
        }
        let position = linearize(&pos, &st);
        let num = sc_src.len() - dest_rank;
        let mut new_strides = Vec::new();
        stride = 1;
        for i in 0..num {
            new_strides.push(stride);
            stride *= rev(&sc_src, i + dest_rank);
        }
        new_strides.reverse();
        let mut rest = position;
        let new_pos: Vec<i64> = new_strides
            .iter()
            .map(|s| {
                let q = rest / s;
                rest %= s;
                q
            })
            .collect();
        self.b.set_dense_array(op, "static_position", &new_pos);
        let src = self.b[sc].operands[0];
        self.b.set_operand(op, 0, src);
        Some(Fold::InPlace)
    }

    fn has_zero_d(&self, op: OpId) -> bool {
        let b = &*self.b;
        b[op].operands.iter().chain(&b[op].results).any(|v| vrank(&b[*v].ty) == Some(0))
    }

    fn array_attr(&self, op: OpId, name: &str) -> Vec<i64> {
        match self.b[op].get(name) {
            Some(Attribute::Array(a)) => a.iter().filter_map(|x| if let Attribute::Int { lit, .. } = x { lit.parse().ok() } else { None }).collect(),
            _ => Vec::new(),
        }
    }

    /// `foldExtractFromExtractStrided`.
    fn extract_strided(&mut self) -> Option<Fold<'a>> {
        let op = self.op;
        if self.b.has_dynamic_position(op) {
            return None;
        }
        let es = self.def(0, "vector.extract_strided_slice")?;
        if self.has_zero_d(es) || self.array_attr(es, "strides").iter().any(|s| *s != 1) {
            return None;
        }
        let mut offsets = self.array_attr(es, "offsets");
        let (res, _) = vshape(&self.b.result_ty(es))?;
        let (src, _) = vshape(&self.b.operand_ty(es, 0))?;
        while let Some(&last) = offsets.last() {
            let i = offsets.len() - 1;
            if last != 0 || res[i] != src[i] {
                break;
            }
            offsets.pop();
        }
        let dest_rank = vrank(&self.b.result_ty(op)).unwrap_or(0);
        if dest_rank > src.len() - offsets.len() {
            return None;
        }
        let mut pos = self.b.static_position(op);
        for (i, o) in offsets.iter().enumerate() {
            pos[i] += o;
        }
        let s = self.b[es].operands[0];
        self.b.set_operand(op, 0, s);
        self.b.set_dense_array(op, "static_position", &pos);
        Some(Fold::InPlace)
    }

    /// `foldExtractStridedOpFromInsertChain`, for `vector.extract` (offsets = position) and
    /// `vector.extract_strided_slice` (offsets attribute).
    fn insert_strided_chain(&mut self, offsets: Vec<i64>, dest_rank: usize, set: impl FnOnce(&mut Body<'a>, OpId, ValueId, Vec<i64>)) -> Option<Fold<'a>> {
        let mut ins = self.def(0, "vector.insert_strided_slice")?;
        if self.has_zero_d(ins) {
            return None;
        }
        loop {
            let (src, _) = vshape(&self.b.operand_ty(ins, 0))?;
            let (dst, _) = vshape(&self.b.operand_ty(ins, 1))?;
            let diff = dst.len() - src.len();
            if dest_rank > src.len() {
                return None;
            }
            let ins_offsets = self.array_attr(ins, "offsets");
            if self.array_attr(ins, "strides").iter().any(|s| *s != 1) {
                return None;
            }
            let mut disjoint = false;
            let mut diffs = Vec::new();
            for (dim, &offset) in offsets.iter().enumerate() {
                let start = ins_offsets[dim];
                let size = if dim < diff { 1 } else { src[dim - diff] };
                if start <= offset && offset < start + size {
                    if dim >= diff {
                        diffs.push(offset - start);
                    }
                    continue;
                }
                disjoint = true;
                break;
            }
            if !disjoint {
                let src_diff = src.len() - dest_rank;
                for i in 0..dest_rank {
                    if src[i + src_diff] != dst[i + src_diff + diff] {
                        return None;
                    }
                }
                let v = self.b[ins].operands[0];
                set(self.b, self.op, v, diffs);
                return Some(Fold::InPlace);
            }
            ins = self.b.def_named(self.b[ins].operands[1], "vector.insert_strided_slice")?;
        }
    }

    fn extract_insert_strided(&mut self) -> Option<Fold<'a>> {
        if self.b.has_dynamic_position(self.op) {
            return None;
        }
        let dest_rank = vrank(&self.b.result_ty(self.op)).unwrap_or(0);
        let offsets = self.b.static_position(self.op);
        self.insert_strided_chain(offsets, dest_rank, |b, op, v, diffs| {
            b.set_operand(op, 0, v);
            b.set_dense_array(op, "static_position", &diffs);
        })
    }

    /// `foldScalarExtractFromFromElements`.
    fn extract_from_elements(&mut self) -> Option<Fold<'a>> {
        let op = self.op;
        if self.b.has_dynamic_position(op) {
            return None;
        }
        let fe = self.def(0, "vector.from_elements")?;
        let vt = self.b.result_ty(fe);
        let (shape, scal) = vshape(&vt)?;
        if scal.contains(&true) || self.b.result_ty(op) != *elem(&vt) {
            return None;
        }
        let idx = linearize(&self.b.static_position(op), &strides(&shape));
        Some(Self::value(self.b[fe].operands[idx as usize]))
    }

    fn insert(&mut self) -> Fold<'a> {
        let op = self.op;
        let (v, dest) = (self.b[op].operands[0], self.b[op].operands[1]);
        if self.b.static_position(op).is_empty() && self.b[v].ty == self.b.result_ty(op) {
            return Self::value(v);
        }
        let in_place = self.fold_constant_positions();
        // `foldInsertUseChain`.
        if let Some(prev) = self.b.def_named(dest, "vector.insert")
            && self.b.mixed_position(op) == self.b.mixed_position(prev)
        {
            let d = self.b[prev].operands[1];
            self.b.set_operand(op, 1, d);
            return Fold::InPlace;
        }
        if self.b.static_position(op).contains(&POISON) {
            return Self::poison();
        }
        if let Some(f) = self.insert_dense() {
            return f;
        }
        if in_place { Fold::InPlace } else { Fold::Failed }
    }

    /// `foldDenseElementsAttrDestInsertOp`.
    fn insert_dense(&self) -> Option<Fold<'a>> {
        let op = self.op;
        if self.b.has_dynamic_position(op) {
            return None;
        }
        let dst = self.dense(1)?;
        let src_attr = self.cst(0)?;
        let dt = self.b.operand_ty(op, 1);
        let (shape, scal) = vshape(&dt)?;
        if scal.contains(&true) {
            return None;
        }
        let n: i64 = shape.iter().product();
        if n > 256 && self.b[self.b[op].results[0]].uses.len() != 1 {
            return None;
        }
        let mut full = vec![0; shape.len()];
        for (i, p) in self.b.static_position(op).into_iter().enumerate() {
            full[i] = p;
        }
        let begin = linearize(&full, &strides(&shape)) as usize;
        let src = Const::try_from(src_attr).ok()?;
        let inserted: Vec<Scalar> = if src.elements {
            let count = attr::element_count(&src.ty)?;
            (0..count).map(|i| src.values[if src.is_splat() { 0 } else { i }]).collect()
        } else {
            src.values.clone()
        };
        let mut all: Vec<Scalar> = (0..n as usize).map(|i| dst.values[if dst.is_splat() { 0 } else { i }]).collect();
        for (i, s) in inserted.into_iter().enumerate() {
            all[begin + i] = Self::numeric(s, elem(&dt));
        }
        Some(Self::attr(Const { ty: dt, values: all, elements: true }.into()))
    }

    /// `convertNumericAttr`: an integer to the element width, a float bit-cast into an
    /// integer element.
    fn numeric(s: Scalar, ty: &Type<'_>) -> Scalar {
        match (s, ty) {
            (Scalar::Int(i), Type::Integer { width, .. }) => Scalar::Int(ApInt::new(*width, i.signed())),
            (Scalar::Float(f), Type::Integer { width, .. }) => Scalar::Int(ApInt::new(*width, f.bits as i128)),
            (s, _) => s,
        }
    }

    fn broadcast(&mut self) -> Fold<'a> {
        let op = self.op;
        let src = self.b[op].operands[0];
        let rt = self.b.result_ty(op);
        if self.b[src].ty == rt {
            return Self::value(src);
        }
        // `foldBroadcastOfShapeCast`.
        if let Some(sc) = self.def(0, "vector.shape_cast") {
            let st = self.b.operand_ty(sc, 0);
            if broadcastable(&st, &rt) {
                let (s, _) = vshape(&st).unwrap_or_default();
                let (c, _) = vshape(&self.b.result_ty(sc)).unwrap_or_default();
                let n = s.len().min(c.len());
                if s[s.len() - n..] == c[c.len() - n..] {
                    let inner = self.b[sc].operands[0];
                    self.b.set_operand(op, 0, inner);
                    return Fold::InPlace;
                }
            }
        }
        let Some(a) = self.cst(0) else { return Fold::Failed };
        if attr::is_poison(a) {
            return Self::poison();
        }
        let Ok(c) = Const::try_from(a) else { return Fold::Failed };
        if !c.is_splat() || (!c.elements && c.ty != *elem(&rt)) {
            return Fold::Failed;
        }
        Self::attr(Const::splat(c.values[0], rt).into())
    }

    fn shuffle(&mut self) -> Fold<'a> {
        let op = self.op;
        let (t1, t2) = (self.b.operand_ty(op, 0), self.b.operand_ty(op, 1));
        let Some((s1, _)) = vshape(&t1) else { return Fold::Failed };
        if s1.is_empty() {
            return Fold::Failed;
        }
        let s2 = vshape(&t2).map_or(Vec::new(), |s| s.0);
        let mask = self.b.dense_array(op, "mask");
        let step = |begin: i64, width: i64| mask.len() as i64 == width && mask.iter().enumerate().all(|(i, m)| *m == begin + i as i64);
        if step(0, s1[0]) {
            return Self::value(self.b[op].operands[0]);
        }
        if step(s1[0], s2[0]) {
            return Self::value(self.b[op].operands[1]);
        }
        let (Some(a1), Some(a2)) = (self.cst(0), self.cst(1)) else { return Fold::Failed };
        let (p1, p2) = (attr::is_poison(a1), attr::is_poison(a2));
        if p1 && p2 {
            return Self::poison();
        }
        if s1.len() != 1 {
            return Fold::Failed;
        }
        let expand = |a: &Attribute<'a>, n: i64| -> Option<Vec<Scalar>> {
            let c = Const::try_from(a).ok().filter(|c| c.elements)?;
            Some((0..n as usize).map(|i| c.values[if c.is_splat() { 0 } else { i }]).collect())
        };
        let e2 = if p2 { Vec::new() } else { expand(a2, s2[0]).unwrap_or_default() };
        let e1 = if p1 { Vec::new() } else { expand(a1, s1[0]).unwrap_or_default() };
        if (!p2 && e2.is_empty()) || (!p1 && e1.is_empty()) {
            return Fold::Failed;
        }
        let poison_elem = if !p1 { e1[0] } else { e2[0] };
        let values: Vec<Scalar> = mask
            .iter()
            .map(|&m| {
                if m == POISON {
                    poison_elem
                } else if m < s1[0] {
                    if p1 { poison_elem } else { e1[m as usize] }
                } else if p2 {
                    poison_elem
                } else {
                    e2[(m - s1[0]) as usize]
                }
            })
            .collect();
        Self::attr(Const { ty: self.b.result_ty(op), values, elements: true }.into())
    }

    fn shape_cast(&mut self) -> Fold<'a> {
        let op = self.op;
        let rt = self.b.result_ty(op);
        let src = self.b[op].operands[0];
        if self.b[src].ty == rt {
            return Self::value(src);
        }
        if let Some(prev) = self.def(0, "vector.shape_cast") {
            let s = self.b[prev].operands[0];
            self.b.set_operand(op, 0, s);
            return Fold::InPlace;
        }
        if let Some(t) = self.def(0, "vector.transpose") {
            if self.b.order_preserving(t) {
                let s = self.b[t].operands[0];
                self.b.set_operand(op, 0, s);
                return Fold::InPlace;
            }
            return Fold::Failed;
        }
        if let Some(bc) = self.def(0, "vector.broadcast")
            && self.b.operand_ty(bc, 0) == rt
        {
            return Self::value(self.b[bc].operands[0]);
        }
        match self.cst(0) {
            Some(a) if attr::is_poison(a) => Self::poison(),
            Some(a) => match Const::try_from(a).ok().filter(|c| c.elements) {
                Some(c) => Self::attr(Const { ty: rt, ..c }.into()),
                None => Fold::Failed,
            },
            None => Fold::Failed,
        }
    }

    fn bitcast(&mut self) -> Fold<'a> {
        let op = self.op;
        let rt = self.b.result_ty(op);
        let src = self.b[op].operands[0];
        if self.b[src].ty == rt {
            return Self::value(src);
        }
        if let Some(prev) = self.def(0, "vector.bitcast") {
            let s = self.b[prev].operands[0];
            if self.b[s].ty == rt {
                return Self::value(s);
            }
            self.b.set_operand(op, 0, s);
            return Fold::InPlace;
        }
        let Some(c) = self.dense(0) else { return Fold::Failed };
        if !c.is_splat() {
            return Fold::Failed;
        }
        let (se, de) = (elem(&c.ty).clone(), elem(&rt).clone());
        match (c.values[0], &se, &de) {
            (Scalar::Float(f), Type::Float(mlirformat::FloatKind::F16), Type::Float(mlirformat::FloatKind::F32)) => {
                let bits = f.bits as u32 & 0xffff;
                let packed = (bits << 16) | bits;
                let Some(v) = crate::ApFloat::from_bits(mlirformat::FloatKind::F32, u64::from(packed)) else { return Fold::Failed };
                Self::attr(Const::splat(Scalar::Float(v), rt).into())
            }
            (Scalar::Int(i), Type::Integer { width: sw, .. }, Type::Integer { width: dw, .. }) if dw > sw && dw % sw == 0 => {
                let mut bits = i.unsigned() & ((1u128 << sw) - 1);
                let unit = bits;
                for _ in 0..dw / sw - 1 {
                    bits = (bits << sw) | unit;
                }
                Self::attr(Const::splat(Scalar::Int(ApInt::new(*dw, bits as i128)), rt).into())
            }
            _ => Fold::Failed,
        }
    }

    fn transpose(&mut self) -> Fold<'a> {
        let op = self.op;
        let rt = self.b.result_ty(op);
        if let Some(a) = self.cst(0) {
            if attr::is_poison(a) {
                return Self::poison();
            }
            if let Some(c) = Const::try_from(a).ok().filter(|c| c.elements && c.is_splat()) {
                return Self::attr(Const { ty: rt, ..c }.into());
            }
        }
        if self.b.operand_ty(op, 0) == rt && self.b.order_preserving(op) {
            return Self::value(self.b[op].operands[0]);
        }
        Fold::Failed
    }

    fn from_elements(&mut self) -> Fold<'a> {
        let op = self.op;
        let elems = self.b[op].operands.clone();
        // `foldFromElementsToElements`.
        if let Some(&first) = elems.first()
            && let Some(te) = self.b.def_named(first, "vector.to_elements")
            && elems.iter().all(|e| self.b.def_op(*e) == Some(te))
        {
            let input = self.b[te].operands[0];
            if self.b[input].ty == self.b.result_ty(op) && self.b[te].results == elems {
                return Self::value(input);
            }
        }
        // `foldFromElementsToConstant`.
        if elems.is_empty() || self.c.iter().any(|c| c.as_ref().is_none_or(attr::is_poison)) {
            return Fold::Failed;
        }
        let rt = self.b.result_ty(op);
        let et = elem(&rt).clone();
        if !matches!(et, Type::Integer { .. } | Type::Index | Type::Float(_)) {
            return Fold::Failed;
        }
        let mut values = Vec::new();
        for c in self.c {
            let Some(s) = c.as_ref().and_then(|a| Const::try_from(a).ok()).filter(|c| !c.elements).map(|c| c.values[0]) else { return Fold::Failed };
            values.push(Self::numeric(s, &et));
        }
        Self::attr(Const { ty: rt, values, elements: true }.into())
    }

    fn to_elements(&mut self) -> Fold<'a> {
        let op = self.op;
        if let Some(fe) = self.def(0, "vector.from_elements") {
            return Fold::Results(self.b[fe].operands.iter().map(|v| Folded::Value(*v)).collect());
        }
        if let Some(bc) = self.def(0, "vector.broadcast") {
            let s = self.b[bc].operands[0];
            if vrank(&self.b[s].ty).is_some() {
                return Fold::Failed;
            }
            let n = self.b[op].results.len();
            return Fold::Results(vec![Folded::Value(s); n]);
        }
        Fold::Failed
    }

    fn constant_mask(&mut self) -> Fold<'a> {
        let op = self.op;
        let bounds = self.b.dense_array(op, "mask_dim_sizes");
        let rt = self.b.result_ty(op);
        let sizes = vshape(&rt).map_or(Vec::new(), |s| s.0);
        let splat = |v: bool| Self::attr(Const::splat(Scalar::Int(ApInt::new(1, i128::from(v))), rt.clone()).into());
        if sizes.is_empty() {
            return splat(bounds.first() == Some(&1));
        }
        if bounds == sizes {
            return splat(true);
        }
        if bounds.iter().all(|b| *b == 0) {
            return splat(false);
        }
        Fold::Failed
    }

    /// `MaskOp::fold`: an empty mask region forwards its yield; an all-true mask unwraps.
    fn mask(&mut self) -> Fold<'a> {
        let op = self.op;
        let region = self.b[op].regions[0];
        let Some(&block) = self.b[region].blocks.first() else { return Fold::Failed };
        let ops = self.b[block].ops.clone();
        let passthru = self.b[op].operands.len() > 1;
        if ops.len() == 1 && !passthru {
            let y = ops[0];
            return Fold::Results(self.b[y].operands.iter().map(|v| Folded::Value(*v)).collect());
        }
        if self.b.mask_format(self.b[op].operands[0]) != Some(true) || ops.len() < 2 {
            return Fold::Failed;
        }
        let maskable = ops[0];
        let results = self.b[maskable].results.clone();
        for r in &results {
            self.b.drop_value_uses(*r);
        }
        self.b.detach(maskable);
        self.b.insert_before(maskable, op);
        Fold::Results(results.into_iter().map(Folded::Value).collect())
    }

    fn extract_strided_slice(&mut self) -> Fold<'a> {
        let op = self.op;
        let rt = self.b.result_ty(op);
        if self.b.operand_ty(op, 0) == rt {
            return Self::value(self.b[op].operands[0]);
        }
        let dest_rank = vrank(&rt).unwrap_or(0);
        let offsets = self.array_attr(op, "offsets");
        let num_dims = self.b.dense_array(op, "sizes").len().max(self.array_attr(op, "sizes").len());
        let _ = num_dims;
        if let Some(f) = self.insert_strided_chain(offsets, dest_rank, |b, op, v, diffs| {
            b.set_operand(op, 0, v);
            b[op].set("offsets", Attribute::Array(diffs.into_iter().map(Attribute::i64).collect()));
        }) {
            return f;
        }
        match self.dense(0) {
            Some(c) if c.is_splat() => Self::attr(Const::splat(c.values[0], rt).into()),
            _ => Fold::Failed,
        }
    }

    /// `memref::foldMemRefCast`: a `memref.cast` to a less static type folds away.
    fn memref_cast(&mut self) -> Fold<'a> {
        let op = self.op;
        let mut changed = false;
        for i in 0..self.b[op].operands.len() {
            let v = self.b[op].operands[i];
            let Some(cast) = self.b.def_named(v, "memref.cast") else { continue };
            let src = self.b[cast].operands[0];
            if crate::canon::memref_cast_foldable(&self.b[src].ty, &self.b[v].ty) {
                self.b.set_operand(op, i, src);
                changed = true;
            }
        }
        if changed { Fold::InPlace } else { Fold::Failed }
    }
}

impl<'a> Body<'a> {
    /// `getMaskFormat`: `Some(true)` all true, `Some(false)` all false, `None` unknown.
    pub fn mask_format(&self, mask: ValueId) -> Option<bool> {
        let d = self.def_op(mask)?;
        match &*self[d].name {
            "arith.constant" => {
                let c = Const::try_from(self[d].get("value")?).ok().filter(|c| c.elements)?;
                let n = attr::element_count(&c.ty)?;
                let mut val: i64 = 0;
                for i in 0..n {
                    let b = c.values[if c.is_splat() { 0 } else { i }].int()?.is_one();
                    if b && val >= 0 {
                        val += 1;
                    } else if !b && val <= 0 {
                        val -= 1;
                    } else {
                        return None;
                    }
                }
                (val != 0).then_some(val > 0)
            }
            "vector.constant_mask" => {
                let masks = self.dense_array(d, "mask_dim_sizes");
                let shape = vshape(&self.result_ty(d))?.0;
                let all_true = masks.iter().zip(&shape).all(|(m, s)| m >= s);
                let all_false = masks.iter().all(|m| *m <= 0);
                if all_true {
                    Some(true)
                } else if all_false {
                    Some(false)
                } else {
                    None
                }
            }
            "vector.create_mask" => {
                for o in &self[d].operands {
                    if let Some(c) = self.def_named(*o, "arith.constant").and_then(|c| Const::try_from(self[c].get("value")?).ok()).and_then(|c| c.as_int())
                        && c.signed() <= 0
                    {
                        return Some(false);
                    }
                }
                None
            }
            _ => None,
        }
    }
}

/// The vector type of `shape` over `elem`.
pub fn vector_type<'a>(shape: &[i64], scalable: &[bool], elem: Type<'a>) -> Type<'a> {
    Type::Shaped(Shaped { kind: ShapedKind::Vector, shape: Some(shape.iter().zip(scalable.iter().chain(core::iter::repeat(&false))).map(|(n, s)| if *s { Dim::Scalable(*n) } else { Dim::Static(*n) }).collect()), elem: elem.into(), extras: Vec::new() })
}
