//! ⭐ Bufferization, as `mlir/Dialect/Bufferization`: tensors to memrefs.
//!
//! ```text
//! Bufferizable    per dialect (`OpInterfaces::bufferizable`): BufferizableOpInterface of its ops
//! AnalysisState           AnalysisState; with the One-Shot analysis' results (alias and equivalence
//!                 sets, in-place operands) once `analyze` ran (OneShotAnalysisState)
//! analyze         OneShotAnalysis.cpp: which tensor operands bufferize in place
//! insert_copies   TensorCopyInsertion.cpp: `resolveConflicts` of every op
//! bufferize       Bufferize.cpp: every op rewritten on buffers, `to_buffer` / `to_tensor` between
//! ```

mod analysis;

#[cfg(feature = "dialect.func")]
pub(crate) use analysis::{callee, func_arg_attr};
pub(crate) use analysis::{func_signature, return_ops};
mod driver;

use alloc::collections::{BTreeMap, BTreeSet};
use alloc::string::String;
use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{Attribute, Error, Shaped, ShapedKind, StridedLayout, Type};

use crate::{Body, Def, MemrefOfr as Ofr, OpData, OpId, Operand, Rewriter, Trait, ValueId};

pub(crate) use driver::{buffer_type_in, fold_to_buffer_to_tensor};
pub use driver::{bufferize_block_signature, buffer_of, buffer_type, cast_or_realloc, one_shot_bufferize, one_shot_module_bufferize, replace_with_buffers};

/// `BufferRelation`: what the buffer of an aliasing value is to the operand's.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum BufferRelation {
    Unknown,
    Equivalent,
}

/// `AliasingValue`: a value whose buffer may (`definite`: does) alias an operand's.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct AliasingValue {
    pub value: ValueId,
    pub relation: BufferRelation,
    pub definite: bool,
}

impl AliasingValue {
    /// The same buffer, definitely.
    pub const fn equivalent(value: ValueId) -> Self {
        Self { value, relation: BufferRelation::Equivalent, definite: true }
    }

    /// Some other buffer that `definite`ly (or maybe) aliases.
    pub const fn unknown(value: ValueId, definite: bool) -> Self {
        Self { value, relation: BufferRelation::Unknown, definite }
    }
}

/// `AliasingOpOperand`.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct AliasingOperand {
    pub operand: Operand,
    pub relation: BufferRelation,
    pub definite: bool,
}

/// `OneShotBufferizationOptions::AnalysisHeuristic`: in which order operands are decided.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum AnalysisHeuristic {
    BottomUp,
    TopDown,
    BottomUpFromTerminators,
    /// Shuffled by `std::mt19937` of the seed.
    Fuzzer(u32),
}

/// `LayoutMapOption`: the layout of a bufferized tensor's memref.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum LayoutMapOption {
    Infer,
    Identity,
    FullyDynamic,
}

impl core::str::FromStr for LayoutMapOption {
    type Err = Error;

    fn from_str(s: &str) -> Result<Self, Error> {
        Self::try_from(s)
    }
}

impl TryFrom<&str> for LayoutMapOption {
    type Error = Error;

    fn try_from(s: &str) -> Result<Self, Error> {
        Ok(match s {
            "infer-layout-map" => Self::Infer,
            "identity-layout-map" => Self::Identity,
            "fully-dynamic-layout-map" => Self::FullyDynamic,
            _ => return Err(Error(alloc::format!("invalid layout map option: {s}"))),
        })
    }
}

/// `defaultMemorySpaceFn`: the memory space of a new buffer.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum MemorySpaceOption {
    /// None (the default memory space).
    Default,
    /// Never inferred: an allocation without one fails (`must-infer-memory-space`).
    MustInfer,
    /// The tensor's encoding (`use-encoding-for-memory-space`).
    Encoding,
}

/// `OneShotBufferizationOptions`.
#[derive(Debug, Clone)]
pub struct BufferizationOptions {
    pub allow_return_allocs_from_loops: bool,
    pub allow_unknown_ops: bool,
    pub heuristic: AnalysisHeuristic,
    pub copy_before_write: bool,
    pub dump_alias_sets: bool,
    pub function_boundary_layout: LayoutMapOption,
    pub unknown_layout: LayoutMapOption,
    pub memory_space: MemorySpaceOption,
    pub print_conflicts: bool,
    pub buffer_alignment: u64,
    pub test_analysis_only: bool,
    pub function_boundaries: bool,
    pub check_parallel_regions: bool,
    pub no_analysis_func_filter: Vec<String>,
    /// `dialect-filter`: only these dialects' ops bufferize (all when empty).
    pub dialect_filter: Vec<String>,
    /// The functions whose ops the analysis skips (`no-analysis-func-filter`'s deny rule).
    pub(crate) deny_funcs: Vec<String>,
}

impl Default for BufferizationOptions {
    fn default() -> Self {
        Self {
            allow_return_allocs_from_loops: false,
            allow_unknown_ops: false,
            heuristic: AnalysisHeuristic::BottomUp,
            copy_before_write: false,
            dump_alias_sets: false,
            function_boundary_layout: LayoutMapOption::Infer,
            unknown_layout: LayoutMapOption::FullyDynamic,
            memory_space: MemorySpaceOption::Default,
            print_conflicts: false,
            buffer_alignment: 64,
            test_analysis_only: false,
            function_boundaries: false,
            check_parallel_regions: true,
            no_analysis_func_filter: Vec::new(),
            dialect_filter: Vec::new(),
            deny_funcs: Vec::new(),
        }
    }
}

impl BufferizationOptions {
    /// `isOpAllowed`: func ops only with function boundaries, then the dialect filter.
    pub fn allowed(&self, b: &Body<'_>, op: OpId) -> bool {
        let ns = b[op].name.split_once('.').map_or(&*b[op].name, |(ns, _)| ns);
        if !self.function_boundaries && ns == "func" {
            return false;
        }
        if !self.deny_funcs.is_empty() {
            let mut f = Some(op);
            while let Some(x) = f.filter(|x| b[*x].name != "func.func") {
                f = b.parent_op(x);
            }
            if f.and_then(|f| b.sym_name(f)).is_some_and(|n| self.deny_funcs.iter().any(|d| d == n)) {
                return false;
            }
        }
        self.dialect_filter.is_empty() || self.dialect_filter.iter().any(|d| d == ns)
    }

    /// `dynCastBufferizableOp`: `op`'s interface, when it is allowed and implements one.
    pub fn bufferizable<'a>(&self, b: &Body<'a>, op: OpId) -> Option<&'a dyn Bufferizable> {
        if !self.allowed(b, op) {
            return None;
        }
        b.ctx.interfaces.of(&b[op].name)?.bufferizable(&b[op].name)
    }

    /// `defaultMemorySpaceFn` of `tensor`: `Some(None)` the default space, `None` none inferred.
    pub fn default_memory_space<'a>(&self, tensor: &Shaped<'a>) -> Option<Option<Attribute<'a>>> {
        match self.memory_space {
            MemorySpaceOption::Default => Some(None),
            MemorySpaceOption::MustInfer => None,
            MemorySpaceOption::Encoding => Some(tensor.extras.first().cloned()),
        }
    }

    /// `getMemRefType`: with `layout`, or through `unknownTypeConverterFn`.
    pub fn memref_type<'a>(&self, tensor: &Shaped<'a>, layout: Option<Attribute<'a>>, space: Option<Attribute<'a>>) -> Type<'a> {
        match layout {
            Some(l) => Self::memref(tensor, Some(l), space),
            None => match self.unknown_layout {
                LayoutMapOption::Identity => Self::memref(tensor, None, space),
                _ => Self::fully_dynamic(tensor, space),
            },
        }
    }

    /// A memref of `tensor`'s shape and element type, its `layout` and memory `space`.
    pub fn memref<'a>(tensor: &Shaped<'a>, layout: Option<Attribute<'a>>, space: Option<Attribute<'a>>) -> Type<'a> {
        // An `i64` memory space is written without its type inside a memref type.
        let space = space.map(|s| match s {
            Attribute::Int { lit, ty: Some(t) } if t == Type::int(64) => Attribute::Int { lit, ty: None },
            s => s,
        });
        // The default layout is the identity map without symbols: that one is no layout at all.
        // One with symbols is another type, which only prints the same.
        let layout = layout.filter(|l| !crate::AffineMap::try_from(l).is_ok_and(|m| m.syms == 0 && m.is_identity()));
        let extras = layout.into_iter().chain(space).collect();
        Type::Shaped(alloc::boxed::Box::new(Shaped { kind: ShapedKind::MemRef, shape: tensor.shape.clone(), elem: tensor.elem.clone(), extras }))
    }

    /// `getMemRefTypeWithFullyDynamicLayout`.
    /// `TensorLikeType::getBufferType` of a dialect tensor type: `!test.test_tensor<..>` ⇒
    /// `!test.test_memref<..>`.
    pub fn tensor_like<'a>(t: &Type<'a>) -> Option<Type<'a>> {
        const TENSOR_LIKE: &[(&str, &str)] = &[("test.test_tensor", "test.test_memref")];
        let Type::Extended(e) = t else { return None };
        let (_, memref) = TENSOR_LIKE.iter().find(|(tensor, _)| *tensor == &*e.name)?;
        Some(Type::Extended(alloc::boxed::Box::new(mlirformat::Extended { name: (*memref).into(), body: e.body.clone(), params: e.params.clone() })))
    }

    /// `BaseMemRefType::isValidElementType`: builtin scalars, complex, vector and memref, and
    /// the dialect types with `MemRefElementTypeInterface`.
    pub fn valid_element(t: &Type<'_>) -> bool {
        const ELEMENT_TYPES: &[&str] = &["ptr.ptr", "test.memref_element"];
        match t {
            Type::Integer { .. } | Type::Index | Type::Float(_) | Type::Complex(_) => true,
            Type::Shaped(s) => s.kind != ShapedKind::Tensor,
            Type::Extended(e) => ELEMENT_TYPES.contains(&&*e.name),
            _ => false,
        }
    }

    pub fn fully_dynamic<'a>(tensor: &Shaped<'a>, space: Option<Attribute<'a>>) -> Type<'a> {
        let Some(shape) = &tensor.shape else { return Self::memref(tensor, None, space) };
        let layout = StridedLayout { strides: vec![mlirformat::Dim::DYNAMIC; shape.len()], offset: mlirformat::Dim::DYNAMIC };
        Self::memref(tensor, Some(layout.into()), space)
    }

    /// `getMemRefTypeWithStaticIdentityLayout`.
    pub fn identity<'a>(tensor: &Shaped<'a>, space: Option<Attribute<'a>>) -> Type<'a> {
        Self::memref(tensor, None, space)
    }
}

/// ⭐ `BufferizableOpInterface`, implemented once per dialect for its ops (by name): what the
/// analysis asks, and how an op bufferizes. Every method has upstream's default.
pub trait Bufferizable: Sync {
    /// `bufferizesToAllocation`.
    fn to_allocation(&self, _: &Body<'_>, _: ValueId) -> bool {
        false
    }

    /// `bufferizesToMemoryRead`.
    fn reads(&self, _: &AnalysisState<'_>, _: &Body<'_>, _: Operand) -> bool {
        true
    }

    /// `bufferizesToMemoryWrite`.
    fn writes(&self, _: &AnalysisState<'_>, _: &Body<'_>, _: Operand) -> bool {
        true
    }

    /// `bufferizesToElementwiseAccess`.
    fn elementwise(&self, _: &AnalysisState<'_>, _: &Body<'_>, _: &[Operand]) -> bool {
        false
    }

    /// `resultBufferizesToMemoryWrite`.
    fn result_writes(&self, s: &AnalysisState<'_>, b: &Body<'_>, v: ValueId) -> bool {
        s.default_result_writes(b, v)
    }

    /// `mustBufferizeInPlace`: an unranked tensor.
    fn must_in_place(&self, _: &AnalysisState<'_>, b: &Body<'_>, (op, i): Operand) -> bool {
        matches!(&b[b[op].operands[i]].ty, Type::Shaped(s) if s.shape.is_none())
    }

    /// `getAliasingValues`.
    fn aliasing_values(&self, _: &AnalysisState<'_>, _: &Body<'_>, _: Operand) -> Vec<AliasingValue> {
        Vec::new()
    }

    /// `getAliasingOpOperands`: by default the operands whose aliasing values hold `v`.
    fn aliasing_operands(&self, s: &AnalysisState<'_>, b: &Body<'_>, v: ValueId) -> Vec<AliasingOperand> {
        s.default_aliasing_operands(b, v)
    }

    /// `resolveConflicts`: by default `resolveTensorOpOperandConflicts`.
    fn resolve_conflicts(&self, rw: &mut Rewriter<'_, '_>, s: &AnalysisState<'_>, op: OpId) -> Result<(), Error> {
        s.resolve_tensor_conflicts(rw, op)
    }

    /// `bufferize`: `op` rewritten on buffers.
    fn bufferize(&self, rw: &mut Rewriter<'_, '_>, _: &BufferizationOptions, op: OpId) -> Result<(), Error> {
        Err(Error(alloc::format!("'{}' op bufferize not implemented", rw.body[op].name)))
    }

    /// `isWritable`: an op result.
    fn writable(&self, _: &AnalysisState<'_>, b: &Body<'_>, v: ValueId) -> bool {
        matches!(b[v].def, Def::Result(..))
    }

    /// `isNotConflicting`.
    fn not_conflicting(&self, _: &AnalysisState<'_>, _: &Body<'_>, _: Operand, _: Operand) -> bool {
        false
    }

    /// `verifyAnalysis`.
    fn verify(&self, _: &AnalysisState<'_>, _: &Body<'_>, _: OpId) -> Result<(), Error> {
        Ok(())
    }

    /// `getBufferType` of `v` (on top of `stack`, the values being asked).
    fn buffer_type<'a>(&self, o: &BufferizationOptions, b: &Body<'a>, v: ValueId, stack: &mut Vec<ValueId>) -> Result<Type<'a>, Error> {
        AnalysisState::default_buffer_type(o, b, v, stack)
    }

    /// `isRepetitiveRegion`: by `RegionBranchOpInterface`.
    fn repetitive_region(&self, b: &Body<'_>, op: OpId, index: usize) -> bool {
        b.repetitive_region(op, index)
    }

    /// `isParallelRegion`.
    fn parallel_region(&self, _: &Body<'_>, _: OpId, _: usize) -> bool {
        false
    }

    /// `hasTensorSemantics`.
    fn tensor_semantics(&self, b: &Body<'_>, op: OpId) -> bool {
        b.default_tensor_semantics(op)
    }

    /// `supportsUnstructuredControlFlow`.
    fn unstructured_control_flow(&self, _: &Body<'_>, _: OpId) -> bool {
        false
    }
}

/// A builtin tensor type (`TensorType`), ranked or not: what the analysis and its annotations
/// look at.
pub fn is_tensor_type(t: &Type<'_>) -> bool {
    matches!(t, Type::Shaped(s) if s.kind == ShapedKind::Tensor)
}

/// A tensor type (`TensorLikeType`): a builtin tensor, ranked or not, or a dialect type with
/// `TensorLikeTypeInterface`.
pub fn is_tensor(t: &Type<'_>) -> bool {
    match t {
        Type::Shaped(s) => s.kind == ShapedKind::Tensor,
        Type::Extended(_) => BufferizationOptions::tensor_like(t).is_some(),
        _ => false,
    }
}

impl Body<'_> {
    /// `getOwnerOfValue`: the op defining `v`, or the one holding its block.
    pub fn owner_of(&self, v: ValueId) -> OpId {
        match self[v].def {
            Def::Result(op, _) => op,
            Def::Arg(blk, _) => self.block_owner(blk).expect("a block in an op"),
        }
    }

    /// `v`'s uses, in MLIR's use-list order (the latest first).
    pub fn uses_of(&self, v: ValueId) -> Vec<Operand> {
        self[v].uses.iter().rev().map(|u| (u.op, u.index as usize)).collect()
    }

    /// Operand `u` is a tensor.
    pub fn tensor_operand(&self, (op, i): Operand) -> bool {
        is_tensor_type(&self[self[op].operands[i]].ty)
    }

    /// `detail::defaultHasTensorSemantics`: a tensor block argument, result or operand.
    pub fn default_tensor_semantics(&self, op: OpId) -> bool {
        self[op].regions.iter().any(|r| self[*r].blocks.iter().any(|blk| self[*blk].args.iter().any(|a| is_tensor(&self[*a].ty))))
            || self[op].results.iter().chain(self[op].operands.iter()).any(|v| is_tensor(&self[*v].ty))
    }
}

/// `TraversalConfig` of `findValueInReverseUseDefChain`.
#[derive(Debug, Clone, Copy)]
pub struct TraversalConfig {
    pub always_include_leaves: bool,
    pub follow_equivalent_only: bool,
    pub follow_in_place_only: bool,
    pub follow_same_type_or_casts_only: bool,
    pub follow_unknown_ops: bool,
    pub revisit: bool,
}

impl Default for TraversalConfig {
    fn default() -> Self {
        Self { always_include_leaves: true, follow_equivalent_only: false, follow_in_place_only: false, follow_same_type_or_casts_only: false, follow_unknown_ops: false, revisit: false }
    }
}

/// Union-find with members in insertion order (`llvm::EquivalenceClasses`).
#[derive(Debug, Default, Clone)]
pub(crate) struct Classes {
    parent: BTreeMap<ValueId, ValueId>,
    members: BTreeMap<ValueId, Vec<ValueId>>,
}

impl Classes {
    pub(crate) fn insert(&mut self, v: ValueId) {
        self.parent.entry(v).or_insert(v);
        self.members.entry(v).or_insert_with(|| vec![v]);
    }

    fn leader(&self, mut v: ValueId) -> ValueId {
        while let Some(p) = self.parent.get(&v).copied().filter(|p| *p != v) {
            v = p;
        }
        v
    }

    pub(crate) fn union(&mut self, a: ValueId, b: ValueId) {
        self.insert(a);
        self.insert(b);
        let (la, lb) = (self.leader(a), self.leader(b));
        if la == lb {
            return;
        }
        let moved = self.members.remove(&lb).unwrap_or_default();
        self.members.entry(la).or_default().extend(moved);
        self.parent.insert(lb, la);
    }

    pub(crate) fn same(&self, a: ValueId, b: ValueId) -> bool {
        self.leader(a) == self.leader(b)
    }

    /// The class of `v`, from its leader.
    pub(crate) fn of(&self, v: ValueId) -> Vec<ValueId> {
        self.members.get(&self.leader(v)).cloned().unwrap_or_else(|| vec![v])
    }
}

/// What the module analysis found of each function (`FuncAnalysisState`), by `func.func`.
#[derive(Debug, Default, Clone)]
pub(crate) struct Funcs {
    /// Analyzed (`true`) or in progress (`false`).
    pub(crate) analyzed: BTreeMap<OpId, bool>,
    /// Return value index ⇒ the argument it is equivalent to.
    pub(crate) equivalent: BTreeMap<OpId, BTreeMap<usize, usize>>,
    /// Argument index ⇒ the return values that may alias it.
    pub(crate) aliasing: BTreeMap<OpId, BTreeMap<usize, Vec<usize>>>,
    pub(crate) read: BTreeMap<OpId, BTreeSet<usize>>,
    pub(crate) written: BTreeMap<OpId, BTreeSet<usize>>,
}

/// What the One-Shot analysis decided (`OneShotAnalysisState`'s own data).
#[derive(Debug, Default, Clone)]
pub(crate) struct OneShot {
    pub(crate) funcs: Option<Funcs>,
    pub(crate) alias: Classes,
    pub(crate) equiv: Classes,
    pub(crate) inplace: BTreeSet<Operand>,
    pub(crate) undefined: BTreeSet<Operand>,
    pub(crate) definitions: BTreeMap<ValueId, Vec<ValueId>>,
}

/// ⭐ `AnalysisState`: the questions about tensors' buffers, answered through each op's
/// [`Bufferizable`]; with [`OneShot`] results the in-place, aliasing and equivalence ones.
pub struct AnalysisState<'o> {
    pub options: &'o BufferizationOptions,
    pub(crate) one_shot: Option<OneShot>,
}

impl<'o> AnalysisState<'o> {
    /// A plain `AnalysisState`: nothing in place, everything aliasing.
    pub fn new(options: &'o BufferizationOptions) -> Self {
        Self { options, one_shot: None }
    }

    fn of<'a>(&self, b: &Body<'a>, op: OpId) -> Option<&'a dyn Bufferizable> {
        self.options.bufferizable(b, op)
    }

    /// `getAliasingOpOperands`: through the owner's interface, else `unknownGetAliasingOpOperands`.
    pub fn aliasing_operands(&self, b: &Body<'_>, v: ValueId) -> Vec<AliasingOperand> {
        let owner = b.owner_of(v);
        if let Some(i) = self.of(b, owner) {
            return i.aliasing_operands(self, b, v);
        }
        if let Def::Arg(blk, _) = b[v].def
            && b[b[blk].parent.expect("a region")].blocks.first() != Some(&blk)
        {
            return Vec::new();
        }
        let Def::Result(op, _) = b[v].def else { return Vec::new() };
        (0..b[op].operands.len()).filter(|i| b.tensor_operand((op, *i))).map(|i| AliasingOperand { operand: (op, i), relation: BufferRelation::Unknown, definite: false }).collect()
    }

    /// `getAliasingValues`: through the owner's interface, else `unknownGetAliasingValues`.
    pub fn aliasing_values(&self, b: &Body<'_>, u: Operand) -> Vec<AliasingValue> {
        if let Some(i) = self.of(b, u.0) {
            return i.aliasing_values(self, b, u);
        }
        let op = u.0;
        let mut r: Vec<AliasingValue> = b[op].results.iter().filter(|v| is_tensor(&b[**v].ty)).map(|v| AliasingValue::unknown(*v, false)).collect();
        for reg in b[op].regions.iter() {
            if let Some(blk) = b[*reg].blocks.first() {
                r.extend(b[*blk].args.iter().filter(|a| is_tensor(&b[**a].ty)).map(|a| AliasingValue::unknown(*a, false)));
            }
        }
        r
    }

    /// `bufferizesToMemoryRead`; an unknown op reads.
    pub fn reads(&self, b: &Body<'_>, u: Operand) -> bool {
        self.of(b, u.0).is_none_or(|i| i.reads(self, b, u))
    }

    /// `bufferizesToMemoryWrite(OpOperand)`; an unknown op writes.
    pub fn writes(&self, b: &Body<'_>, u: Operand) -> bool {
        self.of(b, u.0).is_none_or(|i| i.writes(self, b, u))
    }

    /// `bufferizesToAliasOnly`.
    pub fn alias_only(&self, b: &Body<'_>, u: Operand) -> bool {
        self.of(b, u.0).is_some_and(|i| !i.reads(self, b, u) && !i.writes(self, b, u) && !i.aliasing_values(self, b, u).is_empty())
    }

    /// `bufferizesToMemoryWrite(Value)`: a block argument does; an op result as its op says.
    pub fn value_writes(&self, b: &Body<'_>, v: ValueId) -> bool {
        let Def::Result(op, _) = b[v].def else { return true };
        self.of(b, op).is_none_or(|i| i.result_writes(self, b, v))
    }

    /// `isValueRead`: a use, or a use of what an alias-only use aliases, reads.
    pub fn value_read(&self, b: &Body<'_>, v: ValueId) -> bool {
        let mut work = b.uses_of(v);
        let mut seen = BTreeSet::new();
        while let Some(u) = work.pop() {
            if !seen.insert(u) {
                continue;
            }
            if self.alias_only(b, u) {
                for a in self.aliasing_values(b, u) {
                    work.extend(b.uses_of(a.value));
                }
            }
            if self.reads(b, u) {
                return true;
            }
        }
        false
    }

    /// `findValueInReverseUseDefChain`: from operand `start` up the aliasing operands, the
    /// values for which `cond` holds (and, per `config`, the leaves).
    pub fn reverse_chain(&self, b: &Body<'_>, start: Operand, cond: &mut dyn FnMut(&Self, ValueId) -> bool, config: TraversalConfig, mut visited_operands: Option<&mut BTreeSet<Operand>>) -> Vec<ValueId> {
        let mut visited = BTreeSet::new();
        let mut result: Vec<ValueId> = Vec::new();
        let mut work: Vec<ValueId> = vec![b[start.0].operands[start.1]];
        if let Some(vo) = visited_operands.as_deref_mut() {
            vo.insert(start);
        }
        let push = |r: &mut Vec<ValueId>, v: ValueId| {
            if !r.contains(&v) {
                r.push(v);
            }
        };
        while let Some(v) = work.pop() {
            if !config.revisit && visited.contains(&v) {
                if config.always_include_leaves {
                    push(&mut result, v);
                }
                continue;
            }
            visited.insert(v);
            if cond(self, v) {
                push(&mut result, v);
                continue;
            }
            if !config.follow_unknown_ops && self.of(b, b.owner_of(v)).is_none() {
                if config.always_include_leaves {
                    push(&mut result, v);
                }
                continue;
            }
            let aliases = self.aliasing_operands(b, v);
            if aliases.is_empty() {
                if config.always_include_leaves {
                    push(&mut result, v);
                }
                continue;
            }
            for a in aliases {
                let src = b[a.operand.0].operands[a.operand.1];
                let cast = matches!(b[v].def, Def::Result(d, _) if b.has(d, Trait::CastOpInterface));
                if (config.follow_equivalent_only && a.relation != BufferRelation::Equivalent)
                    || (config.follow_in_place_only && !self.in_place(b, a.operand))
                    || (config.follow_same_type_or_casts_only && b[src].ty != b[v].ty && !cast)
                {
                    if config.always_include_leaves {
                        push(&mut result, v);
                    }
                    continue;
                }
                if !work.contains(&src) {
                    work.push(src);
                }
                if let Some(vo) = visited_operands.as_deref_mut() {
                    vo.insert(a.operand);
                }
            }
        }
        result
    }

    /// `findDefinitions`: the values up the chain that write.
    pub fn definitions(&self, b: &Body<'_>, u: Operand) -> Vec<ValueId> {
        let config = TraversalConfig { always_include_leaves: false, ..TraversalConfig::default() };
        self.reverse_chain(b, u, &mut |s, v| s.value_writes(b, v), config, None)
    }

    /// `canOmitTensorCopy`.
    pub fn can_omit_copy(&self, b: &Body<'_>, u: Operand) -> bool {
        if self.undefined_contents(u) {
            return true;
        }
        if self.writes(b, u) && !self.reads(b, u) {
            return true;
        }
        !self.reads(b, u) && !self.aliasing_values(b, u).iter().any(|a| self.value_read(b, a.value))
    }

    /// `isInPlace`: decided by the analysis; without one, an operand that is not written (and
    /// `to_buffer`'s).
    pub fn in_place(&self, b: &Body<'_>, u: Operand) -> bool {
        match &self.one_shot {
            Some(o) => o.inplace.contains(&u),
            None => b[u.0].name == "bufferization.to_buffer" || !self.writes(b, u),
        }
    }

    /// `areEquivalentBufferizedValues`.
    pub fn equivalent(&self, a: ValueId, b: ValueId) -> bool {
        self.one_shot.as_ref().is_some_and(|o| o.equiv.same(a, b))
    }

    /// `areAliasingBufferizedValues`.
    pub fn aliasing(&self, a: ValueId, b: ValueId) -> bool {
        self.one_shot.as_ref().is_none_or(|o| o.alias.same(a, b))
    }

    /// `applyOnAliases`: the alias set of `v` (itself alone without an analysis).
    pub fn alias_set(&self, v: ValueId) -> Vec<ValueId> {
        self.one_shot.as_ref().map_or_else(|| vec![v], |o| o.alias.of(v))
    }

    /// Whether the module analysis has analyzed function `f` (`FuncOpAnalysisState::Analyzed`).
    pub fn func_analyzed(&self, f: OpId) -> bool {
        self.funcs().is_some_and(|x| x.analyzed.get(&f) == Some(&true))
    }

    /// Argument `i` of analyzed function `f` is read.
    pub fn func_reads(&self, f: OpId, i: usize) -> bool {
        self.funcs().is_some_and(|x| x.read.get(&f).is_some_and(|r| r.contains(&i)))
    }

    /// Argument `i` of analyzed function `f` is written.
    pub fn func_writes(&self, f: OpId, i: usize) -> bool {
        self.funcs().is_some_and(|x| x.written.get(&f).is_some_and(|r| r.contains(&i)))
    }

    /// The return values of `f` that may alias its argument `i`.
    pub fn func_aliasing(&self, f: OpId, i: usize) -> Vec<usize> {
        self.funcs().and_then(|x| x.aliasing.get(&f)?.get(&i).cloned()).unwrap_or_default()
    }

    /// The argument of `f` its return value `r` is equivalent to.
    pub fn func_equivalent(&self, f: OpId, r: usize) -> Option<usize> {
        self.funcs().and_then(|x| x.equivalent.get(&f)?.get(&r).copied())
    }

    fn funcs(&self) -> Option<&Funcs> {
        self.one_shot.as_ref()?.funcs.as_ref()
    }

    /// `hasUndefinedContents`.
    pub fn undefined_contents(&self, u: Operand) -> bool {
        self.one_shot.as_ref().is_some_and(|o| o.undefined.contains(&u))
    }

    /// `isWritable` (One-Shot): through the owner's interface; an unknown op's is not.
    pub fn writable(&self, b: &Body<'_>, v: ValueId) -> bool {
        self.of(b, b.owner_of(v)).is_some_and(|i| i.writable(self, b, v))
    }

    /// `detail::defaultResultBufferizesToMemoryWrite`.
    pub fn default_result_writes(&self, b: &Body<'_>, v: ValueId) -> bool {
        let op = b.owner_of(v);
        let Some(i) = self.of(b, op) else { return true };
        let operands = i.aliasing_operands(self, b, v);
        if operands.is_empty() || operands.iter().any(|a| self.writes(b, a.operand)) {
            return true;
        }
        let config = TraversalConfig { always_include_leaves: false, ..TraversalConfig::default() };
        operands.iter().any(|a| !self.reverse_chain(b, a.operand, &mut |s, x| b.is_ancestor(op, b.owner_of(x)) && s.value_writes(b, x), config, None).is_empty())
    }

    /// `detail::defaultGetAliasingOpOperands`.
    pub fn default_aliasing_operands(&self, b: &Body<'_>, v: ValueId) -> Vec<AliasingOperand> {
        let op = b.owner_of(v);
        let mut out = Vec::new();
        for i in 0..b[op].operands.len() {
            if !b.tensor_operand((op, i)) {
                continue;
            }
            for a in self.aliasing_values(b, (op, i)) {
                if a.value == v {
                    out.push(AliasingOperand { operand: (op, i), relation: a.relation, definite: a.definite });
                }
            }
        }
        out
    }

    /// `detail::defaultGetBufferType`: a block argument's from the options; a result equivalent
    /// to an operand has its buffer type, else a new buffer's in the default memory space.
    pub fn default_buffer_type<'a>(o: &BufferizationOptions, b: &Body<'a>, v: ValueId, stack: &mut Vec<ValueId>) -> Result<Type<'a>, Error> {
        if let Some(m) = BufferizationOptions::tensor_like(&b[v].ty) {
            return Ok(m);
        }
        let Type::Shaped(t) = &b[v].ty else { return Err(Error("expected a tensor".into())) };
        if !BufferizationOptions::valid_element(&t.elem) {
            return Err(Error(alloc::format!("'{}' op cannot bufferize value of type '{}': element type '{}' is not a valid memref element type", b[b.owner_of(v)].name, b[v].ty, t.elem)));
        }
        if let Def::Arg(..) = b[v].def {
            return Ok(o.memref_type(t, None, None));
        }
        let state = AnalysisState::new(o);
        let aliases = state.aliasing_operands(b, v);
        if let Some(a) = aliases.first().filter(|a| a.relation == BufferRelation::Equivalent) {
            return driver::buffer_type_in(o, b, b[a.operand.0].operands[a.operand.1], stack);
        }
        match o.default_memory_space(t) {
            Some(space) => Ok(o.memref_type(t, None, space)),
            None => Err(Error(alloc::format!("'{}' op could not infer memory space", b[b.owner_of(v)].name))),
        }
    }

    /// `getAliasingBranchOpOperands`: a block argument may alias (equivalent) each operand
    /// its predecessors forward to it.
    pub fn branch_aliasing_operands(b: &Body<'_>, v: ValueId) -> Vec<AliasingOperand> {
        let Def::Arg(blk, i) = b[v].def else { return Vec::new() };
        b.predecessors(blk)
            .into_iter()
            .filter_map(|(br, succ)| b.successor_operands(br, succ).and_then(|r| r.clone().nth(i as usize)).map(|k| AliasingOperand { operand: (br, k), relation: BufferRelation::Equivalent, definite: false }))
            .collect()
    }

    /// `OpWithUnstructuredControlFlowBufferizableOpInterfaceExternalModel::getBufferType`: a
    /// block argument takes the buffer type its predecessors forward, a fully dynamic layout
    /// when they differ.
    pub fn unstructured_buffer_type<'a>(o: &BufferizationOptions, b: &Body<'a>, v: ValueId, stack: &mut Vec<ValueId>) -> Result<Type<'a>, Error> {
        let Def::Arg(blk, i) = b[v].def else { return Self::default_buffer_type(o, b, v, stack) };
        let op = b.owner_of(v);
        let Type::Shaped(t) = &b[v].ty else { return Err(Error("expected a tensor".into())) };
        let space = |t: &Type<'a>| match t {
            Type::Shaped(m) => m.extras.iter().find(|a| !a.is_layout()).cloned(),
            _ => None,
        };
        let mut found: Option<Type<'a>> = None;
        for (br, succ) in b.predecessors(blk) {
            let Some(range) = b.successor_operands(br, succ) else { continue };
            let Some(k) = range.clone().nth(i as usize) else { continue };
            let fv = b[br].operands[k];
            if stack.contains(&fv) {
                continue;
            }
            let caller = if is_tensor(&b[fv].ty) { driver::buffer_type_in(o, b, fv, stack)? } else { b[fv].ty.clone() };
            found = Some(match found {
                None => caller,
                Some(f) if f == caller => f,
                Some(f) if space(&f) != space(&caller) => return Err(Error(alloc::format!("'{}' op incoming operands of block argument have inconsistent memory spaces", b[op].name))),
                Some(f) => BufferizationOptions::fully_dynamic(t, space(&f)),
            });
        }
        found.ok_or_else(|| Error(alloc::format!("'{}' op could not infer buffer type of block argument", b[op].name)))
    }

    /// `resolveTensorOpOperandConflicts`: an operand that does not bufferize in place gets a
    /// new tensor (`alloc_tensor`, a copy unless it can be omitted); when its only alias is a
    /// result of the op it only aliases, that result is copied after the op instead.
    pub fn resolve_tensor_conflicts(&self, rw: &mut Rewriter<'_, '_>, op: OpId) -> Result<(), Error> {
        let b = &*rw.body;
        let mut out_of_place_operands: Vec<(usize, bool)> = Vec::new();
        let mut out_of_place_values: Vec<(ValueId, bool)> = Vec::new();
        for i in 0..b[op].operands.len() {
            let u = (op, i);
            // Only builtin tensors (`TensorType`) are copied.
            if !matches!(&b[b[op].operands[i]].ty, Type::Shaped(s) if s.kind == ShapedKind::Tensor) || self.in_place(b, u) {
                continue;
            }
            if matches!(&b[b[op].operands[i]].ty, Type::Shaped(s) if s.shape.is_none()) {
                return Err(Error(alloc::format!("'{}' op copying of unranked tensors is not implemented", b[op].name)));
            }
            let aliases = self.aliasing_values(b, u);
            let single = match aliases.as_slice() {
                [a] if matches!(b[a.value].def, Def::Result(..)) && !self.writes(b, u) && self.aliasing_operands(b, a.value).len() == 1 && matches!(&b[a.value].ty, Type::Shaped(s) if s.shape.is_some()) => Some(a.value),
                _ => None,
            };
            let copy = !self.can_omit_copy(b, u);
            match single {
                Some(v) => out_of_place_values.push((v, copy)),
                None => out_of_place_operands.push((i, copy)),
            }
        }
        rw.set_before(op);
        for (i, copy) in out_of_place_operands {
            let v = rw.body[op].operands[i];
            let t = self.allocate_tensor_for(rw, v, copy)?;
            rw.modify(op, |b| b.set_operand(op, i, t));
        }
        rw.set_after(op);
        for (v, copy) in out_of_place_values {
            let t = self.allocate_tensor_for(rw, v, copy)?;
            let alloc = rw.body.owner_of(t);
            for (user, k) in rw.body.uses_of(v) {
                if user == alloc || rw.body[user].name == "tensor.dim" {
                    continue;
                }
                rw.modify(user, |b| b.set_operand(user, k, t));
            }
        }
        Ok(())
    }

    /// `allocateTensorForShapedValue`: a `bufferization.alloc_tensor` of `v`'s type, of its
    /// contents when `copy`, else of its (reified) sizes, in its buffer's memory space.
    pub fn allocate_tensor_for(&self, rw: &mut Rewriter<'_, '_>, v: ValueId, copy: bool) -> Result<ValueId, Error> {
        let Type::Shaped(t) = rw.body[v].ty.clone() else { return Err(Error("expected a shaped value".into())) };
        let shape = t.dims().unwrap_or_default();
        let mut dynamic: Vec<ValueId> = Vec::new();
        if !copy {
            let mut reified = false;
            if let Def::Result(owner, k) = rw.body[v].def
                && let Some(shapes) = rw.reify(owner)
            {
                reified = true;
                let sizes = shapes[k as usize].clone();
                for (d, s) in shape.iter().zip(sizes) {
                    if *d == mlirformat::Dim::DYNAMIC {
                        dynamic.push(rw.value_of(s));
                    }
                }
            }
            if !reified {
                // `populateDynamicDimSizes`.
                for (d, s) in shape.iter().enumerate() {
                    if *s == mlirformat::Dim::DYNAMIC {
                        let k = rw.value_of(Ofr::C(d as i64));
                        let dim = rw.create(OpData::build("tensor.dim").operands(&[v, k]), &[Type::Index]);
                        dynamic.push(rw.body[dim].results[0]);
                    }
                }
            }
        }
        let mut operands = dynamic.clone();
        if copy {
            operands.push(v);
        }
        let ty = Type::Shaped(t.clone());
        let mut data = OpData::build("bufferization.alloc_tensor").operands(&operands).segments(&[dynamic.len(), usize::from(copy), 0]);
        if !copy {
            let buffer = driver::buffer_type_in(self.options, rw.body, v, &mut Vec::new())?;
            let space = match &buffer {
                Type::Shaped(m) => m.extras.iter().find(|a| !a.is_layout()).cloned(),
                _ => None,
            };
            let space = match space {
                Some(s) => Some(s),
                None => self.options.default_memory_space(&t).flatten(),
            };
            if let Some(s) = space {
                data.set("memory_space", s);
            }
        }
        let a = rw.create(data, &[ty]);
        Ok(rw.body[a].results[0])
    }
}
