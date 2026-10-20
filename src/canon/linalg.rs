//! `linalg`: folds and canonicalization patterns, as `LinalgOps.cpp`.

use alloc::borrow::Cow;
use alloc::format;
use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{arith, linalg, Attribute, Dim, NamedAttr, Shaped, ShapedKind, Type};

use super::MemrefOfr as Ofr;
use crate::{AffineExpr, AffineMap, Body, Const, DYNAMIC, Def, Fold, Folded, Mapping, OpData, OpId, PatternSet, Rewriter, Trait, TypedOp, ValueId, attr};

/// The `linalg` ops' helpers.
struct Lg;

impl Lg {
    fn dims(t: &Type<'_>) -> Option<Vec<i64>> {
        attr::shape_of(t).map(|d| d.iter().map(|d| if let Dim::Static(n) = d { *n } else { DYNAMIC }).collect())
    }

    fn kind(t: &Type<'_>) -> Option<ShapedKind> {
        match t {
            Type::Shaped(s) => Some(s.kind),
            _ => None,
        }
    }

    fn is_tensor(t: &Type<'_>) -> bool {
        Self::kind(t) == Some(ShapedKind::Tensor)
    }

    fn is_memref(t: &Type<'_>) -> bool {
        Self::kind(t) == Some(ShapedKind::MemRef)
    }

    /// `LinalgOp::isScalar`: neither a tensor nor a memref.
    fn is_scalar(t: &Type<'_>) -> bool {
        !Self::is_tensor(t) && !Self::is_memref(t)
    }

    fn static_shape(t: &Type<'_>) -> bool {
        Self::dims(t).is_some_and(|d| !d.contains(&DYNAMIC))
    }

    /// `RankedTensorType::clone(dims)`: element type and encoding kept.
    fn with_dims<'a>(t: &Type<'a>, dims: &[i64]) -> Type<'a> {
        let Type::Shaped(s) = t else { return t.clone() };
        let shape = dims.iter().map(|d| if *d == DYNAMIC { Dim::Dynamic } else { Dim::Static(*d) }).collect();
        Type::Shaped(Shaped { shape: Some(shape), ..s.clone() })
    }

    /// `RankedTensorType::get(dims, elem)`.
    fn tensor<'a>(dims: &[i64], elem: Type<'a>) -> Type<'a> {
        Self::with_dims(&Type::Shaped(Shaped { kind: ShapedKind::Tensor, shape: None, elem: elem.into(), extras: Vec::new() }), dims)
    }

    /// The result types of a destination-style op writing `init`: its type, when a tensor.
    fn results_for<'a>(init: &Type<'a>) -> Vec<Type<'a>> {
        if Self::is_tensor(init) { vec![init.clone()] } else { Vec::new() }
    }

    fn dense<'a>(v: &[i64]) -> Attribute<'a> {
        Attribute::DenseArray { ty: Type::int(64), values: v.iter().map(|x| Cow::Owned(format!("{x}"))).collect() }
    }

    fn index<'a>(v: i64) -> Attribute<'a> {
        Attribute::Int { lit: Cow::Owned(format!("{v}")), ty: Some(Type::Index) }
    }

    fn int(a: Option<&Attribute<'_>>) -> Option<i64> {
        match a? {
            Attribute::Int { lit, .. } => lit.parse().ok(),
            _ => None,
        }
    }

    /// `invertPermutationVector`.
    fn invert(p: &[i64]) -> Vec<i64> {
        let mut inv = vec![0; p.len()];
        for (i, x) in p.iter().enumerate() {
            inv[*x as usize] = i as i64;
        }
        inv
    }

    /// `applyPermutation`: `out[i] = v[p[i]]`.
    fn permute<T: Clone>(v: &[T], p: &[i64]) -> Vec<T> {
        p.iter().map(|i| v[*i as usize].clone()).collect()
    }

    fn is_identity(p: &[i64]) -> bool {
        p.iter().enumerate().all(|(i, x)| *x == i as i64)
    }

    /// `dropDims`.
    fn drop_dims(perm: &[i64], drop: &[i64]) -> Vec<i64> {
        let mut res = Vec::new();
        for p in perm {
            let mut target = *p;
            let mut dropped = false;
            for d in drop {
                if d == p {
                    dropped = true;
                    break;
                }
                if d < p {
                    target -= 1;
                }
            }
            if !dropped {
                res.push(target);
            }
        }
        res
    }

    /// `AffineMap::isProjectedPermutation()`.
    fn projected_permutation(m: &AffineMap) -> bool {
        if m.syms > 0 || m.results.len() > m.dims as usize {
            return false;
        }
        let mut seen = vec![false; m.dims as usize];
        m.results.iter().all(|e| match e {
            AffineExpr::Dim(d) if !seen[*d as usize] => {
                seen[*d as usize] = true;
                true
            }
            _ => false,
        })
    }

    /// `tensor::CastOp::areCastCompatible`.
    fn cast_compatible(a: &Type<'_>, b: &Type<'_>) -> bool {
        if !Self::is_tensor(a) || !Self::is_tensor(b) || attr::element_type(a) != attr::element_type(b) {
            return false;
        }
        match (Self::dims(a), Self::dims(b)) {
            (Some(x), Some(y)) => x.len() == y.len() && x.iter().zip(&y).all(|(p, q)| *p == DYNAMIC || *q == DYNAMIC || p == q),
            _ => true,
        }
    }

    fn sparse(t: &Type<'_>) -> bool {
        matches!(t, Type::Shaped(s) if s.extras.iter().any(|e| format!("{e}").starts_with("#sparse_tensor.encoding")))
    }

    /// The OpDSL ops whose maps are identities of the init's rank (scalars: no results).
    fn rank_polymorphic(name: &str) -> bool {
        matches!(
            name,
            "linalg.fill"
                | "linalg.copy"
                | "linalg.abs"
                | "linalg.add"
                | "linalg.ceil"
                | "linalg.div"
                | "linalg.div_unsigned"
                | "linalg.erf"
                | "linalg.exp"
                | "linalg.floor"
                | "linalg.log"
                | "linalg.max"
                | "linalg.min"
                | "linalg.mul"
                | "linalg.negf"
                | "linalg.powf"
                | "linalg.reciprocal"
                | "linalg.round"
                | "linalg.rsqrt"
                | "linalg.select"
                | "linalg.sqrt"
                | "linalg.square"
                | "linalg.sub"
                | "linalg.tanh"
        )
    }

    /// Whether `linalg` op `name` folds with `memref::foldMemRefCast` (the OpDSL ops and the
    /// ODS ops declaring that folder).
    fn folds_memref_cast(name: &str) -> bool {
        !matches!(name, "linalg.transpose" | "linalg.broadcast" | "linalg.map" | "linalg.reduce")
    }
}

impl<'a> Body<'a> {
    fn uses_len(&self, v: ValueId) -> usize {
        self[v].uses.len()
    }

    /// `getIndexingMapsArray`: from `indexing_maps`, or as the op computes them.
    fn indexing_maps(&self, op: OpId) -> Option<Vec<AffineMap>> {
        if let Some(Attribute::Array(ms)) = self[op].get("indexing_maps") {
            return ms
                .iter()
                .map(|m| match m {
                    Attribute::Builtin { name, body, .. } if name == "affine_map" => AffineMap::parse(body),
                    _ => None,
                })
                .collect();
        }
        let inits = self.dps_inits(op)?;
        let rank = Lg::dims(&self[*self[op].operands.get(inits.start)?].ty)?.len() as u32;
        let id = AffineMap::identity(rank);
        let map = |results: Vec<AffineExpr>| AffineMap { dims: rank, syms: 0, results };
        match &*self[op].name {
            "linalg.transpose" => {
                let inv = Lg::invert(&self.dense_i64(op, "permutation"));
                Some(vec![map(inv.iter().map(|i| AffineExpr::Dim(*i as u32)).collect()), id])
            }
            "linalg.broadcast" => {
                let drop = self.dense_i64(op, "dimensions");
                Some(vec![map((0..rank).filter(|d| !drop.contains(&i64::from(*d))).map(AffineExpr::Dim).collect()), id])
            }
            n if Lg::rank_polymorphic(n) => Some(self[op].operands.iter().map(|v| if Lg::dims(&self[*v].ty).is_none_or(|d| d.is_empty()) { map(Vec::new()) } else { id.clone() }).collect()),
            _ => None,
        }
    }

    /// `getStaticLoopRanges`: each loop's first operand dim, through the inverted maps.
    fn static_loop_ranges(&self, op: OpId) -> Option<Vec<i64>> {
        let maps = self.indexing_maps(op)?;
        let mut flat = Vec::new();
        for (v, m) in self[op].operands.iter().zip(&maps) {
            flat.extend(m.results.iter().zip(Lg::dims(&self[*v].ty).unwrap_or_default()));
        }
        (0..maps.first()?.dims).map(|d| flat.iter().find(|(e, _)| **e == AffineExpr::Dim(d)).map(|(_, s)| *s)).collect()
    }

    /// `hasPureTensorSemantics`.
    fn pure_tensor(&self, op: OpId) -> bool {
        self[op].operands.iter().all(|v| !Lg::is_memref(&self[*v].ty))
    }

    /// `hasPureBufferSemantics`.
    fn pure_buffer(&self, op: OpId) -> bool {
        self[op].operands.iter().all(|v| !Lg::is_tensor(&self[*v].ty))
    }

    /// `isEqualConstantIntOrValue`.
    fn same_int_or_value(&self, a: Ofr, b: Ofr) -> bool {
        a == b || matches!((self.ofr_int(a), self.ofr_int(b)), (Some(x), Some(y)) if x == y)
    }

    /// `getAsOpFoldResult(a) == getAsOpFoldResult(b)`.
    fn same_fold_result(&self, a: ValueId, b: ValueId) -> bool {
        match (self.constant_of(a), self.constant_of(b)) {
            (Some(x), Some(y)) => x == y,
            (None, None) => a == b,
            _ => false,
        }
    }
}

/// A `linalg.pack` or `linalg.unpack`, by its parts.
struct Relayout<'a> {
    pack: bool,
    source: ValueId,
    dest: ValueId,
    padding: Option<ValueId>,
    tiles: Vec<Ofr>,
    inner: Vec<i64>,
    outer: Vec<i64>,
    attrs: Vec<NamedAttr<'a>>,
}

impl<'a> Relayout<'a> {
    fn of(b: &Body<'a>, op: OpId) -> Self {
        let ops = &b[op].operands;
        let pack = b[op].name == "linalg.pack";
        let padding = pack.then(|| b.segments(op, "operandSegmentSizes")).flatten().and_then(|s| (s.get(2) == Some(&1)).then(|| ops[2]));
        let mut dynamic = ops[2 + usize::from(padding.is_some())..].iter();
        let tiles = b.dense_i64(op, "static_inner_tiles").into_iter().map(|t| if t == DYNAMIC { Ofr::V(*dynamic.next().expect("a dynamic tile")) } else { Ofr::C(t) }).collect();
        Self { pack, source: ops[0], dest: ops[1], padding, tiles, inner: b.dense_i64(op, "inner_dims_pos"), outer: b.dense_i64(op, "outer_dims_perm"), attrs: b[op].attributes.clone() }
    }

    /// `PackOp::create` / `UnPackOp::create`, with the discardable attributes `attrs`.
    fn create(&self, rw: &mut Rewriter<'_, 'a>) -> ValueId {
        let b = &*rw.body;
        let mut st = Vec::new();
        let mut dy = Vec::new();
        for t in &self.tiles {
            match t {
                Ofr::C(c) => st.push(*c),
                Ofr::V(v) => {
                    st.push(DYNAMIC);
                    dy.push((*v).into());
                }
            }
        }
        let outer = (!self.outer.is_empty()).then(|| Lg::dense(&self.outer));
        let (src_ty, ty) = (b[self.source].ty.clone(), b[self.dest].ty.clone());
        let (data, types) = if self.pack {
            let pad: Vec<_> = self.padding.iter().map(|v| (*v).into()).collect();
            let pad_ty = self.padding.iter().map(|v| b[*v].ty.clone()).collect();
            linalg::PackOp::new(self.source.into(), self.dest.into(), pad, dy, outer, Lg::dense(&self.inner), Lg::dense(&st), src_ty, pad_ty, Type::Index, ty).split()
        } else {
            linalg::UnPackOp::new(self.source.into(), self.dest.into(), dy, outer, Lg::dense(&self.inner), Lg::dense(&st), src_ty, Type::Index, ty).split()
        };
        let op = rw.create(data.attrs(self.attrs.clone()), &types);
        rw.body[op].results[0]
    }

    /// `hasSameInnerOuterAttribute`.
    fn same_layout(&self, o: &Self) -> bool {
        self.inner == o.inner && (self.outer == o.outer || (Lg::is_identity(&self.outer) && Lg::is_identity(&o.outer)))
    }

    /// `haveSameTiles`.
    fn same_tiles(&self, b: &Body<'_>, o: &Self) -> bool {
        self.tiles.len() == o.tiles.len() && self.tiles.iter().zip(&o.tiles).all(|(x, y)| b.same_int_or_value(*x, *y))
    }

    /// `PackOp::requirePaddingValue`.
    fn requires_padding(&self, b: &Body<'_>, input: &[i64], output: &[i64]) -> bool {
        let mut tiles = output[..input.len()].to_vec();
        if !self.outer.is_empty() {
            tiles = Lg::permute(&tiles, &Lg::invert(&self.outer));
        }
        self.inner.iter().zip(&self.tiles).any(|(pos, tile)| {
            let pos = *pos as usize;
            if input[pos] == DYNAMIC {
                return false;
            }
            match b.ofr_int(*tile) {
                Some(c) => input[pos] % c != 0,
                None => tiles[pos] != DYNAMIC && input[pos] % tiles[pos] != 0,
            }
        })
    }

    /// `paddingIsNotNeeded`.
    fn padding_not_needed(&self, b: &Body<'_>) -> bool {
        let (Some(src), Some(dst)) = (Lg::dims(&b[self.source].ty), Lg::dims(&b[self.dest].ty)) else { return false };
        !self.inner.iter().any(|p| src[*p as usize] == DYNAMIC) && !self.tiles.iter().any(|t| matches!(t, Ofr::V(_))) && !self.requires_padding(b, &src, &dst)
    }

    /// `inferStaticShape`: the source and dest shapes with the untiled dims each side knows.
    fn infer_static(&self, b: &Body<'_>) -> Option<(Vec<i64>, Vec<i64>)> {
        let (mut src, mut dst) = (Lg::dims(&b[self.source].ty)?, Lg::dims(&b[self.dest].ty)?);
        let inv = if self.outer.is_empty() { Vec::new() } else { Lg::invert(&self.outer) };
        let mut changed = false;
        for i in 0..if self.pack { src.len() } else { dst.len() } {
            if self.inner.contains(&(i as i64)) {
                continue;
            }
            let (mut sp, mut dp) = (i, i);
            if !inv.is_empty() {
                if self.pack {
                    dp = inv[sp] as usize;
                } else {
                    sp = inv[dp] as usize;
                }
            }
            if (src[sp] == DYNAMIC) == (dst[dp] == DYNAMIC) {
                continue;
            }
            let size = if src[sp] == DYNAMIC { dst[dp] } else { src[sp] };
            src[sp] = size;
            dst[dp] = size;
            changed = true;
        }
        changed.then_some((src, dst))
    }

    /// `UnPackOp::canFoldSliceOp`.
    fn can_fold_slice(&self, b: &Body<'_>, slice: OpId) -> bool {
        let (Some(st), Some(dest), Some(src)) = (Lg::dims(&b[b[slice].results[0]].ty), Lg::dims(&b[self.dest].ty), Lg::dims(&b[self.source].ty)) else { return false };
        if st.len() != dest.len() {
            return false;
        }
        let [o, _, t] = b.slice_lists(slice);
        if !o.iter().all(|x| b.ofr_int(*x) == Some(0)) || !t.iter().all(|x| b.ofr_int(*x) == Some(1)) {
            return false;
        }
        let mut outer = src[..dest.len()].to_vec();
        if !self.outer.is_empty() {
            outer = Lg::permute(&outer, &Lg::invert(&self.outer));
        }
        self.inner.iter().zip(&self.tiles).all(|(pos, tile)| {
            let (p, tile) = (*pos as usize, if let Ofr::C(c) = tile { *c } else { DYNAMIC });
            st[p] != DYNAMIC && outer[p] != DYNAMIC && tile != DYNAMIC && outer[p] * tile - st[p] < tile
        })
    }
}

/// The fold of a `linalg` op.
pub fn fold<'a>(b: &mut Body<'a>, op: OpId, c: &[Option<Attribute<'a>>]) -> Fold<'a> {
    let name = b[op].name.clone();
    match &*name {
        "linalg.transpose" => {
            let input = b[op].operands[0];
            let p = b.dense_i64(op, "permutation");
            if Lg::is_tensor(&b[input].ty) && Lg::is_identity(&p) { Folded::Value(input).into() } else { Fold::Failed }
        }
        "linalg.index" => {
            let ranges = b.parent_op(op).filter(|p| b.has(*p, Trait::LinalgOp)).and_then(|p| b.static_loop_ranges(p));
            match (ranges, Lg::int(b[op].get("dim"))) {
                (Some(r), Some(d)) if r.get(d as usize) == Some(&1) => Folded::Attr(Lg::index(0)).into(),
                _ => Fold::Failed,
            }
        }
        // `reshapeConstantSource`: a splat source (equal to the padding value, if constant).
        "linalg.pack" | "linalg.unpack" => {
            let rt = b[b[op].results[0]].ty.clone();
            let Some(k) = c[0].as_ref().and_then(|a| Const::try_from(a).ok()).filter(|k| k.elements && k.is_splat()) else { return Fold::Failed };
            let pad = Relayout::of(b, op).padding.and_then(|_| c[2].as_ref());
            if !Lg::static_shape(&rt) || pad.is_some_and(|p| Const::try_from(p).ok().is_none_or(|p| p.values != k.values || &p.ty != attr::element_type(&k.ty))) {
                return Fold::Failed;
            }
            Folded::Attr(Const { ty: rt, ..k }.into()).into()
        }
        n if (b.has(op, Trait::LinalgOp) && Lg::folds_memref_cast(n)) || n == "linalg.softmax" => {
            if b.fold_memref_cast(op, None) { Fold::InPlace } else { Fold::Failed }
        }
        _ => Fold::Failed,
    }
}

impl<'a> Rewriter<'_, 'a> {
    /// `mlir::clone(b, op, types, operands)`: `op` with other operands and result types, its
    /// regions copied.
    fn clone_linalg(&mut self, op: OpId, operands: Vec<ValueId>, types: &[Type<'a>]) -> OpId {
        let new = self.body.clone_op(op, &mut Mapping::default());
        self.body.set_operands(new, operands);
        for (r, t) in self.body[new].results.clone().into_iter().zip(types) {
            self.body[r].ty = t.clone();
        }
        self.insert(new)
    }

    /// A structured op whose body yields its first block argument (`fill`, `copy`,
    /// `transpose`, `broadcast`), result types those of its tensor init; its results. The
    /// OpDSL scalar cast is not built: the first operand's element type is the init's.
    fn structured(&mut self, data: OpData<'a>) -> Vec<ValueId> {
        let args: Vec<(Type<'a>, Option<_>)> = data.operands.iter().map(|v| (attr::element_type(&self.body[*v].ty).clone(), None)).collect();
        let types = Lg::results_for(&self.body[*data.operands.last().expect("an init")].ty);
        let op = self.create_with(data, &types, |b, o| {
            let r = b.add_region(o);
            let blk = b.add_block(r, &args);
            let a = b[blk].args[0];
            let y = b.create(OpData::build("linalg.yield").operands(&[a]), &[]);
            b.insert(y, blk, None);
        });
        self.body[op].results.clone()
    }

    fn fill(&mut self, value: ValueId, init: ValueId) -> Vec<ValueId> {
        self.structured(OpData::build("linalg.fill").operands(&[value, init]).segments(&[1, 1]))
    }

    fn transpose(&mut self, input: ValueId, init: ValueId, perm: &[i64]) -> Vec<ValueId> {
        self.structured(OpData::build("linalg.transpose").operands(&[input, init]).with("permutation", Lg::dense(perm)))
    }

    fn broadcast(&mut self, input: ValueId, init: ValueId, dims: &[i64]) -> Vec<ValueId> {
        self.structured(OpData::build("linalg.broadcast").operands(&[input, init]).with("dimensions", Lg::dense(dims)))
    }

    /// `tensor::DimOp::create(b, loc, v, i)`: the index constant, then the dim.
    fn tensor_dim(&mut self, v: ValueId, i: usize) -> ValueId {
        let k = self.emit(&arith::Constant::new(Lg::index(i as i64), Type::Index));
        let k = self.body[k].results[0];
        let d = self.create(OpData::build("tensor.dim").operands(&[v, k]), &[Type::Index]);
        self.body[d].results[0]
    }

    /// `tensor::EmptyOp::create(b, loc, sizes, elem)`.
    fn empty(&mut self, sizes: &[Ofr], elem: Type<'a>) -> ValueId {
        let dims: Vec<i64> = sizes.iter().map(|s| if let Ofr::C(c) = s { *c } else { DYNAMIC }).collect();
        let dynamic: Vec<ValueId> = sizes.iter().filter_map(|s| if let Ofr::V(v) = s { Some(*v) } else { None }).collect();
        let e = self.create(OpData::build("tensor.empty").operands(&dynamic), &[Lg::tensor(&dims, elem)]);
        self.body[e].results[0]
    }

    /// `EraseIdentityLinalgOp`: a body that only yields block arguments, all maps equal.
    fn erase_identity(&mut self, op: OpId) -> bool {
        let b = &*self.body;
        let Some(maps) = b.indexing_maps(op) else { return false };
        if maps.windows(2).any(|w| w[0] != w[1]) {
            return false;
        }
        let blk = b.top_block(op);
        let [y] = b[blk].ops[..] else { return false };
        if b[y].name != "linalg.yield" {
            return false;
        }
        let own_arg = |b: &Body<'_>, v: ValueId| match b[v].def {
            Def::Arg(k, i) if k == blk => Some(i as usize),
            _ => None,
        };
        if b.pure_buffer(op) {
            let ops = &b[op].operands;
            if ops.len() != 2 || b.dps_inits(op) != Some(1..2) || ops[0] != ops[1] || b[y].operands.first().and_then(|v| own_arg(b, *v)).is_none() {
                return false;
            }
            self.erase_op(op);
            return true;
        }
        if !b.pure_tensor(op) {
            return false;
        }
        let yielded = b[y].operands.clone();
        self.set_before(op);
        let mut out = Vec::new();
        for (k, v) in yielded.into_iter().enumerate() {
            let b = &*self.body;
            let (Some(n), Some(r)) = (own_arg(b, v), b[op].results.get(k)) else { return false };
            let arg = b[op].operands[n];
            let (at, rt) = (b[arg].ty.clone(), b[*r].ty.clone());
            out.push(if at == rt {
                arg
            } else if Lg::sparse(&at) || Lg::sparse(&rt) {
                let c = self.create(OpData::build("sparse_tensor.convert").operands(&[arg]), &[rt]);
                self.body[c].results[0]
            } else if Lg::cast_compatible(&at, &rt) {
                self.tensor_cast(arg, rt)
            } else {
                return false;
            });
        }
        if out.len() != self.body[op].results.len() {
            return false;
        }
        self.replace_op(op, &out);
        true
    }

    /// `FoldFillWithTensorReshape`: the reshape of a fill is a fill of the reshaped init.
    fn fill_reshape(&mut self, op: OpId) -> bool {
        let b = &*self.body;
        let Some(fill) = b.def_named(b[op].operands[0], "linalg.fill") else { return false };
        let (value, init) = (b[fill].operands[0], b[fill].operands[1]);
        let mut ops = b[op].operands.clone();
        ops[0] = init;
        let mut data = OpData::build(&*b[op].name).operands(&ops);
        for a in ["reassociation", "static_output_shape"] {
            if let Some(v) = b[op].get(a) {
                data.set(a, v.clone());
            }
        }
        let ty = b[b[op].results[0]].ty.clone();
        self.set_before(op);
        let r = self.create(data, &[ty]);
        let r = self.body[r].results[0];
        let f = self.fill(value, r);
        self.replace_op(op, &f);
        true
    }

    /// `FoldTensorCastPackOp` / `FoldTensorCastUnPackOp`.
    fn relayout_cast(&mut self, op: OpId) -> bool {
        let b = &*self.body;
        let foldable = |v: &ValueId| !matches!(b[*v].def, Def::Arg(..)) && b.foldable_cast(*v).is_some();
        if !b[op].operands.iter().any(foldable) {
            return false;
        }
        let through = |v: ValueId| b.foldable_cast(v).map_or(v, |c| b[c].operands[0]);
        let mut r = Relayout::of(b, op);
        (r.source, r.dest) = (through(r.source), through(r.dest));
        let packed = Lg::dims(&b[if r.pack { r.dest } else { r.source }].ty).unwrap_or_default();
        let tail = &packed[packed.len() - r.tiles.len()..];
        r.tiles = tail.iter().zip(&r.tiles).map(|(s, t)| if *s == DYNAMIC || matches!(t, Ofr::C(_)) { *t } else { Ofr::C(*s) }).collect();
        let old = b[b[op].results[0]].ty.clone();
        self.set_before(op);
        let mut new = r.create(self);
        if self.body[new].ty != old {
            new = self.tensor_cast(new, old);
        }
        self.replace_op(op, &[new]);
        true
    }

    /// `PackOp::canonicalize`.
    fn pack_canonicalize(&mut self, op: OpId) -> bool {
        let b = &*self.body;
        let p = Relayout::of(b, op);
        let dest_ty = b[p.dest].ty.clone();
        if let Some(u) = b.def_named(p.source, "linalg.unpack") {
            let q = Relayout::of(b, u);
            if b[q.source].ty == dest_ty && p.padding.is_none() && p.same_layout(&q) && p.same_tiles(b, &q) {
                self.replace_op(op, &[q.source]);
                return true;
            }
        }
        if p.padding.is_some() && p.padding_not_needed(b) {
            let mut ops = b[op].operands.clone();
            ops.remove(2);
            self.modify(op, |b| {
                b.set_operands(op, ops);
                b.set_segments(op, "operandSegmentSizes", &[1, 1, 0, p.tiles.iter().filter(|t| matches!(t, Ofr::V(_))).count()]);
            });
            return true;
        }
        let Some((src, dst)) = p.infer_static(b) else { return false };
        let src_ty = b[p.source].ty.clone();
        self.set_before(op);
        let source = if Lg::dims(&src_ty).as_ref() != Some(&src) { self.tensor_cast(p.source, Lg::with_dims(&src_ty, &src)) } else { p.source };
        let update = Lg::dims(&dest_ty).as_ref() != Some(&dst);
        let dest = if update { self.tensor_cast(p.dest, Lg::with_dims(&dest_ty, &dst)) } else { p.dest };
        let r = self.body[op].results[0];
        let ty = self.body[dest].ty.clone();
        self.modify(op, |b| {
            b.set_operand(op, 0, source);
            b.set_operand(op, 1, dest);
            b[r].ty = ty;
        });
        if update {
            self.set_after(op);
            let c = self.tensor_cast(r, dest_ty);
            let cast = self.body.def_op(c);
            self.replace_uses_if(r, c, |_, u| Some(u.op) != cast);
        }
        true
    }

    /// `UnPackOp::canonicalize`.
    fn unpack_canonicalize(&mut self, op: OpId) -> bool {
        let b = &*self.body;
        let u = Relayout::of(b, op);
        if let Some(p) = b.def_named(u.source, "linalg.pack") {
            let q = Relayout::of(b, p);
            if b[q.source].ty != b[u.dest].ty || q.padding.is_some() || !q.same_layout(&u) || !q.same_tiles(b, &u) {
                return false;
            }
            self.replace_op(op, &[q.source]);
            return true;
        }
        if let Some(d) = b.def_op(u.dest).filter(|d| b.has(*d, Trait::DestinationStyleOpInterface))
            && let (Def::Result(_, n), Some(inits)) = (b[u.dest].def, b.dps_inits(d))
        {
            let init = b[d].operands[inits.start + n as usize];
            self.modify(op, |b| b.set_operand(op, 1, init));
            return true;
        }
        let r = b[op].results[0];
        if let [user] = b[r].uses[..]
            && b[user.op].name == "tensor.extract_slice"
            && u.can_fold_slice(b, user.op)
        {
            let lists = b.slice_lists(user.op);
            let sizes: Vec<i64> = lists[1].iter().map(|s| if let Ofr::C(c) = s { *c } else { DYNAMIC }).collect();
            let ty = Lg::tensor(&sizes, attr::element_type(&b[u.dest].ty).clone());
            self.set_before(op);
            let s = self.create(OpData::sliced("tensor.extract_slice", &[u.dest], &lists), &[ty.clone()]);
            let s = self.body[s].results[0];
            self.modify(op, |b| {
                b.set_operand(op, 1, s);
                b[r].ty = ty;
            });
            self.replace_op(user.op, &[r]);
            return true;
        }
        let Some((src, dst)) = u.infer_static(b) else { return false };
        let (src_ty, dest_ty, old) = (b[u.source].ty.clone(), b[u.dest].ty.clone(), b[r].ty.clone());
        self.set_before(op);
        let source = if Lg::dims(&src_ty).as_ref() != Some(&src) { self.tensor_cast(u.source, Lg::with_dims(&src_ty, &src)) } else { u.source };
        let dest = if Lg::dims(&dest_ty).as_ref() != Some(&dst) { self.tensor_cast(u.dest, Lg::with_dims(&dest_ty, &dst)) } else { u.dest };
        let new = Relayout { source, dest, attrs: Vec::new(), ..u }.create(self);
        self.replace_with(op, OpData::build("tensor.cast").operands(&[new]), &[old]);
        true
    }
}

rewrites! {
    /// `EraseDeadLinalgOp`: an op over a memref with a zero-sized dim goes.
    EraseDeadLinalgOp(_, 1) |rw, op| {
        let b = &*rw.body;
        if !b.has(op, Trait::LinalgOp) || !b[op].operands.iter().any(|v| Lg::is_memref(&b[*v].ty) && Lg::dims(&b[*v].ty).is_some_and(|d| d.contains(&0))) {
            return false;
        }
        rw.erase_op(op);
        true
    }

    /// `FoldTensorCastConsumerOp`: a cast to a more static type of a linalg result goes into
    /// the op, through its init.
    FoldTensorCastConsumerOp("tensor.cast", 1) |rw, op| {
        let b = &*rw.body;
        if !b.cast_into_producer(op) {
            return false;
        }
        let src = b[op].operands[0];
        let Some(l) = b.def_op(src).filter(|l| b.has(*l, Trait::LinalgOp)) else { return false };
        let (Some(inits), Def::Result(_, n)) = (b.dps_inits(l), b[src].def) else { return false };
        if b[op].parent != b[l].parent {
            return false;
        }
        let n = n as usize;
        let (rt, old) = (b[b[op].results[0]].ty.clone(), b[src].ty.clone());
        let mut operands = b[l].operands.clone();
        let mut types = b.types(&b[l].results);
        types[n] = rt.clone();
        rw.set_before(l);
        operands[inits.start + n] = rw.tensor_cast(operands[inits.start + n], rt);
        let new = rw.clone_linalg(l, operands, &types);
        let mut results = rw.body[new].results.clone();
        let result = results[n];
        results[n] = rw.tensor_cast(result, old);
        rw.replace_op(l, &results);
        rw.replace_op(op, &[result]);
        true
    }

    FoldTensorCastPackOp("linalg.pack", 1) |rw, op| {
        rw.relayout_cast(op)
    }

    FoldTensorCastUnPackOp("linalg.unpack", 1) |rw, op| {
        rw.relayout_cast(op)
    }

    /// `InferStaticShapeOfOperands`: dims one operand knows statically, through the
    /// (projected permutation) maps, cast onto the others.
    InferStaticShapeOfOperands(_, 1) |rw, op| {
        let b = &*rw.body;
        if !b.has(op, Trait::LinalgOp) || !b.pure_tensor(op) {
            return false;
        }
        let (Some(maps), Some(inits)) = (b.indexing_maps(op), b.dps_inits(op)) else { return false };
        if !maps.iter().all(Lg::projected_permutation) {
            return false;
        }
        let operands = b[op].operands.clone();
        let mut known: Vec<(u32, i64)> = Vec::new();
        for (v, m) in operands.iter().zip(&maps) {
            if Lg::is_scalar(&b[*v].ty) {
                continue;
            }
            for (s, e) in Lg::dims(&b[*v].ty).unwrap_or_default().into_iter().zip(&m.results) {
                if let AffineExpr::Dim(d) = e
                    && s != DYNAMIC
                    && !known.iter().any(|k| k.0 == *d)
                {
                    known.push((*d, s));
                }
            }
        }
        let mut casts: Vec<Option<Type<'_>>> = Vec::new();
        let mut types = Vec::new();
        for (k, (v, m)) in operands.iter().zip(&maps).enumerate() {
            let t = b[*v].ty.clone();
            if Lg::is_scalar(&t) {
                casts.push(None);
                continue;
            }
            let dims = Lg::dims(&t).unwrap_or_default();
            let init = inits.contains(&k);
            if init && !dims.contains(&DYNAMIC) {
                types.push(t);
                casts.push(None);
                continue;
            }
            let mut need = false;
            let shape: Vec<i64> = dims
                .iter()
                .zip(&m.results)
                .map(|(s, e)| match (s, e) {
                    (&DYNAMIC, AffineExpr::Dim(d)) => known.iter().find(|k| k.0 == *d).map_or(DYNAMIC, |k| {
                        need = true;
                        k.1
                    }),
                    _ => *s,
                })
                .collect();
            let nt = Lg::with_dims(&t, &shape);
            casts.push(need.then(|| nt.clone()));
            if init {
                types.push(nt);
            }
        }
        if casts.iter().all(Option::is_none) {
            return false;
        }
        rw.set_before(op);
        let mut new_ops = Vec::new();
        for (v, c) in operands.into_iter().zip(casts) {
            new_ops.push(match c {
                Some(t) => rw.tensor_cast(v, t),
                None => v,
            });
        }
        let new = rw.clone_linalg(op, new_ops, &types);
        let mut repl = Vec::new();
        for (o, n) in rw.body[op].results.clone().into_iter().zip(rw.body[new].results.clone()) {
            let ot = rw.body[o].ty.clone();
            repl.push(if rw.body[n].ty != ot { rw.tensor_cast(n, ot) } else { n });
        }
        rw.replace_op(op, &repl);
        true
    }

    EraseIdentityBroadcastOp("linalg.broadcast", 1) |rw, op| {
        rw.erase_identity(op)
    }

    /// `FoldBroadcasts`: a broadcast of a broadcast is one broadcast.
    FoldBroadcasts("linalg.broadcast", 1) |rw, op| {
        let b = &*rw.body;
        let (input, init) = (b[op].operands[0], b[op].operands[1]);
        let Some(d) = b.def_named(input, "linalg.broadcast") else { return false };
        let dims = b.dense_i64(op, "dimensions");
        let rank = Lg::dims(&b[init].ty).map_or(0, |d| d.len()) as i64;
        let map: Vec<i64> = (0..rank).filter(|x| !dims.contains(x)).collect();
        let mut folded = dims.clone();
        folded.extend(b.dense_i64(d, "dimensions").into_iter().map(|x| map[x as usize]));
        folded.sort_unstable();
        let src = b[d].operands[0];
        rw.set_before(op);
        let r = rw.broadcast(src, init, &folded);
        rw.replace_op(op, &r);
        true
    }

    /// `EraseSelfCopy`.
    EraseSelfCopy("linalg.copy", 1) |rw, op| {
        let b = &*rw.body;
        let Some(inits) = b.dps_inits(op) else { return false };
        let ops = &b[op].operands;
        if ops[..inits.start] != ops[inits.clone()] {
            return false;
        }
        if b.pure_buffer(op) {
            rw.erase_op(op);
        } else {
            let inputs = ops[..inits.start].to_vec();
            rw.replace_op(op, &inputs);
        }
        true
    }

    /// `FoldConcatsOfFill`: a concat of fills of one value is a fill of the concatenated inits.
    FoldConcatsOfFill("tensor.concat", 1) |rw, op| {
        let b = &*rw.body;
        let ins = &b[op].operands;
        let Some(first) = ins.first().and_then(|v| b.def_named(*v, "linalg.fill")) else { return false };
        let value = b[first].operands[0];
        let mut outs = vec![b[first].operands[1]];
        for v in &ins[1..] {
            let Some(f) = b.def_named(*v, "linalg.fill").filter(|f| b.same_fold_result(b[*f].operands[0], value)) else { return false };
            outs.push(b[f].operands[1]);
        }
        let Some(dim) = b[op].get("dim").cloned() else { return false };
        let Some(ty) = Lg::int(Some(&dim)).and_then(|d| b.concat_type(&outs, d as usize)) else { return false };
        rw.set_before(op);
        let c = rw.create(OpData::build("tensor.concat").operands(&outs).with("dim", dim), &[ty]);
        let c = rw.body[c].results[0];
        let f = rw.fill(value, c);
        rw.replace_op(op, &f);
        true
    }

    /// `FoldFillWithCopy`: a copy from a fill is a fill; a copy into a fill copies into its init.
    FoldFillWithCopy("linalg.copy", 1) |rw, op| {
        let b = &*rw.body;
        let (input, output) = (b[op].operands[0], b[op].operands[1]);
        let (from, into) = (b.def_named(input, "linalg.fill").map(|f| b[f].operands[0]), b.def_named(output, "linalg.fill").map(|f| b[f].operands[1]));
        rw.set_before(op);
        let r = match (from, into) {
            (Some(value), _) => rw.fill(value, output),
            (None, Some(init)) => rw.structured(OpData::build("linalg.copy").operands(&[input, init]).segments(&[1, 1])),
            _ => return false,
        };
        rw.replace_op(op, &r);
        true
    }

    /// `FoldFillWithTensorExtract`: an element of a fill is the fill value.
    FoldFillWithTensorExtract("tensor.extract", 1) |rw, op| {
        let b = &*rw.body;
        let Some(f) = b.def_named(b[op].operands[0], "linalg.fill") else { return false };
        let v = b[f].operands[0];
        rw.replace_op(op, &[v]);
        true
    }

    /// `FoldFillWithPack`: a pack of a fill (padded with the fill value) fills the pack's dest.
    FoldFillWithPack("linalg.pack", 1) |rw, op| {
        let b = &*rw.body;
        let p = Relayout::of(b, op);
        let Some(f) = b.def_named(p.source, "linalg.fill") else { return false };
        let value = b[f].operands[0];
        if p.padding.is_some_and(|pad| !b.same_int_or_value(Ofr::V(pad), Ofr::V(value))) || b.uses_len(p.dest) != 1 {
            return false;
        }
        rw.set_before(op);
        let r = rw.fill(value, p.dest);
        rw.replace_op(op, &r);
        true
    }

    /// `FoldFillWithPad`: padding a fill with its value is a fill of the padded shape.
    FoldFillWithPad("tensor.pad", 1) |rw, op| {
        let b = &*rw.body;
        let src = b[op].operands[0];
        let Some(f) = b.def_named(src, "linalg.fill") else { return false };
        let Some(value) = b.constant_padding(op).filter(|v| *v == b[f].operands[0]) else { return false };
        let rt = b[b[op].results[0]].ty.clone();
        let Some(dims) = Lg::dims(&rt) else { return false };
        let [low, high] = b.pad_lists(op);
        rw.set_before(op);
        // `PadOp::reifyResultShapes`.
        let sum = AffineMap { dims: 3, syms: 0, results: vec![AffineExpr::Dim(0).add(AffineExpr::Dim(1)).add(AffineExpr::Dim(2))] };
        let mut sizes = Vec::new();
        for (i, d) in dims.iter().enumerate() {
            if *d != DYNAMIC {
                sizes.push(Ofr::C(*d));
                continue;
            }
            let k = rw.emit(&arith::Constant::new(Lg::index(i as i64), Type::Index));
            let k = rw.body[k].results[0];
            let dim = rw.create_or_fold(OpData::build("tensor.dim").operands(&[src, k]), &[Type::Index])[0];
            sizes.push(rw.composed_folded_apply(sum.clone(), &[Ofr::V(dim), low[i], high[i]]));
        }
        let empty = rw.empty(&sizes, attr::element_type(&rt).clone());
        let mut r = rw.fill(value, empty)[0];
        if rw.body[r].ty != rt {
            r = rw.tensor_cast(r, rt);
        }
        rw.replace_op(op, &[r]);
        true
    }

    FoldFillWithCollapse("tensor.collapse_shape", 1) |rw, op| {
        rw.fill_reshape(op)
    }

    FoldFillWithExpand("tensor.expand_shape", 1) |rw, op| {
        rw.fill_reshape(op)
    }

    /// `FoldInsertPadIntoFill`: inserting a pad (of the fill value) into a fill inserts the
    /// pad's source instead, when the inserts before it touch other elements.
    FoldInsertPadIntoFill("tensor.insert_slice", 1) |rw, op| {
        let b = &*rw.body;
        let Some(pad) = b.def_named(b[op].operands[0], "tensor.pad") else { return false };
        let rank = |v: ValueId| Lg::dims(&b[v].ty).map_or(0, |d| d.len());
        let flat = |o: OpId| ["static_offsets", "static_sizes", "static_strides"].map(|n| b.dense_i64(o, n));
        if rank(b[op].results[0]) != rank(b[op].operands[0]) {
            return false;
        }
        let [io, is, it] = flat(op);
        let mut first = b[op].operands[1];
        while let Some(prev) = b.def_named(first, "tensor.insert_slice") {
            if rank(b[prev].results[0]) != rank(b[prev].operands[0]) {
                return false;
            }
            let [po, ps, pt] = flat(prev);
            let disjoint = (0..rank(b[prev].results[0])).any(|i| {
                if [io[i], is[i], it[i], po[i], ps[i], pt[i]].contains(&DYNAMIC) {
                    return false;
                }
                let (pe, ne) = (po[i] + (ps[i] - 1) * pt[i], io[i] + (is[i] - 1) * it[i]);
                pe < io[i] || ne < po[i]
            });
            if !disjoint {
                break;
            }
            first = b[prev].operands[1];
        }
        let Some(fill) = b.def_named(first, "linalg.fill") else { return false };
        if b.constant_padding(pad) != Some(b[fill].operands[0]) {
            return false;
        }
        let [low, _] = b.pad_lists(pad);
        let [offsets, _, strides] = b.slice_lists(op);
        let (psrc, dst, rt) = (b[pad].operands[0], b[op].operands[1], b[b[op].results[0]].ty.clone());
        let pdims = Lg::dims(&b[psrc].ty).unwrap_or_default();
        rw.set_before(op);
        let add = AffineMap { dims: 0, syms: 2, results: vec![AffineExpr::Sym(0).add(AffineExpr::Sym(1))] };
        let mut new_offsets = Vec::new();
        for (l, o) in low.iter().zip(&offsets) {
            new_offsets.push(rw.composed_folded_apply(add.clone(), &[*l, *o]));
        }
        let mut sizes = Vec::new();
        for (i, d) in pdims.iter().enumerate() {
            sizes.push(if *d == DYNAMIC { Ofr::V(rw.tensor_dim(psrc, i)) } else { Ofr::C(*d) });
        }
        rw.replace_with(op, OpData::sliced("tensor.insert_slice", &[psrc, dst], &[new_offsets, sizes, strides]), &[rt]);
        true
    }

    /// `FoldFillWithTranspose`: a transpose of a fill is a fill of the transpose's init.
    FoldFillWithTranspose("linalg.transpose", 1) |rw, op| {
        let b = &*rw.body;
        let Some(f) = b.def_named(b[op].operands[0], "linalg.fill") else { return false };
        let (value, init) = (b[f].operands[0], b[op].operands[1]);
        rw.set_before(op);
        let r = rw.fill(value, init);
        rw.replace_op(op, &r);
        true
    }

    EraseIdentityGenericOp("linalg.generic", 1) |rw, op| {
        rw.erase_identity(op)
    }

    CanonicalizePackOp("linalg.pack", 1) |rw, op| {
        rw.pack_canonicalize(op)
    }

    /// `FoldTransposeWithTranspose`: two transposes are one, permutations composed.
    FoldTransposeWithTranspose("linalg.transpose", 1) |rw, op| {
        let b = &*rw.body;
        let Some(d) = b.def_named(b[op].operands[0], "linalg.transpose") else { return false };
        let folded = Lg::permute(&b.dense_i64(d, "permutation"), &b.dense_i64(op, "permutation"));
        let (input, init) = (b[d].operands[0], b[op].operands[1]);
        rw.set_before(op);
        let r = rw.transpose(input, init, &folded);
        rw.replace_op(op, &r);
        true
    }

    /// `SwapTransposeWithBroadcast`: `transpose(broadcast(x))` ⇒ `broadcast(transpose(x))`.
    SwapTransposeWithBroadcast("linalg.transpose", 1) |rw, op| {
        let b = &*rw.body;
        let input = b[op].operands[0];
        let Some(bc) = b.def_named(input, "linalg.broadcast").filter(|_| b.uses_len(input) == 1) else { return false };
        let (dims, perm) = (b.dense_i64(bc, "dimensions"), b.dense_i64(op, "permutation"));
        let result_perm = Lg::drop_dims(&perm, &dims);
        let inv = Lg::invert(&perm);
        let result_dims: Vec<i64> = dims.iter().map(|d| inv[*d as usize]).collect();
        let (src, init) = (b[bc].operands[0], b[op].operands[1]);
        let (shape, elem) = (Lg::dims(&b[src].ty).unwrap_or_default(), attr::element_type(&b[src].ty).clone());
        rw.set_before(op);
        let mut sizes = Vec::new();
        for (i, d) in shape.iter().enumerate() {
            sizes.push(if *d == DYNAMIC { Ofr::V(rw.tensor_dim(src, i)) } else { Ofr::C(*d) });
        }
        let empty = rw.empty(&Lg::permute(&sizes, &result_perm), elem);
        let t = rw.transpose(src, empty, &result_perm)[0];
        let r = rw.broadcast(t, init, &result_dims);
        rw.replace_op(op, &r);
        true
    }

    CanonicalizeUnPackOp("linalg.unpack", 1) |rw, op| {
        rw.unpack_canonicalize(op)
    }
}

/// `LinalgDialect::getCanonicalizationPatterns`, then the ops', by op name.
pub fn patterns(set: &mut PatternSet) {
    set.add(EraseDeadLinalgOp).add(FoldTensorCastConsumerOp).add(FoldTensorCastPackOp).add(FoldTensorCastUnPackOp).add(InferStaticShapeOfOperands);
    set.add(EraseIdentityBroadcastOp).add(FoldBroadcasts);
    set.add(EraseSelfCopy);
    set.add(FoldConcatsOfFill).add(FoldFillWithCopy).add(FoldFillWithTensorExtract).add(FoldFillWithPack).add(FoldFillWithPad);
    set.add(FoldFillWithCollapse).add(FoldFillWithExpand).add(FoldInsertPadIntoFill).add(FoldFillWithTranspose);
    set.add(EraseIdentityGenericOp);
    set.add(CanonicalizePackOp);
    set.add(FoldTransposeWithTranspose).add(SwapTransposeWithBroadcast);
    set.add(CanonicalizeUnPackOp);
}
