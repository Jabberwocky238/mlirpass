//! ⭐ What a GPU runs, for every vendor: the `image` dialect, its layout (GPU addresses) and its bytes.
//!
//! ```text
//!   image.memory @m {mem = "streaming"} {...}   one buffer object: what is placed in it, in order
//!   image.stream @s {...}                        a command stream of vendor ops (Intel a batch, AMD an IB, Apple a
//!                                                control stream); the vendor ends it
//!   <isa>.kernel @k {...}                         a shader: the target's instructions (`rdna2.kernel`, ...)
//!   image.data @d {bytes = dense<...>}           raw bytes (vertices, uploads), or {size} zeros
//!   image.words @w {values = [...]}              dwords that may name places (parameter buffers)
//! ```
//!
//! A vendor op placed directly in a memory (a kernel, a state struct) may carry `sym_name` and `align`. An attribute may name a
//! place: `@x` is x's GPU address, `@m::@x` its offset in memory `m`, `[@x, n]` x's address plus n (n may be negative:
//! an address relative to a window). [`Layout`] gives
//! every memory an address (`addr`) and a size (`size`), every item an offset (`offset`, aligned to its `align`, 64 by
//! default), and turns the symbols into numbers; then [`ImageEmit`] has everything it packs. What bytes a vendor op
//! is, is the vendor's [`ImageTarget`]; what ends a stream or pads a kernel is a vendor pass, before the layout.

use alloc::borrow::ToOwned;
use alloc::collections::BTreeMap;
use alloc::format;
use alloc::string::String;
use alloc::vec;
use alloc::vec::Vec;

mod pack;

pub use pack::*;

use mlirformat::{Attribute, Const, Error, NamedAttr, Op, Region};
use serde::{Deserialize, Serialize};

use crate::{A, Attrs, Body, Emit, Heads, OpId, Quiet, Rewriter, Symbol, Updates};

/// ⭐ The `image` dialect: load it with `MlirOpt::load(ImageDialect)`.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Default)]
pub struct ImageDialect;

impl mlirformat::Dialect for ImageDialect {
    fn namespace(&self) -> &'static str {
        "image"
    }

    fn ops(&self) -> Vec<mlirformat::Template> {
        Containers.ops()
    }

    /// Every op has effects (none may be dropped as dead).
    fn op_infos(&self) -> Vec<mlirformat::OpInfo> {
        ImageDialect::INHERENT.iter().map(|(name, inherent)| mlirformat::OpInfo { name, traits: &[], effects: mlirformat::Effects::Unknown, inherent }).collect()
    }
}

impl ImageDialect {
    /// Each op's properties, by name (checked against the typed ops' fields by the `inherent` test).
    pub const INHERENT: &[(&str, &[&str])] = &[
        ("image.memory", &["sym_name", "mem", "align", "size", "addr"]),
        ("image.stream", &["sym_name", "align", "offset", "cdm", "vdm"]),
        ("image.data", &["sym_name", "bytes", "size", "align", "offset"]),
        ("image.words", &["sym_name", "values", "align", "offset"]),
    ];
}

/// How the GPU caches a memory (`image.memory {mem}`).
#[derive(Clone, Copy, Debug, PartialEq, Eq, Serialize, Deserialize)]
#[serde(rename_all = "lowercase")]
pub enum MemType {
    /// Coherent with the CPU's caches (write-back).
    Coherent,
    /// Not snooped (write-combined).
    Streaming,
    /// Read by the display engine or another device.
    Scanout,
    /// Compressed (render targets).
    Compressed,
}

/// `image.memory @m {mem = "coherent"} {...}`: one buffer object; [`Layout`] gives it `addr` and `size` (at least
/// the `size` asked, a page multiple).
#[mlirformat::mlir::op("image.memory", format = "$sym_name attr-dict-with-keyword $body")]
pub struct Memory<'a> {
    #[attr(symbol)]
    pub sym_name: Attribute<'a>,
    /// How the GPU caches it (`streaming` when not said).
    pub mem: Option<MemType>,
    pub align: Option<u64>,
    pub size: Option<u64>,
    pub addr: Option<u64>,
    pub body: Region<'a>,
}

/// `image.stream @s {...}`: a command stream of vendor ops (Apple's says its engine: `{cdm}` compute, `{vdm}` vertex).
#[mlirformat::mlir::op("image.stream", format = "$sym_name attr-dict-with-keyword $body")]
pub struct Stream<'a> {
    #[attr(symbol)]
    pub sym_name: Attribute<'a>,
    pub align: Option<u64>,
    pub offset: Option<u64>,
    pub cdm: bool,
    pub vdm: bool,
    pub body: Region<'a>,
}

/// `image.data @d {bytes = dense<...>}`: raw bytes, or `{size}` zeros (both: the bytes, then zeros up to the size).
#[mlirformat::mlir::op("image.data", format = "$sym_name attr-dict")]
pub struct Data<'a> {
    #[attr(symbol)]
    pub sym_name: Attribute<'a>,
    pub bytes: Option<Attribute<'a>>,
    pub size: Option<u64>,
    pub align: Option<u64>,
    pub offset: Option<u64>,
}

/// `image.words @w {values = [...]}`: dwords that may name places.
#[mlirformat::mlir::op("image.words", format = "$sym_name attr-dict")]
pub struct Words<'a> {
    #[attr(symbol)]
    pub sym_name: Attribute<'a>,
    pub values: Vec<Attribute<'a>>,
    pub align: Option<u64>,
    pub offset: Option<u64>,
}

#[mlirformat::mlir::dialect("image", ops = [Memory, Stream, Data, Words])]
struct Containers;

impl<'a> Memory<'a> {
    /// Memory `name`, cached as `mem`.
    pub fn named(name: impl Into<String>, mem: MemType) -> Self {
        Memory::new(A::str(name.into()).into(), Some(mem), None, None, None, Region { blocks: Vec::new() })
    }
}

impl<'a> Stream<'a> {
    pub fn named(name: impl Into<String>) -> Self {
        Stream::new(A::str(name.into()).into(), None, None, false, false, Region { blocks: Vec::new() })
    }
}

impl<'a> Data<'a> {
    /// `size` zeros.
    pub fn zeros(name: impl Into<String>, size: u64) -> Self {
        Data::new(A::str(name.into()).into(), None, Some(size), None, None)
    }

    /// `bytes` (a dense constant).
    pub fn bytes(name: impl Into<String>, bytes: Attribute<'a>) -> Self {
        Data::new(A::str(name.into()).into(), Some(bytes), None, None, None)
    }

    /// Its bytes, then zeros up to its size.
    fn contents(&self) -> Result<Vec<u8>, Error> {
        let mut bytes = self.bytes.as_ref().map(Image::dense).transpose()?.unwrap_or_default();
        bytes.resize(bytes.len().max(self.size.unwrap_or(0) as usize), 0);
        Ok(bytes)
    }
}

impl Words<'_> {
    fn contents(&self) -> Result<Vec<u8>, Error> {
        self.values.iter().map(|v| Attrs::as_int(v).map(|v| (v as u32).to_le_bytes())).collect::<Result<Vec<_>, _>>().map(|w| w.concat())
    }
}

/// A placed item's discardable `align` / `offset` (a vendor op placed in a memory carries them as the image ops do).
pub struct Placed;

impl Placed {
    pub const ALIGN: &str = "align";
    pub const OFFSET: &str = "offset";
}

/// ⭐ What a vendor says about its image: where memories go, and the bytes of its ops (symbols already numbers).
pub trait ImageTarget {
    /// Where the first memory starts in the GPU's address space.
    const BASE: u64;
    /// Memories are this aligned at least (a buffer object's page).
    const PAGE: u64;

    /// An `image.stream` ⇒ its bytes (its ops packed as they are: what ends it is a vendor pass's).
    fn stream(&self, body: &Body<'_>, stream: OpId) -> Result<Vec<u8>, Error>;
    /// A vendor op placed in a memory itself (a kernel, a state struct) ⇒ bytes.
    fn item(&self, body: &Body<'_>, op: OpId) -> Result<Vec<u8>, Error>;

    /// The bytes of anything placed in a memory.
    fn contents(&self, body: &Body<'_>, op: OpId) -> Result<Vec<u8>, Error> {
        let name = &*body[op].name;
        if name == Stream::NAME {
            self.stream(body, op)
        } else if name == Data::NAME {
            body.head::<Data>(op)?.contents()
        } else if name == Words::NAME {
            body.head::<Words>(op)?.contents()
        } else {
            self.item(body, op)
        }
    }
}

/// Where a symbol is.
#[derive(Clone, Copy)]
struct Place<'s> {
    memory: &'s str,
    addr: u64,
    offset: u64,
}

/// Symbols ⇒ numbers.
struct Resolver<'s>(BTreeMap<String, Place<'s>>);

impl Resolver<'_> {
    fn int<'a>(v: u64) -> Attribute<'a> {
        A::from(v).into()
    }

    fn get(&self, s: &str) -> Result<Place<'_>, Error> {
        self.0.get(s.trim_matches('"')).copied().ok_or_else(|| Error(format!("no symbol @{s}")))
    }

    /// `a` with its symbols numbers (every symbol 0 with `zero`: to size things before there are addresses).
    fn attr<'a>(&self, a: &Attribute<'a>, zero: bool) -> Result<Attribute<'a>, Error> {
        Ok(match a {
            _ if zero && matches!(a, Attribute::SymbolRef(_)) => Self::int(0),
            Attribute::SymbolRef(p) if p.len() == 1 => Self::int(self.get(&p[0])?.addr),
            Attribute::SymbolRef(p) if p.len() == 2 => {
                let x = self.get(&p[1])?;
                if x.memory != p[0].trim_matches('"') {
                    return Err(Error(format!("@{} is not in memory @{}", p[1], p[0])));
                }
                Self::int(x.offset)
            }
            // sizing: the whole sum 0 (an offset may be negative)
            Attribute::Array(v) if zero && matches!(&v[..], [Attribute::SymbolRef(_), Attribute::Int { .. }]) => Self::int(0),
            Attribute::Array(v) if matches!(&v[..], [Attribute::SymbolRef(_), Attribute::Int { .. }]) => {
                let base = Attrs::as_int(&self.attr(&v[0], zero)?)? as u64;
                Self::int(base.wrapping_add(Attrs::as_int(&v[1])? as u64))
            }
            Attribute::Array(v) => Attribute::Array(v.iter().map(|e| self.attr(e, zero)).collect::<Result<_, _>>()?),
            Attribute::Dict(d) => Attribute::Dict(d.iter().map(|n| Ok(NamedAttr { name: n.name.clone(), value: n.value.as_ref().map(|v| self.attr(v, zero)).transpose()? })).collect::<Result<_, Error>>()?),
            _ => a.clone(),
        })
    }

    /// Every attribute of `op` and of the ops in it, resolved.
    fn op(&self, rw: &mut Rewriter<'_, '_>, op: OpId, zero: bool) -> Result<(), Error> {
        let mut ops = Vec::new();
        rw.body.walk(op, &mut |o| ops.push(o));
        for o in ops {
            for a in rw.body[o].all_attrs() {
                if let Some(v) = &a.value
                    && a.name != Symbol::ATTR
                {
                    let r = self.attr(v, zero)?;
                    if &r != v {
                        rw.modify(o, |b| b[o].set(&a.name, r));
                    }
                }
            }
        }
        Ok(())
    }
}

/// ⭐ The layout of a module for target `T` (a vendor's `<vendor>-layout` pass runs it).
pub struct Layout<'t, T: ImageTarget>(pub &'t T);

impl<T: ImageTarget> Layout<'_, T> {
    pub fn run(&self, body: &mut Body<'_>, op: OpId) -> Result<(), Error> {
        // sizes first, on a copy whose symbols are 0 (packing does not depend on them)
        let mut sized = body.clone();
        Resolver(BTreeMap::new()).op(&mut Rewriter::new(&mut sized, &mut Quiet), op, true)?;
        let mut quiet = Quiet;
        let mut rw = Rewriter::new(body, &mut quiet);
        let memories = Image::memories(rw.body, op);
        let heads = memories.iter().map(|m| rw.body.head::<Memory>(*m)).collect::<Result<Vec<_>, _>>()?;
        let mut places: Vec<(String, String, u64, u64)> = Vec::new(); // (symbol, memory, address, offset)
        let mut at = T::BASE;
        for (&m, mut head) in memories.iter().zip(heads) {
            let name = Symbol::defined(&head.sym_name)?.to_owned();
            let align = head.align.unwrap_or(T::PAGE).max(T::PAGE);
            let addr = at.next_multiple_of(align);
            let mut cursor = 0u64;
            for item in rw.body.block_ops(rw.body.top_block(m)) {
                cursor = cursor.next_multiple_of(Image::int(rw.body, item, Placed::ALIGN)?.unwrap_or(64));
                if let Some(s) = rw.body[item].get(Symbol::ATTR) {
                    places.push((Symbol::defined(s)?.to_owned(), name.clone(), addr + cursor, cursor));
                }
                rw.modify(item, |b| b[item].set(Placed::OFFSET, A::from(cursor).into()));
                cursor += self.0.contents(&sized, item)?.len() as u64;
            }
            let size = head.size.unwrap_or(0).max(cursor).next_multiple_of(4096).max(4096);
            (head.addr, head.size) = (Some(addr), Some(size));
            rw.update::<Memory>(m, |h| *h = head)?;
            places.push((name.clone(), name, addr, 0));
            at = addr + size;
        }
        let resolver = Resolver(places.iter().map(|(s, m, a, o)| (s.clone(), Place { memory: m, addr: *a, offset: *o })).collect());
        for m in memories {
            for item in rw.body.block_ops(rw.body.top_block(m)) {
                resolver.op(&mut rw, item, false)?;
            }
        }
        Ok(())
    }
}

/// One buffer object's worth: where it goes and what is in it.
#[derive(Debug, Clone)]
pub struct Segment {
    pub name: String,
    pub addr: u64,
    pub mem: MemType,
    pub bytes: Vec<u8>,
}

/// ⭐ What the GPU runs: the memories, and where the (first) command stream starts and ends.
#[derive(Debug, Clone)]
pub struct Image {
    pub segments: Vec<Segment>,
    pub stream: u64,
    /// The address after the stream's last byte (asahi's `cdm_ctrl_stream_end`).
    pub stream_end: u64,
}

impl Image {
    /// A region with nothing in it (a typed region op's, before its body has its blocks).
    pub fn region<'a>() -> Region<'a> {
        Region { blocks: Vec::new() }
    }

    pub fn segment(&self, name: &str) -> Option<&Segment> {
        self.segments.iter().find(|s| s.name == name)
    }

    /// The memories of the module.
    fn memories(body: &Body<'_>, op: OpId) -> Vec<OpId> {
        body.ops(body.top_block(op)).filter(|m| body[*m].name == Memory::NAME).collect()
    }

    /// A placed item's [`Placed`] attribute `name`.
    fn int(body: &Body<'_>, op: OpId, name: &str) -> Result<Option<u64>, Error> {
        Ok(body[op].get(name).map(Attrs::as_int).transpose()?.map(|v| v as u64))
    }

    /// A dense constant's elements, little endian.
    fn dense(a: &Attribute<'_>) -> Result<Vec<u8>, Error> {
        let c = Const::try_from(a).map_err(|()| Error("bytes: not a dense constant".into()))?;
        let n = c.ty.element_count().unwrap_or(1);
        let width = c.ty.element_type().bit_width().ok_or_else(|| Error("bytes: element without a width".into()))? as usize / 8;
        let mut out = Vec::with_capacity(n * width);
        for i in 0..n {
            let bits = match c.at(i) {
                mlirformat::Scalar::Float(f) => u128::from(f.bits),
                mlirformat::Scalar::Int(v) => v.bits(),
                mlirformat::Scalar::Complex(..) | mlirformat::Scalar::ComplexFloat(..) | mlirformat::Scalar::Wide(_) => {
                    return Err(Error("bytes: complex and wide float elements have no image layout".into()));
                }
            };
            out.extend_from_slice(&bits.to_le_bytes()[..width]);
        }
        Ok(out)
    }
}

/// ⭐ The module (after its layout) as an [`Image`], packed by target `T`.
pub struct ImageEmit<'t, T: ImageTarget>(pub &'t T);

impl<T: ImageTarget> Emit for ImageEmit<'_, T> {
    type Output = Image;

    fn emit(&self, body: &Body<'_>, op: OpId) -> Result<Image, Error> {
        let mut segments = Vec::new();
        let mut stream: Option<(u64, u64)> = None;
        for m in Image::memories(body, op) {
            let head = body.head::<Memory>(m)?;
            let name = Symbol::defined(&head.sym_name)?.to_owned();
            let addr = head.addr.ok_or_else(|| Error(format!("memory @{name} without an address: run the layout")))?;
            let size = head.size.unwrap_or(0);
            let mem = head.mem.unwrap_or(MemType::Streaming);
            let mut bytes = vec![0u8; size as usize];
            for item in body.block_ops(body.top_block(m)) {
                let offset = Image::int(body, item, Placed::OFFSET)?.unwrap_or(0) as usize;
                let b = self.0.contents(body, item)?;
                bytes[offset..offset + b.len()].copy_from_slice(&b);
                if body[item].name == Stream::NAME && stream.is_none() {
                    let at = addr + offset as u64;
                    stream = Some((at, at + b.len() as u64));
                }
            }
            segments.push(Segment { name, addr, mem, bytes });
        }
        let (stream, stream_end) = stream.ok_or_else(|| Error("no image.stream".into()))?;
        Ok(Image { segments, stream, stream_end })
    }
}
