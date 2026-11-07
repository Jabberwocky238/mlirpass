//! ⭐ Table-driven packing, for every vendor: an op whose fields are its attributes (a command, a state struct, a
//! register) ⇒ its dwords, by a table of items (bit offset, width, type, default of each field). A vendor generates
//! its table from its hardware description (Intel genxml: `XE3`) and packs with it; the per-frame path copies
//! [`Template`]s and fills their holes.
//!
//! An attribute per field, named as the field (snake case); absent ⇒ the table's default. A struct-typed field is a
//! dictionary of the struct's fields, a fixed array an array (nested for each dimension), the variable-length group
//! `elements = [{...}, ...]`. `dword_length` absent ⇒ it is computed from what was packed (a variable group, or
//! fields set past the declared length: the longer forms such as a qword MI_STORE_DATA_IMM).

use alloc::format;
use alloc::string::{String, ToString};
use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{Attribute, Error, NamedAttr, Type};

use crate::A;

/// A field's type.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Ty<'t> {
    Bool,
    /// not masked: a value too wide is an error
    Uint,
    /// two's complement, masked to the width
    Int,
    Float,
    /// placed as it is: its low bits (below the field) must be zero
    Address,
    /// unsigned fixed point with this many fraction bits
    Ufixed(u8),
    Sfixed(u8),
    /// another item of the table (a state struct), by op name
    Struct(&'t str),
    /// must be one: its default is all ones, not settable
    Mbo,
    /// fixed to its default, not settable (AGX `exact`)
    Exact,
    /// an unsigned value stored shifted right by this many bits, which must be zero (AGX `shr(n)`)
    Shr(u8),
    /// an unsigned value stored less this (AGX `minus(n)`; the default encodes to zero)
    Minus(u32),
    /// a power of two stored as its log2 (AGX `log2`)
    Log2,
    /// a count stored in groups of this many, rounded up; 0 is stored as 1, all `1 << width` groups as 0 (AGX
    /// `groups(n)`, `__gen_to_groups`)
    Groups(u32),
    /// a level of detail: unsigned fixed point with 6 fraction bits, clamped to [0, 14] (AGX `lod`, `__gen_pack_lod`)
    Lod,
    /// IEEE half, rounded to nearest even (AGX `half`, `_mesa_float_to_half`)
    Half,
}

#[derive(Clone, Copy, Debug)]
pub struct Field<'t> {
    pub name: &'t str,
    /// first bit from dword 0 (of the item, or of a variable group element), for element 0 of every array dimension
    pub bit: u32,
    pub width: u32,
    pub ty: Ty<'t>,
    pub default: u64,
    /// (count, stride in bits) of the arrays it is in, outermost first
    pub dims: &'t [(u32, u32)],
}

impl<'t> Field<'t> {
    /// ⭐ A field of `width` bits from `bit`: default 0, in no array (the generated tables build theirs with it).
    pub const fn new(name: &'t str, bit: u32, width: u32, ty: Ty<'t>) -> Self {
        Field { name, bit, width, ty, default: 0, dims: &[] }
    }

    /// Its default value `default`.
    pub const fn with_default(self, default: u64) -> Self {
        Field { default, ..self }
    }

    /// In the arrays `dims` ((count, stride in bits), outermost first).
    pub const fn with_dims(self, dims: &'t [(u32, u32)]) -> Self {
        Field { dims, ..self }
    }
}

/// The variable-length group: elements of `size` bits from bit `at`.
#[derive(Clone, Copy, Debug)]
pub struct Group<'t> {
    pub at: u32,
    pub size: u32,
    pub fields: &'t [Field<'t>],
}

/// One item: a command, a state struct, a register.
#[derive(Clone, Copy, Debug)]
pub struct Item<'t> {
    pub name: &'t str,
    pub op: &'t str,
    /// dwords of the fixed part
    pub length: u32,
    /// what `dword_length` leaves out
    pub bias: u32,
    /// a register's MMIO offset
    pub num: u32,
    pub fields: &'t [Field<'t>],
    pub group: Option<Group<'t>>,
}

/// ⭐ A table of items, sorted by op name (a vendor's generated one).
#[derive(Clone, Copy)]
pub struct Layouts<'t>(pub &'t [Item<'t>]);

impl<'t> Layouts<'t> {
    pub fn get(&self, op: &str) -> Option<&'t Item<'t>> {
        self.0.binary_search_by(|i| i.op.cmp(op)).ok().map(|i| &self.0[i])
    }

    /// ⭐ The dwords of op `op` with attributes `attrs` (no symbols left in them).
    pub fn pack(&self, op: &str, attrs: &[NamedAttr<'_>]) -> Result<Vec<u32>, Error> {
        let t = self.template(op, attrs)?;
        match t.holes.first() {
            Some(h) => Err(Error(format!("{op}: @{} is not a number yet", h.name))),
            None => Ok(t.dw),
        }
    }

    /// ⭐ The dwords of op `op` with a hole wherever an attribute is a symbol (`@x`, or `[@x, n]`: x plus n), to be
    /// filled at each use ([`Template::emit`]).
    pub fn template(&self, op: &str, attrs: &[NamedAttr<'_>]) -> Result<Template, Error> {
        let item = self.get(op).ok_or_else(|| Error(format!("{op}: not an item of the table")))?;
        let mut p = Packer::new(*self, item);
        p.pack(attrs)?;
        Ok(Template { dw: p.dw, holes: p.holes })
    }
}

/// A symbol's place in packed dwords.
#[derive(Clone, Debug, PartialEq, Eq)]
pub struct Hole {
    pub name: String,
    bit: u32,
    width: u32,
    /// an address' bits below the field (its alignment: dropped)
    shift: u32,
    /// `[@x, n]`: n
    add: u64,
}

/// ⭐ Packed dwords with holes: copied and filled each time (no attribute is read then).
#[derive(Clone, Debug, Default, PartialEq, Eq)]
pub struct Template {
    pub dw: Vec<u32>,
    pub holes: Vec<Hole>,
}

impl Template {
    /// Appends the dwords, every hole filled with `value(its symbol)`.
    pub fn emit(&self, out: &mut Vec<u32>, value: impl Fn(&str) -> u64) {
        self.emit_indexed(out, |i| value(&self.holes[i].name));
    }

    /// `emit` with each hole's value by its index in `holes`: names resolved ahead of time.
    pub fn emit_indexed(&self, out: &mut Vec<u32>, value: impl Fn(usize) -> u64) {
        let at = out.len();
        out.extend_from_slice(&self.dw);
        for (i, h) in self.holes.iter().enumerate() {
            let v = (value(i) + h.add) >> h.shift;
            let v = if h.width >= 64 { v } else { v & ((1 << h.width) - 1) };
            let mut rest = u128::from(v) << (h.bit % 32);
            for d in &mut out[at + (h.bit / 32) as usize..at + (h.bit + h.width).div_ceil(32) as usize] {
                *d |= rest as u32;
                rest >>= 32;
            }
        }
    }

    /// Appends another template (its holes moved along).
    pub fn extend(&mut self, other: &Template) {
        let base = self.dw.len() as u32 * 32;
        self.dw.extend_from_slice(&other.dw);
        self.holes.extend(other.holes.iter().map(|h| Hole { bit: h.bit + base, ..h.clone() }));
    }
}

/// One item being packed.
struct Packer<'l, 't> {
    layouts: Layouts<'t>,
    item: &'l Item<'t>,
    dw: Vec<u32>,
    holes: Vec<Hole>,
}

/// Attributes that are not fields: the variable group, and where a state op is placed.
const META: &[&str] = &["elements", "sym_name", "align", "offset"];

impl<'l, 't> Packer<'l, 't> {
    fn new(layouts: Layouts<'t>, item: &'l Item<'t>) -> Self {
        Packer { layouts, item, dw: vec![0; item.length as usize], holes: Vec::new() }
    }

    fn err<T>(&self, msg: impl core::fmt::Display) -> Result<T, Error> {
        Err(Error(format!("{}: {msg}", self.item.op)))
    }

    fn pack(&mut self, attrs: &[NamedAttr<'_>]) -> Result<(), Error> {
        let get = |name: &str| attrs.iter().find(|a| a.name == name).map(|a| a.value.as_ref().unwrap_or(&Attribute::Unit));
        for a in attrs {
            if !META.contains(&&*a.name) && !self.item.fields.iter().any(|f| f.name == a.name) {
                return self.err(format_args!("no field {}", a.name));
            }
        }
        let auto_length = self.item.bias > 0 && get("dword_length").is_none() && self.item.fields.iter().any(|f| f.name == "dword_length");
        for f in self.item.fields {
            if !(auto_length && f.name == "dword_length") {
                self.field(f, 0, get(f.name))?;
            }
        }
        match (self.item.group, get("elements")) {
            (Some(g), Some(Attribute::Array(es))) => {
                self.dw.resize((g.at as usize + es.len() * g.size as usize).div_ceil(32).max(self.dw.len()), 0);
                for (i, e) in es.iter().enumerate() {
                    let Attribute::Dict(es) = e else { return self.err("an element is not a dictionary") };
                    for f in g.fields {
                        let v = es.iter().find(|a| a.name == f.name).map(|a| a.value.as_ref().unwrap_or(&Attribute::Unit));
                        self.field(f, g.at + i as u32 * g.size, v)?;
                    }
                }
            }
            (_, None) => {}
            _ => return self.err("elements: not a variable-length item, or not an array"),
        }
        if auto_length {
            let f = self.item.fields.iter().find(|f| f.name == "dword_length").unwrap();
            let n = self.dw.len() as u64 - u64::from(self.item.bias);
            self.put(f.bit, f.width, n, true);
        }
        Ok(())
    }

    /// A field (every element of its arrays), from bit `base`; `value` absent ⇒ its default.
    fn field(&mut self, f: &Field<'_>, base: u32, value: Option<&Attribute<'_>>) -> Result<(), Error> {
        self.elements(f, base + f.bit, f.dims, value, value.is_some())
    }

    fn elements(&mut self, f: &Field<'_>, bit: u32, dims: &[(u32, u32)], value: Option<&Attribute<'_>>, set: bool) -> Result<(), Error> {
        let Some(((count, stride), inner)) = dims.split_first() else { return self.scalar(f, bit, value, set) };
        let items = match value {
            Some(Attribute::Array(v)) if v.len() == *count as usize => Some(v),
            None => None,
            _ => return self.err(format_args!("{}: not an array of {count}", f.name)),
        };
        for i in 0..*count {
            self.elements(f, bit + i * stride, inner, items.map(|v| &v[i as usize]), set)?;
        }
        Ok(())
    }

    fn scalar(&mut self, f: &Field<'_>, bit: u32, value: Option<&Attribute<'_>>, set: bool) -> Result<(), Error> {
        let v = match (f.ty, value) {
            (Ty::Struct(op), v) => {
                let Some(item) = self.layouts.get(op) else { return self.err(format_args!("{}: no struct {op}", f.name)) };
                let attrs = match v {
                    Some(Attribute::Dict(a)) => a.as_slice(),
                    None => &[],
                    _ => return self.err(format_args!("{}: not a dictionary", f.name)),
                };
                let mut inner = Packer::new(self.layouts, item);
                inner.pack(attrs)?;
                for (k, w) in inner.dw.iter().enumerate().take(f.width.div_ceil(32) as usize) {
                    let k = k as u32;
                    self.put(bit + 32 * k, (f.width - 32 * k).min(32), u64::from(*w), set);
                }
                self.holes.extend(inner.holes.into_iter().map(|h| Hole { bit: h.bit + bit, ..h }));
                return Ok(());
            }
            (Ty::Uint, Some(Attribute::Array(words))) if f.width > 64 => {
                for (k, w) in words.iter().enumerate() {
                    let (k, w) = (k as u32, Scalar::try_from(w)?.0 as u64);
                    self.put(bit + 32 * k, (f.width - 32 * k).min(32), w, set);
                }
                return Ok(());
            }
            (Ty::Mbo, Some(_)) => return self.err(format_args!("{}: must be one, not settable", f.name)),
            (Ty::Exact, Some(_)) => return self.err(format_args!("{}: fixed to {:#x}, not settable", f.name, f.default)),
            (ty, Some(Attribute::SymbolRef(p))) => return self.hole(f, ty, bit, p, 0),
            (ty, Some(Attribute::Array(v))) if matches!(&v[..], [Attribute::SymbolRef(_), Attribute::Int { .. }]) => {
                let (Attribute::SymbolRef(p), add) = (&v[0], Scalar::try_from(&v[1])?.0 as u64) else { unreachable!() };
                return self.hole(f, ty, bit, p, add);
            }
            (_, None) => f.default,
            (ty, Some(a)) => {
                let s = Scalar::try_from(a)?;
                match ty.encode(s, f.width, bit % 32) {
                    Some(v) => v,
                    None => return self.err(format_args!("{}: {a} does not fit {ty:?} of {} bits at bit {}", f.name, f.width, bit % 32)),
                }
            }
        };
        self.put(bit, f.width, v, set);
        Ok(())
    }

    /// A symbol where field `f` (at `bit`) goes: a hole, zeros for now.
    fn hole(&mut self, f: &Field<'_>, ty: Ty<'_>, bit: u32, path: &[mlirformat::Str<'_>], add: u64) -> Result<(), Error> {
        let shift = match ty {
            Ty::Uint | Ty::Int | Ty::Bool => 0,
            Ty::Address => bit % 32,
            Ty::Shr(n) => n.into(),
            _ => return self.err(format_args!("{}: a symbol in a {ty:?} field", f.name)),
        };
        let name = path.iter().map(|s| s.trim_matches('"')).collect::<Vec<_>>().join("::");
        self.holes.push(Hole { name, bit, width: f.width, shift, add });
        Ok(())
    }

    /// Ors the low `width` bits of `v` in at `bit`. A field set past the fixed part grows the dwords where its bits
    /// are not zero (the longer forms); a default there, or zero bits, are left out.
    fn put(&mut self, bit: u32, width: u32, v: u64, set: bool) {
        let v = if width >= 64 { v } else { v & ((1 << width) - 1) };
        let mut rest = u128::from(v) << (bit % 32);
        for k in (bit / 32) as usize..(bit + width).div_ceil(32) as usize {
            let d = rest as u32;
            rest >>= 32;
            if k >= self.dw.len() {
                if !set || d == 0 {
                    continue;
                }
                self.dw.resize(k + 1, 0);
            }
            self.dw[k] |= d;
        }
    }
}

/// An attribute as a field value: an integer's bits, or a float.
#[derive(Clone, Copy, Debug)]
struct Scalar(i128, Option<f64>);

impl TryFrom<&Attribute<'_>> for Scalar {
    type Error = Error;

    fn try_from(a: &Attribute<'_>) -> Result<Scalar, Error> {
        let int = |lit: &str| {
            let (neg, l) = lit.strip_prefix('-').map_or((false, lit), |l| (true, l));
            let v = match l.strip_prefix("0x") {
                Some(h) => i128::from_str_radix(h, 16),
                None => l.parse(),
            };
            v.ok().map(|v| if neg { -v } else { v })
        };
        match a {
            Attribute::Unit => Ok(Scalar(1, None)),
            Attribute::Bool(b) => Ok(Scalar((*b).into(), None)),
            Attribute::Int { lit, .. } => int(lit).map(|v| Scalar(v, Some(v as f64))).ok_or_else(|| Error(format!("bad integer {lit}"))),
            Attribute::Float { lit, .. } => lit.parse::<f64>().map(|v| Scalar(v as i128, Some(v))).map_err(|_| Error(format!("bad float {lit}"))),
            _ => Err(Error(format!("{a} is not a number"))),
        }
    }
}

impl Ty<'_> {
    /// `s` as the field's bits (in the low `width` bits); `None` when it does not fit. An address keeps its own bit
    /// positions: `lo` low bits below the field must be zero, and its bits from `lo` up are returned.
    fn encode(self, s: Scalar, width: u32, lo: u32) -> Option<u64> {
        let fits = |v: i128| v >= 0 && (width >= 64 || v >> width == 0);
        let frac = |v: f64, f: u8| (v * (1u64 << f) as f64).round() as i128;
        match self {
            Ty::Bool => (s.0 == 0 || s.0 == 1).then_some(s.0 as u64),
            Ty::Uint => fits(s.0).then_some(s.0 as u64),
            Ty::Int => (s.0 >= -(1i128 << (width - 1)) && s.0 < 1i128 << width).then_some(s.0 as u64),
            Ty::Float => Some(u64::from((s.1? as f32).to_bits())),
            Ty::Ufixed(f) => Some(frac(s.1?, f)).filter(|v| fits(*v)).map(|v| v as u64),
            Ty::Sfixed(f) => Some(frac(s.1?, f) as u64),
            Ty::Address => (s.0 >= 0 && s.0 & ((1 << lo) - 1) == 0 && (width + lo >= 64 || s.0 >> (width + lo) == 0)).then_some((s.0 >> lo) as u64),
            Ty::Shr(n) => (s.0 >= 0 && s.0 & ((1 << n) - 1) == 0).then_some(s.0 >> n).filter(|v| fits(*v)).map(|v| v as u64),
            Ty::Minus(n) => Some(s.0 - i128::from(n)).filter(|v| fits(*v)).map(|v| v as u64),
            Ty::Log2 => (s.0 > 0 && s.0 & (s.0 - 1) == 0).then(|| i128::from(s.0.trailing_zeros())).filter(|v| fits(*v)).map(|v| v as u64),
            Ty::Groups(n) => {
                let groups = if s.0 == 0 { 1 } else { s.0.checked_add(i128::from(n) - 1)? / i128::from(n) };
                match groups {
                    g if g == 1 << width => Some(0),
                    g => fits(g).then_some(g as u64),
                }
            }
            // C: CLAMP(f * (1 << 6), 0, 0x380) in float, truncated to an integer
            Ty::Lod => Some(u64::from((s.1? as f32 * 64.0).clamp(0.0, 896.0) as u32)),
            Ty::Half => Some(u64::from(Half::from(s.1? as f32).0)),
            Ty::Struct(_) | Ty::Mbo | Ty::Exact => None,
        }
    }
}

/// An IEEE half's bits: an f32 rounded to nearest even, as `vcvtps2ph $0` (what `_mesa_float_to_half` runs on x86-64
/// with F16C): too large is infinity, a NaN keeps its top mantissa bits and is quiet.
struct Half(u16);

impl From<f32> for Half {
    fn from(f: f32) -> Half {
        let bits = f.to_bits();
        let sign = ((bits >> 16) & 0x8000) as u16;
        let (exp, man) = ((bits >> 23) & 0xff, bits & 0x7f_ffff);
        if exp == 0xff {
            return Half(sign | 0x7c00 | if man != 0 { 0x200 | (man >> 13) as u16 } else { 0 });
        }
        let x = f64::from(f.abs());
        if x < f64::powi(2.0, -14) {
            // a subnormal half (or zero): x in units of 2^-24, rounded to even (exact in f64)
            return Half(sign | (x * f64::powi(2.0, 24)).round_ties_even() as u16);
        }
        let e = exp as i32 - 127 + 15;
        if e >= 31 {
            return Half(sign | 0x7c00);
        }
        // exponent and mantissa together, so a carry from rounding moves into the exponent (up to infinity)
        let full = ((e as u32) << 23) | man;
        let (mut h, rest) = (full >> 13, full & 0x1fff);
        if rest > 0x1000 || (rest == 0x1000 && h & 1 == 1) {
            h += 1;
        }
        Half(sign | h.min(0x7c00) as u16)
    }
}

/// ⭐ A packed field's value in a typed op: a number, or a place, `@x` / `@m::@x` plus `add` (`[@x, n]`), which the
/// image fills in once laid out (a template's hole). Serialized as the attribute [`Layouts`](crate::Layouts)'s
/// packer reads.
#[derive(Clone, Debug, PartialEq, Eq)]
pub enum Fill {
    Int(i128),
    Bool(bool),
    Place { path: Vec<String>, add: i64 },
}


impl From<bool> for Fill {
    fn from(v: bool) -> Self {
        Fill::Bool(v)
    }
}

/// A number as a field's value.
macro_rules! fills {
    ($($t:ty),*) => {$(
        impl From<$t> for Fill {
            fn from(v: $t) -> Self {
                Fill::Int(v.into())
            }
        }
    )*};
}

fills!(i32, u32, i64, u64);

impl Fill {
    /// `@name` plus `add`.
    pub fn at(name: impl Into<String>, add: i64) -> Fill {
        Fill::Place { path: vec![name.into()], add }
    }
}

/// An attribute value as a field's (`xe3!` and the like take either): a number, a bool or a place; anything else is
/// a caller's mistake (a string, an f32: a `Real` field takes that).
impl From<A> for Fill {
    fn from(a: A) -> Self {
        Fill::try_from(&a).unwrap_or_else(|e| panic!("{e}"))
    }
}

/// An attribute value as a field's: a number or a place.
impl TryFrom<&A> for Fill {
    type Error = Error;

    fn try_from(a: &A) -> Result<Fill, Error> {
        match a {
            A::Int(v) => Ok(Fill::Int(*v)),
            A::Bool(b) => Ok(Fill::Bool(*b)),
            A::Sym(s) => Ok(Fill::at(s.clone(), 0)),
            A::In(m, s) => Ok(Fill::Place { path: vec![m.clone(), s.clone()], add: 0 }),
            other => Err(Error(format!("{other:?} is not a field's value"))),
        }
    }
}

impl<'a> From<&Fill> for Attribute<'a> {
    fn from(f: &Fill) -> Self {
        match f {
            Fill::Int(v) => A::Int(*v).into(),
            Fill::Bool(b) => Attribute::Bool(*b),
            Fill::Place { path, add: 0 } => Attribute::SymbolRef(path.iter().map(|s| s.clone().into()).collect()),
            Fill::Place { path, add } => Attribute::Array(vec![Attribute::SymbolRef(path.iter().map(|s| s.clone().into()).collect()), Attribute::Int { lit: add.to_string().into(), ty: None }]),
        }
    }
}

impl TryFrom<&Attribute<'_>> for Fill {
    type Error = Error;

    fn try_from(a: &Attribute<'_>) -> Result<Fill, Error> {
        let path = |s: &[mlirformat::Str<'_>]| s.iter().map(|x| x.to_string()).collect();
        match a {
            Attribute::Int { .. } => Ok(Fill::Int(a.int()?)),
            Attribute::Bool(b) => Ok(Fill::Bool(*b)),
            Attribute::Unit => Ok(Fill::Bool(true)),
            Attribute::SymbolRef(s) => Ok(Fill::Place { path: path(s), add: 0 }),
            Attribute::Array(xs) => match &xs[..] {
                [Attribute::SymbolRef(s), n @ Attribute::Int { .. }] => Ok(Fill::Place { path: path(s), add: crate::Attrs::as_int(n)? }),
                _ => Err(Error(format!("{a}: not a number or [@place, n]"))),
            },
            _ => Err(Error(format!("{a}: not a number or a place"))),
        }
    }
}

/// ⭐ A typed field's value as an attribute, however mlirformat hands it to serde: an `Attribute` read off an op, or
/// the plain values a custom form's parser gives (a number, a bool, an array, a dictionary). Asked for as an `i128`:
/// an integer comes whole (a 64-bit address does not fit an `i64`), anything else as it is.
pub fn attribute_of<'de, D: serde::Deserializer<'de>>(d: D) -> Result<Attribute<'static>, D::Error> {
    d.deserialize_i128(AttrVisitor)
}

/// [`attribute_of`]'s visitor (and seed, for an array's elements and a dictionary's values).
#[derive(Clone, Copy)]
struct AttrVisitor;

impl<'de> serde::de::DeserializeSeed<'de> for AttrVisitor {
    type Value = Attribute<'static>;
    fn deserialize<D: serde::Deserializer<'de>>(self, d: D) -> Result<Self::Value, D::Error> {
        attribute_of(d)
    }
}

impl<'de> serde::de::Visitor<'de> for AttrVisitor {
    type Value = Attribute<'static>;
    fn expecting(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
        f.write_str("an attribute")
    }
    fn visit_bool<E: serde::de::Error>(self, v: bool) -> Result<Self::Value, E> {
        Ok(Attribute::Bool(v))
    }
    fn visit_i64<E: serde::de::Error>(self, v: i64) -> Result<Self::Value, E> {
        self.visit_i128(v.into())
    }
    fn visit_u64<E: serde::de::Error>(self, v: u64) -> Result<Self::Value, E> {
        self.visit_i128(v.into())
    }
    fn visit_i128<E: serde::de::Error>(self, v: i128) -> Result<Self::Value, E> {
        Ok(Attribute::Int { lit: v.to_string().into(), ty: None })
    }
    fn visit_f64<E: serde::de::Error>(self, v: f64) -> Result<Self::Value, E> {
        Ok(Attribute::Float { lit: format!("{v:?}").into(), ty: None })
    }
    fn visit_str<E: serde::de::Error>(self, v: &str) -> Result<Self::Value, E> {
        Ok(Attribute::Str { lit: String::from(v).into(), ty: None })
    }
    fn visit_unit<E: serde::de::Error>(self) -> Result<Self::Value, E> {
        Ok(Attribute::Unit)
    }
    fn visit_some<D: serde::Deserializer<'de>>(self, d: D) -> Result<Self::Value, D::Error> {
        attribute_of(d)
    }
    fn visit_seq<S: serde::de::SeqAccess<'de>>(self, mut seq: S) -> Result<Self::Value, S::Error> {
        let mut xs = Vec::new();
        while let Some(x) = seq.next_element_seed(AttrVisitor)? {
            xs.push(x);
        }
        Ok(Attribute::Array(xs))
    }
    fn visit_map<M: serde::de::MapAccess<'de>>(self, mut map: M) -> Result<Self::Value, M::Error> {
        let mut d = Vec::new();
        while let Some(k) = map.next_key::<String>()? {
            d.push(NamedAttr { name: k.into(), value: Some(map.next_value_seed(AttrVisitor)?) });
        }
        Ok(Attribute::Dict(d))
    }
    /// The `Attribute` enum itself, as mlirformat carries one.
    fn visit_enum<A: serde::de::EnumAccess<'de>>(self, e: A) -> Result<Self::Value, A::Error> {
        <Attribute<'static> as serde::Deserialize>::deserialize(serde::de::value::EnumAccessDeserializer::new(e))
    }
}

/// Through serde as mlirformat carries attributes: `Attribute` itself.
impl serde::Serialize for Fill {
    fn serialize<S: serde::Serializer>(&self, s: S) -> Result<S::Ok, S::Error> {
        serde::Serialize::serialize(&Attribute::from(self), s)
    }
}

impl<'de> serde::Deserialize<'de> for Fill {
    fn deserialize<D: serde::Deserializer<'de>>(d: D) -> Result<Self, D::Error> {
        Fill::try_from(&attribute_of(d)?).map_err(serde::de::Error::custom)
    }
}

/// ⭐ A struct as an op's property: a dictionary attribute of its fields (a nested state struct, a group's element).
/// mlirformat hands a dictionary attribute to serde as `Attribute` itself; this reads it field by field into `T`.
#[derive(Clone, Debug, Default, PartialEq)]
pub struct Fields<T>(pub T);

impl<T: serde::Serialize> serde::Serialize for Fields<T> {
    fn serialize<S: serde::Serializer>(&self, s: S) -> Result<S::Ok, S::Error> {
        self.0.serialize(s)
    }
}

impl<'de, T: serde::de::DeserializeOwned> serde::Deserialize<'de> for Fields<T> {
    fn deserialize<D: serde::Deserializer<'de>>(d: D) -> Result<Self, D::Error> {
        use mlirformat::IntoStatic;
        let err = |m: String| <D::Error as serde::de::Error>::custom(m);
        let Attribute::Dict(fields) = attribute_of(d)? else { return Err(err("not a dictionary".into())) };
        let map = fields.into_iter().map(|n| (mlirformat::Content::Str(n.name.to_string()), mlirformat::Content::Attr(n.value.unwrap_or(Attribute::Unit).into_static()))).collect();
        mlirformat::Content::Map(map).to().map(Fields).map_err(|e| err(e.to_string()))
    }
}

/// ⭐ A float field's value in a typed op (the tables' floats are 32-bit; the packer reads the literal as an `f64`,
/// so a fixed-point field keeps what was written), printed as MLIR reads it back: always with a decimal point
/// (`3.0`, not mlirformat's `3e0` for a serde float), the shortest form that round-trips, `: f32` as `A::F32` prints.
#[derive(Clone, Copy, Debug, Default, PartialEq)]
pub struct Real(pub f64);

/// As `A::F32` gives it to the packer: the f32's shortest decimal.
impl From<f32> for Real {
    fn from(v: f32) -> Self {
        Real(format!("{v:?}").parse().unwrap_or(v.into()))
    }
}

impl From<f64> for Real {
    fn from(v: f64) -> Self {
        Real(v)
    }
}

impl<'a> From<Real> for Attribute<'a> {
    fn from(r: Real) -> Self {
        let s = format!("{:?}", r.0);
        // `1e-5` ⇒ `1.0e-5` (a float literal has a decimal point); `inf` / `NaN` stay as they are
        let lit = match s.find(['e', 'E']) {
            Some(at) if !s[..at].contains('.') => format!("{}.0{}", &s[..at], &s[at..]),
            _ => s,
        };
        Attribute::Float { lit: lit.into(), ty: Some(Type::Float(mlirformat::FloatKind::F32)) }
    }
}

impl serde::Serialize for Real {
    fn serialize<S: serde::Serializer>(&self, s: S) -> Result<S::Ok, S::Error> {
        serde::Serialize::serialize(&Attribute::from(*self), s)
    }
}

impl<'de> serde::Deserialize<'de> for Real {
    fn deserialize<D: serde::Deserializer<'de>>(d: D) -> Result<Self, D::Error> {
        let err = <D::Error as serde::de::Error>::custom;
        match attribute_of(d)? {
            Attribute::Float { lit, .. } => lit.parse::<f64>().map(Real).map_err(|e| err(e.to_string())),
            a @ Attribute::Int { .. } => a.int().map(|v| Real(v as f64)).map_err(|e| err(e.0)),
            a => Err(err(format!("{a}: not a float"))),
        }
    }
}
