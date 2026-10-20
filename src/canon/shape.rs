//! `shape`: folds, canonicalization patterns and constants, as `Shape.cpp` and
//! `ShapeCanonicalization.td`.

use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{Attribute, Dim, Shaped, ShapedKind, Type};

use crate::{ApInt, Body, Const, Fold, Folded, OpData, OpId, PatternSet, Rewriter, Scalar, ValueId, attr};

const DYNAMIC: i64 = i64::MIN;

/// The shape dialect's types and attributes.
struct Shp;

impl Shp {
    /// `!shape.<name>`.
    fn is(t: &Type<'_>, name: &str) -> bool {
        matches!(t, Type::Extended(e) if e.name.strip_prefix("shape.") == Some(name) && e.body.is_none())
    }

    /// `isExtentTensorType`: `tensor<?xindex>` or `tensor<Nxindex>`.
    fn extent_tensor(t: &Type<'_>) -> bool {
        matches!(t, Type::Shaped(s) if s.kind == ShapedKind::Tensor && s.shape.as_ref().is_some_and(|d| d.len() == 1) && *s.elem == Type::Index)
    }

    /// `tensor<N x index>`.
    fn extent_type<'a>(n: i64) -> Type<'a> {
        let dim = if n == DYNAMIC { Dim::Dynamic } else { Dim::Static(n) };
        Type::Shaped(Shaped { kind: ShapedKind::Tensor, shape: Some(vec![dim]), elem: Type::Index.into(), extras: Vec::new() })
    }

    /// `getIndexTensorAttr`.
    fn index_tensor<'a>(v: &[i64]) -> Attribute<'a> {
        let values = v.iter().map(|x| Scalar::Int(ApInt::new(64, i128::from(*x)))).collect();
        Const { ty: Self::extent_type(v.len() as i64), values, elements: true }.into()
    }

    /// `v : index`.
    fn index<'a>(v: i64) -> Attribute<'a> {
        Const::int(ApInt::new(64, i128::from(v)), Type::Index).into()
    }

    /// The values of a `DenseIntElementsAttr`.
    fn ints(a: &Attribute<'_>) -> Option<Vec<i64>> {
        let c = Const::try_from(a).ok().filter(|c| c.elements)?;
        let n = attr::element_count(&c.ty)?;
        (0..n).map(|i| c.at(i).int().map(|x| x.signed() as i64)).collect()
    }

    /// An `IntegerAttr`'s value.
    fn int(a: &Attribute<'_>) -> Option<i64> {
        Const::try_from(a).ok().filter(|c| !c.elements)?.as_int().map(|x| x.signed() as i64)
    }

    /// The dims of a ranked shaped type, dynamic as [`DYNAMIC`].
    fn dims(t: &Type<'_>) -> Option<Vec<i64>> {
        attr::shape_of(t).map(|ds| ds.iter().map(|d| if let Dim::Static(n) = d { *n } else { DYNAMIC }).collect())
    }

    /// `OpTrait::util::getBroadcastedShape`.
    fn broadcasted(a: &[i64], b: &[i64]) -> Option<Vec<i64>> {
        let mut r = if a.len() > b.len() { a.to_vec() } else { b.to_vec() };
        let n = r.len();
        for (k, (x, y)) in a.iter().rev().zip(b.iter().rev()).enumerate() {
            let (x, y) = (*x, *y);
            r[n - 1 - k] = if x == DYNAMIC || y == DYNAMIC {
                if x > 1 {
                    x
                } else if y > 1 {
                    y
                } else if x == 1 {
                    y
                } else if y == 1 {
                    x
                } else {
                    DYNAMIC
                }
            } else if x == y || y == 1 {
                x
            } else if x == 1 {
                y
            } else {
                return None;
            };
        }
        Some(r)
    }

    /// `OpTrait::util::staticallyKnownBroadcastable`.
    fn known_broadcastable(shapes: &[Vec<i64>]) -> bool {
        let rank = shapes.iter().map(Vec::len).max().unwrap_or(0);
        for i in 0..rank {
            let mut dynamic = false;
            let mut non_one: Option<i64> = None;
            for e in shapes {
                let d = if i >= e.len() { 1 } else { e[e.len() - i - 1] };
                if d == 1 {
                    continue;
                }
                if d == DYNAMIC {
                    if dynamic || non_one.is_some() {
                        return false;
                    }
                    dynamic = true;
                }
                if non_one.is_some_and(|n| n != d) {
                    return false;
                }
                non_one = Some(d);
            }
        }
        true
    }
}

impl<'a> Body<'a> {
    /// `getShapeVec`: the extents of a `shape_of` of a ranked value, or of a constant.
    fn shape_vec(&self, v: ValueId) -> Option<Vec<i64>> {
        if let Some(s) = self.def_named(v, "shape.shape_of") {
            return Shp::dims(&self[self[s].operands[0]].ty);
        }
        Shp::ints(&self.constant_of(v)?)
    }

    /// `getConstantIndex` / `getConstantDim`: a `const_size` or `arith.constant` operand.
    fn shape_const_index(&self, v: ValueId) -> Option<i64> {
        let d = self.def_op(v)?;
        match &*self[d].name {
            "shape.const_size" | "arith.constant" => Shp::int(self[d].get("value")?),
            _ => None,
        }
    }

    /// The op's data with other operands (same name, properties and attributes).
    fn rebuilt(&self, op: OpId, operands: &[ValueId]) -> OpData<'a> {
        let d = &self[op];
        OpData { properties: d.properties.clone(), attributes: d.attributes.clone(), loc: d.loc.clone(), ..OpData::named(d.name.clone()) }.operands(operands)
    }
}

/// `ShapeDialect::materializeConstant`.
pub fn materialize<'a>(value: &Attribute<'a>, ty: &Type<'a>) -> Option<OpData<'a>> {
    if crate::is_poison(value) {
        return Some(OpData::build("ub.poison").with("value", value.clone()));
    }
    if Shp::is(ty, "shape") || Shp::extent_tensor(ty) {
        return Some(OpData::build("shape.const_shape").with("shape", value.clone()));
    }
    if Shp::is(ty, "size") {
        return Some(OpData::build("shape.const_size").with("value", value.clone()));
    }
    if Shp::is(ty, "witness") {
        return Some(OpData::build("shape.const_witness").with("passing", value.clone()));
    }
    super::arith::materialize(value, ty)
}

/// The fold of a `shape` op.
pub fn fold<'a>(b: &mut Body<'a>, op: OpId, c: &[Option<Attribute<'a>>]) -> Fold<'a> {
    let attr = |a: Attribute<'a>| Folded::Attr(a).into();
    let ints = |k: usize| c.get(k).cloned().flatten().and_then(|a| Shp::ints(&a));
    let int = |k: usize| c.get(k).cloned().flatten().and_then(|a| Shp::int(&a));
    let ops = b[op].operands.clone();
    let Some(rt) = b[op].results.first().map(|r| b[*r].ty.clone()) else { return Fold::Failed };
    match &*b[op].name {
        "shape.any" => c.last().cloned().flatten().map_or(Fold::Failed, attr),
        "shape.add" | "shape.mul" | "shape.div" => {
            if b[op].name == "shape.add" && b.constant_of(ops[1]).and_then(|a| Shp::int(&a)) == Some(0) {
                return Folded::Value(ops[0]).into();
            }
            if b[op].name == "shape.add"
                && let Some(p) = c.iter().flatten().find(|a| crate::is_poison(a))
            {
                return attr(p.clone());
            }
            let (Some(l), Some(r)) = (int(0), int(1)) else { return Fold::Failed };
            match &*b[op].name {
                "shape.add" => attr(Shp::index(l.wrapping_add(r))),
                "shape.mul" => attr(Shp::index(l.wrapping_mul(r))),
                _ if r == 0 => Fold::Failed,
                _ => {
                    let (q, rem) = (l.wrapping_div(r), l.wrapping_rem(r));
                    attr(Shp::index(if q < 0 && rem != 0 { q - 1 } else { q }))
                }
            }
        }
        "shape.assuming_all" => {
            for idx in (0..ops.len()).rev() {
                let Some(a) = c[idx].clone() else { return Fold::Failed };
                let mut rest = b[op].operands.clone();
                rest.remove(idx);
                b.set_operands(op, rest);
                if a == Attribute::Bool(false) {
                    return attr(a);
                }
            }
            attr(Attribute::Bool(true))
        }
        "shape.broadcast" => {
            if ops.len() == 1 {
                return if b[ops[0]].ty == rt { Folded::Value(ops[0]).into() } else { Fold::Failed };
            }
            let Some(mut res) = ints(0) else { return Fold::Failed };
            for k in 1..ops.len() {
                let Some(next) = ints(k) else { return Fold::Failed };
                let Some(r) = Shp::broadcasted(&res, &next) else { return Fold::Failed };
                res = r;
            }
            attr(Shp::index_tensor(&res))
        }
        "shape.concat" => {
            let (Some(mut l), Some(r)) = (ints(0), ints(1)) else { return Fold::Failed };
            l.extend(r);
            attr(Shp::index_tensor(&l))
        }
        "shape.const_shape" => b[op].get("shape").cloned().map_or(Fold::Failed, attr),
        "shape.const_size" => b[op].get("value").cloned().map_or(Fold::Failed, attr),
        "shape.const_witness" => b[op].get("passing").cloned().map_or(Fold::Failed, attr),
        "shape.cstr_broadcastable" => {
            let non_scalars = c.iter().filter(|a| a.as_ref().is_none_or(|a| Shp::ints(a).is_none_or(|v| !v.is_empty()))).count();
            if non_scalars <= 1 {
                return attr(Attribute::Bool(true));
            }
            let consts: Option<Vec<Vec<i64>>> = (0..ops.len()).map(ints).collect();
            if consts.is_some_and(|e| Shp::known_broadcastable(&e)) {
                return attr(Attribute::Bool(true));
            }
            let vecs: Option<Vec<Vec<i64>>> = ops.iter().map(|v| b.shape_vec(*v)).collect();
            if vecs.is_some_and(|e| Shp::known_broadcastable(&e)) {
                return attr(Attribute::Bool(true));
            }
            Fold::Failed
        }
        "shape.cstr_eq" => {
            let all: Option<Vec<Vec<i64>>> = (0..ops.len()).map(ints).collect();
            match all {
                Some(v) if v.windows(2).all(|w| w[0] == w[1]) => attr(Attribute::Bool(true)),
                _ => Fold::Failed,
            }
        }
        "shape.cstr_require" | "shape.index_to_size" | "shape.size_to_index" => c[0].clone().map_or(Fold::Failed, attr),
        "shape.dim" => {
            let Some(dims) = Shp::dims(&b[ops[0]].ty) else { return Fold::Failed };
            let Some(i) = b.shape_const_index(ops[1]) else { return Fold::Failed };
            match usize::try_from(i).ok().and_then(|i| dims.get(i)) {
                Some(&d) if d != DYNAMIC => attr(Shp::index(d)),
                _ => Fold::Failed,
            }
        }
        "shape.shape_eq" => {
            if !ops.is_empty() && c[0].is_none() {
                return Fold::Failed;
            }
            let Some(all) = (0..ops.len()).map(ints).collect::<Option<Vec<_>>>() else { return Fold::Failed };
            attr(Attribute::Bool(all.windows(2).all(|w| w[0] == w[1])))
        }
        "shape.from_extents" => match (0..ops.len()).map(int).collect::<Option<Vec<_>>>() {
            Some(v) => attr(Shp::index_tensor(&v)),
            None => Fold::Failed,
        },
        "shape.get_extent" => {
            let Some(v) = ints(0) else { return Fold::Failed };
            let Some(d) = b.shape_const_index(ops[1]) else { return Fold::Failed };
            match usize::try_from(d).ok().and_then(|d| v.get(d)) {
                Some(&e) => attr(Shp::index(e)),
                None => Fold::Failed,
            }
        }
        "shape.is_broadcastable" if ops.len() < 2 => attr(Attribute::Bool(true)),
        "shape.rank" => ints(0).map_or(Fold::Failed, |v| attr(Shp::index(v.len() as i64))),
        "shape.num_elements" => ints(0).map_or(Fold::Failed, |v| attr(Shp::index(v.iter().fold(1i64, |p, x| p.wrapping_mul(*x))))),
        "shape.max" | "shape.min" if ops[0] == ops[1] => Folded::Value(ops[0]).into(),
        "shape.split_at" => {
            let (Some(v), Some(mut at)) = (ints(0), int(1)) else { return Fold::Failed };
            let rank = v.len() as i64;
            if -rank > at || at > rank {
                return Fold::Failed;
            }
            if at < 0 {
                at += rank;
            }
            let (l, r) = v.split_at(at as usize);
            Fold::Results(vec![Folded::Attr(Shp::index_tensor(l)), Folded::Attr(Shp::index_tensor(r))])
        }
        "shape.to_extent_tensor" => ints(0).map_or(Fold::Failed, |v| attr(Shp::index_tensor(&v))),
        _ => Fold::Failed,
    }
}

impl<'a> Rewriter<'_, 'a> {
    /// A new `name` op of operands `ops` and one result `ty`; its result.
    fn one(&mut self, data: OpData<'a>, ty: Type<'a>) -> ValueId {
        let o = self.create(data, &[ty]);
        self.body[o].results[0]
    }

    /// `RemoveDuplicateOperandsPattern`.
    fn remove_duplicate_operands(&mut self, op: OpId) -> bool {
        let b = &*self.body;
        let mut unique: Vec<ValueId> = Vec::new();
        for v in &b[op].operands {
            if !unique.contains(v) {
                unique.push(*v);
            }
        }
        if unique.len() == b[op].operands.len() {
            return false;
        }
        let types = b.types(&b[op].results);
        let data = b.rebuilt(op, &unique);
        self.replace_with(op, data, &types);
        true
    }

    /// `RemoveEmptyShapeOperandsPattern`.
    fn remove_empty_shape_operands(&mut self, op: OpId) -> bool {
        let b = &*self.body;
        let empty = |v: &ValueId| {
            Shp::dims(&b[*v].ty).is_some_and(|d| d.first() == Some(&0)) && matches!(b[*v].ty, Type::Shaped(_))
                || b.def_named(*v, "shape.const_shape").and_then(|c| b[c].get("shape")).and_then(Shp::ints).is_some_and(|s| s.is_empty())
        };
        let kept: Vec<ValueId> = b[op].operands.iter().copied().filter(|v| !empty(v)).collect();
        let types = b.types(&b[op].results);
        if kept.is_empty() {
            self.replace_with(op, OpData::build("shape.const_shape").with("shape", Shp::index_tensor(&[])), &types[..1]);
            return true;
        }
        if kept.len() == b[op].operands.len() {
            return false;
        }
        let data = b.rebuilt(op, &kept);
        self.replace_with(op, data, &types);
        true
    }

    /// `CanonicalizeCastExtentTensorOperandsPattern`: information-losing casts are skipped.
    fn skip_lossy_casts(&mut self, op: OpId) -> bool {
        let b = &*self.body;
        let mut changed = false;
        let ops: Vec<ValueId> = b[op]
            .operands
            .iter()
            .map(|v| match b.def_named(*v, "tensor.cast") {
                Some(c) if Shp::dims(&b[*v].ty).is_some_and(|d| d.first() == Some(&DYNAMIC)) => {
                    changed = true;
                    b[c].operands[0]
                }
                _ => *v,
            })
            .collect();
        if !changed {
            return false;
        }
        let types = b.types(&b[op].results);
        let name = b[op].name.clone();
        self.replace_with(op, OpData::build(&name).operands(&ops), &types);
        true
    }

    /// `AssumingOp::inlineRegionIntoParent`.
    fn inline_assuming(&mut self, op: OpId) {
        let before = self.body[op].parent.expect("placed");
        let after = self.split_block(before, op);
        let region = self.body[op].regions[0];
        let inner = self.body[region].blocks[0];
        let yield_op = *self.body[inner].ops.last().expect("terminated");
        let parent_region = self.body[before].parent.expect("in region");
        self.inline_region_before(region, parent_region, Some(after));
        let values = self.body[yield_op].operands.clone();
        self.replace_op(op, &values);
        self.erase_op(yield_op);
        self.merge_blocks(inner, before, &[]);
        self.merge_blocks(after, before, &[]);
    }
}

rewrites! {
    /// `AssumingOpRemoveUnusedResults`.
    AssumingOpRemoveUnusedResults("shape.assuming", 1) |rw, op| {
        let b = &*rw.body;
        let region = b[op].regions[0];
        let body = b[region].blocks[0];
        let yield_op = *b[body].ops.last().expect("terminated");
        let results = b[op].results.clone();
        let kept: Vec<ValueId> = results.iter().zip(&b[yield_op].operands).filter(|(r, _)| !b[**r].uses.is_empty()).map(|(_, y)| *y).collect();
        if kept.len() == b[yield_op].operands.len() {
            return false;
        }
        let witness = b[op].operands[0];
        rw.set_end(body);
        rw.replace_with(yield_op, OpData::build("shape.assuming_yield").operands(&kept), &[]);
        rw.set_before(op);
        let types = rw.body.types(&kept);
        let new = rw.create_with(OpData::build("shape.assuming").operands(&[witness]), &types, |b, o| {
            b.add_region(o);
        });
        let into = rw.body[new].regions[0];
        rw.inline_region_before(region, into, None);
        let mut src = rw.body[new].results.clone().into_iter();
        for r in results {
            if !rw.body[r].uses.is_empty() {
                let to = src.next().expect("one per used result");
                rw.replace_all_uses(r, to);
            }
        }
        rw.erase_op(op);
        true
    }

    /// `AssumingWithTrue`: a constant witness inlines the region.
    AssumingWithTrue("shape.assuming", 1) |rw, op| {
        let b = &*rw.body;
        if b.def_named(b[op].operands[0], "shape.const_witness").is_none() {
            return false;
        }
        rw.inline_assuming(op);
        true
    }

    /// `MergeAssumingAllOps`.
    MergeAssumingAllOps("shape.assuming_all", 1) |rw, op| {
        let b = &*rw.body;
        let mut ops = Vec::new();
        for v in &b[op].operands {
            match b.def_named(*v, "shape.assuming_all") {
                Some(a) => ops.extend(b[a].operands.iter().copied()),
                None => ops.push(*v),
            }
        }
        if ops.len() == b[op].operands.len() {
            return false;
        }
        let ty = b[b[op].results[0]].ty.clone();
        rw.replace_with(op, OpData::build("shape.assuming_all").operands(&ops), &[ty]);
        true
    }

    /// `AssumingAllOneOp`.
    AssumingAllOneOp("shape.assuming_all", 1) |rw, op| {
        let b = &*rw.body;
        let [v] = b[op].operands[..] else { return false };
        rw.replace_op(op, &[v]);
        true
    }

    /// `AssumingAllOfCstrBroadcastable`: constraints whose shapes another one covers go.
    AssumingAllOfCstrBroadcastable("shape.assuming_all", 1) |rw, op| {
        let b = &*rw.body;
        let mut cstrs: Vec<OpId> = Vec::new();
        for v in &b[op].operands {
            let Some(c) = b.def_named(*v, "shape.cstr_broadcastable") else { return false };
            if !cstrs.contains(&c) {
                cstrs.push(c);
            }
        }
        if cstrs.len() <= 1 {
            return false;
        }
        let mut shapes: Vec<(OpId, Vec<ValueId>)> = cstrs.iter().map(|c| (*c, b[*c].operands.clone())).collect();
        shapes.sort_by(|x, y| b[y.0].operands.len().cmp(&b[x.0].operands.len()));
        let mut erased = Vec::new();
        let mut i = 0;
        while i < shapes.len() {
            let cover = shapes[i].1.clone();
            let (keep, drop): (Vec<_>, Vec<_>) = shapes.drain(i + 1..).partition(|(_, s)| !s.iter().all(|v| cover.contains(v)));
            erased.extend(drop.into_iter().map(|(c, _)| c));
            shapes.extend(keep);
            i += 1;
        }
        if erased.is_empty() {
            return false;
        }
        let unique: Vec<ValueId> = shapes.iter().map(|(c, _)| b[*c].results[0]).collect();
        let ty = b[b[op].results[0]].ty.clone();
        rw.replace_with(op, OpData::build("shape.assuming_all").operands(&unique), &[ty]);
        for c in erased {
            if rw.body[rw.body[c].results[0]].uses.is_empty() {
                rw.erase_op(c);
            }
        }
        true
    }

    /// `AssumingAllToCstrEqCanonicalization`.
    AssumingAllToCstrEqCanonicalization("shape.assuming_all", 1) |rw, op| {
        let b = &*rw.body;
        let mut shapes: Vec<ValueId> = Vec::new();
        for w in &b[op].operands {
            let Some(e) = b.def_named(*w, "shape.cstr_eq") else { return false };
            let these = &b[e].operands;
            let disjoint = !these.iter().any(|s| shapes.contains(s));
            if !shapes.is_empty() && !these.is_empty() && disjoint {
                return false;
            }
            shapes.extend(these.iter().copied());
        }
        let ty = b[b[op].results[0]].ty.clone();
        rw.replace_with(op, OpData::build("shape.cstr_eq").operands(&shapes), &[ty]);
        true
    }

    RemoveDuplicateAssumingAll("shape.assuming_all", 1) |rw, op| {
        rw.remove_duplicate_operands(op)
    }

    /// `BroadcastConcretizeResultTypePattern`.
    BroadcastConcretizeResultType("shape.broadcast", 1) |rw, op| {
        let b = &*rw.body;
        let rt = b[b[op].results[0]].ty.clone();
        if Shp::dims(&rt).and_then(|d| d.first().copied()) != Some(DYNAMIC) || !matches!(rt, Type::Shaped(_)) {
            return false;
        }
        let mut max = 0;
        for v in &b[op].operands {
            if let (Type::Shaped(_), Some(d)) = (&b[*v].ty, Shp::dims(&b[*v].ty)) {
                if d[0] == DYNAMIC {
                    return false;
                }
                max = max.max(d[0]);
            }
        }
        let ops = b[op].operands.clone();
        rw.set_before(op);
        let n = rw.one(OpData::build("shape.broadcast").operands(&ops), Shp::extent_type(max));
        rw.replace_with(op, OpData::build("tensor.cast").operands(&[n]), &[rt]);
        true
    }

    /// `BroadcastFoldConstantOperandsPattern`.
    BroadcastFoldConstantOperands("shape.broadcast", 1) |rw, op| {
        let b = &*rw.body;
        let mut folded: Vec<i64> = Vec::new();
        let mut kept = Vec::new();
        for v in &b[op].operands {
            if let Some(s) = b.def_named(*v, "shape.const_shape").and_then(|c| b[c].get("shape")).and_then(Shp::ints)
                && let Some(n) = Shp::broadcasted(&folded, &s)
            {
                folded = n;
                continue;
            }
            kept.push(*v);
        }
        if b[op].operands.len() - kept.len() < 2 {
            return false;
        }
        let rt = b[b[op].results[0]].ty.clone();
        rw.set_before(op);
        let c = rw.one(OpData::build("shape.const_shape").with("shape", Shp::index_tensor(&folded)), Shp::extent_type(folded.len() as i64));
        kept.push(c);
        rw.replace_with(op, OpData::build("shape.broadcast").operands(&kept), &[rt]);
        true
    }

    /// `BroadcastForwardSingleOperandPattern`.
    BroadcastForwardSingleOperand("shape.broadcast", 1) |rw, op| {
        let b = &*rw.body;
        let [mut v] = b[op].operands[..] else { return false };
        let rt = b[b[op].results[0]].ty.clone();
        if b[v].ty != rt {
            rw.set_before(op);
            let name = if Shp::is(&rt, "shape") { "shape.from_extent_tensor" } else { "tensor.cast" };
            v = rw.one(OpData::build(name).operands(&[v]), rt);
        }
        rw.replace_op(op, &[v]);
        true
    }

    SkipLossyCastsBroadcast("shape.broadcast", 1) |rw, op| {
        rw.skip_lossy_casts(op)
    }

    RemoveDuplicateBroadcast("shape.broadcast", 1) |rw, op| {
        rw.remove_duplicate_operands(op)
    }

    RemoveEmptyShapeBroadcast("shape.broadcast", 1) |rw, op| {
        rw.remove_empty_shape_operands(op)
    }

    /// `TensorCastConstShape`.
    TensorCastConstShape("tensor.cast", 2) |rw, op| {
        let b = &*rw.body;
        let Some(c) = b.def_named(b[op].operands[0], "shape.const_shape") else { return false };
        let rt = &b[b[op].results[0]].ty;
        if !Shp::dims(rt).is_some_and(|d| !d.contains(&DYNAMIC)) {
            return false;
        }
        let Some(shape) = b[c].get("shape").cloned() else { return false };
        let n = Shp::ints(&shape).map_or(0, |v| v.len() as i64);
        rw.replace_with(op, OpData::build("shape.const_shape").with("shape", shape), &[Shp::extent_type(n)]);
        true
    }

    SkipLossyCastsCstrBroadcastable("shape.cstr_broadcastable", 1) |rw, op| {
        rw.skip_lossy_casts(op)
    }

    /// `CstrBroadcastableEqOps`.
    CstrBroadcastableEqOps("shape.cstr_broadcastable", 1) |rw, op| {
        let b = &*rw.body;
        if !b[op].operands.windows(2).all(|w| w[0] == w[1]) {
            return false;
        }
        let ty = b[b[op].results[0]].ty.clone();
        rw.replace_with(op, OpData::build("shape.const_witness").with("passing", Attribute::Bool(true)), &[ty]);
        true
    }

    RemoveDuplicateCstrBroadcastable("shape.cstr_broadcastable", 1) |rw, op| {
        rw.remove_duplicate_operands(op)
    }

    RemoveEmptyShapeCstrBroadcastable("shape.cstr_broadcastable", 1) |rw, op| {
        rw.remove_empty_shape_operands(op)
    }

    /// `CstrEqEqOps`.
    CstrEqEqOps("shape.cstr_eq", 1) |rw, op| {
        let b = &*rw.body;
        if !b[op].operands.windows(2).all(|w| w[0] == w[1]) {
            return false;
        }
        let ty = b[b[op].results[0]].ty.clone();
        rw.replace_with(op, OpData::build("shape.const_witness").with("passing", Attribute::Bool(true)), &[ty]);
        true
    }

    /// `SizeToIndexToSizeCanonicalization`.
    SizeToIndexToSize("shape.index_to_size", 2) |rw, op| {
        let b = &*rw.body;
        let Some(inner) = b.def_named(b[op].operands[0], "shape.size_to_index") else { return false };
        let v = b[inner].operands[0];
        rw.replace_op(op, &[v]);
        true
    }

    RemoveDuplicateIsBroadcastable("shape.is_broadcastable", 1) |rw, op| {
        rw.remove_duplicate_operands(op)
    }

    /// `RankShapeOfCanonicalizationPattern`.
    RankShapeOf("shape.rank", 1) |rw, op| {
        let b = &*rw.body;
        let Some(s) = b.def_named(b[op].operands[0], "shape.shape_of") else { return false };
        let arg = &b[b[s].operands[0]].ty;
        let (Type::Shaped(st), Some(d)) = (arg, Shp::dims(arg)) else { return false };
        if st.kind != ShapedKind::Tensor {
            return false;
        }
        let rank = Shp::index(d.len() as i64);
        let rt = b[b[op].results[0]].ty.clone();
        let name = match &rt {
            Type::Index => "arith.constant",
            t if Shp::is(t, "size") => "shape.const_size",
            _ => return false,
        };
        rw.replace_with(op, OpData::build(name).with("value", rank), &[rt]);
        true
    }

    /// `ShapeOfCastExtentTensor`.
    ShapeOfCastExtentTensor("tensor.cast", 1) |rw, op| {
        let b = &*rw.body;
        let ty = b[b[op].results[0]].ty.clone();
        let Some(d) = Shp::dims(&ty).filter(|d| d.len() == 1) else { return false };
        let Some(s) = b.def_named(b[op].operands[0], "shape.shape_of") else { return false };
        let arg = b[s].operands[0];
        let (Type::Shaped(at), Some(ad)) = (&b[arg].ty, Shp::dims(&b[arg].ty)) else { return false };
        if at.kind != ShapedKind::Tensor || (d[0] != DYNAMIC && d[0] != ad.len() as i64) {
            return false;
        }
        rw.replace_with(op, OpData::build("shape.shape_of").operands(&[arg]), &[ty]);
        true
    }

    /// `ShapeOfFromReshape`.
    ShapeOfFromReshape("shape.shape_of", 1) |rw, op| {
        let b = &*rw.body;
        let Some(r) = b.def_named(b[op].operands[0], "tensor.reshape") else { return false };
        let ty = b[b[op].results[0]].ty.clone();
        if !matches!(&ty, Type::Shaped(s) if s.kind == ShapedKind::Tensor) {
            return false;
        }
        let mut shape = b[r].operands[1];
        let st = b[shape].ty.clone();
        if st != ty {
            rw.set_before(op);
            if attr::element_type(&st) == attr::element_type(&ty) {
                shape = rw.one(OpData::build("tensor.cast").operands(&[shape]), ty);
            } else if !Shp::extent_tensor(&st) {
                shape = rw.one(OpData::build("arith.index_cast").operands(&[shape]), ty);
            }
        }
        rw.replace_op(op, &[shape]);
        true
    }

    /// `ExtractFromShapeOfExtentTensor`.
    ExtractFromShapeOfExtentTensor("tensor.extract", 2) |rw, op| {
        let b = &*rw.body;
        let Some(s) = b.def_named(b[op].operands[0], "shape.shape_of") else { return false };
        let Some(&i) = b[op].operands.get(1) else { return false };
        let arg = b[s].operands[0];
        rw.replace_with(op, OpData::build("tensor.dim").operands(&[arg, i]), &[Type::Index]);
        true
    }

    /// `ShapeOfOpToConstShapeOp`.
    ShapeOfOpToConstShape("shape.shape_of", 1) |rw, op| {
        let b = &*rw.body;
        let arg = &b[b[op].operands[0]].ty;
        let Some(d) = Shp::dims(arg).filter(|d| !d.contains(&DYNAMIC)) else { return false };
        let ty = b[b[op].results[0]].ty.clone();
        rw.set_before(op);
        let ct = Shp::extent_type(d.len() as i64);
        let mut c = rw.one(OpData::build("shape.const_shape").with("shape", Shp::index_tensor(&d)), ct.clone());
        if ct != ty {
            c = rw.one(OpData::build("tensor.cast").operands(&[c]), ty);
        }
        rw.replace_op(op, &[c]);
        true
    }

    /// `IndexToSizeToIndexCanonicalization`.
    IndexToSizeToIndex("shape.size_to_index", 2) |rw, op| {
        let b = &*rw.body;
        let Some(inner) = b.def_named(b[op].operands[0], "shape.index_to_size") else { return false };
        let v = b[inner].operands[0];
        rw.replace_op(op, &[v]);
        true
    }
}

/// The shape ops' canonicalization patterns, by op name as `getRegisteredOperations` sorts them.
pub fn patterns(set: &mut PatternSet) {
    set.add(AssumingOpRemoveUnusedResults).add(AssumingWithTrue);
    set.add(MergeAssumingAllOps).add(AssumingAllOneOp).add(AssumingAllOfCstrBroadcastable).add(AssumingAllToCstrEqCanonicalization).add(RemoveDuplicateAssumingAll);
    set.add(BroadcastConcretizeResultType).add(BroadcastFoldConstantOperands).add(BroadcastForwardSingleOperand).add(SkipLossyCastsBroadcast).add(RemoveDuplicateBroadcast).add(RemoveEmptyShapeBroadcast);
    set.add(TensorCastConstShape);
    set.add(SkipLossyCastsCstrBroadcastable).add(CstrBroadcastableEqOps).add(RemoveDuplicateCstrBroadcastable).add(RemoveEmptyShapeCstrBroadcastable);
    set.add(CstrEqEqOps);
    set.add(SizeToIndexToSize);
    set.add(RemoveDuplicateIsBroadcastable);
    set.add(RankShapeOf);
    set.add(ShapeOfCastExtentTensor).add(ShapeOfFromReshape).add(ExtractFromShapeOfExtentTensor).add(ShapeOfOpToConstShape);
    set.add(IndexToSizeToIndex);
}
