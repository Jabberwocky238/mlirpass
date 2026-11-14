use alloc::vec::Vec;

use crate::{Body, DialectInliner, EffectInstance, EffectKind, InlineAll, OpId, OpInterfaces};

pub struct VectorDialect;

impl OpInterfaces for VectorDialect {
    fn namespace(&self) -> &str {
        "vector"
    }

    fn asm_result_names(&self, b: &crate::Body<'_>, op: crate::OpId) -> alloc::vec::Vec<(crate::ValueId, alloc::borrow::Cow<'static, str>)> {
        match &*b[op].name {
            "vector.vscale" => b.result_named(op, "vscale"),
            _ => b.ods_result_names(op),
        }
    }

    #[cfg(feature = "dialect.bufferization")]
    fn bufferizable(&self, name: &str) -> Option<&dyn crate::Bufferizable> {
        Self::bufferizable_op(name)
    }

    fn inliner(&self) -> Option<&dyn DialectInliner> {
        Some(&InlineAll { calls: false, regions: false })
    }

    fn effects(&self, b: &Body<'_>, op: OpId) -> Option<Vec<EffectInstance>> {
        let (kind, i) = match &*b[op].name {
            "vector.transfer_read" => (EffectKind::Read, 0),
            "vector.transfer_write" => (EffectKind::Write, 1),
            _ => return None,
        };
        Some(b[op].operands.get(i).copied().filter(|v| b.is_memref(*v)).map(|v| EffectInstance::on(kind, Some(v))).into_iter().collect())
    }

    fn speculatability(&self, b: &Body<'_>, op: OpId) -> Option<bool> {
        match &*b[op].name {
            "vector.transfer_read" | "vector.transfer_write" => b[op].operands.iter().all(|v| !b.is_memref(*v)).then_some(false),
            _ => None,
        }
    }
}

#[cfg(feature = "dialect.bufferization")]
mod bufferizable {
    use alloc::vec;
    use alloc::vec::Vec;

    use mlirformat::{Dim, Error, Type};

    use super::VectorDialect;
    use crate::{buffer_of, is_tensor, replace_with_buffers, AliasingOperand, AliasingValue, AnalysisState, Body, BufferRelation, Bufferizable, BufferizationOptions, Def, OpData, OpId, Operand, Rewriter, ValueId};

    struct TransferRead;
    struct TransferWrite;
    struct Scatter;
    struct Gather;
    struct Mask;
    struct Yield;

    impl VectorDialect {
        pub(crate) fn bufferizable_op(name: &str) -> Option<&'static dyn Bufferizable> {
            Some(match name {
                "vector.transfer_read" => &TransferRead,
                "vector.transfer_write" => &TransferWrite,
                "vector.scatter" => &Scatter,
                "vector.gather" => &Gather,
                "vector.mask" => &Mask,
                "vector.yield" => &Yield,
                _ => return None,
            })
        }
    }

    fn rebuilt<'a>(rw: &mut Rewriter<'_, 'a>, op: OpId, at: usize, buffer: ValueId, types: &[Type<'a>]) -> OpId {
        let old = rw.body[op].clone();
        let mut operands = old.operands.to_vec();
        operands[at] = buffer;
        let mut data = OpData::named(old.name.clone()).operands(&operands);
        data.properties.clone_from(&old.properties);
        data.attributes.clone_from(&old.attributes);
        rw.create(data, types)
    }

    impl Bufferizable for TransferRead {
        fn writes(&self, _: &AnalysisState<'_>, _: &Body<'_>, _: Operand) -> bool {
            false
        }

        fn bufferize(&self, rw: &mut Rewriter<'_, '_>, o: &BufferizationOptions, op: OpId) -> Result<(), Error> {
            let base = rw.body[op].operands[0];
            let buffer = buffer_of(rw, o, base)?;
            let ty = rw.body[rw.body[op].results[0]].ty.clone();
            let n = rebuilt(rw, op, 0, buffer, &[ty]);
            let v = rw.body[n].results[0];
            replace_with_buffers(rw, op, &[v]);
            Ok(())
        }
    }

    impl Bufferizable for TransferWrite {
        fn reads(&self, _: &AnalysisState<'_>, b: &Body<'_>, (op, _): Operand) -> bool {
            let base = b[op].operands[1];
            let shape = b[base].ty.dims().unwrap_or_default();
            if shape.contains(&Dim::DYNAMIC) || b[base].ty.dims().is_none() {
                return true;
            }
            let segs = b.segments(op, "operandSegmentSizes").unwrap_or_default();
            let n = segs.get(2).copied().unwrap_or(0);
            if b[op].operands[2..2 + n].iter().any(|v| b.const_index(*v) != Some(0)) {
                return true;
            }
            if segs.get(3).copied().unwrap_or(0) > 0 {
                return true;
            }
            let vshape = b[b[op].operands[0]].ty.dims().unwrap_or_default();
            shape.iter().zip(&vshape).any(|(d0, d1)| d0 > d1)
        }

        fn writes(&self, _: &AnalysisState<'_>, _: &Body<'_>, (_, i): Operand) -> bool {
            i == 1
        }

        fn aliasing_values(&self, _: &AnalysisState<'_>, b: &Body<'_>, (op, i): Operand) -> Vec<AliasingValue> {
            if i == 1 { vec![AliasingValue::equivalent(b[op].results[0])] } else { Vec::new() }
        }

        fn bufferize(&self, rw: &mut Rewriter<'_, '_>, o: &BufferizationOptions, op: OpId) -> Result<(), Error> {
            let base = rw.body[op].operands[1];
            let buffer = buffer_of(rw, o, base)?;
            rebuilt(rw, op, 1, buffer, &[]);
            replace_with_buffers(rw, op, &[buffer]);
            Ok(())
        }
    }

    impl Bufferizable for Scatter {
        fn aliasing_values(&self, _: &AnalysisState<'_>, b: &Body<'_>, (op, i): Operand) -> Vec<AliasingValue> {
            if i == 0 { vec![AliasingValue::equivalent(b[op].results[0])] } else { Vec::new() }
        }

        fn bufferize(&self, rw: &mut Rewriter<'_, '_>, o: &BufferizationOptions, op: OpId) -> Result<(), Error> {
            let buffer = buffer_of(rw, o, rw.body[op].operands[0])?;
            rebuilt(rw, op, 0, buffer, &[]);
            replace_with_buffers(rw, op, &[buffer]);
            Ok(())
        }
    }

    impl Bufferizable for Gather {
        fn writes(&self, _: &AnalysisState<'_>, _: &Body<'_>, _: Operand) -> bool {
            false
        }

        fn bufferize(&self, rw: &mut Rewriter<'_, '_>, o: &BufferizationOptions, op: OpId) -> Result<(), Error> {
            let buffer = buffer_of(rw, o, rw.body[op].operands[0])?;
            let ty = rw.body[rw.body[op].results[0]].ty.clone();
            let n = rebuilt(rw, op, 0, buffer, &[ty]);
            let v = rw.body[n].results[0];
            replace_with_buffers(rw, op, &[v]);
            Ok(())
        }
    }

    impl Mask {
        fn yield_of(b: &Body<'_>, op: OpId) -> OpId {
            b.last_op(b[b[op].regions[0]].blocks[0]).expect("a terminator")
        }

        fn masked(b: &Body<'_>, op: OpId) -> Option<OpId> {
            let ops = &b.block_ops(b[b[op].regions[0]].blocks[0]);
            (ops.len() > 1).then(|| ops[0])
        }
    }

    impl Bufferizable for Mask {
        fn aliasing_operands(&self, _: &AnalysisState<'_>, b: &Body<'_>, v: ValueId) -> Vec<AliasingOperand> {
            let Def::Result(op, k) = b[v].def else { return Vec::new() };
            vec![AliasingOperand { operand: (Self::yield_of(b, op), k as usize), relation: BufferRelation::Equivalent, definite: true }]
        }

        fn resolve_conflicts(&self, rw: &mut Rewriter<'_, '_>, s: &AnalysisState<'_>, op: OpId) -> Result<(), Error> {
            s.resolve_tensor_conflicts(rw, op)?;
            let blk = rw.body[rw.body[op].regions[0]].blocks[0];
            if rw.body.block_ops(blk).iter().any(|o| rw.body[*o].name == "bufferization.alloc_tensor") {
                return Err(Error(alloc::format!("'{}' op body must bufferize in-place", rw.body[op].name)));
            }
            Ok(())
        }

        fn bufferize(&self, rw: &mut Rewriter<'_, '_>, o: &BufferizationOptions, op: OpId) -> Result<(), Error> {
            let Some(masked) = Self::masked(rw.body, op).filter(|m| o.bufferizable(rw.body, *m).is_some()) else { return Ok(()) };
            let y = Self::yield_of(rw.body, op);
            let mut returns: Vec<Option<ValueId>> = vec![None; rw.body[op].results.len()];
            let mut yielded = Vec::new();
            for (k, v) in rw.body[y].operands.to_vec().into_iter().enumerate() {
                if matches!(rw.body[v].def, Def::Result(d, _) if d == masked) {
                    yielded.push(v);
                } else {
                    returns[k] = Some(v);
                }
            }
            rw.modify(y, |b| b.set_operands(y, yielded.clone()));
            let types: Vec<_> = yielded.iter().map(|v| rw.body[*v].ty.clone()).collect();
            let old = rw.body[op].clone();
            let mut data = OpData::named(old.name.clone()).operands(&old.operands);
            data.properties.clone_from(&old.properties);
            data.attributes.clone_from(&old.attributes);
            let n = rw.create_with(data, &types, |b, o| {
                b.add_region(o);
            });
            let (from, to) = (rw.body[op].regions[0], rw.body[n].regions[0]);
            rw.inline_region_before(from, to, None);
            let mut fresh = rw.body[n].results.to_vec().into_iter();
            let values: Vec<ValueId> = returns.into_iter().map(|r| r.unwrap_or_else(|| fresh.next().expect("a result"))).collect();
            replace_with_buffers(rw, op, &values);
            Ok(())
        }
    }

    impl Bufferizable for Yield {
        fn writes(&self, _: &AnalysisState<'_>, _: &Body<'_>, _: Operand) -> bool {
            false
        }

        fn aliasing_values(&self, _: &AnalysisState<'_>, b: &Body<'_>, (op, i): Operand) -> Vec<AliasingValue> {
            b.parent_op(op).map_or_else(Vec::new, |p| vec![AliasingValue::equivalent(b[p].results[i])])
        }

        fn must_in_place(&self, _: &AnalysisState<'_>, _: &Body<'_>, _: Operand) -> bool {
            true
        }

        fn bufferize(&self, rw: &mut Rewriter<'_, '_>, o: &BufferizationOptions, op: OpId) -> Result<(), Error> {
            let Some(p) = rw.body.parent_op(op).filter(|p| rw.body[*p].name == "vector.mask") else { return Err(Error("unsupported vector::YieldOp parent".into())) };
            if Mask::masked(rw.body, p).filter(|m| o.bufferizable(rw.body, *m).is_some()).is_none() {
                return Ok(());
            }
            let mut new = Vec::new();
            for v in rw.body[op].operands.to_vec() {
                new.push(if is_tensor(&rw.body[v].ty) { buffer_of(rw, o, v)? } else { v });
            }
            rw.replace_with(op, OpData::named(rw.body[op].name.clone()).operands(&new), &[]);
            Ok(())
        }
    }
}
