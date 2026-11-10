//! The `test` dialect's op interfaces (`mlir/test/lib/Dialect/Test`).

use alloc::vec;
use alloc::vec::Vec;
use core::ops::Range;

use mlirformat::Attribute;

use crate::{BlockId, Body, EffectInstance, EffectKind, Resource, BranchLayout, DialectInliner, InsertPoint, OpData, OpId, OpInterfaces, Operand, Point, Succ, ValueId};

/// The `test` dialect.
pub struct TestDialect;

/// The keys of one `test.side_effect_op` effect dictionary.
#[derive(Clone, Copy, PartialEq, Eq)]
enum EffectKey {
    Effect,
    Resource(Resource),
    OnResult,
    OnReference,
}

impl EffectKey {
    const TABLE: &[(&str, EffectKey)] = &[
        ("effect", EffectKey::Effect),
        ("test_resource", EffectKey::Resource(Resource::Test)),
        ("test_nonaddressable_resource", EffectKey::Resource(Resource::TestNonAddressable)),
        ("test_nonaddressable_resource_a", EffectKey::Resource(Resource::TestNonAddressableA)),
        ("test_nonaddressable_resource_b", EffectKey::Resource(Resource::TestNonAddressableB)),
        ("on_result", EffectKey::OnResult),
        ("on_reference", EffectKey::OnReference),
    ];
    const KINDS: &[(&str, EffectKind)] = &[
        ("allocate", EffectKind::Allocate),
        ("free", EffectKind::Free),
        ("read", EffectKind::Read),
        ("write", EffectKind::Write),
    ];
}

/// One entry of `test.side_effect_op`'s `effects`, read once.
#[derive(Default)]
struct SideEffectEntry {
    kind: Option<EffectKind>,
    resource: Option<Resource>,
    on_result: bool,
}

impl From<&Attribute<'_>> for SideEffectEntry {
    fn from(a: &Attribute<'_>) -> Self {
        let mut out = SideEffectEntry::default();
        let Attribute::Dict(d) = a else { return out };
        for na in d {
            let Some((_, key)) = EffectKey::TABLE.iter().find(|(n, _)| *n == &*na.name) else { continue };
            match key {
                EffectKey::Effect => {
                    if let Some(Attribute::Str { lit, .. }) = &na.value {
                        out.kind = EffectKey::KINDS.iter().find(|(n, _)| *n == &**lit).map(|(_, k)| *k);
                    }
                }
                // The first resource key in `getEffects`' order wins.
                EffectKey::Resource(r) => {
                    let rank = |r: Resource| EffectKey::TABLE.iter().position(|(_, k)| *k == EffectKey::Resource(r));
                    if out.resource.is_none_or(|o| rank(*r) < rank(o)) {
                        out.resource = Some(*r);
                    }
                }
                EffectKey::OnResult => out.on_result = true,
                EffectKey::OnReference => {}
            }
        }
        out
    }
}

impl SideEffectEntry {
    fn instance(&self, b: &Body<'_>, op: OpId) -> Option<EffectInstance> {
        let value = if self.on_result { b[op].results.first().copied() } else { None };
        Some(EffectInstance { kind: self.kind?, value, resource: self.resource.unwrap_or(Resource::Default) })
    }
}

impl OpInterfaces for TestDialect {
    fn namespace(&self) -> &str {
        "test"
    }

    fn inliner(&self) -> Option<&dyn DialectInliner> {
        Some(self)
    }

    /// `TestOpWithRegionFold::fold` (its operand), `TestOpWithVariadicResultsAndFolder::fold`
    /// (its operands).
    fn fold<'a>(&self, b: &mut Body<'a>, op: OpId, _: &[Option<Attribute<'a>>]) -> crate::Fold<'a> {
        match &*b[op].name {
            "test.op_with_region_fold" | "test.op_with_variadic_results_and_folder" => crate::Fold::Results(b[op].operands.iter().map(|v| crate::Folded::Value(*v)).collect()),
            _ => crate::Fold::Failed,
        }
    }

    /// `SideEffectOp::getEffects`: one effect per entry of the `effects` array.
    fn effects(&self, b: &Body<'_>, op: OpId) -> Option<Vec<EffectInstance>> {
        if !matches!(&*b[op].name, "test.side_effect_op" | "test.side_effect_with_region_op") {
            return None;
        }
        let Some(Attribute::Array(entries)) = b[op].get("effects") else { return Some(Vec::new()) };
        Some(entries.iter().filter_map(|e| SideEffectEntry::from(e).instance(b, op)).collect())
    }

    fn speculatability(&self, b: &Body<'_>, op: OpId) -> Option<bool> {
        match &*b[op].name {
            "test.conditionally_speculatable_op" => b.def_named(b[op].operands[0], "arith.constant").map(|_| false),
            _ => None,
        }
    }

    #[cfg(feature = "dialect.bufferization")]
    fn bufferizable(&self, name: &str) -> Option<&dyn crate::Bufferizable> {
        Self::bufferizable_op(name)
    }

    fn branch_layout(&self, b: &Body<'_>, op: OpId) -> Option<BranchLayout> {
        (b[op].name == "test.br").then_some(BranchLayout::All)
    }

    /// `test.internal_br`: successor `i` gets `i` produced arguments, then operand group `i`.
    fn produced_successor_operands(&self, b: &Body<'_>, op: OpId, i: usize) -> Option<(usize, Range<usize>)> {
        if b[op].name != "test.internal_br" {
            return None;
        }
        let seg = b.segments(op, "operandSegmentSizes").unwrap_or_default();
        let start: usize = seg.iter().take(i).sum();
        Some((i, start..start + seg.get(i).copied().unwrap_or(0)))
    }

    fn is_region_branch(&self, b: &Body<'_>, op: OpId) -> bool {
        b[op].name == "test.region_if"
    }

    /// `test.region_if`: the then and else regions take the operands, both go to the join
    /// region.
    fn region_successors(&self, b: &Body<'_>, op: OpId, point: Point) -> Vec<(Succ, Vec<ValueId>)> {
        if b[op].name != "test.region_if" {
            return Vec::new();
        }
        match point {
            Point::Parent => vec![(Succ::Region(0), b.region_args(op, 0, 0)), (Succ::Region(1), b.region_args(op, 1, 0))],
            Point::Terminator(t) if b[t].parent.and_then(|blk| b[blk].parent) == Some(b[op].regions[2]) => vec![(Succ::Parent, b[op].results.clone().to_vec())],
            Point::Terminator(_) => vec![(Succ::Region(2), b.region_args(op, 2, 0))],
        }
    }

    fn entry_operands(&self, b: &Body<'_>, op: OpId) -> Vec<Operand> {
        if b[op].name != "test.region_if" {
            return Vec::new();
        }
        (0..b[op].operands.len()).map(|i| (op, i)).collect()
    }

    fn is_region_terminator(&self, b: &Body<'_>, t: OpId) -> bool {
        b[t].name == "test.region_if_yield"
    }

    fn call_args(&self, b: &Body<'_>, call: OpId) -> Option<Range<usize>> {
        if b[call].name != "test.call_with_segments" {
            return None;
        }
        let seg = b.segments(call, "operandSegmentSizes").unwrap_or_default();
        Some(seg[0]..seg[0] + seg[1])
    }
}

/// `TestInlinerInterface`.
impl DialectInliner for TestDialect {
    fn legal_call(&self, b: &Body<'_>, call: OpId, _: OpId) -> bool {
        b[call].get("noinline").is_none()
    }

    fn legal_region(&self, _: &Body<'_>, _: crate::RegionId) -> bool {
        true
    }

    fn legal_op(&self, _: &Body<'_>, _: OpId) -> bool {
        true
    }

    /// A functional region op is a scope of its own.
    fn analyze_recursively(&self, b: &Body<'_>, op: OpId) -> bool {
        b[op].name != "test.functional_region_op"
    }

    /// `test.return` as a `cf.br` to `dest`.
    fn branch_terminator(&self, b: &mut Body<'_>, op: OpId, dest: crate::BlockId) {
        if b[op].name != "test.return" {
            return;
        }
        let mut data = crate::OpData::build("cf.br").operands(&b[op].operands.clone());
        data.successors = smallvec::smallvec![dest];
        data.loc = b[op].loc.clone();
        let br = b.create(data, &[]);
        b.insert_before(br, op);
        b.erase(op);
    }

    /// `test.return`'s operands for the results (none when their counts differ).
    fn replace_with_terminator(&self, b: &mut Body<'_>, op: OpId, results: &[ValueId]) {
        if b[op].name != "test.return" || b[op].operands.len() != results.len() {
            return;
        }
        for (r, v) in results.iter().zip(b[op].operands.clone()) {
            b.replace_all_uses(*r, v);
        }
    }

    /// `test.cast` between `i16` and `i32`.
    fn call_conversion<'a>(&self, b: &mut Body<'a>, input: ValueId, ty: &mlirformat::Type<'a>, at: InsertPoint, loc: Option<mlirformat::Str<'a>>) -> Option<OpId> {
        let ok = |t: &mlirformat::Type<'_>| *t == mlirformat::Type::int(16) || *t == mlirformat::Type::int(32);
        if !ok(ty) || !ok(&b[input].ty) {
            return None;
        }
        let mut data = OpData::build("test.cast").operands(&[input]);
        data.loc = loc;
        let c = b.create(data, core::slice::from_ref(ty));
        b.put(c, at);
        Some(c)
    }

    /// A `test.type_changer` for an argument or result marked `test.handle_argument` /
    /// `test.handle_result`.
    fn handle_value<'a>(&self, b: &mut Body<'a>, call: OpId, value: ValueId, attrs: Option<&mlirformat::Attribute<'a>>, result: bool, at: InsertPoint) -> ValueId {
        let key = if result { "test.handle_result" } else { "test.handle_argument" };
        if !matches!(attrs, Some(mlirformat::Attribute::Dict(d)) if d.iter().any(|e| e.name == key)) {
            return value;
        }
        let mut data = OpData::build("test.type_changer").operands(&[value]);
        data.loc = b[call].loc.clone();
        let ty = b[value].ty.clone();
        let c = b.create(data, &[ty]);
        b.put(c, at);
        b[c].results[0]
    }

    /// Ops inlined through a `test.conversion_call_op` are marked `inlined_conversion`.
    fn process_inlined(&self, b: &mut Body<'_>, call: OpId, blocks: &[BlockId]) {
        if b[call].name != "test.conversion_call_op" {
            return;
        }
        let mut ops = Vec::new();
        for blk in blocks {
            for o in &b.block_ops(*blk) {
                b.walk(*o, &mut |x| ops.push(x));
            }
        }
        for o in ops {
            b[o].set("inlined_conversion", mlirformat::Attribute::Unit);
        }
    }
}

#[cfg(feature = "dialect.bufferization")]
mod bufferizable {
    use alloc::vec::Vec;

    use mlirformat::{Error, Type};

    use super::TestDialect;
    use crate::{buffer_of, buffer_type, replace_with_buffers, Body, Bufferizable, BufferizationOptions, OpData, OpId, Rewriter, ValueId};

    /// `test.dummy_tensor_op` (reads and writes its input, aliases nothing) and
    /// `test.create_tensor_op`: their memref analogies on buffers.
    struct DummyTensor;
    struct CreateTensor;

    impl TestDialect {
        pub(crate) fn bufferizable_op(name: &str) -> Option<&'static dyn Bufferizable> {
            Some(match name {
                "test.dummy_tensor_op" => &DummyTensor,
                "test.create_tensor_op" => &CreateTensor,
                _ => return None,
            })
        }
    }

    impl Bufferizable for DummyTensor {
        fn bufferize(&self, rw: &mut Rewriter<'_, '_>, o: &BufferizationOptions, op: OpId) -> Result<(), Error> {
            let input = buffer_of(rw, o, rw.body[op].operands[0])?;
            let out = buffer_type(o, rw.body, rw.body[op].results[0])?;
            let n = rw.create(OpData::build("test.dummy_memref_op").operands(&[input]), &[out]);
            let r = rw.body[n].results.to_vec();
            replace_with_buffers(rw, op, &r);
            Ok(())
        }
    }

    impl Bufferizable for CreateTensor {
        fn buffer_type<'a>(&self, _: &BufferizationOptions, b: &Body<'a>, v: ValueId, _: &mut Vec<ValueId>) -> Result<Type<'a>, Error> {
            BufferizationOptions::tensor_like(&b[v].ty).ok_or_else(|| Error("expected a tensor-like type".into()))
        }

        fn bufferize(&self, rw: &mut Rewriter<'_, '_>, o: &BufferizationOptions, op: OpId) -> Result<(), Error> {
            let out = buffer_type(o, rw.body, rw.body[op].results[0])?;
            let n = rw.create(OpData::build("test.create_memref_op"), &[out]);
            let r = rw.body[n].results.to_vec();
            replace_with_buffers(rw, op, &r);
            Ok(())
        }
    }
}
