use alloc::vec::Vec;

use mlirformat::{ApFloat, Attribute, Const, FloatKind, Scalar, Type};

use crate::patterns;
use crate::{ConversionRewriter, Libm, OpData, OpId, ValueId};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

const OCML: [(&str, &str); 8] = [
    ("complex.abs", "__ocml_cabs_f32,__ocml_cabs_f64"),
    ("complex.cos", "__ocml_ccos_f32,__ocml_ccos_f64"),
    ("complex.exp", "__ocml_cexp_f32,__ocml_cexp_f64"),
    ("complex.log", "__ocml_clog_f32,__ocml_clog_f64"),
    ("complex.sin", "__ocml_csin_f32,__ocml_csin_f64"),
    ("complex.sqrt", "__ocml_csqrt_f32,__ocml_csqrt_f64"),
    ("complex.tan", "__ocml_ctan_f32,__ocml_ctan_f64"),
    ("complex.tanh", "__ocml_ctanh_f32,__ocml_ctanh_f64"),
];

pub struct ComplexToRocdlLibCalls;

#[patterns]
impl ComplexToRocdlLibCalls {
    #[convert("complex.abs", "complex.cos", "complex.exp", "complex.log", "complex.sin", "complex.sqrt", "complex.tan", "complex.tanh")]
    fn library_call(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let name = cr.rw.body[op].name.clone();
        let Some((_, fns)) = OCML.iter().find(|(n, _)| **n == *name) else { return false };
        let ty = cr.rw.body[cr.rw.body[op].results[0]].ty.clone();
        let elem = match &ty {
            Type::Complex(e) => (**e).clone(),
            t => t.clone(),
        };
        Libm::call(cr, op, fns, Libm::float(&elem), false)
    }

    #[convert("complex.pow")]
    fn pow<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let b = &*cr.rw.body;
        let (lhs, rhs) = (b[op].operands[0], b[op].operands[1]);
        let ty = b[b[op].results[0]].ty.clone();
        let fm = b[op].get("fastmath").cloned();
        let with = |d: OpData<'a>| -> OpData<'a> {
            match &fm {
                Some(f) => d.with("fastmath", f.clone()),
                None => d,
            }
        };
        cr.rw.set_before(op);
        let log = cr.build(with(OpData::build("complex.log").operands(&[lhs])), ty.clone());
        let mul = cr.build(with(OpData::build("complex.mul").operands(&[rhs, log])), ty.clone());
        let exp = cr.build(with(OpData::build("complex.exp").operands(&[mul])), ty);
        cr.replace(op, alloc::vec![alloc::vec![exp]]);
        true
    }

    #[convert("complex.powi")]
    fn powi(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let b = &*cr.rw.body;
        let (lhs, rhs) = (b[op].operands[0], b[op].operands[1]);
        let ty = b[b[op].results[0]].ty.clone();
        let Type::Complex(elem) = ty.element_type().clone() else { return false };
        let elem = (*elem).clone();
        let Type::Float(k) = elem else { return false };
        let rhs_ty = b[rhs].ty.clone();
        let exp_ty = match &rhs_ty {
            Type::Shaped(s) => Type::Shaped(alloc::boxed::Box::new(mlirformat::Shaped { elem: elem.clone().into(), ..*s.clone() })),
            _ => elem.clone(),
        };
        let fm = b[op].get("fastmath").cloned();
        cr.rw.set_before(op);
        let real = cr.build(OpData::build("arith.sitofp").operands(&[rhs]), exp_ty.clone());
        let zero = Scalar::Float(ApFloat::from_f64(k, 0.0).unwrap_or_else(|| ApFloat::from_f64(FloatKind::F32, 0.0).expect("f32")));
        let value: Attribute<'_> = if matches!(exp_ty, Type::Shaped(_)) { Const::splat(zero, exp_ty.clone()).into() } else { Const::scalar(zero, exp_ty.clone()).into() };
        let imag = cr.build(OpData::build("arith.constant").with("value", value), exp_ty);
        let lhs_ty = cr.rw.body[lhs].ty.clone();
        let exponent = cr.build(OpData::build("complex.create").operands(&[real, imag]), lhs_ty);
        let mut d = OpData::build("complex.pow").operands(&[lhs, exponent]);
        if let Some(f) = fm {
            d.set("fastmath", f);
        }
        cr.replace_new(op, d, &[ty]);
        true
    }
}
