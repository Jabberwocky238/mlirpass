//! ⭐ The op interfaces whose methods are C++ (`DeclareOpInterfaceMethods<...>`): what core
//! asks of an op that ODS's table cannot answer. Each dialect implements [`OpInterfaces`] once
//! for its ops; nothing is global: a [`Ctx`](crate::Ctx) holds the [`Interfaces`] it asks.

use alloc::{vec, format};
use alloc::borrow::Cow;
use alloc::vec::Vec;
use core::ops::Range;
use mlirformat::{Attribute, Type, ShapedKind, Str};
use crate::{BlockId, Body, InsertPoint, OpId, RegionId, ValueId, BranchLayout as Layout};

pub use mlirformat::{Effect, EffectKind, EffectOn, Effects, OpInfo, Trait};

/// A conditional branch's operand groups: the condition, then one per successor.
pub const CONDITIONAL_GROUPS: [usize; 2] = [1, 2];

/// The upstream ops that get the `getAsmResultNames` ODS generates (`genOpAsmInterface`):
/// several results, some named, no `OpAsmOpInterface` of their own. Each result group by its ODS
/// name, and whether it is variable length (`Optional` / `Variadic`); sorted by op name.
const ODS_RESULT_NAMES: &[(&str, &[(&str, bool)])] = &[
    ("arith.addui_extended", &[("sum", false), ("overflow", false)]),
    ("arith.mulsi_extended", &[("low", false), ("high", false)]),
    ("arith.mului_extended", &[("low", false), ("high", false)]),
    ("arm_sve.zip.x2", &[("resultV1", false), ("resultV2", false)]),
    ("arm_sve.zip.x4", &[("resultV1", false), ("resultV2", false), ("resultV3", false), ("resultV4", false)]),
    ("async.execute", &[("token", false), ("bodyResults", true)]),
    ("gpu.alloc", &[("memref", false), ("asyncToken", true)]),
    ("gpu.create_2to4_spmat", &[("spMat", false), ("asyncToken", true)]),
    ("gpu.create_bsr", &[("spmat", false), ("asyncToken", true)]),
    ("gpu.create_coo", &[("spmat", false), ("asyncToken", true)]),
    ("gpu.create_coo_aos", &[("spmat", false), ("asyncToken", true)]),
    ("gpu.create_csc", &[("spmat", false), ("asyncToken", true)]),
    ("gpu.create_csr", &[("spmat", false), ("asyncToken", true)]),
    ("gpu.create_dn_tensor", &[("dnTensor", false), ("asyncToken", true)]),
    ("gpu.rotate", &[("rotateResult", false), ("valid", false)]),
    ("gpu.sddmm_buffer_size", &[("bufferSz", false), ("asyncToken", true)]),
    ("gpu.shuffle", &[("shuffleResult", false), ("valid", false)]),
    ("gpu.spgemm_create_descr", &[("desc", false), ("asyncToken", true)]),
    ("gpu.spgemm_work_estimation_or_compute", &[("bufferSzNew", false), ("asyncToken", true)]),
    ("gpu.spmat_get_size", &[("rows", false), ("cols", false), ("nnz", false), ("asyncToken", true)]),
    ("gpu.spmm_buffer_size", &[("bufferSzs", true), ("asyncToken", true)]),
    ("gpu.spmv_buffer_size", &[("bufferSz", false), ("asyncToken", true)]),
    ("math.sincos", &[("sin", false), ("cos", false)]),
    ("ml_program.global_load_graph", &[("result", false), ("produceToken", false)]),
    ("shape.split_at", &[("head", false), ("tail", false)]),
    ("test.alloc_with_multiple_results", &[("index", false), ("memref", false)]),
    ("test.another_three_result", &[("result1", false), ("result2", false), ("result3", false)]),
    ("test.another_two_result", &[("result1", false), ("result2", false)]),
    ("test.asm_interface_op", &[("first", false), ("middle_results", true), ("", false)]),
    ("test.attr_sized_results", &[("a", true), ("b", true), ("c", false), ("d", true)]),
    ("test.attr_sized_results_compile_test", &[("a", true), ("b", false), ("c", true)]),
    ("test.format_custom_directive_results", &[("result", false), ("optResult", true), ("varResults", true)]),
    ("test.format_custom_directive_results_with_type_refs", &[("result", false), ("optResult", true), ("varResults", true)]),
    ("test.format_multiple_variadic_results", &[("result0", true), ("result1", true)]),
    ("test.format_optional_result_a_op", &[("optional", true), ("variadic", true)]),
    ("test.format_optional_result_b_op", &[("optional", true), ("variadic", true)]),
    ("test.format_optional_result_c_op", &[("optional", true), ("variadic", true)]),
    ("test.format_result_a_op", &[("buildable_res", false), ("result", false)]),
    ("test.format_result_b_op", &[("buildable_res", false), ("result", false)]),
    ("test.format_result_c_op", &[("buildable_res", false), ("result", false)]),
    ("test.int_types", &[("any_i16", false), ("si32", false), ("ui64", false), ("any_int", false)]),
    ("test.mixed_normal_variadic_result", &[("output1", true), ("output2", false), ("output3", true)]),
    ("test.mixed_variadic_out1", &[("output1", true), ("output2", false), ("output3", true)]),
    ("test.mixed_variadic_out2", &[("output1", true), ("output2", false), ("output3", true)]),
    ("test.mixed_variadic_out3", &[("output1", false), ("output2", true), ("output3", true)]),
    ("test.native_code_call4", &[("output1", false), ("output2", false)]),
    ("test.native_code_call5", &[("output1", false), ("output2", false)]),
    ("test.native_code_call6", &[("output1", false), ("output2", false)]),
    ("test.op_norm_ret", &[("Y", false), ("Z", false)]),
    ("test.op_with_result_shape_interface", &[("result1", false), ("result2", false)]),
    ("test.reify_shaped_type_using_reify_dim_of_result", &[("result1", false), ("result2", false)]),
    ("test.reify_shaped_type_using_reify_result_shapes", &[("result1", false), ("result2", false)]),
    ("test.reify_shaped_type_using_reify_shape_of_result", &[("result1", false), ("result2", false)]),
    ("test.tblgen_build_3", &[("resultA", true), ("resultB", true)]),
    ("test.three_result", &[("result1", false), ("result2", false), ("result3", false)]),
    ("test.two_result", &[("result1", false), ("result2", false)]),
    ("test.variadic_segment_prop", &[("b1", true), ("b2", true)]),
    ("tosa.cast_to_block_scaled", &[("output_data", false), ("output_scale", false)]),
    ("tosa.fft2d", &[("output_real", false), ("output_imag", false)]),
    ("tosa.rfft2d", &[("output_real", false), ("output_imag", false)]),
    ("vector.deinterleave", &[("res1", false), ("res2", false)]),
    ("vector.scan", &[("dest", false), ("accumulated_value", false)]),
    ("x86.avx512.vp2intersect", &[("k1", false), ("k2", false)]),
];

/// How a branch lays out its successor operands (`BranchOpInterface::getSuccessorOperands`).
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum BranchLayout {
    /// All operands go to successor 0.
    All,
    /// Operand group `groups[i]` (by `operandSegmentSizes`) goes to successor `i`.
    Groups { groups: &'static [usize] },
    /// Group `default` goes to successor 0; group `cases`, split by the dense array property
    /// `split`, to successors 1, 2, …
    Cases { default: Option<usize>, cases: usize, split: &'static str },
}

/// ⭐ One dialect's op interfaces, asked of its ops by name. Every method has the answer of an
/// op that does not implement the interface.
pub trait OpInterfaces: Sync {
    /// The dialect namespace whose ops these are.
    fn namespace(&self) -> &str;

    /// `ConstantLike`: the value a constant op holds.
    fn constant_value<'a>(&self, b: &Body<'a>, op: OpId) -> Option<Attribute<'a>> {
        b[op].get("value").cloned()
    }

    /// `MemoryEffectOpInterface::getEffects` of an op whose effects are C++
    /// ([`Effects::Custom`](crate::Effects)); `None`: not ported, the worst is assumed.
    fn effects(&self, _: &Body<'_>, _: OpId) -> Option<Vec<EffectInstance>> {
        None
    }

    /// ⭐ `Op::fold` of an op of a dialect mlirpass does not describe itself (an out-of-tree
    /// dialect): what the greedy driver and `Operation::fold` ask after the built-in folds of
    /// the upstream dialects. [`Fold::Failed`](crate::Fold) by default.
    fn fold<'a>(&self, _: &mut Body<'a>, _: OpId, _: &[Option<Attribute<'a>>]) -> crate::Fold<'a> {
        crate::Fold::Failed
    }

    /// `Dialect::materializeConstant` of such a dialect: the op that makes constant `value` of
    /// type `ty`; `None`: it cannot.
    fn materialize<'a>(&self, _: &Attribute<'a>, _: &mlirformat::Type<'a>) -> Option<crate::OpData<'a>> {
        None
    }

    /// `getCanonicalizationPatterns` of such a dialect's ops, added after the upstream ones
    /// (`canonicalize`).
    fn canonicalization_patterns(&self, _: &mut crate::PatternSet) {}

    /// `BufferizableOpInterface` of op `name` of this dialect, when it implements it.
    #[cfg(feature = "dialect.bufferization")]
    fn bufferizable(&self, _name: &str) -> Option<&dyn crate::Bufferizable> {
        None
    }

    /// `ReifyRankedShapedTypeOpInterface::reifyResultShapes`: the sizes of each result of `op`,
    /// from its operands, built at `rw`'s insertion point; `None`: `op` does not implement it.
    fn reify<'a>(&self, _: &mut crate::Rewriter<'_, 'a>, _: OpId) -> Option<Vec<Vec<crate::MemrefOfr>>> {
        None
    }

    /// `reifyDimOfResult`: size `dim` of result `result`; by default through [`reify`](Self::reify)
    /// of every result, as upstream's default does.
    fn reify_dim<'a>(&self, rw: &mut crate::Rewriter<'_, 'a>, op: OpId, result: usize, dim: usize) -> Option<crate::MemrefOfr> {
        self.reify(rw, op)?.get(result)?.get(dim).copied()
    }

    /// `ConditionallySpeculatable::getSpeculatability`: `None` not speculatable, `Some(false)`
    /// speculatable, `Some(true)` recursively.
    fn speculatability(&self, _: &Body<'_>, _: OpId) -> Option<bool> {
        None
    }

    /// `BranchOpInterface`: how `op` forwards operands to its successors; `None`: no branch.
    fn branch_layout(&self, _: &Body<'_>, _: OpId) -> Option<BranchLayout> {
        None
    }

    /// `SuccessorOperands` that also produce arguments: successor `i`'s produced count and
    /// forwarded range, for branches without a [`BranchLayout`].
    fn produced_successor_operands(&self, _: &Body<'_>, _: OpId, _: usize) -> Option<(usize, Range<usize>)> {
        None
    }

    /// `BranchOpInterface::getSuccessorForOperands`: the successor taken for the operand
    /// constants `c`; `None`: any.
    fn successor_for<'a>(&self, _: &Body<'a>, _: OpId, _: &[Option<Attribute<'a>>]) -> Option<BlockId> {
        None
    }

    /// Whether `op` implements `RegionBranchOpInterface`.
    fn is_region_branch(&self, _: &Body<'_>, _: OpId) -> bool {
        false
    }

    /// `getSuccessorRegions(point)`: each successor with its inputs.
    fn region_successors(&self, _: &Body<'_>, _: OpId, _: Point) -> Vec<(Succ, Vec<ValueId>)> {
        Vec::new()
    }

    /// `getEntrySuccessorOperands`: the operands of `op` flowing into its regions.
    fn entry_operands(&self, _: &Body<'_>, _: OpId) -> Vec<Operand> {
        Vec::new()
    }

    /// `getEntrySuccessorRegions(operands)`: of the successors `all`, those taken for the
    /// operand constants `c`.
    fn entry_successors<'a>(&self, _: &Body<'a>, _: OpId, _: &[Option<Attribute<'a>>], all: Vec<(Succ, Vec<ValueId>)>) -> Vec<(Succ, Vec<ValueId>)> {
        all
    }

    /// Whether terminator `t` implements `RegionBranchTerminatorOpInterface`.
    fn is_region_terminator(&self, _: &Body<'_>, _: OpId) -> bool {
        false
    }

    /// The leading operands of terminator `t` that are not forwarded (`scf.condition`'s
    /// condition).
    fn terminator_skip(&self, _: &Body<'_>, _: OpId) -> usize {
        0
    }

    /// A terminator's `getSuccessorRegions(operands)`: of `all`, those taken for `c`.
    fn terminator_successors<'a>(&self, _: &Body<'a>, _: OpId, _: &[Option<Attribute<'a>>], all: Vec<(Succ, Vec<ValueId>)>) -> Vec<(Succ, Vec<ValueId>)> {
        all
    }

    /// `CallOpInterface::getArgOperands`, when not all the operands.
    fn call_args(&self, _: &Body<'_>, _: OpId) -> Option<Range<usize>> {
        None
    }

    /// `CallOpInterface::getCallableForCallee` of an indirect call: the callee value.
    fn indirect_callee(&self, _: &Body<'_>, _: OpId) -> Option<ValueId> {
        None
    }

    /// `OpAsmOpInterface::getAsmResultNames`: the names `op` suggests for its results, in the
    /// order it sets them (custom form only; each is made unique where it is printed).
    fn asm_result_names(&self, b: &Body<'_>, op: OpId) -> Vec<(ValueId, Cow<'static, str>)> {
        b.ods_result_names(op)
    }

    /// `OpAsmOpInterface::getAsmBlockArgumentNames`: names for the arguments of `op`'s region `r`.
    fn asm_block_arg_names(&self, _: &Body<'_>, _: OpId, _: RegionId) -> Vec<(ValueId, Cow<'static, str>)> {
        Vec::new()
    }

    /// The dialect's `DialectInlinerInterface`; `None`: it has none, and nothing of it inlines.
    fn inliner(&self) -> Option<&dyn DialectInliner> {
        None
    }
}

/// ⭐ `DialectInlinerInterface`: what the inliner asks of a dialect. The defaults are the C++
/// defaults: nothing is legal, terminators are left alone.
pub trait DialectInliner: Sync {
    /// `isLegalToInline(call, callable, wouldBeCloned)`, asked of the call's dialect.
    fn legal_call(&self, _: &Body<'_>, _call: OpId, _callable: OpId) -> bool {
        false
    }

    /// `isLegalToInline(dest, src, ...)`, asked of the dialect of `dest`'s op.
    fn legal_region(&self, _: &Body<'_>, _dest: RegionId) -> bool {
        false
    }

    /// `isLegalToInline(op, dest, ...)`, asked of `op`'s dialect.
    fn legal_op(&self, _: &Body<'_>, _op: OpId) -> bool {
        false
    }

    /// `shouldAnalyzeRecursively`: whether `op`'s regions are checked too.
    fn analyze_recursively(&self, _: &Body<'_>, _op: OpId) -> bool {
        true
    }

    /// `handleTerminator(op, newDest)`: a terminator of a multi-block inlined region, branching
    /// to `dest` instead.
    fn branch_terminator(&self, _: &mut Body<'_>, _op: OpId, _dest: BlockId) {}

    /// `handleTerminator(op, valuesToRepl)`: the single block's terminator replacing the call's
    /// results.
    fn replace_with_terminator(&self, _: &mut Body<'_>, _op: OpId, _results: &[ValueId]) {}

    /// `materializeCallConversion`: an op casting `input` to `ty`, placed at `at`.
    fn call_conversion<'a>(&self, _: &mut Body<'a>, _input: ValueId, _ty: &Type<'a>, _at: InsertPoint, _loc: Option<mlirformat::Str<'a>>) -> Option<OpId> {
        None
    }

    /// `handleArgument` / `handleResult` (asked of the callable's dialect): the value to use
    /// for an argument or result with attributes `attrs`, built at `at`.
    fn handle_value<'a>(&self, _: &mut Body<'a>, _call: OpId, value: ValueId, _attrs: Option<&Attribute<'a>>, _result: bool, _at: InsertPoint) -> ValueId {
        value
    }

    /// `processInlinedCallBlocks`.
    fn process_inlined(&self, _: &mut Body<'_>, _call: OpId, _blocks: &[BlockId]) {}
}

/// The common inliner interface: every op legal, regions (`regions`) and calls (`calls`) as
/// the dialect says.
pub struct InlineAll {
    pub calls: bool,
    pub regions: bool,
}

impl DialectInliner for InlineAll {
    fn legal_call(&self, _: &Body<'_>, _: OpId, _: OpId) -> bool {
        self.calls
    }

    fn legal_region(&self, _: &Body<'_>, _: RegionId) -> bool {
        self.regions
    }

    fn legal_op(&self, _: &Body<'_>, _: OpId) -> bool {
        true
    }
}

/// The dialects' [`OpInterfaces`], by namespace.
#[derive(Default)]
pub struct Interfaces<'i> {
    dialects: Vec<&'i dyn OpInterfaces>,
}

impl<'i> Interfaces<'i> {
    /// Knows no dialect: every op answers as if it implemented nothing.
    pub fn new() -> Self {
        Self::default()
    }

    pub fn register(&mut self, d: &'i dyn OpInterfaces) -> &mut Self {
        self.dialects.push(d);
        self
    }

    /// Every registered dialect's interfaces, in registration order.
    pub fn iter(&self) -> impl Iterator<Item = &'i dyn OpInterfaces> + '_ {
        self.dialects.iter().copied()
    }

    /// The interfaces of the dialect op `name` belongs to.
    pub fn of(&self, name: &str) -> Option<&'i dyn OpInterfaces> {
        let ns = name.split_once('.').map_or(name, |(ns, _)| ns);
        self.dialects.iter().copied().find(|d| d.namespace() == ns)
    }
}

impl Body<'_> {
    /// The interfaces of `op`'s dialect.
    pub fn interfaces(&self, op: OpId) -> Option<&dyn OpInterfaces> {
        self.ctx.interfaces.of(&self[op].name)
    }
}

// ⭐ What ODS says about each op, as passes ask it: the table itself is mlirformat's
// ([`OpInfo`]).

impl Body<'_> {
    /// Whether `op` has trait (or interface) `t`.
    pub fn has(&self, op: OpId, t: Trait) -> bool {
        self[op].info.is_some_and(|i| i.has(t))
    }

    /// `op`'s own memory effects (not its regions').
    pub fn effects(&self, op: OpId) -> Effects {
        self[op].info.map_or(Effects::Unknown, |i| i.effects)
    }
}

// ============================================================================================
// Memory effects of ops, as `mlir/Interfaces/SideEffectInterfaces.cpp`.
//
// What ODS declares comes from the generated table; the ops that compute their effects in C++
// (`DeclareOpInterfaceMethods<MemoryEffectOpInterface>`) answer through their dialect's
// [`OpInterfaces`](crate::OpInterfaces).

/// `SideEffects::Resource`: what an effect touches. They form a tree by [`Resource::parent`]
/// (rooted at `Default`); two effects can only conflict when neither resource is disjoint
/// from the other.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Resource {
    Default,
    AutomaticAllocationScope,
    /// The test dialect's `TestResource`, under `Default`.
    Test,
    /// `TestNonAddressableResource`: runtime state no pointer reaches.
    TestNonAddressable,
    /// `TestNonAddressableSubResourceA` / `B`: the disjoint parents of `A` / `B`.
    TestNonAddressableSubA,
    TestNonAddressableSubB,
    TestNonAddressableA,
    TestNonAddressableB,
    /// OpenACC's runtime state: `acc::RuntimeCounters`, `acc::ConstructResource`,
    /// `acc::CurrentDeviceIdResource` (none addressable).
    AccRuntimeCounters,
    AccConstruct,
    AccCurrentDeviceId,
}

impl Resource {
    /// The C++ names ODS writes. An unknown one is taken as `Default`: it conflicts with all.
    const TABLE: &[(&str, Resource)] = &[
        ("DefaultResource", Resource::Default),
        ("AutomaticAllocationScopeResource", Resource::AutomaticAllocationScope),
        ("TestResource", Resource::Test),
        ("RuntimeCounters", Resource::AccRuntimeCounters),
        ("ConstructResource", Resource::AccConstruct),
        ("CurrentDeviceIdResource", Resource::AccCurrentDeviceId),
    ];

    /// `getParent`: every resource not saying otherwise sits under `Default`.
    pub fn parent(self) -> Option<Self> {
        match self {
            Resource::Default => None,
            Resource::TestNonAddressableA => Some(Resource::TestNonAddressableSubA),
            Resource::TestNonAddressableB => Some(Resource::TestNonAddressableSubB),
            _ => Some(Resource::Default),
        }
    }

    /// `isAddressable`: whether pointer-based memory can alias it.
    pub fn addressable(self) -> bool {
        !matches!(
            self,
            Resource::TestNonAddressable
                | Resource::TestNonAddressableSubA
                | Resource::TestNonAddressableSubB
                | Resource::TestNonAddressableA
                | Resource::TestNonAddressableB
                | Resource::AccRuntimeCounters
                | Resource::AccConstruct
                | Resource::AccCurrentDeviceId
        )
    }

    /// `isSubresourceOf`: `self` is `other` or below it.
    pub fn under(self, other: Self) -> bool {
        core::iter::successors(Some(self), |r| r.parent()).any(|r| r == other)
    }

    /// `isDisjointFrom`: neither is an ancestor of the other.
    pub fn disjoint(self, other: Self) -> bool {
        !self.under(other) && !other.under(self)
    }
}

impl From<&str> for Resource {
    fn from(name: &str) -> Self {
        Self::TABLE.iter().find(|(n, _)| *n == name).map_or(Resource::Default, |(_, r)| *r)
    }
}

/// One effect, on a value when it names one.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct EffectInstance {
    pub kind: EffectKind,
    pub value: Option<ValueId>,
    pub resource: Resource,
}

impl EffectInstance {
    pub const fn on(kind: EffectKind, value: Option<ValueId>) -> Self {
        Self { kind, value, resource: Resource::Default }
    }

    /// Whether this write can touch what `read` reads, as CSE's
    /// `hasOtherSideEffectingOpInBetween`.
    pub fn conflicts(&self, read: &EffectInstance) -> bool {
        !self.resource.disjoint(read.resource)
            && !(read.value.is_some() && !self.resource.addressable())
            && !(self.value.is_some() && !read.resource.addressable())
    }
}

impl Body<'_> {
    /// Whether `v` is a memref.
    pub fn is_memref(&self, v: ValueId) -> bool {
        matches!(&self[v].ty, Type::Shaped(s) if s.kind == ShapedKind::MemRef)
    }

    /// The `i`th group of `op`'s operands, by `operandSegmentSizes` when it has one.
    pub fn operand_group(&self, op: OpId, i: usize) -> &[ValueId] {
        let operands = &self[op].operands;
        match self.segments(op, "operandSegmentSizes") {
            Some(sizes) => {
                let start: usize = sizes.iter().take(i).sum();
                operands.get(start..start + sizes.get(i).copied().unwrap_or(0)).unwrap_or(&[])
            }
            None => operands.get(i..=i).unwrap_or(&[]),
        }
    }

    /// `setNameFn(getResult(), name)`: `name` for `op`'s first result.
    pub fn result_named(&self, op: OpId, name: impl Into<Cow<'static, str>>) -> Vec<(ValueId, Cow<'static, str>)> {
        self[op].results.first().map(|r| (*r, name.into())).into_iter().collect()
    }

    /// The `getAsmResultNames` ODS writes for an op of several results that names them
    /// ([`ODS_RESULT_NAMES`]): each result group's name on its first result, an empty group
    /// skipped, an unnamed one numbered. Nothing for an op not in the table.
    pub fn ods_result_names(&self, op: OpId) -> Vec<(ValueId, Cow<'static, str>)> {
        let Ok(at) = ODS_RESULT_NAMES.binary_search_by(|(n, _)| (*n).cmp(&*self[op].name)) else { return Vec::new() };
        let names = ODS_RESULT_NAMES[at].1;
        let results = &self[op].results;
        let variadic = names.iter().filter(|(_, v)| *v).count();
        let sizes: Vec<usize> = match self.segments(op, "resultSegmentSizes") {
            Some(sizes) => sizes,
            None => {
                // One variadic group takes what the others leave; several split it evenly
                // (`SameVariadicResultSize`).
                let each = if variadic == 0 { 0 } else { results.len().saturating_sub(names.len() - variadic) / variadic };
                names.iter().map(|(_, v)| if *v { each } else { 1 }).collect()
            }
        };
        let mut at = 0;
        let mut out = Vec::new();
        for ((name, _), size) in names.iter().zip(sizes) {
            if size > 0 && let Some(r) = results.get(at) {
                out.push((*r, Cow::Borrowed(*name)));
            }
            at += size;
        }
        out
    }

    /// ⭐ `MemoryEffectOpInterface::getEffects`; `None`: the op does not implement it.
    pub fn effects_of(&self, op: OpId) -> Option<Vec<EffectInstance>> {
        match self.effects(op) {
            Effects::Unknown => None,
            Effects::Known(list) => Some(
                list.iter()
                    .flat_map(|e| {
                        let values: Vec<Option<ValueId>> = match e.on {
                            EffectOn::Op => vec![None],
                            EffectOn::Operand(i) => self.operand_group(op, i as usize).iter().map(|v| Some(*v)).collect(),
                            EffectOn::Result(i) => vec![self[op].results.get(i as usize).copied()],
                        };
                        values.into_iter().map(|value| EffectInstance { kind: e.kind, value, resource: e.resource.into() })
                    })
                    .collect(),
            ),
            Effects::Custom => Some(self.custom_effects(op)),
        }
    }

    /// The effects of the ops whose `getEffects` is C++, from their dialect's interfaces.
    fn custom_effects(&self, op: OpId) -> Vec<EffectInstance> {
        self.interfaces(op).and_then(|i| i.effects(self, op)).unwrap_or_else(|| vec![EffectInstance::on(EffectKind::Write, None), EffectInstance::on(EffectKind::Read, None)])
    }

    /// Whether `op` is registered: known to the op table.
    pub fn registered(&self, op: OpId) -> bool {
        self[op].info.is_some()
    }

    /// `mightHaveTrait`: an unregistered op might have any.
    pub fn might_have(&self, op: OpId, t: Trait) -> bool {
        !self.registered(op) || self.has(op, t)
    }

    fn recursive_effects(&self, op: OpId) -> bool {
        self.has(op, Trait::HasRecursiveMemoryEffects)
    }

    fn nested_ops(&self, op: OpId) -> Vec<OpId> {
        self[op].regions.iter().flat_map(|r| &self[*r].blocks).flat_map(|b| self.ops(*b)).collect()
    }

    /// `isMemoryEffectFree`.
    pub fn is_memory_effect_free(&self, op: OpId) -> bool {
        match self.effects_of(op) {
            Some(e) if !e.is_empty() => return false,
            Some(_) if !self.recursive_effects(op) => return true,
            None if !self.recursive_effects(op) => return false,
            _ => {}
        }
        self.nested_ops(op).into_iter().all(|o| self.is_memory_effect_free(o))
    }

    /// `getSpeculatability`: `None` not speculatable, `Some(false)` speculatable, `Some(true)`
    /// recursively (as far as its regions are).
    fn speculatability(&self, op: OpId) -> Option<bool> {
        if self.has(op, Trait::AlwaysSpeculatableImplTrait) {
            return Some(false);
        }
        if self.has(op, Trait::RecursivelySpeculatableImplTrait) {
            return Some(true);
        }
        if !self.has(op, Trait::ConditionallySpeculatable) {
            return None;
        }
        self.interfaces(op).and_then(|i| i.speculatability(self, op))
    }

    /// `isSpeculatable`.
    pub fn is_speculatable(&self, op: OpId) -> bool {
        match self.speculatability(op) {
            None => false,
            Some(false) => true,
            Some(true) => self.nested_ops(op).into_iter().all(|o| self.is_speculatable(o)),
        }
    }

    /// `isPure`: speculatable and free of memory effects.
    pub fn is_pure(&self, op: OpId) -> bool {
        self.is_speculatable(op) && self.is_memory_effect_free(op)
    }

    /// `hasSingleEffect<kind>(op)`: it has effects, and all of them are `kind`.
    pub fn has_only_effect(&self, op: OpId, kind: EffectKind) -> bool {
        self.effects_of(op).is_some_and(|e| !e.is_empty() && e.iter().all(|x| x.kind == kind))
    }

    /// `hasEffect<kind>(op)`.
    pub fn has_effect(&self, op: OpId, kind: EffectKind) -> bool {
        self.effects_of(op).is_some_and(|e| e.iter().any(|x| x.kind == kind))
    }

    /// `getEffectsRecursively`; `None` when some op's effects are unknown.
    pub fn effects_recursively(&self, op: OpId) -> Option<Vec<EffectInstance>> {
        let mut out = Vec::new();
        let mut work = vec![op];
        while let Some(o) = work.pop() {
            let recursive = self.recursive_effects(o);
            if recursive {
                work.extend(self.nested_ops(o));
            }
            match self.effects_of(o) {
                Some(e) => out.extend(e),
                None if !recursive => return None,
                None => {}
            }
        }
        Some(out)
    }

    /// `wouldOpBeTriviallyDead`: erasable if its results were unused.
    pub fn would_be_trivially_dead(&self, op: OpId) -> bool {
        if self.might_have(op, Trait::IsTerminator) || self.has(op, Trait::SymbolOpInterface) {
            return false;
        }
        let mut work = vec![op];
        while let Some(o) = work.pop() {
            let recursive = self.recursive_effects(o);
            if recursive {
                // Upstream walks nested ops last-in first-out too; only the verdict matters.
                work.extend(self.nested_ops(o));
            }
            match self.effects_of(o) {
                Some(effects) => {
                    // Allocating its own results is fine, and so is reading.
                    let own = |v: Option<ValueId>| v.is_some_and(|v| self.def_op(v) == Some(o));
                    let allocs: Vec<_> = effects.iter().filter(|e| e.kind == EffectKind::Allocate && own(e.value)).map(|e| e.value).collect();
                    if !effects.iter().all(|e| (e.value.is_some() && allocs.contains(&e.value)) || e.kind == EffectKind::Read) {
                        return false;
                    }
                }
                None if recursive => {}
                None => return false,
            }
        }
        true
    }

    /// `isOpTriviallyDead`: no result is used, and nothing else would notice it gone.
    pub fn is_trivially_dead(&self, op: OpId) -> bool {
        self[op].results.iter().all(|r| self[*r].uses.is_empty()) && self.would_be_trivially_dead(op)
    }
}

// ============================================================================================
// `BranchOpInterface`: which operands of a branch go to which successor's arguments.

impl Body<'_> {
    fn layout(&self, op: OpId) -> Option<Layout> {
        self.interfaces(op)?.branch_layout(self, op)
    }

    /// The sizes in dense array `name` of `op` (`operandSegmentSizes` and the like).
    pub fn segments(&self, op: OpId, name: &str) -> Option<Vec<usize>> {
        match self[op].get(name)? {
            Attribute::DenseArray { values, .. } => Some(values.iter().map(|v| v.parse().unwrap_or(0)).collect()),
            _ => None,
        }
    }

    pub fn set_segments(&mut self, op: OpId, name: &str, sizes: &[usize]) {
        let Some(Attribute::DenseArray { ty, .. }) = self[op].get(name).cloned() else { return };
        let values = sizes.iter().map(|s| Cow::Owned(format!("{s}"))).collect();
        self[op].set(name, Attribute::DenseArray { ty, values });
    }

    /// Start of operand group `g`.
    fn group_start(&self, op: OpId, g: usize) -> usize {
        self.segments(op, "operandSegmentSizes").map_or(g, |s| s.iter().take(g).sum())
    }

    /// ⭐ `getSuccessorOperands(i)`: the flat operand range forwarded to successor `i`'s
    /// arguments; `None` when `op` is not a branch this crate knows.
    pub fn successor_operands(&self, op: OpId, i: usize) -> Option<core::ops::Range<usize>> {
        let n = self[op].operands.len();
        match self.layout(op)? {
            Layout::All => Some(0..n),
            Layout::Groups { groups } => {
                let sizes = self.segments(op, "operandSegmentSizes")?;
                let g = *groups.get(i)?;
                let start = self.group_start(op, g);
                Some(start..start + sizes.get(g).copied().unwrap_or(0))
            }
            Layout::Cases { default, cases, split } => {
                if let (Some(d), 0) = (default, i) {
                    let sizes = self.segments(op, "operandSegmentSizes")?;
                    let start = self.group_start(op, d);
                    return Some(start..start + sizes[d]);
                }
                let k = i - usize::from(default.is_some());
                let parts = self.segments(op, split)?;
                let start = self.group_start(op, cases) + parts.iter().take(k).sum::<usize>();
                Some(start..start + parts.get(k).copied().unwrap_or(0))
            }
        }
    }

    /// Whether `op` implements `BranchOpInterface` (as far as this crate knows).
    pub fn is_branch(&self, op: OpId) -> bool {
        self.layout(op).is_some()
    }

    /// `SuccessorOperands` of successor `i`: the produced arguments, then the range of the
    /// forwarded operands.
    pub fn successor_layout(&self, op: OpId, i: usize) -> Option<(usize, core::ops::Range<usize>)> {
        match self.interfaces(op).and_then(|f| f.produced_successor_operands(self, op, i)) {
            Some(l) => Some(l),
            None => self.successor_operands(op, i).map(|r| (0, r)),
        }
    }

    /// `getSuccessorOperands(i)[arg]`: what `op` passes to argument `arg` of successor `i`
    /// (`Some(None)`: an argument the branch produces; `None`: not a branch this crate knows).
    pub fn successor_arg_value(&self, op: OpId, i: usize, arg: usize) -> Option<Option<crate::ValueId>> {
        let (produced, range) = self.successor_layout(op, i)?;
        Some(arg.checked_sub(produced).and_then(|j| range.clone().nth(j)).map(|k| self[op].operands[k]))
    }

    /// Drops what `op` passes to the arguments `args` (ascending) of successor `i`; a produced
    /// one has no operand.
    pub fn erase_successor_args(&mut self, op: OpId, i: usize, args: &[usize]) {
        let produced = self.successor_layout(op, i).map_or(0, |(p, _)| p);
        let dead: Vec<usize> = args.iter().filter_map(|a| a.checked_sub(produced)).collect();
        self.erase_successor_operands(op, i, &dead);
    }

    /// Whether `op` forwards operands to its successors: a branch, or a terminator whose
    /// successor operands also produce arguments.
    pub fn forwards_to_successors(&self, op: OpId) -> bool {
        self.is_branch(op) || self.interfaces(op).is_some_and(|f| f.produced_successor_operands(self, op, 0).is_some())
    }

    /// Appends `values` to the operands forwarded to successor `i`.
    pub fn append_successor_operands(&mut self, op: OpId, i: usize, values: &[crate::ValueId]) {
        let Some(range) = self.successor_operands(op, i) else { return };
        let mut operands = self[op].operands.clone();
        operands.insert_many(range.end, values.iter().copied());
        self.set_operands(op, operands);
        self.resize_successor_group(op, i, values.len() as isize);
    }

    /// Grows (or shrinks) the segment sizes of successor `i`'s operand group by `by`.
    fn resize_successor_group(&mut self, op: OpId, i: usize, by: isize) {
        let group = match self.layout(op) {
            Some(Layout::Groups { groups }) => groups.get(i).copied(),
            Some(Layout::Cases { default: Some(d), .. }) if i == 0 => Some(d),
            Some(Layout::Cases { default, cases, split }) => {
                let k = i - usize::from(default.is_some());
                if let Some(mut parts) = self.segments(op, split) {
                    parts[k] = parts[k].saturating_add_signed(by);
                    self.set_segments(op, split, &parts);
                }
                Some(cases)
            }
            _ => None,
        };
        if let (Some(g), Some(mut sizes)) = (group, self.segments(op, "operandSegmentSizes")) {
            sizes[g] = sizes[g].saturating_add_signed(by);
            self.set_segments(op, "operandSegmentSizes", &sizes);
        }
    }

    /// Drops the `j`th operand forwarded to successor `i`, keeping the segment sizes right.
    pub fn erase_successor_operand(&mut self, op: OpId, i: usize, j: usize) {
        self.erase_successor_operands(op, i, &[j]);
    }

    /// Drops the operands forwarded to successor `i` at `dead` (ascending, within its group) in
    /// one go, keeping the segment sizes right.
    pub fn erase_successor_operands(&mut self, op: OpId, i: usize, dead: &[usize]) {
        if dead.is_empty() {
            return;
        }
        let Some(range) = self.successor_operands(op, i) else { return };
        let operands: crate::Ids<crate::ValueId> = self[op].operands.iter().enumerate().filter(|(at, _)| !(range.contains(at) && dead.binary_search(&(at - range.start)).is_ok())).map(|(_, v)| *v).collect();
        self.set_operands(op, operands);
        self.resize_successor_group(op, i, -(dead.len() as isize));
    }
}

// `RegionBranchOpInterface`: where control goes between an op and its regions, and which
// values flow along: each dialect's [`OpInterfaces`](crate::OpInterfaces) answer
// `getSuccessorRegions`, `getEntrySuccessorOperands` and
// `RegionBranchTerminatorOpInterface::getSuccessorOperands` for its ops.

/// Where control is: entering from the parent op, or at a region's terminator.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Point {
    Parent,
    Terminator(OpId),
}

/// Where control goes.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Succ {
    Parent,
    Region(usize),
}

/// One operand by its owner and index.
pub type Operand = (OpId, usize);

impl<'a> Body<'a> {
    /// Whether `op` implements the interface, as far as this crate describes it.
    pub fn is_region_branch(&self, op: OpId) -> bool {
        self.interfaces(op).is_some_and(|i| i.is_region_branch(self, op))
    }

    /// The entry block's arguments of region `r` of `op`, from `skip` on.
    pub fn region_args(&self, op: OpId, r: usize, skip: usize) -> Vec<ValueId> {
        let region = self[op].regions[r];
        self[region].blocks.first().map(|b| self[*b].args.iter().skip(skip).copied().collect()).unwrap_or_default()
    }

    /// `getSuccessorRegions(point)`: each successor with its inputs.
    pub fn region_successors(&self, op: OpId, point: Point) -> Vec<(Succ, Vec<ValueId>)> {
        self.interfaces(op).map(|i| i.region_successors(self, op, point)).unwrap_or_default()
    }

    /// `getEntrySuccessorRegions(operands)`: the successors taken for `op`'s operand constants
    /// `c`.
    pub fn entry_successors(&self, op: OpId, c: &[Option<Attribute<'a>>]) -> Vec<(Succ, Vec<ValueId>)> {
        let all = self.region_successors(op, Point::Parent);
        match self.interfaces(op) {
            Some(i) => i.entry_successors(self, op, c, all),
            None => all,
        }
    }

    /// A region terminator `t`'s `getSuccessorRegions(operands)` in region-branch `op`.
    pub fn terminator_successors(&self, op: OpId, t: OpId, c: &[Option<Attribute<'a>>]) -> Vec<(Succ, Vec<ValueId>)> {
        let all = self.region_successors(op, Point::Terminator(t));
        match self.interfaces(t) {
            Some(i) => i.terminator_successors(self, t, c, all),
            None => all,
        }
    }

    /// `isRegionReachable` (`traverseRegionGraph`): whether region `to` of region-branch `op` is
    /// reached from region `from` through its regions' terminators.
    pub fn region_reachable(&self, op: OpId, from: usize, to: usize) -> bool {
        let regions = &self[op].regions;
        let mut visited = alloc::vec![false; regions.len()];
        visited[from] = true;
        let mut work = Vec::new();
        let enqueue = |r: usize, work: &mut Vec<usize>| {
            for blk in self[regions[r]].blocks.iter() {
                let Some(t) = self.last_op(*blk) else { continue };
                if !self.interfaces(t).is_some_and(|i| i.is_region_terminator(self, t)) {
                    continue;
                }
                work.extend(self.region_successors(op, Point::Terminator(t)).into_iter().filter_map(|(s, _)| if let Succ::Region(i) = s { Some(i) } else { None }));
            }
        };
        enqueue(from, &mut work);
        while let Some(next) = work.pop() {
            if next == to {
                return true;
            }
            if visited[next] {
                continue;
            }
            visited[next] = true;
            enqueue(next, &mut work);
        }
        false
    }

    /// `RegionBranchOpInterface::isRepetitiveRegion`: region `index` of `op` reaches itself.
    pub fn repetitive_region(&self, op: OpId, index: usize) -> bool {
        self.is_region_branch(op) && self.region_reachable(op, index, index)
    }

    /// `insideMutuallyExclusiveRegions`: `a` and `b` sit in distinct regions of a region-branch
    /// op neither of which reaches the other.
    pub fn mutually_exclusive(&self, a: OpId, b: OpId) -> bool {
        let mut at = self.parent_op(a);
        while let Some(br) = at {
            if !self.is_region_branch(br) {
                at = self.parent_op(br);
                continue;
            }
            if br == b || !self.is_ancestor(br, b) {
                at = self.parent_op(br);
                continue;
            }
            let region_of = |x: OpId| self[br].regions.iter().position(|r| self[*r].blocks.iter().any(|blk| self.ops_of_block_contain(*blk, x)));
            let (Some(ra), Some(rb)) = (region_of(a), region_of(b)) else { return false };
            return ra != rb && !self.region_reachable(br, ra, rb) && !self.region_reachable(br, rb, ra);
        }
        false
    }

    /// Whether `x` is, or is nested in, an op of `block` (`findAncestorOpInBlock`).
    pub fn ops_of_block_contain(&self, block: BlockId, mut x: OpId) -> bool {
        loop {
            if self[x].parent == Some(block) {
                return true;
            }
            match self.parent_op(x) {
                Some(p) => x = p,
                None => return false,
            }
        }
    }

    /// The operands flowing from `point` to its successors.
    pub fn forwarded(&self, op: OpId, point: Point) -> Vec<Operand> {
        match point {
            Point::Parent => self.interfaces(op).map(|i| i.entry_operands(self, op)).unwrap_or_default(),
            Point::Terminator(t) => {
                let skip = self.interfaces(t).map_or(0, |i| i.terminator_skip(self, t));
                (skip..self[t].operands.len()).map(|i| (t, i)).collect()
            }
        }
    }

    /// `getAllRegionBranchPoints`: the parent, then each region terminator in order.
    pub fn branch_points(&self, op: OpId) -> Vec<Point> {
        let mut out = vec![Point::Parent];
        for r in &self[op].regions {
            for b in &self[*r].blocks {
                if let Some(t) = self.last_op(*b)
                    && self.interfaces(t).is_some_and(|i| i.is_region_terminator(self, t))
                {
                    out.push(Point::Terminator(t));
                }
            }
        }
        out
    }

    /// `getSuccessorOperandInputMapping`: each forwarded operand with the inputs it reaches.
    pub fn operand_inputs(&self, op: OpId) -> Vec<(Operand, Vec<ValueId>)> {
        let mut out: Vec<(Operand, Vec<ValueId>)> = Vec::new();
        for p in self.branch_points(op) {
            let operands = self.forwarded(op, p);
            for (_, inputs) in self.region_successors(op, p) {
                for (o, i) in operands.iter().zip(inputs) {
                    match out.iter_mut().find(|e| e.0 == *o) {
                        Some(e) => e.1.push(i),
                        None => out.push((*o, vec![i])),
                    }
                }
            }
        }
        out
    }

    /// The inverse: each input with the operands that reach it, inputs in first-seen order.
    pub fn input_operands(&self, op: OpId) -> Vec<(ValueId, Vec<Operand>)> {
        let mut out: Vec<(ValueId, Vec<Operand>)> = Vec::new();
        for (o, inputs) in self.operand_inputs(op) {
            for i in inputs {
                match out.iter_mut().find(|e| e.0 == i) {
                    Some(e) => e.1.push(o),
                    None => out.push((i, vec![o])),
                }
            }
        }
        out
    }

    /// `eraseOperands` on `op`, keeping the uses right.
    pub fn erase_operands(&mut self, op: OpId, which: &[usize]) {
        let kept: crate::Ids<_> = self[op].operands.iter().enumerate().filter(|(i, _)| !which.contains(i)).map(|(_, v)| *v).collect();
        self.set_operands(op, kept);
    }
}

// ============================================================================================
// Symbols and symbol tables, as `mlir/IR/SymbolTable.cpp`.

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Visibility {
    Public,
    Private,
    Nested,
}

/// One symbol reference held by an op: `@a::@b` as `["@a", "@b"]` segments without the `@`.
#[derive(Debug, Clone, PartialEq)]
pub struct SymbolUse<'a> {
    pub user: OpId,
    pub path: Vec<Str<'a>>,
}

impl<'a> Body<'a> {
    /// `op`'s symbol name, when it is a symbol (and has one: a module may not).
    pub fn sym_name(&self, op: OpId) -> Option<&str> {
        self.has(op, Trait::SymbolOpInterface).then(|| self[op].get_str("sym_name")).flatten()
    }

    pub fn visibility(&self, op: OpId) -> Visibility {
        match self[op].get_str("sym_visibility") {
            Some("private") => Visibility::Private,
            Some("nested") => Visibility::Nested,
            _ => Visibility::Public,
        }
    }

    pub fn set_visibility(&mut self, op: OpId, v: Visibility) {
        let lit = match v {
            Visibility::Public => {
                self[op].remove("sym_visibility");
                return;
            }
            Visibility::Private => "private",
            Visibility::Nested => "nested",
        };
        self[op].set("sym_visibility", Attribute::Str { lit: lit.into(), ty: None });
    }

    /// Whether `op` defines a symbol table.
    pub fn is_symbol_table(&self, op: OpId) -> bool {
        self.has(op, Trait::SymbolTable)
    }

    /// An op that may be a symbol table nobody can tell about: one region, dialect unknown.
    pub fn maybe_unknown_symbol_table(&self, op: OpId) -> bool {
        self[op].regions.len() == 1 && !self.ctx.opt.knows_dialect_of(&self[op].name)
    }

    /// The symbol named `name` directly in symbol table `table`. In a lent body, a symbol of
    /// its module it does not hold is more than it knows ([`Body::escape`]).
    pub fn lookup(&self, table: OpId, name: &str) -> Option<OpId> {
        let found = self.find_symbol(table, name);
        if found.is_none() && table == self.root {
            self.escape();
        }
        found
    }

    /// [`lookup`](Self::lookup) of what this body holds, nothing more asked.
    pub fn find_symbol(&self, table: OpId, name: &str) -> Option<OpId> {
        let region = *self[table].regions.first()?;
        let indexed = self.symbols.table.filter(|t| *t == table).and_then(|_| self.symbols.names.get(name).copied());
        if let Some(o) = indexed.filter(|o| self.holds(*o) && self[*o].parent.is_some_and(|b| self[b].parent == Some(region)) && self.sym_name(*o) == Some(name)) {
            return Some(o);
        }
        self[region].blocks.iter().flat_map(|b| self.ops(*b)).find(|o| self.sym_name(*o) == Some(name))
    }

    /// Indexes `table`'s symbols for [`find_symbol`](Self::find_symbol) (the last index goes).
    pub fn index_symbols(&mut self, table: OpId) {
        let mut names = alloc::collections::BTreeMap::new();
        if let Some(region) = self[table].regions.first() {
            for o in self[*region].blocks.iter().flat_map(|b| self.ops(*b)) {
                if let Some(n) = self.sym_name(o) {
                    names.entry(alloc::string::String::from(n)).or_insert(o);
                }
            }
        }
        self.symbols = crate::ir::SymbolIndex { table: Some(table), names };
    }

    /// Attribute `attr` of symbol `name` in `table`: in a lent body, read off the module's
    /// symbols as they were when it was lent ([`Body::outside_symbol`]).
    pub fn symbol_attr(&self, table: OpId, name: &str, attr: &str) -> Option<Attribute<'a>> {
        match self.find_symbol(table, name) {
            Some(f) => self[f].get(attr).cloned(),
            None => self.outside_symbol(table, name)?.get(attr).cloned(),
        }
    }

    /// Every symbol along `path` from `table` (`@a::@b`: `a`, then `b` inside it); `None` when
    /// a segment is missing.
    pub fn lookup_path(&self, table: OpId, path: &[Str<'_>]) -> Option<Vec<OpId>> {
        let mut out = Vec::new();
        let mut at = table;
        for seg in path {
            at = self.lookup(at, Self::unquote(seg))?;
            out.push(at);
        }
        Some(out)
    }

    /// `"name"` ⇒ `name`; symbol references keep their quotes when they need them.
    pub(crate) fn unquote(s: &str) -> &str {
        s.strip_prefix('"').and_then(|s| s.strip_suffix('"')).unwrap_or(s)
    }

    fn refs_in(a: &Attribute<'a>, user: OpId, out: &mut Vec<SymbolUse<'a>>) {
        match a {
            Attribute::SymbolRef(path) => out.push(SymbolUse { user, path: path.clone() }),
            Attribute::Array(xs) => xs.iter().for_each(|x| Self::refs_in(x, user, out)),
            Attribute::Dict(d) => d.iter().filter_map(|n| n.value.as_ref()).for_each(|x| Self::refs_in(x, user, out)),
            _ => {}
        }
    }

    /// The symbol references `op` itself holds, inherent and discardable alike.
    fn own_refs(&self, op: OpId, out: &mut Vec<SymbolUse<'a>>) {
        let d = &self[op];
        d.properties.iter().filter_map(|n| n.value.as_ref()).for_each(|x| Self::refs_in(x, op, out));
        d.attributes.iter().filter_map(|n| n.value.as_ref()).for_each(|x| Self::refs_in(x, op, out));
    }

    /// Uses nested in `regions` of `op`, not entering nested symbol tables; `None` on a
    /// potentially unknown symbol table.
    fn region_refs(&self, op: OpId, out: &mut Vec<SymbolUse<'a>>) -> Option<()> {
        let mut work: Vec<_> = self[op].regions.clone().to_vec();
        while let Some(r) = work.pop() {
            for o in self[r].blocks.iter().flat_map(|b| self.ops(*b)) {
                let o = &o;
                if self.maybe_unknown_symbol_table(*o) {
                    return None;
                }
                self.own_refs(*o, out);
                if !self.is_symbol_table(*o) {
                    work.extend(self[*o].regions.iter().copied());
                }
            }
        }
        Some(())
    }

    /// `SymbolTable::getSymbolUses(region)` over the regions of `op`.
    pub fn region_symbol_uses(&self, op: OpId) -> Option<Vec<SymbolUse<'a>>> {
        let mut out = Vec::new();
        self.region_refs(op, &mut out)?;
        Some(out)
    }

    /// [`region_symbol_uses`](Self::region_symbol_uses) with `op`'s ops split among `exec`'s
    /// threads ([`Body::map_ops_in`]; in no particular order).
    pub fn region_symbol_uses_in<X: moremath::Executor + Sync>(&self, op: OpId, exec: &X) -> Option<Vec<SymbolUse<'a>>> {
        let parts = self.map_ops_in(op, exec, &|b: &Self, part: &[OpId]| {
            let mut out = Vec::new();
            let ok = part.iter().all(|o| {
                if b.maybe_unknown_symbol_table(*o) {
                    return false;
                }
                b.own_refs(*o, &mut out);
                b.is_symbol_table(*o) || b.region_refs(*o, &mut out).is_some()
            });
            ok.then_some(out)
        });
        parts.into_iter().try_fold(Vec::new(), |mut all, part| {
            all.extend(part?);
            Some(all)
        })
    }

    /// ⭐ `SymbolTable::getSymbolUses(op)`: the references on `op` and nested in it, not entering
    /// nested symbol tables; `None` when an op might be an unknown symbol table.
    pub fn symbol_uses(&self, op: OpId) -> Option<Vec<SymbolUse<'a>>> {
        if self.maybe_unknown_symbol_table(op) {
            return None;
        }
        let mut out = Vec::new();
        self.own_refs(op, &mut out);
        if !self.is_symbol_table(op) {
            self.region_refs(op, &mut out)?;
        }
        Some(out)
    }
}
