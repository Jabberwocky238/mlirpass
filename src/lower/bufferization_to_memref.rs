//! `bufferization` ⇒ `memref`, as `BufferizationToMemRef.cpp` and the one-memref case of
//! `LowerDeallocations.cpp`.

use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{Attribute, Dim, Shaped, ShapedKind, Type, arith, memref};
use mlirpass_macros::{pass, patterns};

use crate::{Body, ConversionConfig, ConversionPatterns, ConversionRewriter as Cr, ConversionTarget, Converter, Listener, Mode, OpData, OpId, Rewriter, ValueId};
use mlirformat::Error;

/// The bufferization ⇒ memref patterns.
pub struct BufferizationToMemref;

#[patterns]
impl BufferizationToMemref {
    /// `CloneOpConversion`: a new buffer (`alloc`, or `alloca` + loop + `reshape` when
    /// unranked) and a `memref.copy` into it.
    #[lowering("bufferization.clone")]
    fn clone(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let input = cr.rw.body[op].operands[0];
        let ty = cr.rw.body[cr.rw.body[op].results[0]].ty.clone();
        let Type::Shaped(s) = &ty else { return false };
        let alloc = match &s.shape {
            None => Self::unranked(&mut cr.rw, input, s),
            Some(shape) => {
                let alloc_ty = Type::Shaped(Shaped { extras: s.extras.iter().filter(|a| !a.is_layout()).cloned().collect(), ..s.clone() });
                if !crate::canon::memref_cast_compatible(&alloc_ty, &ty) {
                    return false;
                }
                let mut sizes = Vec::new();
                for (i, _) in shape.iter().enumerate().filter(|(_, d)| matches!(d, Dim::Dynamic)) {
                    let k = Self::cidx(&mut cr.rw, i as i64);
                    let dim = OpData::build("memref.dim").operands(&[input, k]);
                    sizes.extend(cr.rw.create_or_fold(dim, &[Type::Index]));
                }
                let alloc = Self::result(&mut cr.rw, &memref::AllocOp::new(Self::values(&sizes), Vec::new(), None, Type::Index, Type::Index, alloc_ty.clone()));
                if alloc_ty == ty { alloc } else { Self::result(&mut cr.rw, &memref::CastOp::new(alloc.into(), alloc_ty, ty.clone())) }
            }
        };
        let in_ty = cr.rw.body[input].ty.clone();
        cr.rw.emit(&memref::CopyOp::new(input.into(), alloc.into(), in_ty, ty));
        cr.replace_values(op, &[alloc]);
        true
    }

    /// `DeallocOpConversion`, one memref and nothing retained: `scf.if %cond { memref.dealloc }`.
    #[lowering("bufferization.dealloc")]
    fn dealloc(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let b = &*cr.rw.body;
        let (&[m], &[cond], 0) = (Self::segment(b, op, 0), Self::segment(b, op, 1), Self::segment(b, op, 2).len()) else { return false };
        let ty = b[m].ty.clone();
        cr.rw.build_if_then(cond, &mut |rw| {
            rw.emit(&memref::DeallocOp::new(m.into(), ty.clone()));
        });
        cr.erase(op);
        true
    }
}

impl BufferizationToMemref {
    fn values<'a>(vs: &[ValueId]) -> Vec<mlirformat::Value<'a>> {
        vs.iter().map(|v| (*v).into()).collect()
    }

    fn result<'a, L: Listener<'a> + ?Sized>(rw: &mut Rewriter<'_, 'a, L>, op: &impl crate::TypedOp) -> ValueId {
        let o = rw.emit(op);
        rw.body[o].results[0]
    }

    fn cidx<'a, L: Listener<'a> + ?Sized>(rw: &mut Rewriter<'_, 'a, L>, v: i64) -> ValueId {
        Self::result(rw, &arith::Constant::new(Attribute::index(v), Type::Index))
    }

    /// Operand group `k` of `op` (`operandSegmentSizes`).
    fn segment<'b>(b: &'b Body<'_>, op: OpId, k: usize) -> &'b [ValueId] {
        let sizes: Vec<usize> = match b[op].get("operandSegmentSizes") {
            Some(mlirformat::Attribute::DenseArray { values, .. }) => values.iter().filter_map(|v| v.parse().ok()).collect(),
            _ => return &[],
        };
        let start: usize = sizes.iter().take(k).sum();
        sizes.get(k).map_or(&[], |n| &b[op].operands[start..start + n])
    }

    /// The unranked clone: rank, shape buffer and total size from a loop over the dims, a 1-D
    /// buffer of that size reshaped to the input's shape.
    fn unranked<'a, L: Listener<'a> + ?Sized>(rw: &mut Rewriter<'_, 'a, L>, input: ValueId, s: &Shaped<'a>) -> ValueId {
        let in_ty = rw.body[input].ty.clone();
        let (zero, one) = (Self::cidx(rw, 0), Self::cidx(rw, 1));
        let rank = Self::result(rw, &memref::RankOp::new(input.into(), in_ty.clone(), Type::Index));
        let shape_ty = Type::Shaped(Shaped { kind: ShapedKind::MemRef, shape: Some(vec![Dim::Dynamic]), elem: Type::Index.into(), extras: Vec::new() });
        let shape = Self::result(rw, &memref::AllocaOp::new(vec![rank.into()], Vec::new(), None, Type::Index, Type::Index, shape_ty.clone()));
        let lp = rw.build_for(zero, rank, one, &[one], &mut |rw, i, acc| {
            let dim = Self::result(rw, &memref::DimOp::new(input.into(), i.into(), in_ty.clone(), Type::Index, Type::Index));
            rw.emit(&memref::StoreOp::new(dim.into(), shape.into(), vec![i.into()], None, None, Type::Index, shape_ty.clone(), Type::Index));
            vec![Self::result(rw, &arith::MulI::new(acc[0].into(), dim.into(), mlirformat::Attribute::dialect("arith.overflow", "<none>"), Type::Index))]
        });
        let size = rw.body[lp].results[0];
        let flat = Type::Shaped(Shaped { kind: ShapedKind::MemRef, shape: Some(vec![Dim::Dynamic]), elem: s.elem.clone(), extras: Vec::new() });
        let alloc = Self::result(rw, &memref::AllocOp::new(vec![size.into()], Vec::new(), None, Type::Index, Type::Index, flat.clone()));
        Self::result(rw, &memref::ReshapeOp::new(alloc.into(), shape.into(), flat, shape_ty, Type::Shaped(s.clone())))
    }
}

/// `convert-bufferization-to-memref`.
#[pass("convert-bufferization-to-memref")]
pub fn convert_bufferization_to_memref<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let mut patterns = ConversionPatterns::default();
    BufferizationToMemref::populate(&mut patterns);
    let mut target = ConversionTarget::default();
    target.legal_dialect("memref").legal_dialect("arith").legal_dialect("scf").legal_dialect("func").illegal_dialect("bufferization");
    Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
}
