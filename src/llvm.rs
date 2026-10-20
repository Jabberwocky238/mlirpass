//! LLVM dialect types (`!llvm.ptr`, `!llvm.struct<(...)>`, `!llvm.array<N x T>`,
//! `!llvm.func<R (A...)>`) as values, and the `LLVMTypeConverter`.
//!
//! mlirformat keeps a dialect type's body as text; [`LlvmType`] reads and writes that text
//! exactly as `mlir-opt` prints it: nested LLVM types without their `!llvm.` prefix, builtin
//! types as themselves.

use alloc::borrow::Cow;
use alloc::boxed::Box;
use alloc::format;
use alloc::string::String;
use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{Attribute, Dim, Extended, FloatKind, MlirOpt, Parser, Shaped, ShapedKind, Signedness, Type};

use crate::{Owned, TypeConverter};

/// One LLVM dialect type.
#[derive(Debug, Clone, PartialEq)]
pub enum LlvmType<'a> {
    Ptr(u32),
    Void,
    Token,
    Label,
    Metadata,
    Array(u64, Box<Type<'a>>),
    /// `body: None` is `opaque` when `opaque`, else a name-only reference to an enclosing
    /// identified struct.
    Struct { name: Option<String>, packed: bool, body: Option<Vec<Type<'a>>>, opaque: bool },
    Func { ret: Box<Type<'a>>, params: Vec<Type<'a>>, vararg: bool },
}

impl<'a> LlvmType<'a> {
    pub fn ptr() -> Type<'a> {
        LlvmType::Ptr(0).into()
    }

    pub fn literal(body: Vec<Type<'a>>) -> Type<'a> {
        LlvmType::Struct { name: None, packed: false, body: Some(body), opaque: false }.into()
    }

    pub fn array(n: u64, t: Type<'a>) -> Type<'a> {
        LlvmType::Array(n, t.into()).into()
    }

    pub fn void() -> Type<'a> {
        LlvmType::Void.into()
    }

    /// The mnemonic (`ptr`, `struct`, ...) and body text. `ctx`: the identified structs being
    /// printed around this one, with whether each is LLVM-compatible.
    fn parts(&self, ctx: &mut Vec<(String, bool)>) -> (&'static str, Option<String>) {
        let list = |ts: &[Type<'a>], ctx: &mut Vec<(String, bool)>| ts.iter().map(|t| Self::nested(t, ctx)).collect::<Vec<_>>().join(", ");
        match self {
            LlvmType::Ptr(0) => ("ptr", None),
            LlvmType::Ptr(n) => ("ptr", Some(format!("<{n}>"))),
            LlvmType::Void => ("void", None),
            LlvmType::Token => ("token", None),
            LlvmType::Label => ("label", None),
            LlvmType::Metadata => ("metadata", None),
            LlvmType::Array(n, t) => ("array", Some(format!("<{n} x {}>", Self::nested(t, ctx)))),
            LlvmType::Struct { name, packed, body, opaque } => {
                let mut s = String::from("<");
                if let Some(n) = name {
                    s.push_str(&format!("\"{n}\""));
                    if body.is_none() && !opaque {
                        s.push('>');
                        return ("struct", Some(s));
                    }
                    s.push_str(", ");
                }
                if *opaque {
                    s.push_str("opaque>");
                    return ("struct", Some(s));
                }
                if *packed {
                    s.push_str("packed ");
                }
                let b = body.as_deref().unwrap_or(&[]);
                let pushed = name.as_ref().map(|n| {
                    ctx.push((n.clone(), true));
                    let c = b.iter().all(|t| Self::compatible_in(t, ctx));
                    ctx.last_mut().expect("pushed").1 = c;
                });
                s.push_str(&format!("({})", list(b, ctx)));
                if pushed.is_some() {
                    ctx.pop();
                }
                s.push('>');
                ("struct", Some(s))
            }
            LlvmType::Func { ret, params, vararg } => {
                let mut ps = list(params, ctx);
                if *vararg {
                    ps = if ps.is_empty() { String::from("...") } else { format!("{ps}, ...") };
                }
                ("func", Some(format!("<{} ({ps})>", Self::nested(ret, ctx))))
            }
        }
    }

    /// A type as it appears inside an LLVM type (`dispatchPrint`): an LLVM-compatible LLVM
    /// type without its prefix, anything else as itself.
    fn nested(t: &Type<'a>, ctx: &mut Vec<(String, bool)>) -> String {
        match LlvmType::try_from(t) {
            Ok(l) if Self::compatible_in(t, ctx) => {
                let (m, b) = l.parts(ctx);
                format!("{m}{}", b.unwrap_or_default())
            }
            Ok(l) => {
                let (m, b) = l.parts(ctx);
                format!("!llvm.{m}{}", b.unwrap_or_default())
            }
            Err(()) => format!("{t}"),
        }
    }

    /// Parses an LLVM type at the start of `s` (mnemonic first, no prefix); the rest.
    fn parse_nested(s: &str) -> Option<(Type<'static>, &str)> {
        let s = s.trim_start();
        let word_end = s.find(|c: char| !c.is_ascii_alphanumeric() && c != '_').unwrap_or(s.len());
        let (word, rest) = s.split_at(word_end);
        let llvm = match word {
            "ptr" | "void" | "token" | "label" | "metadata" | "array" | "struct" | "func" => true,
            _ => false,
        };
        if llvm {
            let body_len = if rest.starts_with('<') { Self::group_len(rest)? } else { 0 };
            let ty = LlvmType::from_parts(word, (body_len > 0).then(|| &rest[..body_len]))?;
            return Some((ty.into(), &rest[body_len..]));
        }
        // A builtin type: let mlirformat read it.
        let opt = MlirOpt::new();
        let mut p = Parser::new(s, &opt);
        let ty = p.ty().ok()?.owned();
        let used = p.pos();
        Some((ty, &s[used..]))
    }

    /// The length of the `<...>` group at the start of `s`.
    fn group_len(s: &str) -> Option<usize> {
        let mut depth = 0i32;
        let mut quote = false;
        for (i, c) in s.char_indices() {
            match c {
                '"' => quote = !quote,
                _ if quote => {}
                '<' | '(' | '[' | '{' => depth += 1,
                '>' | ')' | ']' | '}' => {
                    depth -= 1;
                    if depth == 0 {
                        return Some(i + 1);
                    }
                }
                _ => {}
            }
        }
        None
    }

    fn list(mut s: &str) -> Option<Vec<Type<'static>>> {
        let mut out = Vec::new();
        s = s.trim();
        while !s.is_empty() {
            let (t, rest) = Self::parse_nested(s)?;
            out.push(t);
            s = rest.trim_start();
            s = s.strip_prefix(',').unwrap_or(s).trim_start();
        }
        Some(out)
    }

    fn from_parts(mnemonic: &str, body: Option<&str>) -> Option<LlvmType<'static>> {
        let inner = body.map(|b| &b[1..b.len() - 1]);
        Some(match mnemonic {
            "ptr" => LlvmType::Ptr(inner.map_or(Some(0), |n| n.trim().parse().ok())?),
            "void" => LlvmType::Void,
            "token" => LlvmType::Token,
            "label" => LlvmType::Label,
            "metadata" => LlvmType::Metadata,
            "array" => {
                let (n, t) = inner?.split_once(" x ")?;
                LlvmType::Array(n.trim().parse().ok()?, Self::parse_nested(t)?.0.into())
            }
            "struct" => {
                let mut s = inner?.trim();
                let mut name = None;
                if let Some(after) = s.strip_prefix('"') {
                    let end = after.find('"')?;
                    name = Some(String::from(&after[..end]));
                    s = after[end + 1..].trim_start().strip_prefix(',').unwrap_or(&after[end + 1..]).trim_start();
                }
                let packed = s.starts_with("packed");
                if packed {
                    s = s["packed".len()..].trim_start();
                }
                let opaque = s == "opaque";
                let body = if opaque || s.is_empty() && name.is_some() { None } else { Some(Self::list(s.strip_prefix('(')?.strip_suffix(')')?)?) };
                LlvmType::Struct { name, packed, body, opaque }
            }
            "func" => {
                let s = inner?.trim();
                let (ret, rest) = Self::parse_nested(s)?;
                let params = rest.trim().strip_prefix('(')?.strip_suffix(')')?.trim();
                let (params, vararg) = match params.strip_suffix("...") {
                    Some(p) => (p.trim().trim_end_matches(',').trim(), true),
                    None => (params, false),
                };
                LlvmType::Func { ret: ret.into(), params: Self::list(params)?, vararg }
            }
            _ => return None,
        })
    }

    /// `LLVM::isCompatibleType`.
    pub fn compatible(t: &Type<'_>) -> bool {
        Self::compatible_in(t, &mut Vec::new())
    }

    /// The same, a name-only struct reference taking the compatibility `ctx` gives it.
    fn compatible_in(t: &Type<'_>, ctx: &mut Vec<(String, bool)>) -> bool {
        match t {
            Type::Integer { signedness, .. } => *signedness == Signedness::Signless,
            Type::Float(k) => matches!(k, FloatKind::BF16 | FloatKind::F16 | FloatKind::F32 | FloatKind::F64 | FloatKind::F80 | FloatKind::F128),
            Type::Shaped(s) if s.kind == ShapedKind::Vector => s.shape.as_ref().is_some_and(|d| d.len() == 1) && Self::compatible_in(&s.elem, ctx) && !matches!(*s.elem, Type::Index),
            Type::Extended(_) => match LlvmType::try_from(t) {
                Ok(LlvmType::Array(_, e)) => Self::compatible_in(&e, ctx),
                Ok(LlvmType::Struct { name, body: Some(b), .. }) => {
                    ctx.push((name.unwrap_or_default(), true));
                    let c = b.iter().all(|e| Self::compatible_in(e, ctx));
                    ctx.pop();
                    c
                }
                Ok(LlvmType::Struct { name: Some(n), body: None, opaque: false, .. }) => ctx.iter().rev().find(|(m, _)| *m == n).is_none_or(|(_, c)| *c),
                Ok(LlvmType::Func { ret, params, .. }) => Self::compatible_in(&ret, ctx) && params.iter().all(|p| Self::compatible_in(p, ctx)),
                Ok(_) => true,
                Err(()) => false,
            },
            _ => false,
        }
    }
}

impl<'a> From<LlvmType<'a>> for Type<'a> {
    fn from(l: LlvmType<'a>) -> Self {
        let (m, body) = l.parts(&mut Vec::new());
        Type::Extended(Extended { name: Cow::Owned(format!("llvm.{m}")), body: body.map(Cow::Owned), params: Vec::new() })
    }
}

impl TryFrom<&Type<'_>> for LlvmType<'static> {
    type Error = ();

    /// Reads the body text into a type that owns everything.
    fn try_from(t: &Type<'_>) -> Result<Self, ()> {
        let Type::Extended(e) = t else { return Err(()) };
        let m = e.name.strip_prefix("llvm.").ok_or(())?;
        LlvmType::from_parts(m, e.body.as_deref()).ok_or(())
    }
}

/// `LowerToLLVMOptions`.
#[derive(Debug, Clone, Copy)]
pub struct LlvmOptions {
    pub index_bitwidth: u32,
    pub bare_ptr: bool,
}

impl Default for LlvmOptions {
    fn default() -> Self {
        Self { index_bitwidth: 64, bare_ptr: false }
    }
}

impl LlvmOptions {
    /// The `index-bitwidth` pass option alone (0: from the data layout).
    pub fn bitwidth(index_bitwidth: u32) -> Self {
        Self { index_bitwidth, ..Self::default() }
    }

    /// Index bitwidth 0: taken from the data layout (`kDeriveIndexBitwidthFromDataLayout`).
    pub fn derived() -> Self {
        Self { index_bitwidth: 0, ..Self::default() }
    }

    /// Resolves a derived index bitwidth from the `dlti.dl_spec` at or above `op`
    /// (`DataLayoutAnalysis::getAtOrAbove`); 64 without one.
    pub fn at(self, body: &crate::Body<'_>, op: crate::OpId) -> Self {
        if self.index_bitwidth != 0 {
            return self;
        }
        let mut at = Some(op);
        while let Some(o) = at {
            if let Some(bits) = body[o].get("dlti.dl_spec").and_then(Self::spec_index) {
                return Self { index_bitwidth: bits, ..self };
            }
            at = body.parent_op(o);
        }
        Self { index_bitwidth: 64, ..self }
    }

    /// The `index` entry of a `#dlti.dl_spec<...>`: `#dlti.dl_entry<index, 32>` or `index = 32`.
    fn spec_index(a: &Attribute<'_>) -> Option<u32> {
        let Attribute::Extended { ext, .. } = a else { return None };
        let body = ext.body.as_deref()?;
        let (_, rest) = body.split_once("dl_entry<index,").or_else(|| body.split_once("index ="))?;
        rest.trim_start().split(|c: char| !c.is_ascii_digit()).next()?.parse().ok()
    }

    pub fn index(&self) -> Type<'static> {
        Type::int(self.index_bitwidth)
    }

    /// The address space of a memref (`None` when it cannot be expressed).
    pub fn address_space(&self, s: &Shaped<'_>) -> Option<u32> {
        // The memory space is the last extra that is not a layout.
        let space = s.extras.iter().find(|a| !matches!(a, Attribute::Builtin { name, .. } if name == "strided" || name == "affine_map"));
        match space {
            None => Some(0),
            // `getMemRefAddressSpace`: a signless or index integer.
            Some(Attribute::Int { lit, ty: None | Some(Type::Index | Type::Integer { signedness: Signedness::Signless, .. }) }) => lit.parse().ok(),
            Some(_) => None,
        }
    }

    /// `isStrided`: an identity, `strided<...>` or linear `affine_map` layout.
    pub fn strided(&self, s: &Shaped<'_>) -> bool {
        s.extras.iter().all(|a| !matches!(a, Attribute::Builtin { name, .. } if name == "affine_map")) || self.strides_and_offset(s).is_some()
    }

    /// `getMemRefDescriptorFields`.
    pub fn descriptor_fields<'a>(&self, s: &Shaped<'a>, elem_ok: bool, unpack: bool) -> Option<Vec<Type<'a>>> {
        if !self.strided(s) || !elem_ok {
            return None;
        }
        let ptr: Type<'a> = LlvmType::Ptr(self.address_space(s)?).into();
        let idx = self.index();
        let mut out = vec![ptr.clone(), ptr, idx.clone()];
        let rank = s.shape.as_ref().map_or(0, Vec::len);
        if rank > 0 {
            if unpack {
                out.extend(core::iter::repeat_n(idx, 2 * rank));
            } else {
                out.extend(core::iter::repeat_n(LlvmType::array(rank as u64, idx), 2));
            }
        }
        Some(out)
    }
}

/// The `LLVMTypeConverter`'s rules, registered in the same order.
pub struct LlvmConverter;

impl LlvmConverter {
    /// The type converter for `options`, with the unrealized-cast materializations.
    pub fn build<'c>(options: LlvmOptions) -> TypeConverter<'c> {
        let mut tc = TypeConverter::default();
        tc.conversion(move |t| match t {
            Type::Complex(e) => {
                let e = Self::scalar(e, options)?;
                Some(Some(vec![LlvmType::literal(vec![e.clone(), e])]))
            }
            _ => None,
        });
        tc.conversion(move |t| match t {
            Type::Float(k) => Some(Self::float(*k).map(|t| vec![t])),
            _ => None,
        });
        tc.conversion(|t| matches!(t, Type::Function(_)).then(|| Some(vec![LlvmType::ptr()])));
        tc.conversion(move |t| matches!(t, Type::Index).then(|| Some(vec![options.index()])));
        tc.conversion(|t| match t {
            Type::Integer { width, .. } => Some(Some(vec![Type::int(*width)])),
            _ => None,
        });
        tc.conversion(move |t| match t {
            Type::Shaped(s) if s.kind == ShapedKind::MemRef && s.shape.is_some() => {
                let ok = Self::scalar(&s.elem, options).is_some();
                Some(options.descriptor_fields(s, ok, false).map(|f| vec![LlvmType::literal(f)]))
            }
            _ => None,
        });
        tc.conversion(move |t| match t {
            Type::Shaped(s) if s.kind == ShapedKind::MemRef && s.shape.is_none() => {
                Some(Self::scalar(&s.elem, options).map(|_| vec![LlvmType::literal(vec![options.index(), LlvmType::ptr()])]))
            }
            _ => None,
        });
        tc.conversion(move |t| match t {
            Type::Shaped(s) if s.kind == ShapedKind::Vector => Some(Self::vector(s, options).map(|t| vec![t])),
            _ => None,
        });
        tc.conversion(|t| LlvmType::compatible(t).then(|| Some(vec![t.clone()])));
        tc.conversion(move |t| match LlvmType::try_from(t).ok()? {
            LlvmType::Struct { name: None, packed, body: Some(b), .. } if !LlvmType::compatible(t) => {
                let body = b.iter().map(|e| Self::scalar(e, options)).collect::<Option<Vec<_>>>();
                Some(body.map(|b| vec![LlvmType::Struct { name: None, packed, body: Some(b), opaque: false }.into()]))
            }
            _ => None,
        });
        tc.conversion(move |t| match LlvmType::try_from(t).ok()? {
            LlvmType::Array(n, e) => Some(Self::scalar(&e, options).map(|e| vec![LlvmType::array(n, e)])),
            _ => None,
        });
        tc.conversion(move |t| match LlvmType::try_from(t).ok()? {
            LlvmType::Func { ret, params, vararg } => {
                let r = Self::scalar(&ret, options);
                let ps = params.iter().map(|p| Self::scalar(p, options)).collect::<Option<Vec<_>>>();
                Some(r.zip(ps).map(|(r, ps)| vec![LlvmType::Func { ret: r.into(), params: ps, vararg }.into()]))
            }
            _ => None,
        });
        tc.source(|rw, ty, inputs| Some(Self::cast(rw, ty, inputs)));
        tc.target(|rw, tys, inputs, _| (tys.len() == 1).then(|| vec![Self::cast(rw, &tys[0], inputs)]));
        // Memrefs from their unpacked fields (or a bare pointer): the descriptor, then a cast.
        tc.source(move |rw, ty, inputs| match ty {
            Type::Shaped(s) if s.kind == ShapedKind::MemRef && s.shape.is_none() => {
                let packed = Self::pack_unranked(rw, options, inputs)?;
                Some(Self::cast(rw, ty, &[packed]))
            }
            _ => None,
        });
        tc.source(move |rw, ty, inputs| match ty {
            Type::Shaped(s) if s.kind == ShapedKind::MemRef && s.shape.is_some() => {
                let packed = Self::pack_ranked(rw, options, s, inputs)?;
                Some(Self::cast(rw, ty, &[packed]))
            }
            _ => None,
        });
        tc.target(move |rw, tys, inputs, original| {
            let original = original?;
            let [ty] = tys else { return None };
            let Type::Shaped(s) = original else { return None };
            if s.kind != ShapedKind::MemRef || Self::convert_memref(options, s).as_ref() != Some(ty) {
                return None;
            }
            let packed = if s.shape.is_some() { Self::pack_ranked(rw, options, s, inputs)? } else { Self::pack_unranked(rw, options, inputs)? };
            Some(vec![packed])
        });
        tc
    }

    /// The descriptor struct a memref type converts to.
    pub fn convert_memref<'a>(options: LlvmOptions, s: &Shaped<'a>) -> Option<Type<'a>> {
        if s.shape.is_none() {
            return Self::scalar(&s.elem, options).map(|_| LlvmType::literal(vec![options.index(), LlvmType::ptr()]));
        }
        let ok = Self::scalar(&s.elem, options).is_some();
        options.descriptor_fields(s, ok, false).map(LlvmType::literal)
    }

    /// `packRankedMemRefDesc`: from a bare pointer (static shape) or the unpacked fields.
    fn pack_ranked<'a, L: crate::Listener<'a> + ?Sized>(rw: &mut crate::Rewriter<'_, 'a, L>, options: LlvmOptions, s: &Shaped<'a>, inputs: &[crate::ValueId]) -> Option<crate::ValueId> {
        let desc = Self::convert_memref(options, s)?;
        let input_types = rw.body.types(inputs);
        if let [p] = inputs
            && matches!(LlvmType::try_from(&rw.body[*p].ty), Ok(LlvmType::Ptr(_)))
        {
            return rw.desc_from_static(options, s, desc, *p, *p);
        }
        let ok = Self::scalar(&s.elem, options).is_some();
        if Some(input_types) != options.descriptor_fields(s, ok, true) {
            return None;
        }
        let rank = s.shape.as_ref().map_or(0, Vec::len);
        Some(rw.pack_desc(desc, rank, inputs))
    }

    /// `packUnrankedMemRefDesc`.
    fn pack_unranked<'a, L: crate::Listener<'a> + ?Sized>(rw: &mut crate::Rewriter<'_, 'a, L>, options: LlvmOptions, inputs: &[crate::ValueId]) -> Option<crate::ValueId> {
        if rw.body.types(inputs) != vec![options.index(), LlvmType::ptr()] {
            return None;
        }
        Some(rw.pack_unranked(LlvmType::literal(vec![options.index(), LlvmType::ptr()]), inputs))
    }

    fn cast<'a, L: crate::Listener<'a> + ?Sized>(rw: &mut crate::Rewriter<'_, 'a, L>, ty: &Type<'a>, inputs: &[crate::ValueId]) -> crate::ValueId {
        let c = rw.create(crate::OpData::named("builtin.unrealized_conversion_cast").operands(inputs), core::slice::from_ref(ty));
        rw.body[c].results[0]
    }

    /// The converted type of a scalar the rules nest (element types and the like).
    fn scalar<'a>(t: &Type<'a>, options: LlvmOptions) -> Option<Type<'a>> {
        match t {
            Type::Index => Some(options.index()),
            Type::Integer { width, .. } => Some(Type::int(*width)),
            Type::Float(k) => Self::float(*k),
            t if LlvmType::compatible(t) => Some(t.clone()),
            Type::Shaped(s) if s.kind == ShapedKind::Vector => Self::vector(s, options),
            Type::Shaped(s) if s.kind == ShapedKind::MemRef => Self::convert_memref(options, s),
            _ => None,
        }
    }

    /// `convertFloatType`: compatible floats stay; 8-, 6- and 4-bit ones become integers.
    fn float<'a>(k: FloatKind) -> Option<Type<'a>> {
        match k {
            FloatKind::BF16 | FloatKind::F16 | FloatKind::F32 | FloatKind::F64 | FloatKind::F80 | FloatKind::F128 => Some(Type::Float(k)),
            FloatKind::TF32 => None,
            k => crate::attr::bit_width(&Type::Float(k)).map(Type::int),
        }
    }

    /// `convertVectorType`: 0-d to 1-element, n-d to nested arrays of 1-d vectors.
    fn vector<'a>(s: &Shaped<'a>, options: LlvmOptions) -> Option<Type<'a>> {
        let elem = Self::scalar(&s.elem, options)?;
        let shape = s.shape.as_ref()?;
        let vec1 = |d: Dim| Type::Shaped(Shaped { kind: ShapedKind::Vector, shape: Some(vec![d]), elem: elem.clone().into(), extras: Vec::new() });
        let Some(last) = shape.last() else { return Some(vec1(Dim::Static(1))) };
        if shape[..shape.len() - 1].iter().any(|d| matches!(d, Dim::Scalable(_))) {
            return None;
        }
        let mut t = vec1(last.clone());
        for d in shape[..shape.len() - 1].iter().rev() {
            let Dim::Static(n) = d else { return None };
            t = LlvmType::array(*n as u64, t);
        }
        Some(t)
    }
}
