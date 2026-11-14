use alloc::string::String;
use alloc::vec::Vec;

use mlirformat::{Attribute, Dim, Type};

fn params(body: &str) -> Option<Vec<(String, Attribute<'static>)>> {
    mlirformat::Parser::read(body, |p| {
        p.expect("<")?;
        let mut out = Vec::new();
        if !p.eat(">") {
            loop {
                let k = String::from(p.ident()?);
                p.expect("=")?;
                out.push((k, p.attr()?.owned()));
                if !p.eat(",") {
                    break;
                }
            }
            p.expect(">")?;
        }
        Ok(out)
    })
    .ok()
}

fn ints(a: &Attribute<'_>) -> Option<Vec<i64>> {
    match a {
        Attribute::Array(es) => es.iter().map(|e| if let Attribute::Int { lit, .. } = e { lit.parse().ok() } else { None }).collect(),
        Attribute::Int { lit, .. } => Some(alloc::vec![lit.parse().ok()?]),
        _ => None,
    }
}

fn shaped(body: &str) -> Option<(Vec<i64>, Type<'static>, Vec<Attribute<'static>>)> {
    mlirformat::Parser::read(body, |p| {
        p.expect("<")?;
        let dims = p.dims()?;
        let elem = p.ty()?.owned();
        let mut attrs = Vec::new();
        while p.eat(",") {
            attrs.push(p.attr()?.owned());
        }
        p.expect(">")?;
        Ok((dims, elem, attrs))
    })
    .ok()
    .and_then(|(dims, elem, attrs)| Some((dims.into_iter().map(|d| if let Dim::Static(n) = d { Some(n) } else { None }).collect::<Option<Vec<_>>>()?, elem, attrs)))
}

fn body_of<'t>(name: &str, ext: &'t mlirformat::Extended<'_>) -> Option<&'t str> {
    (ext.name == name).then_some(())?;
    ext.body.as_deref()
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum MemorySpace {
    Global,
    Slm,
}

impl MemorySpace {
    const NAMES: [(&'static str, Self); 2] = [("global", Self::Global), ("slm", Self::Slm)];

    pub fn xevm(self) -> u32 {
        match self {
            MemorySpace::Global => 1,
            MemorySpace::Slm => 3,
        }
    }

    fn named(s: &str) -> Option<Self> {
        Self::NAMES.iter().find(|(n, _)| *n == s).map(|(_, v)| *v)
    }
}

impl TryFrom<&Attribute<'_>> for MemorySpace {
    type Error = ();
    fn try_from(a: &Attribute<'_>) -> Result<Self, ()> {
        match a {
            Attribute::Extended { ext, .. } => {
                let b = body_of("xegpu.memory_space", ext).ok_or(())?;
                Self::named(b.strip_prefix('<').and_then(|b| b.strip_suffix('>')).ok_or(())?.trim()).ok_or(())
            }
            Attribute::Builtin { name, .. } | Attribute::Str { lit: name, .. } => Self::named(name).ok_or(()),
            _ => Err(()),
        }
    }
}

#[derive(Debug, Clone)]
pub struct TensorDesc {
    pub shape: Vec<i64>,
    pub elem: Type<'static>,
    pub space: MemorySpace,
    pub array_length: i64,
    pub scattered: bool,
}

impl TryFrom<&Type<'_>> for TensorDesc {
    type Error = ();
    fn try_from(t: &Type<'_>) -> Result<Self, ()> {
        let Type::Extended(ext) = t else { return Err(()) };
        let (shape, elem, attrs) = shaped(body_of("xegpu.tensor_desc", ext).ok_or(())?).ok_or(())?;
        let mut d = TensorDesc { shape, elem, space: MemorySpace::Global, array_length: 1, scattered: false };
        for a in &attrs {
            let Attribute::Extended { ext, .. } = a else { continue };
            let scattered = ext.name == "xegpu.scatter_tdesc_attr";
            if ext.name != "xegpu.block_tdesc_attr" && !scattered {
                continue;
            }
            d.scattered = scattered;
            for (k, v) in params(ext.body.as_deref().unwrap_or("<>")).ok_or(())? {
                match &*k {
                    "memory_space" => d.space = MemorySpace::try_from(&v)?,
                    "array_length" => d.array_length = ints(&v).and_then(|v| v.first().copied()).ok_or(())?,
                    _ => {}
                }
            }
        }
        Ok(d)
    }
}

#[derive(Debug, Clone)]
pub struct MemDesc {
    pub shape: Vec<i64>,
    pub elem: Type<'static>,
    pub stride: Option<Vec<i64>>,
    pub block: Option<Vec<i64>>,
}

impl TryFrom<&Type<'_>> for MemDesc {
    type Error = ();
    fn try_from(t: &Type<'_>) -> Result<Self, ()> {
        let Type::Extended(ext) = t else { return Err(()) };
        let (shape, elem, attrs) = shaped(body_of("xegpu.mem_desc", ext).ok_or(())?).ok_or(())?;
        let mut d = MemDesc { shape, elem, stride: None, block: None };
        for a in &attrs {
            let Attribute::Extended { ext, .. } = a else { continue };
            let Some(b) = body_of("xegpu.mem_layout", ext) else { continue };
            for (k, v) in params(b).ok_or(())? {
                match &*k {
                    "stride" => d.stride = Some(ints(&v).ok_or(())?),
                    "block" => d.block = Some(ints(&v).ok_or(())?),
                    _ => {}
                }
            }
        }
        Ok(d)
    }
}

impl MemDesc {
    fn strides(&self) -> Vec<i64> {
        self.stride.clone().unwrap_or_else(|| self.shape.iter().skip(1).copied().chain([1]).collect())
    }

    pub fn block_shape(&self) -> Vec<i64> {
        self.block.clone().filter(|b| !b.is_empty()).unwrap_or_else(|| self.shape.clone())
    }

    pub fn stride_shape(&self) -> Vec<i64> {
        let strides = self.strides();
        let inner = self.block_shape();
        let n = strides.len();
        let mut perm: Vec<usize> = (0..n).collect();
        perm.sort_by_key(|&i| strides[i]);
        let mut inner_stride = alloc::vec![0i64; n];
        inner_stride[perm[0]] = 1;
        for i in 1..n {
            inner_stride[perm[i]] = inner_stride[perm[i - 1]] * inner[perm[i - 1]];
        }
        let mut blocks = alloc::vec![0i64; self.shape.len()];
        for i in 0..n - 1 {
            let orig = strides[perm[i + 1]] / strides[perm[i]];
            blocks[perm[i]] = orig / inner[perm[i]];
        }
        let inner_size: i64 = inner.iter().product();
        let mut outer = alloc::vec![0i64; self.shape.len()];
        outer[perm[0]] = inner_size;
        for i in 0..n - 1 {
            outer[perm[i + 1]] = outer[perm[i]] * blocks[perm[i]];
        }
        outer.into_iter().chain(inner_stride).collect()
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum CachePolicy {
    Cached,
    Uncached,
    Streaming,
    ReadInvalidate,
    WriteBack,
    WriteThrough,
}

impl CachePolicy {
    const NAMES: [(&'static str, Self); 6] = [("cached", Self::Cached), ("uncached", Self::Uncached), ("streaming", Self::Streaming), ("read_invalidate", Self::ReadInvalidate), ("write_back", Self::WriteBack), ("write_through", Self::WriteThrough)];
}

fn case_of<T: Copy>(a: &Attribute<'_>, name: &str, names: &[(&'static str, T)]) -> Option<T> {
    let Attribute::Extended { ext, .. } = a else { return None };
    let b = body_of(name, ext)?.strip_prefix('<')?.strip_suffix('>')?.trim();
    names.iter().find(|(n, _)| *n == b).map(|(_, v)| *v)
}

impl TryFrom<&Attribute<'_>> for CachePolicy {
    type Error = ();
    fn try_from(a: &Attribute<'_>) -> Result<Self, ()> {
        case_of(a, "xegpu.cache_hint", &Self::NAMES).ok_or(())
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum FenceScope {
    Workgroup,
    Gpu,
}

impl FenceScope {
    const NAMES: [(&'static str, Self); 2] = [("workgroup", Self::Workgroup), ("gpu", Self::Gpu)];
}

fn short_case<T: Copy>(a: &Attribute<'_>, kind: &str, names: &[(&'static str, T)]) -> Option<T> {
    let Attribute::Extended { ext, .. } = a else { return None };
    let b = body_of("xegpu", ext)?.strip_prefix('<')?.strip_suffix('>')?.trim().strip_prefix(kind)?.trim();
    names.iter().find(|(n, _)| *n == b).map(|(_, v)| *v)
}

impl TryFrom<&Attribute<'_>> for FenceScope {
    type Error = ();
    fn try_from(a: &Attribute<'_>) -> Result<Self, ()> {
        short_case(a, "fence_scope", &Self::NAMES).ok_or(())
    }
}

impl MemorySpace {
    pub fn kind(a: &Attribute<'_>) -> Option<Self> {
        short_case(a, "memory_space", &Self::NAMES)
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Chip {
    Pvc,
    Bmg,
    Cri,
    Other,
}

impl Chip {
    pub fn of_target(a: &Attribute<'_>) -> Option<Self> {
        let Attribute::Extended { ext, .. } = a else { return None };
        let ps = params(body_of("xevm.target", ext)?)?;
        let chip = ps.into_iter().find(|(k, _)| k == "chip")?.1;
        let Attribute::Str { lit, .. } = chip else { return None };
        Some(match &*lit {
            "pvc" => Chip::Pvc,
            "bmg" => Chip::Bmg,
            "cri" => Chip::Cri,
            _ => Chip::Other,
        })
    }
}
