//! ⭐ The mutable IR: one arena per [`Body`], everything else is an index into it.
//!
//! ```text
//! Body        the arena + its root op (always a `builtin.module`)
//! OpId        one operation: name, operands, results, successors, properties, regions, attributes
//! BlockId     arguments + ops in order, inside one region
//! RegionId    blocks in order, inside one op
//! ValueId     an op result or a block argument, with its type and every use
//! ```
//!
//! Types and attributes are mlirformat's own values; SSA names are not stored at all — they are
//! made up again on the way out ([`crate::io`]), as `mlir-opt` does.


use alloc::borrow::Cow;
use alloc::collections::BTreeMap;
use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;
use core::ops::{Index, IndexMut};

use mlirformat::{Attribute, Block, BlockArg, Error, Extended, FunctionType, Item, MlirOpt, Module, NamedAttr, Operation, Region, ResultDef, Shaped, Str, Type, Value};

/// Index newtypes into the arena, each with `Index` / `IndexMut` on [`Body`]; `IndexMut` saves the
/// entry's old value first while a [`Checkpoint`] is open (see [`Journal`]).
macro_rules! ids {
    ($($(#[$m:meta])* $id:ident => $data:ident $(<$lt:lifetime>)?, $field:ident, $kind:ident;)*) => {$(
        $(#[$m])*
        #[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord, Hash)]
        pub struct $id(pub u32);

        impl From<$id> for usize {
            fn from(id: $id) -> usize {
                id.0 as usize
            }
        }

        impl<'a> Index<$id> for Body<'a> {
            type Output = $data $(<$lt>)?;
            fn index(&self, id: $id) -> &Self::Output {
                &self.$field[usize::from(id)]
            }
        }

        impl<'a> IndexMut<$id> for Body<'a> {
            fn index_mut(&mut self, id: $id) -> &mut Self::Output {
                let i = usize::from(id);
                if self.journal.saves(Kind::$kind, i) {
                    self.journal.undo.push(Undo::Saved(Saved::$kind(i, self.$field[i].clone())));
                }
                &mut self.$field[i]
            }
        }
    )*};

    (@saved $($kind:ident => $data:ident $(<$lt:lifetime>)?, $field:ident;)*) => {
        /// Which arena an entry lives in.
        #[derive(Debug, Clone, Copy)]
        enum Kind {
            $($kind),*
        }

        /// An arena entry's value before the first write after a checkpoint.
        #[derive(Debug, Clone)]
        enum Saved<'a> {
            $($kind(usize, $data $(<$lt>)?)),*
        }

        impl<'a> Body<'a> {
            /// Puts a saved value back (rollback).
            fn restore(&mut self, saved: Saved<'a>) {
                match saved {
                    $(Saved::$kind(i, d) => self.$field[i] = d),*
                }
            }

            /// The arenas' lengths, in [`Kind`] order.
            fn lens(&self) -> [usize; 4] {
                [$(self.$field.len()),*]
            }

            /// Drops what was appended after `lens`.
            fn truncate(&mut self, lens: [usize; 4]) {
                let mut k = 0;
                $(self.$field.truncate(lens[k]); k += 1;)*
                let _ = k;
            }
        }
    };
}

ids! {
    OpId => OpData<'a>, ops, Op;
    BlockId => BlockData, blocks, Block;
    RegionId => RegionData, regions, Region;
    ValueId => ValueData<'a>, values, Value;
}

ids! {
    @saved
    Op => OpData<'a>, ops;
    Block => BlockData, blocks;
    Region => RegionData, regions;
    Value => ValueData<'a>, values;
}

/// One entry of the undo log.
#[derive(Debug, Clone)]
enum Undo<'a> {
    /// An arena entry's value before the first write after a checkpoint.
    Saved(Saved<'a>),
    /// An op went into block `block` at `at`.
    Inserted { block: usize, at: usize },
    /// `op` came out of block `block` at `at`.
    Removed { block: usize, at: usize, op: OpId },
    /// `len` ops moved from block `from` (at `at_from`) into block `to` (at `at_to`) in one go.
    Spliced { from: usize, at_from: usize, to: usize, at_to: usize, len: usize },
}

/// ⭐ Undo log for cheap rollback: while a [`Checkpoint`] is open, the first write to an entry
/// that existed when it was taken saves the entry's old value; entries appended since are just
/// truncated away. Rolling back costs what was touched, not the size of the body (a clone of
/// the whole body per pattern attempt made dialect conversion quadratic).
///
/// A block's op list is the exception: inserting, detaching and moving ops log just that edit
/// ([`Body::insert`], [`Body::detach`], [`Body::splice`]) — saving the whole list on the first
/// edit of every pattern attempt made a conversion over one long block quadratic in its length.
///
/// Checkpoints nest: each one is an epoch, and an entry is saved at most once per epoch.
#[derive(Debug, Clone, Default)]
pub struct Journal<'a> {
    undo: Vec<Undo<'a>>,
    /// Open checkpoints.
    depth: u32,
    epoch: u32,
    next_epoch: u32,
    /// The arenas' lengths when the innermost open checkpoint was taken.
    lens: [usize; 4],
    /// Per arena and entry, the epoch it was last saved in.
    saved: [Vec<u32>; 4],
}

/// A journal compares equal to any other: bodies compare by their IR.
impl PartialEq for Journal<'_> {
    fn eq(&self, _: &Self) -> bool {
        true
    }
}

impl Journal<'_> {
    /// Whether a write to entry `i` of `kind` must save its old value first (and marks it saved).
    fn saves(&mut self, kind: Kind, i: usize) -> bool {
        let k = kind as usize;
        if self.depth == 0 || i >= self.lens[k] {
            return false;
        }
        let saved = &mut self.saved[k];
        if saved.len() <= i {
            saved.resize(i + 1, u32::MAX);
        }
        let fresh = saved[i] != self.epoch;
        saved[i] = self.epoch;
        fresh
    }
}

/// ⭐ A point to roll a [`Body`] back to ([`Body::checkpoint`]); every one is closed exactly once,
/// by [`Body::rollback`] or [`Body::release`], innermost first.
#[derive(Debug)]
#[must_use = "a checkpoint is closed by rollback or release"]
pub struct Checkpoint {
    undo: usize,
    lens: [usize; 4],
    outer_epoch: u32,
    outer_lens: [usize; 4],
}

/// One operation. Operand and result types live on the values.
#[derive(Debug, Clone, PartialEq)]
pub struct OpData<'a> {
    pub name: Str<'a>,
    pub operands: Vec<ValueId>,
    pub results: Vec<ValueId>,
    pub successors: Vec<BlockId>,
    pub properties: Option<Attribute<'a>>,
    pub regions: Vec<RegionId>,
    pub attributes: Vec<NamedAttr<'a>>,
    /// Raw contents of `loc(...)`.
    pub loc: Option<Str<'a>>,
    /// `None` while detached (just created, or the root).
    pub parent: Option<BlockId>,
    /// Built by [`OpData::build`]: the defaults that depend on what the context knows of the
    /// op are added when it is created in a [`Body`].
    pub defaults: bool,
}

#[derive(Debug, Clone, PartialEq, Default)]
pub struct BlockData {
    pub args: Vec<ValueId>,
    pub ops: Vec<OpId>,
    pub parent: Option<RegionId>,
}

#[derive(Debug, Clone, PartialEq)]
pub struct RegionData {
    pub blocks: Vec<BlockId>,
    pub parent: OpId,
}

/// Where a value comes from.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Def {
    Result(OpId, u32),
    Arg(BlockId, u32),
}

/// One use: operand `index` of `op`.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct Use {
    pub op: OpId,
    pub index: u32,
}

#[derive(Debug, Clone, PartialEq)]
pub struct ValueData<'a> {
    pub ty: Type<'a>,
    pub def: Def,
    pub uses: Vec<Use>,
    /// A block argument's `loc(...)`.
    pub loc: Option<Str<'a>>,
}

/// The context a [`Body`] lives in (`MLIRContext`): what ODS says of ops, and the dialects'
/// [`OpInterfaces`](crate::OpInterfaces).
#[derive(Clone, Copy)]
pub struct Ctx<'a> {
    pub opt: &'a MlirOpt,
    pub interfaces: &'a crate::Interfaces<'a>,
}

impl<'a> Ctx<'a> {
    pub fn new(opt: &'a MlirOpt, interfaces: &'a crate::Interfaces<'a>) -> Self {
        Self { opt, interfaces }
    }
}

impl core::fmt::Debug for Ctx<'_> {
    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
        f.write_str("Ctx")
    }
}

/// Bodies compare by their IR, not their context.
impl PartialEq for Ctx<'_> {
    fn eq(&self, _: &Self) -> bool {
        true
    }
}

/// ⭐ The arena. Erased entities stay in it (ids are never reused), detached from everything.
#[derive(Debug, Clone, PartialEq)]
pub struct Body<'a> {
    /// What the context knows of ops (traits, effects, inherent attributes, dialects).
    pub ctx: Ctx<'a>,
    ops: Vec<OpData<'a>>,
    blocks: Vec<BlockData>,
    regions: Vec<RegionData>,
    values: Vec<ValueData<'a>>,
    /// The `builtin.module` everything hangs off.
    pub root: OpId,
    /// Module items that are not IR: `{-# ... #-}` bodies, and the aliases the input defined
    /// (already inlined everywhere; kept so that a `loc(#loc3)` still has its definition).
    pub items: Vec<mlirformat::Item<'a>>,
    journal: Journal<'a>,
}

impl<'a> Body<'a> {
    /// `DenseElementsAttr::getFromRawBuffer` of a `dense_resource<name>`'s blob (the
    /// `{-# dialect_resources #-}` hex, its 4-byte alignment header dropped): little-endian
    /// elements of whole bytes, or one splat element.
    pub fn resource_const(&self, attr: &Attribute<'a>) -> Option<crate::Const<'a>> {
        let Attribute::Builtin { name, body, ty: Some(ty) } = attr else { return None };
        if name != "dense_resource" {
            return None;
        }
        let key = body.trim_matches(['<', '>']);
        let hex = self.items.iter().find_map(|i| {
            let Item::Metadata { body } = i else { return None };
            let (_, rest) = body.split_once(&*format!("{key}:"))?;
            let (_, rest) = rest.split_once("\"0x")?;
            Some(String::from(rest.split('"').next()?.trim()))
        })?;
        let bytes: Vec<u8> = (0..hex.len() / 2).map(|i| u8::from_str_radix(&hex[2 * i..2 * i + 2], 16)).collect::<Result<_, _>>().ok()?;
        let data = bytes.get(4..)?;
        let elem = ty.element_type().clone();
        let width = elem.bit_width()?;
        if width % 8 != 0 {
            return None;
        }
        let size = (width / 8) as usize;
        let n = ty.element_count()?;
        if data.len() != n * size && data.len() != size {
            return None;
        }
        let scalar = |chunk: &[u8]| {
            let bits = chunk.iter().rev().fold(0u128, |acc, b| (acc << 8) | u128::from(*b));
            Some(match &elem {
                Type::Float(k) => mlirformat::Scalar::Float(mlirformat::ApFloat::from_bits(*k, bits as u64)?),
                _ => mlirformat::Scalar::Int(mlirformat::ApInt::from_bits(width, bits)),
            })
        };
        let values = data.chunks(size).map(scalar).collect::<Option<Vec<_>>>()?;
        Some(crate::Const { ty: ty.clone(), values, elements: true })
    }
}

impl Body<'_> {
    /// The single block of a symbol table op like `builtin.module`.
    pub fn top_block(&self, op: OpId) -> BlockId {
        self[self[op].regions[0]].blocks[0]
    }

    /// ⭐ Opens a checkpoint: until it is closed, [`Self::rollback`] can bring the IR back to
    /// this point (what `*body = snapshot` did, at the cost of what changed since).
    pub fn checkpoint(&mut self) -> Checkpoint {
        let j = &mut self.journal;
        let cp = Checkpoint { undo: j.undo.len(), lens: [0; 4], outer_epoch: j.epoch, outer_lens: j.lens };
        let lens = self.lens();
        let j = &mut self.journal;
        j.depth += 1;
        j.next_epoch += 1;
        j.epoch = j.next_epoch;
        j.lens = lens;
        Checkpoint { lens, ..cp }
    }

    /// ⭐ Brings the IR back to `cp` and closes it.
    pub fn rollback(&mut self, cp: Checkpoint) {
        while self.journal.undo.len() > cp.undo {
            match self.journal.undo.pop().expect("longer than the mark") {
                Undo::Saved(saved) => self.restore(saved),
                Undo::Inserted { block, at } => {
                    self.blocks[block].ops.remove(at);
                }
                Undo::Removed { block, at, op } => self.blocks[block].ops.insert(at, op),
                Undo::Spliced { from, at_from, to, at_to, len } => {
                    let moved: Vec<OpId> = self.blocks[to].ops.drain(at_to..at_to + len).collect();
                    self.blocks[from].ops.splice(at_from..at_from, moved);
                }
            }
        }
        self.truncate(cp.lens);
        self.close(&cp);
    }

    /// ⭐ Keeps what changed since `cp` and closes it (an outer checkpoint can still undo it).
    pub fn release(&mut self, cp: Checkpoint) {
        self.close(&cp);
    }

    fn close(&mut self, cp: &Checkpoint) {
        let j = &mut self.journal;
        j.depth -= 1;
        j.epoch = cp.outer_epoch;
        j.lens = cp.outer_lens;
        if j.depth == 0 {
            j.undo.clear();
        }
    }
}

/// A value as an operand of one of mlirformat's typed ops: named by its id.
impl From<ValueId> for Value<'_> {
    fn from(v: ValueId) -> Self {
        Value { name: Str::Owned(alloc::format!("{}", v.0)), index: None }
    }
}

/// ⭐ One of mlirformat's typed ops (`mlirformat::arith::Constant::new(..)`), built into a body.
pub trait TypedOp {
    /// The op detached, and its result types.
    fn split<'a>(&self) -> (OpData<'a>, Vec<Type<'a>>);
}

impl<O> TypedOp for O
where
    for<'o> Operation<'static>: TryFrom<&'o O, Error = Error>,
{
    fn split<'a>(&self) -> (OpData<'a>, Vec<Type<'a>>) {
        // A typed op always serializes; only regions and successors are refused.
        OpData::of(self).unwrap_or_else(|e| panic!("{e}"))
    }
}

impl<'a> OpData<'a> {
    /// ⭐ mlirformat's typed op `op` (operands are [`ValueId`]s turned [`Value`]s), detached,
    /// with its default-valued properties as [`OpData::build`] gives them; and its result types.
    pub fn of<O>(op: &O) -> Result<(Self, Vec<Type<'a>>), Error>
    where
        for<'o> Operation<'static>: TryFrom<&'o O, Error = Error>,
    {
        let g = Operation::try_from(op)?;
        if !g.regions.is_empty() || !g.successors.is_empty() {
            return Err(alloc::format!("`{}`: regions and successors are built in the body", g.name).into());
        }
        let mut data = OpData::build(&g.name);
        data.operands = g.operands.iter().map(|v| v.name.parse().map(ValueId).map_err(|_| Error::from(alloc::format!("`{}`: operand `%{}` is not a ValueId", g.name, v.name)))).collect::<Result<_, _>>()?;
        if let Some(Attribute::Dict(props)) = g.properties {
            props.into_iter().for_each(|a| data.set(&a.name, a.value.unwrap_or(Attribute::Unit)));
        }
        g.attributes.into_iter().for_each(|a| data.set(&a.name, a.value.unwrap_or(Attribute::Unit)));
        Ok((data, g.ty.results))
    }
}

impl<'a> OpData<'a> {
    /// A detached op with nothing but its name.
    pub fn named(name: impl Into<Str<'a>>) -> Self {
        Self { name: name.into(), operands: Vec::new(), results: Vec::new(), successors: Vec::new(), properties: None, regions: Vec::new(), attributes: Vec::new(), loc: None, parent: None, defaults: false }
    }

    fn dict(&self, inherent: bool) -> &[NamedAttr<'a>] {
        match (inherent, &self.properties) {
            (true, Some(Attribute::Dict(d))) => d,
            (true, _) => &[],
            (false, _) => &self.attributes,
        }
    }

    fn dict_mut(&mut self, inherent: bool) -> &mut Vec<NamedAttr<'a>> {
        if !inherent {
            return &mut self.attributes;
        }
        if !matches!(self.properties, Some(Attribute::Dict(_))) {
            self.properties = Some(Attribute::Dict(Vec::new()));
        }
        let Some(Attribute::Dict(d)) = &mut self.properties else { unreachable!() };
        d
    }

    /// Attribute `name`, inherent or discardable.
    /// The op's attributes, inherent and discardable, sorted (`getAttrs()`).
    pub fn all_attrs(&self) -> Vec<NamedAttr<'a>> {
        let mut out: Vec<NamedAttr<'a>> = match &self.properties {
            Some(Attribute::Dict(p)) => p.clone(),
            _ => Vec::new(),
        };
        out.extend(self.attributes.iter().cloned());
        out.sort_by(|a, b| a.name.cmp(&b.name));
        out
    }

    pub fn get(&self, name: &str) -> Option<&Attribute<'a>> {
        let find = |d: &[NamedAttr<'a>]| d.iter().position(|a| a.name == name);
        let d = if find(self.dict(true)).is_some() { self.dict(true) } else { self.dict(false) };
        let a = &d[find(d)?];
        Some(a.value.as_ref().unwrap_or(&Attribute::Unit))
    }

    /// Sets attribute `name`, keeping the dictionary sorted as MLIR's `DictionaryAttr` does.
    ///
    /// An attribute already there stays where it is; a new one joins the discardable ones until
    /// the op's [`Body`] places it by what its context knows ([`Body::place`]).
    pub fn set(&mut self, name: &str, value: Attribute<'a>) {
        let inherent = self.dict(true).iter().any(|a| a.name == name);
        let d = self.dict_mut(inherent);
        // A unit attribute is written bare: `{name}`.
        let value = (value != Attribute::Unit).then_some(value);
        let named = NamedAttr { name: alloc::string::String::from(name).into(), value };
        match d.binary_search_by(|a| (*a.name).cmp(name)) {
            Ok(i) => d[i] = named,
            Err(i) => d.insert(i, named),
        }
    }

    /// Removes attribute `name`; whether it was there.
    pub fn remove(&mut self, name: &str) -> bool {
        let mut gone = false;
        for inherent in [true, false] {
            let d = self.dict_mut(inherent);
            let before = d.len();
            d.retain(|a| a.name != name);
            gone |= d.len() != before;
        }
        if matches!(&self.properties, Some(Attribute::Dict(d)) if d.is_empty()) {
            self.properties = None;
        }
        gone
    }

    /// A string attribute's contents (still escaped).
    pub fn get_str(&self, name: &str) -> Option<&str> {
        match self.get(name)? {
            Attribute::Str { lit, .. } => Some(lit),
            _ => None,
        }
    }
}

impl<'a> Body<'a> {
    /// An empty `builtin.module` with one empty block.
    pub fn new(ctx: Ctx<'a>) -> Self {
        let mut body = Self { ctx, ops: Vec::new(), blocks: Vec::new(), regions: Vec::new(), values: Vec::new(), root: OpId(0), journal: Journal::default(), items: Vec::new() };
        body.root = body.create(OpData::named("builtin.module"), &[]);
        let region = body.add_region(body.root);
        body.add_block(region, &[]);
        body
    }

    // ---- creation ----------------------------------------------------------------------

    /// Adds a detached op with results of `types`; its operands' uses are recorded.
    pub fn create(&mut self, mut data: OpData<'a>, types: &[Type<'a>]) -> OpId {
        if data.defaults {
            for a in self.ctx.opt.defaults(&data.name) {
                if data.get(&a.name).is_none() {
                    data.set(&a.name, a.value.unwrap_or(Attribute::Unit));
                }
            }
            data.defaults = false;
        }
        self.place(&mut data);
        let id = OpId(self.ops.len() as u32);
        for (index, v) in data.operands.iter().enumerate() {
            self[*v].uses.push(Use { op: id, index: index as u32 });
        }
        self.ops.push(OpData { results: Vec::new(), ..data });
        let results = types.iter().enumerate().map(|(i, ty)| self.value(ty.clone(), Def::Result(id, i as u32), None)).collect();
        self[id].results = results;
        id
    }

    /// Adds mlirformat's typed op `op`, detached.
    pub fn emit(&mut self, op: &impl TypedOp) -> OpId {
        let (data, types) = op.split();
        self.create(data, &types)
    }

    /// Whether attribute `name` of an op `op_name` is inherent (declared by its ODS, so in the
    /// `<{...}>` properties); `None` when the context does not know the op.
    pub fn inherent(&self, op_name: &str, name: &str) -> Option<bool> {
        let info = self.ctx.opt.op_info(op_name)?;
        Some(info.inherent.contains(&name) || matches!(name, "operandSegmentSizes" | "resultSegmentSizes"))
    }

    /// Puts each attribute of `data` among its properties or its discardable attributes, as
    /// the context says; an op the context does not know keeps what it has.
    pub fn place(&self, data: &mut OpData<'a>) {
        // One lookup for the op, not one per attribute (`inherent`).
        let Some(info) = self.ctx.opt.op_info(&data.name) else { return };
        let mut all: Vec<NamedAttr<'a>> = match data.properties.take() {
            Some(Attribute::Dict(d)) => d,
            _ => Vec::new(),
        };
        all.append(&mut data.attributes);
        all.sort_by(|a, b| a.name.cmp(&b.name));
        let (props, attrs): (Vec<_>, Vec<_>) = all.into_iter().partition(|a| info.inherent.contains(&&*a.name) || matches!(&*a.name, "operandSegmentSizes" | "resultSegmentSizes"));
        data.properties = (!props.is_empty()).then_some(Attribute::Dict(props));
        data.attributes = attrs;
    }

    /// The discardable attributes of `op` (the `{...}` dictionary).
    pub fn discardable(&self, op: OpId) -> Vec<NamedAttr<'a>> {
        let mut d = self[op].clone();
        self.place(&mut d);
        d.attributes
    }

    fn value(&mut self, ty: Type<'a>, def: Def, loc: Option<Str<'a>>) -> ValueId {
        self.values.push(ValueData { ty, def, uses: Vec::new(), loc });
        ValueId(self.values.len() as u32 - 1)
    }

    /// Appends an empty region to `op`.
    pub fn add_region(&mut self, op: OpId) -> RegionId {
        self.regions.push(RegionData { blocks: Vec::new(), parent: op });
        let id = RegionId(self.regions.len() as u32 - 1);
        self[op].regions.push(id);
        id
    }

    /// Appends a block with arguments `args` (type, location) to `region`.
    pub fn add_block(&mut self, region: RegionId, args: &[(Type<'a>, Option<Str<'a>>)]) -> BlockId {
        let id = BlockId(self.blocks.len() as u32);
        self.blocks.push(BlockData { parent: Some(region), ..BlockData::default() });
        let args = args.iter().enumerate().map(|(i, (ty, loc))| self.value(ty.clone(), Def::Arg(id, i as u32), loc.clone())).collect();
        self[id].args = args;
        self[region].blocks.push(id);
        id
    }

    /// Adds a block argument at the end.
    pub fn add_arg(&mut self, block: BlockId, ty: Type<'a>) -> ValueId {
        let v = self.value(ty, Def::Arg(block, self[block].args.len() as u32), None);
        self[block].args.push(v);
        v
    }

    // ---- placement ---------------------------------------------------------------------

    /// Whether an edit of `block`'s op list goes into the undo log (a checkpoint is open and the
    /// block existed when it was taken; blocks made since are truncated away whole).
    fn logs(&self, block: BlockId) -> bool {
        self.journal.depth > 0 && usize::from(block) < self.journal.lens[Kind::Block as usize]
    }

    /// Inserts detached `op` into `block` at position `at` (`None`: the end).
    pub fn insert(&mut self, op: OpId, block: BlockId, at: Option<usize>) {
        debug_assert!(self[op].parent.is_none(), "op is already placed");
        let b = usize::from(block);
        let at = at.unwrap_or(self.blocks[b].ops.len());
        if self.logs(block) {
            self.journal.undo.push(Undo::Inserted { block: b, at });
        }
        self.blocks[b].ops.insert(at, op);
        self[op].parent = Some(block);
    }

    /// ⭐ Moves the ops at `range` of `from` into `to` before position `at` (`None`: the end), in one
    /// go and in order; the moved ops. `from` and `to` differ.
    pub fn splice(&mut self, from: BlockId, range: core::ops::Range<usize>, to: BlockId, at: Option<usize>) -> Vec<OpId> {
        debug_assert_ne!(from, to, "splice within one block");
        let (f, t) = (usize::from(from), usize::from(to));
        let at_from = range.start;
        let moved: Vec<OpId> = self.blocks[f].ops.drain(range).collect();
        let at = at.unwrap_or(self.blocks[t].ops.len());
        if self.logs(from) || self.logs(to) {
            self.journal.undo.push(Undo::Spliced { from: f, at_from, to: t, at_to: at, len: moved.len() });
        }
        self.blocks[t].ops.splice(at..at, moved.iter().copied());
        for &o in &moved {
            self[o].parent = Some(to);
        }
        moved
    }

    /// Takes `ops` out of their blocks, one pass over each block (they stay whole).
    pub fn detach_all(&mut self, ops: &[OpId]) {
        let mut by_block: alloc::collections::BTreeMap<BlockId, alloc::collections::BTreeSet<OpId>> = alloc::collections::BTreeMap::new();
        for &op in ops {
            if let Some(block) = self.ops[usize::from(op)].parent {
                by_block.entry(block).or_default().insert(op);
            }
        }
        for (block, gone) in by_block {
            if self.logs(block) {
                // Logged edit by edit, so that a rollback can put them back.
                gone.iter().for_each(|&op| self.detach(op));
                continue;
            }
            self.blocks[usize::from(block)].ops.retain(|o| !gone.contains(o));
            for op in gone {
                self[op].parent = None;
            }
        }
    }

    /// Inserts detached `op` right before `before`.
    pub fn insert_before(&mut self, op: OpId, before: OpId) {
        let block = self[before].parent.expect("anchor is not placed");
        let at = self.position(before);
        self.insert(op, block, Some(at));
    }

    /// Inserts detached `op` at insertion point `at`: before its op, else at the end.
    pub fn put(&mut self, op: OpId, at: crate::InsertPoint) {
        match at.before {
            Some(b) => self.insert_before(op, b),
            None => self.insert(op, at.block, None),
        }
    }

    /// Inserts detached `op` right after `after`.
    pub fn insert_after(&mut self, op: OpId, after: OpId) {
        let block = self[after].parent.expect("anchor is not placed");
        let at = self.position(after) + 1;
        self.insert(op, block, Some(at));
    }

    /// Where `op` sits in its block.
    pub fn position(&self, op: OpId) -> usize {
        let block = self[op].parent.expect("op is not placed");
        self[block].ops.iter().position(|o| *o == op).expect("op not in its block")
    }

    /// Takes `op` out of its block, keeping it whole. Looks from the end: erasing a block's ops
    /// last first costs nothing per op.
    pub fn detach(&mut self, op: OpId) {
        let Some(block) = self.ops[usize::from(op)].parent else { return };
        let b = usize::from(block);
        let at = self.blocks[b].ops.iter().rposition(|o| *o == op).expect("op not in its block");
        if self.logs(block) {
            self.journal.undo.push(Undo::Removed { block: b, at, op });
        }
        self.blocks[b].ops.remove(at);
        self[op].parent = None;
    }

    // ---- use-def -----------------------------------------------------------------------

    /// Points operand `index` of `op` at `v`.
    pub fn set_operand(&mut self, op: OpId, index: usize, v: ValueId) {
        let old = self[op].operands[index];
        let u = Use { op, index: index as u32 };
        self[old].uses.retain(|x| *x != u);
        self[op].operands[index] = v;
        self[v].uses.push(u);
    }

    /// Replaces every operand list of `op` at once.
    pub fn set_operands(&mut self, op: OpId, operands: Vec<ValueId>) {
        self.drop_uses(op);
        for (index, v) in operands.iter().enumerate() {
            self[*v].uses.push(Use { op, index: index as u32 });
        }
        self[op].operands = operands;
    }

    fn drop_uses(&mut self, op: OpId) {
        for (index, v) in self[op].operands.clone().into_iter().enumerate() {
            let u = Use { op, index: index as u32 };
            self[v].uses.retain(|x| *x != u);
        }
    }

    /// Every use of `from` now uses `to`.
    pub fn replace_all_uses(&mut self, from: ValueId, to: ValueId) {
        if from == to {
            return;
        }
        for u in core::mem::take(&mut self[from].uses) {
            self[u.op].operands[u.index as usize] = to;
            self[to].uses.push(u);
        }
    }

    /// Replaces `op`'s results by `with`, one for one, then erases `op`.
    pub fn replace_op(&mut self, op: OpId, with: &[ValueId]) {
        for (r, w) in self[op].results.clone().into_iter().zip(with) {
            self.replace_all_uses(r, *w);
        }
        self.erase(op);
    }

    /// Erases `op` and everything inside it; its results must be unused by then.
    pub fn erase(&mut self, op: OpId) {
        self.detach(op);
        for region in core::mem::take(&mut self[op].regions) {
            for block in core::mem::take(&mut self[region].blocks) {
                self.erase_block_ops(block);
            }
        }
        self.drop_uses(op);
        self[op].operands.clear();
    }

    fn erase_block_ops(&mut self, block: BlockId) {
        // Drop every use first: ops in a block may use each other (and forward, across blocks).
        let ops = core::mem::take(&mut self[block].ops);
        ops.iter().for_each(|o| self[*o].parent = None);
        ops.into_iter().for_each(|o| self.erase(o));
        self[block].parent = None;
    }

    // ---- queries -----------------------------------------------------------------------

    /// The op that owns `block`.
    pub fn block_owner(&self, block: BlockId) -> Option<OpId> {
        self[block].parent.map(|r| self[r].parent)
    }

    /// The op whose region holds `op`.
    pub fn parent_op(&self, op: OpId) -> Option<OpId> {
        self[op].parent.and_then(|b| self.block_owner(b))
    }

    /// The op defining `v`, if it is a result.
    pub fn def_op(&self, v: ValueId) -> Option<OpId> {
        match self[v].def {
            Def::Result(op, _) => Some(op),
            Def::Arg(..) => None,
        }
    }

    /// The types of `values`.
    pub fn types(&self, values: &[ValueId]) -> Vec<Type<'a>> {
        values.iter().map(|v| self[*v].ty.clone()).collect()
    }

    /// The root's single block.
    pub fn top(&self) -> BlockId {
        self[self[self.root].regions[0]].blocks[0]
    }

    /// `f` on `op` and every op nested in it, parents first (preorder).
    /// `Operation::walk` in post-order: nested ops before their parent.
    pub fn walk_post(&self, op: OpId, f: &mut impl FnMut(OpId)) {
        for r in &self[op].regions {
            for b in &self[*r].blocks {
                for o in &self[*b].ops {
                    self.walk_post(*o, f);
                }
            }
        }
        f(op);
    }

    pub fn walk(&self, op: OpId, f: &mut impl FnMut(OpId)) {
        f(op);
        for r in &self[op].regions {
            for b in &self[*r].blocks {
                for o in &self[*b].ops {
                    self.walk(*o, f);
                }
            }
        }
    }

    /// Every op nested in `op` (and `op` itself), preorder.
    pub fn ops_in(&self, op: OpId) -> Vec<OpId> {
        let mut out = Vec::new();
        self.walk(op, &mut |o| out.push(o));
        out
    }
}

// [`Module`] ⇄ [`Body`]: SSA names resolved on the way in, made up again on the way out.
//
// In: every region is one name scope (nested regions see outward, never inward); a scope's
// definitions and block labels are collected before any use is resolved, so forward references
// work. Attribute and type aliases (`#map`, `!t`) are inlined. A custom form mlirformat kept raw
// cannot be imported: the IR has to be generic, or in a registered dialect.
//
// Out: names follow `mlir-opt`'s custom form — `%N` and `%argN` counted in preorder, both
// restored on leaving a region, restarted at an op isolated from above; `^bbN` per region.

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
    pub fn import<'m>(ctx: crate::Ctx<'a>, m: &'m Module<'a>) -> Result<Self, Error> {
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
        let empty = Body { ctx, ops: Vec::new(), blocks: Vec::new(), regions: Vec::new(), values: Vec::new(), root: OpId(0), items, journal: crate::ir::Journal::default() };
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
        let used = body.used_resources();
        items.extend(meta.into_iter().filter_map(|m| match m {
            Item::Metadata { body: text } => Body::keep_resources(&text, &used).map(|t| Item::Metadata { body: t.into() }),
            m => Some(m),
        }));
        Module { items }
    }
}

impl Body<'_> {
    /// The `dense_resource<key>` keys the ops still reference.
    fn used_resources(&self) -> Vec<String> {
        fn scan(a: &Attribute<'_>, out: &mut Vec<String>) {
            match a {
                Attribute::Builtin { name, body, .. } if name == "dense_resource" => out.push(String::from(body.trim_matches(['<', '>']))),
                Attribute::Array(es) => es.iter().for_each(|e| scan(e, out)),
                Attribute::Dict(es) => es.iter().filter_map(|e| e.value.as_ref()).for_each(|e| scan(e, out)),
                _ => {}
            }
        }
        let mut out = Vec::new();
        self.walk(self.root, &mut |o| self[o].all_attrs().iter().filter_map(|a| a.value.as_ref()).for_each(|a| scan(a, &mut out)));
        out
    }

    /// A `{-# ... #-}` body without the `dialect_resources` blobs nothing references, as the
    /// printer only emits referenced ones; `None` once nothing is left.
    fn keep_resources(text: &str, used: &[String]) -> Option<String> {
        if !text.contains("dialect_resources") {
            return Some(String::from(text));
        }
        let blob = |l: &str| l.trim_start().split_once(": \"0x").map(|(k, _)| String::from(k.trim()));
        let kept: Vec<&str> = text.lines().filter(|l| blob(l).is_none_or(|k| used.contains(&k))).collect();
        let n = kept.iter().filter(|l| blob(l).is_some()).count();
        if n == 0 {
            return None;
        }
        // The last blob of a list loses its comma.
        let mut seen = 0;
        let lines: Vec<String> = kept.iter().map(|l| match blob(l) {
            Some(_) => {
                seen += 1;
                String::from(if seen == n { l.trim_end_matches(',') } else { l })
            }
            None => String::from(*l),
        }).collect();
        let mut out = lines.join("\n");
        if text.ends_with('\n') {
            out.push('\n');
        }
        Some(out)
    }
}

impl<'a> Body<'a> {
    /// The op at `id` as a free-standing mlirformat [`Operation`], named as in [`Module::from`].
    pub fn operation(&self, id: OpId) -> Operation<'a> {
        let mut ex = Export { body: self, names: BTreeMap::new(), labels: BTreeMap::new(), next: Counters::default() };
        ex.name_op(self.root);
        ex.op(id)
    }

    /// Text → body, with the context's dialects for custom forms.
    pub fn parse(ctx: crate::Ctx<'a>, src: &'a str) -> Result<Self, Error> {
        let m = ctx.opt.parse(src).map_err(|e| Error(format!("{e}")))?;
        Body::import(ctx, &m)
    }
}
