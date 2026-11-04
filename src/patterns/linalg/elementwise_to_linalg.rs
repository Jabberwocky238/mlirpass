//! `convert-elementwise-to-linalg`, as `ElementwiseToLinalg.cpp`: an elementwise-mappable op on
//! ranked tensors becomes a `linalg.generic` running the op on the elements.

use alloc::vec::Vec;

use mlirformat::{AffineMap, ShapedKind, Type};

use crate::{patterns, Body, ConversionRewriter as Cr, OpData, OpId, Trait, ValueId};

/// The pattern of `populateElementwiseToLinalgConversionPatterns`.
pub struct ElementwiseToLinalg;

#[patterns]
impl ElementwiseToLinalg {
    /// `ConvertAnyElementwiseMappableOpOnRankedTensors`: a `RewritePattern` on any op upstream,
    /// so it reads the op's own operands, not the converted ones.
    #[convert(_)]
    fn any(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        if !Self::applies(cr.rw.body, op) {
            return false;
        }
        let d = cr.rw.body[op].clone();
        let rts: Vec<Type<'_>> = d.results.iter().map(|r| cr.rw.body[*r].ty.clone()).collect();
        let rank = rts[0].dims().unwrap_or_default().len() as u32;
        let id = AffineMap::identity(rank);
        let scalar = AffineMap { dims: rank, syms: 0, results: Vec::new() };
        let mut maps: Vec<AffineMap> = d.operands.iter().map(|v| if Self::scalar_like(&cr.rw.body[*v].ty) { scalar.clone() } else { id.clone() }).collect();
        maps.extend(core::iter::repeat_n(id, rts.len()));
        // `getOrCreateOperandsMatchingResultTypes`
        let mut outs = Vec::new();
        for t in &rts {
            if let Some(v) = d.operands.iter().find(|v| cr.rw.body[**v].ty == *t) {
                outs.push(*v);
                continue;
            }
            let sizes = cr.mixed_sizes(d.operands[0]);
            outs.push(cr.empty_mixed(&sizes, t.element_type().clone()));
        }
        let n = d.operands.len();
        let ets: Vec<Type<'_>> = rts.iter().map(|t| t.element_type().clone()).collect();
        let g = cr.generic(&rts, &d.operands, &outs, &maps, &alloc::vec![true; rank as usize], &mut |cr, a| {
            let mut data = OpData::named(d.name.clone()).operands(&a[..n]);
            data.properties.clone_from(&d.properties);
            data.attributes.clone_from(&d.attributes);
            let o = cr.rw.create(data, &ets);
            cr.rw.body[o].results.to_vec()
        });
        let results = cr.rw.body[g].results.to_vec();
        cr.replace_values(op, &results);
        true
    }
}

impl ElementwiseToLinalg {
    fn scalar_like(t: &Type<'_>) -> bool {
        matches!(t, Type::Integer { .. } | Type::Float(_) | Type::Index | Type::Complex(_))
    }

    fn ranked_tensor(t: &Type<'_>) -> bool {
        matches!(t, Type::Shaped(s) if s.kind == ShapedKind::Tensor && s.shape.is_some())
    }

    /// `isElementwiseMappableOpOnRankedTensors`.
    pub fn applies(b: &Body<'_>, op: OpId) -> bool {
        if ![Trait::Elementwise, Trait::Scalarizable, Trait::Vectorizable, Trait::Tensorizable].iter().all(|t| b.has(op, *t)) {
            return false;
        }
        let tys = b[op].operands.iter().map(|v| &b[*v].ty);
        tys.clone().any(Self::ranked_tensor) && tys.into_iter().all(|t| Self::ranked_tensor(t) || Self::scalar_like(t))
    }
}

