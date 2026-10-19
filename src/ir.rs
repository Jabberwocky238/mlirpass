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

use mlirformat::{Attribute, NamedAttr, Str, Type};

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

/// ⭐ The arena. Erased entities stay in it (ids are never reused), detached from everything.
#[derive(Debug, Clone, PartialEq)]
pub struct Body<'a> {
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

impl<'a> OpData<'a> {
    /// A detached op with nothing but its name.
    pub fn named(name: impl Into<Str<'a>>) -> Self {
        Self { name: name.into(), operands: Vec::new(), results: Vec::new(), successors: Vec::new(), properties: None, regions: Vec::new(), attributes: Vec::new(), loc: None, parent: None }
    }

    /// A property, from the `<{...}>` dictionary.
    pub fn prop(&self, name: &str) -> Option<&Attribute<'a>> {
        let Some(Attribute::Dict(d)) = &self.properties else { return None };
        d.iter().find(|a| a.name == name).and_then(|a| a.value.as_ref())
    }

    /// A discardable attribute.
    pub fn attr(&self, name: &str) -> Option<&Attribute<'a>> {
        self.attributes.iter().find(|a| a.name == name).and_then(|a| a.value.as_ref())
    }
}

impl<'a> Body<'a> {
    /// An empty `builtin.module` with one empty block.
    pub fn new() -> Self {
        let mut body = Self { ops: Vec::new(), blocks: Vec::new(), regions: Vec::new(), values: Vec::new(), root: OpId(0), items: Vec::new() };
        body.root = body.create(OpData::named("builtin.module"), &[]);
        let region = body.add_region(body.root);
        body.add_block(region, &[]);
        body
    }

    // ---- creation ----------------------------------------------------------------------

    /// Adds a detached op with results of `types`; its operands' uses are recorded.
    pub fn create(&mut self, data: OpData<'a>, types: &[Type<'a>]) -> OpId {
        let id = OpId(self.ops.len() as u32);
        for (index, v) in data.operands.iter().enumerate() {
            self[*v].uses.push(Use { op: id, index: index as u32 });
        }
        self.ops.push(OpData { results: Vec::new(), ..data });
        let results = types.iter().enumerate().map(|(i, ty)| self.value(ty.clone(), Def::Result(id, i as u32), None)).collect();
        self[id].results = results;
        id
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

impl Default for Body<'_> {
    fn default() -> Self {
        Self::new()
    }
}
