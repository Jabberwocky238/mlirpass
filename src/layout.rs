//! Builtin memref layouts (`MemRefLayoutAttrInterface`, `getStridesAndOffset`): what the
//! strides and offset of a `memref` are, whichever dialect asks.

use alloc::collections::BTreeMap;
use alloc::string::String;
use alloc::vec::Vec;

use mlirformat::llvm_types::LlvmType;
use mlirformat::{Attribute, Dim, Shaped, ShapedKind, StridedLayout, Type};

use crate::{Body, OpId};

/// A memref's layout, asked of its [`Shaped`] type.
pub trait MemrefLayout {
    /// `getStridesAndOffset`: from a `strided<...>` layout, or row-major for the identity.
    fn strides_and_offset(&self) -> Option<(Vec<i64>, i64)>;

    /// `MemRefLayoutAttrInterface::isIdentity`: no layout, `strided<[1]>`, or `(d0, ...) -> (d0, ...)`.
    fn identity_layout(&self) -> bool;

    /// `isStaticShapeAndContiguousRowMajor`.
    fn contiguous_row_major(&self) -> bool;
}

impl MemrefLayout for Shaped<'_> {
    fn strides_and_offset(&self) -> Option<(Vec<i64>, i64)> {
        let layout = self.layout();
        let shape = self.shape.as_ref()?;
        if let Some(Attribute::Builtin { name, body: map, .. }) = layout
            && name == "affine_map"
        {
            return Linear::strides(map, shape.len());
        }
        let Some(layout) = layout else {
            let mut strides = alloc::vec![0i64; shape.len()];
            let mut running = 1i64;
            for (i, d) in shape.iter().enumerate().rev() {
                strides[i] = running;
                running = match (running, d) {
                    (Dim::DYNAMIC, _) | (_, Dim::Dynamic) => Dim::DYNAMIC,
                    (r, Dim::Static(n) | Dim::Scalable(n)) => r * n,
                };
            }
            return Some((strides, 0));
        };
        let StridedLayout { strides, offset } = StridedLayout::try_from(layout).ok()?;
        Some((strides, offset))
    }

    fn identity_layout(&self) -> bool {
        self.extras.iter().all(|a| match a {
            Attribute::Builtin { name, .. } if name == "strided" => StridedLayout::try_from(a).is_ok_and(|l| l.is_identity()),
            Attribute::Builtin { name, body, .. } if name == "affine_map" => {
                let Some((dims, results)) = body.trim_start_matches('<').trim_end_matches('>').split_once("->") else { return false };
                let squash = |t: &str| t.chars().filter(|c| !c.is_whitespace()).collect::<String>();
                let dims = squash(dims);
                !dims.contains('[') && dims == squash(results)
            }
            _ => true,
        })
    }

    fn contiguous_row_major(&self) -> bool {
        let dims = self.dims().unwrap_or_default();
        if self.shape.is_none() || dims.contains(&Dim::DYNAMIC) {
            return false;
        }
        let Some((strides, _)) = self.strides_and_offset() else { return false };
        let mut running = 1;
        let mut cur = dims.len() as i64 - 1;
        while cur >= 0 && strides[cur as usize] == running {
            running *= dims[cur as usize];
            cur -= 1;
        }
        while cur >= 0 && dims[cur as usize] == 1 {
            cur -= 1;
        }
        cur < 0
    }
}

/// A coefficient of a linear affine expression: known, or depending on a symbol.
#[derive(Debug, Clone, Copy, PartialEq)]
enum Coef {
    K(i64),
    Dyn,
}

impl core::ops::Add for Coef {
    type Output = Coef;
    fn add(self, o: Coef) -> Coef {
        match (self, o) {
            (Coef::K(a), Coef::K(b)) => Coef::K(a + b),
            _ => Coef::Dyn,
        }
    }
}

impl core::ops::Mul for Coef {
    type Output = Coef;
    fn mul(self, o: Coef) -> Coef {
        match (self, o) {
            (Coef::K(0), _) | (_, Coef::K(0)) => Coef::K(0),
            (Coef::K(a), Coef::K(b)) => Coef::K(a * b),
            _ => Coef::Dyn,
        }
    }
}

impl From<Coef> for i64 {
    fn from(c: Coef) -> i64 {
        match c {
            Coef::K(k) => k,
            Coef::Dyn => Dim::DYNAMIC,
        }
    }
}

/// `extractStrides` over a single-result affine map: `Σ dᵢ·strideᵢ + offset`, where a
/// symbol makes its coefficient dynamic. Anything not linear in the dims has no strides.
#[derive(Debug, Clone)]
struct Linear {
    dims: Vec<Coef>,
    off: Coef,
}

impl Linear {
    fn constant(rank: usize, c: Coef) -> Self {
        Self { dims: alloc::vec![Coef::K(0); rank], off: c }
    }

    fn is_constant(&self) -> bool {
        self.dims.iter().all(|d| *d == Coef::K(0))
    }

    fn add(mut self, o: Linear) -> Self {
        self.dims.iter_mut().zip(o.dims).for_each(|(a, b)| *a = *a + b);
        self.off = self.off + o.off;
        self
    }

    fn scale(mut self, c: Coef) -> Self {
        self.dims.iter_mut().for_each(|d| *d = *d * c);
        self.off = self.off * c;
        self
    }

    fn mul(self, o: Linear) -> Option<Self> {
        match (self.is_constant(), o.is_constant()) {
            (true, _) => Some(o.scale(self.off)),
            (_, true) => Some(self.scale(o.off)),
            _ => None,
        }
    }

    /// The strides and offset of `<(d0, ...)[s0, ...] -> (expr)>`; the identity map is row-major.
    fn strides(map: &str, rank: usize) -> Option<(Vec<i64>, i64)> {
        let (_, results) = map.split_once("->")?;
        let results = results.trim().strip_suffix('>')?.trim();
        let expr = results.strip_prefix('(')?.strip_suffix(')')?;
        let tokens = Self::tokens(expr)?;
        let mut p = Parser { tokens: &tokens, at: 0, rank };
        let lin = p.sum()?;
        if p.at != tokens.len() {
            return None;
        }
        Some((lin.dims.into_iter().map(i64::from).collect(), lin.off.into()))
    }

    fn tokens(e: &str) -> Option<Vec<&str>> {
        let mut out = Vec::new();
        let mut rest = e.trim_start();
        while let Some(c) = rest.chars().next() {
            let n = if "+-*(),".contains(c) { 1 } else { rest.find(|c: char| !c.is_ascii_alphanumeric()).unwrap_or(rest.len()) };
            if n == 0 {
                return None;
            }
            out.push(&rest[..n]);
            rest = rest[n..].trim_start();
        }
        Some(out)
    }
}

/// Recursive descent over affine expression tokens.
struct Parser<'t, 's> {
    tokens: &'t [&'s str],
    at: usize,
    rank: usize,
}

impl<'s> Parser<'_, 's> {
    fn peek(&self) -> Option<&'s str> {
        self.tokens.get(self.at).copied()
    }

    fn sum(&mut self) -> Option<Linear> {
        let mut acc = self.product()?;
        while let Some(op @ ("+" | "-")) = self.peek() {
            self.at += 1;
            let mut rhs = self.product()?;
            if op == "-" {
                rhs = rhs.scale(Coef::K(-1));
            }
            acc = acc.add(rhs);
        }
        Some(acc)
    }

    fn product(&mut self) -> Option<Linear> {
        let mut acc = self.atom()?;
        while self.peek() == Some("*") {
            self.at += 1;
            acc = acc.mul(self.atom()?)?;
        }
        Some(acc)
    }

    fn atom(&mut self) -> Option<Linear> {
        let t = self.peek()?;
        self.at += 1;
        if t == "(" {
            let e = self.sum()?;
            (self.peek() == Some(")")).then_some(())?;
            self.at += 1;
            return Some(e);
        }
        if t == "-" {
            return Some(self.atom()?.scale(Coef::K(-1)));
        }
        if let Some(i) = t.strip_prefix('d').and_then(|i| i.parse::<usize>().ok()) {
            let mut l = Linear::constant(self.rank, Coef::K(0));
            *l.dims.get_mut(i)? = Coef::K(1);
            return Some(l);
        }
        if t.strip_prefix('s').is_some_and(|i| i.parse::<usize>().is_ok()) {
            return Some(Linear::constant(self.rank, Coef::Dyn));
        }
        Some(Linear::constant(self.rank, Coef::K(t.parse().ok()?)))
    }
}

// `DataLayout`, as `DataLayoutInterfaces.cpp`: sizes and alignments of types. The default layout,
// and of a `dlti.dl_spec` its pointer entries and endianness (no `llvm.data_layout` string).

/// ⭐ A data layout; [`Default`]: what MLIR assumes with no spec.
#[derive(Debug, Clone, PartialEq, Eq, Default)]
pub struct DataLayout {
    /// `!llvm.ptr<space>` entries: (size, ABI alignment), in bits.
    pointers: BTreeMap<u32, (u64, u64)>,
    /// `"dlti.endianness" = "big"`.
    big_endian: bool,
}

impl DataLayout {
    /// `DataLayout::closest(op)`: the `dlti.dl_spec` of `op` or its nearest ancestor.
    pub fn closest(body: &Body<'_>, op: OpId) -> Self {
        let mut at = Some(op);
        while let Some(o) = at {
            if let Some(Attribute::Extended { ext, .. }) = body[o].get("dlti.dl_spec") {
                return Self::of_spec(ext.body.as_deref().unwrap_or(""));
            }
            at = body.parent_op(o);
        }
        Self::default()
    }

    /// The `index` entry of the `dlti.dl_spec` at or above `op`
    /// (`DataLayoutAnalysis::getAtOrAbove`); 64 without one.
    pub fn index_bitwidth(body: &Body<'_>, op: OpId) -> u32 {
        let mut at = Some(op);
        while let Some(o) = at {
            if let Some(bits) = body[o].get("dlti.dl_spec").and_then(Self::spec_index) {
                return bits;
            }
            at = body.parent_op(o);
        }
        64
    }

    /// The `index` entry of a `#dlti.dl_spec<...>`: `#dlti.dl_entry<index, 32>` or `index = 32`.
    fn spec_index(a: &Attribute<'_>) -> Option<u32> {
        let Attribute::Extended { ext, .. } = a else { return None };
        let body = ext.body.as_deref()?;
        let (_, rest) = body.split_once("dl_entry<index,").or_else(|| body.split_once("index ="))?;
        rest.trim_start().split(|c: char| !c.is_ascii_digit()).next()?.parse().ok()
    }

    /// The entries of a `#dlti.dl_spec<...>` body this layout knows.
    fn of_spec(spec: &str) -> Self {
        let mut dl = Self { big_endian: spec.contains(r#""dlti.endianness" = "big""#), ..Self::default() };
        for (_, rest) in spec.match_indices("!llvm.ptr").map(|(i, _)| ((), &spec[i + "!llvm.ptr".len()..])) {
            let (space, rest) = match rest.strip_prefix('<') {
                Some(r) => {
                    let end = r.find('>').unwrap_or(0);
                    (r[..end].trim().parse().unwrap_or(0), &r[end + 1..])
                }
                None => (0, rest),
            };
            let Some(values) = rest.trim_start().strip_prefix("= dense<") else { continue };
            let values = values.split('>').next().unwrap_or("").trim_matches(|c| c == '[' || c == ']');
            let bits: Vec<u64> = values.split(',').filter_map(|v| v.trim().parse().ok()).collect();
            if let Some(&size) = bits.first() {
                dl.pointers.insert(space, (size, bits.get(1).copied().unwrap_or(size)));
            }
        }
        dl
    }

    /// Whether the spec says `"dlti.endianness" = "big"`.
    pub fn big_endian(&self) -> bool {
        self.big_endian
    }

    /// `getTypeSizeInBits`; panics where MLIR reports a missing layout.
    pub fn size_in_bits(&self, ty: &Type<'_>) -> u64 {
        self.try_bits(ty).unwrap_or_else(|| Self::missing(ty))
    }

    /// `getTypeSize`, in bytes.
    pub fn size(&self, ty: &Type<'_>) -> u64 {
        self.size_in_bits(ty).div_ceil(8)
    }

    /// `getTypeABIAlignment`, in bytes.
    pub fn abi_align(&self, ty: &Type<'_>) -> u64 {
        self.try_abi_align(ty).unwrap_or_else(|| Self::missing(ty))
    }

    /// `getTypePreferredAlignment`, in bytes.
    pub fn preferred_align(&self, ty: &Type<'_>) -> u64 {
        self.try_preferred_align(ty).unwrap_or_else(|| Self::missing(ty))
    }

    /// `reportMissingDataLayout`.
    fn missing(ty: &Type<'_>) -> ! {
        panic!("neither the scoping op nor the type class provide data layout information for {ty}")
    }

    fn try_size(&self, ty: &Type<'_>) -> Option<u64> {
        Some(self.try_bits(ty)?.div_ceil(8))
    }

    fn try_bits(&self, ty: &Type<'_>) -> Option<u64> {
        Some(match ty {
            Type::Integer { width, .. } => u64::from(*width),
            Type::Float(_) => u64::from(ty.bit_width()?),
            // `index` is an integer of the default index bitwidth.
            Type::Index => 64,
            Type::Complex(et) => {
                let inner = self.try_bits(et)?;
                inner.next_multiple_of(self.try_preferred_align(et)? * 8) + inner
            }
            // Rounded up to a power of two elements in the innermost dimension.
            Type::Shaped(s) if s.kind == ShapedKind::Vector => {
                let dims = s.dims()?;
                let (n, last) = (dims.iter().product::<i64>() as u64, *dims.last()? as u64);
                n / last * last.next_power_of_two() * self.try_size(&s.elem)? * 8
            }
            _ => match LlvmType::try_from(ty).ok()? {
                LlvmType::Ptr(space) => self.pointers.get(&space).map_or(64, |p| p.0),
                LlvmType::Array(n, et) => self.try_size(&et)?.next_multiple_of(self.try_abi_align(&et)?) * n * 8,
                LlvmType::Struct { packed, body: Some(body), .. } => {
                    let (mut size, mut align) = (0u64, 1);
                    for e in &body {
                        let a = if packed { 1 } else { self.try_abi_align(e)? };
                        size = size.next_multiple_of(a) + self.try_size(e)?;
                        align = align.max(a);
                    }
                    size.next_multiple_of(align) * 8
                }
                _ => return None,
            },
        })
    }

    fn try_abi_align(&self, ty: &Type<'_>) -> Option<u64> {
        Some(match ty {
            Type::Shaped(s) if s.kind == ShapedKind::Vector => self.try_size(ty)?.next_power_of_two(),
            Type::Float(_) => self.try_size(ty)?.next_power_of_two(),
            Type::Index => self.try_abi_align(&Type::int(64))?,
            // Integers of 64 bits and more are 4-aligned by default.
            Type::Integer { width, .. } if *width < 64 => u64::from(width.div_ceil(8)).next_power_of_two(),
            Type::Integer { .. } => 4,
            Type::Complex(et) => self.try_abi_align(et)?,
            _ => match LlvmType::try_from(ty).ok()? {
                LlvmType::Ptr(space) => self.pointers.get(&space).map_or(8, |p| p.1 / 8),
                LlvmType::Array(_, et) => self.try_abi_align(&et)?,
                LlvmType::Struct { packed: true, body: Some(_), .. } => 1,
                LlvmType::Struct { body: Some(body), .. } => body.iter().try_fold(1, |a, e| Some(a.max(self.try_abi_align(e)?)))?,
                _ => return None,
            },
        })
    }

    fn try_preferred_align(&self, ty: &Type<'_>) -> Option<u64> {
        match ty {
            Type::Integer { .. } => Some(self.try_size(ty)?.next_power_of_two()),
            Type::Index => self.try_preferred_align(&Type::int(64)),
            Type::Complex(et) => self.try_preferred_align(et),
            _ => self.try_abi_align(ty),
        }
    }
}
