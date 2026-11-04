//! The `vector` dialect's op interfaces.

use alloc::vec::Vec;

use crate::{Body, DialectInliner, EffectInstance, EffectKind, InlineAll, OpId, OpInterfaces};

/// The `vector` dialect.
pub struct VectorDialect;

impl OpInterfaces for VectorDialect {
    fn namespace(&self) -> &str {
        "vector"
    }

    #[cfg(feature = "dialect.bufferization")]
    fn bufferizable(&self, name: &str) -> Option<&dyn crate::Bufferizable> {
        Self::bufferizable_op(name)
    }

    /// Every op inlines (`VectorInlinerInterface`).
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
    use crate::{buffer_of, replace_with_buffers, AliasingValue, AnalysisState, Body, Bufferizable, BufferizationOptions, OpData, OpId, Operand, Rewriter, ValueId};

    /// `vector.transfer_read`, `vector.transfer_write`.
    struct TransferRead;
    struct TransferWrite;

    impl VectorDialect {
        pub(crate) fn bufferizable_op(name: &str) -> Option<&'static dyn Bufferizable> {
            Some(match name {
                "vector.transfer_read" => &TransferRead,
                "vector.transfer_write" => &TransferWrite,
                _ => return None,
            })
        }
    }

    /// `op` again with operand `at` replaced by `buffer` and results of `types`.
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
        /// Unless the write covers the whole static tensor from index 0, unmasked.
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
}
