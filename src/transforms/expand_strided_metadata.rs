//! `expand-strided-metadata`, as `ExpandStridedMetadata.cpp`: subviews, reshapes and the
//! metadata of allocations become `memref.extract_strided_metadata` + affine arithmetic +
//! `memref.reinterpret_cast`.

use alloc::format;
use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{Attribute, Shaped, ShapedKind, Type};

use crate::canon::{MemrefOfr as Ofr, map_attr, rewrites};
use crate::{AffineExpr, AffineMap, Body, Def, Fold, Folded, GreedyConfig, LlvmOptions, OpData, OpId, Options, Pass, PatternSet, Rewriter, ValueId, DYNAMIC};

pub struct ExpandStridedMetadata;

impl TryFrom<&Options<'_>> for ExpandStridedMetadata {
    type Error = mlirformat::Error;
    fn try_from(o: &Options<'_>) -> Result<Self, Self::Error> {
        o.only("expand-strided-metadata", &[])?;
        Ok(Self)
    }
}

impl Pass for ExpandStridedMetadata {
    fn name(&self) -> &str {
        "expand-strided-metadata"
    }

    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), mlirformat::Error> {
        let mut set = PatternSet::default();
        set.add(SubviewFolder);
        set.add(ExpandShapeFolder);
        set.add(CollapseShapeFolder);
        set.add(ExtractStridedMetadataOpAllocFolder);
        set.add(ExtractStridedMetadataOpAllocaFolder);
        set.add(ExtractStridedMetadataOpCollapseShapeFolder);
        set.add(ExtractStridedMetadataOpExpandShapeFolder);
        set.add(ExtractStridedMetadataOpGetGlobalFolder);
        set.add(RewriteExtractAlignedPointerAsIndexOfViewLikeOp);
        set.add(ExtractStridedMetadataOpReinterpretCastFolder);
        set.add(ExtractStridedMetadataOpSubviewFolder);
        set.add(ExtractStridedMetadataOpMemorySpaceCastFolder);
        set.add(ExtractStridedMetadataOpAssumeAlignmentFolder);
        set.add(ExtractStridedMetadataOpExtractStridedMetadataFolder);
        for r in body[op].regions.clone() {
            body.apply_greedily(r, &set, &GreedyConfig::default());
        }
        Ok(())
    }
}

fn index_attr<'a>(v: i64) -> Attribute<'a> {
    Attribute::Int { lit: format!("{v}").into(), ty: Some(Type::Index) }
}

fn memref<'t, 'a>(t: &'t Type<'a>) -> Option<&'t Shaped<'a>> {
    match t {
        Type::Shaped(s) if s.kind == ShapedKind::MemRef && s.shape.is_some() => Some(s),
        _ => None,
    }
}

/// `inferFromExprList` for one expression: as many dims and symbols as it names.
fn infer_map(e: AffineExpr) -> AffineMap {
    let (mut d, mut s) = (0, 0);
    e.walk(&mut |x| match x {
        AffineExpr::Dim(p) => d = d.max(p + 1),
        AffineExpr::Sym(p) => s = s.max(p + 1),
        _ => {}
    });
    AffineMap { dims: d, syms: s, results: vec![e] }
}

/// The strided layout metadata of a memref value: base buffer, offset, sizes, strides.
struct Metadata {
    base: ValueId,
    offset: Ofr,
    sizes: Vec<Ofr>,
    strides: Vec<Ofr>,
}

impl<'a> Rewriter<'_, 'a> {
    /// `makeComposedFoldedAffineApply`.
    pub(crate) fn composed_folded_apply(&mut self, map: AffineMap, operands: &[Ofr]) -> Ofr {
        // `foldAttributesIntoMap`.
        let mut values = Vec::new();
        let (mut nd, mut ns) = (0, 0);
        let dims: Vec<AffineExpr> = operands[..map.dims as usize]
            .iter()
            .map(|o| match o {
                Ofr::C(c) => AffineExpr::Const(*c),
                Ofr::V(v) => {
                    values.push(*v);
                    nd += 1;
                    AffineExpr::Dim(nd - 1)
                }
            })
            .collect();
        let syms: Vec<AffineExpr> = operands[map.dims as usize..]
            .iter()
            .map(|o| match o {
                Ofr::C(c) => AffineExpr::Const(*c),
                Ofr::V(v) => {
                    values.push(*v);
                    ns += 1;
                    AffineExpr::Sym(ns - 1)
                }
            })
            .collect();
        let mut map = map.replace(&dims, &syms, nd, ns);
        self.body.compose_map(&mut map, &mut values);
        let op = self.body.create(OpData::build("affine.apply").operands(&values).with("map", map_attr(&map)), &[Type::Index]);
        let ip = self.ip.expect("insertion point");
        match ip.before {
            Some(b) => self.body.insert_before(op, b),
            None => self.body.insert(op, ip.block, None),
        }
        match self.body.fold(op) {
            Fold::Results(r) if !r.is_empty() => {
                self.body.erase(op);
                match &r[0] {
                    Folded::Value(v) => Ofr::V(*v),
                    Folded::Attr(Attribute::Int { lit, .. }) => Ofr::C(lit.parse().unwrap_or(0)),
                    Folded::Attr(_) => unreachable!("affine.apply folds to an index"),
                }
            }
            _ => {
                self.notify_inserted(op);
                Ofr::V(self.body[op].results[0])
            }
        }
    }

    fn apply_expr(&mut self, e: AffineExpr, operands: &[Ofr]) -> Ofr {
        self.composed_folded_apply(infer_map(e), operands)
    }

    /// `getValueOrCreateConstantIndexOp`.
    pub(crate) fn value_of(&mut self, o: Ofr) -> ValueId {
        match o {
            Ofr::V(v) => v,
            Ofr::C(c) => {
                let k = self.create(OpData::build("arith.constant").with("value", index_attr(c)), &[Type::Index]);
                self.body[k].results[0]
            }
        }
    }

    /// `memref.extract_strided_metadata %src`, its result types inferred.
    fn extract_metadata(&mut self, src: ValueId) -> OpId {
        let s = memref(&self.body[src].ty).expect("a ranked memref").clone();
        let rank = s.shape.as_ref().map_or(0, Vec::len);
        let space: Vec<Attribute> = s.extras.iter().filter(|a| !matches!(a, Attribute::Builtin { name, .. } if name == "strided" || name == "affine_map")).cloned().collect();
        let base = Type::Shaped(Shaped { kind: ShapedKind::MemRef, shape: Some(Vec::new()), elem: s.elem.clone(), extras: space });
        let mut types = vec![base, Type::Index];
        types.extend(vec![Type::Index; 2 * rank]);
        self.create(OpData::build("memref.extract_strided_metadata").operands(&[src]), &types)
    }

    /// `memref.reinterpret_cast` to `ty`.
    fn reinterpret_cast_data(&self, src: ValueId, offset: Ofr, sizes: &[Ofr], strides: &[Ofr]) -> OpData<'a> {
        let mut operands = vec![src];
        let mut segs = vec![1usize];
        let mut statics: Vec<Vec<i64>> = Vec::new();
        for group in [&[offset][..], sizes, strides] {
            let mut st = Vec::new();
            let mut n = 0;
            for o in group {
                match o {
                    Ofr::C(c) => st.push(*c),
                    Ofr::V(v) => {
                        st.push(DYNAMIC);
                        operands.push(*v);
                        n += 1;
                    }
                }
            }
            segs.push(n);
            statics.push(st);
        }
        let arr = |v: &[i64]| Attribute::DenseArray { ty: Type::int(64), values: v.iter().map(|x| format!("{x}").into()).collect() };
        OpData::build("memref.reinterpret_cast")
            .operands(&operands)
            .with("operandSegmentSizes", Attribute::DenseArray { ty: Type::int(32), values: segs.iter().map(|x| format!("{x}").into()).collect() })
            .with("static_offsets", arr(&statics[0]))
            .with("static_sizes", arr(&statics[1]))
            .with("static_strides", arr(&statics[2]))
    }

    /// `resolveSubviewStridedMetadata`.
    fn subview_metadata(&mut self, sv: OpId) -> Option<Metadata> {
        let b = &*self.body;
        let src = b[sv].operands[0];
        let st = memref(&b[src].ty)?.clone();
        let rank = st.shape.as_ref()?.len();
        let (src_strides, src_offset) = LlvmOptions::default().strides_and_offset(&st)?;
        let [sub_offs, sub_sizes, sub_strides] = b.mixed_osz(sv);
        let dropped = b.subview_dropped_dims(sv);
        let ex = self.extract_metadata(src);
        let er = self.body[ex].results.clone();
        let mut strides = Vec::new();
        let mut values = vec![Ofr::C(0); 2 * rank + 1];
        values[0] = if src_offset == DYNAMIC { self.ofr_of(er[1]) } else { Ofr::C(src_offset) };
        let mut expr = AffineExpr::Sym(0);
        for i in 0..rank {
            let orig = if src_strides[i] == DYNAMIC { self.ofr_of(er[2 + rank + i]) } else { Ofr::C(src_strides[i]) };
            strides.push(self.apply_expr(AffineExpr::Sym(0).mul(AffineExpr::Sym(1)), &[sub_strides[i], orig]));
            let (o, s) = (1 + 2 * i, 2 + 2 * i);
            expr = expr.add(AffineExpr::Sym(o as u32).mul(AffineExpr::Sym(s as u32)));
            values[o] = sub_offs[i];
            values[s] = orig;
        }
        let offset = self.apply_expr(expr, &values);
        let (mut sizes, mut fs) = (Vec::new(), Vec::new());
        for i in 0..rank {
            if dropped.get(i).copied().unwrap_or(false) {
                continue;
            }
            sizes.push(sub_sizes[i]);
            fs.push(strides[i]);
        }
        Some(Metadata { base: er[0], offset, sizes, strides: fs })
    }

    /// `getAsOpFoldResult(value)`: a constant becomes its value.
    fn ofr_of(&self, v: ValueId) -> Ofr {
        let b = &*self.body;
        match b.def_op(v) {
            Some(d) if b.has(d, crate::Trait::ConstantLike) => b.ofr_int(Ofr::V(v)).map_or(Ofr::V(v), Ofr::C),
            _ => Ofr::V(v),
        }
    }

    /// `resolveReshapeStridedMetadata` for `memref.expand_shape` / `memref.collapse_shape`.
    fn reshape_metadata(&mut self, r: OpId) -> Option<Metadata> {
        let b = &*self.body;
        let expand = b[r].name == "memref.expand_shape";
        let src = b[r].operands[0];
        let st = memref(&b[src].ty)?.clone();
        let rt = memref(&b[b[r].results[0]].ty)?.clone();
        let src_rank = st.shape.as_ref()?.len();
        let res_rank = rt.shape.as_ref()?.len();
        let (strides, offset) = LlvmOptions::default().strides_and_offset(&st)?;
        let groups = reassociation(b, r);
        let ex = self.extract_metadata(src);
        let er = self.body[ex].results.clone();
        let off = if offset == DYNAMIC { self.ofr_of(er[1]) } else { Ofr::C(offset) };
        if src_rank == 0 {
            return Some(Metadata { base: er[0], offset: off, sizes: vec![Ofr::C(1); res_rank], strides: vec![Ofr::C(1); res_rank] });
        }
        let orig_sizes: Vec<Ofr> = (0..src_rank).map(|i| self.ofr_of(er[2 + i])).collect();
        let orig_strides: Vec<Ofr> = (0..src_rank).map(|i| self.ofr_of(er[2 + src_rank + i])).collect();
        let src_dims = self.body.dims_of(src)?;
        let res_dims = self.body.dims_of(self.body[r].results[0])?;
        let (mut fs, mut fst) = (Vec::new(), Vec::new());
        for (g, group) in groups.iter().enumerate() {
            if expand {
                // `getExpandedSizes`.
                let mut sizes = vec![Ofr::C(0); group.len()];
                let mut product = 1i64;
                let mut dyn_idx = None;
                for (i, d) in group.iter().enumerate() {
                    if res_dims[*d] == DYNAMIC {
                        dyn_idx = Some(i);
                        continue;
                    }
                    product *= res_dims[*d];
                    sizes[i] = Ofr::C(res_dims[*d]);
                }
                if let Some(i) = dyn_idx {
                    sizes[i] = self.apply_expr(AffineExpr::Sym(0).floor_div(AffineExpr::Const(product)), &[orig_sizes[g]]);
                }
                // `getExpandedStrides`.
                let mut ex_strides = vec![0i64; group.len()];
                let mut current = 1i64;
                let mut dyn_idx = None;
                for i in (0..group.len()).rev() {
                    ex_strides[i] = current;
                    if res_dims[group[i]] == DYNAMIC {
                        dyn_idx = Some(i);
                        continue;
                    }
                    current *= res_dims[group[i]];
                }
                let orig_stride = if strides[g] == DYNAMIC { orig_strides[g] } else { Ofr::C(strides[g]) };
                let mut out = vec![Ofr::C(0); group.len()];
                let mut done = 0;
                if let Some(di) = dyn_idx {
                    let product = current;
                    while done < di {
                        let e = AffineExpr::Sym(0).mul_const(ex_strides[done]).floor_div(AffineExpr::Const(product)).mul(AffineExpr::Sym(1));
                        out[done] = self.apply_expr(e, &[orig_sizes[g], orig_stride]);
                        done += 1;
                    }
                }
                while done < group.len() {
                    out[done] = self.apply_expr(AffineExpr::Sym(0).mul_const(ex_strides[done]), &[orig_stride]);
                    done += 1;
                }
                fs.extend(sizes);
                fst.extend(out);
            } else {
                // `getCollapsedSize`.
                if res_dims[g] != DYNAMIC {
                    fs.push(Ofr::C(res_dims[g]));
                } else {
                    let mut e = AffineExpr::Const(1);
                    let mut inputs = Vec::new();
                    for (k, d) in group.iter().enumerate() {
                        e = e.mul(AffineExpr::Sym(k as u32));
                        inputs.push(if src_dims[*d] == DYNAMIC { orig_sizes[*d] } else { Ofr::C(src_dims[*d]) });
                    }
                    fs.push(self.apply_expr(e, &inputs));
                }
                // `getCollapsedStride`.
                let mut last = None;
                for d in group {
                    if src_dims[*d] == 1 {
                        continue;
                    }
                    last = Some(if strides[*d] == DYNAMIC { orig_strides[*d] } else { Ofr::C(strides[*d]) });
                }
                let stride = match last {
                    Some(l) => l,
                    None => {
                        let (cs, _) = LlvmOptions::default().strides_and_offset(&rt)?;
                        if cs[g] == DYNAMIC {
                            let d = group.iter().find(|d| strides[**d] == DYNAMIC)?;
                            orig_strides[*d]
                        } else {
                            Ofr::C(cs[g])
                        }
                    }
                };
                fst.push(stride);
            }
        }
        Some(Metadata { base: er[0], offset: off, sizes: fs, strides: fst })
    }

    /// Replaces an `extract_strided_metadata` by the values of `m`.
    fn replace_metadata(&mut self, op: OpId, m: Metadata) {
        let mut results = vec![m.base];
        results.push(self.value_of(m.offset));
        for s in m.sizes {
            results.push(self.value_of(s));
        }
        for s in m.strides {
            results.push(self.value_of(s));
        }
        self.replace_op(op, &results);
    }
}

/// The `reassociation` groups of a reshape.
fn reassociation(b: &Body<'_>, op: OpId) -> Vec<Vec<usize>> {
    match b[op].get("reassociation") {
        Some(Attribute::Array(groups)) => groups
            .iter()
            .map(|g| match g {
                Attribute::Array(i) => i.iter().filter_map(|x| if let Attribute::Int { lit, .. } = x { lit.parse().ok() } else { None }).collect(),
                _ => Vec::new(),
            })
            .collect(),
        _ => Vec::new(),
    }
}

/// `ExtractStridedMetadataOpAllocFolder<AllocLikeOp>`.
fn alloc_folder(rw: &mut Rewriter<'_, '_>, op: OpId, alloc: &str) -> bool {
    let b = &*rw.body;
    let Some(a) = b.def_named(b[op].operands[0], alloc) else { return false };
    let av = b[a].results[0];
    let Some(mt) = memref(&b[av].ty) else { return false };
    if mt.extras.iter().any(|x| matches!(x, Attribute::Builtin { name, .. } if name == "strided" || name == "affine_map")) {
        return false;
    }
    let dims = b.dims_of(av).unwrap_or_default();
    let rank = dims.len();
    let dynamic = b[a].operands.clone();
    let mut d = dynamic.iter();
    let sizes: Vec<Ofr> = dims.iter().map(|s| if *s == DYNAMIC { Ofr::V(*d.next().expect("size")) } else { Ofr::C(*s) }).collect();
    let mut strides = vec![Ofr::C(1); rank];
    let mut expr = AffineExpr::Const(1);
    rw.set_before(op);
    let mut sym = 0u32;
    for i in (0..rank.saturating_sub(1)).rev() {
        expr = expr.mul(AffineExpr::Sym(sym));
        sym += 1;
        let involved = sizes[i + 1..i + 1 + sym as usize].to_vec();
        strides[i] = rw.apply_expr(expr.clone(), &involved);
    }
    let b = &*rw.body;
    let base_v = b[op].results[0];
    let base_ty = b[base_v].ty.clone();
    let base = if b[base_v].uses.is_empty() {
        None
    } else if b[av].ty == base_ty {
        Some(av)
    } else {
        let data = rw.reinterpret_cast_data(av, Ofr::C(0), &[], &[]);
        let o = rw.create(data, &[base_ty]);
        Some(rw.body[o].results[0])
    };
    let mut results = vec![base.unwrap_or(base_v)];
    results.push(rw.value_of(Ofr::C(0)));
    for s in sizes {
        results.push(rw.value_of(s));
    }
    for s in strides {
        results.push(rw.value_of(s));
    }
    rw.replace_op(op, &results);
    true
}

rewrites! {
    /// `SubviewFolder`.
    SubviewFolder("memref.subview", 1) |rw, op| {
        rw.set_before(op);
        let Some(m) = rw.subview_metadata(op) else { return false };
        let ty = rw.body[rw.body[op].results[0]].ty.clone();
        let data = rw.reinterpret_cast_data(m.base, m.offset, &m.sizes, &m.strides);
        rw.replace_with(op, data, &[ty]);
        true
    }

    /// `ReshapeFolder<memref::ExpandShapeOp, ...>`.
    ExpandShapeFolder("memref.expand_shape", 1) |rw, op| {
        rw.set_before(op);
        let Some(m) = rw.reshape_metadata(op) else { return false };
        let ty = rw.body[rw.body[op].results[0]].ty.clone();
        let data = rw.reinterpret_cast_data(m.base, m.offset, &m.sizes, &m.strides);
        rw.replace_with(op, data, &[ty]);
        true
    }

    /// `ReshapeFolder<memref::CollapseShapeOp, ...>`.
    CollapseShapeFolder("memref.collapse_shape", 1) |rw, op| {
        rw.set_before(op);
        let Some(m) = rw.reshape_metadata(op) else { return false };
        let ty = rw.body[rw.body[op].results[0]].ty.clone();
        let data = rw.reinterpret_cast_data(m.base, m.offset, &m.sizes, &m.strides);
        rw.replace_with(op, data, &[ty]);
        true
    }

    ExtractStridedMetadataOpAllocFolder("memref.extract_strided_metadata", 1) |rw, op| { alloc_folder(rw, op, "memref.alloc") }
    ExtractStridedMetadataOpAllocaFolder("memref.extract_strided_metadata", 1) |rw, op| { alloc_folder(rw, op, "memref.alloca") }

    ExtractStridedMetadataOpCollapseShapeFolder("memref.extract_strided_metadata", 1) |rw, op| {
        let b = &*rw.body;
        let Some(r) = b.def_named(b[op].operands[0], "memref.collapse_shape") else { return false };
        rw.set_before(op);
        let Some(m) = rw.reshape_metadata(r) else { return false };
        rw.replace_metadata(op, m);
        true
    }

    ExtractStridedMetadataOpExpandShapeFolder("memref.extract_strided_metadata", 1) |rw, op| {
        let b = &*rw.body;
        let Some(r) = b.def_named(b[op].operands[0], "memref.expand_shape") else { return false };
        rw.set_before(op);
        let Some(m) = rw.reshape_metadata(r) else { return false };
        rw.replace_metadata(op, m);
        true
    }

    ExtractStridedMetadataOpGetGlobalFolder("memref.extract_strided_metadata", 1) |rw, op| {
        let b = &*rw.body;
        let Some(g) = b.def_named(b[op].operands[0], "memref.get_global") else { return false };
        let gv = b[g].results[0];
        let Some(mt) = memref(&b[gv].ty) else { return false };
        if mt.extras.iter().any(|x| matches!(x, Attribute::Builtin { name, .. } if name == "strided" || name == "affine_map")) {
            return false;
        }
        let dims = b.dims_of(gv).unwrap_or_default();
        let mut strides = vec![1i64; dims.len()];
        for i in (0..dims.len().saturating_sub(1)).rev() {
            strides[i] = strides[i + 1] * dims[i + 1];
        }
        let base_ty = b[b[op].results[0]].ty.clone();
        let same = b[gv].ty == base_ty;
        rw.set_before(op);
        let base = if same {
            gv
        } else {
            let data = rw.reinterpret_cast_data(gv, Ofr::C(0), &[], &[]);
            let o = rw.create(data, &[base_ty]);
            rw.body[o].results[0]
        };
        let mut results = vec![base];
        for v in core::iter::once(0).chain(dims).chain(strides) {
            let k = rw.create(OpData::build("arith.constant").with("value", index_attr(v)), &[Type::Index]);
            results.push(rw.body[k].results[0]);
        }
        rw.replace_op(op, &results);
        true
    }

    ExtractStridedMetadataOpAssumeAlignmentFolder("memref.extract_strided_metadata", 1) |rw, op| {
        let b = &*rw.body;
        let Some(a) = b.def_named(b[op].operands[0], "memref.assume_alignment") else { return false };
        let src = b[a].operands[0];
        let types = b.types(&b[op].results.clone());
        rw.replace_with(op, OpData::build("memref.extract_strided_metadata").operands(&[src]), &types);
        true
    }

    RewriteExtractAlignedPointerAsIndexOfViewLikeOp("memref.extract_aligned_pointer_as_index", 1) |rw, op| {
        let b = &*rw.body;
        let src = b[op].operands[0];
        let Def::Result(v, _) = b[src].def else { return false };
        if !matches!(&*b[v].name, "memref.subview" | "memref.reinterpret_cast") {
            return false;
        }
        let s = b[v].operands[0];
        rw.modify(op, |b| b.set_operand(op, 0, s));
        true
    }

    ExtractStridedMetadataOpReinterpretCastFolder("memref.extract_strided_metadata", 1) |rw, op| {
        let b = &*rw.body;
        let Some(rc) = b.def_named(b[op].operands[0], "memref.reinterpret_cast") else { return false };
        let src = b[rc].operands[0];
        if memref(&b[src].ty).is_none() {
            return false;
        }
        let [offs, sizes, strides] = b.mixed_osz(rc);
        rw.set_before(op);
        let ex = rw.extract_metadata(src);
        let base = rw.body[ex].results[0];
        let mut results = vec![base, rw.value_of(offs[0])];
        for s in sizes.into_iter().chain(strides) {
            results.push(rw.value_of(s));
        }
        rw.replace_op(op, &results);
        true
    }

    ExtractStridedMetadataOpSubviewFolder("memref.extract_strided_metadata", 1) |rw, op| {
        let b = &*rw.body;
        let Some(sv) = b.def_named(b[op].operands[0], "memref.subview") else { return false };
        rw.set_before(op);
        let Some(m) = rw.subview_metadata(sv) else { return false };
        rw.replace_metadata(op, m);
        true
    }

    ExtractStridedMetadataOpMemorySpaceCastFolder("memref.extract_strided_metadata", 1) |rw, op| {
        let b = &*rw.body;
        let Some(c) = b.def_named(b[op].operands[0], "memref.memory_space_cast") else { return false };
        let src = b[c].operands[0];
        let cast_ty = b[b[c].results[0]].ty.clone();
        let base_used = !b[b[op].results[0]].uses.is_empty();
        rw.set_before(op);
        let ex = rw.extract_metadata(src);
        let mut results = rw.body[ex].results.clone();
        if base_used {
            let Type::Shaped(bt) = rw.body[results[0]].ty.clone() else { return false };
            let space: Vec<Attribute> = memref(&cast_ty).map_or(Vec::new(), |s| s.extras.iter().filter(|a| !matches!(a, Attribute::Builtin { name, .. } if name == "strided" || name == "affine_map")).cloned().collect());
            let nt = Type::Shaped(Shaped { extras: space, ..bt });
            let o = rw.create(OpData::build("memref.memory_space_cast").operands(&[results[0]]), &[nt]);
            results[0] = rw.body[o].results[0];
        } else {
            results[0] = rw.body[op].results[0];
        }
        rw.replace_op(op, &results);
        true
    }

    ExtractStridedMetadataOpExtractStridedMetadataFolder("memref.extract_strided_metadata", 1) |rw, op| {
        let b = &*rw.body;
        let Some(s) = b.def_named(b[op].operands[0], "memref.extract_strided_metadata") else { return false };
        let base = b[s].results[0];
        rw.set_before(op);
        let zero = rw.value_of(Ofr::C(0));
        rw.replace_op(op, &[base, zero]);
        true
    }
}
