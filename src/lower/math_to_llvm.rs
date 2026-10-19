//! `math` ⇒ `llvm`, as `MathToLLVM.cpp`.

use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{Attribute, NamedAttr, Type};

use super::arith_to_llvm::{Attrs, OneToOne};
use super::{Lowering, llvm_fastmath};
use crate::{ApFloat, Const, ConversionPatterns, ConversionRewriter, LlvmType, OpData, OpId, Scalar, ValueId, attr};

/// `ConvertFMFMathToLLVMPattern` pairs (and `ctpop`, which passes its attributes through).
const FASTMATH: &[(&str, &str)] = &[
    ("math.absf", "llvm.intr.fabs"),
    ("math.ceil", "llvm.intr.ceil"),
    ("math.copysign", "llvm.intr.copysign"),
    ("math.cos", "llvm.intr.cos"),
    ("math.cosh", "llvm.intr.cosh"),
    ("math.acos", "llvm.intr.acos"),
    ("math.exp2", "llvm.intr.exp2"),
    ("math.exp", "llvm.intr.exp"),
    ("math.fpowi", "llvm.intr.powi"),
    ("math.floor", "llvm.intr.floor"),
    ("math.fma", "llvm.intr.fma"),
    ("math.log10", "llvm.intr.log10"),
    ("math.log2", "llvm.intr.log2"),
    ("math.log", "llvm.intr.log"),
    ("math.powf", "llvm.intr.pow"),
    ("math.roundeven", "llvm.intr.roundeven"),
    ("math.round", "llvm.intr.round"),
    ("math.sin", "llvm.intr.sin"),
    ("math.sinh", "llvm.intr.sinh"),
    ("math.asin", "llvm.intr.asin"),
    ("math.sqrt", "llvm.intr.sqrt"),
    ("math.trunc", "llvm.intr.trunc"),
    ("math.tan", "llvm.intr.tan"),
    ("math.tanh", "llvm.intr.tanh"),
    ("math.atan", "llvm.intr.atan"),
    ("math.atan2", "llvm.intr.atan2"),
];

/// The math ⇒ llvm patterns.
pub struct MathToLlvm;

impl MathToLlvm {
    /// The op's attributes with `fastmath` as `fastmathFlags` (`AttrConvertFastMathToLLVM`).
    fn fmf_attrs(cr: &ConversionRewriter<'_, '_, '_>, op: OpId) -> Vec<NamedAttr<'static>> {
        let mut attrs: Vec<NamedAttr<'static>> = cr.all_attrs(op).iter().map(|a| NamedAttr { name: alloc::borrow::Cow::Owned(alloc::string::String::from(&*a.name)), value: a.value.as_ref().map(crate::Owned::owned) }).collect();
        if let Some(i) = attrs.iter().position(|a| a.name == "fastmath") {
            let a = attrs.remove(i);
            attrs.push(NamedAttr { name: "fastmathFlags".into(), value: Some(llvm_fastmath(a.value.as_ref())) });
        }
        attrs
    }

    fn with_attrs<'a>(mut d: OpData<'a>, attrs: &[NamedAttr<'a>]) -> OpData<'a> {
        for a in attrs {
            d.set(&a.name, a.value.clone().unwrap_or(Attribute::Unit));
        }
        d
    }

    fn unsupported(cr: &ConversionRewriter<'_, '_, '_>, op: OpId) -> bool {
        let b = &*cr.rw.body;
        let types: Vec<Type> = b[op].operands.iter().chain(&b[op].results).map(|v| b[*v].ty.clone()).collect();
        types.iter().any(|t| cr.unsupported_float(t))
    }

    /// `IntOpWithFlagLowering`: the intrinsic with its poison flag `false`.
    fn int_with_flag(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], name: &str, flag: &str) -> bool {
        if Self::unsupported(cr, op) {
            return false;
        }
        let Some([x]) = ConversionRewriter::one_to_one(operands).and_then(|v| <[ValueId; 1]>::try_from(v).ok()) else { return false };
        let Some(tc) = cr.type_converter() else { return false };
        let in_ty = cr.rw.body[x].ty.clone();
        let Some(llvm_in) = tc.convert(&in_ty) else { return false };
        let Some(res) = tc.convert(&cr.rw.body[cr.rw.body[op].results[0]].ty.clone()) else { return false };
        let data = |o: &[ValueId]| OpData::build(name).operands(o).with(flag, Attribute::Bool(false));
        if !matches!(LlvmType::try_from(&llvm_in), Ok(LlvmType::Array(..))) {
            cr.replace_new(op, data(&[x]), &[res]);
            return true;
        }
        if !matches!(res, Type::Shaped(_)) {
            return false;
        }
        cr.unroll_vectors(op, &[x], |cr, ty, p| cr.build(data(p), ty))
    }

    fn ctlz(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        Self::int_with_flag(cr, op, operands, "llvm.intr.ctlz", "is_zero_poison")
    }

    fn cttz(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        Self::int_with_flag(cr, op, operands, "llvm.intr.cttz", "is_zero_poison")
    }

    fn absi(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        Self::int_with_flag(cr, op, operands, "llvm.intr.abs", "is_int_min_poison")
    }

    fn sincos(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        if Self::unsupported(cr, op) {
            return false;
        }
        let Some([x]) = ConversionRewriter::one_to_one(operands).and_then(|v| <[ValueId; 1]>::try_from(v).ok()) else { return false };
        let Some(tc) = cr.type_converter() else { return false };
        let Some(t) = tc.convert(&cr.rw.body[x].ty.clone()) else { return false };
        let attrs = Self::fmf_attrs(cr, op);
        let s = cr.build(Self::with_attrs(OpData::build("llvm.intr.sincos").operands(&[x]), &attrs), LlvmType::literal(vec![t.clone(), t]));
        let (sin, cos) = (cr.extract(s, &[0]), cr.extract(s, &[1]));
        cr.replace_values(op, &[sin, cos]);
        true
    }

    /// A constant 1.0 of (1-d vector or scalar) type `ty`.
    fn one<'a>(cr: &mut ConversionRewriter<'_, 'a, '_>, ty: &Type<'a>) -> Option<ValueId> {
        let Type::Float(k) = *attr::element_type(ty) else { return None };
        let one = Scalar::Float(ApFloat::from_f64(k, 1.0)?);
        let value: Attribute = match ty {
            Type::Shaped(_) => Const::splat(one, ty.clone()).into(),
            t => Const::scalar(one, t.clone()).into(),
        };
        Some(cr.llvm_constant(value, ty.clone()))
    }

    /// `ExpM1OpLowering`, `Log1pOpLowering` and `RsqrtOpLowering`: two intrinsics and a 1.0.
    fn two_step(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], kind: u8) -> bool {
        if Self::unsupported(cr, op) {
            return false;
        }
        let Some([x]) = ConversionRewriter::one_to_one(operands).and_then(|v| <[ValueId; 1]>::try_from(v).ok()) else { return false };
        let Some(tc) = cr.type_converter() else { return false };
        let Some(llvm_ty) = tc.convert(&cr.rw.body[x].ty.clone()) else { return false };
        let attrs = Self::fmf_attrs(cr, op);
        let res_ty = cr.rw.body[cr.rw.body[op].results[0]].ty.clone();
        let make = move |cr: &mut ConversionRewriter<'_, '_, '_>, ty: Type<'_>, x: ValueId| -> Option<ValueId> {
            let ty = crate::Owned::owned(&ty);
            let one = Self::one(cr, &ty)?;
            Some(match kind {
                // expm1: exp(x) - 1
                0 => {
                    let e = cr.build(Self::with_attrs(OpData::build("llvm.intr.exp").operands(&[x]), &attrs), ty.clone());
                    cr.build(Self::with_attrs(OpData::build("llvm.fsub").operands(&[e, one]), &attrs), ty)
                }
                // log1p: log(1 + x)
                1 => {
                    let a = cr.build(Self::with_attrs(OpData::build("llvm.fadd").operands(&[one, x]), &attrs), ty.clone());
                    cr.build(Self::with_attrs(OpData::build("llvm.intr.log").operands(&[a]), &attrs), ty)
                }
                // rsqrt: 1 / sqrt(x)
                _ => {
                    let s = cr.build(Self::with_attrs(OpData::build("llvm.intr.sqrt").operands(&[x]), &attrs), ty.clone());
                    cr.build(Self::with_attrs(OpData::build("llvm.fdiv").operands(&[one, s]), &attrs), ty)
                }
            })
        };
        if !matches!(LlvmType::try_from(&llvm_ty), Ok(LlvmType::Array(..))) {
            let Some(r) = make(cr, llvm_ty, x) else { return false };
            cr.replace_values(op, &[r]);
            return true;
        }
        if !matches!(res_ty, Type::Shaped(_)) {
            return false;
        }
        cr.unroll_vectors(op, &[x], |cr, ty, p| make(cr, ty, p[0]).expect("float vector"))
    }

    fn expm1(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        Self::two_step(cr, op, operands, 0)
    }

    fn log1p(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        Self::two_step(cr, op, operands, 1)
    }

    fn rsqrt(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        Self::two_step(cr, op, operands, 2)
    }

    /// `llvm.intr.is.fpclass` with `fcNan` (3) or `fcFinite` (504).
    fn fpclass(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], bit: i64) -> bool {
        if Self::unsupported(cr, op) {
            return false;
        }
        let Some([x]) = ConversionRewriter::one_to_one(operands).and_then(|v| <[ValueId; 1]>::try_from(v).ok()) else { return false };
        let Some(tc) = cr.type_converter() else { return false };
        let Some(res) = tc.convert(&cr.rw.body[cr.rw.body[op].results[0]].ty.clone()) else { return false };
        let b = Attribute::Int { lit: alloc::borrow::Cow::Owned(alloc::format!("{bit}")), ty: Some(Type::int(32)) };
        cr.replace_new(op, OpData::build("llvm.intr.is.fpclass").operands(&[x]).with("bit", b), &[res]);
        true
    }

    fn isnan(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        Self::fpclass(cr, op, operands, 3)
    }

    fn isfinite(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        Self::fpclass(cr, op, operands, 504)
    }

    /// `populateMathToLLVMConversionPatterns`.
    pub fn populate(patterns: &mut ConversionPatterns<'_>, tc: usize, approximate_log1p: bool) {
        if approximate_log1p {
            patterns.add_with(tc, Lowering { root: "math.log1p", benefit: 1, f: Self::log1p });
        }
        let special: [(&'static str, super::LowerFn); 8] = [
            ("math.isnan", Self::isnan),
            ("math.isfinite", Self::isfinite),
            ("math.absi", Self::absi),
            ("math.ctlz", Self::ctlz),
            ("math.cttz", Self::cttz),
            ("math.expm1", Self::expm1),
            ("math.rsqrt", Self::rsqrt),
            ("math.sincos", Self::sincos),
        ];
        for (root, f) in special {
            patterns.add_with(tc, Lowering { root, benefit: 1, f });
        }
        patterns.add_with(tc, OneToOne { from: "math.ctpop", to: "llvm.intr.ctpop", attrs: Attrs::PassThrough, fail_on_unsupported_fp: true, unconstrained: false });
        for (from, to) in FASTMATH {
            patterns.add_with(tc, OneToOne { from, to, attrs: Attrs::FastMath, fail_on_unsupported_fp: true, unconstrained: false });
        }
    }
}
