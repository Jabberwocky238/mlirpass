use alloc::borrow::ToOwned;
use alloc::collections::BTreeSet;
use alloc::format;
use alloc::string::{String, ToString};
use alloc::vec;
use alloc::vec::Vec;

use mlirformat::arith::Constant;
use mlirformat::{Attribute, Error, Extended, FunctionType, NamedAttr, Op, Operation, Region, ResultDef, Role, Type, Value};

use crate::{BlockId, Body, OpData, OpId, Quiet, Rewriter, ValueId};

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct RegType<'t> {
    pub name: &'t str,
    pub elem: &'t str,
}

impl<'a> From<RegType<'_>> for Type<'a> {
    fn from(r: RegType<'_>) -> Self {
        Type::Extended(alloc::boxed::Box::new(Extended { name: r.name.to_owned().into(), body: Some(format!("<{}>", r.elem).into()), params: Vec::new() }))
    }
}

impl<'t> TryFrom<&'t Type<'_>> for RegType<'t> {
    type Error = Error;

    fn try_from(t: &'t Type<'_>) -> Result<RegType<'t>, Error> {
        let not = || Error(format!("{t} is not a register type"));
        let Type::Extended(e) = t else { return Err(not()) };
        let elem = e.body.as_deref().and_then(|b| b.strip_prefix('<')?.strip_suffix('>')).ok_or_else(not)?;
        Ok(RegType { name: &e.name, elem })
    }
}

#[derive(Clone, Copy, Debug)]
pub struct RegSlots<'s>(pub &'s [&'s str]);

impl<'a> From<RegSlots<'_>> for Attribute<'a> {
    fn from(s: RegSlots<'_>) -> Self {
        Attribute::Array(s.0.iter().map(|x| Attribute::Str { lit: String::from(*x).into(), ty: None }).collect())
    }
}

impl RegSlots<'_> {
    pub fn of(op: &OpData<'_>) -> Result<Vec<String>, Error> {
        match op.get("slots") {
            Some(Attribute::Array(s)) => s
                .iter()
                .map(|x| match x {
                    Attribute::Str { lit, .. } => Ok(lit.to_string()),
                    _ => Err(Error(format!("slot {x}"))),
                })
                .collect(),
            _ => Ok(Vec::new()),
        }
    }
}

#[derive(Clone, Debug)]
pub enum A {
    Bool(bool),
    Int(i128),
    F32(f32),
    Sym(String),
    In(String, String),
    Str(String),
    Raw(Attribute<'static>),
}

impl From<bool> for A {
    fn from(v: bool) -> Self {
        A::Bool(v)
    }
}

macro_rules! ints {
    ($($t:ty),*) => {$(
        impl From<$t> for A {
            fn from(v: $t) -> Self {
                A::Int(v.into())
            }
        }
    )*};
}

ints!(u8, u16, u32, u64, i32, i64);

impl From<f32> for A {
    fn from(v: f32) -> Self {
        A::F32(v)
    }
}

impl From<Attribute<'static>> for A {
    fn from(v: Attribute<'static>) -> Self {
        A::Raw(v)
    }
}

impl A {
    pub fn sym(s: impl Into<String>) -> A {
        A::Sym(s.into())
    }

    pub fn within(memory: impl Into<String>, s: impl Into<String>) -> A {
        A::In(memory.into(), s.into())
    }

    pub fn str(s: impl Into<String>) -> A {
        A::Str(s.into())
    }
}

impl<'a> From<A> for Attribute<'a> {
    fn from(v: A) -> Self {
        match v {
            A::Bool(b) => Attribute::Bool(b),
            A::Int(i) => Attribute::Int { lit: if i < 0 { i.to_string() } else { format!("{i:#x}") }.into(), ty: None },
            A::F32(f) => Attribute::Float { lit: format!("{f:?}").into(), ty: Some(Type::Float(mlirformat::FloatKind::F32)) },
            A::Sym(s) => Attribute::SymbolRef(vec![s.into()]),
            A::In(m, s) => Attribute::SymbolRef(vec![m.into(), s.into()]),
            A::Str(s) => Attribute::Str { lit: s.into(), ty: None },
            A::Raw(a) => a,
        }
    }
}

impl A {
    pub fn dict<'a>(entries: Vec<(&str, A)>) -> Attribute<'a> {
        Attribute::Dict(entries.into_iter().map(|(n, v)| NamedAttr { name: String::from(n).into(), value: Some(v.into()) }).collect())
    }
}

pub trait WithAttrs {
    fn with_attrs(self, attrs: Vec<(&str, A)>) -> Self;
}

impl WithAttrs for OpData<'_> {
    fn with_attrs(mut self, attrs: Vec<(&str, A)>) -> Self {
        for (n, v) in attrs {
            self.set(n, v.into());
        }
        self
    }
}

pub struct Attrs<'r, 'a>(pub &'r [NamedAttr<'a>]);

impl<'r, 'a> Attrs<'r, 'a> {
    pub fn get(&self, name: &str) -> Option<&'r Attribute<'a>> {
        self.0.iter().find(|a| a.name == name).and_then(|a| a.value.as_ref())
    }

    fn need(&self, name: &str) -> Result<&'r Attribute<'a>, Error> {
        self.get(name).ok_or_else(|| Error(format!("no {name}")))
    }

    pub fn int(&self, name: &str) -> Result<Option<i64>, Error> {
        self.get(name).map(Self::as_int).transpose()
    }

    pub fn need_int(&self, name: &str) -> Result<i64, Error> {
        Self::as_int(self.need(name)?)
    }

    pub fn bool(&self, name: &str) -> Result<Option<bool>, Error> {
        self.get(name)
            .map(|a| match a {
                Attribute::Bool(b) => Ok(*b),
                Attribute::Unit => Ok(true),
                a => Err(Error(format!("{name}: {a} is not a boolean"))),
            })
            .transpose()
    }

    pub fn str(&self, name: &str) -> Result<&'r str, Error> {
        match self.need(name)? {
            Attribute::Str { lit, .. } => Ok(lit),
            a => Err(Error(format!("{name}: {a} is not a string"))),
        }
    }

    pub fn symbol(&self, name: &str) -> Result<&'r str, Error> {
        Self::as_symbol(self.need(name)?)
    }

    pub fn array(&self, name: &str) -> Result<&'r [Attribute<'a>], Error> {
        match self.get(name) {
            None => Ok(&[]),
            Some(Attribute::Array(v)) => Ok(v),
            Some(a) => Err(Error(format!("{name}: {a} is not an array"))),
        }
    }

    pub fn floats(&self, name: &str) -> Result<Vec<f64>, Error> {
        self.array(name)?.iter().map(Self::as_float).collect()
    }

    pub fn as_int(a: &Attribute<'_>) -> Result<i64, Error> {
        match a {
            Attribute::Int { lit, .. } => match lit.strip_prefix("0x") {
                Some(h) => i64::from_str_radix(h, 16),
                None => lit.parse(),
            }
            .map_err(|_| Error(format!("bad integer {lit}"))),
            a => Err(Error(format!("{a} is not an integer"))),
        }
    }

    fn as_float(a: &Attribute<'_>) -> Result<f64, Error> {
        match a {
            Attribute::Float { lit, .. } => lit.parse().map_err(|_| Error(format!("bad float {lit}"))),
            Attribute::Int { .. } => Self::as_int(a).map(|v| v as f64),
            a => Err(Error(format!("{a} is not a number"))),
        }
    }

    pub fn as_symbol(a: &'r Attribute<'a>) -> Result<&'r str, Error> {
        match a {
            Attribute::SymbolRef(path) if path.len() == 1 => Ok(path[0].trim_matches('"')),
            a => Err(Error(format!("{a} is not a symbol"))),
        }
    }

    pub fn as_dict(a: &'r Attribute<'a>) -> Result<Attrs<'r, 'a>, Error> {
        match a {
            Attribute::Dict(d) => Ok(Attrs(d)),
            a => Err(Error(format!("{a} is not a dictionary"))),
        }
    }
}

pub trait Heads<'a> {
    fn head<O: Op>(&self, op: OpId) -> Result<O, Error>;
    fn store<O>(&mut self, op: OpId, typed: &O) -> Result<(), Error>
    where
        for<'o> Operation<'static>: TryFrom<&'o O, Error = Error>;
    fn update<O: Op>(&mut self, op: OpId, f: impl FnOnce(&mut O)) -> Result<(), Error>
    where
        for<'o> Operation<'static>: TryFrom<&'o O, Error = Error>,
    {
        let mut typed = self.head::<O>(op)?;
        f(&mut typed);
        self.store(op, &typed)
    }
    fn container<O>(&mut self, typed: &O) -> Result<(OpId, BlockId), Error>
    where
        for<'o> Operation<'static>: TryFrom<&'o O, Error = Error>;
}

pub trait Updates {
    fn update<O: Op>(&mut self, op: OpId, f: impl FnOnce(&mut O)) -> Result<(), Error>
    where
        for<'o> Operation<'static>: TryFrom<&'o O, Error = Error>;
}

impl Updates for Rewriter<'_, '_> {
    fn update<O: Op>(&mut self, op: OpId, f: impl FnOnce(&mut O)) -> Result<(), Error>
    where
        for<'o> Operation<'static>: TryFrom<&'o O, Error = Error>,
    {
        let mut done = Ok(());
        self.modify(op, |b| done = b.update(op, f));
        done
    }
}

pub trait OpHead<'a>: Sized {
    fn head<O>(typed: &O) -> Result<Self, Error>
    where
        for<'o> Operation<'static>: TryFrom<&'o O, Error = Error>;
}

impl<'a> OpHead<'a> for OpData<'a> {
    fn head<O>(typed: &O) -> Result<Self, Error>
    where
        for<'o> Operation<'static>: TryFrom<&'o O, Error = Error>,
    {
        let g = Operation::try_from(typed)?;
        let mut data = OpData::build(&g.name);
        if let Some(Attribute::Dict(props)) = g.properties {
            props.into_iter().for_each(|a| data.set(&a.name, a.value.unwrap_or(Attribute::Unit)));
        }
        g.attributes.into_iter().for_each(|a| data.set(&a.name, a.value.unwrap_or(Attribute::Unit)));
        Ok(data)
    }
}

impl<'a> Heads<'a> for Body<'a> {
    fn head<O: Op>(&self, op: OpId) -> Result<O, Error> {
        let d = &self[op];
        let (props, attributes): (Vec<_>, Vec<_>) = d.all_attrs().into_iter().partition(|a| O::FIELDS.iter().any(|f| matches!(f.role, Role::Prop { .. }) && f.name == &*a.name));
        let value = |v: &ValueId| Value::from(*v);
        let types = |vs: &[ValueId]| vs.iter().map(|v| self[*v].ty.clone()).collect();
        let g = Operation {
            name: d.name.clone(),
            results: d.results.first().map(|r| ResultDef { name: value(r).name, count: (d.results.len() > 1).then_some(d.results.len() as u32) }).into_iter().collect(),
            operands: d.operands.iter().map(value).collect(),
            properties: (!props.is_empty()).then_some(Attribute::Dict(props)),
            attributes,
            regions: d.regions.iter().map(|_| Region { blocks: Vec::new() }).collect(),
            ty: FunctionType { inputs: types(&d.operands), results: types(&d.results) },
            ..Default::default()
        };
        g.to_op()
    }

    fn store<O>(&mut self, op: OpId, typed: &O) -> Result<(), Error>
    where
        for<'o> Operation<'static>: TryFrom<&'o O, Error = Error>,
    {
        let data = OpData::head(typed)?;
        for a in data.all_attrs() {
            self[op].set(&a.name, a.value.unwrap_or(Attribute::Unit));
        }
        Ok(())
    }

    fn container<O>(&mut self, typed: &O) -> Result<(OpId, BlockId), Error>
    where
        for<'o> Operation<'static>: TryFrom<&'o O, Error = Error>,
    {
        let op = self.create(OpData::head(typed)?, &[]);
        let r = self.add_region(op);
        Ok((op, self.add_block(r, &[])))
    }
}

#[macro_export]
macro_rules! rewrites {
    (@root _) => { None };
    (@root $root:tt) => { Some($root) };
    ($($(#[$m:meta])* $name:ident($root:tt, $benefit:literal) |$rw:ident, $op:ident| $body:block)*) => {$(
        $(#[$m])*
        pub struct $name;

        impl $crate::Pattern for $name {
            fn name(&self) -> &str {
                stringify!($name)
            }

            fn root(&self) -> Option<&str> {
                $crate::rewrites!(@root $root)
            }

            fn benefit(&self) -> u16 {
                $benefit
            }

            #[allow(unused_variables)]
            fn rewrite(&self, $rw: &mut $crate::Rewriter<'_, '_>, $op: $crate::OpId) -> bool $body
        }
    )*};
}

pub struct Rewrites;

impl Rewrites {
    pub fn apply(body: &mut Body<'_>, op: OpId, patterns: &crate::PatternSet) {
        let config = crate::GreedyConfig { region_simplify: crate::RegionSimplify::Disabled, fold: false, cse_constants: false, ..Default::default() };
        let region = body[op].regions[0];
        body.apply_greedily(region, patterns, &config);
    }
}

pub struct OpRows;

impl OpRows {
    pub fn of(ops: &[mlirformat::Template], inherent: &[(&'static str, &'static [&'static str])]) -> Vec<mlirformat::OpInfo> {
        let inherent: alloc::collections::BTreeMap<&str, &'static [&'static str]> = inherent.iter().rev().copied().collect();
        ops.iter()
            .map(|t| {
                let inherent = inherent.get(t.name).copied().unwrap_or_default();
                mlirformat::OpInfo { name: t.name, traits: &[], effects: mlirformat::Effects::Unknown, inherent }
            })
            .collect()
    }
}

#[macro_export]
macro_rules! attr_ops {
    ($ns:tt $set:ident; $($ty:ident $op:literal,)*) => {
        $(
            #[doc = concat!("`", $op, "`")]
            #[mlirformat::mlir::op($op, format = "(`(` $operands^ `:` type($operands) `)`)? attr-dict (`->` type($results)^)?", results(results))]
            pub struct $ty<'a> {
                #[slot(types)]
                pub operands: Vec<mlirformat::Value<'a>>,
                pub types: Vec<mlirformat::Type<'a>>,
                pub results: Vec<mlirformat::Type<'a>>,
            }
        )*

        #[mlirformat::mlir::dialect($ns, ops = [$($ty),*])]
        pub(crate) struct $set;
    };
}

pub trait SinkConstants {
    fn sink_constants(&mut self, shaders: &[OpId]);
}

impl SinkConstants for Body<'_> {
    fn sink_constants(&mut self, shaders: &[OpId]) {
        let mut constants = Vec::new();
        for &f in shaders {
            self.walk(f, &mut |o| {
                if self[o].name == Constant::NAME {
                    constants.push(o);
                }
            });
        }
        let mut quiet = Quiet;
        let mut rw = Rewriter::new(self, &mut quiet);
        for k in constants {
            let v = rw.body[k].results[0];
            let ty = rw.body[v].ty.clone();
            let uses: BTreeSet<OpId> = rw.body[v].uses.iter().map(|u| u.op).collect();
            for user in uses {
                let mut data = OpData::build(Constant::NAME);
                data.properties = rw.body[k].properties.clone();
                data.attributes = rw.body[k].attributes.clone();
                rw.set_before(user);
                let c = rw.create(data, core::slice::from_ref(&ty));
                let cv = rw.body[c].results[0];
                rw.replace_uses_if(v, cv, |_, u| u.op == user);
            }
            rw.erase_op(k);
        }
    }
}

pub struct Symbol;

impl Symbol {
    pub const ATTR: &str = "sym_name";

    pub fn defined<'r>(a: &'r Attribute<'_>) -> Result<&'r str, Error> {
        match a {
            Attribute::Str { lit, .. } => Ok(lit),
            a => Self::name(a),
        }
    }

    pub fn name<'r>(a: &'r Attribute<'_>) -> Result<&'r str, Error> {
        match a {
            Attribute::SymbolRef(path) if path.len() == 1 => Ok(path[0].trim_matches('"')),
            a => Err(Error(format!("{a} is not a symbol"))),
        }
    }
}
