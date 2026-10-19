//! `APInt` and `APFloat`, as far as folding needs them, and MLIR's way of printing a float.
//!
//! Integers are up to 128 bits wide. Floats are the IEEE-like formats (`f16`, `bf16`, `tf32`,
//! `f32`, `f64`); arithmetic on the narrow ones goes through `f32`, which is exact enough that
//! the one final rounding is the correct one.

use alloc::string::String;
use alloc::vec;
use alloc::vec::Vec;
use core::cmp::Ordering;

use mlirformat::FloatKind;

/// A fixed-width two's-complement integer.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub struct ApInt {
    pub width: u32,
    bits: u128,
}

impl ApInt {
    fn mask(width: u32) -> u128 {
        if width >= 128 { u128::MAX } else { (1u128 << width) - 1 }
    }

    /// `value` truncated to `width` bits.
    pub fn new(width: u32, value: i128) -> Self {
        Self { width, bits: value as u128 & Self::mask(width) }
    }

    pub fn from_bits(width: u32, bits: u128) -> Self {
        Self { width, bits: bits & Self::mask(width) }
    }

    pub fn zero(width: u32) -> Self {
        Self { width, bits: 0 }
    }

    pub fn all_ones(width: u32) -> Self {
        Self { width, bits: Self::mask(width) }
    }

    pub fn bits(self) -> u128 {
        self.bits
    }

    pub fn unsigned(self) -> u128 {
        self.bits
    }

    pub fn signed(self) -> i128 {
        if self.width == 0 || self.width >= 128 {
            return self.bits as i128;
        }
        let shift = 128 - self.width;
        ((self.bits << shift) as i128) >> shift
    }

    pub fn is_zero(self) -> bool {
        self.bits == 0
    }

    pub fn is_one(self) -> bool {
        self.bits == 1
    }

    pub fn is_all_ones(self) -> bool {
        self.bits == Self::mask(self.width)
    }

    pub fn is_negative(self) -> bool {
        self.width > 0 && (self.bits >> (self.width - 1)) & 1 == 1
    }

    pub fn signed_min(width: u32) -> Self {
        Self::from_bits(width, 1u128 << (width - 1))
    }

    pub fn signed_max(width: u32) -> Self {
        Self::from_bits(width, (1u128 << (width - 1)) - 1)
    }

    pub fn is_signed_min(self) -> bool {
        self == Self::signed_min(self.width)
    }

    pub fn sext(self, width: u32) -> Self {
        Self::new(width, self.signed())
    }

    pub fn zext(self, width: u32) -> Self {
        Self::from_bits(width, self.bits)
    }

    pub fn trunc(self, width: u32) -> Self {
        Self::from_bits(width, self.bits)
    }

    pub fn add(self, o: Self) -> Self {
        Self::from_bits(self.width, self.bits.wrapping_add(o.bits))
    }

    pub fn sub(self, o: Self) -> Self {
        Self::from_bits(self.width, self.bits.wrapping_sub(o.bits))
    }

    pub fn mul(self, o: Self) -> Self {
        Self::from_bits(self.width, self.bits.wrapping_mul(o.bits))
    }

    pub fn neg(self) -> Self {
        Self::zero(self.width).sub(self)
    }

    pub fn not(self) -> Self {
        Self::from_bits(self.width, !self.bits)
    }

    pub fn and(self, o: Self) -> Self {
        Self::from_bits(self.width, self.bits & o.bits)
    }

    pub fn or(self, o: Self) -> Self {
        Self::from_bits(self.width, self.bits | o.bits)
    }

    pub fn xor(self, o: Self) -> Self {
        Self::from_bits(self.width, self.bits ^ o.bits)
    }

    pub fn udiv(self, o: Self) -> Option<Self> {
        (!o.is_zero()).then(|| Self::from_bits(self.width, self.bits / o.bits))
    }

    pub fn urem(self, o: Self) -> Option<Self> {
        (!o.is_zero()).then(|| Self::from_bits(self.width, self.bits % o.bits))
    }

    /// Signed division, wrapping `MIN / -1`.
    pub fn sdiv(self, o: Self) -> Option<Self> {
        (!o.is_zero()).then(|| Self::new(self.width, self.signed().wrapping_div(o.signed())))
    }

    pub fn srem(self, o: Self) -> Option<Self> {
        (!o.is_zero()).then(|| Self::new(self.width, self.signed().wrapping_rem(o.signed())))
    }

    /// `sdiv_ov`: also whether it overflowed (`MIN / -1`).
    pub fn sdiv_ov(self, o: Self) -> Option<(Self, bool)> {
        let q = self.sdiv(o)?;
        Some((q, self.is_signed_min() && o.is_all_ones()))
    }

    pub fn shl(self, by: u32) -> Self {
        if by >= self.width { Self::zero(self.width) } else { Self::from_bits(self.width, self.bits << by) }
    }

    pub fn lshr(self, by: u32) -> Self {
        if by >= self.width { Self::zero(self.width) } else { Self::from_bits(self.width, self.bits >> by) }
    }

    pub fn ashr(self, by: u32) -> Self {
        let by = by.min(self.width.saturating_sub(1));
        Self::new(self.width, self.signed() >> by)
    }

    pub fn scmp(self, o: Self) -> Ordering {
        self.signed().cmp(&o.signed())
    }

    pub fn ucmp(self, o: Self) -> Ordering {
        self.bits.cmp(&o.bits)
    }

    /// Signed addition overflowed?
    pub fn sadd_ov(self, o: Self) -> (Self, bool) {
        let r = self.add(o);
        (r, self.is_negative() == o.is_negative() && r.is_negative() != self.is_negative())
    }

    pub fn uadd_ov(self, o: Self) -> (Self, bool) {
        let r = self.add(o);
        (r, r.bits < self.bits)
    }

    pub fn ssub_ov(self, o: Self) -> (Self, bool) {
        let r = self.sub(o);
        (r, self.is_negative() != o.is_negative() && r.is_negative() != self.is_negative())
    }

    pub fn usub_ov(self, o: Self) -> (Self, bool) {
        (self.sub(o), o.bits > self.bits)
    }

    pub fn smul_ov(self, o: Self) -> (Self, bool) {
        let r = self.mul(o);
        let ov = match self.signed().checked_mul(o.signed()) {
            Some(full) => Self::new(self.width, full).signed() != full,
            None => true,
        };
        (r, ov)
    }

    pub fn umul_ov(self, o: Self) -> (Self, bool) {
        let r = self.mul(o);
        let ov = match self.bits.checked_mul(o.bits) {
            Some(full) => full > Self::mask(self.width),
            None => true,
        };
        (r, ov)
    }

    pub fn count_leading_zeros(self) -> u32 {
        if self.bits == 0 { self.width } else { self.width - (128 - self.bits.leading_zeros()) }
    }

    pub fn count_trailing_zeros(self) -> u32 {
        if self.bits == 0 { self.width } else { self.bits.trailing_zeros() }
    }

    pub fn popcount(self) -> u32 {
        self.bits.count_ones()
    }

    pub fn is_power_of_two(self) -> bool {
        self.bits != 0 && self.bits & (self.bits - 1) == 0
    }

    pub fn log2(self) -> u32 {
        127 - self.bits.leading_zeros()
    }
}

/// An unbounded unsigned integer, for exact decimal conversion of floats.
#[derive(Debug, Clone, PartialEq, Eq)]
struct BigUint(Vec<u32>);

impl BigUint {
    fn from_u128(mut v: u128) -> Self {
        let mut out = Vec::new();
        while v != 0 {
            out.push(v as u32);
            v >>= 32;
        }
        Self(out)
    }

    fn is_zero(&self) -> bool {
        self.0.is_empty()
    }

    fn trim(&mut self) {
        while self.0.last() == Some(&0) {
            self.0.pop();
        }
    }

    fn bits(&self) -> u32 {
        match self.0.last() {
            None => 0,
            Some(top) => (self.0.len() as u32 - 1) * 32 + (32 - top.leading_zeros()),
        }
    }

    fn mul(&self, o: &Self) -> Self {
        let mut out = vec![0u32; self.0.len() + o.0.len()];
        for (i, a) in self.0.iter().enumerate() {
            let mut carry = 0u64;
            for (j, b) in o.0.iter().enumerate() {
                let v = out[i + j] as u64 + *a as u64 * *b as u64 + carry;
                out[i + j] = v as u32;
                carry = v >> 32;
            }
            let mut k = i + o.0.len();
            while carry != 0 {
                let v = out[k] as u64 + carry;
                out[k] = v as u32;
                carry = v >> 32;
                k += 1;
            }
        }
        let mut r = Self(out);
        r.trim();
        r
    }

    fn shl(&mut self, by: u32) {
        let (words, bits) = ((by / 32) as usize, by % 32);
        if bits > 0 {
            let mut carry = 0u32;
            for d in &mut self.0 {
                let v = (*d << bits) | carry;
                carry = *d >> (32 - bits);
                *d = v;
            }
            if carry != 0 {
                self.0.push(carry);
            }
        }
        if words > 0 && !self.is_zero() {
            let mut v = vec![0u32; words];
            v.extend_from_slice(&self.0);
            self.0 = v;
        }
    }

    /// Divides in place by `d`, returning the remainder.
    fn divrem_small(&mut self, d: u32) -> u32 {
        let mut rem = 0u64;
        for x in self.0.iter_mut().rev() {
            let v = (rem << 32) | *x as u64;
            *x = (v / d as u64) as u32;
            rem = v % d as u64;
        }
        self.trim();
        rem as u32
    }

    fn pow(base: u32, mut e: u32) -> Self {
        let mut out = Self::from_u128(1);
        let mut b = Self::from_u128(base as u128);
        while e > 0 {
            if e & 1 == 1 {
                out = out.mul(&b);
            }
            e >>= 1;
            if e > 0 {
                b = b.mul(&b);
            }
        }
        out
    }

    /// Long division by a big divisor (shift-and-subtract; numbers here are small).
    fn div(&self, d: &Self) -> Self {
        if d.0.len() == 1 {
            let mut q = self.clone();
            q.divrem_small(d.0[0]);
            return q;
        }
        let mut q = Self(Vec::new());
        let mut r = Self(Vec::new());
        for i in (0..self.bits()).rev() {
            r.shl(1);
            if (self.0[(i / 32) as usize] >> (i % 32)) & 1 == 1 {
                if r.0.is_empty() {
                    r.0.push(1);
                } else {
                    r.0[0] |= 1;
                }
            }
            if r.cmp_big(d) != Ordering::Less {
                r.sub_assign(d);
                q.set_bit(i);
            }
        }
        q.trim();
        q
    }

    fn set_bit(&mut self, i: u32) {
        let w = (i / 32) as usize;
        if self.0.len() <= w {
            self.0.resize(w + 1, 0);
        }
        self.0[w] |= 1 << (i % 32);
    }

    fn cmp_big(&self, o: &Self) -> Ordering {
        self.0.len().cmp(&o.0.len()).then_with(|| self.0.iter().rev().cmp(o.0.iter().rev()))
    }

    fn sub_assign(&mut self, o: &Self) {
        let mut borrow = 0i64;
        for i in 0..self.0.len() {
            let v = self.0[i] as i64 - o.0.get(i).copied().unwrap_or(0) as i64 - borrow;
            borrow = i64::from(v < 0);
            self.0[i] = (v + (borrow << 32)) as u32;
        }
        self.trim();
    }

    fn trailing_zeros(&self) -> u32 {
        let mut n = 0;
        for d in &self.0 {
            if *d == 0 {
                n += 32;
            } else {
                return n + d.trailing_zeros();
            }
        }
        n
    }

    fn shr(&mut self, by: u32) {
        let (words, bits) = ((by / 32) as usize, by % 32);
        self.0.drain(..words.min(self.0.len()));
        if bits > 0 {
            let mut carry = 0u32;
            for d in self.0.iter_mut().rev() {
                let v = (*d >> bits) | carry;
                carry = *d << (32 - bits);
                *d = v;
            }
        }
        self.trim();
    }
}

/// The layout of an IEEE-like format: exponent bits and stored mantissa bits.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
struct Layout {
    exp: u32,
    mant: u32,
}

impl Layout {
    fn of(kind: FloatKind) -> Option<Self> {
        Some(match kind {
            FloatKind::F16 => Self { exp: 5, mant: 10 },
            FloatKind::BF16 => Self { exp: 8, mant: 7 },
            FloatKind::TF32 => Self { exp: 8, mant: 10 },
            FloatKind::F32 => Self { exp: 8, mant: 23 },
            FloatKind::F64 => Self { exp: 11, mant: 52 },
            _ => return None,
        })
    }

    fn bias(self) -> i32 {
        (1 << (self.exp - 1)) - 1
    }

    fn width(self) -> u32 {
        1 + self.exp + self.mant
    }

    /// Precision, hidden bit included.
    fn precision(self) -> u32 {
        self.mant + 1
    }

    /// `f64` ⇒ this layout, rounding to nearest, ties to even.
    fn round(self, x: f64) -> u64 {
        let b = x.to_bits();
        let top = (b >> 63) << (self.exp + self.mant);
        let emax = (1u64 << self.exp) - 1;
        if x.is_nan() {
            // The top payload bits survive; the result is quiet.
            let payload = (b & ((1 << 52) - 1)) >> (52 - self.mant);
            return top | (emax << self.mant) | payload | (1 << (self.mant - 1));
        }
        if x.is_infinite() {
            return top | (emax << self.mant);
        }
        if x == 0.0 {
            return top;
        }
        // x = m * 2^e2 with m normalized to 53 bits.
        let raw_e = ((b >> 52) & 0x7ff) as i32;
        let (mut m, mut e2) = if raw_e == 0 { (b & ((1 << 52) - 1), -1074) } else { ((b & ((1 << 52) - 1)) | (1 << 52), raw_e - 1075) };
        while m < (1 << 52) {
            m <<= 1;
            e2 -= 1;
        }
        let mut ue = e2 + 52;
        let min_e = 1 - self.bias();
        let subnormal = ue < min_e;
        let shift = 52 - self.mant as i32 + if subnormal { min_e - ue } else { 0 };
        if shift > 60 {
            return top;
        }
        let (m, shift) = (m as u128, shift as u32);
        let mut r = m >> shift;
        let rest = m & ((1u128 << shift) - 1);
        let half = 1u128 << (shift - 1);
        if rest > half || (rest == half && r & 1 == 1) {
            r += 1;
        }
        if subnormal {
            // r may have carried into the smallest normal: the exponent field reads 1 then.
            return top | r as u64;
        }
        if r == 1 << (self.mant + 1) {
            r >>= 1;
            ue += 1;
        }
        let biased = (ue + self.bias()) as u64;
        if biased >= emax {
            return top | (emax << self.mant);
        }
        top | (biased << self.mant) | (r as u64 & ((1 << self.mant) - 1))
    }

    fn to_f64(self, bits: u64) -> f64 {
        let sign = (bits >> (self.exp + self.mant)) & 1;
        let e = ((bits >> self.mant) & ((1 << self.exp) - 1)) as i32;
        let m = bits & ((1 << self.mant) - 1);
        let emax = (1i32 << self.exp) - 1;
        let mag = if e == emax {
            if m == 0 { f64::INFINITY } else { f64::from_bits(0x7ff8_0000_0000_0000 | (m << (52 - self.mant))) }
        } else if e == 0 {
            m as f64 * libm_exp2(1 - self.bias() - self.mant as i32)
        } else {
            (m | (1 << self.mant)) as f64 * libm_exp2(e - self.bias() - self.mant as i32)
        };
        if sign == 1 { -mag } else { mag }
    }
}

/// `2^e`, exactly.
fn libm_exp2(e: i32) -> f64 {
    if e >= -1022 {
        f64::from_bits(((e + 1023) as u64) << 52)
    } else {
        f64::from_bits(1u64 << (52 + e + 1022))
    }
}

/// An IEEE-like float of one of the supported formats, as its bits.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct ApFloat {
    pub kind: FloatKind,
    pub bits: u64,
}

impl ApFloat {
    fn layout(self) -> Layout {
        Layout::of(self.kind).expect("unsupported float format")
    }

    pub fn supported(kind: FloatKind) -> bool {
        Layout::of(kind).is_some()
    }

    pub fn from_f64(kind: FloatKind, x: f64) -> Option<Self> {
        let l = Layout::of(kind)?;
        Some(Self { kind, bits: if kind == FloatKind::F64 { x.to_bits() } else { l.round(x) } })
    }

    pub fn from_bits(kind: FloatKind, bits: u64) -> Option<Self> {
        Layout::of(kind).map(|l| Self { kind, bits: bits & ((1u128 << l.width()) - 1) as u64 })
    }

    /// A literal as MLIR spells it: decimal, or `0x...` bits.
    pub fn parse(kind: FloatKind, lit: &str) -> Option<Self> {
        if let Some(hex) = lit.strip_prefix("0x").or_else(|| lit.strip_prefix("0X")) {
            return Self::from_bits(kind, u64::from_str_radix(hex, 16).ok()?);
        }
        if kind == FloatKind::F32 {
            return Some(Self { kind, bits: lit.parse::<f32>().ok()?.to_bits() as u64 });
        }
        Self::from_f64(kind, lit.parse::<f64>().ok()?)
    }

    pub fn to_f64(self) -> f64 {
        if self.kind == FloatKind::F64 { f64::from_bits(self.bits) } else { self.layout().to_f64(self.bits) }
    }

    pub fn is_nan(self) -> bool {
        self.to_f64().is_nan()
    }

    pub fn is_zero(self) -> bool {
        self.to_f64() == 0.0
    }

    pub fn is_negative(self) -> bool {
        (self.bits >> (self.layout().width() - 1)) & 1 == 1
    }

    pub fn is_inf(self) -> bool {
        self.to_f64().is_infinite()
    }

    /// The default quiet NaN `APFloat` makes for an invalid operation (positive).
    /// `APFloat::getLargest`.
    pub fn largest(kind: FloatKind, negative: bool) -> Self {
        let l = Layout::of(kind).expect("unsupported float format");
        let bits = (((1u64 << l.exp) - 2) << l.mant) | ((1u64 << l.mant) - 1) | (u64::from(negative) << (l.exp + l.mant));
        Self { kind, bits }
    }

    pub fn nan(kind: FloatKind) -> Self {
        let l = Layout::of(kind).expect("unsupported float format");
        Self { kind, bits: (((1u64 << l.exp) - 1) << l.mant) | (1 << (l.mant - 1)) }
    }

    pub fn quieted(self) -> Self {
        let l = self.layout();
        Self { kind: self.kind, bits: self.bits | (1 << (l.mant - 1)) }
    }

    /// One arithmetic step with `APFloat`'s NaN rules: a NaN operand comes back (quieted, the
    /// first one first); an invalid operation gives the default NaN.
    pub fn binary(self, o: Self, f32_op: fn(f32, f32) -> f32, f64_op: fn(f64, f64) -> f64) -> Self {
        if self.is_nan() {
            return self.quieted();
        }
        if o.is_nan() {
            return o.quieted();
        }
        let r = if self.kind == FloatKind::F64 {
            Self { kind: self.kind, bits: f64_op(self.to_f64(), o.to_f64()).to_bits() }
        } else {
            let v = f32_op(self.to_f64() as f32, o.to_f64() as f32);
            Self::from_f64(self.kind, v as f64).expect("supported")
        };
        if r.is_nan() { Self::nan(self.kind) } else { r }
    }

    pub fn add(self, o: Self) -> Self {
        self.binary(o, |a, b| a + b, |a, b| a + b)
    }

    pub fn sub(self, o: Self) -> Self {
        self.binary(o, |a, b| a - b, |a, b| a - b)
    }

    pub fn mul(self, o: Self) -> Self {
        self.binary(o, |a, b| a * b, |a, b| a * b)
    }

    pub fn div(self, o: Self) -> Self {
        self.binary(o, |a, b| a / b, |a, b| a / b)
    }

    pub fn neg(self) -> Self {
        Self { kind: self.kind, bits: self.bits ^ (1 << (self.layout().width() - 1)) }
    }

    /// Converts to another format (round to nearest even).
    pub fn convert(self, kind: FloatKind) -> Option<Self> {
        Self::from_f64(kind, self.to_f64())
    }

    /// `APFloat::compare`: `None` when unordered.
    pub fn compare(self, o: Self) -> Option<Ordering> {
        self.to_f64().partial_cmp(&o.to_f64())
    }

    /// Significand (hidden bit included) and exponent: the value is `sig * 2^exp`.
    fn decompose(self) -> (u128, i32) {
        let l = self.layout();
        let e = ((self.bits >> l.mant) & ((1 << l.exp) - 1)) as i32;
        let m = (self.bits & ((1 << l.mant) - 1)) as u128;
        if e == 0 { (m, 1 - l.bias() - l.mant as i32) } else { (m | (1 << l.mant), e - l.bias() - l.mant as i32) }
    }

    /// `APFloat::toString`.
    pub fn to_string_with(self, precision: u32, max_padding: u32, truncate_zero: bool) -> String {
        let mut out = String::new();
        if self.is_inf() {
            out.push_str(if self.is_negative() { "-Inf" } else { "+Inf" });
            return out;
        }
        if self.is_nan() {
            out.push_str("NaN");
            return out;
        }
        if self.is_zero() {
            if self.is_negative() {
                out.push('-');
            }
            if max_padding == 0 {
                if truncate_zero {
                    out.push_str("0.0E+0");
                } else {
                    out.push_str("0.0");
                    for _ in 1..precision.max(1) {
                        out.push('0');
                    }
                    out.push_str("e+00");
                }
            } else {
                out.push('0');
            }
            return out;
        }
        let (sig, exp) = self.decompose();
        Self::to_string_impl(&mut out, self.is_negative(), exp, sig, self.layout().precision(), precision, max_padding, truncate_zero);
        out
    }

    #[allow(clippy::too_many_arguments)]
    fn to_string_impl(out: &mut String, neg: bool, mut exp: i32, sig: u128, sem_precision: u32, mut precision: u32, max_padding: u32, truncate_zero: bool) {
        if neg {
            out.push('-');
        }
        if precision == 0 {
            precision = 2 + sem_precision * 59 / 196;
        }
        let mut s = BigUint::from_u128(sig);
        let tz = s.trailing_zeros();
        exp += tz as i32;
        s.shr(tz);
        if exp > 0 {
            s.shl(exp as u32);
            exp = 0;
        } else if exp < 0 {
            s = s.mul(&BigUint::pow(5, (-exp) as u32));
        }
        // AdjustToPrecision, on the integer.
        let bits = s.bits();
        let required = (precision * 196 + 58) / 59;
        if bits > required {
            let removable = (bits - required) * 59 / 196;
            if removable > 0 {
                exp += removable as i32;
                s = s.div(&BigUint::pow(10, removable));
            }
        }
        // Digits, least significant first; trailing zeros counted into the exponent.
        let mut buf: Vec<u8> = Vec::new();
        let mut trail = true;
        while !s.is_zero() {
            let d = s.divrem_small(10) as u8;
            if trail && d == 0 {
                exp += 1;
            } else {
                buf.push(b'0' + d);
                trail = false;
            }
        }
        // AdjustToPrecision, on the digits.
        let n = buf.len();
        if n > precision as usize {
            let mut first = n - precision as usize;
            if buf[first - 1] < b'5' {
                while first < n && buf[first] == b'0' {
                    first += 1;
                }
                exp += first as i32;
                buf.drain(..first);
            } else {
                let mut i = first;
                while i < n {
                    if buf[i] == b'9' {
                        first += 1;
                        i += 1;
                    } else {
                        buf[i] += 1;
                        break;
                    }
                }
                if first == n {
                    exp += first as i32;
                    buf = vec![b'1'];
                } else {
                    exp += first as i32;
                    buf.drain(..first);
                }
            }
        }
        let n = buf.len();
        let scientific = if max_padding == 0 {
            true
        } else if exp >= 0 {
            exp as u32 > max_padding || n as u32 + exp as u32 > precision
        } else {
            let msd = exp + n as i32 - 1;
            msd < 0 && (-msd) as u32 > max_padding
        };
        let digit = |i: usize| buf[n - 1 - i] as char;
        if scientific {
            exp += n as i32 - 1;
            out.push(digit(0));
            out.push('.');
            if n == 1 && truncate_zero {
                out.push('0');
            } else {
                (1..n).for_each(|i| out.push(digit(i)));
            }
            if !truncate_zero && precision as usize > n - 1 {
                (0..precision as usize - n + 1).for_each(|_| out.push('0'));
            }
            out.push(if truncate_zero { 'E' } else { 'e' });
            out.push(if exp >= 0 { '+' } else { '-' });
            let e = exp.unsigned_abs();
            let digits = alloc::format!("{e}");
            if !truncate_zero && digits.len() < 2 {
                out.push('0');
            }
            out.push_str(&digits);
            return;
        }
        if exp >= 0 {
            (0..n).for_each(|i| out.push(digit(i)));
            (0..exp).for_each(|_| out.push('0'));
            return;
        }
        let whole = exp + n as i32;
        let mut i = 0;
        if whole > 0 {
            while i < whole as usize {
                out.push(digit(i));
                i += 1;
            }
            out.push('.');
        } else {
            out.push_str("0.");
            (1..1 + (-whole) as usize).for_each(|_| out.push('0'));
        }
        while i < n {
            out.push(digit(i));
            i += 1;
        }
    }

    /// ⭐ How MLIR prints this float (`printFloatValue`): `%e`-like with 6 digits when that
    /// reads back exactly, else the shortest natural form, else the bits in hex.
    pub fn print(self) -> String {
        if !self.is_inf() && !self.is_nan() {
            let s = self.to_string_with(6, 0, false);
            if Self::parse(self.kind, &s).is_some_and(|b| b.bits == self.bits) {
                return s;
            }
            let s = self.to_string_with(0, 3, true);
            if s.contains('.') {
                return s;
            }
        }
        alloc::format!("0x{:X}", self.bits)
    }
}
