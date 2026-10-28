//! `math` ⇒ `spirv`, as `MathToSPIRV.cpp`: the core ops, then the GLSL and the OpenCL
//! extended instructions (the target's capabilities decide which are legal).

use alloc::vec::Vec;

use mlirformat::{ApFloat, ApInt, Dim, Scalar, ShapedKind, Type};

use crate::patterns;

use crate::{ArithSpirvOptions, ArithToSpirv, ConversionRewriter, OpData, OpId, ValueId};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

/// The math ⇒ spirv patterns (`populateMathToSPIRVPatterns`).
pub struct MathToSpirv;

impl MathToSpirv {
    /// `isSupportedSourceType`: an int, index or float, or a 1-D fixed vector of them.
    fn supported(t: &Type<'_>) -> bool {
        let scalar = |t: &Type<'_>| matches!(t, Type::Integer { .. } | Type::Index | Type::Float(_));
        match t {
            Type::Shaped(s) if s.kind == ShapedKind::Vector => scalar(&s.elem) && matches!(s.shape.as_deref(), Some([Dim::Static(_)])),
            t => scalar(t),
        }
    }

    /// `checkSourceOpTypes`.
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

    /// A float `spirv.Constant` of `ty` (splat over a vector).
    fn float<'a>(cr: &mut Cr<'_, 'a, '_>, ty: &Type<'a>, f: impl Fn(mlirformat::FloatKind) -> ApFloat) -> ValueId {
        let attr = ArithToSpirv::splat(ty, |e| match e {
            Type::Float(k) => Scalar::Float(f(*k)),
            _ => unreachable!("a float type"),
        });
        cr.spirv_const(ty.clone(), attr)
    }

    /// `CheckedElementwiseOpPattern`.
    fn elementwise(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], spirv: &str) -> bool {
        Self::checked(cr, op) && ArithToSpirv::elementwise(cr, op, operands, spirv, ArithSpirvOptions { no_wrap: false, emulate_floats: true })
    }

    /// `ExpM1OpPattern`: `exp(x) - 1`.
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

    /// `Log1pOpPattern`: `log(1 + x)`.
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

    /// `Log2Log10OpPattern`: `log(x) * (1 / ln b)`.
    fn log_base(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], log: &str) -> bool {
        const LOG2_RECIPROCAL: f64 = 1.442695040888963407359924681001892137426645954152985934135449407;
        const LOG10_RECIPROCAL: f64 = 0.4342944819032518276511289189166050822943970058036665661144537832;
        let Some([x]) = Cr::one_to_one(operands).map(|o| <[ValueId; 1]>::try_from(o).ok()).flatten() else { return false };
        if !Self::checked(cr, op) {
            return false;
        }
        let Some(ty) = Self::result_ty(cr, op) else { return false };
        let r = if cr.rw.body[op].name == "math.log2" { LOG2_RECIPROCAL } else { LOG10_RECIPROCAL };
        let c = Self::float(cr, &ty, |k| ApFloat::from_f64(k, r).expect("a float"));
        let l = Self::op(cr, log, &[x], &ty);
        cr.replace_new(op, OpData::build("spirv.FMul").operands(&[l, c]), &[ty]);
        true
    }
}

#[patterns(converter)]
impl MathToSpirv {
    /// `CopySignPattern`: the magnitude bits of the lhs, the sign bit of the rhs.
    #[lowering("math.copysign")]
    fn copysign(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
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
            int = Type::Shaped(mlirformat::Shaped { elem: int.into(), ..s.clone() });
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

    /// The core ops.
    #[lowering("math.isinf", "math.isnan", "math.isfinite")]
    fn classify(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        let spirv = match &*cr.rw.body[op].name {
            "math.isinf" => "spirv.IsInf",
            "math.isnan" => "spirv.IsNan",
            _ => "spirv.IsFinite",
        };
        Self::elementwise(cr, op, operands, spirv)
    }

    /// `CountLeadingZerosPattern`: `x <= 1 ? 32 - x : 31 - findUMsb(x)`, for 32 bits.
    #[lowering("math.ctlz")]
    fn ctlz(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
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

    #[lowering("math.log1p")]
    fn log1p_gl(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        Self::log1p(cr, op, operands, "spirv.GL.Log")
    }

    #[lowering("math.log2", "math.log10")]
    fn log_base_gl(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        Self::log_base(cr, op, operands, "spirv.GL.Log")
    }

    #[lowering("math.expm1")]
    fn expm1_gl(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        Self::expm1(cr, op, operands, "spirv.GL.Exp")
    }

    /// `PowFOpPattern`: `pow(|x|, y)`, negated for a negative `x` and an odd `y`; NaN for a
    /// negative `x` and a fractional `y`.
    #[lowering("math.powf")]
    fn powf(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        if !Self::checked(cr, op) {
            return false;
        }
        let Some(_) = Self::result_ty(cr, op) else { return false };
        let r = cr.rw.body[op].results[0];
        let Type::Float(k) = cr.rw.body[r].ty.element_type().clone() else { return false };
        let (lhs, rhs) = (ops[0], ops[1]);
        let ty = cr.rw.body[rhs].ty.clone();
        let int = ty.with_element(Type::int(32));
        let bools = ty.with_element(Type::I1);
        let zero = cr.spirv_int_like(&ty, 0);
        let less = Self::op(cr, "spirv.FOrdLessThan", &[lhs, zero], &bools);
        let one = cr.spirv_int_like(&ty, 1);
        let rem = Self::op(cr, "spirv.FRem", &[rhs, one], &ty);
        let frac = Self::op(cr, "spirv.FOrdNotEqual", &[rem, zero], &bools);
        let nan_case = Self::op(cr, "spirv.LogicalAnd", &[frac, less], &bools);
        let nan = Self::float(cr, &ty, |_| ApFloat::nan(k));
        let lhs = Self::op(cr, "spirv.Select", &[nan_case, nan, lhs], &ty);
        let abs = Self::op(cr, "spirv.GL.FAbs", &[lhs], &ty);
        let int_rhs = Self::op(cr, "spirv.ConvertFToS", &[rhs], &int);
        let int_one = cr.spirv_int_like(&int, 1);
        let and = Self::op(cr, "spirv.BitwiseAnd", &[int_rhs, int_one], &int);
        let odd = Self::op(cr, "spirv.IEqual", &[and, int_one], &bools);
        let pow = Self::op(cr, "spirv.GL.Pow", &[abs, rhs], &ty);
        let neg = Self::op(cr, "spirv.FNegate", &[pow], &ty);
        let negate = Self::op(cr, "spirv.LogicalAnd", &[less, odd], &bools);
        cr.replace_new(op, OpData::build("spirv.Select").operands(&[negate, neg, pow]), &[ty]);
        true
    }

    /// `RoundOpPattern`: `copysign(floor(|x|) + (|x| - floor(|x|) >= 0.5), x)`, on the
    /// original operand, the copysign lowered in turn.
    #[lowering("math.round")]
    fn round_gl(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        if !Self::checked(cr, op) {
            return false;
        }
        let x = cr.rw.body[op].operands[0];
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

    /// The GLSL extended instructions.
    #[lowering("math.absf", "math.absi", "math.atan", "math.ceil", "math.cos", "math.exp", "math.floor", "math.fma", "math.log", "math.roundeven", "math.rsqrt", "math.sin", "math.sqrt", "math.tanh", "math.tan", "math.asin", "math.acos", "math.sinh", "math.cosh", "math.asinh", "math.acosh", "math.atanh")]
    fn gl(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        let spirv = match &*cr.rw.body[op].name {
            "math.absf" => "spirv.GL.FAbs",
            "math.absi" => "spirv.GL.SAbs",
            "math.atan" => "spirv.GL.Atan",
            "math.ceil" => "spirv.GL.Ceil",
            "math.cos" => "spirv.GL.Cos",
            "math.exp" => "spirv.GL.Exp",
            "math.floor" => "spirv.GL.Floor",
            "math.fma" => "spirv.GL.Fma",
            "math.log" => "spirv.GL.Log",
            "math.roundeven" => "spirv.GL.RoundEven",
            "math.rsqrt" => "spirv.GL.InverseSqrt",
            "math.sin" => "spirv.GL.Sin",
            "math.sqrt" => "spirv.GL.Sqrt",
            "math.tanh" => "spirv.GL.Tanh",
            "math.tan" => "spirv.GL.Tan",
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

    #[lowering("math.log1p")]
    fn log1p_cl(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        Self::log1p(cr, op, operands, "spirv.CL.log")
    }

    #[lowering("math.expm1")]
    fn expm1_cl(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        Self::expm1(cr, op, operands, "spirv.CL.exp")
    }

    #[lowering("math.log2", "math.log10")]
    fn log_base_cl(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        Self::log_base(cr, op, operands, "spirv.CL.log")
    }

    /// The OpenCL extended instructions.
    #[lowering("math.absf", "math.absi", "math.atan", "math.atan2", "math.ceil", "math.cos", "math.erf", "math.exp", "math.floor", "math.fma", "math.log", "math.powf", "math.roundeven", "math.round", "math.rsqrt", "math.sin", "math.sqrt", "math.tanh", "math.tan", "math.asin", "math.acos", "math.sinh", "math.cosh", "math.asinh", "math.acosh", "math.atanh")]
    fn cl(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        let spirv = match &*cr.rw.body[op].name {
            "math.absf" => "spirv.CL.fabs",
            "math.absi" => "spirv.CL.s_abs",
            "math.atan" => "spirv.CL.atan",
            "math.atan2" => "spirv.CL.atan2",
            "math.ceil" => "spirv.CL.ceil",
            "math.cos" => "spirv.CL.cos",
            "math.erf" => "spirv.CL.erf",
            "math.exp" => "spirv.CL.exp",
            "math.floor" => "spirv.CL.floor",
            "math.fma" => "spirv.CL.fma",
            "math.log" => "spirv.CL.log",
            "math.powf" => "spirv.CL.pow",
            "math.roundeven" => "spirv.CL.rint",
            "math.round" => "spirv.CL.round",
            "math.rsqrt" => "spirv.CL.rsqrt",
            "math.sin" => "spirv.CL.sin",
            "math.sqrt" => "spirv.CL.sqrt",
            "math.tanh" => "spirv.CL.tanh",
            "math.tan" => "spirv.CL.tan",
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
