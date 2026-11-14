use alloc::vec::Vec;

use mlirformat::{ApFloat, ApInt, Dim, Scalar, ShapedKind, Type};

use crate::patterns;

use crate::{ArithSpirvOptions, ArithToSpirv, ConversionRewriter, OpData, OpId, ValueId};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

pub struct MathToSpirv;

#[derive(Debug, Clone, Copy, Default)]
pub struct MathSpirvOptions {
    pub shader: bool,
}

impl MathToSpirv {
    fn supported(t: &Type<'_>) -> bool {
        let scalar = |t: &Type<'_>| matches!(t, Type::Integer { .. } | Type::Index | Type::Float(_));
        match t {
            Type::Shaped(s) if s.kind == ShapedKind::Vector => scalar(&s.elem) && matches!(s.shape.as_deref(), Some([Dim::Static(_)])),
            t => scalar(t),
        }
    }

    fn checked(cr: &Cr<'_, '_, '_>, op: OpId) -> bool {
        let b = &cr.rw.body;
        b[op].operands.iter().chain(&b[op].results).all(|v| Self::supported(&b[*v].ty))
    }

    fn result_ty<'a>(cr: &Cr<'_, 'a, '_>, op: OpId) -> Option<Type<'a>> {
        let r = cr.rw.body[op].results[0];
        cr.converted(&cr.rw.body[r].ty.clone())
    }

    fn op<'a>(cr: &mut Cr<'_, 'a, '_>, name: &str, ops: &[ValueId], ty: &Type<'a>) -> ValueId {
        cr.build(OpData::build(name).operands(ops), ty.clone())
    }

    fn float<'a>(cr: &mut Cr<'_, 'a, '_>, ty: &Type<'a>, f: impl Fn(mlirformat::FloatKind) -> ApFloat) -> ValueId {
        let attr = ArithToSpirv::splat(ty, |e| match e {
            Type::Float(k) => Scalar::Float(f(*k)),
            _ => unreachable!("a float type"),
        });
        cr.spirv_const(ty.clone(), attr)
    }

    fn elementwise(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], spirv: &str) -> bool {
        Self::checked(cr, op) && ArithToSpirv::elementwise(cr, op, operands, spirv, ArithSpirvOptions { no_wrap: false, emulate_floats: true })
    }

    fn expm1(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], exp: &str) -> bool {
        let Some([x]) = Cr::one_to_one(operands).map(|o| <[ValueId; 1]>::try_from(o).ok()).flatten() else { return false };
        if !Self::checked(cr, op) {
            return false;
        }
        let Some(ty) = Self::result_ty(cr, op) else { return false };
        let e = Self::op(cr, exp, &[x], &ty);
        let one = cr.spirv_int_like(&ty, 1);
        cr.replace_new(op, OpData::build("spirv.FSub").operands(&[e, one]), &[ty]);
        true
    }

    fn log1p(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], log: &str) -> bool {
        let Some([x]) = Cr::one_to_one(operands).map(|o| <[ValueId; 1]>::try_from(o).ok()).flatten() else { return false };
        if !Self::checked(cr, op) {
            return false;
        }
        let Some(ty) = Self::result_ty(cr, op) else { return false };
        let one = cr.spirv_int_like(&ty, 1);
        let sum = Self::op(cr, "spirv.FAdd", &[one, x], &ty);
        cr.replace_new(op, OpData::build(log).operands(&[sum]), &[ty]);
        true
    }

    fn sincos(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], sin: &str, cos: &str) -> bool {
        let Some([x]) = Cr::one_to_one(operands).map(|o| <[ValueId; 1]>::try_from(o).ok()).flatten() else { return false };
        if !Self::checked(cr, op) {
            return false;
        }
        let Some(ty) = cr.converted(&cr.rw.body[cr.rw.body[op].operands[0]].ty.clone()) else { return false };
        let s = Self::op(cr, sin, &[x], &ty);
        let c = Self::op(cr, cos, &[x], &ty);
        cr.replace_values(op, &[s, c]);
        true
    }

    fn odd_mask(cr: &Cr<'_, '_, '_>, v: ValueId) -> Option<Vec<bool>> {
        let b = &cr.rw.body;
        let d = b.def_op(v).filter(|d| b.has(*d, crate::Trait::ConstantLike))?;
        let c = mlirformat::Const::try_from(b[d].get("value")?).ok()?;
        c.values.iter().map(|x| match x {
            Scalar::Float(f) => {
                let f = f.to_f64();
                (f.fract() == 0.0 && f.is_finite()).then(|| (f as i64) & 1 == 1)
            }
            _ => None,
        }).collect()
    }

    fn log10(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], log: &str) -> bool {
        const LOG10_RECIPROCAL: f64 = 0.4342944819032518276511289189166050822943970058036665661144537832;
        let Some([x]) = Cr::one_to_one(operands).map(|o| <[ValueId; 1]>::try_from(o).ok()).flatten() else { return false };
        if !Self::checked(cr, op) {
            return false;
        }
        let Some(ty) = Self::result_ty(cr, op) else { return false };
        let c = Self::float(cr, &ty, |k| ApFloat::from_f64(k, LOG10_RECIPROCAL).expect("a float"));
        let l = Self::op(cr, log, &[x], &ty);
        cr.replace_new(op, OpData::build("spirv.FMul").operands(&[l, c]), &[ty]);
        true
    }
}

#[patterns(converter, options = MathSpirvOptions)]
impl MathToSpirv {
    #[convert("math.copysign")]
    fn copysign(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], _: MathSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        if !Self::checked(cr, op) {
            return false;
        }
        let Some(ty) = Self::result_ty(cr, op) else { return false };
        let r = cr.rw.body[op].results[0];
        let Type::Float(k) = cr.rw.body[r].ty.element_type().clone() else { return false };
        let Some(bits) = Type::Float(k).bit_width() else { return false };
        let mut int = Type::int(bits);
        let sign_bit = 1u128 << (bits - 1);
        let mut sign = cr.spirv_const(int.clone(), crate::Const::int(ApInt::from_bits(bits, sign_bit), int.clone()).into());
        let mut value = cr.spirv_const(int.clone(), crate::Const::int(ApInt::from_bits(bits, sign_bit - 1), int.clone()).into());
        if let Type::Shaped(s) = &ty {
            let n = ty.element_count().unwrap_or(1);
            int = Type::Shaped(alloc::boxed::Box::new(mlirformat::Shaped { elem: int.into(), ..*s.clone() }));
            sign = Self::op(cr, "spirv.CompositeConstruct", &alloc::vec![sign; n], &int);
            value = Self::op(cr, "spirv.CompositeConstruct", &alloc::vec![value; n], &int);
        }
        let lhs = Self::op(cr, "spirv.Bitcast", &[ops[0]], &int);
        let rhs = Self::op(cr, "spirv.Bitcast", &[ops[1]], &int);
        let v = Self::op(cr, "spirv.BitwiseAnd", &[lhs, value], &int);
        let s = Self::op(cr, "spirv.BitwiseAnd", &[rhs, sign], &int);
        let res = Self::op(cr, "spirv.BitwiseOr", &[v, s], &int);
        cr.replace_new(op, OpData::build("spirv.Bitcast").operands(&[res]), &[ty]);
        true
    }

    #[convert("math.ctpop", "math.isinf", "math.isnan", "math.isfinite", "math.isnormal")]
    fn classify(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], _: MathSpirvOptions) -> bool {
        let spirv = match &*cr.rw.body[op].name {
            "math.ctpop" => "spirv.BitCount",
            "math.isinf" => "spirv.IsInf",
            "math.isnan" => "spirv.IsNan",
            "math.isnormal" => "spirv.IsNormal",
            _ => "spirv.IsFinite",
        };
        Self::elementwise(cr, op, operands, spirv)
    }

    #[convert("math.ctlz")]
    fn ctlz(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], o: MathSpirvOptions) -> bool {
        if !o.shader {
            return false;
        }
        let Some([x]) = Cr::one_to_one(operands).map(|o| <[ValueId; 1]>::try_from(o).ok()).flatten() else { return false };
        if !Self::checked(cr, op) {
            return false;
        }
        let Some(ty) = Self::result_ty(cr, op) else { return false };
        if ty.element_type().bit_width() != Some(32) || !matches!(ty.element_type(), Type::Integer { .. }) {
            return false;
        }
        let (v1, v31, v32) = (cr.spirv_int_like(&ty, 1), cr.spirv_int_like(&ty, 31), cr.spirv_int_like(&ty, 32));
        let msb = Self::op(cr, "spirv.GL.FindUMsb", &[x], &ty);
        let sub_msb = Self::op(cr, "spirv.ISub", &[v31, msb], &ty);
        let sub_input = Self::op(cr, "spirv.ISub", &[v32, x], &ty);
        let cmp = Self::op(cr, "spirv.ULessThanEqual", &[x, v1], &ty.with_element(Type::I1));
        cr.replace_new(op, OpData::build("spirv.Select").operands(&[cmp, sub_input, sub_msb]), &[ty]);
        true
    }

    #[convert("math.log1p")]
    fn log1p_gl(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], _: MathSpirvOptions) -> bool {
        Self::log1p(cr, op, operands, "spirv.GL.Log")
    }

    #[convert("math.log10")]
    fn log10_gl(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], _: MathSpirvOptions) -> bool {
        Self::log10(cr, op, operands, "spirv.GL.Log")
    }

    #[convert("math.cttz")]
    fn cttz(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], _: MathSpirvOptions) -> bool {
        let Some([x]) = Cr::one_to_one(operands).map(|o| <[ValueId; 1]>::try_from(o).ok()).flatten() else { return false };
        if !Self::checked(cr, op) {
            return false;
        }
        let Some(ty) = Self::result_ty(cr, op) else { return false };
        if ty.element_type().bit_width() != Some(32) || !matches!(ty.element_type(), Type::Integer { .. }) {
            return false;
        }
        let (v0, v32) = (cr.spirv_int_like(&ty, 0), cr.spirv_int_like(&ty, 32));
        let lsb = Self::op(cr, "spirv.GL.FindILsb", &[x], &ty);
        let zero = Self::op(cr, "spirv.IEqual", &[x, v0], &ty.with_element(Type::I1));
        cr.replace_new(op, OpData::build("spirv.Select").operands(&[zero, v32, lsb]), &[ty]);
        true
    }

    #[convert("math.fpowi")]
    fn fpowi_gl(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], _: MathSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        if !Self::checked(cr, op) {
            return false;
        }
        let Some(ty) = Self::result_ty(cr, op) else { return false };
        let (base, power) = (ops[0], ops[1]);
        let bools = ty.with_element(Type::I1);
        let exp = Self::op(cr, "spirv.ConvertSToF", &[power], &ty);
        let abs = Self::op(cr, "spirv.GL.FAbs", &[base], &ty);
        let pow = Self::op(cr, "spirv.GL.Pow", &[abs, exp], &ty);
        let zero = cr.spirv_int_like(&ty, 0);
        let less = Self::op(cr, "spirv.FOrdLessThan", &[base, zero], &bools);
        let pt = cr.rw.body[power].ty.clone();
        let one = cr.spirv_int_like(&pt, 1);
        let low = Self::op(cr, "spirv.BitwiseAnd", &[power, one], &pt);
        let odd = Self::op(cr, "spirv.IEqual", &[low, one], &bools);
        let negate = Self::op(cr, "spirv.LogicalAnd", &[less, odd], &bools);
        let neg = Self::op(cr, "spirv.FNegate", &[pow], &ty);
        cr.replace_new(op, OpData::build("spirv.Select").operands(&[negate, neg, pow]), &[ty]);
        true
    }

    #[convert("math.sincos")]
    fn sincos_gl(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], _: MathSpirvOptions) -> bool {
        Self::sincos(cr, op, operands, "spirv.GL.Sin", "spirv.GL.Cos")
    }

    #[convert("math.expm1")]
    fn expm1_gl(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], _: MathSpirvOptions) -> bool {
        Self::expm1(cr, op, operands, "spirv.GL.Exp")
    }

    #[convert("math.powf")]
    fn powf(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], _: MathSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        if !Self::checked(cr, op) {
            return false;
        }
        let Some(_) = Self::result_ty(cr, op) else { return false };
        let (lhs, rhs) = (ops[0], ops[1]);
        let ty = cr.rw.body[rhs].ty.clone();
        let Some(odd) = Self::odd_mask(cr, rhs) else {
            let log = Self::op(cr, "spirv.GL.Log", &[lhs], &ty);
            let mul = Self::op(cr, "spirv.FMul", &[rhs, log], &ty);
            cr.replace_new(op, OpData::build("spirv.GL.Exp").operands(&[mul]), &[ty]);
            return true;
        };
        let abs = Self::op(cr, "spirv.GL.FAbs", &[lhs], &ty);
        let pow = Self::op(cr, "spirv.GL.Pow", &[abs, rhs], &ty);
        if !odd.contains(&true) {
            cr.replace_values(op, &[pow]);
            return true;
        }
        let bools = ty.with_element(Type::I1);
        let zero = cr.spirv_int_like(&ty, 0);
        let less = Self::op(cr, "spirv.FOrdLessThan", &[lhs, zero], &bools);
        let neg = Self::op(cr, "spirv.FNegate", &[pow], &ty);
        let negate = if odd.iter().all(|o| *o == odd[0]) {
            less
        } else {
            let mask: mlirformat::Attribute<'_> = mlirformat::Const { ty: bools.clone(), values: odd.iter().map(|o| Scalar::Int(ApInt::new(1, i128::from(*o)))).collect(), elements: true }.into();
            let mask = cr.build(OpData::build("spirv.Constant").with("value", mask), bools.clone());
            Self::op(cr, "spirv.LogicalAnd", &[less, mask], &bools)
        };
        cr.replace_new(op, OpData::build("spirv.Select").operands(&[negate, neg, pow]), &[ty]);
        true
    }

    #[convert("math.round")]
    fn round_gl(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], _: MathSpirvOptions) -> bool {
        if !Self::checked(cr, op) {
            return false;
        }
        let Some([x]) = Cr::one_to_one(operands).map(|o| <[ValueId; 1]>::try_from(o).ok()).flatten() else { return false };
        let ty = cr.rw.body[x].ty.clone();
        let zero = cr.spirv_int_like(&ty, 0);
        let one = cr.spirv_int_like(&ty, 1);
        let half = Self::float(cr, &ty, |k| ApFloat::from_f64(k, 0.5).expect("a float"));
        let abs = Self::op(cr, "spirv.GL.FAbs", &[x], &ty);
        let floor = Self::op(cr, "spirv.GL.Floor", &[abs], &ty);
        let sub = Self::op(cr, "spirv.FSub", &[abs, floor], &ty);
        let ge = Self::op(cr, "spirv.FOrdGreaterThanEqual", &[sub, half], &ty.with_element(Type::I1));
        let sel = Self::op(cr, "spirv.Select", &[ge, one, zero], &ty);
        let add = Self::op(cr, "spirv.FAdd", &[floor, sel], &ty);
        cr.replace_new(op, OpData::build("math.copysign").operands(&[add, x]), &[ty]);
        true
    }

    #[convert("math.absf", "math.absi", "math.atan", "math.atan2", "math.ceil", "math.clampf", "math.cos", "math.exp", "math.exp2", "math.floor", "math.fma", "math.log", "math.log2", "math.roundeven", "math.rsqrt", "math.sin", "math.sqrt", "math.tanh", "math.tan", "math.trunc", "math.asin", "math.acos", "math.sinh", "math.cosh", "math.asinh", "math.acosh", "math.atanh")]
    fn gl(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], _: MathSpirvOptions) -> bool {
        let spirv = match &*cr.rw.body[op].name {
            "math.absf" => "spirv.GL.FAbs",
            "math.absi" => "spirv.GL.SAbs",
            "math.atan" => "spirv.GL.Atan",
            "math.atan2" => "spirv.GL.Atan2",
            "math.ceil" => "spirv.GL.Ceil",
            "math.clampf" => "spirv.GL.FClamp",
            "math.cos" => "spirv.GL.Cos",
            "math.exp" => "spirv.GL.Exp",
            "math.exp2" => "spirv.GL.Exp2",
            "math.floor" => "spirv.GL.Floor",
            "math.fma" => "spirv.GL.Fma",
            "math.log" => "spirv.GL.Log",
            "math.log2" => "spirv.GL.Log2",
            "math.roundeven" => "spirv.GL.RoundEven",
            "math.rsqrt" => "spirv.GL.InverseSqrt",
            "math.sin" => "spirv.GL.Sin",
            "math.sqrt" => "spirv.GL.Sqrt",
            "math.tanh" => "spirv.GL.Tanh",
            "math.tan" => "spirv.GL.Tan",
            "math.trunc" => "spirv.GL.Trunc",
            "math.asin" => "spirv.GL.Asin",
            "math.acos" => "spirv.GL.Acos",
            "math.sinh" => "spirv.GL.Sinh",
            "math.cosh" => "spirv.GL.Cosh",
            "math.asinh" => "spirv.GL.Asinh",
            "math.acosh" => "spirv.GL.Acosh",
            _ => "spirv.GL.Atanh",
        };
        Self::elementwise(cr, op, operands, spirv)
    }

    #[convert("math.log1p")]
    fn log1p_cl(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], _: MathSpirvOptions) -> bool {
        Self::log1p(cr, op, operands, "spirv.CL.log")
    }

    #[convert("math.expm1")]
    fn expm1_cl(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], _: MathSpirvOptions) -> bool {
        Self::expm1(cr, op, operands, "spirv.CL.exp")
    }

    #[convert("math.sincos")]
    fn sincos_cl(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], _: MathSpirvOptions) -> bool {
        Self::sincos(cr, op, operands, "spirv.CL.sin", "spirv.CL.cos")
    }

    #[convert("math.fpowi")]
    fn fpowi_cl(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], _: MathSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        if !Self::checked(cr, op) {
            return false;
        }
        let Some(ty) = Self::result_ty(cr, op) else { return false };
        cr.replace_new(op, OpData::build("spirv.CL.pown").operands(&ops), &[ty]);
        true
    }

    #[convert("math.absf", "math.absi", "math.ctlz", "math.atan", "math.atan2", "math.cbrt", "math.ceil", "math.cos", "math.erf", "math.erfc", "math.exp", "math.exp2", "math.floor", "math.fma", "math.log", "math.log2", "math.log10", "math.powf", "math.roundeven", "math.round", "math.rsqrt", "math.sin", "math.sqrt", "math.tanh", "math.tan", "math.trunc", "math.asin", "math.acos", "math.sinh", "math.cosh", "math.asinh", "math.acosh", "math.atanh")]
    fn cl(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], _: MathSpirvOptions) -> bool {
        let spirv = match &*cr.rw.body[op].name {
            "math.absf" => "spirv.CL.fabs",
            "math.absi" => "spirv.CL.s_abs",
            "math.ctlz" => "spirv.CL.clz",
            "math.atan" => "spirv.CL.atan",
            "math.atan2" => "spirv.CL.atan2",
            "math.cbrt" => "spirv.CL.cbrt",
            "math.ceil" => "spirv.CL.ceil",
            "math.cos" => "spirv.CL.cos",
            "math.erf" => "spirv.CL.erf",
            "math.erfc" => "spirv.CL.erfc",
            "math.exp" => "spirv.CL.exp",
            "math.exp2" => "spirv.CL.exp2",
            "math.floor" => "spirv.CL.floor",
            "math.fma" => "spirv.CL.fma",
            "math.log" => "spirv.CL.log",
            "math.log2" => "spirv.CL.log2",
            "math.log10" => "spirv.CL.log10",
            "math.powf" => "spirv.CL.pow",
            "math.roundeven" => "spirv.CL.rint",
            "math.round" => "spirv.CL.round",
            "math.rsqrt" => "spirv.CL.rsqrt",
            "math.sin" => "spirv.CL.sin",
            "math.sqrt" => "spirv.CL.sqrt",
            "math.tanh" => "spirv.CL.tanh",
            "math.tan" => "spirv.CL.tan",
            "math.trunc" => "spirv.CL.trunc",
            "math.asin" => "spirv.CL.asin",
            "math.acos" => "spirv.CL.acos",
            "math.sinh" => "spirv.CL.sinh",
            "math.cosh" => "spirv.CL.cosh",
            "math.asinh" => "spirv.CL.asinh",
            "math.acosh" => "spirv.CL.acosh",
            _ => "spirv.CL.atanh",
        };
        Self::elementwise(cr, op, operands, spirv)
    }
}
