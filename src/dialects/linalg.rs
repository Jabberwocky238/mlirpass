//! The `linalg` dialect's op interfaces.

use alloc::vec::Vec;

use mlirformat::{AffineExpr, AffineMap, Attribute, Dim};

use crate::{Body, EffectInstance, EffectKind, OpId, OpInterfaces};

#[path = "linalg_named.gen.rs"]
mod named;
pub use named::OPDSL;

/// An OpDSL op (`LinalgNamedStructuredOps.yaml`), as mlir-linalg-ods-yaml-gen reads it for
/// `getIndexingMaps` / `getIteratorTypesArray`.
pub struct OpDsl<'s> {
    pub name: &'s str,
    /// Each loop's iterator type, `true` for a reduction; none when the op is rank polymorphic.
    pub reductions: &'s [bool],
    /// `static_indexing_maps` as written.
    pub maps: &'s [&'s str],
    pub attrs: &'s [IndexAttr<'s>],
}

/// An index attribute (`strides`, `dilations`): the symbol each element binds, its defaults.
pub struct IndexAttr<'s> {
    pub name: &'s str,
    pub syms: &'s [u32],
    pub defaults: &'s [i64],
}

impl OpDsl<'_> {
    /// The OpDSL op named `name`.
    pub fn of(name: &str) -> Option<&OpDsl<'_>> {
        OPDSL.iter().find(|o| o.name == name)
    }

    /// The iteration domain has rank zero: the maps follow the operands' ranks.
    pub fn rank_polymorphic(&self) -> bool {
        self.reductions.is_empty()
    }

    /// `getIndexingMaps` of a static-rank op: the symbols an index attribute binds become its
    /// values (`attr(name)`, or the defaults), the others are dropped, and each map is simplified.
    pub fn indexing_maps(&self, attr: impl Fn(&str) -> Option<Vec<i64>>) -> Option<Vec<AffineMap>> {
        let maps: Vec<AffineMap> = self.maps.iter().map(|m| AffineMap::parse(m.strip_prefix("affine_map")?)).collect::<Option<_>>()?;
        let first = maps.first()?;
        let mut syms: Vec<AffineExpr> = (0..first.syms).map(AffineExpr::Sym).collect();
        for a in self.attrs {
            let values = attr(a.name).unwrap_or_else(|| a.defaults.to_vec());
            for (s, v) in a.syms.iter().zip(values) {
                *syms.get_mut(*s as usize)? = AffineExpr::Const(v);
            }
        }
        Some(maps.iter().map(|m| m.replace(&[], &syms, m.dims, 0).simplified()).collect())
    }
}

/// The `linalg` dialect.
pub struct LinalgDialect;

impl LinalgDialect {
    /// `linalg.pack` / `linalg.unpack`: speculatable when every tiled dimension is static and
    /// every tile size a constant.
    fn pack_speculatability(b: &Body<'_>, op: OpId) -> Option<bool> {
        let pack = b[op].name == "linalg.pack";
        let segs = b.segments(op, "operandSegmentSizes");
        if pack && segs.as_ref().is_some_and(|s| s.get(2) == Some(&1)) {
            return Some(false);
        }
        let tiles: Vec<i64> = match b[op].get("static_inner_tiles") {
            Some(Attribute::DenseArray { values, .. }) => values.iter().map(|v| v.parse().unwrap_or(0)).collect(),
            _ => Vec::new(),
        };
        let first_dynamic = if pack { segs.as_ref().map_or(2, |s| s[..3].iter().sum()) } else { 2 };
        let mut dynamic = b[op].operands[first_dynamic..].iter();
        let packed = &b[b[op].operands[usize::from(pack)]].ty;
        let shape = packed.shape()?;
        let dims = &shape[shape.len() - tiles.len()..];
        for (d, t) in dims.iter().zip(&tiles) {
            let constant = *t != i64::MIN || dynamic.next().is_some_and(|v| b.int_constant(*v).is_some());
            if !constant || !matches!(d, Dim::Static(_)) {
                return None;
            }
        }
        Some(false)
    }
}

impl OpInterfaces for LinalgDialect {
    fn namespace(&self) -> &str {
        "linalg"
    }

    /// `OpAsmOpInterface::getAsmResultNames`.
    fn asm_result_names(&self, b: &crate::Body<'_>, op: crate::OpId) -> alloc::vec::Vec<(crate::ValueId, alloc::borrow::Cow<'static, str>)> {
        let name = match &*b[op].name {
            "linalg.map" => "mapped",
            "linalg.reduce" => "reduced",
            "linalg.transpose" => "transposed",
            "linalg.broadcast" => "broadcasted",
            "linalg.pack" => "pack",
            "linalg.unpack" => "unpack",
            _ => return alloc::vec::Vec::new(),
        };
        b.result_named(op, name)
    }

    /// `getAsmBlockArgumentNames`: `%in` for the inputs' arguments, `%out` (`linalg.generic`)
    /// or `%init` for the inits'.
    fn asm_block_arg_names(&self, b: &crate::Body<'_>, op: crate::OpId, r: crate::RegionId) -> alloc::vec::Vec<(crate::ValueId, alloc::borrow::Cow<'static, str>)> {
        let n = b[op].operands.len();
        let (inputs, inits, out) = match &*b[op].name {
            "linalg.generic" => (b.operand_group(op, 0).len(), b.operand_group(op, 1).len(), "out"),
            "linalg.map" => (n.saturating_sub(1), 1, "init"),
            "linalg.reduce" => (n / 2, n / 2, "init"),
            _ => return alloc::vec::Vec::new(),
        };
        let Some(entry) = b[r].blocks.first() else { return alloc::vec::Vec::new() };
        let args = &b[*entry].args;
        let ins = args.iter().take(inputs).map(|a| (*a, "in".into()));
        let outs = args.iter().skip(args.len().saturating_sub(inits)).map(|a| (*a, out.into()));
        ins.chain(outs).collect()
    }

    #[cfg(feature = "dialect.bufferization")]
    fn bufferizable(&self, name: &str) -> Option<&dyn crate::Bufferizable> {
        Self::bufferizable_op(name)
    }

    fn reify<'a>(&self, rw: &mut crate::Rewriter<'_, 'a>, op: OpId) -> Option<Vec<Vec<crate::MemrefOfr>>> {
        match &*rw.body[op].name {
            "linalg.softmax" => Self::reify_softmax(rw, op),
            // Their own `reifyResultShapes`, not ported.
            "linalg.pack" | "linalg.unpack" => None,
            _ => Self::reify_structured(rw, op),
        }
    }

    /// `getGenericEffectsImpl` of a structured op: memref inputs are read, memref inits
    /// written (and read when the payload uses them).
    fn effects(&self, b: &Body<'_>, op: OpId) -> Option<Vec<EffectInstance>> {
        use EffectKind::{Read, Write};
        // The inits by `DestinationStyleOpInterface` (`linalg.map` has no segment sizes).
        let n = b[op].operands.len();
        let inits = b.dps_inits(op).unwrap_or(n..n);
        let (ins, outs) = (&b[op].operands[..inits.start], &b[op].operands[inits]);
        let entry = b[op].regions.first().and_then(|r| b[*r].blocks.first()).map(|blk| &b[*blk].args);
        let mut out: Vec<_> = ins.iter().filter(|v| b.is_memref(**v)).map(|v| EffectInstance::on(Read, Some(*v))).collect();
        for (j, v) in outs.iter().enumerate().filter(|(_, v)| b.is_memref(**v)) {
            let used = entry.and_then(|args| args.get(ins.len() + j)).is_some_and(|a| !b[*a].uses.is_empty());
            if used {
                out.push(EffectInstance::on(Read, Some(*v)));
            }
            out.push(EffectInstance::on(Write, Some(*v)));
        }
        Some(out)
    }

    fn speculatability(&self, b: &Body<'_>, op: OpId) -> Option<bool> {
        match &*b[op].name {
            "linalg.pack" | "linalg.unpack" => Self::pack_speculatability(b, op),
            _ => b[op].operands.iter().all(|v| !b.is_memref(*v)).then_some(true),
        }
    }
}

impl LinalgDialect {
    /// `SoftmaxOp::reifyResultShapes`, as upstream writes it: a static size of the output is the
    /// input's (static or not), a dynamic one the input's dim.
    fn reify_softmax(rw: &mut crate::Rewriter<'_, '_>, op: OpId) -> Option<Vec<Vec<crate::MemrefOfr>>> {
        use crate::MemrefOfr as Ofr;
        let (input, output) = (rw.body[op].operands[0], *rw.body[op].operands.get(1)?);
        let (ins, outs) = (rw.body[input].ty.dims()?, rw.body[output].ty.dims()?);
        let sizes = (0..outs.len())
            .map(|d| {
                if outs[d] != Dim::DYNAMIC {
                    Ofr::C(ins[d])
                } else {
                    Ofr::V(rw.fold_dim(input, d))
                }
            })
            .collect();
        Some(alloc::vec![sizes])
    }

    /// `LinalgOp::reifyResultShapes`: each init's sizes from the operands' (all of them built
    /// first, `createFlatListOfOperandDims`) through `loopsToShapes ∘ shapesToLoops`, composed and
    /// folded result by result; a size depending on the inits' own is the init's dim.
    fn reify_structured(rw: &mut crate::Rewriter<'_, '_>, op: OpId) -> Option<Vec<Vec<crate::MemrefOfr>>> {
        use crate::MemrefOfr as Ofr;
        let maps = rw.body.indexing_maps(op)?;
        let inits = rw.body.dps_inits(op)?;
        let operands = rw.body[op].operands.to_vec();
        let ranks: Vec<usize> = operands.iter().map(|v| rw.body[*v].ty.dims().map_or(0, |d| d.len())).collect();
        // `getLoopsToShapesMap`: every operand's map, concatenated.
        let loops = maps.first()?.dims;
        let all: Vec<AffineExpr> = maps.iter().flat_map(|m| m.results.iter().cloned()).collect();
        let flat = all.len() as u32;
        // `inversePermutation`: each loop at the first shape position that is just it.
        let mut inv: Vec<Option<AffineExpr>> = alloc::vec![None; loops as usize];
        for (i, e) in all.iter().enumerate() {
            if let AffineExpr::Dim(d) = e
                && inv[*d as usize].is_none()
            {
                inv[*d as usize] = Some(AffineExpr::Dim(i as u32));
            }
        }
        let shapes_to_loops = AffineMap { dims: flat, syms: 0, results: inv.into_iter().collect::<Option<Vec<_>>>()? };
        // `getResultsPositionInLoopsToShapeMap`: the inits' positions.
        let first: usize = ranks[..inits.start].iter().sum();
        let last = first + ranks[inits.clone()].iter().sum::<usize>();
        let results = AffineMap { dims: loops, syms: 0, results: all[first..last].to_vec() }.compose(&shapes_to_loops);
        let on_inits = |e: &AffineExpr| {
            let mut hit = false;
            e.walk(&mut |x| hit |= matches!(x, AffineExpr::Dim(d) if (first..last).contains(&(*d as usize))));
            hit
        };
        let dims: Vec<Ofr> = operands.iter().zip(&ranks).flat_map(|(v, r)| (0..*r).map(move |i| (*v, i))).collect::<Vec<_>>().into_iter().map(|(v, i)| rw.mixed_size(v, i)).collect();
        // `makeComposedFoldedMultiResultAffineApply`.
        let values: Vec<Ofr> = results.results.iter().map(|e| rw.composed_folded_apply(AffineMap { dims: flat, syms: 0, results: alloc::vec![e.clone()] }, &dims)).collect();
        let mut pos = 0;
        let mut out = Vec::new();
        for init in operands[inits].iter().copied() {
            let shape = rw.body[init].ty.dims().unwrap_or_default();
            let mut sizes = Vec::new();
            for (d, s) in shape.iter().enumerate() {
                sizes.push(if *s != Dim::DYNAMIC {
                    Ofr::C(*s)
                } else {
                    let size = if on_inits(&results.results[pos]) { Ofr::V(rw.fold_dim(init, d)) } else { values[pos] };
                    Ofr::V(rw.value_of(size))
                });
                pos += 1;
            }
            out.push(sizes);
        }
        Some(out)
    }
}

#[cfg(feature = "dialect.bufferization")]
mod bufferizable {
    use alloc::vec;
    use alloc::vec::Vec;

    use mlirformat::{AffineMap, Attribute, Error};

    use super::LinalgDialect;
    use crate::{buffer_of, replace_with_buffers, AliasingValue, AnalysisState, Body, Bufferizable, BufferizationOptions, OpData, OpId, Operand, Rewriter};

    /// A structured op (`LinalgOpInterface`), and `linalg.softmax`.
    struct Structured;
    struct Softmax;
    /// `linalg.pack` / `linalg.unpack` (`PackOpInterface` / `UnPackOpInterface`).
    struct Relayout;

    impl LinalgDialect {
        pub(crate) fn bufferizable_op(name: &str) -> Option<&'static dyn Bufferizable> {
            match name {
                "linalg.softmax" => Some(&Softmax),
                "linalg.pack" | "linalg.unpack" => Some(&Relayout),
                "linalg.yield" | "linalg.index" => None,
                _ => Some(&Structured),
            }
        }
    }

    /// The init operands of destination-style `op`.
    fn inits(b: &Body<'_>, op: OpId) -> core::ops::Range<usize> {
        b.dps_inits(op).unwrap_or(b[op].operands.len()..b[op].operands.len())
    }

    impl Bufferizable for Structured {
        /// `payloadUsesValueFromOperand`.
        fn reads(&self, _: &AnalysisState<'_>, b: &Body<'_>, (op, i): Operand) -> bool {
            let Some(blk) = b[op].regions.first().and_then(|r| b[*r].blocks.first()) else { return true };
            b[*blk].args.get(i).is_some_and(|a| !b[*a].uses.is_empty())
        }

        fn writes(&self, _: &AnalysisState<'_>, b: &Body<'_>, (op, i): Operand) -> bool {
            inits(b, op).contains(&i)
        }

        fn aliasing_values(&self, _: &AnalysisState<'_>, b: &Body<'_>, (op, i): Operand) -> Vec<AliasingValue> {
            let r = inits(b, op);
            if r.contains(&i) { b[op].results.get(i - r.start).map(|v| vec![AliasingValue::equivalent(*v)]).unwrap_or_default() } else { Vec::new() }
        }

        /// All loops parallel, and the operands asked indexed by the identity.
        fn elementwise(&self, _: &AnalysisState<'_>, b: &Body<'_>, operands: &[Operand]) -> bool {
            let Some(&(op, _)) = operands.first() else { return false };
            let parallel = match b[op].get("iterator_types") {
                Some(Attribute::Array(xs)) => xs.iter().all(|a| *a == Attribute::dialect("linalg.iterator_type", "<parallel>")),
                _ => matches!(&*b[op].name, "linalg.fill" | "linalg.copy" | "linalg.map" | "linalg.elementwise" | "linalg.add" | "linalg.sub" | "linalg.mul" | "linalg.div" | "linalg.div_unsigned" | "linalg.max" | "linalg.min" | "linalg.powf" | "linalg.exp" | "linalg.log" | "linalg.abs" | "linalg.ceil" | "linalg.floor" | "linalg.negf" | "linalg.reciprocal" | "linalg.round" | "linalg.sqrt" | "linalg.rsqrt" | "linalg.square" | "linalg.tanh" | "linalg.erf" | "linalg.select"),
            };
            if !parallel {
                return false;
            }
            let Some(maps) = b.indexing_maps(op) else { return false };
            operands.iter().all(|(_, i)| !matches!(&b[b[op].operands[*i]].ty, mlirformat::Type::Shaped(s) if s.shape.is_some()) || maps.get(*i).is_some_and(AffineMap::is_identity))
        }

        /// `bufferizeDestinationStyleOpInterface`: the same op on the buffers, results
        /// replaced by the inits' buffers.
        fn bufferize(&self, rw: &mut Rewriter<'_, '_>, o: &BufferizationOptions, op: OpId) -> Result<(), Error> {
            let operands = rw.body[op].operands.to_vec();
            let tensor = |b: &Body<'_>, v: crate::ValueId| crate::is_tensor(&b[v].ty);
            if !operands.iter().any(|v| tensor(rw.body, *v)) && !rw.body[op].results.iter().any(|v| tensor(rw.body, *v)) {
                return Ok(());
            }
            let r = inits(rw.body, op);
            let mut new = Vec::new();
            for (i, v) in operands.iter().enumerate() {
                if i >= r.start {
                    break;
                }
                new.push(if tensor(rw.body, *v) { buffer_of(rw, o, *v)? } else { *v });
            }
            let mut outs = Vec::new();
            for k in 0..rw.body[op].results.len() {
                outs.push(buffer_of(rw, o, operands[r.start + k])?);
            }
            new.extend(&outs);
            rw.set_before(op);
            let old = rw.body[op].clone();
            let mut data = OpData::named(old.name.clone()).operands(&new);
            data.properties.clone_from(&old.properties);
            data.attributes.clone_from(&old.attributes);
            let region = old.regions[0];
            let n = rw.create_with(data, &[], |b, o| {
                b.add_region(o);
            });
            let into = rw.body[n].regions[0];
            rw.inline_region_before(region, into, None);
            replace_with_buffers(rw, op, &outs);
            Ok(())
        }
    }

    impl Bufferizable for Softmax {
        fn reads(&self, _: &AnalysisState<'_>, _: &Body<'_>, (_, i): Operand) -> bool {
            i == 0
        }

        fn writes(&self, _: &AnalysisState<'_>, _: &Body<'_>, (_, i): Operand) -> bool {
            i == 1
        }

        fn aliasing_values(&self, _: &AnalysisState<'_>, b: &Body<'_>, (op, i): Operand) -> Vec<AliasingValue> {
            if i == 1 { vec![AliasingValue::equivalent(b[op].results[0])] } else { Vec::new() }
        }

        fn bufferize(&self, rw: &mut Rewriter<'_, '_>, o: &BufferizationOptions, op: OpId) -> Result<(), Error> {
            let (input, output) = (rw.body[op].operands[0], rw.body[op].operands[1]);
            let ib = buffer_of(rw, o, input)?;
            let ob = buffer_of(rw, o, output)?;
            let mut data = OpData::named(rw.body[op].name.clone()).operands(&[ib, ob]);
            data.properties.clone_from(&rw.body[op].properties);
            rw.create(data, &[]);
            replace_with_buffers(rw, op, &[ob]);
            Ok(())
        }
    }

    /// The destination is operand 1; the source (and a pack's padding and tiles) are read.
    const RELAYOUT_DEST: usize = 1;

    impl Bufferizable for Relayout {
        fn reads(&self, _: &AnalysisState<'_>, _: &Body<'_>, (_, i): Operand) -> bool {
            i != RELAYOUT_DEST
        }

        fn writes(&self, _: &AnalysisState<'_>, _: &Body<'_>, (_, i): Operand) -> bool {
            i == RELAYOUT_DEST
        }

        fn aliasing_values(&self, _: &AnalysisState<'_>, b: &Body<'_>, (op, i): Operand) -> Vec<AliasingValue> {
            match b[op].results.first() {
                Some(r) if i == RELAYOUT_DEST => vec![AliasingValue::equivalent(*r)],
                _ => Vec::new(),
            }
        }

        fn bufferize(&self, rw: &mut Rewriter<'_, '_>, o: &BufferizationOptions, op: OpId) -> Result<(), Error> {
            let mut operands = rw.body[op].operands.to_vec();
            if !crate::is_tensor(&rw.body[operands[0]].ty) || !crate::is_tensor(&rw.body[operands[RELAYOUT_DEST]].ty) {
                return Err(Error(alloc::format!("'{}' op mixed tensor/buffer semantic op not supported yet", rw.body[op].name)));
            }
            operands[0] = buffer_of(rw, o, operands[0])?;
            operands[RELAYOUT_DEST] = buffer_of(rw, o, operands[RELAYOUT_DEST])?;
            let dest = operands[RELAYOUT_DEST];
            rw.set_before(op);
            let old = rw.body[op].clone();
            let mut data = OpData::named(old.name.clone()).operands(&operands);
            data.properties.clone_from(&old.properties);
            data.attributes.clone_from(&old.attributes);
            rw.create(data, &[]);
            replace_with_buffers(rw, op, &[dest]);
            Ok(())
        }
    }
}
