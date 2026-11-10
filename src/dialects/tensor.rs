//! The `tensor` dialect's op interfaces.

use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{Dim, Type};

use crate::{AffineExpr, AffineMap, Body, DialectInliner, InlineAll, MemrefOfr as Ofr, OpData, OpId, OpInterfaces, Rewriter};

/// The `tensor` dialect.
pub struct TensorDialect;

impl OpInterfaces for TensorDialect {
    fn namespace(&self) -> &str {
        "tensor"
    }

    /// `getAsmResultNames`: each op's fixed name (`%extracted_slice`, `%padded`, ...).
    fn asm_result_names(&self, b: &crate::Body<'_>, op: crate::OpId) -> alloc::vec::Vec<(crate::ValueId, alloc::borrow::Cow<'static, str>)> {
        let name = match &*b[op].name {
            "tensor.cast" => "cast",
            "tensor.concat" => "concat",
            "tensor.dim" => "dim",
            "tensor.extract" => "extracted",
            "tensor.from_elements" => "from_elements",
            "tensor.gather" => "gather",
            "tensor.insert" => "inserted",
            "tensor.generate" => "generated",
            "tensor.rank" => "rank",
            "tensor.reshape" => "reshape",
            "tensor.collapse_shape" => "collapsed",
            "tensor.expand_shape" => "expanded",
            "tensor.extract_slice" => "extracted_slice",
            "tensor.insert_slice" => "inserted_slice",
            "tensor.pad" => "padded",
            "tensor.scatter" => "scatter",
            "tensor.splat" => "splat",
            _ => return alloc::vec::Vec::new(),
        };
        b.result_named(op, name)
    }

    /// Ops inline, and into regions (`TensorInlinerInterface`).
    fn inliner(&self) -> Option<&dyn DialectInliner> {
        Some(&InlineAll { calls: false, regions: true })
    }

    fn speculatability(&self, b: &Body<'_>, op: OpId) -> Option<bool> {
        if b[op].name == "tensor.dim" { b.dim_speculatability(op) } else { None }
    }

    #[cfg(feature = "dialect.bufferization")]
    fn bufferizable(&self, name: &str) -> Option<&dyn crate::Bufferizable> {
        Self::bufferizable_op(name)
    }

    fn reify<'a>(&self, rw: &mut Rewriter<'_, 'a>, op: OpId) -> Option<Vec<Vec<Ofr>>> {
        let b = &*rw.body;
        let dims = b[*b[op].results.first()?].ty.dims()?;
        let sizes = match &*b[op].name {
            // `EmptyOp`, `GenerateOp`, `SplatOp::reifyResultShapes`: the dynamic sizes are operands.
            "tensor.empty" | "tensor.generate" => Ofr::mixed(&dims, &b[op].operands),
            "tensor.splat" => Ofr::mixed(&dims, &b[op].operands[1..]),
            // `ReifyExpandShapeOp`: `getMixedOutputShape`.
            "tensor.expand_shape" => Ofr::mixed(&b.dense_i64(op, "static_output_shape"), &b[op].operands[1..]),
            "tensor.extract_slice" => Self::slice_sizes(b, op, &dims),
            // `InsertSliceOp::reifyResultShapes`: the destination's sizes.
            "tensor.insert_slice" => {
                let dest = b[op].operands[1];
                rw.mixed_sizes(dest)
            }
            "tensor.pad" => Self::pad(rw, op, &dims),
            "tensor.collapse_shape" => Self::collapse(rw, op, &dims),
            "tensor.concat" => Self::concat(rw, op, &dims),
            _ => return None,
        };
        Some(vec![sizes])
    }
}

impl TensorDialect {
    /// `ExtractSliceOp::reifyResultShapes`: its sizes but those `getDroppedDims` drops (a 1 the
    /// result does not keep).
    fn slice_sizes(b: &Body<'_>, op: OpId, result: &[i64]) -> Vec<Ofr> {
        let mut at = 0;
        b.slice_lists(op)[1]
            .iter()
            .filter(|s| {
                let kept = b.ofr_int(**s) != Some(1) || result.get(at) == Some(&1);
                at += usize::from(kept);
                kept
            })
            .copied()
            .collect()
    }

    /// `PadOp::reifyResultShapes` (its own, not the `ReifyPadOp` external model): a dynamic size is
    /// the source's plus both pads (`d0 + d1 + d2`, composed and folded).
    fn pad(rw: &mut Rewriter<'_, '_>, op: OpId, result: &[i64]) -> Vec<Ofr> {
        let src = rw.body[op].operands[0];
        let [low, high] = rw.body.pad_lists(op);
        let sum = AffineMap { dims: 3, syms: 0, results: vec![AffineExpr::Dim(0).add(AffineExpr::Dim(1)).add(AffineExpr::Dim(2))] };
        (0..result.len())
            .map(|i| {
                if result[i] != Dim::DYNAMIC {
                    return Ofr::C(result[i]);
                }
                let d = rw.fold_dim(src, i);
                rw.composed_folded_apply(sum.clone(), &[Ofr::V(d), low[i], high[i]])
            })
            .collect()
    }

    /// `ConcatOp::reifyResultShapes`: the concatenated size is the sum of the inputs' (composed
    /// and folded); another dynamic size is an input's static one, else the first input's dim.
    fn concat(rw: &mut Rewriter<'_, '_>, op: OpId, result: &[i64]) -> Vec<Ofr> {
        let dim = match rw.body[op].get("dim") {
            Some(mlirformat::Attribute::Int { lit, .. }) => lit.trim().parse::<usize>().unwrap_or(0),
            _ => 0,
        };
        let inputs = rw.body[op].operands.to_vec();
        let shapes: Vec<Vec<i64>> = inputs.iter().map(|v| rw.body[*v].ty.dims().unwrap_or_default()).collect();
        (0..result.len())
            .map(|i| {
                if result[i] != Dim::DYNAMIC {
                    return Ofr::C(result[i]);
                }
                if i == dim {
                    let sum = (1..inputs.len()).fold(AffineExpr::Dim(0), |e, k| e.add(AffineExpr::Dim(k as u32)));
                    let sizes: Vec<Ofr> = inputs.iter().map(|v| Ofr::V(rw.fold_dim(*v, i))).collect();
                    let map = AffineMap { dims: inputs.len() as u32, syms: 0, results: vec![sum] };
                    let r = rw.composed_folded_apply(map, &sizes);
                    return Ofr::V(rw.value_of(r));
                }
                if let Some(c) = shapes.iter().map(|s| s[i]).find(|d| *d != Dim::DYNAMIC) {
                    return Ofr::V(rw.value_of(Ofr::C(c)));
                }
                let k = rw.value_of(Ofr::C(i as i64));
                let d = rw.create(OpData::build("tensor.dim").operands(&[inputs[0], k]), &[Type::Index]);
                Ofr::V(rw.body[d].results[0])
            })
            .collect()
    }

    /// `ReifyCollapseShapeOp` (`getCollapsedOutputDimFromInputShape`): a dynamic size is the
    /// product of the source's sizes in its group (`s0 * s1 * ..`, composed, not folded).
    fn collapse(rw: &mut Rewriter<'_, '_>, op: OpId, result: &[i64]) -> Vec<Ofr> {
        let src = rw.body[op].operands[0];
        let groups = rw.body.reassociation(op);
        (0..result.len())
            .map(|i| {
                if result[i] != Dim::DYNAMIC {
                    return Ofr::C(result[i]);
                }
                let group = &groups[i];
                let (start, end) = (*group.first().expect("a group") as usize, *group.last().expect("a group") as usize);
                let mut expr: Option<AffineExpr> = None;
                let mut operands = Vec::new();
                for d in start..=end {
                    operands.push(Ofr::V(rw.fold_dim(src, d)));
                    let s = AffineExpr::Sym((d - start) as u32);
                    expr = Some(match expr {
                        Some(e) => e.mul(s),
                        None => s,
                    });
                }
                let map = AffineMap { dims: 0, syms: (end - start + 1) as u32, results: vec![expr.expect("a non-empty group")] };
                Ofr::V(rw.composed_apply(map, &operands))
            })
            .collect()
    }
}

#[cfg(feature = "dialect.bufferization")]
mod bufferizable {
    use alloc::vec;
    use alloc::vec::Vec;

    use mlirformat::{Dim, Error, Type};

    use super::TensorDialect;
    use crate::{buffer_of, buffer_type, replace_with_buffers, AffineExpr, AffineMap, AliasingValue, AnalysisState, Body, Bufferizable, BufferizationOptions, MemrefLayout, MemrefOfr as Ofr, MemrefReshape, OpData, OpId, Operand, RegionId, Rewriter, ValueId};

    /// `tensor.cast`.
    struct Cast;
    /// `tensor.collapse_shape`.
    struct Collapse;
    /// `tensor.expand_shape`.
    struct Expand;
    /// `tensor.dim`, `tensor.rank`: neither read nor write, alias nothing.
    struct Query;
    /// `tensor.empty`.
    struct Empty;
    /// `tensor.extract_slice`.
    struct ExtractSlice;
    /// `tensor.extract`.
    struct Extract;
    /// `tensor.from_elements`.
    struct FromElements;
    /// `tensor.insert`.
    struct Insert;
    /// `tensor.insert_slice`.
    struct InsertSlice;

    impl TensorDialect {
        pub(crate) fn bufferizable_op(name: &str) -> Option<&'static dyn Bufferizable> {
            Some(match name {
                "tensor.cast" => &Cast,
                "tensor.collapse_shape" => &Collapse,
                "tensor.expand_shape" => &Expand,
                "tensor.dim" | "tensor.rank" => &Query,
                "tensor.empty" => &Empty,
                "tensor.extract_slice" => &ExtractSlice,
                "tensor.extract" => &Extract,
                "tensor.from_elements" => &FromElements,
                "tensor.insert" => &Insert,
                "tensor.insert_slice" => &InsertSlice,
                "tensor.parallel_insert_slice" => &ParallelInsertSlice,
                "tensor.generate" => &Generate,
                "tensor.splat" => &Splat,
                "tensor.concat" => &Concat,
                "tensor.pad" => &Pad,
                "tensor.reshape" => &Reshape,
                _ => return None,
            })
        }
    }

    /// `op`'s single result, replaced by a new op `data` of buffer type `ty`
    /// (`replaceOpWithNewBufferizedOp`).
    fn replace_new<'a>(rw: &mut Rewriter<'_, 'a>, op: OpId, data: OpData<'a>, ty: Type<'a>) {
        let n = rw.create(data, &[ty]);
        let v = rw.body[n].results[0];
        replace_with_buffers(rw, op, &[v]);
    }

    /// The memref type of `ty` with the memory space of buffer `of`.
    fn space_of<'a>(of: &Type<'a>) -> Option<mlirformat::Attribute<'a>> {
        match of {
            Type::Shaped(m) => m.extras.iter().find(|a| !a.is_layout()).cloned(),
            _ => None,
        }
    }

    impl Bufferizable for Cast {
        fn reads(&self, _: &AnalysisState<'_>, _: &Body<'_>, _: Operand) -> bool {
            false
        }

        fn writes(&self, _: &AnalysisState<'_>, _: &Body<'_>, _: Operand) -> bool {
            false
        }

        fn aliasing_values(&self, _: &AnalysisState<'_>, b: &Body<'_>, (op, _): Operand) -> Vec<AliasingValue> {
            vec![AliasingValue::equivalent(b[op].results[0])]
        }

        /// The source buffer's layout (fully dynamic from or to an unranked tensor).
        fn buffer_type<'a>(&self, o: &BufferizationOptions, b: &Body<'a>, v: ValueId, stack: &mut Vec<ValueId>) -> Result<Type<'a>, Error> {
            let op = b.owner_of(v);
            let src = b[op].operands[0];
            let sb = crate::buffer_type_in(o, b, src, stack)?;
            let space = space_of(&sb);
            let (Type::Shaped(st), Type::Shaped(rt), Type::Shaped(sm)) = (&b[src].ty, &b[v].ty, &sb) else { return Err(Error("expected tensors".into())) };
            if st.shape.is_none() || rt.shape.is_none() {
                return Ok(BufferizationOptions::fully_dynamic(rt, space));
            }
            let layout = sm.extras.iter().find(|a| a.is_layout()).cloned();
            Ok(BufferizationOptions::memref(rt, layout, space))
        }

        fn bufferize(&self, rw: &mut Rewriter<'_, '_>, o: &BufferizationOptions, op: OpId) -> Result<(), Error> {
            let src = rw.body[op].operands[0];
            let buffer = buffer_of(rw, o, src)?;
            let ty = buffer_type(o, rw.body, rw.body[op].results[0])?;
            if rw.body[buffer].ty == ty {
                replace_with_buffers(rw, op, &[buffer]);
            } else {
                replace_new(rw, op, OpData::build("memref.cast").operands(&[buffer]), ty);
            }
            Ok(())
        }
    }

    impl Bufferizable for Collapse {
        fn writes(&self, _: &AnalysisState<'_>, _: &Body<'_>, _: Operand) -> bool {
            false
        }

        fn aliasing_values(&self, _: &AnalysisState<'_>, b: &Body<'_>, (op, _): Operand) -> Vec<AliasingValue> {
            vec![AliasingValue::equivalent(b[op].results[0])]
        }

        fn buffer_type<'a>(&self, o: &BufferizationOptions, b: &Body<'a>, v: ValueId, stack: &mut Vec<ValueId>) -> Result<Type<'a>, Error> {
            let op = b.owner_of(v);
            let sb = crate::buffer_type_in(o, b, b[op].operands[0], stack)?;
            let Type::Shaped(sm) = &sb else { return Err(Error("expected a memref".into())) };
            let groups = b.reassociation(op);
            if !sm.guaranteed_collapsible(&groups) {
                let Type::Shaped(rt) = &b[v].ty else { return Err(Error("expected a tensor".into())) };
                return Ok(BufferizationOptions::identity(rt, space_of(&sb)));
            }
            sm.collapsed(&groups).ok_or_else(|| Error("cannot collapse".into()))
        }

        fn bufferize(&self, rw: &mut Rewriter<'_, '_>, o: &BufferizationOptions, op: OpId) -> Result<(), Error> {
            let src = rw.body[op].operands[0];
            let mut buffer = buffer_of(rw, o, src)?;
            let groups = rw.body.reassociation(op);
            let reassociation = rw.body[op].get("reassociation").cloned().expect("a reassociation");
            let Type::Shaped(bt) = rw.body[buffer].ty.clone() else { return Err(Error("expected a memref".into())) };
            let Type::Shaped(rt) = rw.body[rw.body[op].results[0]].ty.clone() else { return Err(Error("expected a tensor".into())) };
            if rt.dims().is_some_and(|d| d.is_empty()) {
                let layout = if bt.identity_layout() {
                    None
                } else {
                    let (_, offset) = bt.strides_and_offset().ok_or_else(|| Error("no strides".into()))?;
                    Some(mlirformat::StridedLayout { strides: Vec::new(), offset }.into())
                };
                let space = space_of(&rw.body[buffer].ty);
                let ty = BufferizationOptions::memref(&rt, layout, space);
                replace_new(rw, op, OpData::build("memref.collapse_shape").operands(&[buffer]).with("reassociation", reassociation), ty);
                return Ok(());
            }
            if !bt.guaranteed_collapsible(&groups) {
                let state = AnalysisState::new(o);
                let alloc = state.allocate_tensor_for(rw, src, true)?;
                let Type::Shaped(st) = rw.body[src].ty.clone() else { return Err(Error("expected a tensor".into())) };
                let mty = BufferizationOptions::identity(&st, space_of(&rw.body[buffer].ty));
                let t = rw.create(OpData::build("bufferization.to_buffer").operands(&[alloc]), &[mty]);
                buffer = rw.body[t].results[0];
            }
            let Type::Shaped(bt) = rw.body[buffer].ty.clone() else { return Err(Error("expected a memref".into())) };
            let ty = bt.collapsed(&groups).ok_or_else(|| Error("cannot collapse".into()))?;
            replace_new(rw, op, OpData::build("memref.collapse_shape").operands(&[buffer]).with("reassociation", reassociation), ty);
            Ok(())
        }
    }

    impl Bufferizable for Expand {
        fn reads(&self, _: &AnalysisState<'_>, _: &Body<'_>, _: Operand) -> bool {
            false
        }

        fn writes(&self, _: &AnalysisState<'_>, _: &Body<'_>, _: Operand) -> bool {
            false
        }

        fn aliasing_values(&self, _: &AnalysisState<'_>, b: &Body<'_>, (op, i): Operand) -> Vec<AliasingValue> {
            if i == 0 { vec![AliasingValue::equivalent(b[op].results[0])] } else { Vec::new() }
        }

        fn buffer_type<'a>(&self, o: &BufferizationOptions, b: &Body<'a>, v: ValueId, stack: &mut Vec<ValueId>) -> Result<Type<'a>, Error> {
            let op = b.owner_of(v);
            let sb = crate::buffer_type_in(o, b, b[op].operands[0], stack)?;
            let Type::Shaped(sm) = &sb else { return Err(Error("expected a memref".into())) };
            sm.expanded(&b[v].ty.dims().unwrap_or_default(), &b.reassociation(op)).ok_or_else(|| Error("cannot expand".into()))
        }

        fn bufferize(&self, rw: &mut Rewriter<'_, '_>, o: &BufferizationOptions, op: OpId) -> Result<(), Error> {
            let src = rw.body[op].operands[0];
            let buffer = buffer_of(rw, o, src)?;
            let r = rw.body[op].results[0];
            let shape = rw.body[r].ty.dims().unwrap_or_default();
            let Type::Shaped(bt) = rw.body[buffer].ty.clone() else { return Err(Error("expected a memref".into())) };
            let ty = bt.expanded(&shape, &rw.body.reassociation(op)).ok_or_else(|| Error("cannot expand".into()))?;
            let mut data = OpData::build("memref.expand_shape").operands(&[buffer]);
            data.operands.extend(rw.body[op].operands[1..].iter().copied());
            data.properties.clone_from(&rw.body[op].properties);
            replace_new(rw, op, data, ty);
            Ok(())
        }
    }

    impl Bufferizable for Query {
        fn reads(&self, _: &AnalysisState<'_>, _: &Body<'_>, _: Operand) -> bool {
            false
        }

        fn writes(&self, _: &AnalysisState<'_>, _: &Body<'_>, _: Operand) -> bool {
            false
        }

        fn bufferize(&self, rw: &mut Rewriter<'_, '_>, o: &BufferizationOptions, op: OpId) -> Result<(), Error> {
            let src = rw.body[op].operands[0];
            let buffer = buffer_of(rw, o, src)?;
            let name = if rw.body[op].name == "tensor.dim" { "memref.dim" } else { "memref.rank" };
            let mut operands = vec![buffer];
            operands.extend(rw.body[op].operands[1..].iter().copied());
            replace_new(rw, op, OpData::build(name).operands(&operands), Type::Index);
            Ok(())
        }
    }

    impl Bufferizable for Empty {
        fn to_allocation(&self, _: &Body<'_>, _: ValueId) -> bool {
            true
        }

        fn result_writes(&self, _: &AnalysisState<'_>, _: &Body<'_>, _: ValueId) -> bool {
            false
        }

        fn bufferize(&self, rw: &mut Rewriter<'_, '_>, o: &BufferizationOptions, op: OpId) -> Result<(), Error> {
            let r = rw.body[op].results[0];
            if rw.body[r].uses.is_empty() {
                rw.erase_op(op);
                return Ok(());
            }
            let t = AnalysisState::new(o).allocate_tensor_for(rw, r, false)?;
            rw.replace_op(op, &[t]);
            Ok(())
        }
    }

    impl Bufferizable for ExtractSlice {
        fn reads(&self, _: &AnalysisState<'_>, _: &Body<'_>, _: Operand) -> bool {
            false
        }

        fn writes(&self, _: &AnalysisState<'_>, _: &Body<'_>, _: Operand) -> bool {
            false
        }

        fn aliasing_values(&self, _: &AnalysisState<'_>, b: &Body<'_>, (op, i): Operand) -> Vec<AliasingValue> {
            if i == 0 { vec![AliasingValue::unknown(b[op].results[0], true)] } else { Vec::new() }
        }

        fn buffer_type<'a>(&self, o: &BufferizationOptions, b: &Body<'a>, v: ValueId, stack: &mut Vec<ValueId>) -> Result<Type<'a>, Error> {
            let op = b.owner_of(v);
            let sb = crate::buffer_type_in(o, b, b[op].operands[0], stack)?;
            Ok(rank_reduced_subview(b, &sb, &b[v].ty.dims().unwrap_or_default(), &b.slice_lists(op)))
        }

        fn bufferize(&self, rw: &mut Rewriter<'_, '_>, o: &BufferizationOptions, op: OpId) -> Result<(), Error> {
            let lists = rw.body.slice_lists(op);
            let src = rw.body[op].operands[0];
            let buffer = buffer_of(rw, o, src)?;
            let ty = buffer_type(o, rw.body, rw.body[op].results[0])?;
            let s = rw.create(OpData::sliced("memref.subview", &[buffer], &lists), &[ty]);
            let v = rw.body[s].results[0];
            replace_with_buffers(rw, op, &[v]);
            Ok(())
        }
    }

    /// `SubViewOp::inferRankReducedResultType` of `src` to `shape` (statics only, as
    /// `dispatchIndexOpFoldResults`).
    fn rank_reduced_subview<'a>(_: &Body<'a>, src: &Type<'a>, shape: &[i64], lists: &[Vec<Ofr>; 3]) -> Type<'a> {
        let Type::Shaped(s) = src else { return src.clone() };
        let rank = lists[1].len();
        let dropped = if shape.len() >= rank { vec![false; rank] } else { Ofr::dropped(&lists[1], shape) };
        Ofr::subview_type(s, &lists[0], &lists[1], &lists[2], &dropped).unwrap_or_else(|| src.clone())
    }

    impl Bufferizable for Extract {
        fn writes(&self, _: &AnalysisState<'_>, _: &Body<'_>, _: Operand) -> bool {
            false
        }

        fn bufferize(&self, rw: &mut Rewriter<'_, '_>, o: &BufferizationOptions, op: OpId) -> Result<(), Error> {
            let src = rw.body[op].operands[0];
            let buffer = buffer_of(rw, o, src)?;
            let mut operands = vec![buffer];
            operands.extend(rw.body[op].operands[1..].iter().copied());
            let ty = rw.body[rw.body[op].results[0]].ty.clone();
            let l = rw.create(OpData::build("memref.load").operands(&operands).with("nontemporal", mlirformat::Attribute::Bool(false)), &[ty]);
            let v = rw.body[l].results[0];
            replace_with_buffers(rw, op, &[v]);
            Ok(())
        }
    }

    impl Bufferizable for FromElements {
        fn to_allocation(&self, _: &Body<'_>, _: ValueId) -> bool {
            true
        }

        fn bufferize(&self, rw: &mut Rewriter<'_, '_>, o: &BufferizationOptions, op: OpId) -> Result<(), Error> {
            let r = rw.body[op].results[0];
            let shape = rw.body[r].ty.dims().unwrap_or_default();
            let t = AnalysisState::new(o).allocate_tensor_for(rw, r, false)?;
            let ty = buffer_type(o, rw.body, t)?;
            let m = rw.create(OpData::build("bufferization.to_buffer").operands(&[t]), &[ty]);
            let buffer = rw.body[m].results[0];
            let elements = rw.body[op].operands.to_vec();
            if !elements.is_empty() {
                if shape.is_empty() {
                    rw.create(OpData::named("memref.store").operands(&[elements[0], buffer]), &[]);
                } else {
                    let max = *shape.iter().max().expect("a shape");
                    let constants: Vec<ValueId> = (0..max).map(|i| rw.value_of(Ofr::C(i))).collect();
                    let mut indices = vec![constants[0]; shape.len()];
                    let mut it = elements.into_iter();
                    stores(rw, 0, buffer, &shape, &constants, &mut it, &mut indices);
                }
            }
            replace_with_buffers(rw, op, &[buffer]);
            Ok(())
        }
    }

    /// `memref.store value, buffer[indices]`.
    fn store(rw: &mut Rewriter<'_, '_>, value: ValueId, buffer: ValueId, indices: &[ValueId]) {
        let mut operands = vec![value, buffer];
        operands.extend(indices);
        rw.create(OpData::build("memref.store").operands(&operands).with("nontemporal", mlirformat::Attribute::Bool(false)), &[]);
    }

    /// `createStores`: the elements in row-major order.
    fn stores(rw: &mut Rewriter<'_, '_>, dim: usize, buffer: ValueId, shape: &[i64], constants: &[ValueId], it: &mut impl Iterator<Item = ValueId>, indices: &mut Vec<ValueId>) {
        if dim == shape.len() - 1 {
            for i in 0..shape[dim] as usize {
                *indices.last_mut().expect("an index") = constants[i];
                let e = it.next().expect("an element");
                store(rw, e, buffer, indices);
            }
            return;
        }
        for i in 0..shape[dim] as usize {
            indices[dim] = constants[i];
            stores(rw, dim + 1, buffer, shape, constants, it, indices);
        }
    }

    impl Bufferizable for Insert {
        fn writes(&self, _: &AnalysisState<'_>, _: &Body<'_>, (_, i): Operand) -> bool {
            i == 1
        }

        fn aliasing_values(&self, _: &AnalysisState<'_>, b: &Body<'_>, (op, i): Operand) -> Vec<AliasingValue> {
            if i == 1 { vec![AliasingValue::equivalent(b[op].results[0])] } else { Vec::new() }
        }

        fn bufferize(&self, rw: &mut Rewriter<'_, '_>, o: &BufferizationOptions, op: OpId) -> Result<(), Error> {
            let dest = rw.body[op].operands[1];
            let buffer = buffer_of(rw, o, dest)?;
            let scalar = rw.body[op].operands[0];
            let indices = rw.body[op].operands[2..].to_vec();
            store(rw, scalar, buffer, &indices);
            replace_with_buffers(rw, op, &[buffer]);
            Ok(())
        }
    }

    /// `tensor.parallel_insert_slice`: a copy into a subview of its destination, before the
    /// `scf.forall.in_parallel` it sits in; always in place.
    struct ParallelInsertSlice;

    impl Bufferizable for ParallelInsertSlice {
        fn reads(&self, _: &AnalysisState<'_>, _: &Body<'_>, (_, i): Operand) -> bool {
            i == 0
        }

        fn writes(&self, _: &AnalysisState<'_>, _: &Body<'_>, (_, i): Operand) -> bool {
            i == 1
        }

        fn resolve_conflicts(&self, _: &mut Rewriter<'_, '_>, _: &AnalysisState<'_>, _: OpId) -> Result<(), Error> {
            Ok(())
        }

        fn bufferize(&self, rw: &mut Rewriter<'_, '_>, o: &BufferizationOptions, op: OpId) -> Result<(), Error> {
            let parent = rw.body.parent_op(op).ok_or_else(|| Error("expected a parallel combining parent".into()))?;
            rw.set_before(parent);
            let lists = rw.body.slice_lists(op);
            let (src, dest) = (rw.body[op].operands[0], rw.body[op].operands[1]);
            let dst = buffer_of(rw, o, dest)?;
            let sb = buffer_of(rw, o, src)?;
            let shape = rw.body[src].ty.dims().unwrap_or_default();
            let ty = rank_reduced_subview(rw.body, &rw.body[dst].ty.clone(), &shape, &lists);
            let s = rw.create(OpData::sliced("memref.subview", &[dst], &lists), &[ty]);
            let sv = rw.body[s].results[0];
            rw.mem_cpy(sb, sv);
            rw.erase_op(op);
            Ok(())
        }
    }

    /// `tensor.generate`, `tensor.splat`, `tensor.concat`, `tensor.pad`: new allocations;
    /// `tensor.reshape`: a `memref.reshape`.
    struct Generate;
    struct Splat;
    struct Concat;
    struct Pad;
    struct Reshape;

    impl Rewriter<'_, '_> {
        /// A `linalg.map` into `dest` with no inputs and an element-typed block argument.
        fn map_into(&mut self, dest: ValueId) -> (OpId, crate::BlockId) {
            let ty = self.body[dest].ty.clone();
            let elem = match &ty {
                Type::Shaped(t) => (*t.elem).clone(),
                _ => ty.clone(),
            };
            let loc = self.body[dest].loc.clone();
            let m = self.create_with(OpData::build("linalg.map").operands(&[dest]), &[ty], |b, o| {
                let r = b.add_region(o);
                b.add_block(r, &[(elem, loc)]);
            });
            let blk = self.body[self.body[m].regions[0]].blocks[0];
            (m, blk)
        }

        /// `lowerGenerateLikeOpBody`: `body` (one index argument per dimension, ending in
        /// `tensor.yield`) moved into a `linalg.map` into `dest`, on `linalg.index`es.
        fn lower_generate_like(&mut self, dest: ValueId, body: RegionId) -> ValueId {
            let (m, blk) = self.map_into(dest);
            let rank = self.body[dest].ty.dims().unwrap_or_default().len();
            self.set_start(blk);
            let indices: Vec<ValueId> = (0..rank)
                .map(|d| {
                    let i = self.create(OpData::build("linalg.index").with("dim", mlirformat::Attribute::integer(d as i128, Type::int(64))), &[Type::Index]);
                    self.body[i].results[0]
                })
                .collect();
            let from = self.body[body].blocks[0];
            self.merge_blocks(from, blk, &indices);
            let y = self.body.last_op(blk).expect("a terminator");
            let v = self.body[y].operands[0];
            self.replace_with(y, OpData::build("linalg.yield").operands(&[v]), &[]);
            self.body[m].results[0]
        }
    }

    /// `memory space not implemented yet`, when the options give one.
    fn no_memory_space(o: &BufferizationOptions, b: &Body<'_>, op: OpId) -> Result<(), Error> {
        match &b[b[op].results[0]].ty {
            Type::Shaped(t) if o.default_memory_space(t).flatten().is_some() => Err(Error(alloc::format!("'{}' op memory space not implemented yet", b[op].name))),
            _ => Ok(()),
        }
    }

    impl Bufferizable for Generate {
        fn to_allocation(&self, _: &Body<'_>, _: ValueId) -> bool {
            true
        }

        fn bufferize(&self, rw: &mut Rewriter<'_, '_>, o: &BufferizationOptions, op: OpId) -> Result<(), Error> {
            no_memory_space(o, rw.body, op)?;
            let t = AnalysisState::new(o).allocate_tensor_for(rw, rw.body[op].results[0], false)?;
            let r = rw.lower_generate_like(t, rw.body[op].regions[0]);
            rw.replace_op(op, &[r]);
            Ok(())
        }
    }

    impl Bufferizable for Splat {
        fn to_allocation(&self, _: &Body<'_>, _: ValueId) -> bool {
            true
        }

        fn bufferize(&self, rw: &mut Rewriter<'_, '_>, o: &BufferizationOptions, op: OpId) -> Result<(), Error> {
            let t = AnalysisState::new(o).allocate_tensor_for(rw, rw.body[op].results[0], false)?;
            no_memory_space(o, rw.body, op)?;
            let saved = rw.ip;
            let (m, blk) = rw.map_into(t);
            rw.set_start(blk);
            let v = rw.body[op].operands[0];
            rw.create(OpData::build("linalg.yield").operands(&[v]), &[]);
            rw.ip = saved;
            let r = rw.body[m].results[0];
            rw.replace_op(op, &[r]);
            Ok(())
        }
    }

    impl Bufferizable for Concat {
        fn to_allocation(&self, _: &Body<'_>, _: ValueId) -> bool {
            true
        }

        fn writes(&self, _: &AnalysisState<'_>, _: &Body<'_>, _: Operand) -> bool {
            false
        }

        /// Each input copied into its subview of a new buffer, along the concatenated dim.
        fn bufferize(&self, rw: &mut Rewriter<'_, '_>, o: &BufferizationOptions, op: OpId) -> Result<(), Error> {
            let t = AnalysisState::new(o).allocate_tensor_for(rw, rw.body[op].results[0], false)?;
            no_memory_space(o, rw.body, op)?;
            let Type::Shaped(rt) = rw.body[rw.body[op].results[0]].ty.clone() else { return Err(Error("expected a tensor".into())) };
            let mty = BufferizationOptions::memref(&rt, None, None);
            let m = rw.create(OpData::build("bufferization.to_buffer").operands(&[t]), &[mty.clone()]);
            let dst = rw.body[m].results[0];
            let dim = match rw.body[op].get("dim") {
                Some(mlirformat::Attribute::Int { lit, .. }) => lit.trim().parse::<usize>().unwrap_or(0),
                _ => 0,
            };
            let rank = rt.dims().unwrap_or_default().len();
            let mut offsets = vec![Ofr::C(0); rank];
            let strides = vec![Ofr::C(1); rank];
            let mut sizes = rw.mixed_sizes(dst);
            let sum = AffineMap { dims: 0, syms: 2, results: vec![AffineExpr::Sym(0).add(AffineExpr::Sym(1))] };
            let mut at = Ofr::C(0);
            for input in rw.body[op].operands.to_vec() {
                let src = buffer_of(rw, o, input)?;
                offsets[dim] = at;
                let size = rw.mixed_size(src, dim);
                sizes[dim] = size;
                let lists = [offsets.clone(), sizes.clone(), strides.clone()];
                let shape = rw.body[input].ty.dims().unwrap_or_default();
                let ty = rank_reduced_subview(rw.body, &mty, &shape, &lists);
                let s = rw.create(OpData::sliced("memref.subview", &[dst], &lists), &[ty]);
                let sv = rw.body[s].results[0];
                rw.mem_cpy(src, sv);
                at = rw.composed_folded_apply(sum.clone(), &[at, size]);
            }
            replace_with_buffers(rw, op, &[dst]);
            Ok(())
        }
    }

    impl Bufferizable for Pad {
        fn to_allocation(&self, _: &Body<'_>, _: ValueId) -> bool {
            true
        }

        fn writes(&self, _: &AnalysisState<'_>, _: &Body<'_>, _: Operand) -> bool {
            false
        }

        /// The source's memory space, an identity layout.
        fn buffer_type<'a>(&self, o: &BufferizationOptions, b: &Body<'a>, v: ValueId, stack: &mut Vec<ValueId>) -> Result<Type<'a>, Error> {
            let op = b.owner_of(v);
            let src = crate::buffer_type_in(o, b, b[op].operands[0], stack)?;
            let space = match &src {
                Type::Shaped(m) => m.extras.iter().find(|a| !a.is_layout()).cloned(),
                _ => None,
            };
            let Type::Shaped(t) = &b[v].ty else { return Err(Error("expected a tensor".into())) };
            Ok(BufferizationOptions::memref(t, None, space))
        }

        /// A `linalg.map` of the padding body into a new tensor, the source inserted at the low
        /// pads.
        fn bufferize(&self, rw: &mut Rewriter<'_, '_>, o: &BufferizationOptions, op: OpId) -> Result<(), Error> {
            let src = rw.body[op].operands[0];
            let r = rw.body[op].results[0];
            let shape = rw.body[r].ty.dims().unwrap_or_default();
            let [low, high] = rw.body.pad_lists(op);
            let sum = AffineMap { dims: 0, syms: 3, results: vec![AffineExpr::Sym(0).add(AffineExpr::Sym(1)).add(AffineExpr::Sym(2))] };
            for (i, d) in shape.iter().enumerate() {
                if *d != Dim::DYNAMIC {
                    continue;
                }
                let k = rw.value_of(Ofr::C(i as i64));
                let dim = rw.create(OpData::build("tensor.dim").operands(&[src, k]), &[Type::Index]);
                let sd = rw.body[dim].results[0];
                let (l, h) = (rw.value_of(low[i]), rw.value_of(high[i]));
                rw.create(OpData::build("affine.apply").operands(&[sd, l, h]).with("map", mlirformat::Attribute::from(&sum)), &[Type::Index]);
            }
            let t = AnalysisState::new(o).allocate_tensor_for(rw, r, false)?;
            let filled = rw.lower_generate_like(t, rw.body[op].regions[0]);
            // Back before the pad: the body's lowering left the insertion point in the map.
            rw.set_before(op);
            let sizes = rw.mixed_sizes(src);
            let strides = vec![Ofr::C(1); sizes.len()];
            let lists = [low, sizes, strides];
            let ty = rw.body[r].ty.clone();
            rw.replace_with(op, OpData::sliced("tensor.insert_slice", &[src, filled], &lists), &[ty]);
            Ok(())
        }
    }

    impl Bufferizable for Reshape {
        fn reads(&self, _: &AnalysisState<'_>, _: &Body<'_>, (_, i): Operand) -> bool {
            i == 1
        }

        fn writes(&self, _: &AnalysisState<'_>, _: &Body<'_>, _: Operand) -> bool {
            false
        }

        fn aliasing_values(&self, _: &AnalysisState<'_>, b: &Body<'_>, (op, i): Operand) -> Vec<AliasingValue> {
            if i == 0 { vec![AliasingValue::equivalent(b[op].results[0])] } else { Vec::new() }
        }

        /// A static identity layout in the source's memory space.
        fn buffer_type<'a>(&self, o: &BufferizationOptions, b: &Body<'a>, v: ValueId, stack: &mut Vec<ValueId>) -> Result<Type<'a>, Error> {
            let op = b.owner_of(v);
            let src = crate::buffer_type_in(o, b, b[op].operands[0], stack)?;
            let space = match &src {
                Type::Shaped(m) => m.extras.iter().find(|a| !a.is_layout()).cloned(),
                _ => None,
            };
            let Type::Shaped(t) = &b[v].ty else { return Err(Error("expected a tensor".into())) };
            Ok(BufferizationOptions::identity(t, space))
        }

        /// A `memref.reshape`, of a copy when the source's layout is not the identity.
        fn bufferize(&self, rw: &mut Rewriter<'_, '_>, o: &BufferizationOptions, op: OpId) -> Result<(), Error> {
            let (source, shape) = (rw.body[op].operands[0], rw.body[op].operands[1]);
            let mut src = buffer_of(rw, o, source)?;
            let sh = buffer_of(rw, o, shape)?;
            let ty = buffer_type(o, rw.body, rw.body[op].results[0])?;
            if let Type::Shaped(m) = rw.body[src].ty.clone()
                && m.shape.is_some()
                && m.extras.iter().any(|a| a.is_layout())
            {
                let t = AnalysisState::new(o).allocate_tensor_for(rw, source, true)?;
                let space = m.extras.iter().find(|a| !a.is_layout()).cloned();
                let mty = BufferizationOptions::memref(&m, None, space);
                let c = rw.create(OpData::build("bufferization.to_buffer").operands(&[t]), &[mty]);
                src = rw.body[c].results[0];
            }
            let n = rw.create(OpData::build("memref.reshape").operands(&[src, sh]), &[ty]);
            let v = rw.body[n].results[0];
            replace_with_buffers(rw, op, &[v]);
            Ok(())
        }
    }

    impl Bufferizable for InsertSlice {
        /// The source; the destination unless the slice covers it (`insertSliceOpRequiresRead`).
        fn reads(&self, _: &AnalysisState<'_>, b: &Body<'_>, (op, i): Operand) -> bool {
            if i == 0 {
                return true;
            }
            let [offsets, sizes, strides] = b.slice_lists(op);
            let dest = b[b[op].operands[1]].ty.dims().unwrap_or_default();
            let covers = offsets.iter().all(|o| b.ofr_int(*o) == Some(0))
                && sizes.len() == dest.len()
                && sizes.iter().zip(&dest).all(|(s, d)| *d != Dim::DYNAMIC && b.ofr_int(*s) == Some(*d))
                && strides.iter().all(|s| b.ofr_int(*s) == Some(1));
            !covers
        }

        fn writes(&self, _: &AnalysisState<'_>, _: &Body<'_>, (_, i): Operand) -> bool {
            i == 1
        }

        fn aliasing_values(&self, _: &AnalysisState<'_>, b: &Body<'_>, (op, i): Operand) -> Vec<AliasingValue> {
            if i == 1 { vec![AliasingValue::equivalent(b[op].results[0])] } else { Vec::new() }
        }

        fn bufferize(&self, rw: &mut Rewriter<'_, '_>, o: &BufferizationOptions, op: OpId) -> Result<(), Error> {
            let lists = rw.body.slice_lists(op);
            let (src, dest) = (rw.body[op].operands[0], rw.body[op].operands[1]);
            let dst = buffer_of(rw, o, dest)?;
            let shape = rw.body[src].ty.dims().unwrap_or_default();
            let ty = rank_reduced_subview(rw.body, &rw.body[dst].ty.clone(), &shape, &lists);
            let s = rw.create(OpData::sliced("memref.subview", &[dst], &lists), &[ty]);
            let sv = rw.body[s].results[0];
            let sb = buffer_of(rw, o, src)?;
            rw.mem_cpy(sb, sv);
            replace_with_buffers(rw, op, &[dst]);
            Ok(())
        }
    }
}
