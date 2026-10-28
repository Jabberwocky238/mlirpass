//! ⭐ The op interfaces whose methods are C++ (`DeclareOpInterfaceMethods<...>`): what core
//! asks of an op that ODS's table cannot answer. Each dialect implements [`OpInterfaces`] once
//! for its ops; nothing is global: a [`Ctx`](crate::Ctx) holds the [`Interfaces`] it asks.

use alloc::vec::Vec;
use core::ops::Range;

use mlirformat::Attribute;

use crate::{BlockId, Body, EffectInstance, OpId, Operand, Point, Succ, ValueId};
pub use mlirformat::{Effect, EffectKind, EffectOn, Effects, OpInfo, Trait};

/// How a branch lays out its successor operands (`BranchOpInterface::getSuccessorOperands`).
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum BranchLayout {
    /// All operands go to successor 0.
    All,
    /// Operand group `first + i` (by `operandSegmentSizes`) goes to successor `i`.
    Groups { first: usize },
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
        self.ctx.opt.op_info(&self[op].name).is_some_and(|i| i.has(t))
    }

    /// `op`'s own memory effects (not its regions').
    pub fn effects(&self, op: OpId) -> Effects {
        self.ctx.opt.op_info(&self[op].name).map_or(Effects::Unknown, |i| i.effects)
    }
}
