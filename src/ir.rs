use alloc::borrow::Cow;
use alloc::collections::BTreeMap;
use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;
use core::ops::{Index, IndexMut};

use mlirformat::{Attribute, Block, BlockArg, Error, Extended, FunctionType, IntoStatic, Item, MlirOpt, Module, NamedAttr, Operation, Reborrow, Region, ResultDef, Source, Str, Type, Value};

pub trait Id: Copy {
    fn seg(self) -> u32;
    fn index(self) -> u32;
}

macro_rules! ids {
    ($($(#[$m:meta])* $id:ident => $data:ident $(<$lt:lifetime>)?, $field:ident, $kind:ident;)*) => {$(
        $(#[$m])*
        #[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord, Hash)]
        pub struct $id(core::num::NonZeroU64);

        impl $id {
            #[inline]
            pub(crate) const fn at(seg: u32, index: u32) -> Self {
                match core::num::NonZeroU64::new(((seg as u64 + 1) << 32) | index as u64) {
                    Some(n) => Self(n),
                    None => unreachable!(),
                }
            }

            #[inline]
            #[allow(dead_code)]
            pub(crate) const fn raw(self) -> u64 {
                self.0.get()
            }

            #[inline]
            #[allow(dead_code)]
            pub(crate) const fn from_raw(raw: u64) -> Self {
                match core::num::NonZeroU64::new(raw) {
                    Some(n) => Self(n),
                    None => unreachable!(),
                }
            }
        }

        impl Id for $id {
            #[inline]
            fn seg(self) -> u32 {
                ((self.0.get() >> 32) - 1) as u32
            }

            #[inline]
            fn index(self) -> u32 {
                self.0.get() as u32
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
        #[derive(Debug, Clone, Copy, PartialEq, Eq)]
        enum Kind {
            $($kind),*
        }

        #[derive(Debug, Clone)]
        enum Saved<'a> {
            $($kind($id, $data $(<$lt>)?)),*
        }

        impl Saved<'_> {
            fn slot(&self) -> (Kind, u32, usize) {
                match self {
                    $(Saved::$kind(id, _) => (Kind::$kind, id.seg(), id.index() as usize)),*
                }
            }
        }

        impl Seg<'_> {
            fn len(&self, kind: Kind) -> usize {
                match kind {
                    $(Kind::$kind => self.$field.len()),*
                }
            }

            fn truncate(&mut self, kind: Kind, len: usize) {
                match kind {
                    $(Kind::$kind => self.$field.truncate(len)),*
                }
            }
        }

        impl<'a> Body<'a> {
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

#[derive(Debug, Clone, Copy)]
pub struct Offsets {
    pub from: u32,
    pub to: u32,
}

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
    OpData<'a> { operands, results, successors, regions, parent, prev, next }
    BlockData { args, first, last, parent }
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

impl<'a> Shift for Seg<'a> {
    fn shift(self, o: &Offsets) -> Self {
        Seg { ops: self.ops.shift(o), blocks: self.blocks.shift(o), regions: self.regions.shift(o), values: self.values.shift(o), mixed: self.mixed, root: self.root, ..Seg::default() }
    }
}

ids! {
    @saved
    Op => OpId, OpData<'a>, ops;
    Block => BlockId, BlockData, blocks;
    Region => RegionId, RegionData, regions;
    Value => ValueId, ValueData<'a>, values;
}

pub struct BlockOps<'b, 'a> {
    body: &'b Body<'a>,
    front: Option<OpId>,
    back: Option<OpId>,
    left: usize,
}

impl Iterator for BlockOps<'_, '_> {
    type Item = OpId;

    #[inline]
    fn next(&mut self) -> Option<OpId> {
        if self.left == 0 {
            return None;
        }
        let o = self.front?;
        self.left -= 1;
        self.front = self.body.links(o).next;
        Some(o)
    }

    #[inline]
    fn size_hint(&self) -> (usize, Option<usize>) {
        (self.left, Some(self.left))
    }
}

impl DoubleEndedIterator for BlockOps<'_, '_> {
    #[inline]
    fn next_back(&mut self) -> Option<OpId> {
        if self.left == 0 {
            return None;
        }
        let o = self.back?;
        self.left -= 1;
        self.back = self.body.links(o).prev;
        Some(o)
    }
}

impl ExactSizeIterator for BlockOps<'_, '_> {}

#[derive(Debug, Clone, Copy)]
pub struct Lent(Links);

const PARTS_PER_THREAD: usize = 4;

#[derive(Debug, Clone)]
pub struct IdVec<K, T> {
    base: u32,
    segs: Vec<Vec<T>>,
    fill: T,
    _k: core::marker::PhantomData<K>,
}

impl<K: Id, T: Clone + Default> Default for IdVec<K, T> {
    fn default() -> Self {
        Self::new(T::default())
    }
}

impl<K: Id, T: Clone> IdVec<K, T> {
    pub fn new(fill: T) -> Self {
        Self { base: 0, segs: Vec::new(), fill, _k: core::marker::PhantomData }
    }

    #[inline]
    pub fn get(&self, k: K) -> &T {
        self.segs.get(k.seg().wrapping_sub(self.base) as usize).and_then(|s| s.get(k.index() as usize)).unwrap_or(&self.fill)
    }

    pub fn get_mut(&mut self, k: K) -> &mut T {
        let fill = self.fill.clone();
        let (row, i) = (self.row(k.seg()), k.index() as usize);
        if row.len() <= i {
            row.resize(i + 1, fill);
        }
        &mut row[i]
    }

    fn row(&mut self, seg: u32) -> &mut Vec<T> {
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
        &mut self.segs[s]
    }

    pub fn push(&mut self, seg: u32, v: T) -> u32 {
        let row = self.row(seg);
        row.push(v);
        row.len() as u32 - 1
    }

    pub fn take_row(&mut self, seg: u32) -> Vec<T> {
        core::mem::take(self.row(seg))
    }

    pub fn put_row(&mut self, seg: u32, row: Vec<T>) {
        *self.row(seg) = row;
    }

    pub fn entries_mut(&mut self) -> impl Iterator<Item = &mut T> {
        self.segs.iter_mut().flatten()
    }

    #[inline]
    pub fn set(&mut self, k: K, v: T) {
        *self.get_mut(k) = v;
    }
}

#[derive(Debug, Clone)]
enum Undo<'a> {
    Saved(alloc::boxed::Box<Saved<'a>>),
    Link(OpId, Links),
    Ends(BlockId, Ends),
    Grew { seg: u32, kind: Kind, len: usize },
    Spliced { from: BlockId, to: BlockId, first: OpId, last: OpId, n: u32 },
}

#[derive(Debug, Clone, Default)]
pub struct Journal<'a> {
    undo: Vec<Undo<'a>>,
    depth: u32,
    epoch: u32,
    next_epoch: u32,
    outer_epoch: u32,
    clock: u32,
    mark: u32,
    outer_mark: u32,
}

impl PartialEq for Journal<'_> {
    fn eq(&self, _: &Self) -> bool {
        true
    }
}

#[derive(Debug)]
#[must_use = "a checkpoint is closed by rollback or release"]
pub struct Checkpoint {
    undo: usize,
    prev_epoch: u32,
    prev_mark: u32,
}

#[derive(Debug, Clone, Default)]
pub(crate) struct Seg<'a> {
    ops: Vec<OpData<'a>>,
    blocks: Vec<BlockData>,
    regions: Vec<RegionData>,
    values: Vec<ValueData<'a>>,
    mixed: bool,
    born: [Vec<u32>; 4],
    saved: [Vec<u32>; 4],
    outer: [Vec<u32>; 4],
    grown: [u32; 4],
    root: u32,
    away: Option<Links>,
}

impl PartialEq for Seg<'_> {
    fn eq(&self, o: &Self) -> bool {
        self.ops == o.ops && self.blocks == o.blocks && self.regions == o.regions && self.values == o.values
    }
}

pub type Ids<T> = smallvec::SmallVec<[T; 2]>;

const HOLE: u32 = u32::MAX;

#[derive(Debug, Clone, Default)]
pub struct Uses {
    slots: smallvec::SmallVec<[Use; 2]>,
    live: u32,
}

pub type UsesIter<'u> = core::iter::Filter<core::slice::Iter<'u, Use>, fn(&&Use) -> bool>;

impl Uses {
    pub fn new() -> Self {
        Self::default()
    }

    #[inline]
    pub fn len(&self) -> usize {
        self.live as usize
    }

    #[inline]
    pub fn is_empty(&self) -> bool {
        self.live == 0
    }

    #[inline]
    pub fn iter(&self) -> UsesIter<'_> {
        self.slots.iter().filter(|u| u.index != HOLE)
    }

    pub fn first(&self) -> Option<&Use> {
        self.iter().next()
    }

    pub fn single(&self) -> Option<Use> {
        (self.live == 1).then(|| self.first().copied()).flatten()
    }

    pub fn to_vec(&self) -> Vec<Use> {
        self.iter().copied().collect()
    }

    fn push(&mut self, u: Use) -> u32 {
        self.slots.push(u);
        self.live += 1;
        self.slots.len() as u32 - 1
    }

    fn remove(&mut self, hint: u32, u: Use) -> bool {
        let at = match self.slots.get(hint as usize) {
            Some(x) if *x == u => hint as usize,
            _ => match self.slots.iter().position(|x| *x == u) {
                Some(at) => at,
                None => return false,
            },
        };
        self.live -= 1;
        if self.live == 0 {
            self.slots.clear();
        } else {
            self.slots[at].index = HOLE;
        }
        true
    }

    fn sparse(&self) -> bool {
        self.slots.len() >= 8 && self.slots.len() > 2 * self.live as usize
    }
}

impl PartialEq for Uses {
    fn eq(&self, o: &Self) -> bool {
        self.live == o.live && self.iter().eq(o.iter())
    }
}

impl<'u> IntoIterator for &'u Uses {
    type Item = &'u Use;
    type IntoIter = UsesIter<'u>;

    fn into_iter(self) -> UsesIter<'u> {
        self.iter()
    }
}

impl IntoIterator for Uses {
    type Item = Use;
    type IntoIter = core::iter::Filter<smallvec::IntoIter<[Use; 2]>, fn(&Use) -> bool>;

    fn into_iter(self) -> Self::IntoIter {
        self.slots.into_iter().filter(|u| u.index != HOLE)
    }
}

impl Shift for Uses {
    fn shift(self, o: &Offsets) -> Self {
        Uses { slots: self.slots.shift(o), ..self }
    }
}

#[derive(Debug, Clone, Default)]
pub(crate) struct UseSlots(smallvec::SmallVec<[u32; 4]>);

impl PartialEq for UseSlots {
    fn eq(&self, _: &Self) -> bool {
        true
    }
}

#[derive(Debug, Clone, PartialEq)]
pub struct OpData<'a> {
    pub name: Str<'a>,
    pub operands: Ids<ValueId>,
    pub results: Ids<ValueId>,
    pub successors: Ids<BlockId>,
    pub properties: Vec<NamedAttr<'a>>,
    pub regions: Ids<RegionId>,
    pub attributes: Vec<NamedAttr<'a>>,
    pub loc: Option<Str<'a>>,
    pub parent: Option<BlockId>,
    pub defaults: bool,
    pub info: Option<&'a mlirformat::OpInfo>,
    pub(crate) prev: Option<OpId>,
    pub(crate) next: Option<OpId>,
    pub(crate) order: Order,
    pub(crate) slots: UseSlots,
}

#[derive(Debug, Default)]
pub(crate) struct Order(core::sync::atomic::AtomicU32);

impl Order {
    #[inline]
    fn get(&self) -> u32 {
        self.0.load(core::sync::atomic::Ordering::Relaxed)
    }

    #[inline]
    fn set(&self, v: u32) {
        self.0.store(v, core::sync::atomic::Ordering::Relaxed);
    }
}

impl Clone for Order {
    fn clone(&self) -> Self {
        Order(core::sync::atomic::AtomicU32::new(self.get()))
    }
}

impl PartialEq for Order {
    fn eq(&self, _: &Self) -> bool {
        true
    }
}

#[derive(Debug, Clone, Copy, PartialEq)]
pub(crate) struct Links {
    prev: Option<OpId>,
    next: Option<OpId>,
    parent: Option<BlockId>,
}

#[derive(Debug, Clone, Copy, PartialEq)]
struct Ends {
    first: Option<OpId>,
    last: Option<OpId>,
    len: u32,
}

#[derive(Debug, Clone, PartialEq, Default)]
pub struct BlockData {
    pub args: Ids<ValueId>,
    pub(crate) first: Option<OpId>,
    pub(crate) last: Option<OpId>,
    pub(crate) len: u32,
    pub(crate) ordered: Order,
    pub parent: Option<RegionId>,
}

#[derive(Debug, Clone, PartialEq)]
pub struct RegionData {
    pub blocks: Ids<BlockId>,
    pub parent: OpId,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Def {
    Result(OpId, u32),
    Arg(BlockId, u32),
}

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
    pub loc: Option<Str<'a>>,
}

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

impl PartialEq for Ctx<'_> {
    fn eq(&self, _: &Self) -> bool {
        true
    }
}

#[derive(Debug, Clone, PartialEq)]
pub struct Body<'a> {
    pub ctx: Ctx<'a>,
    segs: Vec<Seg<'a>>,
    seg0: u32,
    pub(crate) home: u32,
    pub root: OpId,
    pub items: Vec<mlirformat::Item<'a>>,
    journal: Journal<'a>,
    outside: Option<Outside<'a>>,
    pub(crate) diagnostics: Vec<crate::Diagnostic<'a>>,
    pub(crate) symbols: SymbolIndex,
}

#[derive(Debug, Clone, Default)]
pub(crate) struct SymbolIndex {
    pub(crate) table: Option<OpId>,
    pub(crate) names: BTreeMap<String, OpId>,
}

impl PartialEq for SymbolIndex {
    fn eq(&self, _: &Self) -> bool {
        true
    }
}

#[derive(Debug)]
pub(crate) struct Outside<'a> {
    symbols: alloc::sync::Arc<BTreeMap<String, OpData<'a>>>,
    made: Vec<OpId>,
    escaped: core::sync::atomic::AtomicBool,
}

impl Clone for Outside<'_> {
    fn clone(&self) -> Self {
        Outside { symbols: self.symbols.clone(), made: self.made.clone(), escaped: core::sync::atomic::AtomicBool::new(self.escaped.load(core::sync::atomic::Ordering::Relaxed)) }
    }
}

impl PartialEq for Outside<'_> {
    fn eq(&self, _: &Self) -> bool {
        true
    }
}

impl<'a> Body<'a> {
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
    pub fn top_block(&self, op: OpId) -> BlockId {
        self[self[op].regions[0]].blocks[0]
    }

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

    pub fn rollback(&mut self, cp: Checkpoint) {
        while self.journal.undo.len() > cp.undo {
            match self.journal.undo.pop().expect("longer than the mark") {
                Undo::Saved(saved) => self.restore(*saved),
                Undo::Link(op, l) => {
                    if let Some(b) = l.parent {
                        self[b].ordered.set(0);
                    }
                    self.raw_links(op, l);
                }
                Undo::Ends(b, e) => {
                    self[b].ordered.set(0);
                    self.raw_ends(b, e);
                }
                Undo::Grew { seg, kind, len } => self.seg_mut(seg).truncate(kind, len),
                Undo::Spliced { from, to, first, last, n } => {
                    self[from].ordered.set(0);
                    self[to].ordered.set(0);
                    self.move_run(to, first, last, n, from, None);
                }
            }
        }
        self.close(&cp);
    }

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

    fn existed(&self, kind: Kind, s: u32, i: usize, mark: u32) -> bool {
        self.seg(s).born[kind as usize].get(i).is_none_or(|b| *b < mark)
    }

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

    pub(crate) fn holds(&self, op: OpId) -> bool {
        self.segs.get(op.seg().wrapping_sub(self.seg0) as usize).is_some_and(|s| (op.index() as usize) < s.ops.len())
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

    #[inline]
    fn raw_links(&mut self, op: OpId, l: Links) {
        let d = &mut self.seg_mut(op.seg()).ops[op.index() as usize];
        (d.prev, d.next, d.parent) = (l.prev, l.next, l.parent);
    }

    #[inline]
    fn raw_ends(&mut self, b: BlockId, e: Ends) {
        let d = &mut self.seg_mut(b.seg()).blocks[b.index() as usize];
        (d.first, d.last, d.len) = (e.first, e.last, e.len);
    }

    #[inline]
    fn links(&self, op: OpId) -> Links {
        let s = self.seg(op.seg());
        match s.ops.get(op.index() as usize) {
            Some(d) => Links { prev: d.prev, next: d.next, parent: d.parent },
            None => s.away.expect("an op of this body"),
        }
    }

    fn ends(&self, b: BlockId) -> Ends {
        let d = &self[b];
        Ends { first: d.first, last: d.last, len: d.len }
    }

    fn set_links(&mut self, op: OpId, l: Links) {
        if self.journal.depth > 0 && self.existed(Kind::Op, op.seg(), op.index() as usize, self.journal.mark) {
            let old = self.links(op);
            self.journal.undo.push(Undo::Link(op, old));
        }
        self.raw_links(op, l);
    }

    fn set_ends(&mut self, b: BlockId, e: Ends) {
        if self.logs(b) {
            let old = self.ends(b);
            self.journal.undo.push(Undo::Ends(b, old));
        }
        self.raw_ends(b, e);
    }

    pub(crate) fn seg_root(&self, op: OpId) -> bool {
        op.seg() != self.root.seg() && self.segs.get(op.seg().wrapping_sub(self.seg0) as usize).is_some_and(|s| s.root == op.index() && !s.ops.is_empty())
    }

    fn link(&mut self, a: u32, b: u32) {
        if a != b {
            for s in [a, b] {
                if let Some(seg) = self.segs.get_mut(s.wrapping_sub(self.seg0) as usize) {
                    seg.mixed = true;
                }
            }
        }
    }

    pub(crate) fn new_seg(&mut self, seg: Seg<'a>) -> u32 {
        self.segs.push(seg);
        self.seg0 + self.segs.len() as u32 - 1
    }

    pub fn clear_locs_in<X: moremath::Executor + Sync>(&mut self, x: &X) {
        debug_assert_eq!(self.journal.depth, 0, "locations cleared under a checkpoint");
        let step = self.segs.len().div_ceil(x.threads() * 4).max(1);
        let tasks: Vec<_> = self
            .segs
            .chunks_mut(step)
            .map(|segs| {
                move || {
                    for s in segs {
                        s.ops.iter_mut().for_each(|o| o.loc = None);
                        s.values.iter_mut().for_each(|v| v.loc = None);
                    }
                }
            })
            .collect();
        x.execute(tasks);
    }

    fn names_apart(&self, op: OpId) -> bool {
        self.seg_root(op) && !self.seg(op.seg()).mixed && self[op].results.is_empty()
    }

    pub fn ops_count(&self) -> usize {
        self.segs.iter().map(|s| s.ops.len()).sum()
    }

    pub fn lendable(&self, op: OpId) -> bool {
        self.seg_root(op)
            && !self.seg(op.seg()).mixed
            && self[op].operands.is_empty()
            && self[op].results.iter().all(|r| self[*r].uses.is_empty())
    }

    pub fn lend(&mut self, op: OpId) -> Option<(Body<'a>, Lent)> {
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
        let (s, parent) = (op.seg(), Lent(self.links(op)));
        let seg = self.take_seg(s);
        self.seg_mut(s).away = Some(parent.0);
        let mut sub = Body { ctx: self.ctx, segs: alloc::vec![Seg::default(), seg], seg0: s - 1, home: s - 1, root: OpId::at(s - 1, 0), items: Vec::new(), journal: Journal::default(), outside: None, diagnostics: Vec::new(), symbols: SymbolIndex::default() };
        let root = sub.create(OpData::named("builtin.module"), &[]);
        sub.root = root;
        for n in attrs {
            sub[root].set(&n.name, n.value.unwrap_or(Attribute::Unit));
        }
        let region = sub.add_region(root);
        let block = sub.add_block(region, &[]);
        sub.raw_links(op, Links { prev: None, next: None, parent: None });
        sub.insert(op, block, None);
        sub.home = s;
        Some((sub, parent))
    }

    pub fn unlend(&mut self, op: OpId, mut sub: Body<'a>, at: Lent) {
        debug_assert_eq!(sub.segs.len(), 2, "a lent body makes no seg");
        let seg = sub.segs.pop().expect("the lent seg");
        self.put_seg(op.seg(), seg);
        self.diagnostics.append(&mut sub.diagnostics);
        self.raw_links(op, at.0);
        if let Some(b) = at.0.parent {
            self[b].ordered.set(0);
        }
    }

    pub fn outside_symbol(&self, table: OpId, name: &str) -> Option<&OpData<'a>> {
        self.outside.as_ref().filter(|_| table == self.root)?.symbols.get(name)
    }

    pub fn is_lent(&self) -> bool {
        self.outside.is_some()
    }

    pub fn escape(&self) {
        if let Some(o) = &self.outside {
            o.escaped.store(true, core::sync::atomic::Ordering::Relaxed);
        }
    }

    pub fn declared(&mut self, decl: OpId) {
        if let Some(o) = &mut self.outside {
            o.made.push(decl);
        }
    }

    fn symbols_in(&self, op: OpId) -> BTreeMap<String, OpData<'a>> {
        let mut out = BTreeMap::new();
        for o in self.children(op) {
            if let Some(name) = self.sym_name(o) {
                out.entry(String::from(name)).or_insert_with(|| OpData { regions: crate::Ids::new(), operands: crate::Ids::new(), results: crate::Ids::new(), successors: crate::Ids::new(), parent: None, ..self[o].clone() });
            }
        }
        out
    }

    fn returnable(sub: &Body<'a>, declared: &mut BTreeMap<String, Option<Attribute<'a>>>) -> bool {
        let Some(o) = &sub.outside else { return false };
        if o.escaped.load(core::sync::atomic::Ordering::Relaxed) {
            return false;
        }
        let top = sub.top_block(sub.root);
        if sub.ops(top).filter(|x| !o.made.contains(x)).count() != 1 {
            return false;
        }
        let made: Vec<(String, Option<Attribute<'a>>)> = o.made.iter().filter_map(|d| Some((String::from(sub.sym_name(*d)?), sub[*d].get("function_type").cloned()))).collect();
        if made.iter().any(|(n, t)| declared.get(n).is_some_and(|have| have != t)) {
            return false;
        }
        for (n, t) in made {
            declared.entry(n).or_insert(t);
        }
        true
    }

    fn take_back(&mut self, op: OpId, mut sub: Body<'a>, parent: Lent) -> (OpId, Vec<OpId>) {
        let top = sub.top_block(sub.root);
        let made = sub.outside.as_ref().map(|o| o.made.clone()).unwrap_or_default();
        let new = sub.ops(top).find(|x| !made.contains(x)).expect("the function");
        if new != op {
            sub.raw_links(new, Links { prev: None, next: None, parent: None });
        }
        self.unlend(op, sub, parent);
        (new, made)
    }

    fn put_back(&mut self, op: OpId, new: OpId) {
        if new != op {
            self.seg_mut(new.seg()).root = new.index();
            self.swap_in(op, new);
        }
    }

    fn merge_declared(&mut self, table: OpId, made: Vec<OpId>) {
        let block = self.top_block(table);
        for d in made {
            let have = self.sym_name(d).and_then(|n| self.find_symbol(table, n)).is_some_and(|e| self[e].name == "llvm.func");
            if have {
                continue;
            }
            let data = OpData { regions: crate::Ids::new(), operands: crate::Ids::new(), results: crate::Ids::new(), successors: crate::Ids::new(), parent: None, ..self[d].clone() };
            let home = core::mem::replace(&mut self.home, table.seg());
            let n = self.push_op(data, &[]);
            self.add_region(n);
            self.home = home;
            self.insert(n, block, Some(0));
        }
    }

    pub fn map_ops_in<X: moremath::Executor + Sync, T: Send>(&self, op: OpId, exec: &X, f: &(dyn Fn(&Self, &[OpId]) -> T + Sync)) -> Vec<T> {
        let ops: Vec<OpId> = self[op].regions.iter().flat_map(|r| self[*r].blocks.iter()).flat_map(|b| self.ops(*b)).collect();
        let chunk = ops.len().div_ceil(moremath::Executor::threads(exec).max(1) * PARTS_PER_THREAD).max(1);
        let mut found: Vec<Option<T>> = ops.chunks(chunk).map(|_| None).collect();
        let tasks = found
            .iter_mut()
            .zip(ops.chunks(chunk))
            .map(|(slot, part)| alloc::boxed::Box::new(move || *slot = Some(f(self, part))) as crate::Task<'_>)
            .collect();
        moremath::Executor::execute(exec, tasks);
        found.into_iter().map(|t| t.expect("every task ran")).collect()
    }

    pub fn for_each_child<X: moremath::Executor + Sync>(&mut self, op: OpId, exec: &X, f: &(dyn Fn(&mut Body<'a>, OpId) + Sync)) -> Vec<OpId> {
        let children = self.children(op);
        if moremath::Executor::threads(exec) < 2 || self.journal.depth > 0 || children.iter().filter(|c| self.lendable(**c)).count() < 2 {
            return Vec::new();
        }
        let lent: Vec<(OpId, Body<'a>, Lent)> = children.iter().filter_map(|c| self.lend(*c).map(|(sub, parent)| (*c, sub, parent))).collect();
        let mut done: Vec<Option<(OpId, Body<'a>, Lent)>> = lent.iter().map(|_| None).collect();
        let tasks = done
            .iter_mut()
            .zip(lent)
            .map(|(slot, (c, mut sub, parent))| {
                alloc::boxed::Box::new(move || {
                    f(&mut sub, c);
                    *slot = Some((c, sub, parent));
                }) as crate::Task<'_>
            })
            .collect();
        moremath::Executor::execute(exec, tasks);
        let mut ran = Vec::with_capacity(done.len());
        for (c, sub, parent) in done.into_iter().map(|d| d.expect("every task ran")) {
            debug_assert!(sub.ops(sub.top_block(sub.root)).eq([c]), "a lent op's work stays in it");
            self.unlend(c, sub, parent);
            ran.push(c);
        }
        ran
    }

    pub fn run_local<X: moremath::Executor + Sync>(&mut self, op: OpId, exec: &X, f: &crate::LocalRun<'_>) -> Result<(), Error> {
        let children = self.children(op);
        if moremath::Executor::threads(exec) < 2 || self.journal.depth > 0 || children.iter().filter(|c| self.lendable(**c)).count() < 2 {
            return f(self, op);
        }
        let symbols = alloc::sync::Arc::new(self.symbols_in(op));
        let lent: Vec<_> = children
            .iter()
            .map(|c| {
                self.lend(*c).map(|(mut sub, parent)| {
                    sub.outside = Some(Outside { symbols: symbols.clone(), made: Vec::new(), escaped: core::sync::atomic::AtomicBool::new(false) });
                    (sub, parent)
                })
            })
            .collect();
        type Ran<'a> = (Result<(), Error>, Body<'a>, Lent, Checkpoint);
        let mut done: Vec<Option<Ran<'a>>> = lent.iter().map(|_| None).collect();
        let tasks = done
            .iter_mut()
            .zip(children.iter().zip(lent))
            .filter_map(|(slot, (c, lent))| lent.map(|l| (slot, *c, l)))
            .map(|(slot, c, (mut sub, parent))| {
                alloc::boxed::Box::new(move || {
                    let cp = sub.checkpoint();
                    let r = f(&mut sub, c);
                    *slot = Some((r, sub, parent, cp));
                }) as crate::Task<'_>
            })
            .collect();
        moremath::Executor::execute(exec, tasks);
        let mut declared: BTreeMap<String, Option<Attribute<'a>>> = symbols.iter().filter(|(_, d)| d.name == "llvm.func").map(|(n, d)| (n.clone(), d.get("function_type").cloned())).collect();
        let decided: Vec<Option<(Result<(), Error>, Body<'a>, Lent, Checkpoint, bool)>> = done
            .into_iter()
            .map(|d| {
                d.map(|(r, sub, parent, cp)| {
                    let keep = Self::returnable(&sub, &mut declared);
                    (r, sub, parent, cp, keep)
                })
            })
            .collect();
        let closing: Vec<_> = decided
            .into_iter()
            .map(|d| {
                move || {
                    d.map(|(r, mut sub, parent, cp, keep)| {
                        if keep { sub.release(cp) } else { sub.rollback(cp) }
                        (r, sub, parent, keep)
                    })
                }
            })
            .collect();
        let back: Vec<Option<(Result<(), Error>, Body<'a>, Lent, bool)>> = moremath::Executor::execute(exec, closing);
        let mut kept: Vec<Option<(Result<(), Error>, (OpId, Vec<OpId>))>> = Vec::with_capacity(back.len());
        for (k, b) in back.into_iter().enumerate() {
            kept.push(match b {
                Some((r, sub, parent, true)) => Some((r, self.take_back(children[k], sub, parent))),
                Some((_, sub, parent, false)) => {
                    self.unlend(children[k], sub, parent);
                    None
                }
                None => None,
            });
        }
        for (k, c) in children.iter().enumerate() {
            if let Some((_, (new, _))) = &kept[k] {
                self.put_back(*c, *new);
            }
        }
        let mut first = None;
        for (k, c) in children.iter().enumerate() {
            let r = match kept[k].take() {
                Some((r, (_, made))) => {
                    self.merge_declared(op, made);
                    r
                }
                None => f(self, *c),
            };
            if first.is_none() {
                first = r.err();
            }
        }
        first.map_or(Ok(()), Err)
    }

    fn take_seg(&mut self, s: u32) -> Seg<'a> {
        core::mem::take(self.seg_mut(s))
    }

    fn put_seg(&mut self, s: u32, seg: Seg<'a>) {
        *self.seg_mut(s) = seg;
    }
}

impl From<ValueId> for Value<'_> {
    fn from(v: ValueId) -> Self {
        Value { name: Str::Owned(alloc::format!("{}", v.raw())), index: None }
    }
}

pub trait TypedOp {
    fn split<'a>(&self) -> (OpData<'a>, Vec<Type<'a>>);
}

impl<O> TypedOp for O
where
    for<'o> Operation<'static>: TryFrom<&'o O, Error = Error>,
{
    fn split<'a>(&self) -> (OpData<'a>, Vec<Type<'a>>) {
        OpData::of(self).unwrap_or_else(|e| panic!("{e}"))
    }
}

impl<'a> OpData<'a> {
    pub fn successors(mut self, s: &[BlockId]) -> Self {
        self.successors = s.to_vec().into();
        self
    }

    pub fn segments(self, sizes: &[usize]) -> Self {
        self.with("operandSegmentSizes", Attribute::dense_i32(sizes))
    }
}

impl Body<'_> {
    pub fn is_ranked_memref(&self, v: ValueId) -> bool {
        matches!(&self[v].ty, Type::Shaped(s) if s.kind == mlirformat::ShapedKind::MemRef && s.shape.is_some())
    }

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

    pub fn const_index(&self, v: ValueId) -> Option<i64> {
        let c = crate::Const::try_from(&self.constant_of(v)?).ok().filter(|c| !c.elements)?;
        Some(c.as_int()?.signed() as i64)
    }
}

impl<'a> OpData<'a> {
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
    pub fn named(name: impl Into<Str<'a>>) -> Self {
        Self { name: name.into(), operands: crate::Ids::new(), results: crate::Ids::new(), successors: crate::Ids::new(), properties: Vec::new(), regions: crate::Ids::new(), attributes: Vec::new(), loc: None, parent: None, defaults: false, info: None, prev: None, next: None, order: Order::default(), slots: UseSlots::default() }
    }

    fn dict(&self, inherent: bool) -> &[NamedAttr<'a>] {
        if inherent { &self.properties } else { &self.attributes }
    }

    fn dict_mut(&mut self, inherent: bool) -> &mut Vec<NamedAttr<'a>> {
        if inherent { &mut self.properties } else { &mut self.attributes }
    }

    pub fn all_attrs(&self) -> Vec<NamedAttr<'a>> {
        let mut out = self.properties.clone();
        out.extend(self.attributes.iter().cloned());
        out.sort_by(|a, b| a.name.cmp(&b.name));
        out
    }

    #[inline]
    pub fn gpu_kernel(&self) -> bool {
        self.get("kernel").is_some() || self.get("gpu.kernel").is_some()
    }

    pub fn get<'s>(&'s self, name: &str) -> Option<&'s Attribute<'a>> {
        let find = |d: &'s [NamedAttr<'a>]| d.iter().find(|a| a.name == name);
        let a = find(self.dict(true)).or_else(|| find(self.dict(false)))?;
        Some(a.value.as_ref().unwrap_or(&Attribute::Unit))
    }

    pub fn set(&mut self, name: &str, value: Attribute<'a>) {
        let inherent = self.dict(true).iter().any(|a| a.name == name);
        let d = self.dict_mut(inherent);
        let value = (value != Attribute::Unit).then_some(value);
        let named = NamedAttr { name: alloc::string::String::from(name).into(), value };
        match d.binary_search_by(|a| (*a.name).cmp(name)) {
            Ok(i) => d[i] = named,
            Err(i) => d.insert(i, named),
        }
    }

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

    pub fn get_str(&self, name: &str) -> Option<&str> {
        match self.get(name)? {
            Attribute::Str { lit, .. } => Some(lit),
            _ => None,
        }
    }
}

impl<'a> Body<'a> {
    pub fn new(ctx: Ctx<'a>) -> Self {
        let mut body = Self { ctx, segs: alloc::vec![Seg::default()], seg0: 0, home: 0, root: OpId::at(0, 0), journal: Journal::default(), items: Vec::new(), outside: None, diagnostics: Vec::new(), symbols: SymbolIndex::default() };
        body.root = body.create(OpData::named("builtin.module"), &[]);
        let region = body.add_region(body.root);
        body.add_block(region, &[]);
        body
    }

    pub fn create(&mut self, data: OpData<'a>, types: &[Type<'a>]) -> OpId {
        self.adopt(data, types.iter().cloned())
    }

    pub fn create_for(&mut self, block: BlockId, data: OpData<'a>, types: &[Type<'a>]) -> OpId {
        if self[block].parent.is_some_and(|r| self[r].parent == self.root) {
            return self.create(data, types);
        }
        let home = core::mem::replace(&mut self.home, block.seg());
        let op = self.create(data, types);
        self.home = home;
        op
    }

    pub fn adopt(&mut self, mut data: OpData<'a>, types: impl IntoIterator<Item = Type<'a>>) -> OpId {
        if data.defaults {
            for a in self.ctx.opt.defaults(&data.name) {
                if data.get(&a.name).is_none() {
                    data.set(&a.name, a.value.unwrap_or(Attribute::Unit));
                }
            }
            data.defaults = false;
        }
        data.info = self.ctx.opt.op_info(&data.name);
        self.place(&mut data);
        self.push_known(data, types)
    }

    pub fn push_op(&mut self, mut data: OpData<'a>, types: &[Type<'a>]) -> OpId {
        data.info = self.ctx.opt.op_info(&data.name);
        self.push_known(data, types.iter().cloned())
    }

    fn push_known(&mut self, data: OpData<'a>, types: impl IntoIterator<Item = Type<'a>>) -> OpId {
        let s = self.home;
        let id = OpId::at(s, self.grow(Kind::Op, s));
        let mut slots = UseSlots::default();
        for (index, v) in data.operands.iter().enumerate() {
            self.link(s, v.seg());
            slots.0.push(self[*v].uses.push(Use { op: id, index: index as u32 }));
        }
        self.seg_mut(s).ops.push(OpData { results: crate::Ids::new(), parent: None, prev: None, next: None, order: Order::default(), slots, ..data });
        let results = types.into_iter().enumerate().map(|(i, ty)| self.value(ty, Def::Result(id, i as u32), None)).collect();
        self[id].results = results;
        id
    }

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

    pub fn swap_in(&mut self, old: OpId, new: OpId) {
        self.insert_before(new, old);
        self.detach(old);
    }

    pub fn emit(&mut self, op: &impl TypedOp) -> OpId {
        let (data, types) = op.split();
        self.create(data, &types)
    }

    fn segment_sizes(info: &crate::OpInfo, name: &str) -> bool {
        match name {
            "operandSegmentSizes" => info.traits.contains(&crate::Trait::AttrSizedOperandSegments),
            "resultSegmentSizes" => info.traits.contains(&crate::Trait::AttrSizedResultSegments),
            _ => false,
        }
    }

    pub fn inherent(&self, op_name: &str, name: &str) -> Option<bool> {
        let info = self.ctx.opt.op_info(op_name)?;
        Some(info.inherent.contains(&name) || Self::segment_sizes(info, name))
    }

    pub fn place(&self, data: &mut OpData<'a>) {
        let Some(info) = data.info.or_else(|| self.ctx.opt.op_info(&data.name)) else { return };
        let inherent = |a: &NamedAttr<'_>| info.inherent.contains(&&*a.name) || Self::segment_sizes(info, &a.name);
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

    pub fn placed<'s>(&self, data: &'s OpData<'a>) -> (Option<Attribute<'s>>, Vec<NamedAttr<'s>>) {
        let dict = |props: Vec<NamedAttr<'s>>| (!props.is_empty()).then_some(Attribute::Dict(props));
        let Some(info) = data.info.or_else(|| self.ctx.opt.op_info(&data.name)) else {
            return (dict(data.properties.reborrow()), data.attributes.reborrow());
        };
        let mut all: Vec<&NamedAttr<'a>> = data.properties.iter().collect();
        all.extend(&data.attributes);
        all.sort_by(|a, b| a.name.cmp(&b.name));
        let (props, attrs): (Vec<_>, Vec<_>) = all.into_iter().map(|a| a.reborrow()).partition(|a| info.inherent.contains(&&*a.name) || Self::segment_sizes(info, &a.name));
        (dict(props), attrs)
    }

    pub fn discardable(&self, op: OpId) -> Vec<NamedAttr<'a>> {
        let mut d = self[op].clone();
        self.place(&mut d);
        d.attributes
    }

    fn value(&mut self, ty: Type<'a>, def: Def, loc: Option<Str<'a>>) -> ValueId {
        let s = match def {
            Def::Result(op, _) => op.seg(),
            Def::Arg(b, _) => b.seg(),
        };
        let id = ValueId::at(s, self.grow(Kind::Value, s));
        self.seg_mut(s).values.push(ValueData { ty, def, uses: Uses::default(), loc });
        id
    }

    pub fn add_region(&mut self, op: OpId) -> RegionId {
        let s = op.seg();
        let id = RegionId::at(s, self.grow(Kind::Region, s));
        self.seg_mut(s).regions.push(RegionData { blocks: crate::Ids::new(), parent: op });
        self[op].regions.push(id);
        id
    }

    pub fn add_block(&mut self, region: RegionId, args: &[(Type<'a>, Option<Str<'a>>)]) -> BlockId {
        self.add_block_with(region, args.iter().cloned())
    }

    pub fn add_block_with(&mut self, region: RegionId, args: impl IntoIterator<Item = (Type<'a>, Option<Str<'a>>)>) -> BlockId {
        let s = region.seg();
        let id = BlockId::at(s, self.grow(Kind::Block, s));
        self.seg_mut(s).blocks.push(BlockData { parent: Some(region), ..BlockData::default() });
        let args = args.into_iter().enumerate().map(|(i, (ty, loc))| self.value(ty, Def::Arg(id, i as u32), loc)).collect();
        self[id].args = args;
        self[region].blocks.push(id);
        id
    }

    pub fn add_arg(&mut self, block: BlockId, ty: Type<'a>) -> ValueId {
        let v = self.value(ty, Def::Arg(block, self[block].args.len() as u32), None);
        self[block].args.push(v);
        v
    }

    pub fn insert_arg(&mut self, block: BlockId, at: usize, ty: Type<'a>, loc: Option<Str<'a>>) -> ValueId {
        let v = self.value(ty, Def::Arg(block, at as u32), loc);
        self[block].args.insert(at, v);
        for (i, a) in self[block].args.clone().into_iter().enumerate().skip(at + 1) {
            self[a].def = Def::Arg(block, i as u32);
        }
        v
    }

    fn logs(&self, block: BlockId) -> bool {
        self.journal.depth > 0 && self.existed(Kind::Block, block.seg(), block.index() as usize, self.journal.mark)
    }

    #[inline]
    fn linked(&mut self, op: OpId, block: BlockId) {
        if op.seg() != block.seg() && !self.seg_root(op) {
            self.link(op.seg(), block.seg());
        }
    }

    pub fn insert(&mut self, op: OpId, block: BlockId, at: Option<usize>) {
        let before = match at {
            None => None,
            Some(k) => self.ops(block).nth(k),
        };
        self.link_in(op, block, before);
    }

    fn link_in(&mut self, op: OpId, block: BlockId, before: Option<OpId>) {
        debug_assert!(self[op].parent.is_none(), "op is already placed");
        let ends = self.ends(block);
        let prev = match before {
            Some(b) => self.links(b).prev,
            None => ends.last,
        };
        self.set_links(op, Links { prev, next: before, parent: Some(block) });
        let mut e = Ends { len: ends.len + 1, ..ends };
        match prev {
            Some(p) => self.set_links(p, Links { next: Some(op), ..self.links(p) }),
            None => e.first = Some(op),
        }
        match before {
            Some(n) => self.set_links(n, Links { prev: Some(op), ..self.links(n) }),
            None => e.last = Some(op),
        }
        self.set_ends(block, e);
        self.linked(op, block);
        if self[block].ordered.get() != 0 {
            let lo = prev.map_or(0, |p| u64::from(self[p].order.get()));
            let hi = before.map_or(u64::from(u32::MAX), |n| u64::from(self[n].order.get()));
            if hi > lo + 1 {
                self[op].order.set(((lo + hi) / 2) as u32);
            } else {
                self[block].ordered.set(0);
            }
        }
    }

    pub fn detach(&mut self, op: OpId) {
        let l = self.links(op);
        let Some(block) = l.parent else { return };
        let ends = self.ends(block);
        let mut e = Ends { len: ends.len - 1, ..ends };
        match l.prev {
            Some(p) => self.set_links(p, Links { next: l.next, ..self.links(p) }),
            None => e.first = l.next,
        }
        match l.next {
            Some(n) => self.set_links(n, Links { prev: l.prev, ..self.links(n) }),
            None => e.last = l.prev,
        }
        self.set_ends(block, e);
        self.set_links(op, Links { prev: None, next: None, parent: None });
    }

    pub fn splice(&mut self, from: BlockId, start: Option<OpId>, to: BlockId, before: Option<OpId>) -> Vec<OpId> {
        debug_assert_ne!(from, to, "splice within one block");
        let Some(first) = start.or(self[from].first) else { return Vec::new() };
        let last = self[from].last.expect("a block with a first op has a last");
        let mut moved = Vec::new();
        let mut at = Some(first);
        while let Some(o) = at {
            moved.push(o);
            at = self[o].next;
        }
        let n = moved.len() as u32;
        if self.logs(from) || self.logs(to) {
            self.journal.undo.push(Undo::Spliced { from, to, first, last, n });
        }
        self[to].ordered.set(0);
        self.move_run(from, first, last, n, to, before);
        for &o in &moved {
            self.linked(o, to);
        }
        moved
    }

    fn move_run(&mut self, from: BlockId, first: OpId, last: OpId, n: u32, to: BlockId, before: Option<OpId>) {
        let (fl, ll) = (self.links(first), self.links(last));
        let mut e = self.ends(from);
        e.len -= n;
        match fl.prev {
            Some(p) => self.raw_links(p, Links { next: ll.next, ..self.links(p) }),
            None => e.first = ll.next,
        }
        match ll.next {
            Some(x) => self.raw_links(x, Links { prev: fl.prev, ..self.links(x) }),
            None => e.last = fl.prev,
        }
        self.raw_ends(from, e);
        let mut t = self.ends(to);
        let prev = match before {
            Some(b) => self.links(b).prev,
            None => t.last,
        };
        match prev {
            Some(p) => self.raw_links(p, Links { next: Some(first), ..self.links(p) }),
            None => t.first = Some(first),
        }
        match before {
            Some(b) => self.raw_links(b, Links { prev: Some(last), ..self.links(b) }),
            None => t.last = Some(last),
        }
        t.len += n;
        self.raw_ends(to, t);
        self.raw_links(first, Links { prev, ..self.links(first) });
        self.raw_links(last, Links { next: before, ..self.links(last) });
        let mut at = Some(first);
        while let Some(o) = at {
            self.raw_links(o, Links { parent: Some(to), ..self.links(o) });
            at = if o == last { None } else { self.links(o).next };
        }
    }

    pub fn detach_all(&mut self, ops: &[OpId]) {
        ops.iter().for_each(|o| self.detach(*o));
    }

    pub fn insert_before(&mut self, op: OpId, before: OpId) {
        let block = self[before].parent.expect("anchor is not placed");
        self.link_in(op, block, Some(before));
    }

    pub fn put(&mut self, op: OpId, at: crate::InsertPoint) {
        match at.before {
            Some(b) => self.insert_before(op, b),
            None => self.insert(op, at.block, None),
        }
    }

    pub fn insert_after(&mut self, op: OpId, after: OpId) {
        let block = self[after].parent.expect("anchor is not placed");
        let next = self.links(after).next;
        self.link_in(op, block, next);
    }

    pub fn position(&self, op: OpId) -> usize {
        debug_assert!(self[op].parent.is_some(), "op is not placed");
        let mut n = 0;
        let mut at = self.links(op).prev;
        while let Some(p) = at {
            n += 1;
            at = self.links(p).prev;
        }
        n
    }

    pub fn is_before(&self, a: OpId, b: OpId) -> bool {
        let block = self[a].parent.expect("op is not placed");
        debug_assert_eq!(self[b].parent, Some(block), "ops of one block");
        if self[block].ordered.get() == 0 {
            self.renumber(block);
        }
        self[a].order.get() < self[b].order.get()
    }

    fn renumber(&self, block: BlockId) {
        let gap = (u32::MAX / (self[block].len + 2)).clamp(1, 1 << 16);
        for (i, o) in self.ops(block).enumerate() {
            if let Some(d) = self.seg(o.seg()).ops.get(o.index() as usize) {
                d.order.set(gap * (i as u32 + 1));
            }
        }
        self[block].ordered.set(1);
    }

    pub fn ops(&self, block: BlockId) -> BlockOps<'_, 'a> {
        let d = &self[block];
        BlockOps { body: self, front: d.first, back: d.last, left: d.len as usize }
    }

    pub fn block_ops(&self, block: BlockId) -> Vec<OpId> {
        self.ops(block).collect()
    }

    pub fn len_ops(&self, block: BlockId) -> usize {
        self[block].len as usize
    }

    pub fn first_op(&self, block: BlockId) -> Option<OpId> {
        self[block].first
    }

    pub fn last_op(&self, block: BlockId) -> Option<OpId> {
        self[block].last
    }

    pub fn next_op(&self, op: OpId) -> Option<OpId> {
        self.links(op).next
    }

    pub fn prev_op(&self, op: OpId) -> Option<OpId> {
        self.links(op).prev
    }

    pub fn set_operand(&mut self, op: OpId, index: usize, v: ValueId) {
        let old = self[op].operands[index];
        self.drop_use(old, Use { op, index: index as u32 });
        self.link(op.seg(), v.seg());
        self[op].operands[index] = v;
        self.add_use(v, Use { op, index: index as u32 });
    }

    pub fn set_operands(&mut self, op: OpId, operands: impl Into<Ids<ValueId>>) {
        let operands = operands.into();
        self.drop_uses(op);
        self[op].slots.0.clear();
        for (index, v) in operands.iter().enumerate() {
            self.link(op.seg(), v.seg());
            self.add_use(*v, Use { op, index: index as u32 });
        }
        self[op].operands = operands;
    }

    fn drop_uses(&mut self, op: OpId) {
        for (index, v) in self[op].operands.clone().into_iter().enumerate() {
            self.drop_use(v, Use { op, index: index as u32 });
        }
    }

    fn add_use(&mut self, v: ValueId, u: Use) {
        let slot = self[v].uses.push(u);
        self.set_slot(u, slot);
    }

    fn set_slot(&mut self, u: Use, slot: u32) {
        let slots = &mut self[u.op].slots.0;
        let i = u.index as usize;
        if slots.len() <= i {
            slots.resize(i + 1, HOLE);
        }
        slots[i] = slot;
    }

    fn drop_use(&mut self, v: ValueId, u: Use) {
        let hint = self[u.op].slots.0.get(u.index as usize).copied().unwrap_or(HOLE);
        let uses = &mut self[v].uses;
        if uses.remove(hint, u) && uses.sparse() {
            self.squeeze(v);
        }
    }

    fn squeeze(&mut self, v: ValueId) {
        let uses = core::mem::take(&mut self[v].uses);
        let live = uses.live;
        let slots: smallvec::SmallVec<[Use; 2]> = uses.into_iter().collect();
        for (k, u) in slots.iter().enumerate() {
            self.set_slot(*u, k as u32);
        }
        self[v].uses = Uses { slots, live };
    }

    pub fn replace_all_uses(&mut self, from: ValueId, to: ValueId) {
        if from == to {
            return;
        }
        for u in core::mem::take(&mut self[from].uses) {
            self.link(u.op.seg(), to.seg());
            self[u.op].operands[u.index as usize] = to;
            self.add_use(to, u);
        }
    }

    pub fn replace_op(&mut self, op: OpId, with: &[ValueId]) {
        for (r, w) in self[op].results.clone().into_iter().zip(with) {
            self.replace_all_uses(r, *w);
        }
        self.erase(op);
    }

    pub fn erase(&mut self, op: OpId) {
        self.detach(op);
        for region in core::mem::take(&mut self[op].regions) {
            for block in core::mem::take(&mut self[region].blocks) {
                self.erase_block_ops(block);
            }
        }
        self.drop_uses(op);
        self[op].operands.clear();
        self[op].slots.0.clear();
    }

    fn erase_block_ops(&mut self, block: BlockId) {
        let ops = self.block_ops(block);
        ops.iter().for_each(|o| self.detach(*o));
        ops.into_iter().for_each(|o| self.erase(o));
        self[block].parent = None;
    }

    pub fn block_owner(&self, block: BlockId) -> Option<OpId> {
        self[block].parent.map(|r| self[r].parent)
    }

    pub fn op_region(&self, op: OpId) -> Option<RegionId> {
        self[op].parent.and_then(|b| self[b].parent)
    }

    pub fn parent_op(&self, op: OpId) -> Option<OpId> {
        self[op].parent.and_then(|b| self.block_owner(b))
    }

    pub fn def_op(&self, v: ValueId) -> Option<OpId> {
        match self[v].def {
            Def::Result(op, _) => Some(op),
            Def::Arg(..) => None,
        }
    }

    pub fn types(&self, values: &[ValueId]) -> Vec<Type<'a>> {
        values.iter().map(|v| self[*v].ty.clone()).collect()
    }

    pub fn types_are(&self, values: &[ValueId], types: &[Type<'a>]) -> bool {
        values.len() == types.len() && values.iter().zip(types).all(|(v, t)| self[*v].ty == *t)
    }

    pub fn top(&self) -> BlockId {
        self[self[self.root].regions[0]].blocks[0]
    }

    pub fn walk_post(&self, op: OpId, f: &mut impl FnMut(OpId)) {
        for r in &self[op].regions {
            for b in &self[*r].blocks {
                for o in self.ops(*b) {
                    self.walk_post(o, f);
                }
            }
        }
        f(op);
    }

    pub fn walk(&self, op: OpId, f: &mut impl FnMut(OpId)) {
        f(op);
        for r in &self[op].regions {
            for b in &self[*r].blocks {
                for o in self.ops(*b) {
                    self.walk(o, f);
                }
            }
        }
    }

    pub fn ops_in(&self, op: OpId) -> Vec<OpId> {
        let mut out = Vec::new();
        self.walk(op, &mut |o| out.push(o));
        out
    }
}

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

#[derive(Default)]
struct Aliases<'a> {
    attrs: Named<'a, Attribute<'a>>,
    types: Named<'a, Type<'a>>,
    locs: Named<'a, Str<'a>>,
}

impl<'a> Aliases<'a> {
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
        Some(Str::Owned(out))
    }

    fn alias<'x>(ext: &'x Extended<'_>) -> Option<&'x str> {
        (ext.body.is_none() && ext.params.is_empty() && !ext.name.contains('.')).then_some(&*ext.name)
    }

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
            *body = Str::Owned(out);
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

#[derive(Default)]
struct Scope<'a> {
    values: Vec<(Str<'a>, u32, u32)>,
    ids: Vec<ValueId>,
    labels: Vec<(Str<'a>, BlockId)>,
    cut: u32,
}

impl<'a> Scope<'a> {
    fn define(&mut self, name: Str<'a>, ids: &[ValueId]) {
        self.values.push((name, self.ids.len() as u32, ids.len() as u32));
        self.ids.extend_from_slice(ids);
    }

    fn seal(&mut self, outer: &[Scope<'a>]) -> Result<(), Error> {
        Self::sort(&mut self.values, |v| &v.0).map_err(|n| format!("redefinition of SSA value '%{n}'"))?;
        Self::sort(&mut self.labels, |l| &l.0).map_err(|n| format!("redefinition of block '^{n}'"))?;
        let cuts = outer.iter().skip(1).map(|s| s.cut).chain([self.cut]);
        let seen = |name: &str| outer.iter().zip(cuts.clone()).any(|(s, cut)| s.values.binary_search_by(|(k, ..)| (**k).cmp(name)).is_ok_and(|i| s.values[i].1 < cut));
        match self.values.iter().find(|(n, ..)| seen(n)) {
            Some((n, ..)) => Err(format!("redefinition of SSA value '%{n}'").into()),
            None => Ok(()),
        }
    }

    fn sort<T>(xs: &mut [T], key: impl Fn(&T) -> &Str<'a>) -> Result<(), Str<'a>> {
        xs.sort_unstable_by(|a, b| key(a).cmp(key(b)));
        xs.windows(2).find(|w| key(&w[0]) == key(&w[1])).map_or(Ok(()), |w| Err(key(&w[0]).clone()))
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

struct Pending<'a> {
    id: OpId,
    cut: u32,
    operands: Vec<Value<'a>>,
    successors: Vec<Str<'a>>,
    regions: Vec<Region<'a>>,
}

struct Import<'i, 'a, X> {
    body: Body<'a>,
    aliases: &'i Aliases<'a>,
    scopes: Vec<Scope<'a>>,
    x: &'i X,
    lone: bool,
}

impl<'i, 'a, X: moremath::Executor + Sync> Import<'i, 'a, X> {
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

    fn lookup(&self, v: &Value<'_>) -> Result<ValueId, Error> {
        let pack = self.scopes.iter().rev().find_map(|s| s.values(&v.name)).ok_or_else(|| format!("use of undefined value %{}", v.name))?;
        pack.get(v.index.unwrap_or(0) as usize).copied().ok_or_else(|| format!("%{}#{} is out of range", v.name, v.index.unwrap_or(0)).into())
    }

    fn canonical_floats(a: &mut Attribute<'a>) {
        match a {
            Attribute::Array(xs) => xs.iter_mut().for_each(Self::canonical_floats),
            Attribute::Dict(xs) => xs.iter_mut().filter_map(|n| n.value.as_mut()).for_each(Self::canonical_floats),
            Attribute::Float { ty: Some(Type::Float(_)), .. } => {
                if let Ok(c) = mlirformat::Const::try_from(&*a) {
                    *a = Attribute::from(c);
                }
            }
            Attribute::Builtin { name, ty: Some(t), .. } if name == "dense" && matches!(t.element_type(), Type::Float(_) | Type::Integer { .. } | Type::Index) => {
                if let Ok(c) = mlirformat::Const::try_from(&*a) {
                    *a = Attribute::from(c);
                }
            }
            _ => {}
        }
    }

    fn shell(&mut self, op: Operation<'a>) -> Result<Pending<'a>, Error> {
        let Operation { results, name, operands, successors, properties, regions, mut attributes, ty, loc, raw } = op;
        if raw.is_some() {
            return Err(format!("`{name}`: custom form not understood (register its dialect, or print generic)").into());
        }
        let a = &self.aliases;
        let properties = match properties {
            Some(Attribute::Dict(mut d)) => {
                a.dict(&mut d);
                d
            }
            _ => Vec::new(),
        };
        a.dict(&mut attributes);
        let (mut properties, mut attributes) = (properties, attributes);
        for n in properties.iter_mut().chain(attributes.iter_mut()) {
            if let Some(v) = n.value.as_mut() {
                Self::canonical_floats(v);
            }
        }
        let data = OpData { properties, attributes, loc: a.loc(loc), ..OpData::named(name) };
        let mut types = ty.results;
        a.tys(&mut types);
        let n = types.len();
        let id = self.body.adopt(data, types);
        let named: usize = results.iter().map(|r| r.count.unwrap_or(1) as usize).sum();
        if named != 0 && named != n {
            return Err(format!("`{}`: {} result names for {} result types", self.body[id].name, results.len(), n).into());
        }
        let Import { body, scopes, .. } = self;
        let scope = scopes.last_mut().expect("no scope");
        let cut = scope.ids.len() as u32;
        let mut at = 0;
        for r in results {
            let k = r.count.unwrap_or(1) as usize;
            scope.define(r.name, &body[id].results[at..at + k]);
            at += k;
        }
        Ok(Pending { id, cut, operands, successors, regions })
    }

    fn place(&mut self, block: BlockId, ops: Vec<Operation<'a>>, pending: &mut Vec<Pending<'a>>) -> Result<(), Error> {
        pending.reserve(ops.len());
        let top = !self.lone && self.body.block_owner(block) == Some(self.body.root);
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

    fn owns(&self, op: OpId) -> bool {
        op.seg() != self.body.home
    }

    fn finish(&mut self, mut pending: Vec<Pending<'a>>) -> Result<(), Error> {
        let (scope, outer) = self.scopes.split_last_mut().expect("no scope");
        scope.seal(outer)?;
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
                        self.region(p.id, p.cut, r)?;
                    }
                }
            }
        }
        Ok(())
    }

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
        let body = Body { ctx, segs: alloc::vec![seg], seg0: s, home: s, root: op, items: Vec::new(), journal: crate::ir::Journal::default(), outside: None, diagnostics: Vec::new(), symbols: SymbolIndex::default() };
        let mut im = Import { body, aliases, scopes: alloc::vec![Scope::default()], x, lone: true };
        for r in regions {
            im.region(op, 0, r)?;
        }
        Ok(im.body.segs.pop().expect("its seg"))
    }

    fn isolate(&mut self, op: OpId, regions: Vec<Region<'a>>) -> Result<(), Error> {
        let scopes = core::mem::replace(&mut self.scopes, alloc::vec![Scope::default()]);
        let home = core::mem::replace(&mut self.body.home, op.seg());
        let r = regions.into_iter().try_for_each(|r| self.region(op, 0, r).map(|_| ()));
        self.body.home = home;
        self.scopes = scopes;
        r
    }

    fn region(&mut self, op: OpId, cut: u32, r: Region<'a>) -> Result<RegionId, Error> {
        let region = self.body.add_region(op);
        self.scopes.push(Scope { cut, ..Scope::default() });
        let mut pending = Vec::new();
        let lone = r.blocks.len() == 1;
        for b in r.blocks {
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
    pub fn import(ctx: crate::Ctx<'a>, m: Module<'a>) -> Result<Self, Error> {
        #[cfg(feature = "std")]
        return Body::import_in(ctx, m, &moremath::ThreadMulti::from(core::num::NonZeroUsize::MIN));
        #[cfg(not(feature = "std"))]
        Body::import_in(ctx, m, &moremath::ThreadSingle)
    }

    pub fn import_in<X: moremath::Executor + Sync>(ctx: crate::Ctx<'a>, m: Module<'a>, x: &X) -> Result<Self, Error> {
        let mut aliases = Aliases::default();
        let mut items = Vec::new();
        let mut ops = Vec::new();
        for item in m.items {
            match item {
                Item::AttrAlias { name, value: Attribute::Builtin { name: kw, body, .. } } if kw == "loc" => {
                    let strip = |b: &str| b.strip_prefix('(').and_then(|b| b.strip_suffix(')')).map_or(0..b.len(), |i| 1..1 + i.len());
                    let inner = match body.borrowed() {
                        Some(b) => Str::Borrowed(&b[strip(b)]),
                        None => Str::Owned(String::from(&body[strip(&body)])),
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
        let empty = Body { ctx, segs: alloc::vec![Seg::default()], seg0: 0, home: 0, root: OpId::at(0, 0), items, journal: crate::ir::Journal::default(), outside: None, diagnostics: Vec::new(), symbols: SymbolIndex::default() };
        let mut im = Import { body: empty, aliases: &aliases, scopes: alloc::vec![Scope::default()], x, lone: false };
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

#[derive(Clone, Copy, Default)]
struct Counters {
    value: u32,
    arg: u32,
    conflict: u32,
}

#[derive(Clone, Copy)]
enum Head {
    Num(u32),
    Str(u32),
}

#[derive(Clone, Copy)]
struct Name {
    head: Head,
    index: Option<u32>,
}

pub struct Names {
    values: IdVec<ValueId, Option<Name>>,
    labels: IdVec<BlockId, Option<u32>>,
    groups: BTreeMap<OpId, Vec<u32>>,
    nums: Vec<String>,
    strs: IdVec<StrAt, String>,
    bbs: Vec<String>,
}

#[derive(Debug, Clone, Copy)]
struct StrAt(u32, u32);

impl Id for StrAt {
    fn seg(self) -> u32 {
        self.0
    }

    fn index(self) -> u32 {
        self.1
    }
}

struct Apart {
    names: Names,
    used: Counters,
    max: u32,
    bbs: usize,
    args: Vec<(StrAt, u32)>,
}

impl Apart {
    fn shift(&mut self, base: Counters) {
        for name in self.names.values.entries_mut().flatten() {
            if let Head::Num(i) = &mut name.head {
                *i += base.value;
            }
        }
        for (at, k) in &self.args {
            *self.names.strs.get_mut(*at) = format!("arg{}", k + base.arg);
        }
    }
}

#[derive(Clone)]
struct NameScope {
    parent: Option<usize>,
    used: alloc::collections::BTreeSet<String>,
}

struct Namer<'n, 'b, 'a> {
    n: &'n mut Names,
    body: &'b Body<'a>,
    generic: bool,
    next: Counters,
    max: u32,
    scopes: Vec<NameScope>,
    scope: usize,
    args: Option<Vec<(StrAt, u32)>>,
}

impl<'n, 'b, 'a> Namer<'n, 'b, 'a> {
    fn new(n: &'n mut Names, body: &'b Body<'a>, generic: bool) -> Self {
        Namer { n, body, generic, next: Counters::default(), max: 0, scopes: alloc::vec![NameScope { parent: None, used: Default::default() }], scope: 0, args: None }
    }

    fn drain(&mut self, mut stack: Vec<(RegionId, Counters, usize)>) -> usize {
        let body = self.body;
        let mut bbs = 0;
        while let Some((r, saved, parent)) = stack.pop() {
            if !self.generic {
                self.next = saved;
            }
            self.scopes.push(NameScope { parent: Some(parent), used: Default::default() });
            self.scope = self.scopes.len() - 1;
            self.region(r);
            bbs = bbs.max(body[r].blocks.len());
            let (next, scope) = (self.next, self.scope);
            stack.extend(body[r].blocks.iter().flat_map(|b| body.ops(*b)).flat_map(|o| body[o].regions.iter()).map(|nr| (*nr, next, scope)));
        }
        bbs
    }

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

    fn set(&mut self, name: &str, seg: u32) -> Head {
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
        Head::Str(self.n.strs.push(seg, unique))
    }

    fn op(&mut self, op: OpId) {
        let (body, results) = (self.body, &self.body[op].results);
        let mut heads: Vec<Option<Head>> = alloc::vec![None; results.len()];
        let mut groups = alloc::vec![0u32];
        if !self.generic {
            let names = body.interfaces(op).map_or_else(|| body.ods_result_names(op), |i| i.asm_result_names(body, op));
            for (v, name) in names {
                let Some(k) = results.iter().position(|r| *r == v) else { continue };
                heads[k] = Some(self.set(&name, op.seg()));
                if k != 0 {
                    groups.push(k as u32);
                }
            }
        }
        if results.is_empty() {
            return;
        }
        if heads[0].is_none() {
            heads[0] = Some(self.set("", op.seg()));
        }
        groups.sort_unstable();
        groups.dedup();
        let total = results.len() as u32;
        for (k, r) in results.iter().enumerate() {
            let k = k as u32;
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

    fn region(&mut self, r: RegionId) {
        let body = self.body;
        if !self.generic && let Some(i) = body.interfaces(body[r].parent) {
            let parent = body[r].parent;
            for (v, name) in i.asm_block_arg_names(body, parent, r) {
                let head = self.set(&name, v.seg());
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
                    let k = self.next.arg - 1;
                    let head = self.set(&format!("arg{k}"), v.seg());
                    if let (Some(args), Head::Str(at)) = (&mut self.args, head) {
                        args.push((StrAt(v.seg(), at), k));
                    }
                    head
                } else {
                    self.set("", v.seg())
                };
                self.n.values.set(*v, Some(Name { head, index: None }));
            }
            for o in body.ops(*b) {
                self.op(o);
            }
            self.max = self.max.max(self.next.value);
        }
    }
}

impl Names {
    pub(crate) fn of(body: &Body<'_>, root: OpId, generic: bool) -> Self {
        let mut n = Names::new();
        let mut namer = Namer::new(&mut n, body, generic);
        let stack: Vec<(RegionId, Counters, usize)> = body[root].regions.iter().map(|r| (*r, namer.next, 0)).collect();
        namer.op(root);
        let bbs = namer.drain(stack);
        let max = namer.max.max(namer.next.value);
        #[cfg(feature = "std")]
        n.spell(max, bbs, &moremath::ThreadMulti::from(core::num::NonZeroUsize::MIN));
        #[cfg(not(feature = "std"))]
        n.spell(max, bbs, &moremath::ThreadSingle);
        n
    }

    fn new() -> Self {
        Names { values: IdVec::new(None), labels: IdVec::new(None), groups: BTreeMap::new(), nums: Vec::new(), strs: IdVec::new(String::new()), bbs: Vec::new() }
    }

    pub(crate) fn of_in<X: moremath::Executor + Sync>(body: &Body<'_>, root: OpId, generic: bool, x: &X) -> Self {
        let &[r] = &body[root].regions[..] else { return Self::of(body, root, generic) };
        let order: Vec<OpId> = body[r].blocks.iter().flat_map(|b| body.ops(*b)).filter(|o| body.names_apart(*o)).collect();
        let units: BTreeMap<OpId, usize> = order.iter().enumerate().map(|(k, o)| (*o, k)).collect();
        if x.threads() <= 1 || order.len() < 2 {
            return Self::of(body, root, generic);
        }
        let mut n = Names::new();
        let mut namer = Namer::new(&mut n, body, generic);
        namer.op(root);
        if !generic {
            namer.next = Counters::default();
        }
        namer.scopes.push(NameScope { parent: Some(0), used: Default::default() });
        namer.scope = 1;
        namer.region(r);
        let mut bbs = body[r].blocks.len();
        let (next, scope) = (namer.next, namer.scope);
        let held: Vec<(RegionId, Counters, usize)> = body[r].blocks.iter().flat_map(|b| body.ops(*b)).flat_map(|o| body[o].regions.iter()).map(|nr| (*nr, next, scope)).collect();
        let begin = if generic { Counters::default() } else { next };
        let scopes = &namer.scopes;
        let tasks: Vec<_> = order
            .iter()
            .map(|u| (*u, scopes.clone()))
            .collect::<Vec<_>>()
            .into_iter()
            .map(|(u, scopes)| {
                move || {
                    let mut names = Names::new();
                    let mut nm = Namer { n: &mut names, body, generic, next: begin, max: 0, scopes, scope, args: generic.then(Vec::new) };
                    let bbs = nm.drain(body[u].regions.iter().map(|nr| (*nr, begin, scope)).collect());
                    let (used, max, args) = (nm.next, nm.max.max(nm.next.value), nm.args.take().unwrap_or_default());
                    Apart { names, used, max, bbs, args }
                }
            })
            .collect();
        let mut apart: Vec<Apart> = x.execute(tasks);
        if generic && apart.iter().any(|a| a.used.conflict != 0) {
            return Self::of(body, root, generic);
        }
        let mut bases = alloc::vec![Counters::default(); apart.len()];
        let mut i = held.len();
        while i > 0 {
            let (nr, saved, parent) = held[i - 1];
            let owner = body[nr].parent;
            let Some(&k) = units.get(&owner) else {
                bbs = bbs.max(namer.drain(alloc::vec![(nr, saved, parent)]));
                i -= 1;
                continue;
            };
            while i > 0 && body[held[i - 1].0].parent == owner {
                i -= 1;
            }
            let a = &apart[k];
            bbs = bbs.max(a.bbs);
            if generic {
                bases[k] = namer.next;
                namer.next.value += a.used.value;
                namer.next.arg += a.used.arg;
                namer.max = namer.max.max(namer.next.value);
            } else {
                namer.max = namer.max.max(a.max);
            }
        }
        let max = namer.max.max(namer.next.value);
        if generic {
            let shifts: Vec<_> = apart.into_iter().zip(bases).map(|(mut a, base)| move || {
                a.shift(base);
                a
            }).collect();
            apart = x.execute(shifts);
        }
        for (u, mut a) in order.iter().zip(apart) {
            let s = u.seg();
            n.values.put_row(s, a.names.values.take_row(s));
            n.labels.put_row(s, a.names.labels.take_row(s));
            n.strs.put_row(s, a.names.strs.take_row(s));
            n.groups.append(&mut a.names.groups);
        }
        n.spell(max, bbs, x);
        n
    }

    fn spell<X: moremath::Executor + Sync>(&mut self, max: u32, bbs: usize, x: &X) {
        let max = max as usize;
        let step = max.div_ceil(x.threads() * 4).max(1);
        let runs: Vec<_> = (0..max).step_by(step).map(|from| move || (from..(from + step).min(max)).map(|i| format!("{i}")).collect::<Vec<_>>()).collect();
        self.nums = x.execute(runs).into_iter().flatten().collect();
        self.bbs = (0..bbs).map(|i| format!("bb{i}")).collect();
    }

    fn head(&self, h: Head, seg: u32) -> &str {
        match h {
            Head::Num(i) => &self.nums[i as usize],
            Head::Str(i) => self.strs.get(StrAt(seg, i)),
        }
    }

    #[cfg(feature = "dialect.bufferization")]
    pub(crate) fn print(&self, v: ValueId) -> String {
        match *self.values.get(v) {
            Some(Name { head, index: Some(k) }) => format!("%{}#{k}", self.head(head, v.seg())),
            Some(Name { head, index: None }) => format!("%{}", self.head(head, v.seg())),
            None => String::from("%<<UNKNOWN SSA VALUE>>"),
        }
    }
}

struct Export<'n, 'a> {
    body: &'n Body<'a>,
    names: &'n Names,
    deep: bool,
}

impl Source for Export<'_, '_> {
    fn region(&self, id: u64) -> Region<'_> {
        self.region(RegionId::from_raw(id))
    }

    fn blocks(&self, id: u64) -> Vec<Block<'_>> {
        self.body[RegionId::from_raw(id)].blocks.iter().enumerate().map(|(i, b)| self.block(i, *b, Vec::new())).collect()
    }

    fn len(&self, id: u64, b: usize) -> usize {
        self.body.len_ops(self.body[RegionId::from_raw(id)].blocks[b])
    }

    fn op(&self, id: u64, b: usize, k: usize) -> Operation<'_> {
        self.op(self.body.ops(self.body[RegionId::from_raw(id)].blocks[b]).nth(k).expect("an op of the block"))
    }

    fn ops_iter<'s>(&'s self, id: u64, b: usize, range: core::ops::Range<usize>) -> alloc::boxed::Box<dyn Iterator<Item = Operation<'s>> + 's> {
        let block = self.body[RegionId::from_raw(id)].blocks[b];
        alloc::boxed::Box::new(self.body.ops(block).skip(range.start).take(range.len()).map(move |o| self.op(o)))
    }
}

impl<'n, 'a> Export<'n, 'a> {
    fn new(body: &'n Body<'a>, names: &'n Names, deep: bool) -> Self {
        Self { body, names, deep }
    }

    fn source(&self, r: RegionId) -> Region<'n> {
        Region::sourced(r.raw())
    }

    fn value(&self, v: ValueId) -> Value<'n> {
        match *self.names.values.get(v) {
            Some(Name { head, index }) => Value { name: Str::Borrowed(self.names.head(head, v.seg())), index },
            None => Value { name: Str::Borrowed("INVALID"), index: None },
        }
    }

    fn label(&self, b: BlockId) -> Str<'n> {
        Str::Borrowed(&self.names.bbs[(*self.names.labels.get(b)).expect("placed block") as usize])
    }

    fn types(&self, vs: &[ValueId]) -> Vec<Type<'n>> {
        vs.iter().map(|v| self.body[*v].ty.reborrow()).collect()
    }

    fn op(&self, op: OpId) -> Operation<'n> {
        let d = &self.body[op];
        let (properties, attributes) = self.body.placed(d);
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
        Region { blocks: self.body[r].blocks.iter().enumerate().map(|(i, b)| self.block(i, *b, self.body.ops(*b).map(|o| self.op(o)).collect())).collect() }
    }

    fn block(&self, i: usize, b: BlockId, ops: Vec<Operation<'n>>) -> Block<'n> {
        let data = &self.body[b];
        Block {
            label: (i > 0 || !data.args.is_empty() || data.len == 0).then(|| self.label(b)),
            args: data.args.iter().map(|v| BlockArg { name: self.value(*v).name, ty: self.body[*v].ty.reborrow(), loc: self.body[*v].loc.reborrow() }).collect(),
            ops,
        }
    }
}

impl<'a> Body<'a> {
    fn module<'o>(&self, root: Operation<'o>) -> Module<'o>
    where
        'a: 'o,
    {
        let (meta, mut items): (Vec<_>, Vec<_>) = self.items.iter().cloned().partition(|i| matches!(i, Item::Metadata { .. }));
        items.push(Item::Op(root));
        let blobs = meta.iter().any(|m| matches!(m, Item::Metadata { body } if body.contains("dialect_resources")));
        let used = if blobs { self.used_resources() } else { Vec::new() };
        items.extend(meta.into_iter().filter_map(|m| match m {
            Item::Metadata { body: text } => Body::keep_resources(&text, &used).map(|t| Item::Metadata { body: t.into() }),
            m => Some(m),
        }));
        Module { items }
    }
}

impl<'a> From<&Body<'a>> for Module<'a> {
    fn from(body: &Body<'a>) -> Self {
        let names = body.names();
        body.module(Export::new(body, &names, true).op(body.root).into_static())
    }
}

impl<'a> Body<'a> {
    pub fn names(&self) -> Names {
        Names::of(self, self.root, false)
    }

    pub fn show(&self, opt: &MlirOpt, generic: bool, keep: impl Fn(&Item<'_>) -> bool) -> String {
        #[cfg(feature = "std")]
        return self.render(opt, generic, true, keep, &moremath::ThreadMulti::from(core::num::NonZeroUsize::MIN));
        #[cfg(not(feature = "std"))]
        self.render(opt, generic, true, keep, &moremath::ThreadSingle)
    }

    pub fn show_in<X: moremath::Executor + Sync>(&self, opt: &MlirOpt, generic: bool, keep: impl Fn(&Item<'_>) -> bool, x: &X) -> String {
        self.render(opt, generic, true, keep, x)
    }

    pub fn show_local_scope(&self, opt: &MlirOpt, generic: bool, keep: impl Fn(&Item<'_>) -> bool) -> String {
        #[cfg(feature = "std")]
        return self.render(opt, generic, false, keep, &moremath::ThreadMulti::from(core::num::NonZeroUsize::MIN));
        #[cfg(not(feature = "std"))]
        self.render(opt, generic, false, keep, &moremath::ThreadSingle)
    }

    pub fn show_local_scope_in<X: moremath::Executor + Sync>(&self, opt: &MlirOpt, generic: bool, keep: impl Fn(&Item<'_>) -> bool, x: &X) -> String {
        self.render(opt, generic, false, keep, x)
    }

    fn render<X: moremath::Executor + Sync>(&self, opt: &MlirOpt, generic: bool, aliased: bool, keep: impl Fn(&Item<'_>) -> bool, x: &X) -> String {
        let names = Names::of_in(self, self.root, generic, x);
        let ex = Export::new(self, &names, false);
        let mut m = self.module(ex.op(self.root));
        m.items.retain(|i| matches!(i, Item::Op(_)) || keep(i));
        let bare = MlirOpt::new();
        let text = if generic { &bare } else { opt }.print_in(&m, &ex, x).expect("printing into a string");
        if !aliased {
            return text;
        }
        let taken = m.items.iter().filter_map(|i| match i {
            Item::AttrAlias { name, .. } | Item::TypeAlias { name, .. } => Some(String::from(&**name)),
            _ => None,
        });
        let mut aliases = crate::aliases::Aliases::new(taken);
        if generic {
            aliases.visit_generic_in(self, self.root, x);
        } else {
            aliases.visit_in(&text, x);
        }
        aliases.apply(text, x)
    }
}

impl Body<'_> {
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
    pub fn operation(&self, id: OpId) -> Operation<'a> {
        let names = self.names();
        Export::new(self, &names, true).op(id).into_static()
    }

    pub fn parse(ctx: crate::Ctx<'a>, src: &'a str) -> Result<Self, Error> {
        let m = ctx.opt.parse(src).map_err(|e| Error(format!("{e}")))?;
        Body::import(ctx, m)
    }

    pub fn parse_file(ctx: crate::Ctx<'a>, src: &'a str, name: &str) -> Result<Self, Error> {
        let m = ctx.opt.parse_file(src, name).map_err(|e| Error(format!("{e}")))?;
        Body::import(ctx, m)
    }

    pub fn parse_in<X: moremath::Executor + Sync>(ctx: crate::Ctx<'a>, src: &'a str, x: &X) -> Result<Self, Error> {
        let m = ctx.opt.parse_in(src, x).map_err(|e| Error(format!("{e}")))?;
        Body::import_in(ctx, m, x)
    }
}

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

    pub fn clone_region_into(&mut self, from: crate::RegionId, into: crate::RegionId, before: Option<crate::BlockId>, map: &mut Mapping) -> Vec<crate::BlockId> {
        let blocks = self[from].blocks.clone();
        let mut made = Vec::new();
        for b in &blocks {
            let fresh: Vec<ValueId> = self[*b].args.iter().copied().filter(|a| !map.values.contains_key(a)).collect();
            let args: Vec<_> = fresh.iter().map(|a| (self[*a].ty.clone(), self[*a].loc.clone())).collect();
            let nb = self.add_block(into, &args);
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
            for o in self.block_ops(*b) {
                let c = self.clone_op(o, map);
                self.insert(c, *nb, None);
                cloned.push(c);
            }
        }
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

pub struct Regex<'p>(pub &'p [u8]);

impl Regex<'_> {
    pub fn search(&self, s: &str) -> bool {
        let s = s.as_bytes();
        if let Some(p) = self.0.strip_prefix(b"^") {
            return Regex(p).here(s);
        }
        (0..=s.len()).any(|i| self.here(&s[i..]))
    }

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
