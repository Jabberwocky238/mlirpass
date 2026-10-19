//! `MemRefDescriptor` and `UnrankedMemRefDescriptor`, as `MemRefBuilder.cpp`: the struct a
//! memref lowers to, built and taken apart with `llvm.insertvalue` / `llvm.extractvalue`.
//!
//! ```text
//! ranked    { allocated ptr, aligned ptr, offset, sizes[rank], strides[rank] }
//! unranked  { rank, ptr to a ranked descriptor }
//! ```

use alloc::borrow::Cow;
use alloc::format;
use alloc::vec::Vec;

use mlirformat::{Attribute, Dim, Shaped, Type};

use crate::{ConversionRewriter, LlvmOptions, Listener, OpData, Rewriter, ValueId};

/// `ShapedType::kDynamic`.
pub const DYNAMIC: i64 = i64::MIN;

impl LlvmOptions {
    /// `getStridesAndOffset`: from a `strided<...>` layout, or row-major for the identity.
    pub fn strides_and_offset(&self, s: &Shaped<'_>) -> Option<(Vec<i64>, i64)> {
        let layout = s.extras.iter().find_map(|a| match a {
            Attribute::Builtin { name, body, .. } if name == "strided" || name == "affine_map" => Some((name == "strided", body)),
            _ => None,
        });
        let shape = s.shape.as_ref()?;
        if let Some((false, map)) = layout {
            return Linear::strides(map, shape.len());
        }
        let Some((_, body)) = layout else {
            let mut strides = alloc::vec![0i64; shape.len()];
            let mut running = 1i64;
            for (i, d) in shape.iter().enumerate().rev() {
                strides[i] = running;
                running = match (running, d) {
                    (DYNAMIC, _) | (_, Dim::Dynamic) => DYNAMIC,
                    (r, Dim::Static(n) | Dim::Scalable(n)) => r * n,
                };
            }
            return Some((strides, 0));
        };
        // `<[s0, s1], offset: o>`
        let inner = body.trim().strip_prefix('<')?.strip_suffix('>')?;
        let (list, rest) = inner.split_once(']')?;
        let num = |t: &str| if t.trim() == "?" { Some(DYNAMIC) } else { t.trim().parse().ok() };
        let strides = list.trim_start_matches('[').split(',').filter(|t| !t.trim().is_empty()).map(num).collect::<Option<Vec<_>>>()?;
        let offset = match rest.split_once("offset:") {
            Some((_, o)) => num(o)?,
            None => 0,
        };
        Some((strides, offset))
    }
}

impl<'a> ConversionRewriter<'_, 'a, '_> {
    /// `createIndexAttrConstant`: an `llvm.mlir.constant` of `v : index` typed `ty`.
    pub fn index_const(&mut self, ty: &Type<'a>, v: i64) -> ValueId {
        self.rw.index_const(ty, v)
    }

    /// `MemRefDescriptor::pack` from the unpacked fields.
    pub fn pack_desc(&mut self, desc_ty: Type<'a>, rank: usize, fields: &[ValueId]) -> ValueId {
        self.rw.pack_desc(desc_ty, rank, fields)
    }

    /// `MemRefDescriptor::unpack`.
    pub fn unpack_desc(&mut self, desc: ValueId, rank: usize) -> Vec<ValueId> {
        let mut out = Vec::new();
        for p in [0, 1, 2] {
            out.push(self.extract(desc, &[p]));
        }
        for i in 0..rank as i64 {
            out.push(self.extract(desc, &[3, i]));
        }
        for i in 0..rank as i64 {
            out.push(self.extract(desc, &[4, i]));
        }
        out
    }

    /// `MemRefDescriptor::fromStaticShape`.
    pub fn desc_from_static(&mut self, opts: LlvmOptions, s: &Shaped<'a>, desc_ty: Type<'a>, ptr: ValueId, aligned: ValueId) -> Option<ValueId> {
        self.rw.desc_from_static(opts, s, desc_ty, ptr, aligned)
    }
}

impl<'r, 'a, L: Listener<'a> + ?Sized> Rewriter<'r, 'a, L> {
    fn value(&mut self, data: OpData<'a>, ty: Type<'a>) -> ValueId {
        let o = self.create(data, &[ty]);
        self.body[o].results[0]
    }

    fn insert_at(&mut self, agg: ValueId, v: ValueId, pos: &[i64]) -> ValueId {
        let ty = self.body[agg].ty.clone();
        let p = Attribute::DenseArray { ty: Type::int(64), values: pos.iter().map(|x| Cow::Owned(format!("{x}"))).collect() };
        self.value(OpData::build("llvm.insertvalue").operands(&[agg, v]).with("position", p), ty)
    }

    pub fn index_const(&mut self, ty: &Type<'a>, v: i64) -> ValueId {
        let value = Attribute::Int { lit: Cow::Owned(format!("{v}")), ty: Some(Type::Index) };
        self.value(OpData::build("llvm.mlir.constant").with("value", value), ty.clone())
    }

    /// `MemRefDescriptor::pack`: allocated, aligned, offset, then each (size, stride) pair.
    pub fn pack_desc(&mut self, desc_ty: Type<'a>, rank: usize, fields: &[ValueId]) -> ValueId {
        let mut d = self.value(OpData::build("llvm.mlir.poison"), desc_ty);
        for p in [0, 1, 2] {
            d = self.insert_at(d, fields[p], &[p as i64]);
        }
        for i in 0..rank {
            d = self.insert_at(d, fields[3 + i], &[3, i as i64]);
            d = self.insert_at(d, fields[3 + rank + i], &[4, i as i64]);
        }
        d
    }

    /// `UnrankedMemRefDescriptor::pack`.
    pub fn pack_unranked(&mut self, desc_ty: Type<'a>, fields: &[ValueId]) -> ValueId {
        let mut d = self.value(OpData::build("llvm.mlir.poison"), desc_ty);
        d = self.insert_at(d, fields[0], &[0]);
        self.insert_at(d, fields[1], &[1])
    }

    /// `MemRefDescriptor::fromStaticShape`: the pointers, then offset, sizes and strides constant.
    pub fn desc_from_static(&mut self, opts: LlvmOptions, s: &Shaped<'a>, desc_ty: Type<'a>, ptr: ValueId, aligned: ValueId) -> Option<ValueId> {
        let (strides, offset) = opts.strides_and_offset(s)?;
        let idx = opts.index();
        let mut d = self.value(OpData::build("llvm.mlir.poison"), desc_ty);
        d = self.insert_at(d, ptr, &[0]);
        d = self.insert_at(d, aligned, &[1]);
        let o = self.index_const(&idx, offset);
        d = self.insert_at(d, o, &[2]);
        for (i, dim) in s.shape.as_ref()?.iter().enumerate() {
            let Dim::Static(n) = dim else { return None };
            let size = self.index_const(&idx, *n);
            d = self.insert_at(d, size, &[3, i as i64]);
            let st = self.index_const(&idx, strides[i]);
            d = self.insert_at(d, st, &[4, i as i64]);
        }
        Some(d)
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
            Coef::Dyn => DYNAMIC,
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
