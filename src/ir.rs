//! ⭐ The mutable IR: arenas, one per function ([`Seg`]), everything else an index into them.
//!
//! ```text
//! Body        the arenas + its root op (always a `builtin.module`)
//! Seg         one arena of each kind: the module's own level (seg 0), or one function (an
//!             isolated op in the root's block) with everything in it; moved whole, never copied
//! ids         (seg, index): the seg in the high half
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

use mlirformat::{Attribute, Block, BlockArg, Error, Extended, FunctionType, IntoStatic, Item, MlirOpt, Module, NamedAttr, Operation, Reborrow, Region, ResultDef, Source, Str, Type, Value};

/// Where an entity lives: its seg ([`Seg`]) and its index in that seg's arena of its kind.
pub trait Id: Copy {
    fn seg(self) -> u32;
    fn index(self) -> u32;
}

/// Index newtypes into the arenas, each with `Index` / `IndexMut` on [`Body`]; `IndexMut` saves the
/// entry's old value first while a [`Checkpoint`] is open (see [`Journal`]).
macro_rules! ids {
    ($($(#[$m:meta])* $id:ident => $data:ident $(<$lt:lifetime>)?, $field:ident, $kind:ident;)*) => {$(
        $(#[$m])*
        /// Its seg in the high half, its index in the seg in the low half: ids order by seg, then
        /// by creation in the seg.
        #[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord, Hash)]
        pub struct $id(pub(crate) u64);

        impl $id {
            /// Entry `index` of seg `seg`.
            #[inline]
            pub(crate) const fn at(seg: u32, index: u32) -> Self {
                Self(((seg as u64) << 32) | index as u64)
            }
        }

        impl Id for $id {
            #[inline]
            fn seg(self) -> u32 {
                (self.0 >> 32) as u32
            }

            #[inline]
            fn index(self) -> u32 {
                self.0 as u32
            }
        }

        impl<'a> Index<$id> for Body<'a> {
            type Output = $data $(<$lt>)?;
            #[inline]
            fn index(&self, id: $id) -> &Self::Output {
                &self.seg(id.seg()).$field[id.index() as usize]
            }
        }

        impl<'a> IndexMut<$id> for Body<'a> {
            #[inline]
            fn index_mut(&mut self, id: $id) -> &mut Self::Output {
                let (s, i) = (id.seg(), id.index() as usize);
                if self.journal.depth > 0 && self.saves(Kind::$kind, s, i) {
                    let old = self.seg(s).$field[i].clone();
                    self.journal.undo.push(Undo::Saved(alloc::boxed::Box::new(Saved::$kind(id, old))));
                }
                &mut self.seg_mut(s).$field[i]
            }
        }
    )*};

    (@saved $($kind:ident => $id:ident, $data:ident $(<$lt:lifetime>)?, $field:ident;)*) => {
        /// Which arena an entry lives in.
        #[derive(Debug, Clone, Copy, PartialEq, Eq)]
        enum Kind {
            $($kind),*
        }

        /// An arena entry's value before the first write after a checkpoint.
        #[derive(Debug, Clone)]
        enum Saved<'a> {
            $($kind($id, $data $(<$lt>)?)),*
        }

        impl Saved<'_> {
            /// The arena, the seg and the entry.
            fn slot(&self) -> (Kind, u32, usize) {
                match self {
                    $(Saved::$kind(id, _) => (Kind::$kind, id.seg(), id.index() as usize)),*
                }
            }
        }

        impl Seg<'_> {
            /// How many entries its arena `kind` holds.
            fn len(&self, kind: Kind) -> usize {
                match kind {
                    $(Kind::$kind => self.$field.len()),*
                }
            }

            /// Drops the entries of arena `kind` from `len` on.
            fn truncate(&mut self, kind: Kind, len: usize) {
                match kind {
                    $(Kind::$kind => self.$field.truncate(len)),*
                }
            }
        }

        impl<'a> Body<'a> {
            /// Puts a saved value back (rollback).
            fn restore(&mut self, saved: Saved<'a>) {
                match saved {
                    $(Saved::$kind(id, d) => self.seg_mut(id.seg()).$field[id.index() as usize] = d),*
                }
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

/// Where the segs of an absorbed body went ([`Body::absorb`]): seg `from` and those after it
/// are now seg `to` and those after it.
#[derive(Debug, Clone, Copy)]
pub struct Offsets {
    pub from: u32,
    pub to: u32,
}

/// An arena entry (or an id in one) with every id it holds moved by [`Offsets`].
pub trait Shift {
    fn shift(self, o: &Offsets) -> Self;
}

macro_rules! shift_ids {
    ($($id:ident),*) => {$(
        impl Shift for $id {
            #[inline]
            fn shift(self, o: &Offsets) -> Self {
                $id::at(self.seg() - o.from + o.to, self.index())
            }
        }
    )*};
}

shift_ids!(OpId, BlockId, RegionId, ValueId);

impl<T: Shift> Shift for Vec<T> {
    fn shift(self, o: &Offsets) -> Self {
        self.into_iter().map(|x| x.shift(o)).collect()
    }
}

impl<T: Shift, const N: usize> Shift for smallvec::SmallVec<[T; N]> {
    fn shift(self, o: &Offsets) -> Self {
        self.into_iter().map(|x| x.shift(o)).collect()
    }
}

impl<T: Shift> Shift for Option<T> {
    fn shift(self, o: &Offsets) -> Self {
        self.map(|x| x.shift(o))
    }
}

/// A struct whose id fields shift (the rest is kept).
macro_rules! shift_fields {
    ($($t:ident $(<$lt:lifetime>)? { $($f:ident),* })*) => {$(
        impl $(<$lt>)? Shift for $t $(<$lt>)? {
            fn shift(self, o: &Offsets) -> Self {
                Self { $($f: self.$f.shift(o),)* ..self }
            }
        }
    )*};
}

shift_fields! {
    OpData<'a> { operands, results, successors, regions, parent }
    BlockData { args, ops, parent }
    RegionData { blocks, parent }
    ValueData<'a> { def, uses }
    Use { op }
}

impl Shift for Def {
    fn shift(self, o: &Offsets) -> Self {
        match self {
            Def::Result(op, i) => Def::Result(op.shift(o), i),
            Def::Arg(b, i) => Def::Arg(b.shift(o), i),
        }
    }
}

/// A seg moved whole: its entries shifted, its journal state left behind.
impl<'a> Shift for Seg<'a> {
    fn shift(self, o: &Offsets) -> Self {
        Seg { ops: self.ops.shift(o), blocks: self.blocks.shift(o), regions: self.regions.shift(o), values: self.values.shift(o), mixed: self.mixed, ..Seg::default() }
    }
}

ids! {
    @saved
    Op => OpId, OpData<'a>, ops;
    Block => BlockId, BlockData, blocks;
    Region => RegionId, RegionData, regions;
    Value => ValueId, ValueData<'a>, values;
}

/// ⭐ A table by id, one `Vec` per seg, each as long as the highest index written in it: what a
/// `Vec` indexed by id was while there was one arena.
#[derive(Debug, Clone)]
pub struct IdVec<K, T> {
    /// The seg `segs[0]` is.
    base: u32,
    segs: Vec<Vec<T>>,
    /// What an entry never written reads as.
    fill: T,
    _k: core::marker::PhantomData<K>,
}

impl<K: Id, T: Clone + Default> Default for IdVec<K, T> {
    fn default() -> Self {
        Self::new(T::default())
    }
}

impl<K: Id, T: Clone> IdVec<K, T> {
    /// Every entry `fill`.
    pub fn new(fill: T) -> Self {
        Self { base: 0, segs: Vec::new(), fill, _k: core::marker::PhantomData }
    }

    #[inline]
    pub fn get(&self, k: K) -> &T {
        self.segs.get(k.seg().wrapping_sub(self.base) as usize).and_then(|s| s.get(k.index() as usize)).unwrap_or(&self.fill)
    }

    /// Entry `k`, the table grown to hold it.
    pub fn get_mut(&mut self, k: K) -> &mut T {
        let seg = k.seg();
        if self.segs.is_empty() {
            self.base = seg;
        } else if seg < self.base {
            self.segs.splice(0..0, (seg..self.base).map(|_| Vec::new()));
            self.base = seg;
        }
        let s = (seg - self.base) as usize;
        if self.segs.len() <= s {
            self.segs.resize_with(s + 1, Vec::new);
        }
        let (row, i) = (&mut self.segs[s], k.index() as usize);
        if row.len() <= i {
            row.resize(i + 1, self.fill.clone());
        }
        &mut row[i]
    }

    #[inline]
    pub fn set(&mut self, k: K, v: T) {
        *self.get_mut(k) = v;
    }
}

/// One entry of the undo log.
#[derive(Debug, Clone)]
enum Undo<'a> {
    /// An arena entry's value before the first write after a checkpoint (boxed: an op is
    /// hundreds of bytes, the other entries a few words).
    Saved(alloc::boxed::Box<Saved<'a>>),
    /// An op went into block `block` at `at`.
    Inserted { block: BlockId, at: usize },
    /// `op` came out of block `block` at `at`.
    Removed { block: BlockId, at: usize, op: OpId },
    /// `len` ops moved from block `from` (at `at_from`) into block `to` (at `at_to`) in one go.
    Spliced { from: BlockId, at_from: usize, to: BlockId, at_to: usize, len: usize },
    /// Arena `kind` of seg `seg` held `len` entries when it first grew under a checkpoint: what a
    /// rollback truncates it back to.
    Grew { seg: u32, kind: Kind, len: usize },
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
/// Checkpoints nest: each one is an epoch, and an entry is saved at most once per epoch. A
/// checkpoint released into the outermost one leaves only the saves the outermost one lacks
/// ([`Body::compact`]): a conversion's whole-run checkpoint holds one save per entry touched.
///
/// Each seg keeps what concerns its own entries ([`Seg`]): when each was made (a checkpoint's
/// mark tells the entries that existed when it was taken), the epochs each was saved in, and
/// under which mark each arena last grew (one [`Undo::Grew`] per arena and checkpoint).
#[derive(Debug, Clone, Default)]
pub struct Journal<'a> {
    undo: Vec<Undo<'a>>,
    /// Open checkpoints.
    depth: u32,
    epoch: u32,
    next_epoch: u32,
    /// The outermost open checkpoint's epoch.
    outer_epoch: u32,
    /// Ticks once per checkpoint taken.
    clock: u32,
    /// The clock when the innermost open checkpoint was taken: an entry made before it existed.
    mark: u32,
    /// The outermost open checkpoint's mark.
    outer_mark: u32,
}

/// A journal compares equal to any other: bodies compare by their IR.
impl PartialEq for Journal<'_> {
    fn eq(&self, _: &Self) -> bool {
        true
    }
}

/// ⭐ A point to roll a [`Body`] back to ([`Body::checkpoint`]); every one is closed exactly once,
/// by [`Body::rollback`] or [`Body::release`], innermost first.
#[derive(Debug)]
#[must_use = "a checkpoint is closed by rollback or release"]
pub struct Checkpoint {
    undo: usize,
    /// The enclosing checkpoint's epoch and mark, restored when this one closes.
    prev_epoch: u32,
    prev_mark: u32,
}

/// ⭐ One arena of each kind: the module's own level (seg 0), or one isolated op that is a child
/// of the root (a function) and everything in it, the op itself its entry 0. A seg moves whole
/// ([`Body::lend`]): an op's body changes hands without a copy, and ids stay what they are.
#[derive(Debug, Clone, Default)]
pub(crate) struct Seg<'a> {
    ops: Vec<OpData<'a>>,
    blocks: Vec<BlockData>,
    regions: Vec<RegionData>,
    values: Vec<ValueData<'a>>,
    /// An entity of another seg was linked in (other than its entry 0 into its parent's block):
    /// the seg no longer holds its op alone, and is not lent.
    mixed: bool,
    /// Per arena, the mark an entry was made under while a checkpoint was open (an entry past
    /// the end was made outside any).
    born: [Vec<u32>; 4],
    /// Per arena and entry, the epoch it was last saved in.
    saved: [Vec<u32>; 4],
    /// Per arena and entry, the outermost epoch it was saved in: what an inner checkpoint's
    /// saves are checked against when it is released into the outermost one.
    outer: [Vec<u32>; 4],
    /// Per arena, the mark its growth was last logged under ([`Undo::Grew`]).
    grown: [u32; 4],
}

/// Segs compare by their IR.
impl PartialEq for Seg<'_> {
    fn eq(&self, o: &Self) -> bool {
        self.ops == o.ops && self.blocks == o.blocks && self.regions == o.regions && self.values == o.values
    }
}

/// The ids an op or a block holds (operands, results, successors, regions, arguments, blocks):
/// up to four inline, as big as a `Vec` and no allocation for the usual handful.
pub type Ids<T> = smallvec::SmallVec<[T; 4]>;

/// A value's uses: two inline.
pub type Uses = smallvec::SmallVec<[Use; 2]>;

/// One operation. Operand and result types live on the values.
#[derive(Debug, Clone, PartialEq)]
pub struct OpData<'a> {
    pub name: Str<'a>,
    pub operands: Ids<ValueId>,
    pub results: Ids<ValueId>,
    pub successors: Ids<BlockId>,
    /// The inherent attributes (`<{...}>`), sorted; empty: none.
    pub properties: Vec<NamedAttr<'a>>,
    pub regions: Ids<RegionId>,
    pub attributes: Vec<NamedAttr<'a>>,
    /// Raw contents of `loc(...)`.
    pub loc: Option<Str<'a>>,
    /// `None` while detached (just created, or the root).
    pub parent: Option<BlockId>,
    /// Built by [`OpData::build`]: the defaults that depend on what the context knows of the
    /// op are added when it is created in a [`Body`].
    pub defaults: bool,
    /// What the context knows of the op ([`MlirOpt::op_info`] of `name`): looked up once, when
    /// the op enters a [`Body`], not on every trait query.
    pub info: Option<&'a mlirformat::OpInfo>,
}

#[derive(Debug, Clone, PartialEq, Default)]
pub struct BlockData {
    pub args: Ids<ValueId>,
    pub ops: Vec<OpId>,
    pub parent: Option<RegionId>,
}

#[derive(Debug, Clone, PartialEq)]
pub struct RegionData {
    pub blocks: Ids<BlockId>,
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
    pub uses: Uses,
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

/// ⭐ The arenas, one [`Seg`] per function. Erased entities stay in them (ids are never reused),
/// detached from everything.
#[derive(Debug, Clone, PartialEq)]
pub struct Body<'a> {
    /// What the context knows of ops (traits, effects, inherent attributes, dialects).
    pub ctx: Ctx<'a>,
    /// Seg `seg0 + i` is `segs[i]`: a body lent one function holds just its segs ([`Body::lend`]).
    segs: Vec<Seg<'a>>,
    seg0: u32,
    /// The seg new ops are made in ([`Body::create`]); blocks, regions and values go to the seg
    /// of what holds them.
    pub(crate) home: u32,
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

impl<'a> Body<'a> {
    /// The single block of a symbol table op like `builtin.module`.
    pub fn top_block(&self, op: OpId) -> BlockId {
        self[self[op].regions[0]].blocks[0]
    }

    /// ⭐ Opens a checkpoint: until it is closed, [`Self::rollback`] can bring the IR back to
    /// this point (what `*body = snapshot` did, at the cost of what changed since).
    pub fn checkpoint(&mut self) -> Checkpoint {
        let j = &mut self.journal;
        let cp = Checkpoint { undo: j.undo.len(), prev_epoch: j.epoch, prev_mark: j.mark };
        j.depth += 1;
        j.next_epoch += 1;
        j.epoch = j.next_epoch;
        j.clock += 1;
        j.mark = j.clock;
        if j.depth == 1 {
            j.outer_epoch = j.epoch;
            j.outer_mark = j.mark;
        }
        cp
    }

    /// ⭐ Brings the IR back to `cp` and closes it.
    pub fn rollback(&mut self, cp: Checkpoint) {
        while self.journal.undo.len() > cp.undo {
            match self.journal.undo.pop().expect("longer than the mark") {
                Undo::Saved(saved) => self.restore(*saved),
                Undo::Inserted { block, at } => {
                    self.ops_of(block).remove(at);
                }
                Undo::Removed { block, at, op } => self.ops_of(block).insert(at, op),
                Undo::Spliced { from, at_from, to, at_to, len } => {
                    let moved: Vec<OpId> = self.ops_of(to).drain(at_to..at_to + len).collect();
                    self.ops_of(from).splice(at_from..at_from, moved);
                }
                Undo::Grew { seg, kind, len } => self.seg_mut(seg).truncate(kind, len),
            }
        }
        self.close(&cp);
    }

    /// ⭐ Keeps what changed since `cp` and closes it (an outer checkpoint can still undo it).
    pub fn release(&mut self, cp: Checkpoint) {
        self.close(&cp);
    }

    fn close(&mut self, cp: &Checkpoint) {
        let j = &mut self.journal;
        j.depth -= 1;
        j.epoch = cp.prev_epoch;
        j.mark = cp.prev_mark;
        match j.depth {
            0 => j.undo.clear(),
            1 => self.compact(cp.undo),
            _ => {}
        }
    }

    /// Whether entry `i` of seg `s`'s arena `kind` existed when the checkpoint at `mark` was taken.
    fn existed(&self, kind: Kind, s: u32, i: usize, mark: u32) -> bool {
        self.seg(s).born[kind as usize].get(i).is_none_or(|b| *b < mark)
    }

    /// Whether a write to entry `i` of seg `s`'s `kind` must save its old value first (and marks
    /// it saved).
    fn saves(&mut self, kind: Kind, s: u32, i: usize) -> bool {
        let j = &self.journal;
        if j.depth == 0 || !self.existed(kind, s, i, j.mark) {
            return false;
        }
        let (outer, epoch) = (j.depth == 1, if j.depth == 1 { j.outer_epoch } else { j.epoch });
        let seg = self.seg_mut(s);
        let saved = if outer { &mut seg.outer[kind as usize] } else { &mut seg.saved[kind as usize] };
        if saved.len() <= i {
            saved.resize(i + 1, u32::MAX);
        }
        let fresh = saved[i] != epoch;
        saved[i] = epoch;
        fresh
    }

    /// An inner checkpoint taken at `from` in the log was released into the outermost one: of
    /// its saves, those of entries the outermost one saved already, or that did not exist when
    /// it was taken (its rollback truncates them), go. Every entry then has one save, however
    /// many attempts touched it. A block's save stays: its op list is also undone edit by
    /// edit, and those edits need every list they were made on.
    fn compact(&mut self, from: usize) {
        let (mark, epoch) = (self.journal.outer_mark, self.journal.outer_epoch);
        let mut undo = core::mem::take(&mut self.journal.undo);
        let mut kept = from;
        for r in from..undo.len() {
            let keep = match &undo[r] {
                Undo::Saved(saved) => match saved.slot() {
                    (Kind::Block, ..) => true,
                    (kind, s, i) => {
                        let existed = self.existed(kind, s, i, mark);
                        let outer = &mut self.seg_mut(s).outer[kind as usize];
                        if outer.len() <= i {
                            outer.resize(i + 1, u32::MAX);
                        }
                        let fresh = existed && outer[i] != epoch;
                        if fresh {
                            outer[i] = epoch;
                        }
                        fresh
                    }
                },
                _ => true,
            };
            if keep {
                undo.swap(kept, r);
                kept += 1;
            }
        }
        undo.truncate(kept);
        self.journal.undo = undo;
    }

    /// The next index of seg `s`'s arena `kind`, about to be appended: under a checkpoint, the
    /// entry is stamped with its mark and the arena's growth logged once per checkpoint.
    fn grow(&mut self, kind: Kind, s: u32) -> u32 {
        let (depth, mark) = (self.journal.depth, self.journal.mark);
        let seg = self.seg_mut(s);
        let len = seg.len(kind);
        if depth > 0 {
            let k = kind as usize;
            let born = &mut seg.born[k];
            if born.len() <= len {
                born.resize(len + 1, 0);
            }
            born[len] = mark;
            if seg.grown[k] != mark {
                seg.grown[k] = mark;
                self.journal.undo.push(Undo::Grew { seg: s, kind, len });
            }
        }
        len as u32
    }

    #[inline]
    fn seg(&self, s: u32) -> &Seg<'a> {
        &self.segs[s.wrapping_sub(self.seg0) as usize]
    }

    #[inline]
    fn seg_mut(&mut self, s: u32) -> &mut Seg<'a> {
        let i = s.wrapping_sub(self.seg0) as usize;
        &mut self.segs[i]
    }

    /// `block`'s op list, written without the journal (what logs it does so itself).
    #[inline]
    fn ops_of(&mut self, block: BlockId) -> &mut Vec<OpId> {
        &mut self.seg_mut(block.seg()).blocks[block.index() as usize].ops
    }

    /// Notes that segs `a` and `b` now refer to each other: neither holds its op alone.
    fn link(&mut self, a: u32, b: u32) {
        if a != b {
            for s in [a, b] {
                if let Some(seg) = self.segs.get_mut(s.wrapping_sub(self.seg0) as usize) {
                    seg.mixed = true;
                }
            }
        }
    }

    /// A new seg, `seg`; its number.
    pub(crate) fn new_seg(&mut self, seg: Seg<'a>) -> u32 {
        self.segs.push(seg);
        self.seg0 + self.segs.len() as u32 - 1
    }

    /// ⭐ Whether `op`'s seg can be lent out alone ([`Body::lend`]): `op` is its seg's own op (a
    /// function), nothing of another seg was linked into the seg, and `op` neither uses a value
    /// from outside nor has a result used there.
    pub fn lendable(&self, op: OpId) -> bool {
        op.index() == 0
            && op.seg() != self.root.seg()
            && self.segs.get(op.seg().wrapping_sub(self.seg0) as usize).is_some_and(|s| !s.mixed && !s.ops.is_empty())
            && self[op].operands.is_empty()
            && self[op].results.iter().all(|r| self[*r].uses.is_empty())
    }

    /// ⭐ `op`'s seg moved into a body of its own ([`Body::lendable`]), under a module carrying the
    /// discardable attributes of `op`'s ancestors (the nearest wins: what `DataLayout::closest`
    /// reads), and the block `op` was in. Nothing is copied: the seg itself moves, ids and all,
    /// and [`Body::unlend`] moves it back. The module is in a seg of its own, numbered just below
    /// `op`'s: the lent body holds no other seg, so the number is free there.
    pub fn lend(&mut self, op: OpId) -> Option<(Body<'a>, Option<BlockId>)> {
        if !self.lendable(op) {
            return None;
        }
        let mut ancestors = Vec::new();
        let mut at = self.parent_op(op);
        while let Some(a) = at {
            ancestors.push(a);
            at = self.parent_op(a);
        }
        let attrs: Vec<NamedAttr<'a>> = ancestors.into_iter().rev().flat_map(|a| self[a].attributes.iter().cloned()).collect();
        let (s, parent) = (op.seg(), self[op].parent);
        let seg = self.take_seg(s);
        let mut sub = Body { ctx: self.ctx, segs: alloc::vec![Seg::default(), seg], seg0: s - 1, home: s - 1, root: OpId::at(s - 1, 0), items: Vec::new(), journal: Journal::default() };
        let root = sub.create(OpData::named("builtin.module"), &[]);
        sub.root = root;
        for n in attrs {
            sub[root].set(&n.name, n.value.unwrap_or(Attribute::Unit));
        }
        let region = sub.add_region(root);
        let block = sub.add_block(region, &[]);
        sub.ops_of(block).push(op);
        sub[op].parent = Some(block);
        sub.home = s;
        Some((sub, parent))
    }

    /// `op`'s seg back from the body [`Body::lend`] gave it to, `op` back in `parent`.
    pub fn unlend(&mut self, op: OpId, mut sub: Body<'a>, parent: Option<BlockId>) {
        debug_assert_eq!(sub.segs.len(), 2, "a lent body makes no seg");
        let seg = sub.segs.pop().expect("the lent seg");
        self.put_seg(op.seg(), seg);
        self[op].parent = parent;
    }

    /// Seg `s` taken out, an empty one left in its place.
    fn take_seg(&mut self, s: u32) -> Seg<'a> {
        core::mem::take(self.seg_mut(s))
    }

    /// Seg `s` put back.
    fn put_seg(&mut self, s: u32, seg: Seg<'a>) {
        *self.seg_mut(s) = seg;
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
    pub fn successors(mut self, s: &[BlockId]) -> Self {
        self.successors = s.to_vec().into();
        self
    }

    /// `operandSegmentSizes` for operand groups of `sizes`.
    pub fn segments(self, sizes: &[usize]) -> Self {
        self.with("operandSegmentSizes", Attribute::dense_i32(sizes))
    }
}

impl Body<'_> {
    pub fn is_ranked_memref(&self, v: ValueId) -> bool {
        matches!(&self[v].ty, Type::Shaped(s) if s.kind == mlirformat::ShapedKind::MemRef && s.shape.is_some())
    }

    /// `memref::foldMemRefCast(op, inner)`: casts from ranked memrefs fold into `op`.
    pub fn fold_memref_cast(&mut self, op: OpId, inner: Option<ValueId>) -> bool {
        let mut folded = false;
        for i in 0..self[op].operands.len() {
            let v = self[op].operands[i];
            let Some(c) = self.def_named(v, "memref.cast") else { continue };
            let src = self[c].operands[0];
            if Some(v) != inner && self.is_ranked_memref(src) {
                self.set_operand(op, i, src);
                folded = true;
            }
        }
        folded
    }

    /// `getConstantIntValue` of an index or integer.
    pub fn const_index(&self, v: ValueId) -> Option<i64> {
        let c = crate::Const::try_from(&self.constant_of(v)?).ok().filter(|c| !c.elements)?;
        Some(c.as_int()?.signed() as i64)
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
        Self { name: name.into(), operands: crate::Ids::new(), results: crate::Ids::new(), successors: crate::Ids::new(), properties: Vec::new(), regions: crate::Ids::new(), attributes: Vec::new(), loc: None, parent: None, defaults: false, info: None }
    }

    fn dict(&self, inherent: bool) -> &[NamedAttr<'a>] {
        if inherent { &self.properties } else { &self.attributes }
    }

    fn dict_mut(&mut self, inherent: bool) -> &mut Vec<NamedAttr<'a>> {
        if inherent { &mut self.properties } else { &mut self.attributes }
    }

    /// Attribute `name`, inherent or discardable.
    /// The op's attributes, inherent and discardable, sorted (`getAttrs()`).
    pub fn all_attrs(&self) -> Vec<NamedAttr<'a>> {
        let mut out = self.properties.clone();
        out.extend(self.attributes.iter().cloned());
        out.sort_by(|a, b| a.name.cmp(&b.name));
        out
    }

    pub fn get<'s>(&'s self, name: &str) -> Option<&'s Attribute<'a>> {
        let find = |d: &'s [NamedAttr<'a>]| d.iter().find(|a| a.name == name);
        let a = find(self.dict(true)).or_else(|| find(self.dict(false)))?;
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
        let mut body = Self { ctx, segs: alloc::vec![Seg::default()], seg0: 0, home: 0, root: OpId::at(0, 0), journal: Journal::default(), items: Vec::new() };
        body.root = body.create(OpData::named("builtin.module"), &[]);
        let region = body.add_region(body.root);
        body.add_block(region, &[]);
        body
    }

    // ---- creation ----------------------------------------------------------------------

    /// Adds a detached op with results of `types`; its operands' uses are recorded.
    pub fn create(&mut self, data: OpData<'a>, types: &[Type<'a>]) -> OpId {
        self.adopt(data, types.iter().cloned())
    }

    /// [`Body::create`] with result types it takes over rather than copies.
    pub fn adopt(&mut self, mut data: OpData<'a>, types: impl IntoIterator<Item = Type<'a>>) -> OpId {
        if data.defaults {
            for a in self.ctx.opt.defaults(&data.name) {
                if data.get(&a.name).is_none() {
                    data.set(&a.name, a.value.unwrap_or(Attribute::Unit));
                }
            }
            data.defaults = false;
        }
        // Looked up once: placing and pushing both read it
        data.info = self.ctx.opt.op_info(&data.name);
        self.place(&mut data);
        self.push_known(data, types)
    }

    /// [`create`](Self::create) for an op already placed (a copy of one in a body): no
    /// defaults to add, no attributes to sort.
    pub fn push_op(&mut self, mut data: OpData<'a>, types: &[Type<'a>]) -> OpId {
        data.info = self.ctx.opt.op_info(&data.name);
        self.push_known(data, types.iter().cloned())
    }

    /// [`push_op`](Self::push_op) with `data.info` already this context's.
    fn push_known(&mut self, data: OpData<'a>, types: impl IntoIterator<Item = Type<'a>>) -> OpId {
        let s = self.home;
        let id = OpId::at(s, self.grow(Kind::Op, s));
        for (index, v) in data.operands.iter().enumerate() {
            self.link(s, v.seg());
            self[*v].uses.push(Use { op: id, index: index as u32 });
        }
        self.seg_mut(s).ops.push(OpData { results: crate::Ids::new(), ..data });
        let results = types.into_iter().enumerate().map(|(i, ty)| self.value(ty, Def::Result(id, i as u32), None)).collect();
        self[id].results = results;
        id
    }

    /// ⭐ Moves the segs of `from` into this body, after its own, ids shifted to their new seg
    /// numbers; the returned offsets say where `from`'s ids now are ([`Shift`]). Nothing is
    /// copied or looked up op by op. `from`'s root and its block come along, detached and unused.
    pub fn absorb(&mut self, from: Body<'a>) -> Offsets {
        let o = Offsets { from: from.seg0, to: self.seg0 + self.segs.len() as u32 };
        let same = core::ptr::eq(self.ctx.opt, from.ctx.opt);
        let opt = self.ctx.opt;
        for seg in from.segs {
            let mut seg = seg.shift(&o);
            if !same {
                seg.ops.iter_mut().for_each(|d| d.info = opt.op_info(&d.name));
            }
            self.segs.push(seg);
        }
        o
    }

    /// Puts `new` (detached) where `old` is, at `at` in its block; `old` is left detached.
    pub fn swap_in(&mut self, old: OpId, at: usize, new: OpId) {
        let block = self[old].parent.expect("old is placed");
        if self.logs(block) {
            self.insert_before(new, old);
            return self.detach(old);
        }
        debug_assert_eq!(self[block].ops[at], old);
        self.ops_of(block)[at] = new;
        self.linked(new, block);
        self[new].parent = Some(block);
        self[old].parent = None;
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
        // One lookup for the op (none once it is in a body), not one per attribute (`inherent`).
        let Some(info) = data.info.or_else(|| self.ctx.opt.op_info(&data.name)) else { return };
        let inherent = |a: &NamedAttr<'_>| info.inherent.contains(&&*a.name) || matches!(&*a.name, "operandSegmentSizes" | "resultSegmentSizes");
        // Already where they belong (what the parser gives): each list sorted in place, nothing
        // moved or allocated.
        if data.properties.iter().all(inherent) && !data.attributes.iter().any(inherent) {
            data.properties.sort_by(|a, b| a.name.cmp(&b.name));
            data.attributes.sort_by(|a, b| a.name.cmp(&b.name));
            return;
        }
        let mut all = core::mem::take(&mut data.properties);
        all.append(&mut data.attributes);
        all.sort_by(|a, b| a.name.cmp(&b.name));
        let n = all.iter().filter(|a| inherent(a)).count();
        let (mut props, mut attrs) = (Vec::with_capacity(n), Vec::with_capacity(all.len() - n));
        for a in all {
            if inherent(&a) { props.push(a) } else { attrs.push(a) }
        }
        data.properties = props;
        data.attributes = attrs;
    }

    /// [`place`](Self::place) read off `data` without copying it: its properties and its
    /// discardable attributes, borrowing their text.
    pub fn placed<'s>(&self, data: &'s OpData<'a>) -> (Option<Attribute<'s>>, Vec<NamedAttr<'s>>) {
        let dict = |props: Vec<NamedAttr<'s>>| (!props.is_empty()).then_some(Attribute::Dict(props));
        let Some(info) = data.info.or_else(|| self.ctx.opt.op_info(&data.name)) else {
            return (dict(data.properties.reborrow()), data.attributes.reborrow());
        };
        let mut all: Vec<&NamedAttr<'a>> = data.properties.iter().collect();
        all.extend(&data.attributes);
        all.sort_by(|a, b| a.name.cmp(&b.name));
        let (props, attrs): (Vec<_>, Vec<_>) = all.into_iter().map(|a| a.reborrow()).partition(|a| info.inherent.contains(&&*a.name) || matches!(&*a.name, "operandSegmentSizes" | "resultSegmentSizes"));
        (dict(props), attrs)
    }

    /// The discardable attributes of `op` (the `{...}` dictionary).
    pub fn discardable(&self, op: OpId) -> Vec<NamedAttr<'a>> {
        let mut d = self[op].clone();
        self.place(&mut d);
        d.attributes
    }

    /// A new value, in the seg of what defines it.
    fn value(&mut self, ty: Type<'a>, def: Def, loc: Option<Str<'a>>) -> ValueId {
        let s = match def {
            Def::Result(op, _) => op.seg(),
            Def::Arg(b, _) => b.seg(),
        };
        let id = ValueId::at(s, self.grow(Kind::Value, s));
        self.seg_mut(s).values.push(ValueData { ty, def, uses: Uses::new(), loc });
        id
    }

    /// Appends an empty region to `op` (in `op`'s seg).
    pub fn add_region(&mut self, op: OpId) -> RegionId {
        let s = op.seg();
        let id = RegionId::at(s, self.grow(Kind::Region, s));
        self.seg_mut(s).regions.push(RegionData { blocks: crate::Ids::new(), parent: op });
        self[op].regions.push(id);
        id
    }

    /// Appends a block with arguments `args` (type, location) to `region`.
    pub fn add_block(&mut self, region: RegionId, args: &[(Type<'a>, Option<Str<'a>>)]) -> BlockId {
        self.add_block_with(region, args.iter().cloned())
    }

    /// [`Body::add_block`] with arguments it takes over rather than copies.
    pub fn add_block_with(&mut self, region: RegionId, args: impl IntoIterator<Item = (Type<'a>, Option<Str<'a>>)>) -> BlockId {
        let s = region.seg();
        let id = BlockId::at(s, self.grow(Kind::Block, s));
        self.seg_mut(s).blocks.push(BlockData { parent: Some(region), ..BlockData::default() });
        let args = args.into_iter().enumerate().map(|(i, (ty, loc))| self.value(ty, Def::Arg(id, i as u32), loc)).collect();
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

    /// Inserts a block argument at position `at` (`Block::insertArgument`); the later ones shift.
    pub fn insert_arg(&mut self, block: BlockId, at: usize, ty: Type<'a>, loc: Option<Str<'a>>) -> ValueId {
        let v = self.value(ty, Def::Arg(block, at as u32), loc);
        self[block].args.insert(at, v);
        for (i, a) in self[block].args.clone().into_iter().enumerate().skip(at + 1) {
            self[a].def = Def::Arg(block, i as u32);
        }
        v
    }

    // ---- placement ---------------------------------------------------------------------

    /// Whether an edit of `block`'s op list goes into the undo log (a checkpoint is open and the
    /// block existed when it was taken; blocks made since are truncated away whole).
    fn logs(&self, block: BlockId) -> bool {
        self.journal.depth > 0 && self.existed(Kind::Block, block.seg(), block.index() as usize, self.journal.mark)
    }

    /// Notes `op` going into `block`: a link between their segs unless `op` is its seg's own
    /// op (entry 0) going into its parent's block.
    #[inline]
    fn linked(&mut self, op: OpId, block: BlockId) {
        if op.seg() != block.seg() && (op.index() != 0 || op.seg() == 0) {
            self.link(op.seg(), block.seg());
        }
    }

    /// Inserts detached `op` into `block` at position `at` (`None`: the end).
    pub fn insert(&mut self, op: OpId, block: BlockId, at: Option<usize>) {
        debug_assert!(self[op].parent.is_none(), "op is already placed");
        let at = at.unwrap_or(self[block].ops.len());
        if self.logs(block) {
            self.journal.undo.push(Undo::Inserted { block, at });
        }
        self.ops_of(block).insert(at, op);
        self.linked(op, block);
        self[op].parent = Some(block);
    }

    /// ⭐ Moves the ops at `range` of `from` into `to` before position `at` (`None`: the end), in one
    /// go and in order; the moved ops. `from` and `to` differ.
    pub fn splice(&mut self, from: BlockId, range: core::ops::Range<usize>, to: BlockId, at: Option<usize>) -> Vec<OpId> {
        debug_assert_ne!(from, to, "splice within one block");
        let at_from = range.start;
        let moved: Vec<OpId> = self.ops_of(from).drain(range).collect();
        let at = at.unwrap_or(self[to].ops.len());
        if self.logs(from) || self.logs(to) {
            self.journal.undo.push(Undo::Spliced { from, at_from, to, at_to: at, len: moved.len() });
        }
        self.ops_of(to).splice(at..at, moved.iter().copied());
        for &o in &moved {
            self.linked(o, to);
            self[o].parent = Some(to);
        }
        moved
    }

    /// Takes `ops` out of their blocks, one pass over each block (they stay whole).
    pub fn detach_all(&mut self, ops: &[OpId]) {
        let mut by_block: alloc::collections::BTreeMap<BlockId, alloc::collections::BTreeSet<OpId>> = alloc::collections::BTreeMap::new();
        for &op in ops {
            if let Some(block) = self[op].parent {
                by_block.entry(block).or_default().insert(op);
            }
        }
        for (block, gone) in by_block {
            if self.logs(block) {
                // Logged edit by edit, so that a rollback can put them back.
                gone.iter().for_each(|&op| self.detach(op));
                continue;
            }
            self.ops_of(block).retain(|o| !gone.contains(o));
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
        let Some(block) = self[op].parent else { return };
        let at = self[block].ops.iter().rposition(|o| *o == op).expect("op not in its block");
        if self.logs(block) {
            self.journal.undo.push(Undo::Removed { block, at, op });
        }
        self.ops_of(block).remove(at);
        self[op].parent = None;
    }

    // ---- use-def -----------------------------------------------------------------------

    /// Points operand `index` of `op` at `v`.
    pub fn set_operand(&mut self, op: OpId, index: usize, v: ValueId) {
        let old = self[op].operands[index];
        let u = Use { op, index: index as u32 };
        self[old].uses.retain(|x| *x != u);
        self.link(op.seg(), v.seg());
        self[op].operands[index] = v;
        self[v].uses.push(u);
    }

    /// Replaces every operand list of `op` at once.
    pub fn set_operands(&mut self, op: OpId, operands: impl Into<Ids<ValueId>>) {
        let operands = operands.into();
        self.drop_uses(op);
        for (index, v) in operands.iter().enumerate() {
            self.link(op.seg(), v.seg());
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
            self.link(u.op.seg(), to.seg());
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

    /// Whether `values` have exactly the types `types` (without collecting them).
    pub fn types_are(&self, values: &[ValueId], types: &[Type<'a>]) -> bool {
        values.len() == types.len() && values.iter().zip(types).all(|(v, t)| self[*v].ty == *t)
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

/// Names to values, sorted by name: what a module's aliases are kept in (`#map`, `!t`, `#loc3`).
/// The names borrow the text; a `Vec`, not a map — a module has few, looked up by halving.
struct Named<'a, T>(Vec<(Str<'a>, T)>);

impl<'a, T> Default for Named<'a, T> {
    fn default() -> Self {
        Self(Vec::new())
    }
}

impl<'a, T> Named<'a, T> {
    fn get(&self, name: &str) -> Option<&T> {
        self.0.binary_search_by(|(k, _)| (**k).cmp(name)).ok().map(|i| &self.0[i].1)
    }

    /// A later definition of the same name replaces the earlier one.
    fn insert(&mut self, name: Str<'a>, value: T) {
        match self.0.binary_search_by(|(k, _)| (**k).cmp(&*name)) {
            Ok(i) => self.0[i].1 = value,
            Err(i) => self.0.insert(i, (name, value)),
        }
    }

    fn is_empty(&self) -> bool {
        self.0.is_empty()
    }
}

/// The module's aliases, each already resolved against the earlier ones. Resolving works in
/// place: only a node that names an alias is replaced, nothing else is copied, and a module
/// without aliases is not walked at all.
#[derive(Default)]
struct Aliases<'a> {
    attrs: Named<'a, Attribute<'a>>,
    types: Named<'a, Type<'a>>,
    /// Location aliases (`#loc3 = loc("f":1:2)`), by name, as the text inside `loc(...)`.
    locs: Named<'a, Str<'a>>,
}

impl<'a> Aliases<'a> {
    /// A location's raw text with every location alias in it spelled out.
    fn loc(&self, raw: Option<Str<'a>>) -> Option<Str<'a>> {
        let raw = raw?;
        if !raw.contains('#') || self.locs.is_empty() {
            return Some(raw);
        }
        let mut out = String::new();
        let mut rest = &*raw;
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

    /// No alias defined: nothing to resolve.
    fn none(&self) -> bool {
        self.attrs.is_empty() && self.types.is_empty()
    }

    fn ty(&self, t: &mut Type<'a>) {
        if self.none() {
            return;
        }
        if let Type::Extended(ext) = t
            && let Some(hit) = Self::alias(ext).and_then(|n| self.types.get(n))
        {
            *t = hit.clone();
            return;
        }
        match t {
            Type::Extended(ext) => self.ext(ext),
            Type::Complex(e) => self.ty(e),
            Type::Tuple(ts) => self.tys(ts),
            Type::Function(f) => self.fn_ty(f),
            Type::Shaped(s) => {
                self.ty(&mut s.elem);
                self.attrs(&mut s.extras);
            }
            _ => {}
        }
    }

    fn tys(&self, ts: &mut [Type<'a>]) {
        ts.iter_mut().for_each(|t| self.ty(t));
    }

    fn fn_ty(&self, f: &mut FunctionType<'a>) {
        self.tys(&mut f.inputs);
        self.tys(&mut f.results);
    }

    fn ext(&self, e: &mut Extended<'a>) {
        if let Some(b) = &mut e.body {
            self.raw(b);
        }
        self.attrs(&mut e.params);
    }

    /// A dialect body's raw text with the aliases it names (`#loop_unroll`, `!t`) spelled out;
    /// string literals and dialect names (`#llvm.loop_unroll`) left alone.
    fn raw(&self, body: &mut Str<'a>) {
        if !body.contains(['#', '!']) || self.none() {
            return;
        }
        let ident = |c: char| c.is_ascii_alphanumeric() || matches!(c, '_' | '.' | '$' | '-');
        let mut out = String::new();
        let mut chars = body.char_indices().peekable();
        let mut at = 0;
        while let Some((i, c)) = chars.next() {
            match c {
                '"' => {
                    while let Some((_, d)) = chars.next() {
                        match d {
                            '\\' => {
                                chars.next();
                            }
                            '"' => break,
                            _ => {}
                        }
                    }
                }
                '#' | '!' => {
                    let tail = &body[i + 1..];
                    let end = tail.find(|c: char| !ident(c)).unwrap_or(tail.len());
                    let name = &tail[..end];
                    let value = match c {
                        _ if name.contains('.') => None,
                        '#' => self.attrs.get(name).map(|a| format!("{a}")),
                        _ => self.types.get(name).map(|t| format!("{t}")),
                    };
                    if let Some(v) = value {
                        out.push_str(&body[at..i]);
                        out.push_str(&v);
                        at = i + 1 + end;
                    }
                }
                _ => {}
            }
        }
        if at != 0 {
            out.push_str(&body[at..]);
            *body = Cow::Owned(out);
        }
    }

    fn opt_ty(&self, t: &mut Option<Type<'a>>) {
        if let Some(t) = t {
            self.ty(t);
        }
    }

    fn attr(&self, a: &mut Attribute<'a>) {
        if self.none() {
            return;
        }
        if let Attribute::Extended { ext, ty: None } = a
            && let Some(hit) = Self::alias(ext).and_then(|n| self.attrs.get(n))
        {
            *a = hit.clone();
            return;
        }
        match a {
            Attribute::Extended { ext, ty } => {
                self.ext(ext);
                self.opt_ty(ty);
            }
            Attribute::Int { ty, .. } | Attribute::Float { ty, .. } | Attribute::Str { ty, .. } | Attribute::Builtin { ty, .. } => self.opt_ty(ty),
            Attribute::Type(t) | Attribute::DenseArray { ty: t, .. } => self.ty(t),
            Attribute::Array(xs) => self.attrs(xs),
            Attribute::Dict(d) => self.dict(d),
            _ => {}
        }
    }

    fn attrs(&self, xs: &mut [Attribute<'a>]) {
        xs.iter_mut().for_each(|a| self.attr(a));
    }

    fn dict(&self, d: &mut [NamedAttr<'a>]) {
        if self.none() {
            return;
        }
        for n in d {
            if let Some(v) = &mut n.value {
                self.attr(v);
            }
        }
    }
}

/// One name scope: a region's values and block labels. Names borrow the text; a result group's
/// values are a range of `ids`. Filled while the scope's ops are placed, then [`Scope::seal`]ed
/// (sorted by name) before any use in it is resolved.
#[derive(Default)]
struct Scope<'a> {
    /// (name, start in `ids`, length).
    values: Vec<(Str<'a>, u32, u32)>,
    ids: Vec<ValueId>,
    labels: Vec<(Str<'a>, BlockId)>,
}

impl<'a> Scope<'a> {
    fn define(&mut self, name: Str<'a>, ids: &[ValueId]) {
        self.values.push((name, self.ids.len() as u32, ids.len() as u32));
        self.ids.extend_from_slice(ids);
    }

    /// Sorted by name, a name defined twice keeping its last definition (as a map would).
    fn seal(&mut self) {
        Self::sort(&mut self.values, |v| &v.0);
        Self::sort(&mut self.labels, |l| &l.0);
    }

    fn sort<T>(xs: &mut Vec<T>, key: impl Fn(&T) -> &Str<'a>) {
        xs.reverse();
        xs.sort_by(|a, b| key(a).cmp(key(b)));
        xs.dedup_by(|b, a| key(a) == key(b));
    }

    fn values(&self, name: &str) -> Option<&[ValueId]> {
        let i = self.values.binary_search_by(|(k, ..)| (**k).cmp(name)).ok()?;
        let (_, start, len) = self.values[i];
        Some(&self.ids[start as usize..(start + len) as usize])
    }

    fn label(&self, name: &str) -> Option<BlockId> {
        self.labels.binary_search_by(|(k, _)| (**k).cmp(name)).ok().map(|i| self.labels[i].1)
    }
}

/// What an op still has to give once its whole scope is known: taken out of its
/// [`Operation`], which is gone by then.
struct Pending<'a> {
    id: OpId,
    operands: Vec<Value<'a>>,
    successors: Vec<Str<'a>>,
    regions: Vec<Region<'a>>,
}

/// The state of one import. It owns the module and moves each piece into the body: names,
/// attributes and types go over as they are (borrowing the text), and each op's text-side
/// [`Operation`] is dropped as soon as it is in. The regions of isolated ops are imported
/// apart, on `x` ([`Import::apart`]).
struct Import<'i, 'a, X> {
    body: Body<'a>,
    aliases: &'i Aliases<'a>,
    scopes: Vec<Scope<'a>>,
    x: &'i X,
}

impl<'i, 'a, X: mlirformat::Executor + Sync> Import<'i, 'a, X> {
    /// How many ops, values, blocks and regions `ops` hold, nested ones included: what the
    /// body's arenas are sized to up front, so that they do not grow by doubling (an arena
    /// half empty at its last doubling).
    fn census(ops: &[Operation<'_>], n: &mut [usize; 4]) {
        for op in ops {
            n[0] += 1;
            n[1] += op.ty.results.len();
            n[3] += op.regions.len();
            for b in op.regions.iter().flat_map(|r| &r.blocks) {
                n[2] += 1;
                n[1] += b.args.len();
                Self::census(&b.ops, n);
            }
        }
    }

    fn scope(&mut self) -> &mut Scope<'a> {
        self.scopes.last_mut().expect("no scope")
    }

    fn lookup(&self, v: &Value<'_>) -> Result<ValueId, Error> {
        let pack = self.scopes.iter().rev().find_map(|s| s.values(&v.name)).ok_or_else(|| format!("use of undefined value %{}", v.name))?;
        pack.get(v.index.unwrap_or(0) as usize).copied().ok_or_else(|| format!("%{}#{} is out of range", v.name, v.index.unwrap_or(0)).into())
    }

    /// The op without its operands and regions, results named in the current scope.
    fn shell(&mut self, op: Operation<'a>) -> Result<Pending<'a>, Error> {
        let Operation { results, name, operands, successors, properties, regions, mut attributes, ty, loc, raw } = op;
        if raw.is_some() {
            return Err(format!("`{name}`: custom form not understood (register its dialect, or print generic)").into());
        }
        let a = &self.aliases;
        // `<{...}>` is a dictionary; anything else is not a property
        let properties = match properties {
            Some(Attribute::Dict(mut d)) => {
                a.dict(&mut d);
                d
            }
            _ => Vec::new(),
        };
        a.dict(&mut attributes);
        let data = OpData { properties, attributes, loc: a.loc(loc), ..OpData::named(name) };
        let mut types = ty.results;
        a.tys(&mut types);
        let n = types.len();
        let id = self.body.adopt(data, types);
        let named: usize = results.iter().map(|r| r.count.unwrap_or(1) as usize).sum();
        if named != n {
            return Err(format!("`{}`: {} result names for {} result types", self.body[id].name, results.len(), n).into());
        }
        let Import { body, scopes, .. } = self;
        let scope = scopes.last_mut().expect("no scope");
        let mut at = 0;
        for r in results {
            let k = r.count.unwrap_or(1) as usize;
            scope.define(r.name, &body[id].results[at..at + k]);
            at += k;
        }
        Ok(Pending { id, operands, successors, regions })
    }

    /// `ops` into `block`; returns them, to be finished once the whole scope is known. An
    /// isolated op placed in the root's block (a function) starts a seg of its own, as its
    /// entry 0: everything in it is imported there ([`Import::finish`]).
    fn place(&mut self, block: BlockId, ops: Vec<Operation<'a>>, pending: &mut Vec<Pending<'a>>) -> Result<(), Error> {
        pending.reserve(ops.len());
        let top = self.body.block_owner(block) == Some(self.body.root);
        for op in ops {
            let home = self.body.home;
            if top && self.body.ctx.opt.op_info(&op.name).is_some_and(|i| i.has(crate::Trait::IsIsolatedFromAbove)) {
                self.body.home = self.body.new_seg(Seg::default());
            }
            let p = self.shell(op);
            self.body.home = home;
            let p = p?;
            self.body.insert(p.id, block, None);
            pending.push(p);
        }
        Ok(())
    }

    /// Whether `op` starts a seg of its own here.
    fn owns(&self, op: OpId) -> bool {
        op.seg() != self.body.home
    }

    /// Operands, successors and regions of the ops of one scope. The regions of an op with a
    /// seg of its own are imported into that seg alone: on `x`, all at once ([`Import::apart`]),
    /// or here one after the other, the same way.
    fn finish(&mut self, mut pending: Vec<Pending<'a>>) -> Result<(), Error> {
        self.scope().seal();
        let apart = self.apart(&mut pending);
        for (p, done) in pending.into_iter().zip(apart) {
            let operands = p.operands.iter().map(|v| self.lookup(v)).collect::<Result<Vec<_>, _>>()?;
            let scope = self.scopes.last().expect("no scope");
            let successors = p.successors.iter().map(|s| scope.label(s).ok_or_else(|| Error(format!("reference to an undefined block ^{s}")))).collect::<Result<_, _>>()?;
            let apart = done.is_some();
            if let Some(seg) = done.transpose()? {
                self.body.put_seg(p.id.seg(), seg);
            }
            self.body.set_operands(p.id, operands);
            self.body[p.id].successors = successors;
            if !apart && !p.regions.is_empty() {
                if self.owns(p.id) {
                    self.isolate(p.id, p.regions)?;
                } else {
                    for r in p.regions {
                        self.region(p.id, r)?;
                    }
                }
            }
        }
        Ok(())
    }

    /// ⭐ The regions of the ops among `pending` with a seg of their own, each imported into its
    /// seg as a task on `x`: the seg taken out of the body, filled, handed back (in `pending`'s
    /// order; `None`: imported in [`Import::finish`]). Such an op is isolated: its regions name
    /// nothing outside themselves, so a task needs none of this import's scopes, only its
    /// aliases. On one thread, or with fewer than two such ops, nothing goes apart.
    fn apart(&mut self, pending: &mut [Pending<'a>]) -> Vec<Option<Result<Seg<'a>, Error>>> {
        let mut out: Vec<_> = pending.iter().map(|_| None).collect();
        let picked: Vec<usize> = (0..pending.len()).filter(|i| self.owns(pending[*i].id) && !pending[*i].regions.is_empty()).collect();
        if self.x.threads() <= 1 || picked.len() < 2 {
            return out;
        }
        let (ctx, aliases, x) = (self.body.ctx, self.aliases, self.x);
        let tasks: Vec<_> = picked
            .iter()
            .map(|i| {
                let (op, regions) = (pending[*i].id, core::mem::take(&mut pending[*i].regions));
                let seg = self.body.take_seg(op.seg());
                move || Import::alone(ctx, aliases, x, op, seg, regions)
            })
            .collect();
        for (i, r) in picked.into_iter().zip(x.execute(tasks)) {
            out[i] = Some(r);
        }
        out
    }

    /// `op`'s `regions` imported into `seg`, `op`'s own (taken out of the body: a body of its own
    /// holds it meanwhile), sized to them up front.
    fn alone(ctx: crate::Ctx<'a>, aliases: &'i Aliases<'a>, x: &'i X, op: OpId, mut seg: Seg<'a>, regions: Vec<Region<'a>>) -> Result<Seg<'a>, Error> {
        let mut n = [0, 0, 0, regions.len()];
        for b in regions.iter().flat_map(|r| &r.blocks) {
            n[2] += 1;
            n[1] += b.args.len();
            Self::census(&b.ops, &mut n);
        }
        seg.ops.reserve(n[0]);
        seg.values.reserve(n[1]);
        seg.blocks.reserve(n[2]);
        seg.regions.reserve(n[3]);
        let s = op.seg();
        let body = Body { ctx, segs: alloc::vec![seg], seg0: s, home: s, root: op, items: Vec::new(), journal: crate::ir::Journal::default() };
        let mut im = Import { body, aliases, scopes: alloc::vec![Scope::default()], x };
        for r in regions {
            im.region(op, r)?;
        }
        Ok(im.body.segs.pop().expect("its seg"))
    }

    /// [`Import::alone`] in place: `op`'s regions imported into its seg, with none of the
    /// scopes around it.
    fn isolate(&mut self, op: OpId, regions: Vec<Region<'a>>) -> Result<(), Error> {
        let scopes = core::mem::replace(&mut self.scopes, alloc::vec![Scope::default()]);
        let home = core::mem::replace(&mut self.body.home, op.seg());
        let r = regions.into_iter().try_for_each(|r| self.region(op, r).map(|_| ()));
        self.body.home = home;
        self.scopes = scopes;
        r
    }

    fn region(&mut self, op: OpId, r: Region<'a>) -> Result<RegionId, Error> {
        let region = self.body.add_region(op);
        self.scopes.push(Scope::default());
        let mut pending = Vec::new();
        let lone = r.blocks.len() == 1;
        for b in r.blocks {
            // `({ })` holds no block at all; mlirformat reads it as one empty, unlabeled block.
            if lone && b.label.is_none() && b.args.is_empty() && b.ops.is_empty() {
                break;
            }
            let Block { label, args, ops } = b;
            let Import { body, aliases, scopes, .. } = self;
            let mut names = Vec::with_capacity(args.len());
            let block = body.add_block_with(
                region,
                args.into_iter().map(|BlockArg { name, mut ty, loc }| {
                    names.push(name);
                    aliases.ty(&mut ty);
                    (ty, aliases.loc(loc))
                }),
            );
            let scope = scopes.last_mut().expect("no scope");
            if let Some(label) = label {
                scope.labels.push((label, block));
            }
            for (name, v) in names.into_iter().zip(&body[block].args) {
                scope.define(name, core::slice::from_ref(v));
            }
            self.place(block, ops, &mut pending)?;
        }
        self.finish(pending)?;
        self.scopes.pop();
        Ok(region)
    }
}

impl<'a> Body<'a> {
    /// The body of module `m` in context `ctx`: its one `builtin.module` becomes the root;
    /// loose top-level ops are wrapped in one, as `mlir-opt` does. `m` is taken apart, not
    /// copied: the body ends up holding its names, attributes and types.
    pub fn import(ctx: crate::Ctx<'a>, m: Module<'a>) -> Result<Self, Error> {
        Body::import_in(ctx, m, &mlirformat::ThreadSingle)
    }

    /// Like [`import`](Self::import), each function (an isolated op in the root's block, with a
    /// seg of its own) imported in parallel on `x`, straight into its seg.
    pub fn import_in<X: mlirformat::Executor + Sync>(ctx: crate::Ctx<'a>, m: Module<'a>, x: &X) -> Result<Self, Error> {
        let mut aliases = Aliases::default();
        let mut items = Vec::new();
        let mut ops = Vec::new();
        for item in m.items {
            match item {
                // Location aliases are spelled out where used (so the IR prints them inline).
                Item::AttrAlias { name, value: Attribute::Builtin { name: kw, body, .. } } if kw == "loc" => {
                    let inner = match body {
                        Cow::Borrowed(b) => Cow::Borrowed(b.strip_prefix('(').and_then(|b| b.strip_suffix(')')).unwrap_or(b)),
                        Cow::Owned(b) => Cow::Owned(String::from(b.strip_prefix('(').and_then(|b| b.strip_suffix(')')).unwrap_or(&b))),
                    };
                    let resolved = aliases.loc(Some(inner)).unwrap_or_default();
                    aliases.locs.insert(name, resolved);
                }
                Item::AttrAlias { name, value } => {
                    let mut resolved = value.clone();
                    aliases.attr(&mut resolved);
                    aliases.attrs.insert(name.clone(), resolved);
                    items.push(Item::AttrAlias { name, value });
                }
                Item::TypeAlias { name, ty } => {
                    let mut resolved = ty.clone();
                    aliases.ty(&mut resolved);
                    aliases.types.insert(name.clone(), resolved);
                    items.push(Item::TypeAlias { name, ty });
                }
                Item::Metadata { .. } => items.push(item),
                Item::Op(op) => ops.push(op),
            }
        }
        let empty = Body { ctx, segs: alloc::vec![Seg::default()], seg0: 0, home: 0, root: OpId::at(0, 0), items, journal: crate::ir::Journal::default() };
        let mut im = Import { body: empty, aliases: &aliases, scopes: alloc::vec![Scope::default()], x };
        if let [module] = ops.as_slice()
            && module.name == "builtin.module"
        {
            let module = ops.pop().expect("one op");
            let p = im.shell(module)?;
            im.body.root = p.id;
            im.finish(alloc::vec![p])?;
        } else {
            let root = im.body.create(OpData::named("builtin.module"), &[]);
            im.body.root = root;
            let region = im.body.add_region(root);
            let block = im.body.add_block(region, &[]);
            let mut pending = Vec::new();
            im.place(block, ops, &mut pending)?;
            im.finish(pending)?;
        }
        Ok(im.body)
    }
}

/// Name counters of one scope.
#[derive(Clone, Copy, Default)]
struct Counters {
    value: u32,
    arg: u32,
    conflict: u32,
}

/// What a value is called: a number (`%7`), or a name (`%c0`, `%arg2`), by index into
/// [`Names::strs`].
#[derive(Clone, Copy)]
enum Head {
    Num(u32),
    Str(u32),
}

/// A value's name on the way out: its result group's head, and its place in the group when the
/// group has several results (`%0#1`, `%sizes#2`).
#[derive(Clone, Copy)]
struct Name {
    head: Head,
    index: Option<u32>,
}

/// ⭐ How a body is named on the way out ([`Body::names`]): every value and block by id, each
/// spelling (`%7`, `%c0`, `^bb1`) written once, for [`Body::export`] to borrow.
pub struct Names {
    values: IdVec<ValueId, Option<Name>>,
    labels: IdVec<BlockId, Option<u32>>,
    /// The ops whose results print in several groups (`%a, %b:2 = ...`): each group's start.
    groups: BTreeMap<OpId, Vec<u32>>,
    nums: Vec<String>,
    strs: Vec<String>,
    bbs: Vec<String>,
}

/// One naming scope (`usedNames`), inside its parent's.
struct NameScope {
    parent: Option<usize>,
    used: alloc::collections::BTreeSet<String>,
}

/// `SSANameState` while it numbers: the names, the counters and the open scopes.
struct Namer<'n, 'b, 'a> {
    n: &'n mut Names,
    body: &'b Body<'a>,
    /// Generic form: no op is asked for names (`OpAsmOpInterface`), and ids are unique.
    generic: bool,
    next: Counters,
    /// The highest value number given, for the spellings to write.
    max: u32,
    scopes: Vec<NameScope>,
    scope: usize,
}

impl Namer<'_, '_, '_> {
    /// `sanitizeIdentifier`: a name that cannot be an identifier made into one.
    fn sanitize(name: &str) -> Cow<'_, str> {
        let valid = |c: u8| c.is_ascii_alphanumeric() || b"$._-".contains(&c);
        let copy = |out: &mut String| {
            for c in name.bytes() {
                match c {
                    c if valid(c) => out.push(c as char),
                    b' ' => out.push('_'),
                    c => out.push_str(&format!("{c:X}")),
                }
            }
        };
        let first = name.as_bytes()[0];
        if first.is_ascii_digit() || (!valid(first) && first != b' ') {
            let mut out = String::from("_");
            copy(&mut out);
            return Cow::Owned(out);
        }
        if name.bytes().all(valid) {
            return Cow::Borrowed(name);
        }
        let mut out = String::new();
        copy(&mut out);
        Cow::Owned(out)
    }

    fn taken(&self, name: &str) -> bool {
        let mut at = Some(self.scope);
        while let Some(s) = at {
            if self.scopes[s].used.contains(name) {
                return true;
            }
            at = self.scopes[s].parent;
        }
        false
    }

    /// `setValueName`: an empty name is numbered; any other made unique in the scopes open
    /// (`uniqueValueName`: `name_N`, `N` the next conflict id).
    fn set(&mut self, name: &str) -> Head {
        if name.is_empty() {
            self.next.value += 1;
            return Head::Num(self.next.value - 1);
        }
        let name = Self::sanitize(name);
        let unique = if !self.taken(&name) {
            name.into_owned()
        } else {
            loop {
                let probe = format!("{name}_{}", self.next.conflict);
                self.next.conflict += 1;
                if !self.taken(&probe) {
                    break probe;
                }
            }
        };
        self.scopes[self.scope].used.insert(unique.clone());
        self.n.strs.push(unique);
        Head::Str(self.n.strs.len() as u32 - 1)
    }

    /// `numberValuesInOp`: the names `op` suggests, then a number for its first result if it
    /// has none; the results named apart start groups of their own.
    fn op(&mut self, op: OpId) {
        let (body, results) = (self.body, &self.body[op].results);
        let mut heads: Vec<Option<Head>> = alloc::vec![None; results.len()];
        let mut groups = alloc::vec![0u32];
        if !self.generic {
            let names = body.interfaces(op).map_or_else(|| body.ods_result_names(op), |i| i.asm_result_names(body, op));
            for (v, name) in names {
                let Some(k) = results.iter().position(|r| *r == v) else { continue };
                heads[k] = Some(self.set(&name));
                if k != 0 {
                    groups.push(k as u32);
                }
            }
        }
        if results.is_empty() {
            return;
        }
        if heads[0].is_none() {
            heads[0] = Some(self.set(""));
        }
        groups.sort_unstable();
        groups.dedup();
        let total = results.len() as u32;
        for (k, r) in results.iter().enumerate() {
            let k = k as u32;
            // `getResultIDAndNumber`: the group holding result `k`.
            let at = groups.partition_point(|g| *g <= k) - 1;
            let (start, end) = (groups[at], groups.get(at + 1).copied().unwrap_or(total));
            let index = match () {
                _ if total == 1 => None,
                _ if groups.len() == 1 => Some(k),
                _ if end - start != 1 => Some(k - start),
                _ => None,
            };
            self.n.values.set(*r, heads[start as usize].map(|head| Name { head, index }));
        }
        if groups.len() > 1 {
            self.n.groups.insert(op, groups);
        }
    }

    /// `numberValuesInRegion` / `numberValuesInBlock`: the argument names the parent op
    /// suggests, `%argN` for the entry block's others, numbers for later blocks', then the ops.
    fn region(&mut self, r: RegionId) {
        let body = self.body;
        if !self.generic && let Some(i) = body.interfaces(body[r].parent) {
            let parent = body[r].parent;
            for (v, name) in i.asm_block_arg_names(body, parent, r) {
                let head = self.set(&name);
                self.n.values.set(v, Some(Name { head, index: None }));
            }
        }
        for (i, b) in body[r].blocks.iter().enumerate() {
            self.n.labels.set(*b, Some(i as u32));
            for v in &body[*b].args {
                if self.n.values.get(*v).is_some() {
                    continue;
                }
                let head = if i == 0 {
                    self.next.arg += 1;
                    self.set(&format!("arg{}", self.next.arg - 1))
                } else {
                    self.set("")
                };
                self.n.values.set(*v, Some(Name { head, index: None }));
            }
            for o in &body[*b].ops {
                self.op(*o);
            }
            self.max = self.max.max(self.next.value);
        }
    }
}

impl Names {
    /// `SSANameState(root)`: regions are numbered off a stack, so the last one pushed first,
    /// each after its whole parent region. `generic` form asks no op for names, and keeps
    /// counting across regions (`shouldPrintUniqueSSAIDs`); otherwise a region starts from the
    /// counters its parent region ended with.
    pub(crate) fn of(body: &Body<'_>, root: OpId, generic: bool) -> Self {
        let mut n = Names { values: IdVec::new(None), labels: IdVec::new(None), groups: BTreeMap::new(), nums: Vec::new(), strs: Vec::new(), bbs: Vec::new() };
        let mut namer = Namer { n: &mut n, body, generic, next: Counters::default(), max: 0, scopes: alloc::vec![NameScope { parent: None, used: Default::default() }], scope: 0 };
        let mut stack: Vec<(RegionId, Counters, usize)> = body[root].regions.iter().map(|r| (*r, namer.next, 0)).collect();
        namer.op(root);
        let mut bbs = 0;
        while let Some((r, saved, parent)) = stack.pop() {
            if !generic {
                namer.next = saved;
            }
            namer.scopes.push(NameScope { parent: Some(parent), used: Default::default() });
            namer.scope = namer.scopes.len() - 1;
            namer.region(r);
            bbs = bbs.max(body[r].blocks.len());
            let (next, scope) = (namer.next, namer.scope);
            stack.extend(body[r].blocks.iter().flat_map(|b| &body[*b].ops).flat_map(|o| &body[*o].regions).map(|nr| (*nr, next, scope)));
        }
        let max = namer.max.max(namer.next.value);
        n.nums = (0..max).map(|i| format!("{i}")).collect();
        n.bbs = (0..bbs).map(|i| format!("bb{i}")).collect();
        n
    }

    fn head(&self, h: Head) -> &str {
        match h {
            Head::Num(i) => &self.nums[i as usize],
            Head::Str(i) => &self.strs[i as usize],
        }
    }

    /// `printAsOperand`: `%N`, `%name`, `%N#k`, or what MLIR prints for a value not named under
    /// the root.
    #[cfg(feature = "dialect.bufferization")]
    pub(crate) fn print(&self, v: ValueId) -> String {
        match *self.values.get(v) {
            Some(Name { head, index: Some(k) }) => format!("%{}#{k}", self.head(head)),
            Some(Name { head, index: None }) => format!("%{}", self.head(head)),
            None => String::from("%<<UNKNOWN SSA VALUE>>"),
        }
    }
}

/// The state of one export: the body, read in place, and its names. Shallow, an op holds its
/// regions by reference and the printer reads them from here ([`Source`]); deep, it holds them.
struct Export<'n, 'a> {
    body: &'n Body<'a>,
    names: &'n Names,
    deep: bool,
    /// The regions handed to the printer by reference, by the number it knows each by.
    sourced: core::cell::RefCell<Vec<RegionId>>,
}

impl Source for Export<'_, '_> {
    fn region(&self, id: u32) -> Region<'_> {
        self.region(self.sourced(id))
    }

    fn blocks(&self, id: u32) -> Vec<Block<'_>> {
        self.body[self.sourced(id)].blocks.iter().enumerate().map(|(i, b)| self.block(i, *b, Vec::new())).collect()
    }

    fn len(&self, id: u32, b: usize) -> usize {
        self.body[self.body[self.sourced(id)].blocks[b]].ops.len()
    }

    fn op(&self, id: u32, b: usize, k: usize) -> Operation<'_> {
        self.op(self.body[self.body[self.sourced(id)].blocks[b]].ops[k])
    }
}

impl<'n, 'a> Export<'n, 'a> {
    fn new(body: &'n Body<'a>, names: &'n Names, deep: bool) -> Self {
        Self { body, names, deep, sourced: core::cell::RefCell::new(Vec::new()) }
    }

    /// Region `r` handed to the printer by reference: the number it knows it by.
    fn source(&self, r: RegionId) -> Region<'n> {
        let mut s = self.sourced.borrow_mut();
        s.push(r);
        Region::sourced(s.len() as u32 - 1)
    }

    /// The region the printer knows by `id`.
    fn sourced(&self, id: u32) -> RegionId {
        self.sourced.borrow()[id as usize]
    }

    /// The name of `v`; a value outside the IR (a dangling use, which is a bug) prints as
    /// `%INVALIDn` so that it shows.
    fn value(&self, v: ValueId) -> Value<'n> {
        match *self.names.values.get(v) {
            Some(Name { head, index }) => Value { name: Cow::Borrowed(self.names.head(head)), index },
            None => Value { name: Cow::Owned(format!("INVALID{}", v.0)), index: None },
        }
    }

    fn label(&self, b: BlockId) -> Str<'n> {
        Cow::Borrowed(&self.names.bbs[(*self.names.labels.get(b)).expect("placed block") as usize])
    }

    fn types(&self, vs: &[ValueId]) -> Vec<Type<'n>> {
        vs.iter().map(|v| self.body[*v].ty.reborrow()).collect()
    }

    fn op(&self, op: OpId) -> Operation<'n> {
        let d = &self.body[op];
        let (properties, attributes) = self.body.placed(d);
        // `printResultGroup`: each group by its first result, `:count` when it has several.
        let total = d.results.len() as u32;
        let starts = self.names.groups.get(&op).map_or(&[0][..], |g| &g[..]);
        let results = if d.results.is_empty() {
            Vec::new()
        } else {
            starts
                .iter()
                .enumerate()
                .map(|(i, s)| {
                    let count = starts.get(i + 1).copied().unwrap_or(total) - s;
                    ResultDef { name: self.value(d.results[*s as usize]).name, count: (count > 1).then_some(count) }
                })
                .collect()
        };
        Operation {
            results,
            name: d.name.reborrow(),
            operands: d.operands.iter().map(|v| self.value(*v)).collect(),
            successors: d.successors.iter().map(|b| self.label(*b)).collect(),
            properties,
            regions: d.regions.iter().map(|r| if self.deep || self.body[*r].blocks.is_empty() { self.region(*r) } else { self.source(*r) }).collect(),
            attributes,
            ty: FunctionType { inputs: self.types(&d.operands), results: self.types(&d.results) },
            loc: d.loc.reborrow(),
            raw: None,
        }
    }

    fn region(&self, r: RegionId) -> Region<'n> {
        Region { blocks: self.body[r].blocks.iter().enumerate().map(|(i, b)| self.block(i, *b, self.body[*b].ops.iter().map(|o| self.op(*o)).collect())).collect() }
    }

    /// Block `b`, the `i`th of its region, holding `ops`.
    fn block(&self, i: usize, b: BlockId, ops: Vec<Operation<'n>>) -> Block<'n> {
        let data = &self.body[b];
        Block {
            // An entry block without arguments needs no label, unless it is empty too: the
            // region would read back as having no block at all.
            label: (i > 0 || !data.args.is_empty() || data.ops.is_empty()).then(|| self.label(b)),
            args: data.args.iter().map(|v| BlockArg { name: self.value(*v).name, ty: self.body[*v].ty.reborrow(), loc: self.body[*v].loc.reborrow() }).collect(),
            ops,
        }
    }
}

impl<'a> Body<'a> {
    /// Aliases, the root (`root`, the body's root exported), then `{-# ... #-}` metadata, as
    /// `mlir-opt` prints them.
    fn module<'o>(&self, root: Operation<'o>) -> Module<'o>
    where
        'a: 'o,
    {
        let (meta, mut items): (Vec<_>, Vec<_>) = self.items.iter().cloned().partition(|i| matches!(i, Item::Metadata { .. }));
        items.push(Item::Op(root));
        let used = self.used_resources();
        items.extend(meta.into_iter().filter_map(|m| match m {
            Item::Metadata { body: text } => Body::keep_resources(&text, &used).map(|t| Item::Metadata { body: t.into() }),
            m => Some(m),
        }));
        Module { items }
    }
}

impl<'a> From<&Body<'a>> for Module<'a> {
    /// [`Body::export`], copied: a module that borrows nothing of the body.
    fn from(body: &Body<'a>) -> Self {
        let names = body.names();
        body.module(Export::new(body, &names, true).op(body.root).into_static())
    }
}

impl<'a> Body<'a> {
    /// How [`export`](Self::export) names things.
    pub fn names(&self) -> Names {
        Names::of(self, self.root, false)
    }

    /// ⭐ The body as text: what [`Module::from`] gives, shown with `opt` (`generic`: every op
    /// in generic form), without building it. The printer reads each op from the body as it
    /// reaches it; `keep` says which of the body's module items to print (the root always).
    pub fn show(&self, opt: &MlirOpt, generic: bool, keep: impl Fn(&Item<'_>) -> bool) -> String {
        self.render(opt, generic, true, keep)
    }

    /// [`show`](Self::show) under `--mlir-print-local-scope`: no aliases, every attribute and
    /// type spelled where it is used.
    pub fn show_local_scope(&self, opt: &MlirOpt, generic: bool, keep: impl Fn(&Item<'_>) -> bool) -> String {
        self.render(opt, generic, false, keep)
    }

    fn render(&self, opt: &MlirOpt, generic: bool, aliased: bool, keep: impl Fn(&Item<'_>) -> bool) -> String {
        let names = Names::of(self, self.root, generic);
        let ex = Export::new(self, &names, false);
        let mut m = self.module(ex.op(self.root));
        m.items.retain(|i| matches!(i, Item::Op(_)) || keep(i));
        let bare = MlirOpt::new();
        let text = if generic { &bare } else { opt }.show_from(&m, &ex).text().expect("printing into a string");
        if !aliased {
            return text;
        }
        // The aliases the C++ printer makes, past those still defined.
        let taken = m.items.iter().filter_map(|i| match i {
            Item::AttrAlias { name, .. } | Item::TypeAlias { name, .. } => Some(String::from(&**name)),
            _ => None,
        });
        let mut aliases = crate::aliases::Aliases::new(taken);
        if generic {
            aliases.visit_generic(self, self.root);
        } else {
            aliases.visit(&text);
        }
        aliases.apply(&text)
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
        let names = self.names();
        Export::new(self, &names, true).op(id).into_static()
    }

    /// Text → body, with the context's dialects for custom forms.
    pub fn parse(ctx: crate::Ctx<'a>, src: &'a str) -> Result<Self, Error> {
        let m = ctx.opt.parse(src).map_err(|e| Error(format!("{e}")))?;
        Body::import(ctx, m)
    }

    /// Like [`parse`](Self::parse), read and imported in parallel on `x`
    /// ([`MlirOpt::parse_in`](mlirformat::MlirOpt::parse_in), [`Body::import_in`]).
    pub fn parse_in<X: mlirformat::Executor + Sync>(ctx: crate::Ctx<'a>, src: &'a str, x: &X) -> Result<Self, Error> {
        let m = ctx.opt.parse_in(src, x).map_err(|e| Error(format!("{e}")))?;
        Body::import_in(ctx, m, x)
    }
}

/// Value and block correspondences for cloning (`IRMapping`).
#[derive(Debug, Default, Clone)]
pub struct Mapping {
    pub values: BTreeMap<ValueId, ValueId>,
    pub blocks: BTreeMap<crate::BlockId, crate::BlockId>,
}

impl Mapping {
    pub fn map(&mut self, from: ValueId, to: ValueId) {
        self.values.insert(from, to);
    }

    pub fn get(&self, v: ValueId) -> ValueId {
        self.values.get(&v).copied().unwrap_or(v)
    }
}

impl<'a> Body<'a> {
    /// `Operation::clone`: a detached deep copy of `op`, operands through `map`.
    pub fn clone_op(&mut self, op: OpId, map: &mut Mapping) -> OpId {
        let d = self[op].clone();
        let types = self.types(&d.results);
        let data = OpData { operands: d.operands.iter().map(|v| map.get(*v)).collect(), successors: d.successors.iter().map(|b| map.blocks.get(b).copied().unwrap_or(*b)).collect(), regions: crate::Ids::new(), parent: None, ..d };
        let new = self.create(data, &types);
        for (a, b) in self[op].results.clone().into_iter().zip(self[new].results.clone()) {
            map.map(a, b);
        }
        for r in self[op].regions.clone() {
            let nr = self.add_region(new);
            self.clone_region_into(r, nr, None, map);
        }
        new
    }

    /// `Region::cloneInto`: `from`'s blocks copied into `into` before `before` (`None`: the
    /// end); operands referring forward are remapped once everything is copied.
    pub fn clone_region_into(&mut self, from: crate::RegionId, into: crate::RegionId, before: Option<crate::BlockId>, map: &mut Mapping) -> Vec<crate::BlockId> {
        let blocks = self[from].blocks.clone();
        let mut made = Vec::new();
        for b in &blocks {
            // An argument the mapping already has is not created again.
            let fresh: Vec<ValueId> = self[*b].args.iter().copied().filter(|a| !map.values.contains_key(a)).collect();
            let args: Vec<_> = fresh.iter().map(|a| (self[*a].ty.clone(), self[*a].loc.clone())).collect();
            let nb = self.add_block(into, &args);
            // `add_block` appends; move into place.
            if let Some(at) = before {
                self[into].blocks.pop();
                let pos = self[into].blocks.iter().position(|x| *x == at).expect("block not in region");
                self[into].blocks.insert(pos, nb);
            }
            for (x, y) in fresh.into_iter().zip(self[nb].args.clone()) {
                map.map(x, y);
            }
            map.blocks.insert(*b, nb);
            made.push(nb);
        }
        let mut cloned = Vec::new();
        for (b, nb) in blocks.iter().zip(&made) {
            for o in self[*b].ops.clone() {
                let c = self.clone_op(o, map);
                self.insert(c, *nb, None);
                cloned.push(c);
            }
        }
        // Remap what was cloned before its definition (forward references, successors).
        for c in cloned {
            for o in self.ops_in(c) {
                for i in 0..self[o].operands.len() {
                    let v = self[o].operands[i];
                    let m = map.get(v);
                    if m != v {
                        self.set_operand(o, i, m);
                    }
                }
                for s in self[o].successors.iter_mut() {
                    if let Some(n) = map.blocks.get(s) {
                        *s = *n;
                    }
                }
            }
        }
        made
    }
}

/// The `llvm::Regex` subset module matchers use: literals, `.`, `*`, `+`, `?`, `^`, `$`;
/// [`Regex::search`] matches anywhere, as `Regex::match` does.
pub struct Regex<'p>(pub &'p [u8]);

impl Regex<'_> {
    pub fn search(&self, s: &str) -> bool {
        let s = s.as_bytes();
        if let Some(p) = self.0.strip_prefix(b"^") {
            return Regex(p).here(s);
        }
        (0..=s.len()).any(|i| self.here(&s[i..]))
    }

    /// Whether the pattern matches a prefix of `s`.
    fn here(&self, s: &[u8]) -> bool {
        let p = self.0;
        let Some(&c) = p.first() else { return true };
        if c == b'$' && p.len() == 1 {
            return s.is_empty();
        }
        let one = |x: Option<&u8>| x.is_some_and(|x| c == b'.' || *x == c);
        match p.get(1) {
            Some(b'*') => (0..=s.len()).take_while(|n| *n == 0 || one(s.get(n - 1))).any(|n| s[..n].iter().all(|x| one(Some(x))) && Regex(&p[2..]).here(&s[n..])),
            Some(b'+') => one(s.first()) && Regex(&[&[c, b'*'][..], &p[2..]].concat()).here(&s[1..]),
            Some(b'?') => (one(s.first()) && Regex(&p[2..]).here(&s[1..])) || Regex(&p[2..]).here(s),
            _ => one(s.first()) && Regex(&p[1..]).here(&s[1..]),
        }
    }
}
