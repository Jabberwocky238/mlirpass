//! `tosa`: folds and constants, as `TosaCanonicalizations.cpp` and `TosaOps.cpp`.

use alloc::vec::Vec;

use mlirformat::{Attribute, Dim, FloatKind, Signedness, Type, UniformQuantized};

use crate::patterns::Broadcast;
use crate::{ApFloat, ApInt, Body, Const, Fold, Folded, OpData, OpId, Scalar, ValueId};

/// `kInferableDimSize`: a slice size taking the rest of the dim.
const INFERABLE_DIM: i64 = -1;

/// The integer folds of the shape ops (`*FoldAdaptor`), on index elements.
#[derive(Clone, Copy)]
enum ShapeFold {
    Add,
    Sub,
    Mul,
    DivCeil,
    DivFloor,
    Mod,
    Max,
    Min,
    Exp2,
    Log2Ceil,
    Log2Floor,
}

impl ShapeFold {
    /// `DivFoldAdaptor<ceil>`: the quotient, rounded up when `ceil` and the exact one is positive.
    fn div(a: ApInt, b: ApInt, unsigned: bool, ceil: bool) -> Option<ApInt> {
        if b.is_zero() {
            return None;
        }
        let one = ApInt::new(a.width, 1);
        if unsigned {
            let (q, r) = (a.udiv(b)?, a.urem(b)?);
            return Some(if ceil && !r.is_zero() { q.add(one) } else { q });
        }
        let (q, overflow) = a.sdiv_ov(b)?;
        if overflow {
            return None;
        }
        let r = a.srem(b)?;
        Some(if ceil && !r.is_zero() && a.is_negative() == b.is_negative() { q.add(one) } else { q })
    }

    /// Two operands (signed).
    fn binary(self, a: ApInt, b: ApInt) -> Option<ApInt> {
        let ov = |(r, o): (ApInt, bool)| (!o).then_some(r);
        match self {
            ShapeFold::Add => ov(a.sadd_ov(b)),
            ShapeFold::Sub => ov(a.ssub_ov(b)),
            ShapeFold::Mul if a.is_zero() || b.is_zero() => Some(ApInt::zero(a.width)),
            ShapeFold::Mul => ov(a.smul_ov(b)),
            ShapeFold::DivCeil | ShapeFold::DivFloor if a.is_negative() || b.is_negative() || b.is_zero() => None,
            ShapeFold::DivCeil => Self::div(a, b, false, true),
            ShapeFold::DivFloor => Self::div(a, b, false, false),
            ShapeFold::Mod if a.is_negative() || b.is_negative() || b.is_zero() => None,
            ShapeFold::Mod => a.srem(b),
            ShapeFold::Max => Some(if a.signed() >= b.signed() { a } else { b }),
            ShapeFold::Min => Some(if a.signed() <= b.signed() { a } else { b }),
            _ => None,
        }
    }

    /// One operand (signed).
    fn unary(self, v: ApInt) -> Option<ApInt> {
        let bits = v.width;
        match self {
            ShapeFold::Exp2 if v.is_negative() || v.signed() >= i128::from(bits) => None,
            ShapeFold::Exp2 => Some(ApInt::new(bits, 1).shl(v.signed() as u32)),
            ShapeFold::Log2Ceil | ShapeFold::Log2Floor if v.is_negative() || v.is_zero() => None,
            ShapeFold::Log2Floor => Some(ApInt::new(bits, i128::from(v.log2()))),
            ShapeFold::Log2Ceil => Some(ApInt::new(bits, i128::from(if v.is_one() { 0 } else { bits - v.sub(ApInt::new(bits, 1)).count_leading_zeros() }))),
            _ => None,
        }
    }
}

/// One fold: the op, its operands' constants.
struct Tf<'b, 'c, 'a> {
    b: &'b mut Body<'a>,
    op: OpId,
    c: &'c [Option<Attribute<'a>>],
}

impl<'a> Tf<'_, '_, 'a> {
    fn operand(&self, i: usize) -> ValueId {
        self.b[self.op].operands[i]
    }

    fn ty(&self, v: ValueId) -> Type<'a> {
        self.b[v].ty.clone()
    }

    fn result_ty(&self) -> Type<'a> {
        self.ty(self.b[self.op].results[0])
    }

    /// Operand `i` as a `DenseElementsAttr`.
    fn dense(&self, i: usize) -> Option<Const<'a>> {
        Const::try_from(self.c.get(i)?.as_ref()?).ok().filter(|k| k.elements)
    }

    /// `isSplat` (every element the same) and that element.
    fn splat(k: &Const<'_>) -> Option<Scalar> {
        let first = *k.values.first()?;
        k.values.iter().all(|v| *v == first).then_some(first)
    }

    /// A `RankedTensorType`'s dims (dynamic as `None`).
    fn dims(t: &Type<'_>) -> Option<Vec<Option<i64>>> {
        Some(t.shape()?.iter().map(|d| if let Dim::Static(n) = d { Some(*n) } else { None }).collect())
    }

    /// `getStorageElementTypeFromQuantized` of a `!quant.uniform` element type (its storage
    /// type, unsigned for `u`), else the type itself.
    fn storage(t: &Type<'a>) -> Type<'a> {
        UniformQuantized::try_from(t).map_or_else(|()| t.clone(), |q| q.storage_type())
    }

    /// The elements of constant `v` as integers (`m_Constant` of a `DenseIntElementsAttr`).
    fn ints_of(b: &Body<'a>, v: ValueId) -> Option<Vec<i64>> {
        Const::try_from(&b.constant_of(v)?).ok().filter(|k| k.elements)?.ints()
    }

    fn is_static(t: &Type<'_>) -> bool {
        Self::dims(t).is_some_and(|d| d.iter().all(Option::is_some))
    }

    /// A ranked type's dims, dynamic as [`Dim::DYNAMIC`].
    fn dims64(t: &Type<'_>) -> Option<Vec<i64>> {
        Some(Self::dims(t)?.into_iter().map(|d| d.unwrap_or(Dim::DYNAMIC)).collect())
    }

    /// `staticallyKnownBroadcastable` of the ranked types of `vs`.
    fn broadcastable(&self, vs: &[ValueId]) -> bool {
        let shapes: Option<Vec<Vec<i64>>> = vs.iter().map(|v| Self::dims64(&self.b[*v].ty)).collect();
        shapes.is_some_and(|s| Broadcast::known(&s))
    }

    /// `foldToInputIfTypeMatches`.
    fn input_if_same(&self, input: ValueId) -> Fold<'a> {
        if self.b[input].ty == self.result_ty() { Self::value(input) } else { Fold::Failed }
    }

    /// Whether `t`'s element type is an unsigned integer.
    fn unsigned(t: &Type<'_>) -> bool {
        matches!(t.element_type(), Type::Integer { signedness: Signedness::Unsigned, .. })
    }

    fn int_attr(&self, name: &str) -> Option<i64> {
        match self.b[self.op].get(name)? {
            Attribute::Int { lit, .. } => lit.parse().ok(),
            _ => None,
        }
    }

    fn value(v: ValueId) -> Fold<'a> {
        Folded::Value(v).into()
    }

    fn attr(k: Const<'a>) -> Fold<'a> {
        Folded::Attr(k.into()).into()
    }

    fn splat_of(s: Scalar, ty: Type<'a>) -> Fold<'a> {
        Self::attr(Const::splat(s, ty))
    }

    /// `isSplatZero`.
    fn splat_zero(k: Option<&Const<'_>>) -> bool {
        match k.and_then(Self::splat) {
            Some(Scalar::Int(i)) => i.is_zero(),
            Some(Scalar::Float(f)) => f.is_zero(),
            _ => false,
        }
    }

    /// `isSplatOne`, `1 << shift` for integers.
    fn splat_one(k: Option<&Const<'_>>, shift: i64) -> bool {
        match k.and_then(Self::splat) {
            Some(Scalar::Int(i)) => i.signed() == 1i128 << shift,
            Some(Scalar::Float(f)) => f.to_f64() == 1.0,
            _ => false,
        }
    }

    /// `binaryFolder`: two splats of the same element type through `int` (given whether it is
    /// unsigned) / `float`, into a static result.
    fn binary(&self, ty: Type<'a>, int: impl Fn(ApInt, ApInt, bool) -> Option<Scalar>, float: impl Fn(ApFloat, ApFloat) -> Option<Scalar>) -> Fold<'a> {
        let (Some(l), Some(r)) = (self.dense(0), self.dense(1)) else { return Fold::Failed };
        if !Self::is_static(&ty) || l.ty.element_type() != r.ty.element_type() {
            return Fold::Failed;
        }
        let (Some(ls), Some(rs)) = (Self::splat(&l), Self::splat(&r)) else { return Fold::Failed };
        let unsigned = Self::unsigned(&l.ty);
        let s = match (ls, rs) {
            (Scalar::Int(a), Scalar::Int(b)) => int(a, b, unsigned),
            (Scalar::Float(a), Scalar::Float(b)) => float(a, b),
            _ => None,
        };
        s.map_or(Fold::Failed, |s| Self::splat_of(s, ty))
    }

    /// A comparison's `i1`.
    fn bool(b: bool) -> Option<Scalar> {
        Some(Scalar::Int(ApInt::new(1, i128::from(b))))
    }

    fn fold(self) -> Fold<'a> {
        let name = alloc::string::String::from(self.b[self.op].name.strip_prefix("tosa.").unwrap_or(""));
        match name.as_str() {
            "const" | "const_shape" => self.b[self.op].get("values").cloned().map_or(Fold::Failed, |a| Folded::Attr(a).into()),
            "add" | "sub" => self.add_sub(name == "add"),
            "mul" => self.mul(),
            "intdiv" => self.int_div(),
            "greater" => self.binary(self.result_ty(), |a, b, u| Self::bool(if u { a.ucmp(b) } else { a.scmp(b) }.is_gt()), |a, b| Self::bool(a.compare(b) == Some(core::cmp::Ordering::Greater))),
            "greater_equal" => self.binary(self.result_ty(), |a, b, u| Self::bool(if u { a.ucmp(b) } else { a.scmp(b) }.is_ge()), |a, b| Self::bool(matches!(a.compare(b), Some(core::cmp::Ordering::Greater | core::cmp::Ordering::Equal)))),
            "equal" => self.equal(),
            "cast" => self.cast(),
            "reduce_all" | "reduce_any" | "reduce_max" | "reduce_min" | "reduce_product" | "reduce_sum" => self.reduce(),
            "reshape" => self.reshape(),
            "pad" => self.pad(),
            "resize" => self.resize(),
            "reverse" => self.reverse(),
            "slice" => self.slice(),
            "select" => self.select(),
            "tile" => self.tile(),
            "transpose" => self.transpose(),
            "negate" => self.negate(),
            "abs" => {
                let input = self.operand(0);
                if self.b.def_named(input, "tosa.abs").is_some() { self.input_if_same(input) } else { Fold::Failed }
            }
            "reciprocal" => self.reciprocal(),
            "argmax" => self.argmax(),
            "dim" => self.dim(),
            "add_shape" => self.shape_binary(ShapeFold::Add),
            "sub_shape" => self.shape_binary(ShapeFold::Sub),
            "mul_shape" => self.shape_binary(ShapeFold::Mul),
            "div_ceil_shape" => self.shape_binary(ShapeFold::DivCeil),
            "div_floor_shape" => self.shape_binary(ShapeFold::DivFloor),
            "mod_shape" => self.shape_binary(ShapeFold::Mod),
            "max_shape" => self.shape_binary(ShapeFold::Max),
            "min_shape" => self.shape_binary(ShapeFold::Min),
            "exp2_shape" => self.shape_unary(ShapeFold::Exp2),
            "log2_ceil_shape" => self.shape_unary(ShapeFold::Log2Ceil),
            "log2_floor_shape" => self.shape_unary(ShapeFold::Log2Floor),
            "concat_shape" => self.concat_shape(),
            "slice_shape" => self.slice_shape(),
            _ => Fold::Failed,
        }
    }

    /// `AddOp::fold`, `SubOp::fold`.
    fn add_sub(&self, add: bool) -> Fold<'a> {
        let (lt, rt, ty) = (self.ty(self.operand(0)), self.ty(self.operand(1)), self.result_ty());
        if Self::dims(&lt).is_none() || Self::dims(&rt).is_none() || Self::dims(&ty).is_none() {
            return Fold::Failed;
        }
        let bc = self.broadcastable(&[self.operand(0), self.operand(1)]);
        if bc && lt == ty && Self::splat_zero(self.dense(1).as_ref()) {
            return Self::value(self.operand(0));
        }
        if add && bc && rt == ty && Self::splat_zero(self.dense(0).as_ref()) {
            return Self::value(self.operand(1));
        }
        let ov = |(r, o): (ApInt, bool)| (!o).then_some(Scalar::Int(r));
        if add {
            self.binary(ty, |a, b, u| ov(if u { a.uadd_ov(b) } else { a.sadd_ov(b) }), |a, b| Some(Scalar::Float(a.add(b))))
        } else {
            self.binary(ty, |a, b, u| ov(if u { a.usub_ov(b) } else { a.ssub_ov(b) }), |a, b| Some(Scalar::Float(a.sub(b))))
        }
    }

    /// `MulOp::fold`, with `shift` for i32 results.
    fn mul(&self) -> Fold<'a> {
        let (lt, rt, ty) = (self.ty(self.operand(0)), self.ty(self.operand(1)), self.result_ty());
        if Self::dims(&lt).is_none() || Self::dims(&rt).is_none() || Self::dims(&ty).is_none() {
            return Fold::Failed;
        }
        let elem = ty.element_type().clone();
        let mut shift = 0i64;
        if matches!(elem, Type::Integer { width: 32, .. }) && self.b[self.op].operands.len() > 2 {
            let Some(s) = self.dense(2) else { return Fold::Failed };
            shift = s.values.first().and_then(|v| v.int()).map_or(0, |i| i.signed() as i64);
        }
        let (l, r) = (self.dense(0), self.dense(1));
        if rt == ty && Self::splat_zero(l.as_ref()) && Self::is_static(&ty) {
            return Self::splat_of(l.as_ref().and_then(Self::splat).expect("a splat"), ty);
        }
        if lt == ty && Self::splat_zero(r.as_ref()) && Self::is_static(&ty) {
            return Self::splat_of(r.as_ref().and_then(Self::splat).expect("a splat"), ty);
        }
        let bc = self.broadcastable(&[self.operand(0), self.operand(1)]);
        if bc && rt == ty && Self::splat_one(l.as_ref(), shift) {
            return Self::value(self.operand(1));
        }
        if bc && lt == ty && Self::splat_one(r.as_ref(), shift) {
            return Self::value(self.operand(0));
        }
        let (Some(l), Some(r)) = (l, r) else { return Fold::Failed };
        let (Some(ls), Some(rs)) = (Self::splat(&l), Self::splat(&r)) else { return Fold::Failed };
        let s = match (ls, rs) {
            (Scalar::Int(a), Scalar::Int(b)) if shift == 0 => Some(Scalar::Int(a.mul(b))),
            (Scalar::Int(a), Scalar::Int(b)) => {
                let w = elem.int_width().map_or(32, |w| w.0);
                let p = a.signed() * b.signed();
                if i64::try_from(p).is_err() {
                    return Fold::Failed;
                }
                let mut p = p + (1i128 << (shift - 1));
                p >>= shift;
                (i128::from(i32::MIN)..=i128::from(i32::MAX)).contains(&p).then(|| Scalar::Int(ApInt::new(w, p)))
            }
            (Scalar::Float(a), Scalar::Float(b)) => Some(Scalar::Float(a.mul(b))),
            _ => None,
        };
        s.map_or(Fold::Failed, |s| Self::splat_of(s, ty))
    }

    /// `IntDivOp::fold`.
    fn int_div(&self) -> Fold<'a> {
        let (lt, rt, ty) = (self.ty(self.operand(0)), self.ty(self.operand(1)), self.result_ty());
        if Self::dims(&ty).is_none() || Self::dims(&lt).is_none() || Self::dims(&rt).is_none() || lt.element_type() != rt.element_type() {
            return Fold::Failed;
        }
        let (l, r) = (self.dense(0), self.dense(1));
        let (ls, rs) = (l.as_ref().and_then(Self::splat), r.as_ref().and_then(Self::splat));
        if let (Some(Scalar::Int(z)), Some(Scalar::Int(d))) = (ls, rs)
            && Self::is_static(&ty)
            && z.is_zero()
            && !d.is_zero()
        {
            return Self::splat_of(Scalar::Int(z), ty);
        }
        if let Some(Scalar::Int(o)) = rs
            && o.is_one()
            && lt == ty
            && self.broadcastable(&[self.operand(0), self.operand(1)])
        {
            return Self::value(self.operand(0));
        }
        match (ls, rs) {
            (Some(Scalar::Int(a)), Some(Scalar::Int(b))) if !b.is_zero() => ShapeFold::div(a, b, Self::unsigned(&ty), false).map_or(Fold::Failed, |q| Self::splat_of(Scalar::Int(q), ty)),
            _ => Fold::Failed,
        }
    }

    /// `EqualOp::fold`.
    fn equal(&self) -> Fold<'a> {
        let ty = self.result_ty();
        let lt = self.ty(self.operand(0));
        if matches!(lt.element_type(), Type::Integer { .. }) && Self::is_static(&ty) && self.operand(0) == self.operand(1) {
            return Self::splat_of(Scalar::Int(ApInt::new(1, 1)), ty);
        }
        self.binary(ty, |a, b, _| Self::bool(a == b), |a, b| Self::bool(a.compare(b) == Some(core::cmp::Ordering::Equal)))
    }

    /// `CastOp::fold`: the same type, or a splat converted.
    fn cast(&self) -> Fold<'a> {
        let (input, ty) = (self.operand(0), self.result_ty());
        let it = self.ty(input);
        if it == ty {
            return Self::value(input);
        }
        if !Self::is_static(&ty) {
            return Fold::Failed;
        }
        let Some(s) = self.dense(0).as_ref().and_then(Self::splat) else { return Fold::Failed };
        let (ie, oe) = (it.element_type().clone(), ty.element_type().clone());
        let out = match (s, &ie, &oe) {
            (Scalar::Float(f), _, Type::Float(k)) => f.convert(*k).map(Scalar::Float),
            (Scalar::Int(i), Type::Integer { signedness, .. }, Type::Float(k)) => {
                let x = if *signedness == Signedness::Unsigned { i.unsigned() as f64 } else { i.signed() as f64 };
                let f = if *k == FloatKind::F32 {
                    let y = if *signedness == Signedness::Unsigned { i.unsigned() as f32 } else { i.signed() as f32 };
                    ApFloat::from_bits(*k, u64::from(y.to_bits()))
                } else {
                    ApFloat::from_f64(*k, x)
                };
                f.map(Scalar::Float)
            }
            (Scalar::Float(f), _, Type::Integer { width, .. }) => {
                let x = f.to_f64();
                x.is_finite().then(|| Scalar::Int(ApInt::new(*width, libm::rint(x) as i128)))
            }
            (Scalar::Int(i), Type::Integer { width: iw, signedness }, Type::Integer { width: ow, .. }) => Some(Scalar::Int(if *ow == 1 {
                ApInt::new(1, i128::from(!i.is_zero()))
            } else if iw > ow {
                i.trunc(*ow)
            } else if *signedness == Signedness::Unsigned || *iw == 1 {
                i.zext(*ow)
            } else {
                i.sext(*ow)
            })),
            _ => None,
        };
        out.map_or(Fold::Failed, |s| Self::splat_of(s, ty))
    }

    /// `REDUCE_FOLDER`.
    fn reduce(&self) -> Fold<'a> {
        let (input, ty) = (self.operand(0), self.result_ty());
        let it = self.ty(input);
        let Some(dims) = Self::dims(&it) else { return Fold::Failed };
        if it != ty {
            return Fold::Failed;
        }
        let axis = self.int_attr("axis").unwrap_or(0) as usize;
        if dims.is_empty() || dims.get(axis) == Some(&Some(1)) { Self::value(input) } else { Fold::Failed }
    }

    /// `ReshapeOp::fold`.
    fn reshape(self) -> Fold<'a> {
        let (input, ty) = (self.operand(0), self.result_ty());
        let it = self.ty(input);
        let (Some(id), Some(_)) = (Self::dims(&it), Self::dims(&ty)) else { return Fold::Failed };
        if it == ty && id.iter().filter(|d| d.is_none()).count() < 2 {
            return Self::value(input);
        }
        if let Some(inner) = self.b.def_named(input, "tosa.reshape") {
            let src = self.b[inner].operands[0];
            self.b.set_operand(self.op, 0, src);
            return Fold::InPlace;
        }
        let Some(k) = self.dense(0) else { return Fold::Failed };
        if !Self::is_static(&ty) {
            return Fold::Failed;
        }
        if let Some(s) = Self::splat(&k) {
            return Self::splat_of(s, ty);
        }
        if self.b[input].uses.len() != 1 {
            return Fold::Failed;
        }
        Self::attr(Const { ty, ..k })
    }

    /// `PadOp::fold`: a zero padding.
    fn pad(&self) -> Fold<'a> {
        let (input, ty) = (self.operand(0), self.result_ty());
        if self.ty(input) == ty && matches!(self.dense(1).as_ref().and_then(Self::splat), Some(Scalar::Int(i)) if i.is_zero()) {
            return Self::value(input);
        }
        Fold::Failed
    }

    /// `ResizeOp::fold`: unit scaling, no offset, no border.
    fn resize(&self) -> Fold<'a> {
        let ints = |i: usize| self.dense(i)?.ints();
        let (Some(scale), Some(offset), Some(border)) = (ints(1), ints(2), ints(3)) else { return Fold::Failed };
        if scale.len() != 4 || offset.len() != 2 || border.len() != 2 || scale[0] != scale[1] || scale[2] != scale[3] || offset.iter().chain(&border).any(|x| *x != 0) {
            return Fold::Failed;
        }
        let input = self.operand(0);
        if self.ty(input) == self.result_ty() { Self::value(input) } else { Fold::Failed }
    }

    /// `ReverseOp::fold`.
    fn reverse(&self) -> Fold<'a> {
        let input = self.operand(0);
        let splat = self.dense(0).as_ref().and_then(Self::splat).is_some();
        let axis = self.int_attr("axis").unwrap_or(0) as usize;
        match Self::dims(&self.ty(input)) {
            Some(d) if splat || d.get(axis) == Some(&Some(1)) => self.input_if_same(input),
            _ => Fold::Failed,
        }
    }

    /// `SliceOp::fold`.
    fn slice(&self) -> Fold<'a> {
        let (input, ty) = (self.operand(0), self.result_ty());
        let it = self.ty(input);
        let (Some(_), Some(od)) = (Self::dims(&it), Self::dims(&ty)) else { return Fold::Failed };
        if it == ty && Self::is_static(&it) {
            return Self::value(input);
        }
        // A slice of everything from the start.
        let Some(start) = Self::ints_of(self.b, self.operand(1)) else { return Fold::Failed };
        if start.iter().all(|s| *s == 0) {
            let Some(size) = Self::ints_of(self.b, self.operand(2)) else { return Fold::Failed };
            let id = Self::dims(&it).unwrap_or_default();
            if size.iter().enumerate().all(|(i, s)| *s == INFERABLE_DIM || id.get(i).copied().flatten() == Some(*s)) {
                return Self::value(input);
            }
        }
        let Some(k) = self.dense(0) else { return Fold::Failed };
        if let Some(s) = Self::splat(&k)
            && Self::is_static(&ty)
        {
            return Self::splat_of(s, ty);
        }
        if Self::is_static(&it) && Self::is_static(&ty) && od.iter().map(|d| d.unwrap_or(0)).product::<i64>() == 1 {
            let Some(shape) = Self::dims(&it) else { return Fold::Failed };
            let mut index = 0i64;
            for (s, d) in start.iter().zip(&shape) {
                index = index * d.unwrap_or(1) + s;
            }
            return Self::splat_of(k.at(index as usize), ty);
        }
        Fold::Failed
    }

    /// `SelectOp::fold`, when no operand needs broadcasting.
    fn select(&self) -> Fold<'a> {
        let ops = self.b[self.op].operands.clone();
        if ops.iter().any(|v| Self::dims(&self.b[*v].ty).is_none()) {
            return Fold::Failed;
        }
        let (pred, on_true, on_false, ty) = (ops[0], ops[1], ops[2], self.result_ty());
        if on_true == on_false && self.b[on_true].ty == ty && self.broadcastable(&[pred, on_true]) {
            return Self::value(on_true);
        }
        let Some(Scalar::Int(p)) = self.dense(0).as_ref().and_then(Self::splat) else { return Fold::Failed };
        let chosen = if p.is_zero() { on_false } else { on_true };
        if self.b[chosen].ty == ty && self.broadcastable(&ops) { Self::value(chosen) } else { Fold::Failed }
    }

    /// `TileOp::fold`: every multiple 1.
    fn tile(&self) -> Fold<'a> {
        let input = self.operand(0);
        if self.ty(input) != self.result_ty() {
            return Fold::Failed;
        }
        match self.dense(1) {
            Some(m) if m.values.iter().all(|v| v.int().is_some_and(|i| i.signed() == 1)) => Self::value(input),
            _ => Fold::Failed,
        }
    }

    /// `TransposeOp::fold`: a splat reshaped, or the identity.
    fn transpose(&self) -> Fold<'a> {
        let (input, ty) = (self.operand(0), self.result_ty());
        if let Some(k) = self.dense(0)
            && let Some(s) = Self::splat(&k)
            && Self::is_static(&ty)
            && k.ty.element_type() == ty.element_type()
        {
            return Self::splat_of(s, ty);
        }
        let perms: Vec<i64> = match self.b[self.op].get("perms") {
            Some(Attribute::DenseArray { values, .. }) => values.iter().filter_map(|v| v.parse().ok()).collect(),
            _ => return Fold::Failed,
        };
        if perms.iter().enumerate().all(|(i, p)| *p == i as i64) { self.input_if_same(input) } else { Fold::Failed }
    }

    /// A constant single zero.
    fn zero_point(&self, v: ValueId) -> bool {
        let Some(a) = self.b.constant_of(v) else { return false };
        Const::try_from(&a).ok().is_some_and(|k| k.values.iter().all(|s| match s {
            Scalar::Int(i) => i.is_zero(),
            Scalar::Float(f) => f.is_zero(),
            Scalar::Complex(..) | Scalar::ComplexFloat(..) | Scalar::Wide(_) => false,
        }))
    }

    /// `NegateOp::fold`: `negate(negate(x))`, every zero point 0.
    fn negate(&self) -> Fold<'a> {
        let Some(inner) = self.b.def_named(self.operand(0), "tosa.negate") else { return Fold::Failed };
        let zps = self.b[self.op].operands[1..].iter().chain(&self.b[inner].operands[1..]);
        if zps.clone().count() != 4 || !zps.into_iter().all(|v| self.zero_point(*v)) {
            return Fold::Failed;
        }
        self.input_if_same(self.b[inner].operands[0])
    }

    /// The `values` of `v`'s `tosa.const_shape`.
    fn shape_values(&self, v: ValueId) -> Option<Const<'a>> {
        let def = self.b.def_named(v, "tosa.const_shape")?;
        Const::try_from(self.b[def].get("values")?).ok().filter(|k| k.elements)
    }

    /// Every element of `k`.
    fn elements(k: &Const<'_>) -> Option<Vec<ApInt>> {
        let n = if k.is_splat() { k.ty.element_count()? } else { k.values.len() };
        (0..n).map(|i| k.at(i).int()).collect()
    }

    /// A `tensor<Nxindex>` of `values`.
    fn index_tensor(values: Vec<ApInt>) -> Fold<'a> {
        let n = values.len() as i64;
        let ty = Type::Shaped(alloc::boxed::Box::new(mlirformat::Shaped { kind: mlirformat::ShapedKind::Tensor, shape: Some(alloc::vec![Dim::Static(n)]), elem: Type::Index.into(), extras: Vec::new() }));
        Self::attr(Const { ty, values: values.into_iter().map(Scalar::Int).collect(), elements: true })
    }

    /// `binaryFold` of a shape op: element by element.
    fn shape_binary(&self, f: ShapeFold) -> Fold<'a> {
        let (Some(l), Some(r)) = (self.shape_values(self.operand(0)), self.shape_values(self.operand(1))) else { return Fold::Failed };
        if !Self::is_static(&l.ty) || l.ty.element_type() != r.ty.element_type() {
            return Fold::Failed;
        }
        let (Some(ls), Some(rs)) = (Self::elements(&l), Self::elements(&r)) else { return Fold::Failed };
        let out: Option<Vec<ApInt>> = ls.into_iter().zip(rs).map(|(a, b)| f.binary(a, b)).collect();
        out.map_or(Fold::Failed, |v| Self::attr(Const { ty: l.ty, values: v.into_iter().map(Scalar::Int).collect(), elements: true }))
    }

    /// `unaryShapeFold`.
    fn shape_unary(&self, f: ShapeFold) -> Fold<'a> {
        let Some(k) = self.shape_values(self.operand(0)) else { return Fold::Failed };
        let Some(vs) = Self::elements(&k).filter(|_| Self::is_static(&k.ty)) else { return Fold::Failed };
        let out: Option<Vec<ApInt>> = vs.into_iter().map(|v| f.unary(v)).collect();
        out.map_or(Fold::Failed, |v| Self::attr(Const { ty: k.ty, values: v.into_iter().map(Scalar::Int).collect(), elements: true }))
    }

    /// `DimOp::fold`: a static dim.
    fn dim(&self) -> Fold<'a> {
        let axis = self.int_attr("axis").unwrap_or(0) as usize;
        match Self::dims(&self.ty(self.operand(0))).and_then(|d| d.get(axis).copied().flatten()) {
            Some(n) => Self::index_tensor(alloc::vec![ApInt::new(64, i128::from(n))]),
            None => Fold::Failed,
        }
    }

    /// `concatShapeFold`.
    fn concat_shape(&self) -> Fold<'a> {
        let ops = &self.b[self.op].operands;
        if ops.is_empty() {
            return Fold::Failed;
        }
        let mut all = Vec::new();
        for v in ops.iter() {
            let Some(vs) = self.shape_values(*v).as_ref().and_then(Self::elements) else { return Fold::Failed };
            all.extend(vs);
        }
        Self::index_tensor(all)
    }

    /// `sliceShapeFold`.
    fn slice_shape(&self) -> Fold<'a> {
        let Some(vs) = self.shape_values(self.operand(0)).as_ref().and_then(Self::elements) else { return Fold::Failed };
        let one = |i: usize| Self::ints_of(self.b, self.operand(i)).and_then(|v| v.first().copied());
        let (Some(start), Some(size)) = (one(1), one(2)) else { return Fold::Failed };
        let (start, size) = (start as i32, size as i32);
        if size <= 0 || start < 0 || (start + size) as usize > vs.len() {
            return Fold::Failed;
        }
        Self::index_tensor(vs[start as usize..(start + size) as usize].to_vec())
    }

    /// `ReciprocalOp::fold`: of a float splat.
    fn reciprocal(&self) -> Fold<'a> {
        let ty = self.result_ty();
        if !Self::is_static(&ty) {
            return Fold::Failed;
        }
        match self.dense(0).as_ref().and_then(Self::splat) {
            Some(Scalar::Float(f)) => ApFloat::from_f64(f.kind, 1.0).map_or(Fold::Failed, |one| Self::splat_of(Scalar::Float(one.div(f)), ty)),
            _ => Fold::Failed,
        }
    }

    /// `ArgMaxOp::fold`: the axis has one element.
    fn argmax(&self) -> Fold<'a> {
        let (it, ty) = (self.ty(self.operand(0)), self.result_ty());
        if !Self::is_static(&it) || !Self::is_static(&ty) {
            return Fold::Failed;
        }
        let axis = self.int_attr("axis").unwrap_or(0) as usize;
        let Type::Integer { width, .. } = *ty.element_type() else { return Fold::Failed };
        if Self::dims(&it).and_then(|d| d.get(axis).copied().flatten()) == Some(1) { Self::splat_of(Scalar::Int(ApInt::zero(width)), ty) } else { Fold::Failed }
    }
}

impl<'a> Tf<'_, '_, 'a> {
    /// `FoldPadToTensorOp`: `op`'s input padded by a `tosa.pad` in H and W only, the padding
    /// moved into `op`'s own; `pool` for `max_pool2d` (`PoolPadFoldAdaptor`), else a conv
    /// (`ConvPadFoldAdaptor`).
    fn fold_pad(rw: &mut crate::Rewriter<'_, 'a>, op: OpId, pool: bool) -> bool {
        let b = &*rw.body;
        let Some(pad) = b.def_named(b[op].operands[0], "tosa.pad") else { return false };
        let own: Vec<i64> = match b[op].get("pad") {
            Some(Attribute::DenseArray { values, .. }) => values.iter().filter_map(|v| v.parse().ok()).collect(),
            _ => return false,
        };
        let Some(p) = Tf::ints_of(b, b[pad].operands[1]).filter(|p| own.len() == 4 && p.len() == 8) else { return false };
        if p[0] != 0 || p[1] != 0 || p[6] != 0 || p[7] != 0 {
            return false;
        }
        let folded = [p[2] + own[0], p[3] + own[1], p[4] + own[2], p[5] + own[3]];
        let kernel: Vec<i64> = match b[op].get("kernel") {
            Some(Attribute::DenseArray { values, .. }) => values.iter().filter_map(|v| v.parse().ok()).collect(),
            _ => Vec::new(),
        };
        if pool && (kernel.len() != 2 || folded[2] >= kernel[1] || folded[3] >= kernel[1] || folded[0] >= kernel[0] || folded[1] >= kernel[0]) {
            return false;
        }
        let constant = |v: ValueId| b.constant_of(v).and_then(|a| Const::try_from(&a).ok()).filter(|k| k.elements && k.ty.element_count() == Some(1));
        let Some(pad_const) = constant(b[pad].operands[2]) else { return false };
        let ok = match (pad_const.at(0), pad_const.ty.element_type()) {
            (Scalar::Float(f), _) if pool => f.compare(ApFloat::largest(f.kind, true)) == Some(core::cmp::Ordering::Equal),
            (Scalar::Float(f), _) => f.to_f64() as f32 == 0.0,
            (Scalar::Int(i), Type::Integer { width, signedness }) if pool => i == if *signedness == Signedness::Unsigned { ApInt::zero(*width) } else { ApInt::signed_min(*width) },
            (Scalar::Int(i), _) if !pool => constant(b[op].operands[3]).and_then(|z| z.at(0).int()).is_some_and(|z| z.signed() == i.signed()),
            _ => false,
        };
        if !ok || folded.iter().any(|v| *v > 8192) {
            return false;
        }
        let mut data = OpData::build(&b[op].name);
        data.operands = b[op].operands.clone();
        data.operands[0] = b[pad].operands[0];
        b[op].properties.iter().for_each(|a| data.set(&a.name, a.value.clone().unwrap_or(Attribute::Unit)));
        // The conv builders spell `local_bound` (`DefaultValuedOptionalAttr`) out.
        if !pool && data.get("local_bound").is_none() {
            data.set("local_bound", Attribute::Bool(false));
        }
        data.set("pad", Attribute::dense_i64(&folded));
        let ty = b[b[op].results[0]].ty.clone();
        rw.replace_with(op, data, &[ty]);
        true
    }
}

/// A `min_val` / `max_val` scalar.
fn scalar_attr(a: Option<&Attribute<'_>>) -> Option<Scalar> {
    Const::try_from(a?).ok().filter(|k| !k.elements)?.splat_value()
}

/// The dims of a shaped value's type (dynamic as `None`).
fn dims_of(b: &Body<'_>, v: ValueId) -> Option<Vec<Option<i64>>> {
    Tf::dims(&b[v].ty)
}

/// The `perms` of a `tosa.transpose`.
fn perms(b: &Body<'_>, op: OpId) -> Vec<i64> {
    match b[op].get("perms") {
        Some(Attribute::DenseArray { values, .. }) => values.iter().filter_map(|v| v.parse().ok()).collect(),
        _ => Vec::new(),
    }
}

/// `tosa` canonicalization: its rewrite patterns, folds and constant materialization.
pub struct TosaCanon;

#[crate::patterns]
impl TosaCanon {
    /// `ClampIsNoOp`: a clamp to the whole range of its type.
    #[rewrite("tosa.clamp")]
    fn clamp_is_no_op(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
        let b = &*rw.body;
        let input = b[op].operands[0];
        let elem = b[input].ty.element_type().clone();
        let (Some(lo), Some(hi)) = (scalar_attr(b[op].get("min_val")), scalar_attr(b[op].get("max_val"))) else { return false };
        let noop = match (&elem, lo, hi) {
            (Type::Float(_), Scalar::Float(l), Scalar::Float(h)) => l.is_inf() && l.is_negative() && h.is_inf() && !h.is_negative(),
            (Type::Integer { width, signedness }, Scalar::Int(l), Scalar::Int(h)) if *signedness == Signedness::Unsigned || *width == 1 => {
                l.unsigned() == 0 && h.unsigned() >= ApInt::all_ones(*width).unsigned()
            }
            (Type::Integer { width, .. }, Scalar::Int(l), Scalar::Int(h)) => l.signed() <= ApInt::signed_min(*width).signed() && h.signed() >= ApInt::signed_max(*width).signed(),
            _ => false,
        };
        if !noop {
            return false;
        }
        rw.replace_op(op, &[input]);
        true
    }

    /// `ClampClampOptimization`: two clamps whose ranges meet, as one.
    #[rewrite("tosa.clamp")]
    fn clamp_clamp_optimization(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
        let b = &*rw.body;
        let Some(inner) = b.def_named(b[op].operands[0], "tosa.clamp") else { return false };
        let mode = |o: OpId| match b[o].get("nan_mode") {
            Some(Attribute::Extended { ext, .. }) => ext.body.as_deref().unwrap_or("<PROPAGATE>").contains("IGNORE"),
            _ => false,
        };
        let (outer_ignore, inner_ignore) = (mode(op), mode(inner));
        if outer_ignore && !inner_ignore {
            return false;
        }
        let get = |o: OpId, n: &str| scalar_attr(b[o].get(n));
        let (Some(l1), Some(h1), Some(l2), Some(h2)) = (get(op, "min_val"), get(op, "max_val"), get(inner, "min_val"), get(inner, "max_val")) else { return false };
        let src = b[inner].operands[0];
        let elem = Tf::storage(b[src].ty.element_type());
        let (lo, hi) = match (l1, h1, l2, h2) {
            (Scalar::Float(a), Scalar::Float(b_), Scalar::Float(c), Scalar::Float(d)) => {
                let lt = |x: ApFloat, y: ApFloat| x.compare(y) == Some(core::cmp::Ordering::Less);
                if !(lt(a, d) && lt(c, b_)) {
                    return false;
                }
                (Scalar::Float(if lt(a, c) { c } else { a }), Scalar::Float(if lt(b_, d) { b_ } else { d }))
            }
            (Scalar::Int(a), Scalar::Int(b_), Scalar::Int(c), Scalar::Int(d)) => {
                let unsigned = matches!(elem, Type::Integer { signedness: Signedness::Unsigned, .. });
                let key = |x: ApInt| if unsigned { x.unsigned() as i128 } else { x.signed() };
                if !(key(a) < key(d) && key(c) < key(b_)) {
                    return false;
                }
                (Scalar::Int(if key(a) < key(c) { c } else { a }), Scalar::Int(if key(b_) < key(d) { b_ } else { d }))
            }
            _ => return false,
        };
        let ignore = outer_ignore != inner_ignore || outer_ignore;
        let ty = b[b[op].results[0]].ty.clone();
        let data = OpData::build("tosa.clamp")
            .operands(&[src])
            .with("min_val", Const::scalar(lo, elem.clone()).into())
            .with("max_val", Const::scalar(hi, elem).into())
            .with("nan_mode", Attribute::dialect("tosa.nan_mode", if ignore { "<IGNORE>" } else { "<PROPAGATE>" }));
        rw.replace_with(op, data, &[ty]);
        true
    }

    /// `AvgPool2dIsNoOp`: a float pool of one element at a time, zero points known.
    #[rewrite("tosa.avg_pool2d")]
    fn avg_pool2d_is_no_op(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
        let b = &*rw.body;
        let input = b[op].operands[0];
        if b[input].ty != b[b[op].results[0]].ty || !matches!(b[input].ty.element_type(), Type::Float(_)) {
            return false;
        }
        if b.constant_of(b[op].operands[1]).is_none() || b.constant_of(b[op].operands[2]).is_none() || !Pool::of(b, op).unit() {
            return false;
        }
        rw.replace_op(op, &[input]);
        true
    }

    /// `AvgPool2dAdaptiveToAvgPool2d`: constant kernel, stride and pad as attributes.
    #[rewrite("tosa.avg_pool2d_adaptive")]
    fn avg_pool2d_adaptive_to_avg_pool2d(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
        Pool::from_adaptive(rw, op, "tosa.avg_pool2d", 3)
    }

    /// `MaxPool2dAdaptiveToMaxPool2d`.
    #[rewrite("tosa.max_pool2d_adaptive")]
    fn max_pool2d_adaptive_to_max_pool2d(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
        Pool::from_adaptive(rw, op, "tosa.max_pool2d", 1)
    }

    /// `MaxPool2dIsNoOp`: one element at a time propagating NaNs, or 1x1 in and out.
    #[rewrite("tosa.max_pool2d")]
    fn max_pool2d_is_no_op(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
        let b = &*rw.body;
        let input = b[op].operands[0];
        let propagate = !matches!(b[op].get("nan_mode"), Some(Attribute::Extended { ext, .. }) if ext.body.as_deref().is_some_and(|m| m.contains("IGNORE")));
        if b[input].ty == b[b[op].results[0]].ty && Pool::of(b, op).unit() && propagate {
            rw.replace_op(op, &[input]);
            return true;
        }
        let (Some(i), Some(o)) = (dims_of(b, input), dims_of(b, b[op].results[0])) else { return false };
        let unit = |d: &[Option<i64>]| d.iter().all(Option::is_some) && d.get(1) == Some(&Some(1)) && d.get(2) == Some(&Some(1));
        if !unit(&i) || !unit(&o) {
            return false;
        }
        rw.replace_op(op, &[input]);
        true
    }

    /// `FoldPadToTensorOp<MaxPool2dOp>`: a pad of the lowest value into the pool's padding.
    #[rewrite("tosa.max_pool2d")]
    fn fold_pad_to_max_pool2d(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
        Tf::fold_pad(rw, op, true)
    }

    /// `FoldPadToTensorOp<Conv2DOp>`: a pad of the input zero point into the conv's padding.
    #[rewrite("tosa.conv2d")]
    fn fold_pad_to_conv2d(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
        Tf::fold_pad(rw, op, false)
    }

    /// `FoldPadToTensorOp<DepthwiseConv2DOp>`.
    #[rewrite("tosa.depthwise_conv2d")]
    fn fold_pad_to_depthwise_conv2d(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
        Tf::fold_pad(rw, op, false)
    }

    /// `ConcatSliceOptimization`: a slice within one input of a concat slices that input.
    #[rewrite("tosa.slice")]
    fn concat_slice_optimization(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
        let b = &*rw.body;
        let Some(concat) = b.def_named(b[op].operands[0], "tosa.concat") else { return false };
        if !Tf::is_static(&b[b[concat].results[0]].ty) {
            return false;
        }
        let axis = match b[concat].get("axis") {
            Some(Attribute::Int { lit, .. }) => lit.parse::<usize>().ok(),
            _ => None,
        };
        let (Some(axis), Some(mut starts), Some(sizes)) = (axis, Tf::ints_of(b, b[op].operands[1]), Tf::ints_of(b, b[op].operands[2])) else { return false };
        if axis >= starts.len().min(sizes.len()) {
            return false;
        }
        let mut found = None;
        for input in b[concat].operands.clone() {
            let Some(dim) = dims_of(b, input).filter(|d| d.iter().all(Option::is_some)).and_then(|d| *d.get(axis)?) else { return false };
            if starts[axis] >= 0 && starts[axis] + sizes[axis] <= dim {
                found = Some(input);
                break;
            }
            starts[axis] -= dim;
        }
        let Some(input) = found else { return false };
        let ty = b[b[op].results[0]].ty.clone();
        rw.set_before(op);
        let start = const_shape(rw, &starts);
        let size = const_shape(rw, &sizes);
        rw.replace_with(op, OpData::build("tosa.slice").operands(&[input, start, size]), &[ty]);
        true
    }

    /// `PadSliceOptimization`: a slice of a pad pads only what the slice keeps.
    #[rewrite("tosa.slice")]
    fn pad_slice_optimization(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
        let b = &*rw.body;
        let Some(pad) = b.def_named(b[op].operands[0], "tosa.pad") else { return false };
        if b[b[pad].results[0]].uses.len() != 1 {
            return false;
        }
        let input = b[pad].operands[0];
        let (Some(dims), Some(_)) = (dims_of(b, input), dims_of(b, b[pad].results[0])) else { return false };
        let (Some(paddings), Some(starts), Some(sizes)) = (Tf::ints_of(b, b[pad].operands[1]), Tf::ints_of(b, b[op].operands[1]), Tf::ints_of(b, b[op].operands[2])) else { return false };
        let rank = dims.len();
        if paddings.len() < 2 * rank || starts.len() < rank || sizes.len() < rank || dims.iter().enumerate().any(|(i, d)| d.is_none() && (starts[i] != 0 || sizes[i] != -1)) {
            return false;
        }
        let mut new_starts = alloc::vec![0i64; rank];
        let mut new_paddings = alloc::vec![0i64; 2 * rank];
        let mut shape = alloc::vec![Dim::Dynamic; rank];
        let mut updated = false;
        for (i, d) in dims.iter().enumerate() {
            let (lo, hi, start) = (paddings[2 * i], paddings[2 * i + 1], starts[i]);
            let end = start + sizes[i];
            let Some(dim) = *d else {
                (new_paddings[2 * i], new_paddings[2 * i + 1], new_starts[i]) = (lo, hi, start);
                continue;
            };
            if start < 0 || end > lo + dim + hi {
                return false;
            }
            new_starts[i] = (start - lo).max(0);
            let (new_lo, new_hi) = ((lo - start).max(0), (end - (lo + dim)).max(0));
            (new_paddings[2 * i], new_paddings[2 * i + 1]) = (new_lo, new_hi);
            updated |= new_starts[i] != start || new_lo != lo || new_hi != hi;
            shape[i] = Dim::Static(new_lo + dim + new_hi);
        }
        if !updated {
            return false;
        }
        let pad_ty = Type::Shaped(alloc::boxed::Box::new(mlirformat::Shaped { kind: mlirformat::ShapedKind::Tensor, shape: Some(shape), elem: b[input].ty.element_type().clone().into(), extras: Vec::new() }));
        let (pad_const, size, ty) = (b[pad].operands[2], b[op].operands[2], b[b[op].results[0]].ty.clone());
        rw.set_before(op);
        let paddings = const_shape(rw, &new_paddings);
        let new_pad = rw.create(OpData::build("tosa.pad").operands(&[input, paddings, pad_const]), &[pad_ty]);
        let new_pad = rw.body[new_pad].results[0];
        let start = const_shape(rw, &new_starts);
        rw.replace_with(op, OpData::build("tosa.slice").operands(&[new_pad, start, size]), &[ty]);
        true
    }

    /// `SliceDynamicSizeCanonicalization`: a `-1` size where the result's dim is static.
    #[rewrite("tosa.slice")]
    fn slice_dynamic_size_canonicalization(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
        let b = &*rw.body;
        let (Some(mut sizes), Some(out)) = (Tf::ints_of(b, b[op].operands[2]), dims_of(b, b[op].results[0])) else { return false };
        let mut replace = false;
        for (s, d) in sizes.iter_mut().zip(&out) {
            if let (-1, Some(d)) = (*s, d) {
                (*s, replace) = (*d, true);
            }
        }
        if !replace {
            return false;
        }
        let (input, start, ty) = (b[op].operands[0], b[op].operands[1], b[b[op].results[0]].ty.clone());
        rw.set_before(op);
        let size = const_shape(rw, &sizes);
        rw.replace_with(op, OpData::build("tosa.slice").operands(&[input, start, size]), &[ty]);
        true
    }

    /// `ConsecutiveConcatOptimization`: concats on the same axis flattened in, within the
    /// target level's tensor list size.
    #[rewrite("tosa.concat")]
    fn consecutive_concat_optimization(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
        let b = &*rw.body;
        let axis = b[op].get("axis").cloned();
        let mut operands = Vec::new();
        let mut found = false;
        for v in b[op].operands.iter() {
            match b.def_named(*v, "tosa.concat") {
                Some(p) if b[p].get("axis").cloned() == axis => {
                    found = true;
                    operands.extend(b[p].operands.iter().copied());
                }
                _ => operands.push(*v),
            }
        }
        if !found || TosaLevel::of(b, op).is_some_and(|l| operands.len() > l.max_tensor_list_size()) {
            return false;
        }
        let ty = b[b[op].results[0]].ty.clone();
        let data = OpData::build("tosa.concat").operands(&operands).with("axis", axis.unwrap_or(Attribute::Unit));
        rw.replace_with(op, data, &[ty]);
        true
    }

    /// `NonNarrowingCastsOptimization`: a widening cast then another, as one cast.
    #[rewrite("tosa.cast")]
    fn non_narrowing_casts_optimization(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
        let b = &*rw.body;
        let Some(inner) = b.def_named(b[op].operands[0], "tosa.cast") else { return false };
        let src = b[inner].operands[0];
        let (i, m, o) = (b[src].ty.element_type(), b[b[inner].results[0]].ty.element_type(), b[b[op].results[0]].ty.element_type());
        let Some([ik, mk, ok]) = [i, m, o].map(CastKind::of).into_iter().collect::<Option<Vec<_>>>().and_then(|v| <[CastKind; 3]>::try_from(v).ok()) else { return false };
        if !CastKind::allowed(ik, ok) || ik.narrows_to(mk) {
            return false;
        }
        let ty = b[b[op].results[0]].ty.clone();
        rw.replace_with(op, OpData::build("tosa.cast").operands(&[src]), &[ty]);
        true
    }

    /// `CancellingBlockScaledCastsOptimization`: block scaled to f32 and back.
    #[rewrite("tosa.cast")]
    fn cancelling_block_scaled_casts_optimization(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
        let b = &*rw.body;
        let Some(inner) = b.def_named(b[op].operands[0], "tosa.cast") else { return false };
        let src = b[inner].operands[0];
        let block_scaled = matches!(b[src].ty.element_type(), Type::Extended(e) if e.name == "tosa.block_scaled");
        if !block_scaled || b[src].ty != b[b[op].results[0]].ty || *b[b[inner].results[0]].ty.element_type() != Type::Float(FloatKind::F32) {
            return false;
        }
        rw.replace_op(op, &[src]);
        true
    }

    /// `CancellingCastToFromBlockScaledOptimization`: from block scaled and back, the same types
    /// and block size.
    #[rewrite("tosa.cast_to_block_scaled")]
    fn cancelling_cast_to_from_block_scaled(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
        let b = &*rw.body;
        let Some(from) = b.def_named(b[op].operands[0], "tosa.cast_from_block_scaled") else { return false };
        let (data, scale) = (b[from].operands[0], b[from].operands[1]);
        let r = &b[op].results;
        if b[data].ty != b[r[0]].ty || b[scale].ty != b[r[1]].ty || b[from].get("block_size") != b[op].get("block_size") {
            return false;
        }
        rw.replace_op(op, &[data, scale]);
        true
    }

    /// `RowGatherToGather`: rows of one.
    #[rewrite("tosa.row_gather")]
    fn row_gather_to_gather(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
        let b = &*rw.body;
        let one = b.constant_of(b[op].operands[2]).and_then(|a| Const::try_from(&a).ok()).filter(|k| matches!(k.ty.element_type(), Type::Integer { .. }) && k.ty.element_count() == Some(1)).and_then(|k| k.at(0).int());
        if !one.is_some_and(|i| i.signed() as i32 == 1) {
            return false;
        }
        let (values, indices, ty) = (b[op].operands[0], b[op].operands[1], b[b[op].results[0]].ty.clone());
        rw.replace_with(op, OpData::build("tosa.gather").operands(&[values, indices]), &[ty]);
        true
    }

    /// `RemoveBroadcastTileFromBinaryElementwise`: a tile only broadcasting unit dims into a
    /// binary elementwise op, left to the op's own broadcasting.
    #[rewrite("tosa.tile")]
    fn remove_broadcast_tile_from_binary_elementwise(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
        let b = &*rw.body;
        let out = b[op].results[0];
        if b[out].uses.len() != 1 {
            return false;
        }
        let Some(user) = b[out].uses.iter().next().map(|u| u.op) else { return false };
        let binary = b[user].operands.len() == 2 && b.has(user, crate::Trait::TosaElementwiseOperator);
        if !binary && b[user].name != "tosa.mul" {
            return false;
        }
        let input = b[op].operands[0];
        let (Some(id), Some(od)) = (dims_of(b, input), dims_of(b, out)) else { return false };
        let Some(multiples) = Tf::ints_of(b, b[op].operands[1]) else { return false };
        let broadcast = multiples.iter().enumerate().all(|(i, m)| *m == 1 || (od.get(i).copied().flatten().is_some() && id.get(i) == Some(&Some(1))));
        if !broadcast {
            return false;
        }
        let (l, r) = (b[user].operands[0], b[user].operands[1]);
        let other = if l == out { r } else { l };
        let (Some(other_dims), Some(tile_dims), Some(user_dims)) = (Tf::dims64(&b[other].ty), Tf::dims64(&b[input].ty), Tf::dims64(&b[b[user].results[0]].ty)) else { return false };
        if Broadcast::shape(&other_dims, &tile_dims).is_none_or(|s| s != user_dims) {
            return false;
        }
        rw.set_before(user);
        let mut map = crate::Mapping::default();
        map.map(out, input);
        let new = rw.clone(user, &mut map);
        let results = rw.body[new].results.to_vec();
        rw.replace_op(user, &results);
        true
    }

    /// `ConcatOptimization`: one input, cast to the result type when it differs.
    #[rewrite("tosa.concat")]
    fn concat_optimization(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
        let b = &*rw.body;
        let &[input] = &b[op].operands[..] else { return false };
        let ty = b[b[op].results[0]].ty.clone();
        if b[input].ty != ty {
            rw.replace_with(op, OpData::build("tensor.cast").operands(&[input]), &[ty]);
        } else {
            rw.replace_op(op, &[input]);
        }
        true
    }

    /// `SelectOp::canonicalize`: a select on `logical_not(p)` swaps its branches.
    #[rewrite("tosa.select")]
    fn select_of_logical_not(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
        let b = &*rw.body;
        let Some(not) = b.def_named(b[op].operands[0], "tosa.logical_not") else { return false };
        let ops = alloc::vec![b[not].operands[0], b[op].operands[2], b[op].operands[1]];
        rw.modify(op, |b| b.set_operands(op, ops));
        true
    }

    /// `ConsolidateTransposeOptimization`: a transpose of a transpose, as one.
    #[rewrite("tosa.transpose")]
    fn consolidate_transpose_optimization(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
        let b = &*rw.body;
        let Some(inner) = b.def_named(b[op].operands[0], "tosa.transpose") else { return false };
        let (outer, inner_p) = (perms(b, op), perms(b, inner));
        if outer.len() != inner_p.len() || outer.is_empty() {
            return false;
        }
        let composed: Vec<i64> = outer.iter().map(|p| inner_p[*p as usize]).collect();
        let ty = b[b[op].results[0]].ty.clone();
        let src = b[inner].operands[0];
        let values = composed.iter().map(|p| alloc::format!("{p}").into()).collect();
        let data = OpData::build("tosa.transpose").operands(&[src]).with("perms", Attribute::DenseArray { ty: Type::int(32), values });
        rw.replace_with(op, data, &[ty]);
        true
    }

    /// `TransposeIsReshape`: a transpose that only moves unit dims is a reshape.
    #[rewrite("tosa.transpose")]
    fn transpose_is_reshape(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
        let b = &*rw.body;
        let input = b[op].operands[0];
        if b.def_named(input, "tosa.transpose").is_some() || b[b[op].results[0]].uses.iter().any(|u| b[u.op].name == "tosa.transpose") {
            return false;
        }
        let Some(dims) = dims_of(b, input) else { return false };
        if dims.iter().filter(|d| d.is_none()).count() > 1 {
            return false;
        }
        let p = perms(b, op);
        let moved: Vec<i64> = p.iter().copied().filter(|i| dims[*i as usize] != Some(1)).collect();
        if moved.windows(2).any(|w| w[0] > w[1]) {
            return false;
        }
        let shape: Vec<i64> = p.iter().map(|i| dims[*i as usize].unwrap_or(i64::MIN)).collect();
        let ty = b[b[op].results[0]].ty.clone();
        rw.set_before(op);
        let s = const_shape(rw, &shape);
        rw.replace_with(op, OpData::build("tosa.reshape").operands(&[input, s]), &[ty]);
        true
    }
}

/// A pool's `kernel`, `stride` and `pad`.
struct Pool {
    kernel: Vec<i64>,
    stride: Vec<i64>,
    pad: Vec<i64>,
}

impl Pool {
    fn of(b: &Body<'_>, op: OpId) -> Self {
        let get = |n: &str| match b[op].get(n) {
            Some(Attribute::DenseArray { values, .. }) => values.iter().filter_map(|v| v.parse().ok()).collect(),
            _ => Vec::new(),
        };
        Pool { kernel: get("kernel"), stride: get("stride"), pad: get("pad") }
    }

    /// A unit kernel and stride, no padding.
    fn unit(&self) -> bool {
        self.kernel.iter().all(|k| *k == 1) && self.stride.iter().all(|s| *s == 1) && self.pad.iter().all(|p| *p == 0)
    }

    /// An adaptive pool (`kernel`, `stride`, `pad` from operand `at` on, each a
    /// `tosa.const_shape`) as `name` with them as attributes; the other attributes kept.
    fn from_adaptive(rw: &mut crate::Rewriter<'_, '_>, op: OpId, name: &str, at: usize) -> bool {
        let b = &*rw.body;
        let shape = |i: usize| {
            let def = b.def_named(b[op].operands[at + i], "tosa.const_shape")?;
            Const::try_from(b[def].get("values")?).ok()?.ints()
        };
        let (Some(kernel), Some(stride), Some(pad)) = (shape(0), shape(1), shape(2)) else { return false };
        let mut data = OpData::build(name).operands(&b[op].operands[..at]);
        data.set("kernel", Attribute::dense_i64(&kernel));
        data.set("stride", Attribute::dense_i64(&stride));
        data.set("pad", Attribute::dense_i64(&pad));
        for a in b[op].properties.iter() {
            data.set(&a.name, a.value.clone().unwrap_or(Attribute::Unit));
        }
        let ty = b[b[op].results[0]].ty.clone();
        rw.replace_with(op, data, &[ty]);
        true
    }
}

/// The element types `NonNarrowingCastsOptimization` handles.
#[derive(Clone, Copy, PartialEq, Eq)]
enum CastKind {
    Int { width: u32, signedness: Signedness },
    F8E4M3FN,
    F8E5M2,
    BF16,
    F16,
    F32,
}

/// `fltSemantics` of a float: max and min exponents, precision, NaN, infinity.
struct Semantics {
    max_exp: i32,
    min_exp: i32,
    precision: u32,
    nan: bool,
    inf: bool,
}

impl CastKind {
    fn of(t: &Type<'_>) -> Option<Self> {
        Some(match t {
            Type::Integer { width, signedness } => CastKind::Int { width: *width, signedness: *signedness },
            Type::Float(FloatKind::F8E4M3FN) => CastKind::F8E4M3FN,
            Type::Float(FloatKind::F8E5M2) => CastKind::F8E5M2,
            Type::Float(FloatKind::BF16) => CastKind::BF16,
            Type::Float(FloatKind::F16) => CastKind::F16,
            Type::Float(FloatKind::F32) => CastKind::F32,
            _ => return None,
        })
    }

    fn width(self) -> Option<u32> {
        if let CastKind::Int { width, .. } = self { Some(width) } else { None }
    }

    fn fp8(self) -> bool {
        matches!(self, CastKind::F8E4M3FN | CastKind::F8E5M2)
    }

    fn semantics(self) -> Option<Semantics> {
        let s = |max_exp, min_exp, precision, nan, inf| Some(Semantics { max_exp, min_exp, precision, nan, inf });
        match self {
            CastKind::Int { .. } => None,
            CastKind::F8E4M3FN => s(8, -6, 4, true, false),
            CastKind::F8E5M2 => s(15, -14, 3, true, true),
            CastKind::BF16 => s(127, -126, 8, true, true),
            CastKind::F16 => s(15, -14, 11, true, true),
            CastKind::F32 => s(127, -126, 24, true, true),
        }
    }

    /// Whether a cast `self` ⇒ `out` is legal in every TOSA version.
    fn allowed(self, out: CastKind) -> bool {
        use CastKind::*;
        let (iw, ow) = (self.width(), out.width());
        !matches!((self, out), (F8E5M2, F8E4M3FN) | (F8E4M3FN, F8E5M2) | (F16, BF16) | (BF16, F16))
            && !(self.fp8() && ow.is_some())
            && !(iw.is_some() && out.fp8())
            && !(matches!(iw, Some(8 | 16)) && ow == Some(64))
            && !(matches!(iw, Some(1 | 64)) && ow.is_none())
            && !(iw.is_none() && matches!(ow, Some(1 | 64)))
    }

    /// `isNarrowingCast`: whether `self` ⇒ `out` may lose values.
    fn narrows_to(self, out: CastKind) -> bool {
        match (self, out) {
            (CastKind::Int { width: a, signedness: sa }, CastKind::Int { width: b, signedness: sb }) => sa != sb || a > b,
            _ => match (self.semantics(), out.semantics()) {
                (Some(i), Some(o)) => i.max_exp > o.max_exp || i.min_exp < o.min_exp || i.precision > o.precision || (i.nan && !o.nan) || (i.inf && !o.inf),
                _ => true,
            },
        }
    }
}

/// `TosaLevel` of a `#tosa.target_env`.
#[derive(Clone, Copy)]
enum TosaLevel {
    EightK,
    None,
}

impl TosaLevel {
    /// `lookupTargetEnv`: the level of the nearest enclosing symbol table's `tosa.target_env`.
    fn of(b: &Body<'_>, op: OpId) -> Option<Self> {
        let mut at = b.parent_op(op);
        while let Some(o) = at {
            if b.is_symbol_table(o)
                && let Some(Attribute::Extended { ext, .. }) = b[o].get("tosa.target_env")
            {
                let body = ext.body.as_deref().unwrap_or("");
                return Some(if body.contains("level = \"none\"") { TosaLevel::None } else { TosaLevel::EightK });
            }
            at = b.parent_op(o);
        }
        None
    }

    /// `MAX_TENSOR_LIST_SIZE`.
    fn max_tensor_list_size(self) -> usize {
        match self {
            TosaLevel::EightK => 64,
            TosaLevel::None => 256,
        }
    }
}

/// `getTosaConstShape`: a `tosa.const_shape` of `shape` (dynamic as -1).
fn const_shape<'a>(rw: &mut crate::Rewriter<'_, 'a>, shape: &[i64]) -> ValueId {
    let values = shape.iter().map(|d| Scalar::Int(ApInt::new(64, i128::from(if *d == i64::MIN { -1 } else { *d })))).collect();
    let n = shape.len() as i64;
    let tensor = Type::Shaped(alloc::boxed::Box::new(mlirformat::Shaped { kind: mlirformat::ShapedKind::Tensor, shape: Some(alloc::vec![Dim::Static(n)]), elem: Type::Index.into(), extras: Vec::new() }));
    let ty = Type::Extended(alloc::boxed::Box::new(mlirformat::Extended { name: "tosa.shape".into(), body: Some(alloc::format!("<{n}>").into()), params: Vec::new() }));
    let o = rw.create(OpData::build("tosa.const_shape").with("values", Const { ty: tensor, values, elements: true }.into()), &[ty]);
    rw.body[o].results[0]
}

impl TosaCanon {
    /// The fold hook of tosa op `op`.
    pub fn fold<'a>(b: &mut Body<'a>, op: OpId, c: &[Option<Attribute<'a>>]) -> Fold<'a> {
        Tf { b, op, c }.fold()
    }

    /// `TosaDialect::materializeConstant`: `tosa.const_shape` for a `!tosa.shape`, else
    /// `tosa.const` of an elements attribute.
    pub fn materialize<'a>(value: &Attribute<'a>, ty: &Type<'a>) -> Option<OpData<'a>> {
        let k = Const::try_from(value).ok().filter(|k| k.elements)?;
        let name = if matches!(ty, Type::Extended(e) if e.name == "tosa.shape") { "tosa.const_shape" } else { "tosa.const" };
        Some(OpData::build(name).with("values", k.into()))
    }

    pub fn canonicalization(set: &mut crate::PatternSet) {
        set.add(ClampIsNoOp).add(ClampClampOptimization);
        set.add(ConcatOptimization).add(ConsecutiveConcatOptimization);
        set.add(NonNarrowingCastsOptimization).add(CancellingBlockScaledCastsOptimization);
        set.add(CancellingCastToFromBlockScaled);
        set.add(RowGatherToGather);
        set.add(RemoveBroadcastTileFromBinaryElementwise);
        set.add(FoldPadToConv2d).add(FoldPadToDepthwiseConv2d);
        set.add(AvgPool2dIsNoOp).add(AvgPool2dAdaptiveToAvgPool2d);
        set.add(MaxPool2dIsNoOp).add(FoldPadToMaxPool2d).add(MaxPool2dAdaptiveToMaxPool2d);
        set.add(ConcatSliceOptimization).add(PadSliceOptimization).add(SliceDynamicSizeCanonicalization);
        set.add(SelectOfLogicalNot);
        set.add(ConsolidateTransposeOptimization).add(TransposeIsReshape);
    }
}
