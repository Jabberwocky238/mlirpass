//! `tosa`: folds and constants, as `TosaCanonicalizations.cpp` and `TosaOps.cpp`.

use alloc::vec::Vec;

use mlirformat::{Attribute, Dim, FloatKind, Signedness, Type};

use crate::{ApFloat, ApInt, Body, Const, Fold, Folded, OpData, OpId, Scalar, ValueId, attr};

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
        Some(attr::shape_of(t)?.iter().map(|d| if let Dim::Static(n) = d { Some(*n) } else { None }).collect())
    }

    fn is_static(t: &Type<'_>) -> bool {
        Self::dims(t).is_some_and(|d| d.iter().all(Option::is_some))
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

    /// `binaryFolder`: two splats of the same element type through `int` / `float`.
    fn binary(&self, ty: Type<'a>, int: impl Fn(ApInt, ApInt) -> Option<Scalar>, float: impl Fn(ApFloat, ApFloat) -> Option<Scalar>) -> Fold<'a> {
        let (Some(l), Some(r)) = (self.dense(0), self.dense(1)) else { return Fold::Failed };
        let (Some(ls), Some(rs)) = (Self::splat(&l), Self::splat(&r)) else { return Fold::Failed };
        if attr::element_type(&l.ty) != attr::element_type(&r.ty) {
            return Fold::Failed;
        }
        let s = match (ls, rs) {
            (Scalar::Int(a), Scalar::Int(b)) => int(a, b),
            (Scalar::Float(a), Scalar::Float(b)) => float(a, b),
            _ => None,
        };
        s.map_or(Fold::Failed, |s| Self::splat_of(s, ty))
    }

    fn fold(self) -> Fold<'a> {
        let name = alloc::string::String::from(self.b[self.op].name.strip_prefix("tosa.").unwrap_or(""));
        match name.as_str() {
            "const" | "const_shape" => self.b[self.op].get("values").cloned().map_or(Fold::Failed, |a| Folded::Attr(a).into()),
            "add" | "sub" => self.add_sub(name == "add"),
            "mul" => self.mul(),
            "intdiv" => self.int_div(),
            "greater" => self.binary(self.result_ty(), |a, b| Some(Scalar::Int(ApInt::new(1, i128::from(a.scmp(b).is_gt())))), |a, b| Some(Scalar::Int(ApInt::new(1, i128::from(a.compare(b) == Some(core::cmp::Ordering::Greater)))))),
            "greater_equal" => self.binary(self.result_ty(), |a, b| Some(Scalar::Int(ApInt::new(1, i128::from(a.scmp(b).is_ge())))), |a, b| Some(Scalar::Int(ApInt::new(1, i128::from(matches!(a.compare(b), Some(core::cmp::Ordering::Greater | core::cmp::Ordering::Equal))))))),
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
                if self.b.def_named(input, "tosa.abs").is_some() { Self::value(input) } else { Fold::Failed }
            }
            "concat" => self.concat(),
            "reciprocal" => self.reciprocal(),
            "argmax" => self.argmax(),
            _ => Fold::Failed,
        }
    }

    /// `AddOp::fold`, `SubOp::fold`.
    fn add_sub(&self, add: bool) -> Fold<'a> {
        let (lt, rt, ty) = (self.ty(self.operand(0)), self.ty(self.operand(1)), self.result_ty());
        if Self::dims(&lt).is_none() || Self::dims(&rt).is_none() || Self::dims(&ty).is_none() {
            return Fold::Failed;
        }
        if lt == ty && Self::splat_zero(self.dense(1).as_ref()) {
            return Self::value(self.operand(0));
        }
        if add && rt == ty && Self::splat_zero(self.dense(0).as_ref()) {
            return Self::value(self.operand(1));
        }
        if add {
            self.binary(ty, |a, b| Some(Scalar::Int(a.add(b))), |a, b| Some(Scalar::Float(a.add(b))))
        } else {
            self.binary(ty, |a, b| Some(Scalar::Int(a.sub(b))), |a, b| Some(Scalar::Float(a.sub(b))))
        }
    }

    /// `MulOp::fold`, with `shift` for i32 results.
    fn mul(&self) -> Fold<'a> {
        let (lt, rt, ty) = (self.ty(self.operand(0)), self.ty(self.operand(1)), self.result_ty());
        if Self::dims(&lt).is_none() || Self::dims(&rt).is_none() || Self::dims(&ty).is_none() {
            return Fold::Failed;
        }
        let elem = attr::element_type(&ty).clone();
        let mut shift = 0i64;
        if matches!(elem, Type::Integer { width: 32, .. }) && self.b[self.op].operands.len() > 2 {
            let Some(s) = self.dense(2) else { return Fold::Failed };
            shift = s.values.first().and_then(|v| v.int()).map_or(0, |i| i.signed() as i64);
        }
        let (l, r) = (self.dense(0), self.dense(1));
        if rt == ty {
            if Self::splat_zero(l.as_ref()) && Self::is_static(&ty) {
                return Self::splat_of(l.as_ref().and_then(Self::splat).expect("a splat"), ty);
            }
            if Self::splat_one(l.as_ref(), shift) {
                return Self::value(self.operand(1));
            }
        }
        if lt == ty {
            if Self::splat_zero(r.as_ref()) && Self::is_static(&ty) {
                return Self::splat_of(r.as_ref().and_then(Self::splat).expect("a splat"), ty);
            }
            if Self::splat_one(r.as_ref(), shift) {
                return Self::value(self.operand(0));
            }
        }
        let (Some(l), Some(r)) = (l, r) else { return Fold::Failed };
        let (Some(ls), Some(rs)) = (Self::splat(&l), Self::splat(&r)) else { return Fold::Failed };
        let s = match (ls, rs) {
            (Scalar::Int(a), Scalar::Int(b)) if shift == 0 => Some(Scalar::Int(a.mul(b))),
            (Scalar::Int(a), Scalar::Int(b)) => {
                let w = attr::int_width(&elem).map_or(32, |w| w.0);
                let mut p = a.signed() * b.signed() + (1i128 << (shift - 1));
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
        if Self::dims(&ty).is_none() || lt != rt {
            return Fold::Failed;
        }
        let (l, r) = (self.dense(0), self.dense(1));
        let (ls, rs) = (l.as_ref().and_then(Self::splat), r.as_ref().and_then(Self::splat));
        if let (Some(Scalar::Int(z)), Some(l)) = (ls, &l) && z.is_zero() {
            return Self::attr(l.clone());
        }
        if let Some(Scalar::Int(o)) = rs && o.signed() == 1 {
            return Self::value(self.operand(0));
        }
        match (ls, rs) {
            (Some(Scalar::Int(a)), Some(Scalar::Int(b))) if !b.is_zero() => a.sdiv(b).map_or(Fold::Failed, |q| Self::splat_of(Scalar::Int(q), ty)),
            _ => Fold::Failed,
        }
    }

    /// `EqualOp::fold`.
    fn equal(&self) -> Fold<'a> {
        let ty = self.result_ty();
        let lt = self.ty(self.operand(0));
        if matches!(attr::element_type(&lt), Type::Integer { .. }) && Self::is_static(&ty) && self.operand(0) == self.operand(1) {
            return Self::splat_of(Scalar::Int(ApInt::new(1, 1)), ty);
        }
        self.binary(ty, |a, b| Some(Scalar::Int(ApInt::new(1, i128::from(a == b)))), |a, b| Some(Scalar::Int(ApInt::new(1, i128::from(a.compare(b) == Some(core::cmp::Ordering::Equal))))))
    }

    /// `CastOp::fold`: the same type, or a splat converted.
    fn cast(&self) -> Fold<'a> {
        let (input, ty) = (self.operand(0), self.result_ty());
        let it = self.ty(input);
        if it == ty {
            return Self::value(input);
        }
        let Some(s) = self.dense(0).as_ref().and_then(Self::splat) else { return Fold::Failed };
        let (ie, oe) = (attr::element_type(&it).clone(), attr::element_type(&ty).clone());
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
                (x.is_finite()).then(|| Scalar::Int(ApInt::new(*width, x.round_ties_even() as i128)))
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
        let ints = |i: usize| -> Option<Vec<i128>> { self.dense(i)?.values.iter().map(|v| v.int().map(ApInt::signed)).collect() };
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
        if let Some(k) = self.dense(0)
            && Self::splat(&k).is_some()
        {
            return Self::attr(k);
        }
        let axis = self.int_attr("axis").unwrap_or(0) as usize;
        match Self::dims(&self.ty(input)) {
            Some(d) if d.is_empty() || d.get(axis) == Some(&Some(1)) => Self::value(input),
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
        let Some(k) = self.dense(0) else { return Fold::Failed };
        if let Some(s) = Self::splat(&k)
            && Self::is_static(&ty)
        {
            return Self::splat_of(s, ty);
        }
        if Self::is_static(&it) && Self::is_static(&ty) && od.iter().map(|d| d.unwrap_or(0)).product::<i64>() == 1 {
            let (Some(start), Some(shape)) = (self.dense(1), Self::dims(&it)) else { return Fold::Failed };
            let mut index = 0i64;
            for (s, d) in start.values.iter().zip(&shape) {
                index = index * d.unwrap_or(1) + s.int().map_or(0, |i| i.signed() as i64);
            }
            return Self::splat_of(k.at(index as usize), ty);
        }
        Fold::Failed
    }

    /// `SelectOp::fold`, when no operand needs broadcasting.
    fn select(&self) -> Fold<'a> {
        let ops = &self.b[self.op].operands;
        let shapes: Option<Vec<Vec<Option<i64>>>> = ops.iter().map(|v| Self::dims(&self.b[*v].ty).filter(|d| d.iter().all(Option::is_some))).collect();
        let Some(shapes) = shapes else { return Fold::Failed };
        if shapes.windows(2).any(|w| w[0] != w[1]) {
            return Fold::Failed;
        }
        let (on_true, on_false) = (ops[1], ops[2]);
        if on_true == on_false {
            return Self::value(on_true);
        }
        match self.dense(0).as_ref().and_then(Self::splat) {
            Some(Scalar::Int(p)) => Self::value(if p.is_zero() { on_false } else { on_true }),
            _ => Fold::Failed,
        }
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
            && attr::element_type(&k.ty) == attr::element_type(&ty)
        {
            return Self::splat_of(s, ty);
        }
        let perms: Vec<i64> = match self.b[self.op].get("perms") {
            Some(Attribute::DenseArray { values, .. }) => values.iter().filter_map(|v| v.parse().ok()).collect(),
            _ => return Fold::Failed,
        };
        if perms.iter().enumerate().all(|(i, p)| *p == i as i64) { Self::value(input) } else { Fold::Failed }
    }

    /// A constant single zero.
    fn zero_point(&self, v: ValueId) -> bool {
        let Some(a) = self.b.constant_of(v) else { return false };
        Const::try_from(&a).ok().is_some_and(|k| k.values.iter().all(|s| match s {
            Scalar::Int(i) => i.is_zero(),
            Scalar::Float(f) => f.is_zero(),
        }))
    }

    /// `NegateOp::fold`: `negate(negate(x))`, every zero point 0.
    fn negate(&self) -> Fold<'a> {
        let Some(inner) = self.b.def_named(self.operand(0), "tosa.negate") else { return Fold::Failed };
        let zps = self.b[self.op].operands[1..].iter().chain(&self.b[inner].operands[1..]);
        if zps.clone().count() != 4 || !zps.into_iter().all(|v| self.zero_point(*v)) {
            return Fold::Failed;
        }
        Self::value(self.b[inner].operands[0])
    }

    /// `ConcatOp::fold`: concats on the same axis flattened in.
    fn concat(self) -> Fold<'a> {
        let axis = self.int_attr("axis");
        let mut operands = Vec::new();
        let mut found = false;
        for v in self.b[self.op].operands.clone() {
            match self.b.def_named(v, "tosa.concat") {
                Some(p) if self.b[p].get("axis").and_then(|a| if let Attribute::Int { lit, .. } = a { lit.parse().ok() } else { None }) == axis => {
                    found = true;
                    operands.extend(self.b[p].operands.clone());
                }
                _ => operands.push(v),
            }
        }
        if !found {
            return Fold::Failed;
        }
        self.b.set_operands(self.op, operands);
        Fold::InPlace
    }

    /// `ReciprocalOp::fold`: of a float splat.
    fn reciprocal(&self) -> Fold<'a> {
        let ty = self.result_ty();
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
        let Type::Integer { width, .. } = *attr::element_type(&ty) else { return Fold::Failed };
        if Self::dims(&it).and_then(|d| d.get(axis).copied().flatten()) == Some(1) { Self::splat_of(Scalar::Int(ApInt::zero(width)), ty) } else { Fold::Failed }
    }
}

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
