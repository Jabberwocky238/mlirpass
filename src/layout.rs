//! Builtin memref layouts (`MemRefLayoutAttrInterface`, `getStridesAndOffset`): what the
//! strides and offset of a `memref` are, whichever dialect asks.

use alloc::string::String;
use alloc::vec::Vec;

use mlirformat::{Attribute, Dim, Shaped, StridedLayout};

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
