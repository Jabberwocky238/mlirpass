//! `arith` ⇒ `spirv`, as `ArithToSPIRV.cpp`.

use alloc::vec;
use alloc::vec::Vec;

use crate::patterns;
use mlirformat::{ApFloat, ApInt, Attribute, Const, FloatKind, Scalar, ShapedKind, Type};

use crate::{ConversionRewriter, OpData, OpId, OpSpec, ValueId};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

/// What the arith patterns need of the target and the type converter.
#[derive(Debug, Clone, Copy)]
pub struct ArithSpirvOptions {
    /// `SPV_KHR_no_integer_wrap_decoration`: overflow flags become decorations.
    pub no_wrap: bool,
    /// `emulateUnsupportedFloatTypes`.
    pub emulate_floats: bool,
}

/// The arith ⇒ spirv patterns (`populateArithToSPIRVPatterns`).
pub struct ArithToSpirv;

impl<'a> ConversionRewriter<'_, 'a, '_> {
    /// The converted type of `t`.
    pub fn converted(&self, t: &Type<'a>) -> Option<Type<'a>> {
        self.type_converter()?.convert(t)
    }

    /// `spirv::ConstantOp::getZero` / `getOne` (`v`: 0 or 1) of a scalar or vector type.
    pub fn spirv_int_like(&mut self, ty: &Type<'a>, v: i64) -> ValueId {
        let attr = ArithToSpirv::splat(ty, |e| match e {
            Type::Float(k) => Scalar::Float(ApFloat::from_f64(*k, v as f64).expect("a float")),
            e => Scalar::Int(ApInt::new(e.bit_width().unwrap_or(32), i128::from(v))),
        });
        self.spirv_const(ty.clone(), attr)
    }
}

impl ArithToSpirv {
    /// `isBoolScalarOrVector`.
    fn is_bool(t: &Type<'_>) -> bool {
        *t == Type::I1 || matches!(t, Type::Shaped(s) if s.kind == ShapedKind::Vector && *s.elem == Type::I1)
    }

    /// A scalar of type `ty`'s element, splat over `ty` when it is a vector.
    pub(crate) fn splat<'a>(ty: &Type<'a>, f: impl Fn(&Type<'a>) -> Scalar) -> Attribute<'a> {
        match ty {
            Type::Shaped(s) => {
                let v = f(&s.elem);
                if *s.elem == Type::I1 {
                    return Const::splat(v, ty.clone()).into();
                }
                Const::splat(v, ty.clone()).into()
            }
            t if *t == Type::I1 => Attribute::Bool(matches!(f(t), Scalar::Int(i) if i.bits() != 0)),
            t => Const::scalar(f(t), t.clone()).into(),
        }
    }

    /// `getScalarOrVectorConstInt`.
    fn const_int<'a>(cr: &mut Cr<'_, 'a, '_>, ty: &Type<'a>, v: u64) -> ValueId {
        let attr = Self::splat(ty, |e| Scalar::Int(ApInt::from_bits(e.bit_width().unwrap_or(32), u128::from(v))));
        cr.spirv_const(ty.clone(), attr)
    }

    fn result_ty<'a>(cr: &Cr<'_, 'a, '_>, op: OpId) -> Option<Type<'a>> {
        let r = cr.rw.body[op].results[0];
        cr.converted(&cr.rw.body[r].ty)
    }

    fn src_ty<'a>(cr: &Cr<'_, 'a, '_>, op: OpId, i: usize) -> Type<'a> {
        let v = cr.rw.body[op].operands[i];
        cr.rw.body[v].ty.clone()
    }

    /// `hasTrait<UnsignedOp>` of the spirv op, on a type the converter changed (not `index`).
    fn unsigned_emulated<'a>(cr: &Cr<'_, 'a, '_>, op: OpId, spirv: &str, dst: &Type<'a>) -> bool {
        let r = cr.rw.body[op].results[0];
        let src = cr.rw.body[r].ty.clone();
        OpSpec::of(spirv).is_some_and(|s| s.unsigned) && *src.element_type() != Type::Index && src != *dst
    }

    /// `spirv::ElementwiseOpPattern` (and `ElementwiseArithOpPattern`, which adds the
    /// overflow decorations).
    pub(crate) fn elementwise<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], spirv: &str, o: ArithSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let Some(dst) = Self::result_ty(cr, op) else { return false };
        if Self::unsigned_emulated(cr, op, spirv, &dst) {
            return false;
        }
        let mut data = OpData::build(spirv).operands(&ops);
        if o.no_wrap
            && let Some(Attribute::Extended { ext, .. }) = cr.rw.body[op].get("overflowFlags")
        {
            let flags = ext.body.as_deref().unwrap_or("");
            if flags.contains("nsw") {
                data.set("no_signed_wrap", Attribute::Unit);
            }
            if flags.contains("nuw") {
                data.set("no_unsigned_wrap", Attribute::Unit);
            }
        }
        let v = cr.build(data, dst);
        cr.replace_values(op, &[v]);
        true
    }

    fn fastmath_nnan(cr: &Cr<'_, '_, '_>, op: OpId) -> bool {
        matches!(cr.rw.body[op].get("fastmath"), Some(Attribute::Extended { ext, .. }) if ext.body.as_deref().is_some_and(|b| b.contains("nnan") || b.contains("fast")))
    }

    /// `convertIntegerAttr`: `v` as an integer of `width` bits, when it fits (unsigned or
    /// signed).
    fn fit_int(v: ApInt, width: u32) -> Option<ApInt> {
        let s = v.signed();
        let unsigned_fits = v.bits() >> width.min(127) == 0 || width >= v.width;
        let signed_fits = width >= 128 || (s >= -(1i128 << (width - 1)) && s < (1i128 << (width - 1)));
        (unsigned_fits || signed_fits).then(|| ApInt::new(width, s))
    }

    /// `convertFloatAttr`: to `f32` without losing anything.
    fn fit_f32(f: ApFloat) -> Option<ApFloat> {
        let g = f.convert(FloatKind::F32)?;
        (g.to_f64() == f.to_f64() || f.to_f64().is_nan()).then_some(g)
    }
}

#[patterns(converter, options = ArithSpirvOptions)]
impl ArithToSpirv {
    /// The one-to-one lowerings (`spirv::ElementwiseOpPattern` and, adding overflow
    /// decorations, `ElementwiseArithOpPattern`).
    #[lowering("arith.addi", "arith.subi", "arith.muli", "arith.shli", "arith.divui", "arith.divsi", "arith.remui", "arith.shrui", "arith.shrsi", "arith.negf", "arith.addf", "arith.subf", "arith.mulf", "arith.divf", "arith.remf")]
    fn one_to_one_op<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], o: ArithSpirvOptions) -> bool {
        let (target, wrap) = match &*cr.rw.body[op].name {
            "arith.addi" => ("spirv.IAdd", true),
            "arith.subi" => ("spirv.ISub", true),
            "arith.muli" => ("spirv.IMul", true),
            "arith.shli" => ("spirv.ShiftLeftLogical", true),
            "arith.divui" => ("spirv.UDiv", false),
            "arith.divsi" => ("spirv.SDiv", false),
            "arith.remui" => ("spirv.UMod", false),
            "arith.shrui" => ("spirv.ShiftRightLogical", false),
            "arith.shrsi" => ("spirv.ShiftRightArithmetic", false),
            "arith.negf" => ("spirv.FNegate", false),
            "arith.addf" => ("spirv.FAdd", false),
            "arith.subf" => ("spirv.FSub", false),
            "arith.mulf" => ("spirv.FMul", false),
            "arith.divf" => ("spirv.FDiv", false),
            _ => ("spirv.FRem", false),
        };
        Self::elementwise(cr, op, operands, target, ArithSpirvOptions { no_wrap: o.no_wrap && wrap, ..o })
    }

    /// Integer min / max: the GLSL extended instruction, else the OpenCL one.
    #[lowering("arith.maxsi", "arith.maxui", "arith.minsi", "arith.minui")]
    fn int_min_max_gl<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], o: ArithSpirvOptions) -> bool {
        let t = match &*cr.rw.body[op].name {
            "arith.maxsi" => "spirv.GL.SMax",
            "arith.maxui" => "spirv.GL.UMax",
            "arith.minsi" => "spirv.GL.SMin",
            _ => "spirv.GL.UMin",
        };
        Self::elementwise(cr, op, operands, t, ArithSpirvOptions { no_wrap: false, ..o })
    }

    #[lowering("arith.maxsi", "arith.maxui", "arith.minsi", "arith.minui")]
    fn int_min_max_cl<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], o: ArithSpirvOptions) -> bool {
        let t = match &*cr.rw.body[op].name {
            "arith.maxsi" => "spirv.CL.s_max",
            "arith.maxui" => "spirv.CL.u_max",
            "arith.minsi" => "spirv.CL.s_min",
            _ => "spirv.CL.u_min",
        };
        Self::elementwise(cr, op, operands, t, ArithSpirvOptions { no_wrap: false, ..o })
    }

    /// `ConstantCompositeOpPattern`.
    #[lowering("arith.constant")]
    fn constant_composite<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, _: &[Vec<ValueId>], o: ArithSpirvOptions) -> bool {
        let r = cr.rw.body[op].results[0];
        let src = cr.rw.body[r].ty.clone();
        let Type::Shaped(s) = &src else { return false };
        if src.element_count() == Some(1) || s.kind == ShapedKind::MemRef {
            return false;
        }
        let Some(dst) = cr.converted(&src) else { return false };
        let Some(value) = cr.rw.body[op].get("value").cloned() else { return false };
        let Some(c) = Const::try_from(&value).ok().or_else(|| cr.rw.body.resource_const(&value)) else { return false };
        let n = src.element_count().unwrap_or(0) as i64;
        let rank = s.shape.as_ref().map_or(0, Vec::len);
        let mut attr_ty = src.clone();
        if rank > 1 {
            if s.kind != ShapedKind::Tensor {
                return false;
            }
            attr_ty = Type::tensor(&[n], (*s.elem).clone());
        }
        let src_elem = (*s.elem).clone();
        let dst_elem = match mlirformat::spirv_types::SpirvType::try_from(&dst) {
            Ok(st) => st.element().cloned().unwrap_or(Type::NoneType),
            Err(()) => dst.element_type().clone(),
        };
        let mut values = c.values.clone();
        if src_elem != dst_elem {
            if src_elem == Type::I1 {
                return false;
            }
            let mut out = Vec::new();
            for i in 0..n as usize {
                out.push(match c.at(i) {
                    Scalar::Float(f) if o.emulate_floats && src_elem.bit_width() == Some(8) && matches!(dst_elem, Type::Integer { .. }) => Scalar::Int(ApInt::from_bits(8, u128::from(f.bits))),
                    Scalar::Float(f) if dst_elem == Type::Float(FloatKind::F32) => match Self::fit_f32(f) {
                        Some(g) => Scalar::Float(g),
                        None => return false,
                    },
                    Scalar::Float(_) => return false,
                    Scalar::Int(i) => match Self::fit_int(i, dst_elem.bit_width().unwrap_or(32)) {
                        Some(j) => Scalar::Int(j),
                        None => return false,
                    },
                });
            }
            values = out;
            attr_ty = match &attr_ty {
                Type::Shaped(a) => Type::Shaped(mlirformat::Shaped { elem: dst_elem.clone().into(), ..a.clone() }),
                t => t.clone(),
            };
        } else if c.is_splat() {
            values = vec![c.values[0]];
        }
        let attr: Attribute<'a> = Const { ty: attr_ty, values, elements: true }.into();
        let v = cr.spirv_const(dst, attr);
        cr.replace_values(op, &[v]);
        true
    }

    /// `ConstantScalarOpPattern`.
    #[lowering("arith.constant")]
    fn constant_scalar<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, _: &[Vec<ValueId>], o: ArithSpirvOptions) -> bool {
        let r = cr.rw.body[op].results[0];
        let mut src = cr.rw.body[r].ty.clone();
        let Some(mut value) = cr.rw.body[op].get("value").cloned() else { return false };
        if let Type::Shaped(s) = &src {
            if src.element_count() != Some(1) {
                return false;
            }
            src = (*s.elem).clone();
            let Ok(c) = Const::try_from(&value) else { return false };
            value = Const::scalar(c.at(0), src.clone()).into();
        }
        if !matches!(src, Type::Integer { .. } | Type::Index | Type::Float(_)) {
            return false;
        }
        let Some(dst) = cr.converted(&src) else { return false };
        let attr: Attribute<'a> = match (&src, Const::try_from(&value).ok().map(|c| c.at(0))) {
            (Type::Float(_), Some(Scalar::Float(f))) => {
                if o.emulate_floats && src.bit_width() == Some(8) && dst.bit_width() == Some(8) && matches!(dst, Type::Integer { .. }) {
                    Attribute::integer(i128::from(f.bits as i8), dst.clone())
                } else if src != dst {
                    if dst != Type::Float(FloatKind::F32) {
                        return false;
                    }
                    let Some(g) = Self::fit_f32(f) else { return false };
                    Const::scalar(Scalar::Float(g), dst.clone()).into()
                } else {
                    value
                }
            }
            (t, Some(Scalar::Int(i))) if *t == Type::I1 => Attribute::Bool(i.bits() != 0),
            (_, Some(Scalar::Int(i))) => match Self::fit_int(i, dst.bit_width().unwrap_or(32)) {
                Some(j) => Attribute::integer(j.signed(), dst.clone()),
                None => return false,
            },
            _ => return false,
        };
        let v = cr.spirv_const(dst, attr);
        cr.replace_values(op, &[v]);
        true
    }

    /// `emulateSignedRemainder`: `RemSIOpGLPattern` (with `spirv.CL.s_abs`) and
    /// `RemSIOpCLPattern` (with `spirv.GL.SAbs`), whichever the target allows.
    fn remsi<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], abs: &str) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let (lhs, rhs) = (ops[0], ops[1]);
        let ty = cr.rw.body[lhs].ty.clone();
        let la = cr.build(OpData::build(abs).operands(&[lhs]), ty.clone());
        let ra = cr.build(OpData::build(abs).operands(&[rhs]), ty.clone());
        let m = cr.build(OpData::build("spirv.UMod").operands(&[la, ra]), ty.clone());
        let bty = Self::bool_like(&ty);
        let pos = cr.build(OpData::build("spirv.IEqual").operands(&[lhs, la]), bty);
        let neg = cr.build(OpData::build("spirv.SNegate").operands(&[m]), ty.clone());
        let v = cr.build(OpData::build("spirv.Select").operands(&[pos, m, neg]), ty);
        cr.replace_values(op, &[v]);
        true
    }

    /// `i1` of `t`'s shape.
    fn bool_like<'a>(t: &Type<'a>) -> Type<'a> {
        match t {
            Type::Shaped(s) => Type::Shaped(mlirformat::Shaped { elem: Type::I1.into(), ..s.clone() }),
            _ => Type::I1,
        }
    }

    #[lowering("arith.remsi")]
    fn remsi_gl<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: ArithSpirvOptions) -> bool {
        Self::remsi(cr, op, operands, "spirv.CL.s_abs")
    }

    #[lowering("arith.remsi")]
    fn remsi_cl<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: ArithSpirvOptions) -> bool {
        Self::remsi(cr, op, operands, "spirv.GL.SAbs")
    }

    /// `BitwiseOpPattern`.
    #[lowering("arith.andi", "arith.ori")]
    fn bitwise<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: ArithSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let Some(dst) = Self::result_ty(cr, op) else { return false };
        let and = cr.rw.body[op].name == "arith.andi";
        let logical = Self::is_bool(&cr.rw.body[ops[0]].ty);
        let target = match (and, logical) {
            (true, true) => "spirv.LogicalAnd",
            (true, false) => "spirv.BitwiseAnd",
            (false, true) => "spirv.LogicalOr",
            (false, false) => "spirv.BitwiseOr",
        };
        let v = cr.build(OpData::build(target).operands(&ops), dst);
        cr.replace_values(op, &[v]);
        true
    }

    /// `XOrIOpLogicalPattern` / `XOrIOpBooleanPattern`.
    #[lowering("arith.xori")]
    fn xori<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: ArithSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let Some(dst) = Self::result_ty(cr, op) else { return false };
        let target = if Self::is_bool(&cr.rw.body[ops[0]].ty) { "spirv.LogicalNotEqual" } else { "spirv.BitwiseXor" };
        let v = cr.build(OpData::build(target).operands(&ops), dst);
        cr.replace_values(op, &[v]);
        true
    }

    /// `select(c, one, zero)` of type `dst`: `UIToFPI1Pattern`, `IndexCastI1IndexPattern`,
    /// `ExtUII1Pattern`.
    fn select_one_zero<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, cond: ValueId, dst: Type<'a>) -> bool {
        let zero = cr.spirv_int_like(&dst, 0);
        let one = cr.spirv_int_like(&dst, 1);
        let v = cr.build(OpData::build("spirv.Select").operands(&[cond, one, zero]), dst);
        cr.replace_values(op, &[v]);
        true
    }

    #[lowering("arith.uitofp", "arith.extui")]
    fn from_i1<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: ArithSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        if !Self::is_bool(&cr.rw.body[ops[0]].ty) {
            return false;
        }
        let Some(dst) = Self::result_ty(cr, op) else { return false };
        Self::select_one_zero(cr, op, ops[0], dst)
    }

    /// `IndexCastIndexI1Pattern`.
    #[lowering("arith.index_cast")]
    fn index_to_i1<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: ArithSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let r = cr.rw.body[op].results[0];
        if !Self::is_bool(&cr.rw.body[r].ty) {
            return false;
        }
        let Some(dst) = Self::result_ty(cr, op) else { return false };
        let in_t = cr.rw.body[ops[0]].ty.clone();
        let zero = cr.spirv_int_like(&in_t, 0);
        let v = cr.build(OpData::build("spirv.INotEqual").operands(&[zero, ops[0]]), dst);
        cr.replace_values(op, &[v]);
        true
    }

    /// `IndexCastI1IndexPattern`.
    #[lowering("arith.index_cast")]
    fn i1_to_index<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: ArithSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        if !Self::is_bool(&cr.rw.body[ops[0]].ty) {
            return false;
        }
        let Some(dst) = Self::result_ty(cr, op) else { return false };
        Self::select_one_zero(cr, op, ops[0], dst)
    }

    /// `ExtSII1Pattern`.
    #[lowering("arith.extsi")]
    fn extsi_i1<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: ArithSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        if !Self::is_bool(&cr.rw.body[ops[0]].ty) {
            return false;
        }
        let Some(dst) = Self::result_ty(cr, op) else { return false };
        let ones = Self::const_int(cr, &dst, u64::MAX);
        let zero = cr.spirv_int_like(&dst, 0);
        let v = cr.build(OpData::build("spirv.Select").operands(&[ops[0], ones, zero]), dst);
        cr.replace_values(op, &[v]);
        true
    }

    /// `ExtSIPattern`.
    #[lowering("arith.extsi")]
    fn extsi<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: ArithSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let src = cr.rw.body[ops[0]].ty.clone();
        if Self::is_bool(&src) {
            return false;
        }
        let Some(dst) = Self::result_ty(cr, op) else { return false };
        let v = if dst == src {
            let src_bw = Self::src_ty(cr, op, 0).element_type().bit_width().unwrap_or(32);
            let r = cr.rw.body[op].results[0];
            let dst_bw = cr.rw.body[r].ty.element_type().bit_width().unwrap_or(32);
            let shift = Self::const_int(cr, &dst, u64::from(dst_bw - src_bw));
            let l = cr.build(OpData::build("spirv.ShiftLeftLogical").operands(&[ops[0], shift]), dst.clone());
            cr.build(OpData::build("spirv.ShiftRightArithmetic").operands(&[l, shift]), dst)
        } else {
            cr.build(OpData::build("spirv.SConvert").operands(&ops), dst)
        };
        cr.replace_values(op, &[v]);
        true
    }

    /// `ExtUIPattern` / `TruncIPattern`: an emulated width masked, else converted.
    #[lowering("arith.extui", "arith.trunci")]
    fn ext_trunc<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: ArithSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let src = cr.rw.body[ops[0]].ty.clone();
        let Some(dst) = Self::result_ty(cr, op) else { return false };
        let ext = cr.rw.body[op].name == "arith.extui";
        if (ext && Self::is_bool(&src)) || (!ext && Self::is_bool(&dst)) {
            return false;
        }
        let v = if dst == src {
            let bw = if ext { Self::src_ty(cr, op, 0) } else { cr.rw.body[cr.rw.body[op].results[0]].ty.clone() }.element_type().bit_width().unwrap_or(32);
            let mask = Self::const_int(cr, &dst, if bw >= 64 { u64::MAX } else { (1u64 << bw) - 1 });
            cr.build(OpData::build("spirv.BitwiseAnd").operands(&[ops[0], mask]), dst)
        } else {
            cr.build(OpData::build(if ext { "spirv.UConvert" } else { "spirv.SConvert" }).operands(&ops), dst)
        };
        cr.replace_values(op, &[v]);
        true
    }

    /// `TruncII1Pattern`.
    #[lowering("arith.trunci")]
    fn trunci_i1<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: ArithSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let Some(dst) = Self::result_ty(cr, op) else { return false };
        if !Self::is_bool(&dst) {
            return false;
        }
        let src = cr.rw.body[ops[0]].ty.clone();
        let mask = cr.spirv_int_like(&src, 1);
        let masked = cr.build(OpData::build("spirv.BitwiseAnd").operands(&[ops[0], mask]), src);
        let is_one = cr.build(OpData::build("spirv.IEqual").operands(&[masked, mask]), dst.clone());
        Self::select_one_zero(cr, op, is_one, dst)
    }

    /// `TypeCastingOpPattern`.
    #[lowering("arith.extf", "arith.truncf", "arith.uitofp", "arith.sitofp", "arith.fptoui", "arith.fptosi", "arith.index_cast", "arith.index_castui", "arith.bitcast")]
    fn cast<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: ArithSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let src = cr.rw.body[ops[0]].ty.clone();
        let Some(dst) = Self::result_ty(cr, op) else { return false };
        if Self::is_bool(&src) || Self::is_bool(&dst) {
            return false;
        }
        if dst == src {
            cr.replace_values(op, &[ops[0]]);
            return true;
        }
        let target = match &*cr.rw.body[op].name {
            "arith.extf" | "arith.truncf" => "spirv.FConvert",
            "arith.uitofp" => "spirv.ConvertUToF",
            "arith.sitofp" => "spirv.ConvertSToF",
            "arith.fptoui" => "spirv.ConvertFToU",
            "arith.fptosi" => "spirv.ConvertFToS",
            "arith.index_cast" => "spirv.SConvert",
            "arith.index_castui" => "spirv.UConvert",
            _ => "spirv.Bitcast",
        };
        let mut data = OpData::build(target).operands(&ops);
        // `arith::RoundingMode`: to_nearest_even, downward, upward, toward_zero, to_nearest_away.
        if let Some(m) = cr.rw.body[op].get("roundingmode").and_then(|a| Const::try_from(a).ok()).and_then(|c| c.as_int()) {
            let mode = match m.signed() {
                0 => "RTE",
                1 => "RTN",
                2 => "RTP",
                3 => "RTZ",
                _ => return false,
            };
            data.set("fp_rounding_mode", Cr::spirv_enum("fp_rounding_mode", mode));
        }
        let v = cr.build(data, dst);
        cr.replace_values(op, &[v]);
        true
    }

    /// The `arith.cmpi` / `arith.cmpf` predicate's name.
    fn predicate(cr: &Cr<'_, '_, '_>, op: OpId, names: &[&'static str]) -> Option<&'static str> {
        let v = Const::try_from(cr.rw.body[op].get("predicate")?).ok()?.as_int()?.signed();
        names.get(v as usize).copied()
    }

    const CMPI: [&'static str; 10] = ["eq", "ne", "slt", "sle", "sgt", "sge", "ult", "ule", "ugt", "uge"];
    const CMPF: [&'static str; 16] = ["false", "oeq", "ogt", "oge", "olt", "ole", "one", "ord", "ueq", "ugt", "uge", "ult", "ule", "une", "uno", "true"];

    /// `CmpIOpBooleanPattern`.
    #[lowering("arith.cmpi")]
    fn cmpi_bool<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: ArithSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let src = Self::src_ty(cr, op, 0);
        if !Self::is_bool(&src) {
            return false;
        }
        let Some(dst) = cr.converted(&src) else { return false };
        let Some(p) = Self::predicate(cr, op, &Self::CMPI) else { return false };
        let target = match p {
            "eq" => "spirv.LogicalEqual",
            "ne" => "spirv.LogicalNotEqual",
            "uge" | "ugt" | "ule" | "ult" => {
                let ty = match &dst {
                    Type::Shaped(s) => Type::Shaped(mlirformat::Shaped { elem: Type::int(32).into(), ..s.clone() }),
                    _ => Type::int(32),
                };
                let l = cr.build(OpData::build("arith.extui").operands(&[ops[0]]), ty.clone());
                let r = cr.build(OpData::build("arith.extui").operands(&[ops[1]]), ty);
                let pred = cr.rw.body[op].get("predicate").cloned().unwrap_or(Attribute::Unit);
                let v = cr.build(OpData::build("arith.cmpi").operands(&[l, r]).with("predicate", pred), Self::bool_like(&dst));
                cr.replace_values(op, &[v]);
                return true;
            }
            _ => return false,
        };
        let v = cr.build(OpData::build(target).operands(&ops), Self::bool_like(&dst));
        cr.replace_values(op, &[v]);
        true
    }

    /// `CmpIOpPattern`.
    #[lowering("arith.cmpi")]
    fn cmpi<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: ArithSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let src = Self::src_ty(cr, op, 0);
        if Self::is_bool(&src) {
            return false;
        }
        let Some(dst) = cr.converted(&src) else { return false };
        let Some(p) = Self::predicate(cr, op, &Self::CMPI) else { return false };
        let target = match p {
            "eq" => "spirv.IEqual",
            "ne" => "spirv.INotEqual",
            "slt" => "spirv.SLessThan",
            "sle" => "spirv.SLessThanEqual",
            "sgt" => "spirv.SGreaterThan",
            "sge" => "spirv.SGreaterThanEqual",
            "ult" => "spirv.ULessThan",
            "ule" => "spirv.ULessThanEqual",
            "ugt" => "spirv.UGreaterThan",
            _ => "spirv.UGreaterThanEqual",
        };
        let same_bw = src.bit_width().zip(dst.bit_width()).is_some_and(|(a, b)| a == b) || (src.element_count().is_some() && src.element_type().bit_width() == dst.element_type().bit_width());
        if OpSpec::of(target).is_some_and(|s| s.unsigned) && *src.element_type() != Type::Index && src != dst && !same_bw {
            return false;
        }
        let v = cr.build(OpData::build(target).operands(&ops), Self::bool_like(&dst));
        cr.replace_values(op, &[v]);
        true
    }

    /// `CmpFOpNanKernelPattern` (benefit 2: registered before the others, it is tried first
    /// and kept where the target has `spirv.Ordered`), then `CmpFOpNanNonePattern` and
    /// `CmpFOpPattern`.
    #[lowering("arith.cmpf")]
    fn cmpf_kernel<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: ArithSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let target = match Self::predicate(cr, op, &Self::CMPF) {
            Some("ord") => "spirv.Ordered",
            Some("uno") => "spirv.Unordered",
            _ => return false,
        };
        let ty = Self::bool_like(&cr.rw.body[ops[0]].ty);
        let v = cr.build(OpData::build(target).operands(&ops), ty);
        cr.replace_values(op, &[v]);
        true
    }

    #[lowering("arith.cmpf")]
    fn cmpf_nan<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: ArithSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let ord = match Self::predicate(cr, op, &Self::CMPF) {
            Some("ord") => true,
            Some("uno") => false,
            _ => return false,
        };
        let ty = Self::bool_like(&cr.rw.body[ops[0]].ty);
        let v = if Self::fastmath_nnan(cr, op) {
            cr.spirv_int_like(&ty, i64::from(ord))
        } else {
            let l = cr.build(OpData::build("spirv.IsNan").operands(&[ops[0]]), ty.clone());
            let rr = cr.build(OpData::build("spirv.IsNan").operands(&[ops[1]]), ty.clone());
            let any = cr.build(OpData::build("spirv.LogicalOr").operands(&[l, rr]), ty.clone());
            if ord { cr.build(OpData::build("spirv.LogicalNot").operands(&[any]), ty) } else { any }
        };
        cr.replace_values(op, &[v]);
        true
    }

    #[lowering("arith.cmpf")]
    fn cmpf<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: ArithSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let target = match Self::predicate(cr, op, &Self::CMPF) {
            Some("oeq") => "spirv.FOrdEqual",
            Some("ogt") => "spirv.FOrdGreaterThan",
            Some("oge") => "spirv.FOrdGreaterThanEqual",
            Some("olt") => "spirv.FOrdLessThan",
            Some("ole") => "spirv.FOrdLessThanEqual",
            Some("one") => "spirv.FOrdNotEqual",
            Some("ueq") => "spirv.FUnordEqual",
            Some("ugt") => "spirv.FUnordGreaterThan",
            Some("uge") => "spirv.FUnordGreaterThanEqual",
            Some("ult") => "spirv.FUnordLessThan",
            Some("ule") => "spirv.FUnordLessThanEqual",
            Some("une") => "spirv.FUnordNotEqual",
            _ => return false,
        };
        let ty = Self::bool_like(&cr.rw.body[ops[0]].ty);
        let v = cr.build(OpData::build(target).operands(&ops), ty);
        cr.replace_values(op, &[v]);
        true
    }

    /// `AddUIExtendedOpPattern`.
    #[lowering("arith.addui_extended")]
    fn addui_extended<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: ArithSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let ty = cr.rw.body[ops[0]].ty.clone();
        let st = Self::pair_struct(&ty);
        let res = cr.build(OpData::build("spirv.IAddCarry").operands(&ops), st);
        let sum = Self::extract(cr, res, 0, ty.clone());
        let carry = Self::extract(cr, res, 1, ty.clone());
        let one = cr.spirv_int_like(&ty, 1);
        let c = cr.build(OpData::build("spirv.IEqual").operands(&[carry, one]), Self::bool_like(&ty));
        cr.replace_values(op, &[sum, c]);
        true
    }

    /// `!spirv.struct<(T, T)>`.
    fn pair_struct<'a>(t: &Type<'a>) -> Type<'a> {
        let m = |ty: &Type<'a>| mlirformat::spirv_types::SpirvMember { ty: ty.clone(), offset: None, decorations: Vec::new() };
        mlirformat::spirv_types::SpirvType::Struct { name: None, members: Some(vec![m(t), m(t)]), decorations: Vec::new() }.into()
    }

    fn extract<'a>(cr: &mut Cr<'_, 'a, '_>, v: ValueId, i: i64, ty: Type<'a>) -> ValueId {
        cr.build(OpData::build("spirv.CompositeExtract").operands(&[v]).with("indices", Attribute::Array(vec![Attribute::integer(i128::from(i), Type::int(32))])), ty)
    }

    /// `MulIExtendedOpPattern`.
    #[lowering("arith.mulsi_extended", "arith.mului_extended")]
    fn mul_extended<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: ArithSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let ty = cr.rw.body[ops[0]].ty.clone();
        let target = if cr.rw.body[op].name == "arith.mulsi_extended" { "spirv.SMulExtended" } else { "spirv.UMulExtended" };
        let res = cr.build(OpData::build(target).operands(&ops), Self::pair_struct(&ty));
        let lo = Self::extract(cr, res, 0, ty.clone());
        let hi = Self::extract(cr, res, 1, ty);
        cr.replace_values(op, &[lo, hi]);
        true
    }

    /// `SelectOpPattern`.
    #[lowering("arith.select")]
    fn select<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: ArithSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let ty = cr.rw.body[ops[1]].ty.clone();
        let v = cr.build(OpData::build("spirv.Select").operands(&ops), ty);
        cr.replace_values(op, &[v]);
        true
    }

    /// `MinimumMaximumFOpPattern` / `MinNumMaxNumFOpPattern` into `target`; `guard`: NaN
    /// guards (`nan_first`: a NaN operand wins, as `minimumf` / `maximumf` want).
    fn min_max<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], target: &str, guard: bool, nan_first: bool) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let Some(dst) = Self::result_ty(cr, op) else { return false };
        let v = cr.build(OpData::build(target).operands(&ops), dst.clone());
        if !guard || Self::fastmath_nnan(cr, op) {
            cr.replace_values(op, &[v]);
            return true;
        }
        let bty = Self::bool_like(&dst);
        let ln = cr.build(OpData::build("spirv.IsNan").operands(&[ops[0]]), bty.clone());
        let rn = cr.build(OpData::build("spirv.IsNan").operands(&[ops[1]]), bty);
        let (a, b) = if nan_first { (ops[0], ops[1]) } else { (ops[1], ops[0]) };
        let s1 = cr.build(OpData::build("spirv.Select").operands(&[ln, a, v]), dst.clone());
        let s2 = cr.build(OpData::build("spirv.Select").operands(&[rn, b, s1]), dst);
        cr.replace_values(op, &[s2]);
        true
    }

    #[lowering("arith.maximumf", "arith.minimumf")]
    fn minimum_maximum_gl<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: ArithSpirvOptions) -> bool {
        let t = if cr.rw.body[op].name == "arith.maximumf" { "spirv.GL.FMax" } else { "spirv.GL.FMin" };
        Self::min_max(cr, op, operands, t, true, true)
    }

    #[lowering("arith.maxnumf", "arith.minnumf")]
    fn minnum_maxnum_gl<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: ArithSpirvOptions) -> bool {
        let t = if cr.rw.body[op].name == "arith.maxnumf" { "spirv.GL.FMax" } else { "spirv.GL.FMin" };
        Self::min_max(cr, op, operands, t, true, false)
    }

    #[lowering("arith.maximumf", "arith.minimumf")]
    fn minimum_maximum_cl<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: ArithSpirvOptions) -> bool {
        let t = if cr.rw.body[op].name == "arith.maximumf" { "spirv.CL.fmax" } else { "spirv.CL.fmin" };
        Self::min_max(cr, op, operands, t, true, true)
    }

    #[lowering("arith.maxnumf", "arith.minnumf")]
    fn minnum_maxnum_cl<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: ArithSpirvOptions) -> bool {
        let t = if cr.rw.body[op].name == "arith.maxnumf" { "spirv.CL.fmax" } else { "spirv.CL.fmin" };
        Self::min_max(cr, op, operands, t, false, false)
    }
}
