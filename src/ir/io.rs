//! [`Module`] ⇄ [`Body`]: SSA names resolved on the way in, made up again on the way out.
//!
//! In: every region is one name scope (nested regions see outward, never inward); a scope's
//! definitions and block labels are collected before any use is resolved, so forward references
//! work. Attribute and type aliases (`#map`, `!t`) are inlined. A custom form mlirformat kept raw
//! cannot be imported: the IR has to be generic, or in a registered dialect.
//!
//! Out: names follow `mlir-opt`'s custom form — `%N` and `%argN` counted in preorder, both
//! restored on leaving a region, restarted at an op isolated from above; `^bbN` per region.

use alloc::borrow::Cow;
use alloc::collections::BTreeMap;
use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;

use mlirformat::{Attribute, Block, BlockArg, Error, Extended, FunctionType, Item, Module, NamedAttr, Operation, Region, ResultDef, Shaped, Str, Type, Value};

use super::{Body, BlockId, OpData, OpId, RegionId, ValueId};

/// The module's aliases, each already resolved against the earlier ones.
#[derive(Default)]
struct Aliases<'a> {
    attrs: BTreeMap<String, Attribute<'a>>,
    types: BTreeMap<String, Type<'a>>,
    /// Location aliases (`#loc3 = loc("f":1:2)`), by name, as the text inside `loc(...)`.
    locs: BTreeMap<String, String>,
}

impl<'a> Aliases<'a> {
    /// A location's raw text with every location alias in it spelled out.
    fn loc(&self, raw: &Option<Str<'a>>) -> Option<Str<'a>> {
        let raw = raw.as_ref()?;
        if !raw.contains('#') || self.locs.is_empty() {
            return Some(raw.clone());
        }
        let mut out = String::new();
        let mut rest = &**raw;
        while let Some(i) = rest.find('#') {
            out.push_str(&rest[..i]);
            let tail = &rest[i + 1..];
            let end = tail.find(|c: char| !(c.is_ascii_alphanumeric() || matches!(c, '_' | '.' | '$' | '-'))).unwrap_or(tail.len());
            match self.locs.get(&tail[..end]) {
                Some(body) => out.push_str(body),
                None => {
                    out.push('#');
                    out.push_str(&tail[..end]);
                }
            }
            rest = &tail[end..];
        }
        out.push_str(rest);
        Some(Cow::Owned(out))
    }

    /// `name` names an alias rather than a dialect symbol (`#map`, not `#arith.fastmath<...>`).
    fn alias<'x>(ext: &'x Extended<'_>) -> Option<&'x str> {
        (ext.body.is_none() && ext.params.is_empty() && !ext.name.contains('.')).then_some(&*ext.name)
    }

    fn ty(&self, t: &Type<'a>) -> Type<'a> {
        match t {
            Type::Extended(ext) => match Self::alias(ext).and_then(|n| self.types.get(n)) {
                Some(t) => t.clone(),
                None => Type::Extended(self.ext(ext)),
            },
            Type::Complex(e) => Type::Complex(self.ty(e).into()),
            Type::Tuple(ts) => Type::Tuple(self.tys(ts)),
            Type::Function(f) => Type::Function(self.fn_ty(f)),
            Type::Shaped(s) => Type::Shaped(Shaped { kind: s.kind, shape: s.shape.clone(), elem: self.ty(&s.elem).into(), extras: self.attrs(&s.extras) }),
            t => t.clone(),
        }
    }

    fn tys(&self, ts: &[Type<'a>]) -> Vec<Type<'a>> {
        ts.iter().map(|t| self.ty(t)).collect()
    }

    fn fn_ty(&self, f: &FunctionType<'a>) -> FunctionType<'a> {
        FunctionType { inputs: self.tys(&f.inputs), results: self.tys(&f.results) }
    }

    fn ext(&self, e: &Extended<'a>) -> Extended<'a> {
        Extended { name: e.name.clone(), body: e.body.clone(), params: self.attrs(&e.params) }
    }

    fn opt_ty(&self, t: &Option<Type<'a>>) -> Option<Type<'a>> {
        t.as_ref().map(|t| self.ty(t))
    }

    fn attr(&self, a: &Attribute<'a>) -> Attribute<'a> {
        match a {
            Attribute::Extended { ext, ty } => match (Self::alias(ext).and_then(|n| self.attrs.get(n)), ty) {
                (Some(a), None) => a.clone(),
                _ => Attribute::Extended { ext: self.ext(ext), ty: self.opt_ty(ty) },
            },
            Attribute::Int { lit, ty } => Attribute::Int { lit: lit.clone(), ty: self.opt_ty(ty) },
            Attribute::Float { lit, ty } => Attribute::Float { lit: lit.clone(), ty: self.opt_ty(ty) },
            Attribute::Str { lit, ty } => Attribute::Str { lit: lit.clone(), ty: self.opt_ty(ty) },
            Attribute::Type(t) => Attribute::Type(self.ty(t)),
            Attribute::Array(xs) => Attribute::Array(self.attrs(xs)),
            Attribute::Dict(d) => Attribute::Dict(self.dict(d)),
            Attribute::DenseArray { ty, values } => Attribute::DenseArray { ty: self.ty(ty), values: values.clone() },
            Attribute::Builtin { name, body, ty } => Attribute::Builtin { name: name.clone(), body: body.clone(), ty: self.opt_ty(ty) },
            a => a.clone(),
        }
    }

    fn attrs(&self, xs: &[Attribute<'a>]) -> Vec<Attribute<'a>> {
        xs.iter().map(|a| self.attr(a)).collect()
    }

    fn dict(&self, d: &[NamedAttr<'a>]) -> Vec<NamedAttr<'a>> {
        d.iter().map(|n| NamedAttr { name: n.name.clone(), value: n.value.as_ref().map(|v| self.attr(v)) }).collect()
    }
}

/// One name scope: a region's values and block labels.
#[derive(Default)]
struct Scope<'m> {
    values: BTreeMap<&'m str, Vec<ValueId>>,
    labels: BTreeMap<&'m str, BlockId>,
}

/// The state of one import.
struct Import<'m, 'a> {
    body: Body<'a>,
    aliases: Aliases<'a>,
    scopes: Vec<Scope<'m>>,
}

impl<'m, 'a> Import<'m, 'a> {
    fn scope(&mut self) -> &mut Scope<'m> {
        self.scopes.last_mut().expect("no scope")
    }

    fn lookup(&self, v: &Value<'_>) -> Result<ValueId, Error> {
        let pack = self.scopes.iter().rev().find_map(|s| s.values.get(&*v.name)).ok_or_else(|| format!("use of undefined value %{}", v.name))?;
        pack.get(v.index.unwrap_or(0) as usize).copied().ok_or_else(|| format!("%{}#{} is out of range", v.name, v.index.unwrap_or(0)).into())
    }

    /// The op without its operands and regions, results named in the current scope.
    fn shell(&mut self, op: &'m Operation<'a>) -> Result<OpId, Error> {
        if op.raw.is_some() {
            return Err(format!("`{}`: custom form not understood (register its dialect, or print generic)", op.name).into());
        }
        let a = &self.aliases;
        let data = OpData {
            properties: op.properties.as_ref().map(|p| a.attr(p)),
            attributes: a.dict(&op.attributes),
            loc: a.loc(&op.loc),
            ..OpData::named(op.name.clone())
        };
        let types = a.tys(&op.ty.results);
        let id = self.body.create(data, &types);
        let mut results = self.body[id].results.clone().into_iter();
        for r in &op.results {
            let pack: Vec<_> = results.by_ref().take(r.count.unwrap_or(1) as usize).collect();
            self.scope().values.insert(&r.name, pack);
        }
        if results.next().is_some() || op.results.iter().map(|r| r.count.unwrap_or(1) as usize).sum::<usize>() != types.len() {
            return Err(format!("`{}`: {} result names for {} result types", op.name, op.results.len(), types.len()).into());
        }
        Ok(id)
    }

    /// `ops` into `block`; returns them, to be finished once the whole scope is known.
    fn place(&mut self, block: BlockId, ops: &'m [Operation<'a>], pending: &mut Vec<(OpId, &'m Operation<'a>)>) -> Result<(), Error> {
        for op in ops {
            let id = self.shell(op)?;
            self.body.insert(id, block, None);
            pending.push((id, op));
        }
        Ok(())
    }

    /// Operands, successors and regions of the ops of one scope.
    fn finish(&mut self, pending: Vec<(OpId, &'m Operation<'a>)>) -> Result<(), Error> {
        for (id, op) in pending {
            let operands = op.operands.iter().map(|v| self.lookup(v)).collect::<Result<Vec<_>, _>>()?;
            self.body.set_operands(id, operands);
            let labels = &self.scopes.last().expect("no scope").labels;
            self.body[id].successors = op.successors.iter().map(|s| labels.get(&**s).copied().ok_or_else(|| Error(format!("reference to an undefined block ^{s}")))).collect::<Result<_, _>>()?;
            for r in &op.regions {
                self.region(id, r)?;
            }
        }
        Ok(())
    }

    fn region(&mut self, op: OpId, r: &'m Region<'a>) -> Result<RegionId, Error> {
        let region = self.body.add_region(op);
        self.scopes.push(Scope::default());
        let mut pending = Vec::new();
        for b in &r.blocks {
            // `({ })` holds no block at all; mlirformat reads it as one empty, unlabeled block.
            if r.blocks.len() == 1 && b.label.is_none() && b.args.is_empty() && b.ops.is_empty() {
                break;
            }
            let args: Vec<_> = b.args.iter().map(|a| (self.aliases.ty(&a.ty), self.aliases.loc(&a.loc))).collect();
            let block = self.body.add_block(region, &args);
            if let Some(label) = &b.label {
                self.scope().labels.insert(label, block);
            }
            for (a, v) in b.args.iter().zip(self.body[block].args.clone()) {
                self.scope().values.insert(&a.name, alloc::vec![v]);
            }
            self.place(block, &b.ops, &mut pending)?;
        }
        self.finish(pending)?;
        self.scopes.pop();
        Ok(region)
    }
}

impl<'a> Body<'a> {
    /// The body of module `m` in context `ctx`: its one `builtin.module` becomes the root;
    /// loose top-level ops are wrapped in one, as `mlir-opt` does.
    pub fn import<'m>(ctx: &'a dyn mlirformat::OpRegistry, m: &'m Module<'a>) -> Result<Self, Error> {
        let mut aliases = Aliases::default();
        let mut items = Vec::new();
        for item in &m.items {
            match item {
                // Location aliases are spelled out where used (so the IR prints them inline).
                Item::AttrAlias { name, value: Attribute::Builtin { name: kw, body, .. } } if kw == "loc" => {
                    let inner = body.strip_prefix('(').and_then(|b| b.strip_suffix(')')).unwrap_or(body);
                    let resolved = aliases.loc(&Some(Cow::Owned(String::from(inner)))).map(String::from).unwrap_or_default();
                    aliases.locs.insert(String::from(&**name), resolved);
                    continue;
                }
                Item::AttrAlias { name, value } => {
                    let value = aliases.attr(value);
                    aliases.attrs.insert(String::from(&**name), value);
                }
                Item::TypeAlias { name, ty } => {
                    let ty = aliases.ty(ty);
                    aliases.types.insert(String::from(&**name), ty);
                }
                Item::Metadata { .. } => {}
                Item::Op(_) => continue,
            }
            items.push(item.clone());
        }
        let ops: Vec<&'m Operation<'a>> = m.items.iter().filter_map(|i| if let Item::Op(op) = i { Some(op) } else { None }).collect();
        let empty = Body { ctx: crate::Ctx(ctx), ops: Vec::new(), blocks: Vec::new(), regions: Vec::new(), values: Vec::new(), root: OpId(0), items };
        let mut im = Import { body: empty, aliases, scopes: alloc::vec![Scope::default()] };
        match ops.as_slice() {
            [module] if module.name == "builtin.module" => {
                let root = im.shell(module)?;
                im.body.root = root;
                im.finish(alloc::vec![(root, *module)])?;
            }
            _ => {
                let root = im.body.create(OpData::named("builtin.module"), &[]);
                im.body.root = root;
                let region = im.body.add_region(root);
                let block = im.body.add_block(region, &[]);
                let mut pending = Vec::new();
                for op in ops {
                    im.place(block, core::slice::from_ref(op), &mut pending)?;
                }
                im.finish(pending)?;
            }
        }
        Ok(im.body)
    }
}

/// Name counters of one scope.
#[derive(Clone, Copy, Default)]
struct Counters {
    value: u32,
    arg: u32,
}

/// The state of one export.
struct Export<'b, 'a> {
    body: &'b Body<'a>,
    names: BTreeMap<ValueId, Value<'static>>,
    labels: BTreeMap<BlockId, String>,
    next: Counters,
}

impl<'b, 'a> Export<'b, 'a> {
    /// Ops whose regions start numbering afresh.
    fn isolated(&self, op: OpId) -> bool {
        op == self.body.root || self.body.has(op, crate::Trait::IsIsolatedFromAbove)
    }

    fn name_op(&mut self, op: OpId) {
        let results = &self.body[op].results;
        if !results.is_empty() {
            let n = format!("{}", self.next.value);
            self.next.value += 1;
            let multi = results.len() > 1;
            for (i, r) in results.iter().enumerate() {
                self.names.insert(*r, Value { name: Cow::Owned(n.clone()), index: multi.then_some(i as u32) });
            }
        }
        // Whatever the regions number is forgotten on the way out; the results above are not.
        let after = self.next;
        if self.isolated(op) {
            self.next = Counters::default();
        }
        for r in &self.body[op].regions {
            let outer = self.next;
            for (i, b) in self.body[*r].blocks.iter().enumerate() {
                self.labels.insert(*b, format!("bb{i}"));
                for v in &self.body[*b].args {
                    let counter = if i == 0 { &mut self.next.arg } else { &mut self.next.value };
                    let name = if i == 0 { format!("arg{counter}") } else { format!("{counter}") };
                    *counter += 1;
                    self.names.insert(*v, Value { name: Cow::Owned(name), index: None });
                }
                for o in &self.body[*b].ops {
                    self.name_op(*o);
                }
            }
            self.next = outer;
        }
        self.next = after;
    }

    /// The name of `v`; a value outside the IR (a dangling use, which is a bug) prints as
    /// `%INVALIDn` so that it shows.
    fn value(&self, v: ValueId) -> Value<'a> {
        self.names.get(&v).cloned().unwrap_or_else(|| Value { name: Cow::Owned(format!("INVALID{}", v.0)), index: None })
    }

    fn op(&self, op: OpId) -> Operation<'a> {
        let mut placed = self.body[op].clone();
        self.body.place(&mut placed);
        let d = &placed;
        let results = match d.results.as_slice() {
            [] => Vec::new(),
            [r, rest @ ..] => alloc::vec![ResultDef { name: self.names[r].name.clone(), count: (!rest.is_empty()).then_some(d.results.len() as u32) }],
        };
        Operation {
            results,
            name: d.name.clone(),
            operands: d.operands.iter().map(|v| self.value(*v)).collect(),
            successors: d.successors.iter().map(|b| Cow::Owned(self.labels[b].clone())).collect(),
            properties: d.properties.clone(),
            regions: d.regions.iter().map(|r| self.region(*r)).collect(),
            attributes: d.attributes.clone(),
            ty: FunctionType { inputs: self.body.types(&d.operands), results: self.body.types(&d.results) },
            loc: d.loc.clone(),
            raw: None,
        }
    }

    fn region(&self, r: RegionId) -> Region<'a> {
        let blocks = self.body[r].blocks.iter().enumerate().map(|(i, b)| {
            let data = &self.body[*b];
            Block {
                // An entry block without arguments needs no label, unless it is empty too: the
                // region would read back as having no block at all.
                label: (i > 0 || !data.args.is_empty() || data.ops.is_empty()).then(|| Cow::Owned(self.labels[b].clone())),
                args: data.args.iter().map(|v| BlockArg { name: self.names[v].name.clone(), ty: self.body[*v].ty.clone(), loc: self.body[*v].loc.clone() }).collect(),
                ops: data.ops.iter().map(|o| self.op(*o)).collect(),
            }
        });
        Region { blocks: blocks.collect() }
    }
}

impl<'a> From<&Body<'a>> for Module<'a> {
    /// Aliases, the root, then `{-# ... #-}` metadata, as `mlir-opt` prints them.
    fn from(body: &Body<'a>) -> Self {
        let mut ex = Export { body, names: BTreeMap::new(), labels: BTreeMap::new(), next: Counters::default() };
        ex.name_op(body.root);
        let (meta, mut items): (Vec<_>, Vec<_>) = body.items.iter().cloned().partition(|i| matches!(i, Item::Metadata { .. }));
        items.push(Item::Op(ex.op(body.root)));
        items.extend(meta);
        Module { items }
    }
}

impl<'a> Body<'a> {
    /// The op at `id` as a free-standing mlirformat [`Operation`], named as in [`Module::from`].
    pub fn operation(&self, id: OpId) -> Operation<'a> {
        let mut ex = Export { body: self, names: BTreeMap::new(), labels: BTreeMap::new(), next: Counters::default() };
        ex.name_op(self.root);
        ex.op(id)
    }

    /// Text → body, with `opt`'s dialects for custom forms.
    pub fn parse(opt: &'a mlirformat::MlirOpt, src: &'a str) -> Result<Self, Error> {
        let m = opt.parse(src).map_err(|e| Error(format!("{e}")))?;
        Body::import(opt, &m)
    }
}
