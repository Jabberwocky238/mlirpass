use alloc::vec::Vec;

use crate::{Body, EffectInstance, EffectKind, OpId, OpInterfaces};

pub struct BufferizationDialect;

impl OpInterfaces for BufferizationDialect {
    fn namespace(&self) -> &str {
        "bufferization"
    }

    fn effects(&self, b: &Body<'_>, op: OpId) -> Option<Vec<EffectInstance>> {
        if b[op].name != "bufferization.materialize_in_destination" {
            return None;
        }
        let memref = |i: usize| b[op].operands.get(i).copied().filter(|v| b.is_memref(*v));
        let mut out = Vec::new();
        out.extend(memref(0).map(|v| EffectInstance::on(EffectKind::Read, Some(v))));
        out.extend(memref(1).map(|v| EffectInstance::on(EffectKind::Write, Some(v))));
        Some(out)
    }

    #[cfg(feature = "dialect.bufferization")]
    fn bufferizable(&self, name: &str) -> Option<&dyn crate::Bufferizable> {
        Self::bufferizable_op(name)
    }
}

#[cfg(feature = "dialect.bufferization")]
mod bufferizable {
    use alloc::vec::Vec;

    use mlirformat::{Error, Type};

    use super::BufferizationDialect;
    use crate::{buffer_of, buffer_type, replace_with_buffers, AliasingValue, AnalysisState, Body, Bufferizable, BufferizationOptions, MemrefOfr as Ofr, OpData, OpId, Operand, Rewriter, ValueId};

    struct AllocTensor;
    struct ToTensor;
    struct ToBuffer;
    struct Materialize;
    struct DeallocTensor;

    impl BufferizationDialect {
        pub(crate) fn bufferizable_op(name: &str) -> Option<&'static dyn Bufferizable> {
            Some(match name {
                "bufferization.alloc_tensor" => &AllocTensor,
                "bufferization.to_tensor" => &ToTensor,
                "bufferization.to_buffer" => &ToBuffer,
                "bufferization.materialize_in_destination" => &Materialize,
                "bufferization.dealloc_tensor" => &DeallocTensor,
                _ => return None,
            })
        }
    }

    impl Rewriter<'_, '_> {
        pub(crate) fn dynamic_dims(&mut self, v: ValueId) -> Vec<ValueId> {
            let dims = self.body[v].ty.dims().unwrap_or_default();
            let name = if self.body.is_memref(v) { "memref.dim" } else { "tensor.dim" };
            let mut out = Vec::new();
            for (i, d) in dims.iter().enumerate() {
                if *d == mlirformat::Dim::DYNAMIC {
                    let k = self.value_of(Ofr::C(i as i64));
                    let o = self.create(OpData::build(name).operands(&[v, k]), &[Type::Index]);
                    out.push(self.body[o].results[0]);
                }
            }
            out
        }

        pub(crate) fn mem_cpy(&mut self, from: ValueId, to: ValueId) {
            self.create(OpData::build("memref.copy").operands(&[from, to]), &[]);
        }
    }

    impl Bufferizable for AllocTensor {
        fn to_allocation(&self, _: &Body<'_>, _: ValueId) -> bool {
            true
        }

        fn writes(&self, _: &AnalysisState<'_>, _: &Body<'_>, _: Operand) -> bool {
            false
        }

        fn result_writes(&self, _: &AnalysisState<'_>, b: &Body<'_>, v: ValueId) -> bool {
            Self::copy(b, b.owner_of(v)).is_some()
        }

        fn bufferize(&self, rw: &mut Rewriter<'_, '_>, o: &BufferizationOptions, op: OpId) -> Result<(), Error> {
            let r = rw.body[op].results[0];
            if rw.body[r].uses.is_empty() {
                rw.erase_op(op);
                return Ok(());
            }
            let copy = match Self::copy(rw.body, op) {
                Some(c) => Some(buffer_of(rw, o, c)?),
                None => None,
            };
            let ty = buffer_type(o, rw.body, r)?;
            let n = rw.body.segments(op, "operandSegmentSizes").map_or(0, |s| s[0]);
            let mut dynamic = rw.body[op].operands[..n].to_vec();
            if let Some(c) = copy {
                dynamic = rw.dynamic_dims(c);
            }
            let alloc = o.create_alloc(rw, &ty, &dynamic);
            if let Some(c) = copy {
                rw.mem_cpy(c, alloc);
            }
            replace_with_buffers(rw, op, &[alloc]);
            Ok(())
        }

        fn buffer_type<'a>(&self, o: &BufferizationOptions, b: &Body<'a>, v: ValueId, stack: &mut Vec<ValueId>) -> Result<Type<'a>, Error> {
            let op = b.owner_of(v);
            let Type::Shaped(t) = &b[v].ty else { return Err(Error("expected a tensor".into())) };
            let space = if let Some(s) = b[op].get("memory_space") {
                Some(s.clone())
            } else if let Some(c) = Self::copy(b, op) {
                match crate::buffer_type_in(o, b, c, stack)? {
                    Type::Shaped(m) => m.extras.iter().find(|a| !a.is_layout()).cloned(),
                    _ => None,
                }
            } else {
                match o.default_memory_space(t) {
                    Some(s) => s,
                    None => return Err(Error(alloc::format!("'{}' op could not infer memory space", b[op].name))),
                }
            };
            Ok(BufferizationOptions::identity(t, space))
        }
    }

    impl AllocTensor {
        fn copy(b: &Body<'_>, op: OpId) -> Option<ValueId> {
            let segs = b.segments(op, "operandSegmentSizes")?;
            (segs.get(1).copied() == Some(1)).then(|| b[op].operands[segs[0]])
        }
    }

    impl Bufferizable for ToTensor {
        fn bufferize(&self, _: &mut Rewriter<'_, '_>, _: &BufferizationOptions, _: OpId) -> Result<(), Error> {
            Ok(())
        }

        fn writable(&self, _: &AnalysisState<'_>, b: &Body<'_>, v: ValueId) -> bool {
            b[b.owner_of(v)].get("writable").is_some()
        }

        fn buffer_type<'a>(&self, _: &BufferizationOptions, b: &Body<'a>, v: ValueId, _: &mut Vec<ValueId>) -> Result<Type<'a>, Error> {
            Ok(b[b[b.owner_of(v)].operands[0]].ty.clone())
        }
    }

    impl Bufferizable for ToBuffer {
        fn writes(&self, _: &AnalysisState<'_>, b: &Body<'_>, (op, _): Operand) -> bool {
            b[op].get("read_only").is_none()
        }

        fn bufferize(&self, rw: &mut Rewriter<'_, '_>, o: &BufferizationOptions, op: OpId) -> Result<(), Error> {
            let _ = crate::fold_to_buffer_to_tensor(rw, o, op);
            Ok(())
        }
    }

    impl Bufferizable for Materialize {
        fn reads(&self, _: &AnalysisState<'_>, _: &Body<'_>, (_, i): Operand) -> bool {
            i == 0
        }

        fn writes(&self, _: &AnalysisState<'_>, _: &Body<'_>, (_, i): Operand) -> bool {
            i == 1
        }

        fn must_in_place(&self, _: &AnalysisState<'_>, _: &Body<'_>, _: Operand) -> bool {
            true
        }

        fn aliasing_values(&self, _: &AnalysisState<'_>, b: &Body<'_>, (op, i): Operand) -> Vec<AliasingValue> {
            if i == 1 { alloc::vec![AliasingValue::equivalent(b[op].results[0])] } else { Vec::new() }
        }

        fn elementwise(&self, _: &AnalysisState<'_>, _: &Body<'_>, _: &[Operand]) -> bool {
            true
        }

        fn writable(&self, _: &AnalysisState<'_>, b: &Body<'_>, v: ValueId) -> bool {
            let op = b.owner_of(v);
            crate::is_tensor(&b[b[op].operands[1]].ty) || b[op].get("writable").is_some()
        }

        fn bufferize(&self, rw: &mut Rewriter<'_, '_>, o: &BufferizationOptions, op: OpId) -> Result<(), Error> {
            let dest = rw.body[op].operands[1];
            let tensor = crate::is_tensor(&rw.body[dest].ty);
            let buffer = if tensor { buffer_of(rw, o, dest)? } else { dest };
            let src = rw.body[op].operands[0];
            let src = buffer_of(rw, o, src)?;
            rw.mem_cpy(src, buffer);
            replace_with_buffers(rw, op, if tensor { core::slice::from_ref(&buffer) } else { &[] });
            Ok(())
        }
    }

    impl Bufferizable for DeallocTensor {
        fn reads(&self, _: &AnalysisState<'_>, _: &Body<'_>, _: Operand) -> bool {
            false
        }

        fn writes(&self, _: &AnalysisState<'_>, _: &Body<'_>, _: Operand) -> bool {
            false
        }

        fn bufferize(&self, rw: &mut Rewriter<'_, '_>, o: &BufferizationOptions, op: OpId) -> Result<(), Error> {
            let t = rw.body[op].operands[0];
            let buffer = buffer_of(rw, o, t)?;
            rw.create(OpData::build("memref.dealloc").operands(&[buffer]), &[]);
            rw.erase_op(op);
            Ok(())
        }
    }
}
