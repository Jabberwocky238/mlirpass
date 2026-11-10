//! `math` folds (`MathOps.cpp`): constant operands, as `constFoldUnaryOp` /
//! `constFoldBinaryOp` (poison passes through; scalars, splats and dense elements fold element by
//! element), each op the way upstream computes it.
//!
//! ```text
//! APFloat itself     absf ceil floor roundeven copysign          every float type
//! APInt itself       absi ctlz cttz ctpop ipowi
//! the C library      acos ... tanh, round trunc sqrt, atan2 powf  f32 (`cosf`) and f64 (`cos`)
//! classification     isfinite isinf isnan isnormal               scalars and splats only
//! ```
//!
//! What upstream asks of the C library is asked of the C library here too (`std`), so the bits
//! are mlir-opt's on the same host; without `std` only what is exactly rounded (`sqrt`, `round`,
//! `trunc`, from `libm`) folds, and the rest stays.

use mlirformat::{FloatKind, Type};

use crate::ArithFolder as Folder;
use crate::{ApFloat, ApInt, Const, Fold, Folded, Scalar};

/// The C library's `f(double)` / `ff(float)` pairs MLIR folds with; the op is named as `f`.
/// `exact`: correctly rounded, so `libm`'s are the same functions bit for bit (a NaN comes back
/// quieted, as from the C library: the compiler turns calls to these into its own code, which
/// does not quiet, so they are not called).
macro_rules! cmath {
    (exact: $($e:ident $ef:ident),*; inexact: $($f:ident $ff:ident),*;) => {
        #[cfg(feature = "std")]
        mod c {
            unsafe extern "C" {
                $(pub safe fn $f(x: f64) -> f64; pub safe fn $ff(x: f32) -> f32;)*
                pub safe fn atan2(y: f64, x: f64) -> f64;
                pub safe fn atan2f(y: f32, x: f32) -> f32;
                pub safe fn pow(x: f64, y: f64) -> f64;
                pub safe fn cbrt(x: f64) -> f64;
                pub safe fn cbrtf(x: f32) -> f32;
                pub safe fn powf(x: f32, y: f32) -> f32;
            }
        }

        /// The C functions of a unary `math` op, and whether they are exact (`None`: not one, or
        /// not available here).
        fn cmath(op: &str) -> Option<(fn(f64) -> f64, fn(f32) -> f32, bool)> {
            match op {
                $(stringify!($e) => Some((libm::$e, libm::$ef, true)),)*
                #[cfg(feature = "std")]
                "cbrt" => Some((|x| c::cbrt(x), |x| c::cbrtf(x), false)),
                $(#[cfg(feature = "std")]
                stringify!($f) => Some((|x| c::$f(x), |x| c::$ff(x), false)),)*
                _ => None,
            }
        }

        /// The C functions of a binary `math` op.
        #[cfg(feature = "std")]
        fn cmath2(op: &str) -> Option<(fn(f64, f64) -> f64, fn(f32, f32) -> f32)> {
            match op {
                "atan2" => Some((|y, x| c::atan2(y, x), |y, x| c::atan2f(y, x))),
                "powf" => Some((|x, y| c::pow(x, y), |x, y| c::powf(x, y))),
                _ => None,
            }
        }

        #[cfg(not(feature = "std"))]
        fn cmath2(_: &str) -> Option<(fn(f64, f64) -> f64, fn(f32, f32) -> f32)> {
            None
        }
    };
}

cmath! {
    exact: sqrt sqrtf, round roundf, trunc truncf;
    inexact: acos acosf, acosh acoshf, asin asinf, asinh asinhf, atan atanf, atanh atanhf, cos cosf, cosh coshf,
        sin sinf, sinh sinhf, erf erff, erfc erfcf, log logf, log2 log2f, log10 log10f, log1p log1pf, exp expf,
        exp2 exp2f, expm1 expm1f, tan tanf, tanh tanhf;
}

/// What the folds ask of a float beyond mlirformat's [`ApFloat`].
trait FloatFolds: Sized {
    fn through(self, f: fn(f64) -> f64, ff: fn(f32) -> f32) -> Option<Self>;
    fn through2(self, o: Self, f: fn(f64, f64) -> f64, ff: fn(f32, f32) -> f32) -> Option<Self>;
    fn integral(self, round: fn(f64) -> f64) -> Option<Self>;
    fn is_normal(self) -> Option<bool>;
}

/// What the folds ask of an integer beyond mlirformat's [`ApInt`].
trait IntFolds: Sized {
    fn ipowi(self, power: Self) -> Option<Self>;
}

impl FloatFolds for ApFloat {
    /// `APFloat(f(a.convertToDouble()))` / `APFloat(ff(a.convertToFloat()))`: f64 and f32 only.
    fn through(self, f: fn(f64) -> f64, ff: fn(f32) -> f32) -> Option<ApFloat> {
        match self.kind {
            FloatKind::F64 => ApFloat::from_bits(FloatKind::F64, f(f64::from_bits(self.bits)).to_bits()),
            FloatKind::F32 => ApFloat::from_bits(FloatKind::F32, ff(f32::from_bits(self.bits as u32)).to_bits().into()),
            _ => None,
        }
    }

    /// The same, of two operands of one type.
    fn through2(self, o: ApFloat, f: fn(f64, f64) -> f64, ff: fn(f32, f32) -> f32) -> Option<ApFloat> {
        match (self.kind, o.kind) {
            (FloatKind::F64, FloatKind::F64) => ApFloat::from_bits(FloatKind::F64, f(f64::from_bits(self.bits), f64::from_bits(o.bits)).to_bits()),
            (FloatKind::F32, FloatKind::F32) => ApFloat::from_bits(FloatKind::F32, ff(f32::from_bits(self.bits as u32), f32::from_bits(o.bits as u32)).to_bits().into()),
            _ => None,
        }
    }

    /// `APFloat::roundToIntegral` with `round` as the rounding: a NaN comes back quieted.
    fn integral(self, round: fn(f64) -> f64) -> Option<ApFloat> {
        if self.is_nan() {
            return Some(self.quieted());
        }
        ApFloat::from_f64(self.kind, round(self.to_f64()))
    }

    /// `APFloat::isNormal`: the exponent field neither all zeros (zero, denormals) nor all ones
    /// (infinities, NaNs); `None` for a format this does not know the layout of.
    fn is_normal(self) -> Option<bool> {
        let (exp, mant) = crate::float_layout(self.kind)?;
        let e = (self.bits >> mant) & ((1 << exp) - 1);
        Some(e != 0 && e != (1 << exp) - 1)
    }
}

impl IntFolds for ApInt {
    /// `math.ipowi`: `base ** power` wrapping, as upstream; `None` for zero to a negative power.
    fn ipowi(self, power: ApInt) -> Option<ApInt> {
        let w = self.width;
        let (zero, one, minus_one) = (ApInt::zero(w), ApInt::new(w, 1), ApInt::new(w, -1));
        if power.is_zero() {
            return Some(one);
        }
        if power.is_negative() {
            return match () {
                _ if self.is_zero() => None,
                _ if self == one => Some(one),
                _ if self != minus_one => Some(zero),
                _ if power.bits() & 1 == 1 => Some(minus_one),
                _ => Some(one),
            };
        }
        let (mut result, mut base, mut p) = (one, self, power);
        loop {
            if p.bits() & 1 == 1 {
                result = result.mul(base);
            }
            p = p.lshr(1);
            if p.is_zero() {
                return Some(result);
            }
            base = base.mul(base);
        }
    }
}

impl<'x, 'a> Folder<'x, 'a> {
    fn float_unary(&self, f: impl Fn(ApFloat) -> Option<ApFloat>) -> Fold<'a> {
        self.unary(self.ty(), |s| Some(Scalar::Float(f(s.float()?)?)))
    }

    fn int_unary(&self, f: impl Fn(ApInt) -> ApInt) -> Fold<'a> {
        self.unary(self.ty(), |s| Some(Scalar::Int(f(s.int()?))))
    }

    /// `isfinite` / `isinf` / `isnan` / `isnormal`: a float scalar or splat (no poison, no
    /// non-splat elements).
    fn classify(&self, f: impl Fn(ApFloat) -> Option<bool>) -> Fold<'a> {
        let Some(c) = self.cst(0).filter(Const::is_splat) else { return Fold::Failed };
        let Some(a) = c.as_float() else { return Fold::Failed };
        let ty: Type<'a> = self.ty();
        let Some(v) = f(a) else { return Fold::Failed };
        let bit = Scalar::Int(ApInt::new(1, i128::from(v)));
        Fold::from(Folded::Attr(if c.elements { Const::splat(bit, ty).into() } else { Const::scalar(bit, ty).into() }))
    }

    /// ⭐ The fold of a `math` op.
    pub fn math(&mut self) -> Fold<'a> {
        let name = self.b[self.op].name.clone();
        let Some(op) = name.strip_prefix("math.") else { return Fold::Failed };
        match op {
            "absf" => self.float_unary(|a| Some(if a.is_negative() { a.neg() } else { a })),
            "ceil" => self.float_unary(|a| a.integral(libm::ceil)),
            "floor" => self.float_unary(|a| a.integral(libm::floor)),
            "roundeven" => self.float_unary(|a| a.integral(libm::rint)),
            "copysign" => self.binary(None, |a, b| {
                let (a, b) = (a.float()?, b.float()?);
                Some(Scalar::Float(if a.is_negative() != b.is_negative() { a.neg() } else { a }))
            }).map(Folded::Attr).into(),
            "absi" => self.int_unary(|a| if a.is_negative() { a.neg() } else { a }),
            "ctlz" => self.int_unary(|a| ApInt::new(a.width, a.count_leading_zeros().into())),
            "cttz" => self.int_unary(|a| ApInt::new(a.width, a.count_trailing_zeros().into())),
            "ctpop" => self.int_unary(|a| ApInt::new(a.width, a.popcount().into())),
            // (an i1 is ambiguous with signed semantics: not folded)
            "ipowi" => self.binary(None, |a, b| Some(Scalar::Int(a.int().filter(|a| a.width != 1)?.ipowi(b.int()?)?))).map(Folded::Attr).into(),
            // `1 / sqrt(a)`, refusing a negative operand.
            "rsqrt" => self.float_unary(|a| match a.kind {
                _ if a.is_negative() => None,
                FloatKind::F64 => ApFloat::from_bits(FloatKind::F64, (1.0 / f64::from_bits(a.bits).sqrt()).to_bits()),
                FloatKind::F32 => ApFloat::from_bits(FloatKind::F32, (1.0 / f32::from_bits(a.bits as u32).sqrt()).to_bits().into()),
                _ => None,
            }),
            // `pow(base, exp)` when the exponent is exactly a value of the base's type.
            "fpowi" => {
                let Some((f, ff)) = cmath2("powf") else { return Fold::Failed };
                let (Some(l), Some(r)) = (self.cst(0), self.cst(1)) else { return Fold::Failed };
                if l.elements != r.elements || l.ty.shape() != r.ty.shape() {
                    return Fold::Failed;
                }
                let n = if l.is_splat() && r.is_splat() { 1 } else { l.values.len().max(r.values.len()) };
                let pow = |a: Scalar, b: Scalar| -> Option<Scalar> {
                    let (a, e) = (a.float()?, b.int()?.signed());
                    let exp = match a.kind {
                        FloatKind::F64 => ((e as f64) as i128 == e).then(|| e as f64)?,
                        FloatKind::F32 => ((e as f32) as i128 == e).then(|| f64::from(e as f32))?,
                        _ => return None,
                    };
                    Some(Scalar::Float(a.through2(ApFloat::from_f64(a.kind, exp)?, f, ff)?))
                };
                let Some(values) = (0..n).map(|i| pow(l.at(i), r.at(i))).collect::<Option<alloc::vec::Vec<_>>>() else { return Fold::Failed };
                Folded::Attr(Const { ty: l.ty.clone(), values, elements: l.elements }.into()).into()
            }
            // Both `sin` and `cos` fold, or neither.
            "sincos" => {
                let (Some((sin, sinf, _)), Some((cos, cosf, _))) = (cmath("sin"), cmath("cos")) else { return Fold::Failed };
                let ty = self.ty();
                let folded = |f: fn(f64) -> f64, ff: fn(f32) -> f32| match self.unary(ty.clone(), |x| Some(Scalar::Float(x.float()?.through(f, ff)?))) {
                    Fold::Results(r) => r.into_iter().next(),
                    _ => None,
                };
                match (folded(sin, sinf), folded(cos, cosf)) {
                    (Some(s), Some(c)) => Fold::Results(alloc::vec![s, c]),
                    _ => Fold::Failed,
                }
            }
            "isfinite" => self.classify(|a| Some(!a.is_nan() && !a.is_inf())),
            "isinf" => self.classify(|a| Some(a.is_inf())),
            "isnan" => self.classify(|a| Some(a.is_nan())),
            "isnormal" => self.classify(ApFloat::is_normal),
            "atan2" | "powf" => {
                let Some((f, ff)) = cmath2(op) else { return Fold::Failed };
                let atan2 = op == "atan2";
                self.binary(None, |a, b| {
                    let (a, b) = (a.float()?, b.float()?);
                    // `atan2(±0, ±0)`: the default NaN, not what the C library says.
                    if atan2 && a.is_zero() && b.is_zero() {
                        return Some(Scalar::Float(ApFloat::nan(a.kind)));
                    }
                    Some(Scalar::Float(a.through2(b, f, ff)?))
                })
                .map(Folded::Attr)
                .into()
            }
            _ => {
                let Some((f, ff, exact)) = cmath(op) else { return Fold::Failed };
                // What each refuses: a negative operand (`-0.0` and NaNs with the sign set included).
                let refuses = |a: ApFloat| match op {
                    "log" | "log2" | "log10" | "sqrt" => a.is_negative(),
                    "log1p" => match a.kind {
                        FloatKind::F64 => (f64::from_bits(a.bits) + 1.0).is_sign_negative(),
                        _ => (f32::from_bits(a.bits as u32) + 1.0).is_sign_negative(),
                    },
                    _ => false,
                };
                self.float_unary(|a| match () {
                    _ if refuses(a) => None,
                    _ if exact && a.is_nan() && matches!(a.kind, FloatKind::F32 | FloatKind::F64) => Some(a.quieted()),
                    _ => a.through(f, ff),
                })
            }
        }
    }
}
