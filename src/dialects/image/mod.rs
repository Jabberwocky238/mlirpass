use alloc::borrow::ToOwned;
use alloc::collections::BTreeMap;
use alloc::format;
use alloc::string::String;
use alloc::vec;
use alloc::vec::Vec;

pub use mlirbinary::{Hole, Image, ImageTarget, ImageWriter, Pack, Segment, Template};
pub use mlirformat::image::*;

use mlirbinary::Ir;
use mlirformat::{Attribute, Error, NamedAttr, Op};

use crate::{A, Attrs, Body, Emit, Heads, OpId, Quiet, Rewriter, Symbol, Updates};

#[derive(Clone, Copy)]
struct Place<'s> {
    memory: &'s str,
    addr: u64,
    offset: u64,
}

struct Resolver<'s>(BTreeMap<String, Place<'s>>);

impl Resolver<'_> {
    fn int<'a>(v: u64) -> Attribute<'a> {
        A::from(v).into()
    }

    fn get(&self, s: &str) -> Result<Place<'_>, Error> {
        self.0.get(s.trim_matches('"')).copied().ok_or_else(|| Error(format!("no symbol @{s}")))
    }

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

/// Lays out an image: each memory placed from the target's base, its items one after another,
/// then symbols replaced by their addresses (and `@memory::@item` by offsets)
pub struct Layout<'t, T: ImageTarget>(pub &'t T);

impl<T: ImageTarget> Layout<'_, T> {
    /// Each memory's items' sizes, symbols read as zero
    fn sizes(&self, body: &Body<'_>, op: OpId) -> Result<Vec<Vec<u64>>, Error> {
        let mut sized = body.clone();
        Resolver(BTreeMap::new()).op(&mut Rewriter::new(&mut sized, &mut Quiet), op, true)?;
        let root = sized.operation(op);
        let ir = Ir::new(&root)?;
        let memories = ir.block_ops(ir.top_block(ir.root)).into_iter().filter(|m| ir[*m].name == Memory::NAME);
        memories.map(|m| ir.block_ops(ir.top_block(m)).into_iter().map(|item| self.0.contents(&ir, item).map(|b| b.len() as u64)).collect()).collect()
    }

    pub fn run(&self, body: &mut Body<'_>, op: OpId) -> Result<(), Error> {
        let sizes = self.sizes(body, op)?;
        let mut quiet = Quiet;
        let mut rw = Rewriter::new(body, &mut quiet);
        let memories = Layout::<T>::memories(rw.body, op);
        let heads = memories.iter().map(|m| rw.body.head::<Memory>(*m)).collect::<Result<Vec<_>, _>>()?;
        let mut places: Vec<(String, String, u64, u64)> = Vec::new();
        let mut at = T::BASE;
        for ((&m, mut head), sizes) in memories.iter().zip(heads).zip(sizes) {
            let name = Symbol::defined(&head.sym_name)?.to_owned();
            let align = head.align.unwrap_or(T::PAGE).max(T::PAGE);
            let addr = at.next_multiple_of(align);
            let mut cursor = 0u64;
            for (item, len) in rw.body.block_ops(rw.body.top_block(m)).into_iter().zip(sizes) {
                cursor = cursor.next_multiple_of(Layout::<T>::int(rw.body, item, Placed::ALIGN)?.unwrap_or(64));
                if let Some(s) = rw.body[item].get(Symbol::ATTR) {
                    places.push((Symbol::defined(s)?.to_owned(), name.clone(), addr + cursor, cursor));
                }
                rw.modify(item, |b| b[item].set(Placed::OFFSET, A::from(cursor).into()));
                cursor += len;
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

    fn memories(body: &Body<'_>, op: OpId) -> Vec<OpId> {
        body.ops(body.top_block(op)).filter(|m| body[*m].name == Memory::NAME).collect()
    }

    fn int(body: &Body<'_>, op: OpId, name: &str) -> Result<Option<u64>, Error> {
        Ok(body[op].get(name).map(Attrs::as_int).transpose()?.map(|v| v as u64))
    }
}

/// An image laid out (`Layout`) written as its memories' contents, by mlirbinary
pub struct ImageEmit<'t, T: ImageTarget>(pub &'t T);

impl<T: ImageTarget> Emit for ImageEmit<'_, T> {
    type Output = Image;

    fn emit(&self, body: &Body<'_>, op: OpId) -> Result<Image, Error> {
        ImageWriter(self.0).image(&body.operation(op))
    }
}

impl From<A> for Fill {
    fn from(a: A) -> Self {
        Fill::try_from(&a).unwrap_or_else(|e| panic!("{e}"))
    }
}

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
