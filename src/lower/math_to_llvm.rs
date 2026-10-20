//! `math` ⇒ `llvm`, as `MathToLLVM.cpp`.

use alloc::vec;
use alloc::vec::Vec;

use mlirpass_macros::patterns;
use mlirformat::{Attribute, NamedAttr, Type};

use super::llvm_fastmath;
use crate::{ApFloat, Const, ConversionRewriter, LlvmType, OpData, OpId, Scalar, ValueId, attr};

/// The math ⇒ llvm patterns.
pub struct MathToLlvm;

#[patterns(converter, approximate_log1p: bool)]
#[map("math.ctpop" => "llvm.intr.ctpop", fp)]
#[map("math.absf" => "llvm.intr.fabs", fastmath, fp)]
#[map("math.ceil" => "llvm.intr.ceil", fastmath, fp)]
#[map("math.copysign" => "llvm.intr.copysign", fastmath, fp)]
#[map("math.cos" => "llvm.intr.cos", fastmath, fp)]
#[map("math.cosh" => "llvm.intr.cosh", fastmath, fp)]
#[map("math.acos" => "llvm.intr.acos", fastmath, fp)]
#[map("math.exp2" => "llvm.intr.exp2", fastmath, fp)]
#[map("math.exp" => "llvm.intr.exp", fastmath, fp)]
#[map("math.fpowi" => "llvm.intr.powi", fastmath, fp)]
#[map("math.floor" => "llvm.intr.floor", fastmath, fp)]
#[map("math.fma" => "llvm.intr.fma", fastmath, fp)]
#[map("math.log10" => "llvm.intr.log10", fastmath, fp)]
#[map("math.log2" => "llvm.intr.log2", fastmath, fp)]
#[map("math.log" => "llvm.intr.log", fastmath, fp)]
#[map("math.powf" => "llvm.intr.pow", fastmath, fp)]
#[map("math.roundeven" => "llvm.intr.roundeven", fastmath, fp)]
#[map("math.round" => "llvm.intr.round", fastmath, fp)]
#[map("math.sin" => "llvm.intr.sin", fastmath, fp)]
#[map("math.sinh" => "llvm.intr.sinh", fastmath, fp)]
#[map("math.asin" => "llvm.intr.asin", fastmath, fp)]
#[map("math.sqrt" => "llvm.intr.sqrt", fastmath, fp)]
#[map("math.trunc" => "llvm.intr.trunc", fastmath, fp)]
#[map("math.tan" => "llvm.intr.tan", fastmath, fp)]
#[map("math.tanh" => "llvm.intr.tanh", fastmath, fp)]
#[map("math.atan" => "llvm.intr.atan", fastmath, fp)]
#[map("math.atan2" => "llvm.intr.atan2", fastmath, fp)]
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

    #[lowering("math.ctlz")]
    fn ctlz(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        Self::int_with_flag(cr, op, operands, "llvm.intr.ctlz", "is_zero_poison")
    }

    #[lowering("math.cttz")]
    fn cttz(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        Self::int_with_flag(cr, op, operands, "llvm.intr.cttz", "is_zero_poison")
    }

    #[lowering("math.absi")]
    fn absi(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        Self::int_with_flag(cr, op, operands, "llvm.intr.abs", "is_int_min_poison")
    }

    #[lowering("math.sincos")]
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

    #[lowering("math.expm1")]
    fn expm1(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        Self::two_step(cr, op, operands, 0)
    }

    #[lowering("math.log1p", when = approximate_log1p)]
    fn log1p(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        Self::two_step(cr, op, operands, 1)
    }

    #[lowering("math.rsqrt")]
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

    #[lowering("math.isnan")]
    fn isnan(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        Self::fpclass(cr, op, operands, 3)
    }

    #[lowering("math.isfinite")]
    fn isfinite(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        Self::fpclass(cr, op, operands, 504)
    }

}
