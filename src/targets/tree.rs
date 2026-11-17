use alloc::collections::BTreeMap;
use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;

use mlirformat::{Attribute, Block, BlockArg, FunctionType, NamedAttr, OpInfos, Operation, Region, ResultDef, Str, Type, Value};

/// A value the reader made: an op's result or a block's argument
#[derive(Clone, Copy, Debug, PartialEq, Eq, PartialOrd, Ord)]
pub struct V(u32);

#[derive(Clone, Copy, Debug, PartialEq, Eq, PartialOrd, Ord)]
pub struct O(u32);

#[derive(Clone, Copy, Debug, PartialEq, Eq, PartialOrd, Ord)]
pub struct B(u32);

#[derive(Clone, Copy, Debug, PartialEq, Eq, PartialOrd, Ord)]
pub struct R(u32);

pub struct Node {
    pub name: String,
    pub operands: Vec<V>,
    pub results: Vec<V>,
    /// Properties and attributes, by name
    pub attrs: Vec<(String, Attribute<'static>)>,
    pub succ: Vec<B>,
    pub regions: Vec<R>,
    pub parent: Option<B>,
}

impl Node {
    pub fn get(&self, name: &str) -> Option<&Attribute<'static>> {
        self.attrs.iter().find(|(n, _)| n == name).map(|(_, a)| a)
    }

    pub fn set(&mut self, name: &str, value: Attribute<'static>) {
        match self.attrs.iter_mut().find(|(n, _)| n == name) {
            Some(a) => a.1 = value,
            None => self.attrs.push((String::from(name), value)),
        }
    }
}

#[derive(Default)]
pub struct Blk {
    pub args: Vec<V>,
    pub ops: Vec<O>,
    pub region: Option<R>,
}

#[derive(Default)]
pub struct Reg {
    pub blocks: Vec<B>,
    pub parent: Option<O>,
}

/// Values, blocks and regions to remap when cloning
#[derive(Default)]
pub struct Mapping {
    pub values: BTreeMap<V, V>,
    pub blocks: BTreeMap<B, B>,
}

impl Mapping {
    pub fn value(&self, v: V) -> V {
        self.values.get(&v).copied().unwrap_or(v)
    }

    pub fn block(&self, b: B) -> B {
        self.blocks.get(&b).copied().unwrap_or(b)
    }
}

/// Where the next op goes: the end of a block, or before one of its ops
#[derive(Clone, Copy)]
pub enum At {
    End(B),
    Before(O),
}

/// The IR the reader builds in, as MLIR's deserializer does: ops are moved, cloned and erased while
/// control flow is structurized, so this is mutable and only becomes an mlirformat op tree at the end.
pub struct Tree {
    pub nodes: Vec<Node>,
    pub types: Vec<Type<'static>>,
    pub blocks: Vec<Blk>,
    pub regions: Vec<Reg>,
    pub at: Option<At>,
}

impl Tree {
    const SEGMENTS: &'static str = "operandSegmentSizes";
    /// A switch's case operands, case by case, after its default's
    const CASE_SEGMENTS: &'static str = "case_operand_segments";

    pub fn new() -> Self {
        Self { nodes: Vec::new(), types: Vec::new(), blocks: Vec::new(), regions: Vec::new(), at: None }
    }

    pub fn value(&mut self, ty: Type<'static>) -> V {
        self.types.push(ty);
        V(self.types.len() as u32 - 1)
    }

    pub fn ty(&self, v: V) -> &Type<'static> {
        &self.types[v.0 as usize]
    }

    pub fn node(&self, o: O) -> &Node {
        &self.nodes[o.0 as usize]
    }

    pub fn node_mut(&mut self, o: O) -> &mut Node {
        &mut self.nodes[o.0 as usize]
    }

    pub fn blk(&self, b: B) -> &Blk {
        &self.blocks[b.0 as usize]
    }

    pub fn blk_mut(&mut self, b: B) -> &mut Blk {
        &mut self.blocks[b.0 as usize]
    }

    pub fn reg(&self, r: R) -> &Reg {
        &self.regions[r.0 as usize]
    }

    pub fn reg_mut(&mut self, r: R) -> &mut Reg {
        &mut self.regions[r.0 as usize]
    }

    /// A block in no region yet
    pub fn detached(&mut self) -> B {
        self.blocks.push(Blk::default());
        B(self.blocks.len() as u32 - 1)
    }

    /// Puts `b` into `r`, before `before` or at the end
    pub fn place(&mut self, r: R, b: B, before: Option<B>) {
        if let Some(old) = self.blk(b).region {
            self.reg_mut(old).blocks.retain(|x| *x != b);
        }
        let at = before.and_then(|x| self.reg(r).blocks.iter().position(|y| *y == x)).unwrap_or(self.reg(r).blocks.len());
        self.reg_mut(r).blocks.insert(at, b);
        self.blk_mut(b).region = Some(r);
    }

    pub fn block_in(&mut self, r: R) -> B {
        let b = self.detached();
        self.place(r, b, None);
        b
    }

    pub fn arg(&mut self, b: B, ty: Type<'static>) -> V {
        let v = self.value(ty);
        self.blk_mut(b).args.push(v);
        v
    }

    pub fn new_region(&mut self, parent: O) -> R {
        self.regions.push(Reg { blocks: Vec::new(), parent: Some(parent) });
        R(self.regions.len() as u32 - 1)
    }

    /// An op with `regions` empty regions, at the insertion point (or detached without one)
    pub fn create(&mut self, name: &str, operands: &[V], results: &[Type<'static>], attrs: Vec<(String, Attribute<'static>)>, succ: &[B], regions: usize) -> O {
        let results = results.iter().map(|t| self.value(t.clone())).collect();
        self.nodes.push(Node { name: String::from(name), operands: operands.to_vec(), results, attrs, succ: succ.to_vec(), regions: Vec::new(), parent: None });
        let o = O(self.nodes.len() as u32 - 1);
        for _ in 0..regions {
            let r = self.new_region(o);
            self.node_mut(o).regions.push(r);
        }
        if let Some(at) = self.at {
            self.insert(o, at);
        }
        o
    }

    pub fn insert(&mut self, o: O, at: At) {
        let (b, i) = match at {
            At::End(b) => (b, self.blk(b).ops.len()),
            At::Before(x) => {
                let b = self.node(x).parent.expect("an op placed in a block");
                (b, self.blk(b).ops.iter().position(|y| *y == x).expect("an op of its block"))
            }
        };
        self.blk_mut(b).ops.insert(i, o);
        self.node_mut(o).parent = Some(b);
    }

    /// Takes `o` out of its block (it stays alive, to be placed again or dropped)
    pub fn unlink(&mut self, o: O) {
        if let Some(b) = self.node_mut(o).parent.take() {
            self.blk_mut(b).ops.retain(|x| *x != o);
        }
    }

    pub fn first(&self, b: B) -> Option<O> {
        self.blk(b).ops.first().copied()
    }

    pub fn terminator(&self, b: B) -> Option<O> {
        self.blk(b).ops.last().copied()
    }

    pub fn start(&mut self, b: B) {
        self.at = Some(self.first(b).map_or(At::End(b), At::Before));
    }

    /// `b`'s ops from `o` on, moved into a new block right after it
    pub fn split(&mut self, b: B, o: O) -> B {
        let new = self.detached();
        let r = self.blk(b).region.expect("a placed block");
        let next = self.reg(r).blocks.iter().position(|x| *x == b).and_then(|i| self.reg(r).blocks.get(i + 1).copied());
        self.place(r, new, next);
        let i = self.blk(b).ops.iter().position(|x| *x == o).expect("an op of the block");
        let moved = self.blk_mut(b).ops.split_off(i);
        for m in &moved {
            self.node_mut(*m).parent = Some(new);
        }
        self.blk_mut(new).ops = moved;
        new
    }

    /// Every op in `o`'s regions, `o` first
    pub fn walk(&self, o: O, out: &mut Vec<O>) {
        out.push(o);
        for r in &self.node(o).regions {
            for b in &self.reg(*r).blocks {
                for x in &self.blk(*b).ops {
                    self.walk(*x, out);
                }
            }
        }
    }

    /// Every op in `b` and the regions under it
    pub fn walk_block(&self, b: B, out: &mut Vec<O>) {
        for x in &self.blk(b).ops {
            self.walk(*x, out);
        }
    }

    /// Every block under `o`
    pub fn blocks_under(&self, o: O, out: &mut Vec<B>) {
        for r in &self.node(o).regions {
            for b in &self.reg(*r).blocks {
                out.push(*b);
                for x in &self.blk(*b).ops {
                    self.blocks_under(*x, out);
                }
            }
        }
    }

    /// `o`, its regions cloned with it, its operands and successors mapped, at the insertion point
    pub fn clone_op(&mut self, o: O, map: &mut Mapping) -> O {
        let n = self.node(o);
        let (name, operands, attrs, succ, regions) = (n.name.clone(), n.operands.iter().map(|v| map.value(*v)).collect::<Vec<_>>(), n.attrs.clone(), n.succ.iter().map(|b| map.block(*b)).collect::<Vec<_>>(), n.regions.clone());
        let types: Vec<Type<'static>> = n.results.iter().map(|v| self.ty(*v).clone()).collect();
        let c = self.create(&name, &operands, &types, attrs, &succ, regions.len());
        for (a, b) in self.node(o).results.clone().into_iter().zip(self.node(c).results.clone()) {
            map.values.insert(a, b);
        }
        let saved = self.at;
        for (from, to) in regions.into_iter().zip(self.node(c).regions.clone()) {
            let blocks = self.reg(from).blocks.clone();
            let mut fresh = Vec::new();
            for b in &blocks {
                let nb = self.block_in(to);
                for a in self.blk(*b).args.clone() {
                    let na = self.arg(nb, self.ty(a).clone());
                    map.values.insert(a, na);
                }
                map.blocks.insert(*b, nb);
                fresh.push(nb);
            }
            for (b, nb) in blocks.into_iter().zip(fresh) {
                self.at = Some(At::End(nb));
                for x in self.blk(b).ops.clone() {
                    self.clone_op(x, map);
                }
            }
        }
        self.at = saved;
        c
    }

    /// Whether any op still placed under `root` reads `v`
    pub fn used(&self, root: O, v: V) -> bool {
        let mut all = Vec::new();
        self.walk(root, &mut all);
        all.iter().any(|o| self.node(*o).operands.contains(&v))
    }

    pub fn replace_uses(&mut self, root: O, from: V, to: V) {
        let mut all = Vec::new();
        self.walk(root, &mut all);
        for o in all {
            for x in &mut self.node_mut(o).operands {
                if *x == from {
                    *x = to;
                }
            }
        }
    }

    pub fn replace_block_uses(&mut self, root: O, from: B, to: B) {
        let mut all = Vec::new();
        self.walk(root, &mut all);
        for o in all {
            for x in &mut self.node_mut(o).succ {
                if *x == from {
                    *x = to;
                }
            }
        }
    }

    pub fn block_used(&self, root: O, b: B) -> bool {
        let mut all = Vec::new();
        self.walk(root, &mut all);
        all.iter().any(|o| self.node(*o).succ.contains(&b))
    }

    /// The operands `o` forwards to its `i`th successor
    pub fn successor_operands(&self, o: O, i: usize) -> core::ops::Range<usize> {
        let n = self.node(o);
        let sizes = match n.get(Tree::SEGMENTS) {
            Some(Attribute::DenseArray { values, .. }) => values.iter().map(|v| v.parse().unwrap_or(0)).collect::<Vec<usize>>(),
            _ => return 0..n.operands.len(),
        };
        let cases = match n.get(Tree::CASE_SEGMENTS) {
            Some(Attribute::DenseArray { values, .. }) => Some(values.iter().map(|v| v.parse().unwrap_or(0)).collect::<Vec<usize>>()),
            _ => None,
        };
        match cases {
            Some(cases) => {
                let start = sizes[0];
                if i == 0 {
                    return start..start + sizes[1];
                }
                let first = start + sizes[1] + cases[..i - 1].iter().sum::<usize>();
                first..first + cases[i - 1]
            }
            None => {
                let g = sizes.len() - n.succ.len() + i;
                let start: usize = sizes[..g].iter().sum();
                start..start + sizes[g]
            }
        }
    }

    fn name(v: V) -> String {
        format!("{}", v.0)
    }

    /// `^bbN`, N the block's place in its region (as MLIR numbers them)
    fn label(&self, b: B) -> String {
        let at = self.blk(b).region.and_then(|r| self.reg(r).blocks.iter().position(|x| *x == b)).unwrap_or(0);
        format!("bb{at}")
    }

    /// `o` as an mlirformat op; ODS's inherent attributes (`infos`) are its properties
    pub fn operation(&self, o: O, infos: &OpInfos) -> Operation<'static> {
        let n = self.node(o);
        let inherent = |name: &str| name == Tree::SEGMENTS || infos.op_info(&n.name).is_some_and(|i| i.inherent.contains(&name));
        let mut attrs = n.attrs.clone();
        attrs.sort_by(|a, b| a.0.cmp(&b.0));
        let named = |(k, v): (String, Attribute<'static>)| NamedAttr { name: Str::Owned(k), value: (!matches!(v, Attribute::Unit)).then_some(v) };
        let (props, rest): (Vec<_>, Vec<_>) = attrs.into_iter().partition(|(k, _)| inherent(k));
        Operation {
            results: n.results.iter().map(|v| ResultDef { name: Str::Owned(Tree::name(*v)), count: None }).collect(),
            name: Str::Owned(n.name.clone()),
            operands: n.operands.iter().map(|v| Value { name: Str::Owned(Tree::name(*v)), index: None }).collect(),
            successors: n.succ.iter().map(|b| Str::Owned(self.label(*b))).collect(),
            properties: (!props.is_empty()).then(|| Attribute::Dict(props.into_iter().map(named).collect())),
            regions: n.regions.iter().map(|r| self.region_op(*r, infos)).collect(),
            attributes: rest.into_iter().map(named).collect(),
            ty: FunctionType { inputs: n.operands.iter().map(|v| self.ty(*v).clone()).collect(), results: n.results.iter().map(|v| self.ty(*v).clone()).collect() },
            loc: None,
            raw: None,
        }
    }

    fn region_op(&self, r: R, infos: &OpInfos) -> Region<'static> {
        Region {
            blocks: self
                .reg(r)
                .blocks
                .iter()
                .enumerate()
                .map(|(i, b)| Block {
                    label: (i > 0 || !self.blk(*b).args.is_empty() || self.blk(*b).ops.is_empty()).then(|| Str::Owned(self.label(*b))),
                    args: self.blk(*b).args.iter().map(|a| BlockArg { name: Str::Owned(Tree::name(*a)), ty: self.ty(*a).clone(), loc: None }).collect(),
                    ops: self.blk(*b).ops.iter().map(|x| self.operation(*x, infos)).collect(),
                })
                .collect(),
        }
    }
}


impl Default for Tree {
    fn default() -> Self {
        Self::new()
    }
}

impl Mapping {
    pub fn new() -> Self {
        Self { values: BTreeMap::new(), blocks: BTreeMap::new() }
    }
}
