//! `tensor`: folds and canonicalization patterns, as `TensorOps.cpp`.

use alloc::borrow::Cow;
use alloc::format;
use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{Attribute, Dim, Shaped, ShapedKind, Type};

use super::reshape::{ComposeCollapseOfExpand, ComposeExpandOfCollapse, ComposeReassociative, Reassoc, Reshape};
use super::MemrefOfr as Ofr;
use crate::{AffineExpr, AffineMap, Body, Const, DYNAMIC, Fold, Folded, Mapping, OpData, OpId, PatternSet, Rewriter, Trait, ValueId, attr};

/// The tensor types' helpers.
struct Tn;

impl Tn {
    /// A ranked tensor type.
    fn ranked<'x, 'a>(t: &'x Type<'a>) -> Option<&'x Shaped<'a>> {
        match t {
            Type::Shaped(s) if s.kind == ShapedKind::Tensor && s.shape.is_some() => Some(s),
            _ => None,
        }
    }

    fn dims(t: &Type<'_>) -> Option<Vec<i64>> {
        attr::shape_of(t).map(|d| d.iter().map(|d| if let Dim::Static(n) = d { *n } else { DYNAMIC }).collect())
    }

    /// `RankedTensorType::get(dims, elem, encoding)`.
    fn tensor<'a>(dims: &[i64], elem: Type<'a>, extras: Vec<Attribute<'a>>) -> Type<'a> {
        let shape = dims.iter().map(|d| if *d == DYNAMIC { Dim::Dynamic } else { Dim::Static(*d) }).collect();
        Type::Shaped(Shaped { kind: ShapedKind::Tensor, shape: Some(shape), elem: elem.into(), extras })
    }

    /// `t` with other dims (element type and encoding kept).
    fn with_dims<'a>(t: &Shaped<'a>, dims: &[i64]) -> Type<'a> {
        Self::tensor(dims, (*t.elem).clone(), t.extras.clone())
    }

    fn static_shape(t: &Type<'_>) -> bool {
        Self::dims(t).is_some_and(|d| !d.contains(&DYNAMIC))
    }

    /// `preservesStaticInformation`.
    fn preserves(src: &Type<'_>, dst: &Type<'_>) -> bool {
        let (Some(s), Some(d)) = (Self::ranked(src), Self::ranked(dst)) else { return false };
        if s.elem != d.elem || s.extras != d.extras {
            return false;
        }
        let (Some(a), Some(b)) = (Self::dims(src), Self::dims(dst)) else { return false };
        a.len() == b.len() && !a.iter().zip(&b).any(|(x, y)| *x != DYNAMIC && *y == DYNAMIC)
    }

    /// `joinShapes`.
    fn join<'a>(one: &Type<'a>, two: &Type<'a>) -> Option<Type<'a>> {
        let (Some(a), Some(b)) = (Self::dims(one), Self::dims(two)) else {
            return Some(if Self::dims(one).is_none() { two.clone() } else { one.clone() });
        };
        if a.len() != b.len() {
            return None;
        }
        let mut join = Vec::new();
        for (x, y) in a.iter().zip(&b) {
            join.push(match (*x, *y) {
                (DYNAMIC, y) => y,
                (x, DYNAMIC) => x,
                (x, y) if x == y => x,
                _ => return None,
            });
        }
        Some(Self::tensor(&join, attr::element_type(one).clone(), Vec::new()))
    }

    /// `computeRankReductionMask`: the dims of `orig` dropped to get `reduced`.
    fn rank_reduction_mask(orig: &[i64], reduced: &[i64], match_dynamic: bool) -> Option<Vec<usize>> {
        let mut unused = Vec::new();
        let mut j = 0;
        for (i, o) in orig.iter().enumerate() {
            if match_dynamic && j < reduced.len() && *o != 1 && (reduced[j] == DYNAMIC || *o == DYNAMIC) {
                j += 1;
                continue;
            }
            if j < reduced.len() && *o == reduced[j] {
                j += 1;
                continue;
            }
            unused.push(i);
            if *o != 1 {
                return None;
            }
        }
        (j == reduced.len()).then_some(unused)
    }

    /// `isRankReducedType(original, candidate) == Success`.
    fn rank_reduced(orig: &Type<'_>, cand: &Type<'_>) -> bool {
        let (Some(o), Some(c)) = (Self::dims(orig), Self::dims(cand)) else { return false };
        o.len() >= c.len() && Self::rank_reduction_mask(&o, &c, false).is_some() && attr::element_type(orig) == attr::element_type(cand)
    }

    /// `ExtractSliceOp::inferResultType`.
    fn slice_type<'a>(src: &Shaped<'a>, sizes: &[Ofr]) -> Type<'a> {
        let dims: Vec<i64> = sizes.iter().map(|s| if let Ofr::C(c) = s { *c } else { DYNAMIC }).collect();
        Self::with_dims(src, &dims)
    }

    /// `inferCanonicalRankReducedResultType`.
    fn rank_reduced_slice_type<'a>(rank: usize, src: &Shaped<'a>, sizes: &[Ofr]) -> Type<'a> {
        let inferred = Self::slice_type(src, sizes);
        let shape = Self::dims(&inferred).unwrap_or_default();
        if shape.len() <= rank {
            return inferred;
        }
        let mut drop = shape.len() - rank;
        let mut kept = Vec::new();
        for d in &shape {
            if *d == 1 && drop > 0 {
                drop -= 1;
                continue;
            }
            kept.push(*d);
        }
        Self::tensor(&kept, (*src.elem).clone(), Vec::new())
    }

    /// `verifyInBoundsSlice`.
    fn in_bounds(shape: &[i64], offsets: &[Ofr], sizes: &[Ofr], strides: &[Ofr]) -> bool {
        let st = |o: &Ofr| if let Ofr::C(c) = o { *c } else { DYNAMIC };
        for (i, s) in shape.iter().enumerate() {
            let (Some(o), Some(z), Some(t)) = (offsets.get(i).map(st), sizes.get(i).map(st), strides.get(i).map(st)) else { continue };
            if *s == DYNAMIC || o == DYNAMIC {
                continue;
            }
            if o >= *s {
                return false;
            }
            if z == DYNAMIC || t == DYNAMIC {
                continue;
            }
            if o + (z - 1) * t >= *s {
                return false;
            }
        }
        true
    }

    /// `PadOp::inferResultType`.
    fn pad_type<'a>(src: &Shaped<'a>, low: &[i64], high: &[i64], result: &[i64]) -> Option<Type<'a>> {
        let dims = Self::dims(&Type::Shaped(src.clone()))?;
        if low.len() != dims.len() || high.len() != dims.len() || (!result.is_empty() && result.len() != dims.len()) {
            return None;
        }
        let shape: Vec<i64> = (0..dims.len())
            .map(|i| if dims[i] == DYNAMIC || low[i] == DYNAMIC || high[i] == DYNAMIC { if result.is_empty() { DYNAMIC } else { result[i] } } else { dims[i] + low[i] + high[i] })
            .collect();
        Some(Self::tensor(&shape, (*src.elem).clone(), Vec::new()))
    }

    /// `CollapseShapeOp::inferCollapsedType`.
    fn collapsed_type<'a>(src: &Shaped<'a>, r: &Reassoc) -> Type<'a> {
        let dims = Self::dims(&Type::Shaped(src.clone())).unwrap_or_default();
        let mut at = 0;
        let mut shape = Vec::new();
        for g in r {
            let band = &dims[at..at + g.len()];
            shape.push(if band.contains(&DYNAMIC) { DYNAMIC } else { band.iter().product() });
            at += g.len();
        }
        Self::tensor(&shape, (*src.elem).clone(), Vec::new())
    }

    fn index<'a>(v: i64) -> Attribute<'a> {
        Attribute::Int { lit: Cow::Owned(format!("{v}")), ty: Some(Type::Index) }
    }

    fn dense_array<'a>(v: &[i64]) -> Attribute<'a> {
        Attribute::DenseArray { ty: Type::int(64), values: v.iter().map(|x| Cow::Owned(format!("{x}"))).collect() }
    }

    /// Mixed values as static values and the dynamic ones.
    fn split(list: &[Ofr]) -> (Vec<i64>, Vec<ValueId>) {
        let mut st = Vec::new();
        let mut dy = Vec::new();
        for o in list {
            match o {
                Ofr::C(c) => st.push(*c),
                Ofr::V(v) => {
                    st.push(DYNAMIC);
                    dy.push(*v);
                }
            }
        }
        (st, dy)
    }

    /// An op with leading operands and mixed lists stored as `names`.
    fn mixed_op<'a>(name: &str, lead: &[ValueId], lists: &[&[Ofr]], names: &[&str]) -> OpData<'a> {
        let mut ops = lead.to_vec();
        let mut segs = vec![1usize; lead.len()];
        let mut data = OpData::build(name);
        for (l, n) in lists.iter().zip(names) {
            let (st, dy) = Self::split(l);
            segs.push(dy.len());
            ops.extend(dy);
            data.set(n, Self::dense_array(&st));
        }
        data.operands(&ops).segments(&segs)
    }

    fn slice_op<'a>(name: &str, lead: &[ValueId], l: &[Vec<Ofr>; 3]) -> OpData<'a> {
        Self::mixed_op(name, lead, &[&l[0], &l[1], &l[2]], &["static_offsets", "static_sizes", "static_strides"])
    }

    /// `foldDynamicIndexList`.
    fn fold_list(b: &Body<'_>, list: &mut [Ofr], non_negative: bool, non_zero: bool) -> bool {
        let mut changed = false;
        for o in list.iter_mut() {
            let Ofr::V(v) = *o else { continue };
            let Some(c) = b.const_index(v) else { continue };
            if (non_negative && c < 0) || (non_zero && c == 0) {
                continue;
            }
            *o = Ofr::C(c);
            changed = true;
        }
        changed
    }
}

impl<'a> Body<'a> {
    /// Whether `v` is an `index` constant (`matchConstantIndex`).
    fn is_const_index(&self, v: ValueId) -> bool {
        matches!(self.constant_of(v), Some(Attribute::Int { ty: Some(Type::Index), .. }))
    }

    /// The offsets, sizes and strides of a slice op, after its leading operands.
    fn slice_lists(&self, op: OpId) -> [Vec<Ofr>; 3] {
        let segs = self.segments(op, "operandSegmentSizes").unwrap_or_default();
        let lead = segs.len().saturating_sub(3);
        let mut at: usize = segs[..lead].iter().sum();
        let mut out: [Vec<Ofr>; 3] = Default::default();
        for (k, name) in ["static_offsets", "static_sizes", "static_strides"].iter().enumerate() {
            let n = segs.get(lead + k).copied().unwrap_or(0);
            let mut d = self[op].operands[at..at + n].iter();
            out[k] = self.dense_i64(op, name).into_iter().map(|s| if s == DYNAMIC { Ofr::V(*d.next().expect("dynamic")) } else { Ofr::C(s) }).collect();
            at += n;
        }
        out
    }

    /// The `low` and `high` pads of a `tensor.pad`.
    fn pad_lists(&self, op: OpId) -> [Vec<Ofr>; 2] {
        let segs = self.segments(op, "operandSegmentSizes").unwrap_or_default();
        let mut at = 1;
        let mut out: [Vec<Ofr>; 2] = Default::default();
        for (k, name) in ["static_low", "static_high"].iter().enumerate() {
            let n = segs.get(k + 1).copied().unwrap_or(0);
            let mut d = self[op].operands[at..at + n].iter();
            out[k] = self.dense_i64(op, name).into_iter().map(|s| if s == DYNAMIC { Ofr::V(*d.next().expect("dynamic")) } else { Ofr::C(s) }).collect();
            at += n;
        }
        out
    }

    /// `foldIdentityOffsetSizeAndStrideOpInterface`.
    fn identity_slice(&self, op: OpId, shape: &[i64]) -> bool {
        let [o, s, t] = self.slice_lists(op);
        o.iter().all(|x| self.ofr_int(*x) == Some(0)) && s.iter().zip(shape).all(|(x, d)| self.ofr_int(*x) == Some(*d)) && t.iter().all(|x| self.ofr_int(*x) == Some(1))
    }

    /// `canFoldIntoConsumerOp`: a cast from a more static type.
    fn cast_into_consumer(&self, cast: OpId) -> bool {
        Tn::preserves(&self[self[cast].results[0]].ty, &self[self[cast].operands[0]].ty)
    }

    /// `canFoldIntoProducerOp`.
    fn cast_into_producer(&self, cast: OpId) -> bool {
        Tn::preserves(&self[self[cast].operands[0]].ty, &self[self[cast].results[0]].ty)
    }

    /// The `tensor.cast` defining `v`, if it can fold into its consumer.
    fn foldable_cast(&self, v: ValueId) -> Option<OpId> {
        self.def_named(v, "tensor.cast").filter(|c| self.cast_into_consumer(*c))
    }

    /// `foldDynamicToStaticDimSizes`.
    fn static_dims(&self, ty: &Type<'a>, dynamic: &[ValueId]) -> (Type<'a>, Vec<ValueId>) {
        let Some(s) = Tn::ranked(ty) else { return (ty.clone(), dynamic.to_vec()) };
        let mut dims = Tn::dims(ty).unwrap_or_default();
        let mut kept = Vec::new();
        let mut it = dynamic.iter();
        for d in dims.iter_mut() {
            if *d != DYNAMIC {
                continue;
            }
            let v = *it.next().expect("one per dynamic dim");
            match self.const_index(v) {
                Some(c) if c >= 0 => *d = c,
                _ => kept.push(v),
            }
        }
        (Tn::with_dims(s, &dims), kept)
    }

    /// `getDpsInitOperand` operands of a destination-style op.
    fn dps_inits(&self, op: OpId) -> Option<core::ops::Range<usize>> {
        let n = self[op].operands.len();
        match &*self[op].name {
            "tensor.insert_slice" | "tensor.insert" | "bufferization.materialize_in_destination" => Some(1..2),
            _ if !self.has(op, Trait::DestinationStyleOpInterface) => None,
            "test.destination_style_op" => {
                let s = self.segments(op, "operandSegmentSizes")?;
                Some(s[0]..s[0] + s[1])
            }
            _ => match self.segments(op, "operandSegmentSizes") {
                Some(s) => {
                    let last = *s.last()?;
                    Some(n - last..n)
                }
                None => Some(n - 1..n),
            },
        }
    }

    /// `PadOp::getConstantPaddingValue`.
    fn constant_padding(&self, pad: OpId) -> Option<ValueId> {
        let region = self[pad].regions[0];
        let block = *self[region].blocks.first()?;
        let y = *self[block].ops.last()?;
        if self[y].name != "tensor.yield" {
            return None;
        }
        let v = self[y].operands[0];
        if self.constant_of(v).is_some() {
            return Some(v);
        }
        match self.def_op(v) {
            Some(d) if self[d].parent == Some(block) => None,
            _ if matches!(self[v].def, crate::Def::Arg(b, _) if b == block) => None,
            _ => Some(v),
        }
    }
}

/// `reshapeConstantSource`: a splat resized to a static `ty`.
fn reshape_constant<'a>(c: Option<&Attribute<'a>>, ty: &Type<'a>) -> Option<Attribute<'a>> {
    let c = Const::try_from(c?).ok().filter(|c| c.elements && c.is_splat())?;
    Tn::static_shape(ty).then(|| Const { ty: ty.clone(), ..c }.into())
}

/// The fold of a `tensor` op.
pub fn fold<'a>(b: &mut Body<'a>, op: OpId, c: &[Option<Attribute<'a>>]) -> Fold<'a> {
    let name = b[op].name.clone();
    let ops = b[op].operands.clone();
    let Some(&res) = b[op].results.first() else { return Fold::Failed };
    let rt = b[res].ty.clone();
    match &*name {
        "tensor.concat" if ops.len() == 1 && b[ops[0]].ty == rt => Folded::Value(ops[0]).into(),
        "tensor.dim" => {
            let Some(i) = c[1].as_ref().and_then(|a| Const::try_from(a).ok()).filter(|c| !c.elements).and_then(|c| c.as_int()).map(|i| i.signed() as i64) else { return Fold::Failed };
            let Some(dims) = Tn::ranked(&b[ops[0]].ty).and_then(|_| Tn::dims(&b[ops[0]].ty)) else { return Fold::Failed };
            if i < 0 || i as usize >= dims.len() {
                return Fold::Failed;
            }
            if dims[i as usize] != DYNAMIC {
                return Folded::Attr(Tn::index(dims[i as usize])).into();
            }
            if let Some(g) = b.def_named(ops[0], "tensor.generate") {
                let k = dims[..i as usize].iter().filter(|d| **d == DYNAMIC).count();
                return Folded::Value(b[g].operands[k]).into();
            }
            if let Some(s) = b.def_named(ops[0], "tensor.extract_slice") {
                let src_rank = Tn::dims(&b[b[s].operands[0]].ty).map_or(0, |d| d.len());
                if src_rank == dims.len()
                    && let Ofr::V(v) = b.slice_lists(s)[1][i as usize]
                {
                    return Folded::Value(v).into();
                }
            }
            match b.foldable_cast(ops[0]) {
                Some(cast) => {
                    let src = b[cast].operands[0];
                    b.set_operand(op, 0, src);
                    Fold::InPlace
                }
                None => Fold::Failed,
            }
        }
        "tensor.extract" => {
            if let Some(k) = c[0].as_ref().and_then(|a| Const::try_from(a).ok()).filter(|k| k.elements && k.is_splat()) {
                return Folded::Attr(Const::scalar(k.values[0], attr::element_type(&k.ty).clone()).into()).into();
            }
            let mut idx = Vec::new();
            for a in &c[1..] {
                let Some(i) = a.as_ref().and_then(|a| Const::try_from(a).ok()).filter(|c| !c.elements).and_then(|c| c.as_int()) else { return Fold::Failed };
                idx.push(i.signed() as i64);
            }
            if let Some(fe) = b.def_named(ops[0], "tensor.from_elements") {
                let dims = Tn::dims(&b[b[fe].results[0]].ty).unwrap_or_default();
                let (mut flat, mut stride) = (0i64, 1i64);
                for i in (0..dims.len()).rev() {
                    flat += idx[i] * stride;
                    stride *= dims[i];
                }
                if flat < 0 || flat as usize >= b[fe].operands.len() {
                    return Fold::Failed;
                }
                return Folded::Value(b[fe].operands[flat as usize]).into();
            }
            if let Some(k) = c[0].as_ref().and_then(|a| Const::try_from(a).ok()).filter(|k| k.elements) {
                let dims = Tn::dims(&k.ty).unwrap_or_default();
                if idx.len() == dims.len() && idx.iter().zip(&dims).all(|(i, d)| *i >= 0 && i < d) {
                    let flat = idx.iter().zip(&dims).fold(0i64, |acc, (i, d)| acc * d + i);
                    return Folded::Attr(Const::scalar(k.at(flat as usize), attr::element_type(&k.ty).clone()).into()).into();
                }
            }
            // `foldExtractAfterInsert`.
            if let Some(ins) = b.def_named(ops[0], "tensor.insert") {
                let same = |x: ValueId, y: ValueId| x == y || b.constant_of(x).is_some_and(|a| Some(a) == b.constant_of(y));
                let ii = &b[ins].operands[2..];
                if b[b[ins].operands[0]].ty == rt && ii.len() == ops.len() - 1 && ii.iter().zip(&ops[1..]).all(|(x, y)| same(*x, *y)) {
                    return Folded::Value(b[ins].operands[0]).into();
                }
            }
            Fold::Failed
        }
        "tensor.from_elements" => {
            let Some(vals) = c.iter().map(|a| a.as_ref().and_then(|a| Const::try_from(a).ok()).filter(|c| !c.elements).map(|c| c.values[0])).collect::<Option<Vec<_>>>() else { return Fold::Failed };
            Folded::Attr(Const { ty: rt, values: vals, elements: true }.into()).into()
        }
        "tensor.gather" => reshape_constant(c[0].as_ref(), &rt).map_or(Fold::Failed, |a| Folded::Attr(a).into()),
        "tensor.insert" => {
            let (Some(s), Some(d)) = (c[0].as_ref().and_then(|a| Const::try_from(a).ok()), c[1].as_ref().and_then(|a| Const::try_from(a).ok())) else { return Fold::Failed };
            if d.elements && d.is_splat() && s.values.first() == d.values.first() && attr::element_type(&d.ty) == &s.ty {
                return Folded::Attr(c[1].clone().expect("constant")).into();
            }
            Fold::Failed
        }
        "tensor.rank" => match attr::shape_of(&b[ops[0]].ty) {
            Some(d) => Folded::Attr(Tn::index(d.len() as i64)).into(),
            None => Fold::Failed,
        },
        "tensor.reshape" => {
            if let Some(a) = reshape_constant(c[0].as_ref(), &rt) {
                return Folded::Attr(a).into();
            }
            if let Some(p) = b.def_named(ops[0], "tensor.reshape") {
                let s = b[p].operands[0];
                b.set_operand(op, 0, s);
                return Fold::InPlace;
            }
            let src = ops[0];
            if Tn::ranked(&b[src].ty).is_none() || b[src].ty != rt {
                return Fold::Failed;
            }
            let dims = Tn::dims(&rt).unwrap_or_default();
            if dims.len() <= 1 {
                return Folded::Value(src).into();
            }
            if let Some(fe) = b.def_named(ops[1], "tensor.from_elements") {
                let els = &b[fe].operands;
                let mut noop = dims.len() == els.len();
                for (id, e) in els.iter().enumerate() {
                    if !noop {
                        break;
                    }
                    if let Some(k) = b.const_index(*e) {
                        noop &= k == dims[id];
                        continue;
                    }
                    if let Some(d) = b.def_named(*e, "tensor.dim") {
                        noop &= b[d].operands[0] == src && b.const_index(b[d].operands[1]) == Some(id as i64);
                        continue;
                    }
                    noop = false;
                }
                if noop {
                    return Folded::Value(src).into();
                }
            }
            Fold::Failed
        }
        "tensor.expand_shape" => b.fold_reshape(op, "tensor.collapse_shape", c[0].as_ref()),
        "tensor.collapse_shape" => b.fold_reshape(op, "tensor.expand_shape", c[0].as_ref()),
        "tensor.extract_slice" => {
            if let Some(a) = reshape_constant(c[0].as_ref(), &rt) {
                return Folded::Attr(a).into();
            }
            let src = ops[0];
            if b[src].ty == rt && b.identity_slice(op, &Tn::dims(&rt).unwrap_or_default()) {
                return Folded::Value(src).into();
            }
            if let Some(ins) = b.def_named(src, "tensor.insert_slice")
                && b[b[ins].operands[0]].ty == rt
                && b.slice_lists(ins) == b.slice_lists(op)
            {
                return Folded::Value(b[ins].operands[0]).into();
            }
            Fold::Failed
        }
        "tensor.insert_slice" => {
            let (src, dst) = (ops[0], ops[1]);
            if Tn::static_shape(&b[src].ty) && Tn::static_shape(&rt) && b[src].ty == rt && b.identity_slice(op, &Tn::dims(&rt).unwrap_or_default()) {
                return Folded::Value(src).into();
            }
            if let Some(prev) = b.def_named(dst, "tensor.insert_slice")
                && b[b[prev].operands[0]].ty == b[src].ty
                && b.slice_lists(prev) == b.slice_lists(op)
            {
                let d = b[prev].operands[1];
                b.set_operand(op, 1, d);
                return Fold::InPlace;
            }
            if let Some(ext) = b.def_named(src, "tensor.extract_slice")
                && b[ext].operands[0] == dst
                && b.slice_lists(ext) == b.slice_lists(op)
            {
                return Folded::Value(b[ext].operands[0]).into();
            }
            if b.slice_lists(op)[1].iter().any(|s| b.ofr_int(*s) == Some(0)) {
                return Folded::Value(dst).into();
            }
            Fold::Failed
        }
        "tensor.pad" => {
            let src = ops[0];
            if Tn::static_shape(&rt) && rt == b[src].ty && b[op].get("nofold").is_none() {
                return Folded::Value(src).into();
            }
            Fold::Failed
        }
        "tensor.splat" => match &c[0] {
            Some(a @ (Attribute::Int { .. } | Attribute::Float { .. })) if Tn::static_shape(&rt) => match Const::try_from(a) {
                Ok(k) => Folded::Attr(Const::splat(k.values[0], rt).into()).into(),
                Err(()) => Fold::Failed,
            },
            _ => Fold::Failed,
        },
        _ => Fold::Failed,
    }
}

impl<'a> Rewriter<'_, 'a> {
    fn single(&mut self, data: OpData<'a>, ty: Type<'a>) -> ValueId {
        let o = self.create(data, &[ty]);
        self.body[o].results[0]
    }

    fn tensor_cast(&mut self, v: ValueId, ty: Type<'a>) -> ValueId {
        self.single(OpData::build("tensor.cast").operands(&[v]), ty)
    }

    /// `tensor.cast` replacing `op` by `v` as `ty`.
    fn replace_with_cast(&mut self, op: OpId, v: ValueId, ty: Type<'a>) {
        self.replace_with(op, OpData::build("tensor.cast").operands(&[v]), &[ty]);
    }

    /// A `tensor.pad` like `pad` (its discardable attributes kept), without its region.
    fn pad_data(&self, pad: OpId, src: ValueId, low: &[Ofr], high: &[Ofr]) -> OpData<'a> {
        let b = &*self.body;
        let mut d = Tn::mixed_op("tensor.pad", &[src], &[low, high], &["static_low", "static_high"]);
        if b[pad].get("nofold").is_some() {
            d.set("nofold", Attribute::Unit);
        }
        d.attrs(b[pad].attributes.clone())
    }

    /// The pad op `data` of `ty`; its region cloned from `from` (or moved when `take`).
    fn new_pad(&mut self, data: OpData<'a>, ty: Type<'a>, from: OpId, take: bool) -> OpId {
        let new = self.create_with(data, &[ty], |b, p| {
            b.add_region(p);
        });
        let (src, into) = (self.body[from].regions[0], self.body[new].regions[0]);
        if take {
            self.inline_region_before(src, into, None);
        } else {
            self.clone_region_before(src, into, None, &mut Mapping::default());
        }
        new
    }

    /// The parent of `op` when it combines parallel results (`InParallelOpInterface`).
    fn before_parallel_parent(&mut self, op: OpId) {
        if let Some(p) = self.body.parent_op(op).filter(|p| self.body[*p].name == "scf.forall.in_parallel") {
            self.set_before(p);
        } else {
            self.set_before(op);
        }
    }
}

/// `OpWithOffsetSizesAndStridesConstantArgumentFolder` (extract) / `InsertSliceOpConstantArgumentFolder`.
fn constant_slice_arguments(rw: &mut Rewriter<'_, '_>, op: OpId, insert: bool) -> bool {
    let b = &*rw.body;
    let [mut o, mut s, mut t] = b.slice_lists(op);
    let changed = if insert {
        let a = Tn::fold_list(b, &mut o, true, false);
        let bb = Tn::fold_list(b, &mut s, true, false);
        let c = Tn::fold_list(b, &mut t, false, true);
        a || bb || c
    } else {
        let a = Tn::fold_list(b, &mut o, true, false);
        let bb = Tn::fold_list(b, &mut s, true, false);
        let c = Tn::fold_list(b, &mut t, false, false);
        a || bb || c
    };
    if !changed {
        return false;
    }
    let base = b[op].operands[usize::from(insert)];
    let Some(bt) = Tn::ranked(&b[base].ty).cloned() else { return false };
    if !Tn::in_bounds(&Tn::dims(&b[base].ty).unwrap_or_default(), &o, &s, &t) {
        return false;
    }
    let name = b[op].name.clone();
    let lists = [o, s, t];
    if insert {
        let src = b[op].operands[0];
        let rank = Tn::dims(&b[src].ty).map_or(0, |d| d.len());
        let ty = Tn::rank_reduced_slice_type(rank, &bt, &lists[1]);
        let result_types = b.types(&b[op].results);
        let mut to_insert = src;
        if ty != b[src].ty {
            let saved = rw.ip;
            rw.before_parallel_parent(op);
            to_insert = rw.tensor_cast(src, ty);
            rw.ip = saved;
        }
        let dst = rw.body[op].operands[1];
        rw.replace_with(op, Tn::slice_op(&name, &[to_insert, dst], &lists), &result_types);
    } else {
        let rt = b[b[op].results[0]].ty.clone();
        let rank = Tn::dims(&rt).map_or(0, |d| d.len());
        let ty = Tn::rank_reduced_slice_type(rank, &bt, &lists[1]);
        rw.set_before(op);
        let mut v = rw.single(Tn::slice_op(&name, &[base], &lists), ty.clone());
        if ty != rt {
            v = rw.tensor_cast(v, rt);
        }
        rw.replace_op(op, &[v]);
    }
    true
}

/// `InsertSliceOpCastFolder`.
fn insert_slice_cast(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
    let b = &*rw.body;
    if b[op].operands.iter().any(|v| b.is_const_index(*v)) {
        return false;
    }
    let (src0, dst0) = (b[op].operands[0], b[op].operands[1]);
    let (sc, dc) = (b.foldable_cast(src0).map(|c| b[c].operands[0]), b.foldable_cast(dst0).map(|c| b[c].operands[0]));
    if sc.is_none() && dc.is_none() {
        return false;
    }
    let (src, dst) = (sc.unwrap_or(src0), dc.unwrap_or(dst0));
    let (Some(st), Some(dt)) = (Tn::ranked(&b[src].ty).cloned(), Tn::ranked(&b[dst].ty).cloned()) else { return false };
    let sdims = Tn::dims(&b[src].ty).unwrap_or_default();
    let mut static_sizes = b.dense_i64(op, "static_sizes");
    let Some(mask) = Tn::rank_reduction_mask(&static_sizes, &sdims, true) else { return false };
    let [o, mut s, t] = b.slice_lists(op);
    let mut j = 0;
    for (idx, size) in static_sizes.iter_mut().enumerate() {
        if !mask.contains(&idx) && sdims.get(j).is_some_and(|d| *d != DYNAMIC) {
            s[idx] = Ofr::C(sdims[j]);
            *size = sdims[j];
            j += 1;
        }
    }
    let expected = Tn::with_dims(&dt, &static_sizes);
    if !Tn::rank_reduced(&expected, &Type::Shaped(st)) {
        return false;
    }
    if !Tn::in_bounds(&Tn::dims(&b[dst].ty).unwrap_or_default(), &o, &s, &t) {
        return false;
    }
    let parallel = b[op].name == "tensor.parallel_insert_slice";
    let name = b[op].name.clone();
    let old_dst_ty = b[dst0].ty.clone();
    let new_dst_ty = b[dst].ty.clone();
    rw.set_before(op);
    let lists = [o, s, t];
    let data = Tn::slice_op(&name, &[src, dst], &lists);
    if parallel {
        rw.create(data, &[]);
        rw.erase_op(op);
        return true;
    }
    let mut v = rw.single(data, new_dst_ty.clone());
    if new_dst_ty != old_dst_ty {
        v = rw.tensor_cast(v, old_dst_ty);
    }
    rw.replace_op(op, &[v]);
    true
}

/// `InsertSliceOpSourceCastInserter`.
fn insert_slice_source_cast(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
    let b = &*rw.body;
    let (src, dst) = (b[op].operands[0], b[op].operands[1]);
    let (Some(st), Some(sd), Some(dd)) = (Tn::ranked(&b[src].ty).cloned(), Tn::dims(&b[src].ty), Tn::dims(&b[dst].ty)) else { return false };
    if sd.len() != dd.len() {
        return false;
    }
    let lists = b.slice_lists(op);
    let mut shape = sd.clone();
    for (i, d) in shape.iter_mut().enumerate() {
        if let Some(c) = b.ofr_int(lists[1][i]) {
            if c < 0 {
                return false;
            }
            *d = c;
        }
    }
    let new_ty = Tn::with_dims(&st, &shape);
    let compatible = sd.iter().zip(&shape).all(|(a, c)| *a == DYNAMIC || *c == DYNAMIC || a == c);
    if b[src].ty == new_ty || !Tn::preserves(&b[src].ty, &new_ty) || !compatible {
        return false;
    }
    let name = b[op].name.clone();
    let types = b.types(&b[op].results);
    let saved = rw.ip;
    rw.before_parallel_parent(op);
    let cast = rw.tensor_cast(src, new_ty);
    rw.ip = saved;
    rw.replace_with(op, Tn::slice_op(&name, &[cast, dst], &lists), &types);
    true
}

rewrites! {
    /// `ChainedTensorBitcast`.
    ChainedTensorBitcast("tensor.bitcast", 1) |rw, op| {
        let b = &*rw.body;
        let Some(inner) = b.def_named(b[op].operands[0], "tensor.bitcast") else { return false };
        let (src, ty) = (b[inner].operands[0], b[b[op].results[0]].ty.clone());
        rw.replace_with(op, OpData::build("tensor.bitcast").operands(&[src]), &[ty]);
        true
    }

    /// `ChainedTensorCast`.
    ChainedTensorCast("tensor.cast", 1) |rw, op| {
        let b = &*rw.body;
        let Some(inner) = b.def_named(b[op].operands[0], "tensor.cast") else { return false };
        let src = b[inner].operands[0];
        let (s, m, r) = (b[src].ty.clone(), b[b[inner].results[0]].ty.clone(), b[b[op].results[0]].ty.clone());
        let Some(first) = Tn::join(&s, &m).and_then(|j| Tn::join(&j, &r)) else { return false };
        if Some(first) != Tn::join(&s, &r) {
            return false;
        }
        rw.replace_with_cast(op, src, r);
        true
    }

    /// `TensorCastExtractSlice`.
    TensorCastExtractSlice("tensor.cast", 1) |rw, op| {
        let b = &*rw.body;
        let rt = b[b[op].results[0]].ty.clone();
        let Some(rdims) = Tn::ranked(&rt).and_then(|_| Tn::dims(&rt)) else { return false };
        let Some(ext) = b.def_named(b[op].operands[0], "tensor.extract_slice") else { return false };
        if !b.cast_into_producer(op) || Some(&rdims) == Tn::dims(&b[b[op].operands[0]].ty).as_ref() {
            return false;
        }
        let [o, mut s, t] = b.slice_lists(ext);
        let mask = Tn::rank_reduction_mask(&b.dense_i64(ext, "static_sizes"), &Tn::dims(&b[b[ext].results[0]].ty).unwrap_or_default(), false);
        let mut j = 0;
        for (i, size) in s.iter_mut().enumerate() {
            if mask.as_ref().is_some_and(|m| m.contains(&i)) {
                continue;
            }
            let d = rdims[j];
            j += 1;
            if d != DYNAMIC {
                *size = Ofr::C(d);
            }
        }
        let src = b[ext].operands[0];
        rw.replace_with(op, Tn::slice_op("tensor.extract_slice", &[src], &[o, s, t]), &[rt]);
        true
    }

    /// `FoldReshapeWithConstant<CollapseShapeOp>`.
    CollapseWithConstant("tensor.collapse_shape", 1) |rw, op| {
        reshape_with_constant(rw, op)
    }

    /// `FoldReshapeWithSplat<CollapseShapeOp>`.
    CollapseWithSplat("tensor.collapse_shape", 1) |rw, op| {
        reshape_with_splat(rw, op)
    }

    /// `FoldReshapeWithFromElements<CollapseShapeOp>`.
    CollapseWithFromElements("tensor.collapse_shape", 1) |rw, op| {
        reshape_with_from_elements(rw, op)
    }

    /// `FoldCollapseOfCastOp`.
    FoldCollapseOfCastOp("tensor.collapse_shape", 1) |rw, op| {
        let b = &*rw.body;
        let Some(cast) = b.foldable_cast(b[op].operands[0]) else { return false };
        let src = b[cast].operands[0];
        let Some(st) = Tn::ranked(&b[src].ty).cloned() else { return false };
        let r = b.reassociation(op);
        let new_ty = Tn::collapsed_type(&st, &r);
        let rt = b[b[op].results[0]].ty.clone();
        if new_ty == rt {
            rw.modify(op, |b| b.set_operand(op, 0, src));
        } else {
            rw.set_before(op);
            let n = rw.single(OpData::build("tensor.collapse_shape").operands(&[src]).with("reassociation", Reshape::attr(&r)), new_ty);
            rw.replace_with_cast(op, n, rt);
        }
        true
    }

    /// `SingleInputConcatOp`.
    SingleInputConcatOp("tensor.concat", 1) |rw, op| {
        let b = &*rw.body;
        let [v] = b[op].operands[..] else { return false };
        let rt = b[b[op].results[0]].ty.clone();
        rw.replace_with_cast(op, v, rt);
        true
    }

    /// `InferConcatOperandTypes`.
    InferConcatOperandTypes("tensor.concat", 1) |rw, op| {
        let b = &*rw.body;
        let dim = concat_dim(b, op);
        let Some(inferred) = concat_type(b, op, dim) else { return false };
        let mut shape = Tn::dims(&inferred).unwrap_or_default();
        let mut casts = Vec::new();
        for (i, v) in b[op].operands.iter().enumerate() {
            let Some(d) = Tn::dims(&b[*v].ty) else { return false };
            shape[dim] = d[dim];
            let t = Tn::tensor(&shape, attr::element_type(&inferred).clone(), Vec::new());
            if !Tn::preserves(&t, &b[*v].ty) {
                casts.push((i, *v, t));
            }
        }
        if casts.is_empty() {
            return false;
        }
        for (i, v, t) in casts {
            rw.set_before(op);
            let c = rw.tensor_cast(v, t);
            rw.modify(op, |b| b.set_operand(op, i, c));
        }
        true
    }

    /// `InferConcatResultType`.
    InferConcatResultType("tensor.concat", 1) |rw, op| {
        let b = &*rw.body;
        let dim = concat_dim(b, op);
        let Some(inferred) = concat_type(b, op, dim) else { return false };
        let rt = b[b[op].results[0]].ty.clone();
        if Tn::preserves(&inferred, &rt) {
            return false;
        }
        let data = OpData::build("tensor.concat").operands(&b[op].operands.clone()).with("dim", b[op].get("dim").cloned().unwrap_or(Attribute::Unit));
        rw.set_before(op);
        let n = rw.single(data, inferred);
        rw.replace_with_cast(op, n, rt);
        true
    }

    /// `DimOfCastOp`.
    DimOfCastOp("tensor.dim", 1) |rw, op| {
        let b = &*rw.body;
        let Some(cast) = b.def_named(b[op].operands[0], "tensor.cast") else { return false };
        let (src, i) = (b[cast].operands[0], b[op].operands[1]);
        rw.replace_with(op, OpData::build("tensor.dim").operands(&[src, i]), &[Type::Index]);
        true
    }

    /// `DimOfDestStyleOp`.
    DimOfDestStyleOp("tensor.dim", 1) |rw, op| {
        let b = &*rw.body;
        let src = b[op].operands[0];
        let (Some(d), crate::Def::Result(_, k)) = (b.def_op(src), b[src].def) else { return false };
        let Some(inits) = b.dps_inits(d) else { return false };
        let Some(&init) = b[d].operands.get(inits.start + k as usize) else { return false };
        rw.modify(op, |b| b.set_operand(op, 0, init));
        true
    }

    /// `DimOfReshapeOp`.
    DimOfReshapeOp("tensor.dim", 1) |rw, op| {
        let b = &*rw.body;
        let Some(r) = b.def_named(b[op].operands[0], "tensor.reshape") else { return false };
        let (shape, i) = (b[r].operands[1], b[op].operands[1]);
        let elem = attr::element_type(&b[shape].ty).clone();
        rw.set_after(op);
        let mut v = rw.single(OpData::build("tensor.extract").operands(&[shape, i]), elem.clone());
        if elem != Type::Index {
            v = rw.single(OpData::build("arith.index_cast").operands(&[v]), Type::Index);
        }
        rw.replace_op(op, &[v]);
        true
    }

    /// `FoldEmptyTensorWithCastOp`.
    FoldEmptyTensorWithCastOp("tensor.cast", 1) |rw, op| {
        let b = &*rw.body;
        if !b.cast_into_producer(op) {
            return false;
        }
        let Some(e) = b.def_named(b[op].operands[0], "tensor.empty") else { return false };
        let rt = b[b[op].results[0]].ty.clone();
        let (Some(rs), Some(ed)) = (Tn::dims(&rt), Tn::dims(&b[b[e].results[0]].ty)) else { return false };
        let mut dynamic = b[e].operands.iter();
        let mut dims = Vec::new();
        let mut kept = Vec::new();
        for (n, cur) in rs.iter().zip(&ed) {
            if *cur != DYNAMIC {
                if *n == DYNAMIC || n != cur {
                    return false;
                }
                dims.push(*cur);
                continue;
            }
            let v = *dynamic.next().expect("dynamic size");
            if *n != DYNAMIC {
                dims.push(*n);
            } else {
                dims.push(DYNAMIC);
                kept.push(v);
            }
        }
        let ty = Tn::tensor(&dims, attr::element_type(&rt).clone(), Vec::new());
        rw.replace_with(op, OpData::build("tensor.empty").operands(&kept), &[ty]);
        true
    }

    /// `FoldEmptyTensorWithDimOp`.
    FoldEmptyTensorWithDimOp("tensor.dim", 1) |rw, op| {
        let b = &*rw.body;
        let Some(i) = b.const_index(b[op].operands[1]) else { return false };
        let Some(e) = b.def_named(b[op].operands[0], "tensor.empty") else { return false };
        let dims = Tn::dims(&b[b[e].results[0]].ty).unwrap_or_default();
        if i < 0 || i as usize >= dims.len() || dims[i as usize] != DYNAMIC {
            return false;
        }
        let k = dims[..i as usize].iter().filter(|d| **d == DYNAMIC).count();
        let v = b[e].operands[k];
        rw.replace_op(op, &[v]);
        true
    }

    /// `ReplaceEmptyTensorStaticShapeDims`.
    ReplaceEmptyTensorStaticShapeDims("tensor.empty", 1) |rw, op| {
        let b = &*rw.body;
        let ty = b[b[op].results[0]].ty.clone();
        let (new_ty, kept) = b.static_dims(&ty, &b[op].operands);
        if new_ty == ty {
            return false;
        }
        rw.set_before(op);
        let n = rw.single(OpData::build("tensor.empty").operands(&kept), new_ty);
        rw.replace_with_cast(op, n, ty);
        true
    }

    /// `ConvertToStaticExpandShape`.
    ConvertToStaticExpandShape("tensor.expand_shape", 1) |rw, op| {
        let b = &*rw.body;
        let Some(cast) = b.foldable_cast(b[op].operands[0]) else { return false };
        let cast_src = Tn::dims(&b[b[cast].operands[0]].ty).unwrap_or_default();
        let r = b.reassociation(op);
        let rt = b[b[op].results[0]].ty.clone();
        let mut out = Tn::dims(&rt).unwrap_or_default();
        let mut dynamic = Vec::new();
        let mut it = b[op].operands[1..].iter();
        for (in_dim, g) in r.iter().enumerate() {
            for od in g {
                if out[*od as usize] != DYNAMIC {
                    continue;
                }
                let v = *it.next().expect("dynamic output size");
                if cast_src[in_dim] == DYNAMIC {
                    dynamic.push(v);
                    continue;
                }
                match b.constant_of(v).and_then(|a| Const::try_from(&a).ok()).filter(|c| !c.elements).and_then(|c| c.as_int()) {
                    Some(c) => out[*od as usize] = c.signed() as i64,
                    None => dynamic.push(v),
                }
            }
        }
        if b[op].operands.len() - 1 == dynamic.len() {
            return false;
        }
        let src_ty = b[b[op].operands[0]].ty.clone();
        let elem = attr::element_type(&src_ty).clone();
        let mut input = vec![1i64; Tn::dims(&src_ty).map_or(0, |d| d.len())];
        for (i, d) in input.iter_mut().enumerate() {
            for od in &r[i] {
                let o = out[*od as usize];
                if o == DYNAMIC {
                    *d = DYNAMIC;
                    break;
                }
                *d *= o;
            }
        }
        let mut dyn_it = dynamic.into_iter();
        let shape: Vec<Ofr> = out.iter().map(|d| if *d == DYNAMIC { Ofr::V(dyn_it.next().expect("dynamic")) } else { Ofr::C(*d) }).collect();
        let src = b[op].operands[0];
        rw.set_before(op);
        let cin = rw.tensor_cast(src, Tn::tensor(&input, elem.clone(), Vec::new()));
        let n = rw.single(expand_data(cin, &r, &shape), Tn::tensor(&out, elem, Vec::new()));
        rw.replace_with_cast(op, n, rt);
        true
    }

    /// `FoldReshapeWithConstant<ExpandShapeOp>`.
    ExpandWithConstant("tensor.expand_shape", 1) |rw, op| {
        reshape_with_constant(rw, op)
    }

    /// `FoldReshapeWithSplat<ExpandShapeOp>`.
    ExpandWithSplat("tensor.expand_shape", 1) |rw, op| {
        reshape_with_splat(rw, op)
    }

    /// `FoldReshapeWithFromElements<ExpandShapeOp>`.
    ExpandWithFromElements("tensor.expand_shape", 1) |rw, op| {
        reshape_with_from_elements(rw, op)
    }

    /// `ExtractFromTensorCast`.
    ExtractFromTensorCast("tensor.extract", 1) |rw, op| {
        let b = &*rw.body;
        let Some(cast) = b.def_named(b[op].operands[0], "tensor.cast") else { return false };
        let src = b[cast].operands[0];
        if Tn::ranked(&b[src].ty).is_none() {
            return false;
        }
        let mut ops = vec![src];
        ops.extend(&b[op].operands[1..]);
        let ty = b[b[op].results[0]].ty.clone();
        rw.replace_with(op, OpData::build("tensor.extract").operands(&ops), &[ty]);
        true
    }

    /// `OpWithOffsetSizesAndStridesConstantArgumentFolder<ExtractSliceOp>`.
    ExtractSliceConstantArguments("tensor.extract_slice", 1) |rw, op| {
        constant_slice_arguments(rw, op, false)
    }

    /// `ExtractSliceOpCastFolder`.
    ExtractSliceOpCastFolder("tensor.extract_slice", 1) |rw, op| {
        let b = &*rw.body;
        if b[op].operands.iter().any(|v| b.is_const_index(*v)) {
            return false;
        }
        let Some(cast) = b.foldable_cast(b[op].operands[0]) else { return false };
        let src = b[cast].operands[0];
        let lists = b.slice_lists(op);
        if !Tn::in_bounds(&Tn::dims(&b[src].ty).unwrap_or_default(), &lists[0], &lists[1], &lists[2]) {
            return false;
        }
        let ty = b[b[op].results[0]].ty.clone();
        rw.replace_with(op, Tn::slice_op("tensor.extract_slice", &[src], &lists), &[ty]);
        true
    }

    /// `ExtractElementFromIndexCast`.
    ExtractElementFromIndexCast("tensor.extract", 1) |rw, op| {
        let b = &*rw.body;
        let Some(ic) = b.def_named(b[op].operands[0], "arith.index_cast") else { return false };
        let input = b[ic].operands[0];
        let elem = attr::element_type(&b[input].ty).clone();
        let mut ops = vec![input];
        ops.extend(&b[op].operands[1..]);
        let ty = b[b[op].results[0]].ty.clone();
        rw.set_before(op);
        let e = rw.single(OpData::build("tensor.extract").operands(&ops), elem);
        rw.replace_with(op, OpData::build("arith.index_cast").operands(&[e]), &[ty]);
        true
    }

    /// `ExtractFromTensorGenerate`.
    ExtractFromTensorGenerate("tensor.extract", 1) |rw, op| {
        let b = &*rw.body;
        let Some(g) = b.def_named(b[op].operands[0], "tensor.generate") else { return false };
        if !b.would_be_trivially_dead(g) {
            return false;
        }
        let region = b[g].regions[0];
        let block = b[region].blocks[0];
        let mut map = Mapping::default();
        for (a, i) in b[block].args.iter().zip(&b[op].operands[1..]) {
            map.map(*a, *i);
        }
        let body_ops = b[block].ops.clone();
        let (last, rest) = body_ops.split_last().expect("terminated");
        let yielded = b[*last].operands[0];
        rw.set_before(op);
        for o in rest {
            rw.clone(*o, &mut map);
        }
        rw.replace_op(op, &[map.get(yielded)]);
        true
    }

    /// `StaticTensorGenerate`.
    StaticTensorGenerate("tensor.generate", 1) |rw, op| {
        let b = &*rw.body;
        let ty = b[b[op].results[0]].ty.clone();
        let (new_ty, kept) = b.static_dims(&ty, &b[op].operands);
        if new_ty == ty {
            return false;
        }
        rw.set_before(op);
        let new = rw.create_with(OpData::build("tensor.generate").operands(&kept), &[new_ty], |b, g| {
            b.add_region(g);
        });
        let (from, into) = (rw.body[op].regions[0], rw.body[new].regions[0]);
        rw.inline_region_before(from, into, None);
        let v = rw.body[new].results[0];
        rw.replace_with_cast(op, v, ty);
        true
    }

    InsertSliceConstantArguments("tensor.insert_slice", 1) |rw, op| {
        constant_slice_arguments(rw, op, true)
    }

    InsertSliceOpCastFolder("tensor.insert_slice", 1) |rw, op| {
        insert_slice_cast(rw, op)
    }

    InsertSliceOpSourceCastInserter("tensor.insert_slice", 1) |rw, op| {
        insert_slice_source_cast(rw, op)
    }

    /// `FoldStaticZeroPadding`.
    FoldStaticZeroPadding("tensor.pad", 1) |rw, op| {
        let b = &*rw.body;
        let [l, h] = b.pad_lists(op);
        if !l.iter().chain(&h).all(|x| b.ofr_int(*x) == Some(0)) || b[op].get("nofold").is_some() {
            return false;
        }
        let (src, ty) = (b[op].operands[0], b[b[op].results[0]].ty.clone());
        rw.replace_with_cast(op, src, ty);
        true
    }

    /// `FoldSourceTensorCast`.
    FoldSourceTensorCast("tensor.pad", 1) |rw, op| {
        let b = &*rw.body;
        let src = b[op].operands[0];
        let Some(cast) = b.foldable_cast(src) else { return false };
        let cs = b[cast].operands[0];
        let rt = b[b[op].results[0]].ty.clone();
        let Some(st) = Tn::ranked(&b[cs].ty).cloned() else { return false };
        let Some(new_ty) = Tn::pad_type(&st, &b.dense_i64(op, "static_low"), &b.dense_i64(op, "static_high"), &Tn::dims(&rt).unwrap_or_default()) else { return false };
        if new_ty == rt {
            rw.modify(op, |b| b.set_operand(op, 0, cs));
            return true;
        }
        let [l, h] = b.pad_lists(op);
        let data = rw.pad_data(op, src, &l, &h);
        rw.set_before(op);
        let new = rw.new_pad(data, new_ty, op, false);
        let v = rw.body[new].results[0];
        rw.replace_with_cast(op, v, rt);
        true
    }

    /// `FoldTargetTensorCast`.
    FoldTargetTensorCast("tensor.pad", 1) |rw, op| {
        let b = &*rw.body;
        let r = b[op].results[0];
        let [u] = b[r].uses[..] else { return false };
        let cast = u.op;
        if b[cast].name != "tensor.cast" {
            return false;
        }
        let ct = b[b[cast].results[0]].ty.clone();
        if !Tn::preserves(&b[r].ty, &ct) {
            return false;
        }
        let [l, h] = b.pad_lists(op);
        let data = rw.pad_data(op, b[op].operands[0], &l, &h);
        rw.set_before(op);
        let new = rw.new_pad(data, ct, op, true);
        let v = rw.body[new].results[0];
        rw.replace_op(op, &[v]);
        rw.replace_op(cast, &[v]);
        true
    }

    /// `FoldOrthogonalPaddings`.
    FoldOrthogonalPaddings("tensor.pad", 1) |rw, op| {
        let b = &*rw.body;
        let Some(inner) = b.def_named(b[op].operands[0], "tensor.extract_slice") else { return false };
        let Some(outer_pad) = b.def_named(b[inner].operands[0], "tensor.pad").filter(|p| b[*p].get("nofold").is_none()) else { return false };
        let Some(outer) = b.def_named(b[outer_pad].operands[0], "tensor.extract_slice") else { return false };
        let rank = Tn::dims(&b[b[op].operands[0]].ty).map_or(0, |d| d.len());
        if Tn::dims(&b[b[outer].operands[0]].ty).map_or(0, |d| d.len()) != rank {
            return false;
        }
        let (il, ol) = (b.slice_lists(inner), b.slice_lists(outer));
        if !il[2].iter().chain(&ol[2]).all(|s| b.ofr_int(*s) == Some(1)) {
            return false;
        }
        let ([pl, ph], [ql, qh]) = (b.pad_lists(op), b.pad_lists(outer_pad));
        if !pl.iter().chain(&ql).all(|x| b.ofr_int(*x) == Some(0)) {
            return false;
        }
        let (Some(iv), Some(ov)) = (b.constant_padding(op), b.constant_padding(outer_pad)) else { return false };
        let (Some(ia), Some(oa)) = (b.constant_of(iv), b.constant_of(ov)) else { return false };
        if ia != oa {
            return false;
        }
        let padded = |l: &[Ofr], h: &[Ofr]| -> Vec<bool> { (0..rank).map(|i| b.ofr_int(l[i]) != Some(0) || b.ofr_int(h[i]) != Some(0)).collect() };
        let (idims, odims) = (padded(&pl, &ph), padded(&ql, &qh));
        if idims.iter().zip(&odims).any(|(x, y)| *x && *y) {
            return false;
        }
        let mut offsets = Vec::new();
        for i in 0..rank {
            if !idims[i] && b.ofr_int(il[0][i]) == Some(0) {
                offsets.push(ol[0][i]);
                continue;
            }
            if !odims[i] && b.ofr_int(ol[0][i]) == Some(0) {
                offsets.push(il[0][i]);
                continue;
            }
            return false;
        }
        let isrc = Tn::dims(&b[b[inner].operands[0]].ty).unwrap_or_default();
        let mut sizes = il[1].clone();
        for i in 0..rank {
            if !odims[i] {
                continue;
            }
            if b.ofr_int(il[1][i]) != Some(isrc[i]) {
                return false;
            }
            sizes[i] = ol[1][i];
        }
        let high: Vec<Ofr> = (0..rank).map(|i| if odims[i] { qh[i] } else if idims[i] { ph[i] } else { Ofr::C(0) }).collect();
        let strides = il[2].clone();
        let base = b[outer].operands[0];
        let rt = b[b[op].results[0]].ty.clone();
        let Some(bt) = Tn::ranked(&b[base].ty).cloned() else { return false };
        rw.set_before(op);
        let slice_ty = Tn::slice_type(&bt, &sizes);
        let s = rw.single(Tn::slice_op("tensor.extract_slice", &[base], &[offsets, sizes, strides]), slice_ty);
        let data = rw.pad_data(op, s, &pl, &high);
        let new = rw.new_pad(data, rt, op, true);
        let v = rw.body[new].results[0];
        rw.replace_op(op, &[v]);
        true
    }

    /// `FoldStaticPadding`.
    FoldStaticPadding("tensor.pad", 1) |rw, op| {
        let b = &*rw.body;
        let input = b[op].operands[0];
        let (Some(st), Some(idims)) = (Tn::ranked(&b[input].ty).cloned(), Tn::dims(&b[input].ty)) else { return false };
        let rt = b[b[op].results[0]].ty.clone();
        let Some(odims) = Tn::ranked(&rt).and_then(|_| Tn::dims(&rt)) else { return false };
        let segs = b.segments(op, "operandSegmentSizes").unwrap_or_default();
        let (nl, nh) = (segs.get(1).copied().unwrap_or(0), segs.get(2).copied().unwrap_or(0));
        let lows = b[op].operands[1..1 + nl].to_vec();
        let highs = b[op].operands[1 + nl..1 + nl + nh].to_vec();
        let consts = |vs: &[ValueId]| -> (Vec<i64>, Vec<ValueId>) {
            let mut c = Vec::new();
            let mut keep = Vec::new();
            for v in vs {
                match b.constant_of(*v).and_then(|a| Const::try_from(&a).ok()).filter(|c| !c.elements).and_then(|c| c.as_int()) {
                    Some(i) => c.push(i.signed() as i64),
                    None => {
                        c.push(DYNAMIC);
                        keep.push(*v);
                    }
                }
            }
            (c, keep)
        };
        let ((cl, new_lows), (ch, new_highs)) = (consts(&lows), consts(&highs));
        let (mut low, mut high) = (b.dense_i64(op, "static_low"), b.dense_i64(op, "static_high"));
        if idims.len() != odims.len() || idims.len() != low.len() || idims.len() != high.len() {
            return false;
        }
        let (mut li, mut hi) = (cl.into_iter(), ch.into_iter());
        for i in 0..idims.len() {
            if low[i] == DYNAMIC {
                low[i] = li.next().expect("dynamic low");
            }
            if high[i] == DYNAMIC {
                high[i] = hi.next().expect("dynamic high");
            }
        }
        let new_out: Vec<i64> = (0..idims.len())
            .map(|i| if odims[i] == DYNAMIC { if low[i] == DYNAMIC || high[i] == DYNAMIC || idims[i] == DYNAMIC { DYNAMIC } else { idims[i] + low[i] + high[i] } } else { odims[i] })
            .collect();
        if new_out == odims || new_out.iter().all(|x| *x == DYNAMIC) {
            return false;
        }
        let new_ty = Tn::tensor(&new_out, (*st.elem).clone(), Vec::new());
        let (mut lv, mut hv) = (new_lows.into_iter(), new_highs.into_iter());
        let lo: Vec<Ofr> = low.iter().map(|x| if *x == DYNAMIC { Ofr::V(lv.next().expect("value")) } else { Ofr::C(*x) }).collect();
        let ho: Vec<Ofr> = high.iter().map(|x| if *x == DYNAMIC { Ofr::V(hv.next().expect("value")) } else { Ofr::C(*x) }).collect();
        let data = rw.pad_data(op, input, &lo, &ho);
        rw.set_before(op);
        let new = rw.new_pad(data, new_ty, op, false);
        let v = rw.body[new].results[0];
        rw.replace_with_cast(op, v, rt);
        true
    }

    /// `FoldConsecutiveConstantPadding`.
    FoldConsecutiveConstantPadding("tensor.pad", 1) |rw, op| {
        let b = &*rw.body;
        if b[op].get("nofold").is_some() {
            return false;
        }
        let Some(p) = b.def_named(b[op].operands[0], "tensor.pad").filter(|p| b[*p].get("nofold").is_none()) else { return false };
        let (Some(cv), Some(pv)) = (b.constant_padding(op), b.constant_padding(p)) else { return false };
        if cv != pv {
            return false;
        }
        let ([cl, ch], [pl, ph]) = (b.pad_lists(op), b.pad_lists(p));
        let src = b[p].operands[0];
        let rt = b[b[op].results[0]].ty.clone();
        let sum = AffineMap { dims: 2, syms: 0, results: vec![AffineExpr::Dim(0).add(AffineExpr::Dim(1))] };
        rw.set_before(op);
        let high: Vec<Ofr> = ch.iter().zip(&ph).map(|(c, p)| rw.composed_folded_apply(sum.clone(), &[*c, *p])).collect();
        let low: Vec<Ofr> = cl.iter().zip(&pl).map(|(c, p)| rw.composed_folded_apply(sum.clone(), &[*c, *p])).collect();
        let data = rw.pad_data(op, src, &low, &high);
        let new = rw.new_pad(data, rt, op, true);
        let v = rw.body[new].results[0];
        rw.replace_op(op, &[v]);
        true
    }

    ParallelInsertSliceConstantArguments("tensor.parallel_insert_slice", 1) |rw, op| {
        constant_slice_arguments(rw, op, true)
    }

    ParallelInsertSliceOpCastFolder("tensor.parallel_insert_slice", 1) |rw, op| {
        insert_slice_cast(rw, op)
    }

    ParallelInsertSliceOpSourceCastInserter("tensor.parallel_insert_slice", 1) |rw, op| {
        insert_slice_source_cast(rw, op)
    }
}

/// `FoldTensorCastProducerOp`: foldable casts into a destination-style op.
pub struct FoldTensorCastProducerOp;

impl crate::Pattern for FoldTensorCastProducerOp {
    fn name(&self) -> &str {
        "FoldTensorCastProducerOp"
    }

    fn root(&self) -> Option<&str> {
        None
    }

    fn rewrite(&self, rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let b = &*rw.body;
        let Some(inits) = b.dps_inits(op) else { return false };
        if b[op].name == "tensor.insert_slice" || b.has(op, Trait::LoopLikeOpInterface) || matches!(&*b[op].name, "linalg.pack" | "linalg.unpack") {
            return false;
        }
        let foldable = |v: &ValueId| !matches!(b[*v].def, crate::Def::Arg(..)) && b.foldable_cast(*v).is_some();
        if !b[op].operands.iter().any(foldable) {
            return false;
        }
        let mut types = b.types(&b[op].results);
        let mut ops = Vec::new();
        let mut k = 0;
        for (i, v) in b[op].operands.iter().enumerate() {
            let n = b.foldable_cast(*v).map_or(*v, |c| b[c].operands[0]);
            ops.push(n);
            if inits.contains(&i) && !matches!(&b[n].ty, Type::Shaped(s) if s.kind == ShapedKind::MemRef) {
                if let Some(t) = types.get_mut(k) {
                    *t = b[n].ty.clone();
                }
                k += 1;
            }
        }
        let old = b.types(&b[op].results);
        let mut map = Mapping::default();
        rw.set_before(op);
        let new = rw.body.clone_op(op, &mut map);
        rw.body.set_operands(new, ops);
        let results = rw.body[new].results.clone();
        for (r, t) in results.iter().zip(&types) {
            rw.body[*r].ty = t.clone();
        }
        rw.insert(new);
        for nested in rw.body.ops_in(new).into_iter().skip(1) {
            rw.notify_inserted(nested);
        }
        let mut repl = Vec::new();
        for (r, t) in results.into_iter().zip(old) {
            repl.push(if rw.body[r].ty != t { rw.tensor_cast(r, t) } else { r });
        }
        rw.replace_op(op, &repl);
        true
    }
}

/// The `dim` of a `tensor.concat`.
fn concat_dim(b: &Body<'_>, op: OpId) -> usize {
    match b[op].get("dim") {
        Some(Attribute::Int { lit, .. }) => lit.parse().unwrap_or(0),
        _ => 0,
    }
}

/// `ConcatOp::inferResultType`.
fn concat_type<'a>(b: &Body<'a>, op: OpId, dim: usize) -> Option<Type<'a>> {
    let types: Vec<Vec<i64>> = b[op].operands.iter().map(|v| Tn::dims(&b[*v].ty)).collect::<Option<_>>()?;
    let rank = types.first()?.len();
    let mut sizes = vec![DYNAMIC; rank];
    for (i, s) in sizes.iter_mut().enumerate() {
        if i == dim {
            *s = types.iter().try_fold(0i64, |acc, t| (t[i] != DYNAMIC).then(|| acc + t[i])).unwrap_or(DYNAMIC);
            continue;
        }
        for t in &types {
            if *s == DYNAMIC {
                *s = t[i];
            }
        }
    }
    Some(Tn::tensor(&sizes, attr::element_type(&b[b[op].operands[0]].ty).clone(), Vec::new()))
}

/// A `tensor.expand_shape` to `shape`.
fn expand_data<'a>(src: ValueId, r: &Reassoc, shape: &[Ofr]) -> OpData<'a> {
    let (st, dy) = Tn::split(shape);
    let mut ops = vec![src];
    ops.extend(dy);
    OpData::build("tensor.expand_shape").operands(&ops).with("reassociation", Reshape::attr(r)).with("static_output_shape", Tn::dense_array(&st))
}

/// `FoldReshapeWithConstant`.
fn reshape_with_constant(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
    let b = &*rw.body;
    let Some(c) = b.constant_of(b[op].operands[0]).and_then(|a| Const::try_from(&a).ok()).filter(|c| c.elements && c.is_splat()) else { return false };
    let ty = b[b[op].results[0]].ty.clone();
    rw.replace_with(op, OpData::build("arith.constant").with("value", Const { ty: ty.clone(), ..c }.into()), &[ty]);
    true
}

/// `FoldReshapeWithSplat`.
fn reshape_with_splat(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
    let b = &*rw.body;
    let Some(s) = b.def_named(b[op].operands[0], "tensor.splat") else { return false };
    if !Tn::static_shape(&b[b[s].results[0]].ty) {
        return false;
    }
    let (input, ty) = (b[s].operands[0], b[b[op].results[0]].ty.clone());
    rw.replace_with(op, OpData::build("tensor.splat").operands(&[input]), &[ty]);
    true
}

/// `FoldReshapeWithFromElements`.
fn reshape_with_from_elements(rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
    let b = &*rw.body;
    let Some(fe) = b.def_named(b[op].operands[0], "tensor.from_elements") else { return false };
    let ty = b[b[op].results[0]].ty.clone();
    if !Tn::static_shape(&ty) {
        return false;
    }
    let els = b[fe].operands.clone();
    rw.replace_with(op, OpData::build("tensor.from_elements").operands(&els), &[ty]);
    true
}

/// The tensor dialect's and ops' canonicalization patterns, in registration order.
pub fn patterns(set: &mut PatternSet) {
    set.add(FoldTensorCastProducerOp);
    set.add(ChainedTensorBitcast);
    set.add(ChainedTensorCast).add(TensorCastExtractSlice);
    set.add_boxed(alloc::boxed::Box::new(ComposeReassociative { name: "ComposeCollapseOfCollapse", dialect: "tensor", root: "tensor.collapse_shape", expand: false }));
    set.add_boxed(alloc::boxed::Box::new(ComposeCollapseOfExpand { name: "ComposeCollapseOfExpandOp", dialect: "tensor" }));
    set.add(CollapseWithConstant).add(CollapseWithSplat).add(CollapseWithFromElements).add(FoldCollapseOfCastOp);
    set.add(SingleInputConcatOp).add(InferConcatOperandTypes).add(InferConcatResultType);
    set.add(DimOfCastOp).add(DimOfDestStyleOp).add(DimOfReshapeOp);
    set.add(FoldEmptyTensorWithCastOp).add(FoldEmptyTensorWithDimOp).add(ReplaceEmptyTensorStaticShapeDims);
    set.add_boxed(alloc::boxed::Box::new(ComposeReassociative { name: "ComposeExpandOfExpand", dialect: "tensor", root: "tensor.expand_shape", expand: true }));
    set.add_boxed(alloc::boxed::Box::new(ComposeExpandOfCollapse { name: "ComposeExpandOfCollapseOp", dialect: "tensor" }));
    set.add(ConvertToStaticExpandShape).add(ExpandWithConstant).add(ExpandWithSplat).add(ExpandWithFromElements);
    set.add(ExtractFromTensorCast);
    set.add(ExtractSliceConstantArguments).add(ExtractSliceOpCastFolder);
    set.add(ExtractElementFromIndexCast);
    set.add(ExtractFromTensorGenerate).add(StaticTensorGenerate);
    set.add(InsertSliceConstantArguments).add(InsertSliceOpCastFolder).add(InsertSliceOpSourceCastInserter);
    set.add(FoldStaticZeroPadding).add(FoldSourceTensorCast).add(FoldTargetTensorCast).add(FoldOrthogonalPaddings).add(FoldStaticPadding).add(FoldConsecutiveConstantPadding);
    set.add(ParallelInsertSliceConstantArguments).add(ParallelInsertSliceOpCastFolder).add(ParallelInsertSliceOpSourceCastInserter);
}
