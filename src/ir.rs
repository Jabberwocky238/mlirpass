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

mod io;

use alloc::vec::Vec;
use core::ops::{Index, IndexMut};

use mlirformat::{Attribute, Error, NamedAttr, OpRegistry, Operation, Str, Type, Value};

/// Index newtypes into the arena, each with `Index` / `IndexMut` on [`Body`].
macro_rules! ids {
    ($($(#[$m:meta])* $id:ident => $data:ident $(<$lt:lifetime>)?, $field:ident;)*) => {$(
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
                &mut self.$field[usize::from(id)]
            }
        }
    )*};
}

ids! {
    OpId => OpData<'a>, ops;
    BlockId => BlockData, blocks;
    RegionId => RegionData, regions;
    ValueId => ValueData<'a>, values;
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

/// The context a [`Body`] lives in: what it knows of ops (`MLIRContext`).
#[derive(Clone, Copy)]
pub struct Ctx<'a>(pub &'a dyn OpRegistry);

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
    pub fn new(ctx: &'a dyn OpRegistry) -> Self {
        let mut body = Self { ctx: Ctx(ctx), ops: Vec::new(), blocks: Vec::new(), regions: Vec::new(), values: Vec::new(), root: OpId(0), items: Vec::new() };
        body.root = body.create(OpData::named("builtin.module"), &[]);
        let region = body.add_region(body.root);
        body.add_block(region, &[]);
        body
    }

    // ---- creation ----------------------------------------------------------------------

    /// Adds a detached op with results of `types`; its operands' uses are recorded.
    pub fn create(&mut self, mut data: OpData<'a>, types: &[Type<'a>]) -> OpId {
        if data.defaults {
            for a in self.ctx.0.defaults(&data.name) {
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
        let info = self.ctx.0.op_info(op_name)?;
        Some(info.inherent.contains(&name) || matches!(name, "operandSegmentSizes" | "resultSegmentSizes"))
    }

    /// Puts each attribute of `data` among its properties or its discardable attributes, as
    /// the context says; an op the context does not know keeps what it has.
    pub fn place(&self, data: &mut OpData<'a>) {
        if self.ctx.0.op_info(&data.name).is_none() {
            return;
        }
        let mut all: Vec<NamedAttr<'a>> = match data.properties.take() {
            Some(Attribute::Dict(d)) => d,
            _ => Vec::new(),
        };
        all.append(&mut data.attributes);
        all.sort_by(|a, b| a.name.cmp(&b.name));
        let (props, attrs): (Vec<_>, Vec<_>) = all.into_iter().partition(|a| self.inherent(&data.name, &a.name) == Some(true));
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

    /// Inserts detached `op` into `block` at position `at` (`None`: the end).
    pub fn insert(&mut self, op: OpId, block: BlockId, at: Option<usize>) {
        debug_assert!(self[op].parent.is_none(), "op is already placed");
        let at = at.unwrap_or(self[block].ops.len());
        self[block].ops.insert(at, op);
        self[op].parent = Some(block);
    }

    /// Inserts detached `op` right before `before`.
    pub fn insert_before(&mut self, op: OpId, before: OpId) {
        let block = self[before].parent.expect("anchor is not placed");
        let at = self.position(before);
        self.insert(op, block, Some(at));
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

    /// Takes `op` out of its block, keeping it whole.
    pub fn detach(&mut self, op: OpId) {
        if let Some(block) = self[op].parent.take() {
            self[block].ops.retain(|o| *o != op);
        }
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
