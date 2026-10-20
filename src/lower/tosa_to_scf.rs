//! `tosa` ⇒ `scf`, as `TosaToSCF.cpp`: `tosa.cond_if` ⇒ `scf.if`, `tosa.while_loop` ⇒
//! `scf.while`, `tosa.scatter` ⇒ a loop nest of slices.

use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{Attribute, Dim, Error, Shaped, Type, arith, scf, tensor};
use mlirpass_macros::{pass, patterns};

use crate::{Action, Body, ConversionConfig, ConversionPatterns, ConversionRewriter as Cr, ConversionTarget, Converter, Listener, Mode, OpData, OpId, RegionId, Rewriter, TypedOp, ValueId};

/// The tosa ⇒ scf patterns.
pub struct TosaToScf;

#[patterns]
impl TosaToScf {
    /// `IfOpConverter`: the condition extracted, both graphs moved into an `scf.if`.
    #[lowering("tosa.cond_if")]
    fn cond_if(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let (cond, inputs) = cr.rw.body[op].operands.split_first().map(|(c, i)| (*c, i.to_vec())).expect("tosa.cond_if has a condition");
        let c = Self::extract(&mut cr.rw, cond, &[]);
        let types = cr.rw.body.types(&cr.rw.body[op].results.clone());
        let new = cr.rw.body.create(OpData::build("scf.if").operands(&[c]), &types);
        let regions = cr.rw.body[op].regions.clone();
        for src in regions {
            let dst = cr.rw.body.add_region(new);
            cr.inline_region(src, dst, None);
            let head = cr.rw.body[dst].blocks[0];
            for (arg, v) in cr.rw.body[head].args.clone().into_iter().zip(&inputs) {
                cr.replace_value(arg, vec![*v]);
            }
            cr.rw.body[head].args.clear();
            Self::retire_yield(cr, dst, None);
        }
        cr.rw.insert(new);
        let results = cr.rw.body[new].results.clone();
        cr.replace_values(op, &results);
        true
    }

    /// `WhileOpConverter`: the graphs moved into an `scf.while`; the condition graph ends in
    /// `scf.condition` of its extracted boolean, the body in `scf.yield`.
    #[lowering("tosa.while_loop")]
    fn while_loop(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let inits = cr.rw.body[op].operands.clone();
        let types = cr.rw.body.types(&cr.rw.body[op].results.clone());
        let new = cr.rw.body.create(OpData::build("scf.while").operands(&inits), &types);
        let regions = cr.rw.body[op].regions.clone();
        for (k, src) in regions.into_iter().enumerate() {
            let dst = cr.rw.body.add_region(new);
            cr.inline_region(src, dst, None);
            Self::retire_yield(cr, dst, (k == 0).then_some(()));
        }
        cr.rw.insert(new);
        let results = cr.rw.body[new].results.clone();
        cr.replace_values(op, &results);
        true
    }

    /// `ScatterOpConverter`: over N and W, the input's `1 x 1 x C` slice inserted at the row
    /// `indices[n, w]` names.
    #[lowering("tosa.scatter")]
    fn scatter(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let &[values_in, indices, input] = &cr.rw.body[op].operands[..] else { return false };
        let rw = &mut cr.rw;
        let [n, w, c] = [0, 1, 2].map(|d| Self::tensor_dim(rw, input, d));
        let (zero, one) = (Self::cidx(rw, 0), Self::cidx(rw, 1));
        let in_ty = rw.body[input].ty.clone();
        let dyn3 = Attribute::dense_i64(&[Dim::DYNAMIC; 3]);
        let lp = rw.build_for(zero, n, one, &[values_in], &mut |rw, i, acc| {
            let inner = rw.build_for(zero, w, one, acc, &mut |rw, j, acc| {
                let index = Self::extract(rw, indices, &[i, j]);
                let cast = Self::result(rw, &arith::IndexCast::new(index.into(), Type::int(32), Type::Index));
                let (sizes, strides) = (Self::values(&[one, one, c]), Self::values(&[one, one, one]));
                let Type::Shaped(s) = &in_ty else { unreachable!("tosa.scatter takes tensors") };
                let slice_ty = Type::Shaped(Shaped { shape: Some(vec![Dim::Dynamic; 3]), ..s.clone() });
                let slice = Self::result(rw, &tensor::ExtractSliceOp::new(input.into(), Self::values(&[i, j, zero]), sizes.clone(), strides.clone(), dyn3.clone(), dyn3.clone(), dyn3.clone(), in_ty.clone(), Type::Index, Type::Index, Type::Index, slice_ty.clone()));
                let acc_ty = rw.body[acc[0]].ty.clone();
                vec![Self::result(rw, &tensor::InsertSliceOp::new(slice.into(), acc[0].into(), Self::values(&[i, cast, zero]), sizes, strides, dyn3.clone(), dyn3.clone(), dyn3.clone(), slice_ty, Type::Index, Type::Index, Type::Index, acc_ty))]
            });
            rw.body[inner].results.clone()
        });
        let results = cr.rw.body[lp].results.clone();
        cr.replace_values(op, &results);
        true
    }
}

impl TosaToScf {
    fn values<'a>(vs: &[ValueId]) -> Vec<mlirformat::Value<'a>> {
        vs.iter().map(|v| (*v).into()).collect()
    }

    fn result<'a, L: Listener<'a> + ?Sized>(rw: &mut Rewriter<'_, 'a, L>, op: &impl TypedOp) -> ValueId {
        let o = rw.emit(op);
        rw.body[o].results[0]
    }

    fn cidx<'a, L: Listener<'a> + ?Sized>(rw: &mut Rewriter<'_, 'a, L>, v: i64) -> ValueId {
        Self::result(rw, &arith::Constant::new(Attribute::index(v), Type::Index))
    }

    /// `createOrFold<tensor::DimOp>`: the index constant stays, the dim may fold away.
    fn tensor_dim<'a, L: Listener<'a> + ?Sized>(rw: &mut Rewriter<'_, 'a, L>, t: ValueId, d: i64) -> ValueId {
        let k = Self::cidx(rw, d);
        rw.create_or_fold(OpData::build("tensor.dim").operands(&[t, k]), &[Type::Index])[0]
    }

    /// `tensor.extract %t[indices]`.
    fn extract<'a, L: Listener<'a> + ?Sized>(rw: &mut Rewriter<'_, 'a, L>, t: ValueId, indices: &[ValueId]) -> ValueId {
        let ty = rw.body[t].ty.clone();
        let Type::Shaped(s) = &ty else { unreachable!("tensor.extract of a tensor") };
        let elem = (*s.elem).clone();
        Self::result(rw, &tensor::ExtractOp::new(t.into(), Self::values(indices), ty, Type::Index, elem))
    }

    /// The `tosa.yield` ending `region` ⇒ `scf.yield` of its operands, or (`cond`) `scf.condition`
    /// of its extracted first operand and the block's arguments.
    fn retire_yield(cr: &mut Cr<'_, '_, '_>, region: RegionId, cond: Option<()>) {
        let head = cr.rw.body[region].blocks[0];
        let Some(&y) = cr.rw.body[head].ops.last() else { return };
        let saved = cr.rw.ip;
        cr.rw.set_before(y);
        let operands = cr.rw.body[y].operands.clone();
        let tys = cr.rw.body.types(&operands);
        match cond {
            Some(()) => {
                let c = Self::extract(&mut cr.rw, operands[0], &[]);
                let args = cr.rw.body[head].args.clone();
                let arg_tys = cr.rw.body.types(&args);
                cr.rw.emit(&scf::ConditionOp::new(c.into(), Self::values(&args), Type::I1, arg_tys));
            }
            None => {
                cr.rw.emit(&scf::YieldOp::new(Self::values(&operands), tys));
            }
        }
        cr.erase(y);
        cr.rw.ip = saved;
    }
}

/// `tosa-to-scf`.
#[pass("tosa-to-scf", on = "func.func", ty = TosaToScfPass)]
pub fn tosa_to_scf<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let mut patterns = ConversionPatterns::default();
    TosaToScf::populate(&mut patterns);
    let mut target = ConversionTarget::default();
    target.legal_dialect("tensor").legal_dialect("scf").illegal_op("tosa.cond_if").illegal_op("tosa.scatter").illegal_op("tosa.while_loop").unknown(Action::Legal);
    Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
}
