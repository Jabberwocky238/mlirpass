//! ⭐ Dialect conversion, as `DialectConversion.cpp` in its default (rollback) mode.
//!
//! ```text
//! ConversionTarget    which ops are legal: per op, per dialect, dynamically, or unknown
//! TypeConverter       type ⇒ types, plus source / target materializations
//! ConversionPattern   matchAndRewrite with the operands already remapped ("adaptor")
//! Converter           walks the ops (preorder, blocks in DFS order), legalizes each:
//!                     legal, else fold, else the patterns by cost; a pattern's new and
//!                     modified ops are legalized in turn, and a failure rolls back
//! ```
//!
//! Replacements are recorded in a value mapping and only applied at the end (commit), where
//! users left on the old types get `builtin.unrealized_conversion_cast` source
//! materializations; unresolved ones are reconciled, the rest handed to the type converter.
//! Rollback undoes every change since the attempt began: the body's and the conversion state's
//! undo logs ([`crate::Checkpoint`], [`StateMark`]) restore what was there, at the cost of what
//! changed — not a copy of the whole body per attempt.


use alloc::boxed::Box;
use alloc::collections::{BTreeMap, BTreeSet};
use alloc::string::String;
use alloc::vec::Vec;
use alloc::{format, vec};

use mlirformat::{Error, NamedAttr, Str, Type};

use crate::{pass, BlockId, Body, InsertPoint, Listener, OpData, OpId, RegionId, Rewriter, TypedOp, ValueId};


/// The marker a pure type conversion's cast carries until the end.
const PURE: &str = "__pure_type_conversion__";

// ---- target ------------------------------------------------------------------------------

/// A dynamic legality callback: `None` means "no opinion".
pub type LegalityFn<'c> = Box<dyn Fn(&Body<'_>, OpId) -> Option<bool> + 'c>;

/// `ConversionTarget::LegalizationAction`.
pub enum Action<'c> {
    Legal,
    Dynamic(LegalityFn<'c>),
    Illegal,
}

/// ⭐ `ConversionTarget`.
#[derive(Default)]
pub struct ConversionTarget<'c> {
    ops: BTreeMap<String, (Action<'c>, bool)>,
    dialects: BTreeMap<String, Action<'c>>,
    unknown: Option<Action<'c>>,
}

impl<'c> ConversionTarget<'c> {
    pub fn op(&mut self, name: &str, action: Action<'c>) -> &mut Self {
        self.ops.insert(name.into(), (action, false));
        self
    }

    pub fn legal_op(&mut self, name: &str) -> &mut Self {
        self.op(name, Action::Legal)
    }

    pub fn illegal_op(&mut self, name: &str) -> &mut Self {
        self.op(name, Action::Illegal)
    }

    pub fn dynamic_op(&mut self, name: &str, f: impl Fn(&Body<'_>, OpId) -> Option<bool> + 'c) -> &mut Self {
        self.op(name, Action::Dynamic(Box::new(f)))
    }

    /// `markOpRecursivelyLegal`: once legal, its regions are left alone.
    pub fn recursively_legal(&mut self, name: &str) -> &mut Self {
        if let Some(e) = self.ops.get_mut(name) {
            e.1 = true;
        }
        self
    }

    pub fn dialect(&mut self, ns: &str, action: Action<'c>) -> &mut Self {
        self.dialects.insert(ns.into(), action);
        self
    }

    pub fn legal_dialect(&mut self, ns: &str) -> &mut Self {
        self.dialect(ns, Action::Legal)
    }

    pub fn illegal_dialect(&mut self, ns: &str) -> &mut Self {
        self.dialect(ns, Action::Illegal)
    }

    pub fn unknown(&mut self, action: Action<'c>) -> &mut Self {
        self.unknown = Some(action);
        self
    }

    /// `getOpInfo`: op, then dialect, then the unknown-op action.
    fn info(&self, name: &str) -> Option<(&Action<'c>, bool)> {
        if let Some((a, r)) = self.ops.get(name) {
            return Some((a, *r));
        }
        let ns = name.split_once('.').map_or(name, |(ns, _)| ns);
        self.dialects.get(ns).or(self.unknown.as_ref()).map(|a| (a, false))
    }

    /// `getOpAction`.
    pub fn action(&self, name: &str) -> Option<&Action<'c>> {
        self.info(name).map(|i| i.0)
    }

    /// `isLegal`: `Some(recursively legal)` when legal.
    pub fn is_legal(&self, b: &Body<'_>, op: OpId) -> Option<bool> {
        let (action, recursive) = self.info(&b[op].name)?;
        let legal = match action {
            Action::Dynamic(f) => f(b, op).unwrap_or(false),
            Action::Legal => true,
            Action::Illegal => false,
        };
        legal.then_some(recursive)
    }

    pub fn is_illegal(&self, b: &Body<'_>, op: OpId) -> bool {
        match self.info(&b[op].name) {
            None => false,
            Some((Action::Dynamic(f), _)) => f(b, op).is_some_and(|l| !l),
            Some((a, _)) => matches!(a, Action::Illegal),
        }
    }
}

// ---- type converter ----------------------------------------------------------------------

/// A type conversion: `None` when it does not apply, `Some(None)` when the type cannot convert.
pub type ConvertFn<'c> = Box<dyn for<'a> Fn(&Type<'a>) -> Option<Option<Vec<Type<'a>>>> + 'c>;
/// A source materialization: one value of the type given, from the inputs.
pub type SourceMatFn<'c> = Box<dyn for<'r, 'a> Fn(&mut Rewriter<'r, 'a>, &Type<'a>, &[ValueId]) -> Option<ValueId> + 'c>;
/// A target materialization: values of the types given, from the inputs (and the original type).
pub type TargetMatFn<'c> = Box<dyn for<'r, 'a> Fn(&mut Rewriter<'r, 'a>, &[Type<'a>], &[ValueId], Option<&Type<'a>>) -> Option<Vec<ValueId>> + 'c>;

/// ⭐ `TypeConverter`: conversions and materializations, the last added tried first.
#[derive(Default)]
pub struct TypeConverter<'c> {
    conversions: Vec<ConvertFn<'c>>,
    sources: Vec<SourceMatFn<'c>>,
    targets: Vec<TargetMatFn<'c>>,
}

impl<'c> TypeConverter<'c> {
    pub fn conversion(&mut self, f: impl for<'a> Fn(&Type<'a>) -> Option<Option<Vec<Type<'a>>>> + 'c) -> &mut Self {
        self.conversions.push(Box::new(f));
        self
    }

    pub fn source(&mut self, f: impl for<'r, 'a> Fn(&mut Rewriter<'r, 'a>, &Type<'a>, &[ValueId]) -> Option<ValueId> + 'c) -> &mut Self {
        self.sources.push(Box::new(f));
        self
    }

    pub fn target(&mut self, f: impl for<'r, 'a> Fn(&mut Rewriter<'r, 'a>, &[Type<'a>], &[ValueId], Option<&Type<'a>>) -> Option<Vec<ValueId>> + 'c) -> &mut Self {
        self.targets.push(Box::new(f));
        self
    }

    /// `convertType` into a list; `None` on failure.
    pub fn convert_types<'a>(&self, t: &Type<'a>) -> Option<Vec<Type<'a>>> {
        self.conversions.iter().rev().find_map(|f| f(t))?
    }

    /// `convertType` to exactly one type.
    pub fn convert<'a>(&self, t: &Type<'a>) -> Option<Type<'a>> {
        match self.convert_types(t)?.as_slice() {
            [one] => Some(one.clone()),
            _ => None,
        }
    }

    /// Each type converted, flattened.
    pub fn convert_all<'a>(&self, ts: &[Type<'a>]) -> Option<Vec<Type<'a>>> {
        let mut out = Vec::new();
        for t in ts {
            out.extend(self.convert_types(t)?);
        }
        Some(out)
    }

    pub fn is_legal(&self, t: &Type<'_>) -> bool {
        self.convert(t).as_ref() == Some(t)
    }

    /// `isLegal(Operation*)`: operand and result types.
    pub fn is_legal_op(&self, b: &Body<'_>, op: OpId) -> bool {
        b[op].operands.iter().chain(&b[op].results).all(|v| self.is_legal(&b[*v].ty))
    }

    /// `isSignatureLegal`.
    pub fn is_signature_legal(&self, inputs: &[Type<'_>], results: &[Type<'_>]) -> bool {
        inputs.iter().chain(results).all(|t| self.is_legal(t))
    }

    /// `convertBlockSignature`.
    pub fn block_signature<'a>(&self, b: &Body<'a>, block: BlockId) -> Option<SignatureConversion<'a>> {
        let mut sig = SignatureConversion::new(b[block].args.len());
        for (i, a) in b[block].args.iter().enumerate() {
            let types = self.convert_types(&b[*a].ty)?;
            if !types.is_empty() {
                sig.add_inputs(i, types);
            }
        }
        Some(sig)
    }

    pub fn materialize_source<'a>(&self, rw: &mut Rewriter<'_, 'a>, ty: &Type<'a>, inputs: &[ValueId]) -> Option<ValueId> {
        self.sources.iter().rev().find_map(|f| f(rw, ty, inputs))
    }

    fn materialize_target<'a>(&self, rw: &mut Rewriter<'_, 'a>, tys: &[Type<'a>], inputs: &[ValueId], original: Option<&Type<'a>>) -> Option<Vec<ValueId>> {
        self.targets.iter().rev().find_map(|f| f(rw, tys, inputs, original))
    }
}

/// `TypeConverter::SignatureConversion`: how a block's arguments map to new ones.
#[derive(Debug, Clone)]
pub struct SignatureConversion<'a> {
    /// Per original argument: `(first new index, count)`, or replacement values, or dropped.
    remapped: Vec<Option<InputMap>>,
    types: Vec<Type<'a>>,
}

#[derive(Debug, Clone)]
pub enum InputMap {
    New { at: usize, count: usize },
    Values(Vec<ValueId>),
}

impl<'a> SignatureConversion<'a> {
    pub fn new(n: usize) -> Self {
        Self { remapped: vec![None; n], types: Vec::new() }
    }

    /// `addInputs(origInputNo, types)`.
    pub fn add_inputs(&mut self, orig: usize, types: Vec<Type<'a>>) {
        self.remapped[orig] = Some(InputMap::New { at: self.types.len(), count: types.len() });
        self.types.extend(types);
    }

    /// `addInputs(types)`: new arguments mapped from nothing.
    pub fn add_new(&mut self, types: Vec<Type<'a>>) {
        self.types.extend(types);
    }

    /// `remapInput(orig, values)`.
    pub fn remap_values(&mut self, orig: usize, values: Vec<ValueId>) {
        self.remapped[orig] = Some(InputMap::Values(values));
    }

    pub fn converted_types(&self) -> &[Type<'a>] {
        &self.types
    }

    /// How original argument `orig` is mapped.
    pub fn mapping(&self, orig: usize) -> Option<&InputMap> {
        self.remapped.get(orig)?.as_ref()
    }
}

// ---- conversion state --------------------------------------------------------------------

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum MatKind {
    Source,
    Target,
}

#[derive(Debug, Clone)]
struct MatInfo<'a> {
    kind: MatKind,
    original: Option<Type<'a>>,
    converter: Option<usize>,
}

/// A rewrite to commit at the end.
#[derive(Debug, Clone)]
enum Rewrite {
    ReplaceOp(OpId, Option<usize>),
    ReplaceValue(ValueId, Option<usize>),
}

/// `ConversionPatternRewriterImpl`'s state. Rolled back with an undo log ([`StateMark`]), as
/// the body is ([`crate::Checkpoint`]): cloning it per pattern attempt was quadratic.
#[derive(Debug, Clone, Default)]
pub struct ConvState<'a> {
    mapping: BTreeMap<Vec<ValueId>, Vec<ValueId>>,
    mapped_to: BTreeSet<ValueId>,
    replaced_ops: BTreeSet<OpId>,
    replaced_values: BTreeSet<ValueId>,
    ignored_ops: BTreeSet<OpId>,
    unresolved: BTreeMap<OpId, MatInfo<'a>>,
    rewrites: Vec<Rewrite>,
    new_ops: Vec<OpId>,
    modified_ops: Vec<OpId>,
    /// What to undo while a mark is open: what the sets and maps held before each change.
    undo: Vec<Undo<'a>>,
    /// Open marks.
    depth: u32,
}

/// One change to [`ConvState`] to undo on rollback.
#[derive(Debug, Clone)]
enum Undo<'a> {
    Mapping(Vec<ValueId>, Option<Vec<ValueId>>),
    MappedTo(ValueId),
    ReplacedOp(OpId),
    ReplacedValue(ValueId),
    Ignored(OpId),
    Unresolved(OpId, Option<MatInfo<'a>>),
}

/// A point to roll a [`ConvState`] back to; closed by [`ConvState::rollback`] or
/// [`ConvState::release`], innermost first.
#[derive(Debug)]
#[must_use = "a mark is closed by rollback or release"]
struct StateMark {
    undo: usize,
    rewrites: usize,
    new_ops: Vec<OpId>,
    modified_ops: Vec<OpId>,
}

impl<'a> Listener<'a> for ConvState<'a> {
    fn inserted(&mut self, _body: &Body<'a>, op: OpId) {
        if !self.new_ops.contains(&op) {
            self.new_ops.push(op);
        }
    }

    fn moved(&mut self, _body: &Body<'a>, _op: OpId) {}

    fn modified(&mut self, _body: &Body<'a>, op: OpId) {
        if !self.modified_ops.contains(&op) {
            self.modified_ops.push(op);
        }
    }
}

impl<'a> ConvState<'a> {
    fn map(&mut self, from: Vec<ValueId>, to: Vec<ValueId>) {
        for v in &to {
            if self.mapped_to.insert(*v) && self.depth > 0 {
                self.undo.push(Undo::MappedTo(*v));
            }
        }
        let old = self.mapping.insert(from.clone(), to);
        if self.depth > 0 {
            self.undo.push(Undo::Mapping(from, old));
        }
    }

    fn replace_ops(&mut self, ops: impl IntoIterator<Item = OpId>) {
        for o in ops {
            if self.replaced_ops.insert(o) && self.depth > 0 {
                self.undo.push(Undo::ReplacedOp(o));
            }
        }
    }

    fn replace_value(&mut self, v: ValueId) {
        if self.replaced_values.insert(v) && self.depth > 0 {
            self.undo.push(Undo::ReplacedValue(v));
        }
    }

    fn ignore(&mut self, ops: impl IntoIterator<Item = OpId>) {
        for o in ops {
            if self.ignored_ops.insert(o) && self.depth > 0 {
                self.undo.push(Undo::Ignored(o));
            }
        }
    }

    fn set_unresolved(&mut self, op: OpId, info: Option<MatInfo<'a>>) {
        let old = match info {
            Some(info) => self.unresolved.insert(op, info),
            None => self.unresolved.remove(&op),
        };
        if self.depth > 0 {
            self.undo.push(Undo::Unresolved(op, old));
        }
    }

    /// Opens a mark (with the body's [`crate::Checkpoint`]).
    fn mark(&mut self) -> StateMark {
        self.depth += 1;
        StateMark { undo: self.undo.len(), rewrites: self.rewrites.len(), new_ops: self.new_ops.clone(), modified_ops: self.modified_ops.clone() }
    }

    /// Brings the state back to `m` and closes it.
    fn rollback(&mut self, m: StateMark) {
        while self.undo.len() > m.undo {
            match self.undo.pop().expect("longer than the mark") {
                Undo::Mapping(from, Some(old)) => {
                    self.mapping.insert(from, old);
                }
                Undo::Mapping(from, None) => {
                    self.mapping.remove(&from);
                }
                Undo::MappedTo(v) => {
                    self.mapped_to.remove(&v);
                }
                Undo::ReplacedOp(o) => {
                    self.replaced_ops.remove(&o);
                }
                Undo::ReplacedValue(v) => {
                    self.replaced_values.remove(&v);
                }
                Undo::Ignored(o) => {
                    self.ignored_ops.remove(&o);
                }
                Undo::Unresolved(o, Some(info)) => {
                    self.unresolved.insert(o, info);
                }
                Undo::Unresolved(o, None) => {
                    self.unresolved.remove(&o);
                }
            }
        }
        self.rewrites.truncate(m.rewrites);
        self.new_ops = m.new_ops;
        self.modified_ops = m.modified_ops;
        self.close();
    }

    /// Keeps what changed since `m` and closes it (an outer mark can still undo it).
    fn release(&mut self, _m: StateMark) {
        self.close();
    }

    fn close(&mut self) {
        self.depth -= 1;
        if self.depth == 0 {
            self.undo.clear();
        }
    }

    /// `lookupOrDefault`.
    fn lookup_or_default(&self, b: &Body<'a>, from: ValueId, desired: &[Type<'a>], skip_pure: bool) -> Vec<ValueId> {
        let lookup = |vs: &Vec<ValueId>| self.mapping.get(vs).cloned().unwrap_or_default();
        let composed = |vs: &Vec<ValueId>| -> Vec<ValueId> {
            let mut next = Vec::new();
            for v in vs {
                let r = lookup(&vec![*v]);
                if r.is_empty() { next.push(*v) } else { next.extend(r) }
            }
            if next != *vs {
                return next;
            }
            lookup(vs)
        };
        let pure = |vs: &Vec<ValueId>| {
            let op = b.def_op(vs[0]);
            op.is_some() && vs.iter().all(|v| b.def_op(*v) == op) && b[op.expect("def")].get(PURE).is_some()
        };
        let mut desired_value = Vec::new();
        let mut current = vec![from];
        let mut last_non_mat = vec![from];
        loop {
            let mut matched = b.types(&current) == desired;
            if skip_pure {
                let p = pure(&current);
                matched &= !p;
                if !p {
                    last_non_mat = current.clone();
                }
            }
            if matched {
                desired_value = current.clone();
            }
            let next = composed(&current);
            if next.is_empty() {
                break;
            }
            current = next;
        }
        if !desired.is_empty() {
            return desired_value;
        }
        if skip_pure {
            return last_non_mat;
        }
        current
    }

    fn lookup_or_null(&self, b: &Body<'a>, from: ValueId, desired: &[Type<'a>]) -> Vec<ValueId> {
        let r = self.lookup_or_default(b, from, desired, false);
        if r == vec![from] || (!desired.is_empty() && b.types(&r) != desired) {
            return Vec::new();
        }
        r
    }

    fn was_replaced(&self, op: OpId) -> bool {
        self.replaced_ops.contains(&op)
    }

    fn is_ignored(&self, op: OpId) -> bool {
        self.was_replaced(op) || self.ignored_ops.contains(&op)
    }
}

impl<'a> Body<'a> {
    /// `computeInsertPoint(value)`: right after its definition (block start for an argument).
    fn insert_point_after(&self, v: ValueId) -> InsertPoint {
        match self[v].def {
            crate::Def::Result(op, _) => {
                let block = self[op].parent.expect("placed");
                let i = self.position(op);
                InsertPoint { block, before: self[block].ops.get(i + 1).copied() }
            }
            crate::Def::Arg(block, _) => InsertPoint { block, before: self[block].ops.first().copied() },
        }
    }

    /// `computeInsertPoint(values)`: the latest of their insertion points.
    fn insert_point_after_all(&self, vs: &[ValueId]) -> InsertPoint {
        let mut pt = self.insert_point_after(vs[0]);
        for v in &vs[1..] {
            let next = self.insert_point_after(*v);
            let later = if next.block == pt.block {
                let pos = |p: &InsertPoint| p.before.map_or(usize::MAX, |o| self.position(o));
                pos(&next) > pos(&pt)
            } else {
                // A block nested deeper, or dominated, comes later.
                true
            };
            if later {
                pt = next;
            }
        }
        pt
    }
}

// ---- patterns ----------------------------------------------------------------------------

/// ⭐ A conversion pattern: it sees the op and its operands already converted (`operands[i]`
/// are the values standing for operand `i`, empty when it was dropped).
pub trait ConversionPattern {
    fn name(&self) -> &str;

    /// The op it matches; `None`: any.
    fn root(&self) -> Option<&str>;

    fn benefit(&self) -> u16 {
        1
    }

    /// The ops it may create (for the legalization cost model).
    fn generated(&self) -> &[&str] {
        &[]
    }

    fn rewrite(&self, rw: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool;
}

/// Patterns with the type converter each uses.
#[derive(Default)]
pub struct ConversionPatterns<'p> {
    patterns: Vec<(Box<dyn ConversionPattern + 'p>, Option<usize>)>,
    converters: Vec<&'p TypeConverter<'p>>,
}

impl<'p> ConversionPatterns<'p> {
    /// Registers `tc`; patterns added with [`add_with`](Self::add_with) refer to it by index.
    pub fn converter(&mut self, tc: &'p TypeConverter<'p>) -> usize {
        self.converters.push(tc);
        self.converters.len() - 1
    }

    pub fn add(&mut self, p: impl ConversionPattern + 'p) -> &mut Self {
        self.patterns.push((Box::new(p), None));
        self
    }

    pub fn add_with(&mut self, tc: usize, p: impl ConversionPattern + 'p) -> &mut Self {
        self.patterns.push((Box::new(p), Some(tc)));
        self
    }

    pub fn is_empty(&self) -> bool {
        self.patterns.is_empty()
    }
}

// ---- the rewriter ------------------------------------------------------------------------

/// ⭐ `ConversionPatternRewriter`: a [`Rewriter`] whose replacements are recorded, not done.
pub struct ConversionRewriter<'r, 'a, 'p> {
    pub rw: Rewriter<'r, 'a, ConvState<'a>>,
    converters: &'r [&'p TypeConverter<'p>],
    /// The current pattern's type converter.
    pub current: Option<usize>,
    /// `allowPatternRollback`.
    rollback: bool,
}

impl<'r, 'a, 'p> core::ops::Deref for ConversionRewriter<'r, 'a, 'p> {
    type Target = Rewriter<'r, 'a, ConvState<'a>>;
    fn deref(&self) -> &Self::Target {
        &self.rw
    }
}

impl<'r, 'a, 'p> core::ops::DerefMut for ConversionRewriter<'r, 'a, 'p> {
    fn deref_mut(&mut self) -> &mut Self::Target {
        &mut self.rw
    }
}

impl<'r, 'a, 'p> ConversionRewriter<'r, 'a, 'p> {
    fn state(&mut self) -> &mut ConvState<'a> {
        self.rw.listener
    }

    fn state_ref(&self) -> &ConvState<'a> {
        self.rw.listener
    }

    /// The current pattern's type converter.
    pub fn type_converter(&self) -> Option<&'p TypeConverter<'p>> {
        self.current.map(|i| self.converters[i])
    }

    /// `buildUnresolvedMaterialization`.
    fn materialization(&mut self, kind: MatKind, ip: InsertPoint, loc: Option<Str<'a>>, to_map: Vec<ValueId>, inputs: &[ValueId], types: &[Type<'a>], original: Option<Type<'a>>, converter: Option<usize>, pure: bool) -> Vec<ValueId> {
        let mut data = OpData::named("builtin.unrealized_conversion_cast").operands(inputs);
        data.loc = loc;
        if pure {
            data.attributes.push(mlirformat::NamedAttr { name: PURE.into(), value: None });
        }
        let op = self.rw.body.create(data, types);
        match ip.before {
            Some(b) => self.rw.body.insert_before(op, b),
            None => self.rw.body.insert(op, ip.block, None),
        }
        let results = self.rw.body[op].results.clone();
        let st = self.state();
        st.set_unresolved(op, Some(MatInfo { kind, original, converter }));
        if !to_map.is_empty() {
            st.map(to_map, results.clone());
        }
        results
    }

    /// `remapValues`: each operand as the current converter wants it, casting where needed.
    pub fn remap(&mut self, values: &[ValueId], loc: Option<Str<'a>>) -> Option<Vec<Vec<ValueId>>> {
        let mut out = Vec::new();
        for v in values {
            let operand_loc = loc.clone().or_else(|| self.rw.body.value_loc(*v));
            let Some(tc) = self.type_converter() else {
                out.push(self.state_ref().lookup_or_default(self.rw.body, *v, &[], true));
                continue;
            };
            let orig = self.rw.body[*v].ty.clone();
            let legal = tc.convert_types(&orig)?;
            if legal.is_empty() {
                out.push(Vec::new());
                continue;
            }
            let repl = self.state_ref().lookup_or_default(self.rw.body, *v, &legal, false);
            if !repl.is_empty() && self.rw.body.types(&repl) == legal {
                out.push(repl);
                continue;
            }
            let repl = self.state_ref().lookup_or_default(self.rw.body, *v, &[], true);
            let ip = self.rw.body.insert_point_after_all(&repl);
            let current = self.current;
            out.push(self.materialization(MatKind::Target, ip, operand_loc, repl.clone(), &repl, &legal, Some(orig), current, false));
        }
        Some(out)
    }

    /// `getRemappedValue`.
    pub fn remapped(&mut self, v: ValueId) -> Option<ValueId> {
        self.remap(&[v], None)?.into_iter().next()?.first().copied()
    }

    /// ⭐ `replaceOp`: `op`'s results stand for `values` from now on; `op` goes at the end.
    pub fn replace(&mut self, op: OpId, values: Vec<Vec<ValueId>>) {
        if self.rw.ip.is_some_and(|ip| ip.before == Some(op)) {
            self.rw.set_after(op);
        }
        let results = self.rw.body[op].results.clone();
        let current = self.current;
        let nested = self.rw.body.ops_in(op);
        let st = self.state();
        for (r, v) in results.into_iter().zip(values) {
            st.map(vec![r], v);
        }
        st.rewrites.push(Rewrite::ReplaceOp(op, current));
        st.replace_ops(nested);
    }

    /// `replaceOp` with single values.
    pub fn replace_values(&mut self, op: OpId, values: &[ValueId]) {
        self.replace(op, values.iter().map(|v| vec![*v]).collect());
    }

    /// [`ConversionRewriter::replace_new`] mlirformat's typed op `with`.
    pub fn replace_by(&mut self, op: OpId, with: &impl TypedOp) -> OpId {
        let (data, types) = with.split();
        self.replace_new(op, data, &types)
    }

    /// Builds `data` (with the given result types) before `op` and replaces `op` by it.
    pub fn replace_new(&mut self, op: OpId, data: OpData<'a>, types: &[Type<'a>]) -> OpId {
        self.rw.set_before(op);
        let n = self.rw.create(data, types);
        let results = self.rw.body[n].results.clone();
        self.replace_values(op, &results);
        n
    }

    /// `Block::getTerminator`: the last op of `block` not already replaced.
    pub fn terminator(&self, block: BlockId) -> Option<OpId> {
        self.rw.body[block].ops.iter().rev().copied().find(|o| !self.state_ref().was_replaced(*o))
    }

    /// `eraseOp`: replaced by nothing.
    pub fn erase(&mut self, op: OpId) {
        let n = self.rw.body[op].results.len();
        self.replace(op, vec![Vec::new(); n]);
    }

    /// `replaceAllUsesWith(from, to)` (recorded).
    pub fn replace_value(&mut self, from: ValueId, to: Vec<ValueId>) {
        let current = self.current;
        let st = self.state();
        st.replace_value(from);
        st.map(vec![from], to);
        st.rewrites.push(Rewrite::ReplaceValue(from, current));
    }

    /// `eraseBlock` in rollback mode: out of its region now, its ops count as replaced.
    pub fn erase_block_recorded(&mut self, block: BlockId) {
        let ops: Vec<OpId> = self.rw.body[block].ops.iter().flat_map(|o| self.rw.body.ops_in(*o)).collect();
        self.rw.body.remove_block(block);
        self.state().replace_ops(ops);
    }

    /// `startOpModification` .. `finalizeOpModification` around `f`.
    pub fn modify(&mut self, op: OpId, f: impl FnOnce(&mut Body<'a>)) {
        f(self.rw.body);
        let st = self.state();
        if !st.modified_ops.contains(&op) {
            st.modified_ops.push(op);
        }
    }

    /// ⭐ `applySignatureConversion`: a new block with the converted argument types replaces
    /// `block`; the old arguments are mapped to the new ones (or materialized).
    pub fn apply_signature_conversion(&mut self, block: BlockId, sig: &SignatureConversion<'a>, converter: Option<usize>) -> BlockId {
        let b = &*self.rw.body;
        let old_types = b.types(&b[block].args);
        if old_types == sig.types {
            return block;
        }
        let mut locs: Vec<Option<Str<'a>>> = vec![Some("unknown".into()); sig.types.len()];
        for (i, m) in sig.remapped.iter().enumerate() {
            if let Some(InputMap::New { at, count }) = m {
                for j in 0..*count {
                    locs[at + j] = b[b[block].args[i]].loc.clone();
                }
            }
        }
        let region = b[block].parent.expect("in region");
        let args: Vec<_> = sig.types.iter().cloned().zip(locs).collect();
        let new = self.rw.body.add_block(region, &args);
        // `createBlock` right after `block`.
        let blocks = &mut self.rw.body[region].blocks;
        blocks.pop();
        let pos = blocks.iter().position(|x| *x == block).expect("in region");
        blocks.insert(pos + 1, new);
        let n = self.rw.body[block].ops.len();
        self.rw.body.splice(block, 0..n, new, None);
        // Branches to the old block now go to the new one.
        for (t, s) in self.rw.body.predecessors(block) {
            self.rw.body[t].successors[s] = new;
        }
        for (i, arg) in self.rw.body[block].args.clone().into_iter().enumerate() {
            match sig.remapped[i].clone() {
                None => {
                    let ty = self.rw.body[arg].ty.clone();
                    let loc = self.rw.body[arg].loc.clone();
                    let ip = InsertPoint { block: new, before: self.rw.body[new].ops.first().copied() };
                    let mat = self.materialization(MatKind::Source, ip, loc, Vec::new(), &[], &[ty], None, converter, false)[0];
                    self.replace_value_with(arg, vec![mat], converter);
                }
                Some(InputMap::Values(vs)) => self.replace_value_with(arg, vs, converter),
                Some(InputMap::New { at, count }) => {
                    let repl = self.rw.body[new].args[at..at + count].to_vec();
                    self.replace_value_with(arg, repl, converter);
                }
            }
        }
        self.rw.body.remove_block(block);
        new
    }

    fn replace_value_with(&mut self, from: ValueId, to: Vec<ValueId>, converter: Option<usize>) {
        let st = self.state();
        st.replace_value(from);
        st.map(vec![from], to);
        st.rewrites.push(Rewrite::ReplaceValue(from, converter));
    }

    /// `convertRegionTypes`: every block's signature, the entry's by `entry` if given.
    pub fn convert_region_types(&mut self, region: RegionId, converter: usize, entry: Option<&SignatureConversion<'a>>) -> Option<Option<BlockId>> {
        let tc = self.converters[converter];
        let blocks = self.rw.body[region].blocks.clone();
        let Some((&first, rest)) = blocks.split_first() else { return Some(None) };
        for b in rest {
            let sig = tc.block_signature(self.rw.body, *b)?;
            self.apply_signature_conversion(*b, &sig, Some(converter));
        }
        let sig = match entry {
            Some(s) => s.clone(),
            None => tc.block_signature(self.rw.body, first)?,
        };
        Some(Some(self.apply_signature_conversion(first, &sig, Some(converter))))
    }

    /// `inlineBlockBefore`: `source`'s arguments are replaced by `args` (recorded, so uses
    /// see the mapping), its ops move before `before` in `dest`, and `source` goes.
    pub fn inline_block_before(&mut self, source: BlockId, dest: BlockId, before: Option<OpId>, args: &[ValueId]) {
        let current = self.current;
        for (a, v) in self.rw.body[source].args.clone().into_iter().zip(args) {
            self.replace_value_with(a, vec![*v], current);
        }
        let at = before.map(|b| self.rw.body.position(b));
        let n = self.rw.body[source].ops.len();
        self.rw.body.splice(source, 0..n, dest, at);
        if self.rw.ip.is_some_and(|ip| ip.block == source) {
            self.rw.ip = Some(InsertPoint { block: dest, before });
        }
        self.rw.body.remove_block(source);
    }

    /// `mergeBlocks`: `source` appended to `dest`.
    pub fn merge_blocks(&mut self, source: BlockId, dest: BlockId, args: &[ValueId]) {
        self.inline_block_before(source, dest, None, args);
    }

    /// `inlineRegionBefore` (moves blocks; nothing to record with snapshot rollback).
    pub fn inline_region(&mut self, region: RegionId, into: RegionId, before: Option<BlockId>) {
        self.rw.inline_region_before(region, into, before);
    }
}

// ---- the legalizer and converter ---------------------------------------------------------

/// `OpConversionMode`.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Mode {
    Partial,
    Full,
}

/// `ConversionConfig`.
#[derive(Debug, Clone, Copy)]
pub struct ConversionConfig {
    pub rollback: bool,
    pub fold: bool,
    pub build_materializations: bool,
}

impl Default for ConversionConfig {
    fn default() -> Self {
        Self { rollback: true, fold: true, build_materializations: true }
    }
}

/// ⭐ One conversion run.
pub struct Converter<'x, 'c, 'p> {
    target: &'x ConversionTarget<'c>,
    patterns: &'x ConversionPatterns<'p>,
    config: ConversionConfig,
    /// Pattern indices per root name, in cost-model order; any-op patterns under `""`.
    order: BTreeMap<&'x str, Vec<usize>>,
    applied: BTreeSet<usize>,
}

impl<'x, 'c, 'p> Converter<'x, 'c, 'p> {
    pub fn new(target: &'x ConversionTarget<'c>, patterns: &'x ConversionPatterns<'p>, config: ConversionConfig) -> Self {
        let mut c = Self { target, patterns, config, order: BTreeMap::new(), applied: BTreeSet::new() };
        c.cost_model();
        c
    }

    /// `buildLegalizationGraph` + `computeLegalizationGraphBenefit`, simplified to what it
    /// decides: patterns ordered by legalization depth, then benefit, stably.
    fn cost_model(&mut self) {
        let pats = &self.patterns.patterns;
        let any_op = pats.iter().any(|(p, _)| p.root().is_none());
        let mut by_root: BTreeMap<&'x str, Vec<usize>> = BTreeMap::new();
        for (i, (p, _)) in pats.iter().enumerate() {
            let root = p.root().unwrap_or("");
            if !root.is_empty() && matches!(self.target.action(root), Some(Action::Legal)) {
                continue;
            }
            by_root.entry(root).or_default().push(i);
        }
        let mut depth: BTreeMap<&'x str, usize> = BTreeMap::new();
        for r in by_root.keys() {
            self.op_depth(r, &by_root, &mut depth, any_op);
        }
        for (root, mut idx) in by_root {
            let d = |i: usize| pats[i].0.generated().iter().map(|g| depth.get(*g).copied().unwrap_or(0) + 1).max().unwrap_or(1).max(1);
            if idx.len() > 1 && !any_op {
                idx.sort_by(|a, b| d(*a).cmp(&d(*b)).then(pats[*b].0.benefit().cmp(&pats[*a].0.benefit())));
            } else {
                idx.sort_by(|a, b| pats[*b].0.benefit().cmp(&pats[*a].0.benefit()));
            }
            self.order.insert(root, idx);
        }
    }

    fn op_depth(&self, op: &'x str, by_root: &BTreeMap<&'x str, Vec<usize>>, depth: &mut BTreeMap<&'x str, usize>, any_op: bool) -> usize {
        if any_op {
            return 0;
        }
        if let Some(d) = depth.get(op) {
            return *d;
        }
        let Some(pats) = by_root.get(op).filter(|p| !p.is_empty()) else { return 0 };
        depth.insert(op, usize::MAX - 1);
        let mut min = usize::MAX;
        for i in pats {
            let mut d = 1;
            for g in self.patterns.patterns[*i].0.generated() {
                d = d.max(self.op_depth(g, by_root, depth, any_op).saturating_add(1));
            }
            min = min.min(d);
        }
        depth.insert(op, min);
        min
    }

    /// The patterns to try on op `name`, merged with the any-op ones by benefit.
    fn patterns_for(&self, name: &str) -> Vec<usize> {
        let mut out: Vec<usize> = self.order.get(name).cloned().unwrap_or_default();
        if let Some(any) = self.order.get("") {
            out.extend(any);
            let pats = &self.patterns.patterns;
            out.sort_by(|a, b| pats[*b].0.benefit().cmp(&pats[*a].0.benefit()));
        }
        out
    }

    fn rewriter<'r, 'a>(&'r self, body: &'r mut Body<'a>, state: &'r mut ConvState<'a>) -> ConversionRewriter<'r, 'a, 'p> {
        ConversionRewriter { rw: Rewriter::typed(body, state), converters: &self.patterns.converters, current: None, rollback: self.config.rollback }
    }

    /// `OperationLegalizer::legalize`.
    fn legalize<'a>(&mut self, body: &mut Body<'a>, state: &mut ConvState<'a>, op: OpId) -> bool {
        if state.is_ignored(op) {
            return true;
        }
        if let Some(recursive) = self.target.is_legal(body, op) {
            if recursive {
                state.ignore(body.ops_in(op).into_iter().skip(1));
            }
            return true;
        }
        if self.config.fold && self.legalize_with_fold(body, state, op) {
            return true;
        }
        self.legalize_with_pattern(body, state, op)
    }

    /// `legalizeWithFold`.
    fn legalize_with_fold<'a>(&mut self, body: &mut Body<'a>, state: &mut ConvState<'a>, op: OpId) -> bool {
        // `OpBuilder::tryFold`: a constant is already as folded as it gets.
        if body.constant_value(op).is_some() {
            return false;
        }
        let (cp, mark) = (body.checkpoint(), state.mark());
        state.new_ops.clear();
        state.modified_ops.clear();
        match body.fold(op) {
            crate::Fold::Failed => {
                body.rollback(cp);
                state.rollback(mark);
                false
            }
            crate::Fold::InPlace => {
                state.new_ops.clear();
                state.modified_ops.clear();
                let ok = self.legalize(body, state, op);
                body.release(cp);
                state.release(mark);
                ok
            }
            crate::Fold::Results(results) => {
                let name = body[op].name.clone();
                let types = body.types(&body[op].results.clone());
                let loc = body[op].loc.clone();
                let mut values = Vec::new();
                let mut new_ops = Vec::new();
                for (r, ty) in results.into_iter().zip(&types) {
                    match r {
                        crate::Folded::Value(v) => values.push(v),
                        crate::Folded::Attr(a) => {
                            let Some(data) = body.materialize(&name, &a, ty) else {
                                body.rollback(cp);
                                state.rollback(mark);
                                return false;
                            };
                            let c = body.create(OpData { loc: loc.clone(), ..data }, core::slice::from_ref(ty));
                            body.insert_before(c, op);
                            values.push(body[c].results[0]);
                            new_ops.push(c);
                        }
                    }
                }
                {
                    let mut cr = self.rewriter(body, state);
                    cr.replace_values(op, &values);
                }
                state.new_ops.clear();
                state.modified_ops.clear();
                for c in new_ops {
                    if !self.legalize(body, state, c) {
                        body.rollback(cp);
                        state.rollback(mark);
                        return false;
                    }
                }
                body.release(cp);
                state.release(mark);
                true
            }
        }
    }

    /// `legalizeWithPattern`: the patterns in order; a match whose result cannot be legalized
    /// is rolled back and the next one tried.
    fn legalize_with_pattern<'a>(&mut self, body: &mut Body<'a>, state: &mut ConvState<'a>, op: OpId) -> bool {
        let name = body[op].name.clone();
        for i in self.patterns_for(&name) {
            if !self.applied.insert(i) {
                continue;
            }
            let (cp, mark) = (body.checkpoint(), state.mark());
            state.new_ops.clear();
            state.modified_ops.clear();
            let tc = self.patterns.patterns[i].1;
            let matched = {
                let mut cr = self.rewriter(body, state);
                cr.current = tc;
                cr.rw.set_before(op);
                let loc = cr.rw.body[op].loc.clone();
                let operands = cr.rw.body[op].operands.clone();
                match cr.remap(&operands, loc) {
                    Some(remapped) => self.patterns.patterns[i].0.rewrite(&mut cr, op, &remapped),
                    None => false,
                }
            };
            if !matched {
                body.rollback(cp);
                state.rollback(mark);
                self.applied.remove(&i);
                continue;
            }
            let new_ops = core::mem::take(&mut state.new_ops);
            let modified = core::mem::take(&mut state.modified_ops);
            let ok = modified.iter().all(|o| self.legalize(body, state, *o)) && new_ops.iter().all(|o| self.legalize(body, state, *o));
            self.applied.remove(&i);
            if ok {
                body.release(cp);
                state.release(mark);
                return true;
            }
            body.rollback(cp);
            state.rollback(mark);
        }
        false
    }

    /// `OperationConverter::convert`.
    fn convert_op<'a>(&mut self, body: &mut Body<'a>, state: &mut ConvState<'a>, op: OpId, mode: Mode) -> Result<(), Error> {
        if self.legalize(body, state, op) {
            return Ok(());
        }
        match mode {
            Mode::Full => Err(Error(format!("failed to legalize operation '{}'", body[op].name))),
            Mode::Partial if self.target.is_illegal(body, op) => Err(Error(format!("failed to legalize operation '{}' that was explicitly marked illegal", body[op].name))),
            Mode::Partial => Ok(()),
        }
    }

    /// The ops to convert: preorder, blocks in depth-first order, not into recursively legal ops.
    fn collect(&self, body: &Body<'_>, op: OpId, out: &mut Vec<OpId>) {
        out.push(op);
        if self.target.is_legal(body, op) == Some(true) {
            return;
        }
        for r in &body[op].regions {
            let Some(&entry) = body[*r].blocks.first() else { continue };
            for b in body.depth_first(entry) {
                for o in &body[b].ops {
                    self.collect(body, *o, out);
                }
            }
        }
    }

    /// ⭐ `applyPartialConversion` / `applyFullConversion` on `roots`.
    pub fn apply<'a>(&mut self, body: &mut Body<'a>, roots: &[OpId], mode: Mode) -> Result<(), Error> {
        let mut state = ConvState::default();
        let mut ops = Vec::new();
        for r in roots {
            self.collect(body, *r, &mut ops);
        }
        let snapshot = body.clone();
        for op in ops {
            if let Err(e) = self.convert_op(body, &mut state, op, mode) {
                *body = snapshot;
                return Err(e);
            }
        }
        self.commit(body, &mut state);
        self.finish(body, &mut state)
    }

    /// `findOrBuildReplacementValue`.
    fn replacement<'a>(&self, body: &mut Body<'a>, state: &mut ConvState<'a>, v: ValueId, converter: Option<usize>) -> Option<ValueId> {
        let ty = body[v].ty.clone();
        let repl = state.lookup_or_null(body, v, core::slice::from_ref(&ty));
        if let Some(r) = repl.first() {
            return Some(*r);
        }
        if body[v].uses.iter().all(|u| state.replaced_ops.contains(&u.op)) && !state.mapped_to.contains(&v) {
            return None;
        }
        let repl = state.lookup_or_null(body, v, &[]);
        let ip = if repl.is_empty() { body.insert_point_after(v) } else { body.insert_point_after_all(&repl) };
        let loc = body.value_loc(v);
        let pure = !repl.is_empty();
        let mut cr = self.rewriter(body, state);
        Some(cr.materialization(MatKind::Source, ip, loc, repl.clone(), &repl, &[ty], None, converter, pure)[0])
    }

    /// `performReplaceValue`.
    fn replace_uses<'a>(body: &mut Body<'a>, from: ValueId, repl: ValueId) {
        let after_def = body.def_op(repl);
        for u in body[from].uses.clone().into_iter().rev() {
            let ok = match after_def {
                None => true,
                Some(d) => body[u.op].parent != body[d].parent || body.position(d) < body.position(u.op),
            };
            if ok {
                body.set_operand(u.op, u.index as usize, repl);
            }
        }
    }

    /// `applyRewrites`: replacements in order, then the replaced ops go.
    fn commit<'a>(&self, body: &mut Body<'a>, state: &mut ConvState<'a>) {
        let rewrites = state.rewrites.clone();
        let mut erase = Vec::new();
        for r in rewrites {
            match r {
                Rewrite::ReplaceOp(op, tc) => {
                    let results = body[op].results.clone();
                    let repls: Vec<_> = results.iter().map(|v| self.replacement(body, state, *v, tc)).collect();
                    for (v, repl) in results.into_iter().zip(repls) {
                        if let Some(repl) = repl {
                            body.replace_all_uses(v, repl);
                        }
                    }
                    erase.push(op);
                }
                Rewrite::ReplaceValue(v, tc) => {
                    if let Some(repl) = self.replacement(body, state, v, tc) {
                        Self::replace_uses(body, v, repl);
                    }
                }
            }
        }
        // Out of their blocks in one pass per block (one by one is a scan of the block each)
        body.detach_all(&erase);
        for op in erase {
            for o in body.ops_in(op) {
                state.set_unresolved(o, None);
            }
            body.drop_result_uses(op);
            body.erase(op);
        }
    }

    /// Unresolved materializations: reconciled, then legalized by the type converters.
    fn finish<'a>(&self, body: &mut Body<'a>, state: &mut ConvState<'a>) -> Result<(), Error> {
        let casts: Vec<OpId> = state.unresolved.keys().copied().filter(|o| body[*o].parent.is_some()).collect();
        let remaining = body.reconcile_casts(&casts);
        for c in &remaining {
            body[*c].remove(PURE);
        }
        if !self.config.build_materializations {
            return Ok(());
        }
        for c in remaining {
            let info = state.unresolved[&c].clone();
            let Some(tc) = info.converter.map(|i| self.patterns.converters[i]) else {
                return Err(Error("failed to legalize unresolved materialization".into()));
            };
            let inputs = body[c].operands.clone();
            let types = body.types(&body[c].results.clone());
            let mut quiet = crate::Quiet;
            let mut rw = Rewriter::new(body, &mut quiet);
            rw.set_before(c);
            let made = match info.kind {
                MatKind::Target => tc.materialize_target(&mut rw, &types, &inputs, info.original.as_ref()),
                MatKind::Source => tc.materialize_source(&mut rw, &types[0], &inputs).map(|v| vec![v]),
            };
            let Some(made) = made else {
                return Err(Error(format!("failed to legalize unresolved materialization from ({}) to ({}) that remained live after conversion", body.types(&inputs).iter().map(|t| format!("{t}")).collect::<Vec<_>>().join(", "), types.iter().map(|t| format!("{t}")).collect::<Vec<_>>().join(", "))));
            };
            rw.replace_op(c, &made);
        }
        Ok(())
    }
}

impl<'a> Body<'a> {
    /// A value's location: its defining op's, or its own (a block argument).
    pub fn value_loc(&self, v: ValueId) -> Option<Str<'a>> {
        match self[v].def {
            crate::Def::Result(op, _) => self[op].loc.clone(),
            crate::Def::Arg(..) => self[v].loc.clone(),
        }
    }

    /// Blocks reachable from `entry` in depth-first preorder (`llvm::depth_first`).
    pub fn depth_first(&self, entry: BlockId) -> Vec<BlockId> {
        let mut out = Vec::new();
        let mut seen = BTreeSet::new();
        let mut stack = vec![(entry, 0usize)];
        seen.insert(entry);
        out.push(entry);
        while let Some((b, i)) = stack.pop() {
            if let Some(s) = self.successors(b).get(i).copied() {
                stack.push((b, i + 1));
                if seen.insert(s) {
                    out.push(s);
                    stack.push((s, 0));
                }
            }
        }
        out
    }

    /// `reconcileUnrealizedCasts` over `casts`; the ones still live.
    pub fn reconcile_casts(&mut self, casts: &[OpId]) -> Vec<OpId> {
        let set: BTreeSet<OpId> = casts.iter().copied().collect();
        let input_cast = |b: &Body<'_>, c: OpId| -> Option<OpId> {
            let first = *b[c].operands.first()?;
            let ic = b.def_op(first).filter(|o| b[*o].name == "builtin.unrealized_conversion_cast")?;
            (b[ic].results == b[c].operands).then_some(ic)
        };
        // Cast chains that come back to where they started fold away.
        let mut work: Vec<OpId> = casts.to_vec();
        while let Some(c) = work.pop() {
            let mut next = Some(c);
            while let Some(n) = next {
                if self.types(&self[n].operands) == self.types(&self[c].results) {
                    if self[n].operands.iter().any(|v| self.def_op(*v) == Some(c)) {
                        break;
                    }
                    let (results, inputs) = (self[c].results.clone(), self[n].operands.clone());
                    for (r, i) in results.into_iter().zip(inputs) {
                        self.replace_all_uses(r, i);
                    }
                    break;
                }
                next = input_cast(self, n);
            }
        }
        // Live: used by something that is not one of these casts, and what those use.
        let mut live = BTreeSet::new();
        for c in casts {
            if live.contains(c) {
                continue;
            }
            let used_outside = self[*c].results.iter().any(|r| self[*r].uses.iter().any(|u| self[u.op].name != "builtin.unrealized_conversion_cast" || !set.contains(&u.op)));
            if used_outside {
                let mut stack = vec![*c];
                while let Some(o) = stack.pop() {
                    if live.insert(o) {
                        for v in &self[o].operands {
                            if let Some(d) = self.def_op(*v).filter(|d| set.contains(d)) {
                                stack.push(d);
                            }
                        }
                    }
                }
            }
        }
        let mut remaining = Vec::new();
        for c in casts {
            if live.contains(c) {
                remaining.push(*c);
                continue;
            }
            self.drop_result_uses(*c);
            self.erase(*c);
        }
        remaining
    }
}

// The dialect conversion interfaces `convert-to-*` gather (`ConvertToLLVMPatternInterface`,
// `ConvertToEmitCPatternInterface`, ...): which dialects have one, and what each adds. Nothing
// is global: a pass holds the manager it asks.

/// ⭐ Dialects' conversion interfaces: what each registered dialect adds to the patterns.
pub trait DialectInterfaces {
    /// What the patterns are built with.
    type Env<'e>;

    /// The dialects that have one, in registration order.
    fn dialects(&self) -> Vec<&'static str>;

    fn knows(&self, ns: &str) -> bool {
        self.dialects().contains(&ns)
    }

    /// Adds dialect `ns`'s patterns (nothing when it has no interface).
    fn populate<'p>(&self, ns: &str, patterns: &mut ConversionPatterns<'p>, tc: usize, env: &Self::Env<'p>);
}

// Lowerings given as functions: what `#[patterns]` / `#[lowering]` generate, and the
// [`ConversionRewriter`] builders they are written with.

/// Something a typed `#[lowering]` reads off the op it lowers (its fast-math flags, ..).
pub(crate) trait FromOp {
    fn from_op(cr: &ConversionRewriter<'_, '_, '_>, op: OpId) -> Self;
}

/// What a typed `#[lowering]` returns: the op's replacement, or failure.
pub trait Replacement {
    fn replace(self, cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId) -> bool;
}

impl Replacement for ValueId {
    fn replace(self, cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId) -> bool {
        cr.replace_values(op, &[self]);
        true
    }
}

impl Replacement for Option<ValueId> {
    fn replace(self, cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId) -> bool {
        self.is_some_and(|v| v.replace(cr, op))
    }
}

impl Replacement for Vec<ValueId> {
    fn replace(self, cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId) -> bool {
        cr.replace_values(op, &self);
        true
    }
}

/// A lowering that needs the pass options `O`.
pub struct OptLowering<O> {
    pub root: &'static str,
    pub benefit: u16,
    pub opts: O,
    pub f: for<'r, 'a, 'p> fn(&mut ConversionRewriter<'r, 'a, 'p>, OpId, &[Vec<ValueId>], O) -> bool,
}

impl<O: Copy> ConversionPattern for OptLowering<O> {
    fn name(&self) -> &str {
        self.root
    }

    fn root(&self) -> Option<&str> {
        Some(self.root)
    }

    fn benefit(&self) -> u16 {
        self.benefit
    }

    fn rewrite(&self, cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        (self.f)(cr, op, operands, self.opts)
    }
}

impl<'a> ConversionRewriter<'_, 'a, '_> {
    /// Builds `data` with one result of type `ty` at the insertion point; the result.
    pub fn build(&mut self, data: OpData<'a>, ty: Type<'a>) -> ValueId {
        let o = self.rw.create(data, &[ty]);
        self.rw.body[o].results[0]
    }

    /// Builds mlirformat's typed op `op` at the insertion point; its first result.
    pub fn emit(&mut self, op: &impl TypedOp) -> ValueId {
        let o = self.rw.emit(op);
        self.rw.body[o].results[0]
    }

    /// The single remapped value of each operand (`getOneToOneAdaptorOperands`).
    pub fn one_to_one(operands: &[Vec<ValueId>]) -> Option<Vec<ValueId>> {
        operands.iter().map(|o| (o.len() == 1).then(|| o[0])).collect()
    }

    /// The op's attributes, inherent and discardable, sorted (`getAttrs()`).
    pub fn all_attrs(&self, op: OpId) -> Vec<NamedAttr<'a>> {
        self.rw.body[op].all_attrs()
    }
}

/// A conversion pattern given as a root, a benefit and a function.
pub struct Lowering {
    pub root: &'static str,
    pub benefit: u16,
    pub f: LowerFn,
}

/// What a [`Lowering`] runs.
pub type LowerFn = for<'r, 'a, 'p> fn(&mut ConversionRewriter<'r, 'a, 'p>, OpId, &[Vec<ValueId>]) -> bool;

impl ConversionPattern for Lowering {
    fn name(&self) -> &str {
        self.root
    }

    fn root(&self) -> Option<&str> {
        Some(self.root)
    }

    fn benefit(&self) -> u16 {
        self.benefit
    }

    fn rewrite(&self, cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        (self.f)(cr, op, operands)
    }
}

/// `reconcile-unrealized-casts`.
#[pass("reconcile-unrealized-casts")]
pub fn reconcile_unrealized_casts<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let casts: Vec<OpId> = body.ops_in(op).into_iter().filter(|o| body[*o].name == "builtin.unrealized_conversion_cast").collect();
    body.reconcile_casts(&casts);
    Ok(())
}

crate::pass_set! {
    /// The dialect conversion framework's own passes.
    ConversionPasses: ReconcileUnrealizedCasts
}
