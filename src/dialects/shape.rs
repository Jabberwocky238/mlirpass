//! The `shape` dialect's op interfaces.

use mlirformat::Attribute;

use crate::{Body, OpId, OpInterfaces};

/// The `shape` dialect.
pub struct ShapeDialect;

impl OpInterfaces for ShapeDialect {
    fn namespace(&self) -> &str {
        "shape"
    }

    #[cfg(feature = "dialect.bufferization")]
    fn bufferizable(&self, name: &str) -> Option<&dyn crate::Bufferizable> {
        match name {
            "shape.assuming" => Some(&bufferizable::Assuming),
            "shape.assuming_yield" => Some(&bufferizable::AssumingYield),
            _ => None,
        }
    }

    fn constant_value<'a>(&self, b: &Body<'a>, op: OpId) -> Option<Attribute<'a>> {
        let d = &b[op];
        match &*d.name {
            "shape.const_shape" => d.get("shape").cloned(),
            "shape.const_witness" => d.get("passing").cloned(),
            _ => d.get("value").cloned(),
        }
    }
}

#[cfg(feature = "dialect.bufferization")]
mod bufferizable {
    use alloc::vec;
    use alloc::vec::Vec;

    use mlirformat::Error;

    use crate::{buffer_of, is_tensor, AliasingOperand, AliasingValue, AnalysisState, Body, BufferRelation, Bufferizable, BufferizationOptions, Def, OpData, OpId, Operand, Rewriter, ValueId};

    /// `shape.assuming`: a new op on the (already bufferized) yield's types, its tensor
    /// results through `to_tensor`.
    pub(super) struct Assuming;
    /// `shape.assuming_yield`: yields buffers, always in place.
    pub(super) struct AssumingYield;

    fn yield_of(b: &Body<'_>, op: OpId) -> OpId {
        *b[b[b[op].regions[0]].blocks[0]].ops.last().expect("a terminator")
    }

    impl Bufferizable for Assuming {
        fn aliasing_operands(&self, _: &AnalysisState<'_>, b: &Body<'_>, v: ValueId) -> Vec<AliasingOperand> {
            let Def::Result(op, k) = b[v].def else { return Vec::new() };
            vec![AliasingOperand { operand: (yield_of(b, op), k as usize), relation: BufferRelation::Equivalent, definite: true }]
        }

        fn bufferize(&self, rw: &mut Rewriter<'_, '_>, _: &BufferizationOptions, op: OpId) -> Result<(), Error> {
            let y = yield_of(rw.body, op);
            let types: Vec<_> = rw.body[y].operands.iter().map(|v| rw.body[*v].ty.clone()).collect();
            let old = rw.body[op].clone();
            let mut data = OpData::named(old.name.clone()).operands(&old.operands);
            data.properties.clone_from(&old.properties);
            data.attributes.clone_from(&old.attributes);
            let n = rw.create_with(data, &types, |b, o| {
                b.add_region(o);
            });
            let (from, to) = (rw.body[op].regions[0], rw.body[n].regions[0]);
            rw.inline_region_before(from, to, None);
            rw.set_after(n);
            let mut results = Vec::new();
            for (k, r) in old.results.iter().enumerate() {
                let nr = rw.body[n].results[k];
                if is_tensor(&rw.body[*r].ty) {
                    let ty = rw.body[*r].ty.clone();
                    let t = rw.create(OpData::build("bufferization.to_tensor").operands(&[nr]), &[ty]);
                    results.push(rw.body[t].results[0]);
                } else {
                    results.push(nr);
                }
            }
            rw.replace_op(op, &results);
            Ok(())
        }
    }

    impl Bufferizable for AssumingYield {
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
            let mut new = Vec::new();
            for v in rw.body[op].operands.to_vec() {
                new.push(if is_tensor(&rw.body[v].ty) { buffer_of(rw, o, v)? } else { v });
            }
            rw.replace_with(op, OpData::named(rw.body[op].name.clone()).operands(&new), &[]);
            Ok(())
        }
    }
}
