//! ⭐ Constant attributes as numbers: `IntegerAttr`, `FloatAttr`, `BoolAttr` and
//! `DenseElementsAttr` (splat or not) ⇄ [`Const`], printed back exactly as MLIR prints them.

use alloc::borrow::Cow;
use alloc::format;
use alloc::string::String;
use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{Attribute, Dim, Extended, FloatKind, Shaped, ShapedKind, Signedness, Type};

use crate::{ApFloat, ApInt};

/// One element.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Scalar {
    Int(ApInt),
    Float(ApFloat),
}

impl Scalar {
    pub fn int(self) -> Option<ApInt> {
        match self {
            Scalar::Int(i) => Some(i),
            Scalar::Float(_) => None,
        }
    }

    pub fn float(self) -> Option<ApFloat> {
        match self {
            Scalar::Float(f) => Some(f),
            Scalar::Int(_) => None,
        }
    }
}

/// A constant: `values` (one per element; one for a scalar or a splat) of type `ty`.
#[derive(Debug, Clone, PartialEq)]
pub struct Const<'a> {
    pub ty: Type<'a>,
    pub values: Vec<Scalar>,
    /// A `DenseElementsAttr` (`ty` is shaped), as opposed to a scalar attribute.
    pub elements: bool,
}

/// What an integer type means for its values: width and signedness.
pub fn int_width(ty: &Type<'_>) -> Option<(u32, Signedness)> {
    match ty {
        Type::Integer { signedness, width } => Some((*width, *signedness)),
        // `IndexType::kInternalStorageBitWidth`.
        Type::Index => Some((64, Signedness::Signless)),
        _ => None,
    }
}

/// The element type of a shaped type, or the type itself.
pub fn element_type<'x, 'a>(ty: &'x Type<'a>) -> &'x Type<'a> {
    match ty {
        Type::Shaped(s) => &s.elem,
        t => t,
    }
}

/// A static shape's element count; `None` when dynamic or unranked.
pub fn element_count(ty: &Type<'_>) -> Option<usize> {
    let Type::Shaped(s) = ty else { return Some(1) };
    s.shape.as_ref()?.iter().try_fold(1usize, |n, d| match d {
        Dim::Static(k) | Dim::Scalable(k) => Some(n * *k as usize),
        Dim::Dynamic => None,
    })
}

impl Scalar {
    /// An element literal of element type `ty`.
    fn parse(lit: &str, ty: &Type<'_>) -> Option<Self> {
        let lit = lit.trim();
        match ty {
            Type::Float(k) => {
                // Integer-looking hex is the bits; a decimal integer is the value.
                let f = if lit.starts_with("0x") || lit.contains(['.', 'e', 'E']) || lit.contains("inf") || lit.contains("nan") {
                    ApFloat::parse(*k, lit)?
                } else {
                    ApFloat::from_f64(*k, lit.parse::<f64>().ok()?)?
                };
                Some(Scalar::Float(f))
            }
            t => {
                let (w, sign) = int_width(t)?;
                let v = match lit {
                    "true" => 1,
                    "false" => 0,
                    _ => match lit.strip_prefix("0x") {
                        Some(h) => u128::from_str_radix(h, 16).ok()? as i128,
                        None if sign == Signedness::Unsigned => lit.parse::<u128>().ok()? as i128,
                        None => lit.parse::<i128>().ok()?,
                    },
                };
                Some(Scalar::Int(ApInt::new(w, v)))
            }
        }
    }

    /// The element as MLIR prints it for element type `ty`.
    fn print(self, ty: &Type<'_>) -> String {
        match self {
            Scalar::Float(f) => f.print(),
            Scalar::Int(i) => match int_width(ty) {
                Some((1, _)) => String::from(if i.is_zero() { "false" } else { "true" }),
                Some((_, Signedness::Unsigned)) => format!("{}", i.unsigned()),
                _ => format!("{}", i.signed()),
            },
        }
    }
}

impl<'a> Const<'a> {
    pub fn scalar(value: Scalar, ty: Type<'a>) -> Self {
        Self { ty, values: vec![value], elements: false }
    }

    /// A splat of `value` over shaped `ty`.
    pub fn splat(value: Scalar, ty: Type<'a>) -> Self {
        Self { ty, values: vec![value], elements: true }
    }

    pub fn int(value: ApInt, ty: Type<'a>) -> Self {
        Self::scalar(Scalar::Int(value), ty)
    }

    pub fn is_splat(&self) -> bool {
        self.values.len() == 1
    }

    /// The single value of a scalar or a splat.
    pub fn splat_value(&self) -> Option<Scalar> {
        self.is_splat().then(|| self.values[0])
    }

    /// `m_ConstantInt`: an integer scalar or splat.
    pub fn as_int(&self) -> Option<ApInt> {
        self.splat_value()?.int()
    }

    pub fn as_float(&self) -> Option<ApFloat> {
        self.splat_value()?.float()
    }

    /// The same constant with every element through `f` (result element type `ty`).
    pub fn map(&self, ty: Type<'a>, f: impl Fn(Scalar) -> Option<Scalar>) -> Option<Self> {
        Some(Self { ty, values: self.values.iter().map(|v| f(*v)).collect::<Option<_>>()?, elements: self.elements })
    }

    /// `getValues<int64_t>`: every element as an integer, a splat repeated over the shape.
    pub fn ints(&self) -> Option<Vec<i64>> {
        let n = if self.is_splat() { element_count(&self.ty)? } else { self.values.len() };
        (0..n).map(|i| self.at(i).int().map(|v| v.signed() as i64)).collect()
    }

    /// Element `i` (a splat repeats).
    pub fn at(&self, i: usize) -> Scalar {
        if self.is_splat() { self.values[0] } else { self.values[i] }
    }

    fn dense_body(&self) -> String {
        let elem = element_type(&self.ty);
        if self.values.len() == 1 || self.values.windows(2).all(|w| w[0] == w[1]) && !self.values.is_empty() {
            return format!("<{}>", self.values[0].print(elem));
        }
        let Type::Shaped(Shaped { shape: Some(shape), .. }) = &self.ty else { return String::from("<>") };
        let dims: Vec<usize> = shape.iter().map(|d| if let Dim::Static(k) | Dim::Scalable(k) = d { *k as usize } else { 0 }).collect();
        if self.values.is_empty() {
            return String::from("<>");
        }
        let mut out = String::from("<");
        self.nest(&dims, 0, &mut 0, elem, &mut out);
        out.push('>');
        out
    }

    fn nest(&self, dims: &[usize], depth: usize, at: &mut usize, elem: &Type<'_>, out: &mut String) {
        if depth == dims.len() {
            out.push_str(&self.values[*at].print(elem));
            *at += 1;
            return;
        }
        out.push('[');
        for i in 0..dims[depth] {
            if i > 0 {
                out.push_str(", ");
            }
            self.nest(dims, depth + 1, at, elem, out);
        }
        out.push(']');
    }
}

impl<'a> From<Const<'a>> for Attribute<'a> {
    fn from(c: Const<'a>) -> Self {
        if c.elements {
            let body = c.dense_body();
            return Attribute::Builtin { name: "dense".into(), body: Cow::Owned(body), ty: Some(c.ty) };
        }
        match c.values[0] {
            Scalar::Int(i) if matches!(c.ty, Type::Integer { width: 1, .. }) => Attribute::Bool(!i.is_zero()),
            v @ Scalar::Int(_) => Attribute::Int { lit: Cow::Owned(v.print(&c.ty)), ty: Some(c.ty) },
            v @ Scalar::Float(f) => {
                let lit = v.print(&c.ty);
                // A float printed as its bits reads back as an integer literal.
                if lit.starts_with("0x") {
                    let _ = f;
                    Attribute::Int { lit: Cow::Owned(lit), ty: Some(c.ty) }
                } else {
                    Attribute::Float { lit: Cow::Owned(lit), ty: Some(c.ty) }
                }
            }
        }
    }
}

impl<'a> TryFrom<&Attribute<'a>> for Const<'a> {
    type Error = ();

    /// Integer, float and bool attributes, and `dense<...>` of int or float elements.
    fn try_from(a: &Attribute<'a>) -> Result<Self, ()> {
        match a {
            Attribute::Bool(b) => Ok(Const::int(ApInt::new(1, i128::from(*b)), Type::I1)),
            Attribute::Int { lit, ty: Some(ty) } | Attribute::Float { lit, ty: Some(ty) } => Scalar::parse(lit, ty).map(|v| Const::scalar(v, ty.clone())).ok_or(()),
            Attribute::Builtin { name, body, ty: Some(ty) } if name == "dense" => {
                let elem = element_type(ty);
                let inner = body.strip_prefix('<').and_then(|b| b.strip_suffix('>')).ok_or(())?.trim();
                if inner.starts_with('"') || inner.starts_with('(') {
                    return Err(());
                }
                let flat: Vec<&str> = inner.split(|c| matches!(c, '[' | ']' | ',')).map(str::trim).filter(|s| !s.is_empty()).collect();
                let values = flat.iter().map(|l| Scalar::parse(l, elem)).collect::<Option<Vec<_>>>().ok_or(())?;
                if !inner.starts_with('[') && values.len() != 1 && element_count(ty) != Some(0) {
                    return Err(());
                }
                if values.len() > 1 && element_count(ty) != Some(values.len()) {
                    return Err(());
                }
                Ok(Const { ty: ty.clone(), values, elements: true })
            }
            _ => Err(()),
        }
    }
}

/// `#ub.poison`.
pub fn is_poison(a: &Attribute<'_>) -> bool {
    matches!(a, Attribute::Extended { ext: Extended { name, .. }, .. } if name == "ub.poison")
}

/// A shaped type's dims, when ranked.
pub fn shape_of<'x>(ty: &'x Type<'_>) -> Option<&'x [Dim]> {
    match ty {
        Type::Shaped(s) => s.shape.as_deref(),
        _ => None,
    }
}

/// `ty` with element type `elem` (a scalar type is replaced outright).
pub fn with_element<'a>(ty: &Type<'a>, elem: Type<'a>) -> Type<'a> {
    match ty {
        Type::Shaped(s) => Type::Shaped(Shaped { kind: s.kind, shape: s.shape.clone(), elem: elem.into(), extras: if s.kind == ShapedKind::Vector { Vec::new() } else { s.extras.clone() } }),
        _ => elem,
    }
}

/// The width of a scalar int or float element type.
pub fn bit_width(ty: &Type<'_>) -> Option<u32> {
    match element_type(ty) {
        Type::Integer { width, .. } => Some(*width),
        Type::Index => Some(64),
        Type::Float(k) => Some(match k {
            FloatKind::F16 | FloatKind::BF16 => 16,
            FloatKind::TF32 => 19,
            FloatKind::F32 => 32,
            FloatKind::F64 => 64,
            FloatKind::F80 => 80,
            FloatKind::F128 => 128,
            FloatKind::F4E2M1FN => 4,
            FloatKind::F6E2M3FN | FloatKind::F6E3M2FN => 6,
            _ => 8,
        }),
        _ => None,
    }
}

