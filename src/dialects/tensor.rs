//! The `tensor` dialect's op interfaces.

use alloc::vec;
use alloc::vec::Vec;

use mlirformat::Dim;

use crate::{AffineExpr, AffineMap, Body, DialectInliner, InlineAll, MemrefOfr as Ofr, OpId, OpInterfaces, Rewriter};

/// The `tensor` dialect.
pub struct TensorDialect;

impl OpInterfaces for TensorDialect {
    fn namespace(&self) -> &str {
        "tensor"
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
    use crate::{buffer_of, buffer_type, replace_with_buffers, AliasingValue, AnalysisState, Body, Bufferizable, BufferizationOptions, MemrefLayout, MemrefOfr as Ofr, MemrefReshape, OpData, OpId, Operand, Rewriter, ValueId};

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
                    store(rw, elements[0], buffer, &[]);
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
