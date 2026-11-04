//! The `scf` dialect's op interfaces.

use alloc::vec;
use alloc::vec::Vec;

use mlirformat::Attribute;

use crate::{Body, DialectInliner, OpId, OpInterfaces, Operand, Point, Succ, ValueId};

/// The `scf` dialect.
pub struct ScfDialect;

impl OpInterfaces for ScfDialect {
    fn namespace(&self) -> &str {
        "scf"
    }

    #[cfg(feature = "dialect.bufferization")]
    fn bufferizable(&self, name: &str) -> Option<&dyn crate::Bufferizable> {
        Self::bufferizable_op(name)
    }

    fn inliner(&self) -> Option<&dyn DialectInliner> {
        Some(self)
    }

    fn speculatability(&self, b: &Body<'_>, op: OpId) -> Option<bool> {
        match &*b[op].name {
            "scf.for" => (b.int_constant(b[op].operands[2]) == Some(1)).then_some(true),
            _ => None,
        }
    }

    fn is_region_branch(&self, b: &Body<'_>, op: OpId) -> bool {
        matches!(&*b[op].name, "scf.for" | "scf.if" | "scf.while" | "scf.execute_region" | "scf.index_switch")
    }

    fn region_successors(&self, b: &Body<'_>, op: OpId, point: Point) -> Vec<(Succ, Vec<ValueId>)> {
        let results = b[op].results.clone();
        match &*b[op].name {
            "scf.for" => vec![(Succ::Region(0), b.region_args(op, 0, 1)), (Succ::Parent, results.to_vec())],
            "scf.if" => match point {
                Point::Parent => {
                    let else_empty = b[b[op].regions[1]].blocks.is_empty();
                    vec![(Succ::Region(0), Vec::new()), if else_empty { (Succ::Parent, results.to_vec()) } else { (Succ::Region(1), Vec::new()) }]
                }
                Point::Terminator(_) => vec![(Succ::Parent, results.to_vec())],
            },
            "scf.while" => match point {
                Point::Parent => vec![(Succ::Region(0), b.region_args(op, 0, 0))],
                Point::Terminator(t) if b[t].name == "scf.condition" => vec![(Succ::Region(1), b.region_args(op, 1, 0)), (Succ::Parent, results.to_vec())],
                Point::Terminator(_) => vec![(Succ::Region(0), b.region_args(op, 0, 0))],
            },
            "scf.execute_region" | "scf.index_switch" => match point {
                Point::Parent => (0..b[op].regions.len()).map(|r| (Succ::Region(r), Vec::new())).collect(),
                Point::Terminator(_) => vec![(Succ::Parent, results.to_vec())],
            },
            _ => Vec::new(),
        }
    }

    fn entry_operands(&self, b: &Body<'_>, op: OpId) -> Vec<Operand> {
        let from = match &*b[op].name {
            "scf.for" => 3,
            "scf.while" => 0,
            _ => return Vec::new(),
        };
        (from..b[op].operands.len()).map(|i| (op, i)).collect()
    }

    fn entry_successors<'a>(&self, b: &Body<'a>, op: OpId, c: &[Option<Attribute<'a>>], all: Vec<(Succ, Vec<ValueId>)>) -> Vec<(Succ, Vec<ValueId>)> {
        match &*b[op].name {
            "scf.if" => match Body::selector_of(&c[0]) {
                Some(1) => vec![all[0].clone()],
                Some(_) => vec![all[1].clone()],
                None => all,
            },
            "scf.index_switch" => {
                let Some(v) = Body::selector_of(&c[0]) else { return all };
                let cases = b.segments(op, "cases").unwrap_or_default();
                let i = cases.iter().position(|x| *x as i128 == v).map_or(0, |i| i + 1);
                vec![(Succ::Region(i), Vec::new())]
            }
            _ => all,
        }
    }

    fn is_region_terminator(&self, b: &Body<'_>, t: OpId) -> bool {
        matches!(&*b[t].name, "scf.yield" | "scf.condition")
    }

    fn terminator_skip(&self, b: &Body<'_>, t: OpId) -> usize {
        usize::from(b[t].name == "scf.condition")
    }

    /// `scf.condition`: `[after, parent]`, by the condition.
    fn terminator_successors<'a>(&self, b: &Body<'a>, t: OpId, c: &[Option<Attribute<'a>>], all: Vec<(Succ, Vec<ValueId>)>) -> Vec<(Succ, Vec<ValueId>)> {
        if b[t].name != "scf.condition" {
            return all;
        }
        match Body::selector_of(&c[0]) {
            Some(1) => all.into_iter().filter(|s| s.0 != Succ::Parent).collect(),
            Some(_) => all.into_iter().filter(|s| s.0 == Succ::Parent).collect(),
            None => all,
        }
    }
}

/// `SCFInlinerInterface`.
impl DialectInliner for ScfDialect {
    fn legal_region(&self, _: &Body<'_>, _: crate::RegionId) -> bool {
        true
    }

    fn legal_op(&self, _: &Body<'_>, _: OpId) -> bool {
        true
    }

    fn replace_with_terminator(&self, b: &mut Body<'_>, op: OpId, results: &[ValueId]) {
        if b[op].name != "scf.yield" {
            return;
        }
        for (r, v) in results.iter().zip(b[op].operands.clone()) {
            b.replace_all_uses(*r, v);
        }
    }
}

#[cfg(feature = "dialect.bufferization")]
mod bufferizable {
    use alloc::format;
    use alloc::vec;
    use alloc::vec::Vec;

    use mlirformat::{Error, Shaped, ShapedKind, Type};

    use super::ScfDialect;
    use crate::{buffer_of, buffer_type, is_tensor, replace_with_buffers, AliasingOperand, AliasingValue, AnalysisState, Body, BufferRelation, Bufferizable, BufferizationOptions, Def, OpData, OpId, Operand, RegionId, Rewriter, ValueId};

    /// `scf.for`, `scf.if`, `scf.yield`, `scf.execute_region`.
    struct For;
    struct If;
    struct Yield;
    struct ExecuteRegion;

    impl ScfDialect {
        pub(crate) fn bufferizable_op(name: &str) -> Option<&'static dyn Bufferizable> {
            Some(match name {
                "scf.for" => &For,
                "scf.if" => &If,
                "scf.yield" => &Yield,
                "scf.execute_region" => &ExecuteRegion,
                _ => return None,
            })
        }
    }

    /// The body block of region `r` of `op`.
    fn body_of(b: &Body<'_>, op: OpId, r: usize) -> crate::BlockId {
        b[b[op].regions[r]].blocks[0]
    }

    /// The terminator (`scf.yield`) of region `r` of `op`.
    fn yield_of(b: &Body<'_>, op: OpId, r: usize) -> OpId {
        *b[body_of(b, op, r)].ops.last().expect("a terminator")
    }

    /// `castBuffer`: `buffer` as `ty`, through a `memref.cast` when it differs.
    fn cast_buffer<'a>(rw: &mut Rewriter<'_, 'a>, buffer: ValueId, ty: &Type<'a>) -> ValueId {
        if rw.body[buffer].ty == *ty {
            return buffer;
        }
        let c = rw.create(OpData::build("memref.cast").operands(&[buffer]), core::slice::from_ref(ty));
        rw.body[c].results[0]
    }

    /// `Region::isAncestor` of `r` over region `of`.
    fn region_contains(b: &Body<'_>, r: RegionId, mut of: Option<RegionId>) -> bool {
        while let Some(x) = of {
            if x == r {
                return true;
            }
            let op = b[x].parent;
            of = b[op].parent.and_then(|blk| b[blk].parent);
        }
        false
    }

    /// `doesNotAliasExternalValue`: no alias of `v` (but `except`) is defined outside `region`.
    fn no_external_alias(s: &AnalysisState<'_>, b: &Body<'_>, v: ValueId, region: RegionId, except: ValueId) -> bool {
        s.alias_set(v).into_iter().filter(|a| *a != except).all(|a| match b[a].def {
            Def::Arg(blk, _) => {
                let r = b[blk].parent.expect("a region");
                r != region && region_contains(b, region, Some(r))
            }
            Def::Result(op, _) => region_contains(b, region, b[op].parent.and_then(|blk| b[blk].parent)),
        })
    }

    /// `mayHaveZeroIterations`.
    fn may_have_zero_iterations(b: &Body<'_>, op: OpId) -> bool {
        match (b.const_index(b[op].operands[0]), b.const_index(b[op].operands[1])) {
            (Some(lb), Some(ub)) => ub <= lb,
            _ => true,
        }
    }

    impl For {
        /// The iteration argument (block argument) of init operand `i`.
        fn iter_arg(b: &Body<'_>, op: OpId, i: usize) -> ValueId {
            b[body_of(b, op, 0)].args[i - 2]
        }

        /// `bufferRelation`: equivalent when the body yields its iteration argument's buffer.
        fn relation(s: &AnalysisState<'_>, b: &Body<'_>, op: OpId, k: usize) -> BufferRelation {
            let arg = b[body_of(b, op, 0)].args[k + 1];
            let yielded = b[yield_of(b, op, 0)].operands[k];
            if s.equivalent(arg, yielded) { BufferRelation::Equivalent } else { BufferRelation::Unknown }
        }

        /// `computeLoopRegionIterArgBufferType`.
        fn iter_arg_type<'a>(o: &BufferizationOptions, b: &Body<'a>, op: OpId, k: usize, stack: &mut Vec<ValueId>) -> Result<Type<'a>, Error> {
            let arg = b[body_of(b, op, 0)].args[k + 1];
            let init = crate::buffer_type_in(o, b, b[op].operands[3 + k], stack)?;
            if stack.iter().filter(|v| **v == arg).count() >= 2 {
                return Ok(init);
            }
            let yv = b[yield_of(b, op, 0)].operands[k];
            let yielded = if is_tensor(&b[yv].ty) { crate::buffer_type_in(o, b, yv, stack)? } else { b[yv].ty.clone() };
            if init == yielded {
                return Ok(yielded);
            }
            let space = |t: &Type<'a>| match t {
                Type::Shaped(m) => m.extras.iter().find(|a| !a.is_layout()).cloned(),
                _ => None,
            };
            if space(&init) != space(&yielded) {
                return Err(Error(format!("'{}' op init_arg and yielded value bufferize to inconsistent memory spaces", b[op].name)));
            }
            let Type::Shaped(t) = &b[arg].ty else { return Err(Error("expected a tensor".into())) };
            Ok(BufferizationOptions::fully_dynamic(t, space(&yielded)))
        }
    }

    impl Bufferizable for For {
        fn reads(&self, s: &AnalysisState<'_>, b: &Body<'_>, (op, i): Operand) -> bool {
            may_have_zero_iterations(b, op) || s.value_read(b, Self::iter_arg(b, op, i))
        }

        fn aliasing_values(&self, s: &AnalysisState<'_>, b: &Body<'_>, (op, i): Operand) -> Vec<AliasingValue> {
            if i < 3 {
                return Vec::new();
            }
            let relation = Self::relation(s, b, op, i - 3);
            vec![AliasingValue { value: b[op].results[i - 3], relation, definite: relation == BufferRelation::Equivalent }]
        }

        fn writable(&self, _: &AnalysisState<'_>, _: &Body<'_>, _: ValueId) -> bool {
            true
        }

        /// The operands' conflicts, then the yielded values that may alias a value outside the
        /// loop replaced by new tensors.
        fn resolve_conflicts(&self, rw: &mut Rewriter<'_, '_>, s: &AnalysisState<'_>, op: OpId) -> Result<(), Error> {
            s.resolve_tensor_conflicts(rw, op)?;
            if s.options.copy_before_write {
                return Ok(());
            }
            let y = yield_of(rw.body, op, 0);
            let region = rw.body[op].regions[0];
            rw.set_before(y);
            let n = rw.body[y].operands.len();
            for k in 0..n {
                let v = rw.body[y].operands[k];
                let arg = rw.body[body_of(rw.body, op, 0)].args[k + 1];
                if !is_tensor(&rw.body[rw.body[op].operands[3 + k]].ty) || no_external_alias(s, rw.body, v, region, arg) {
                    continue;
                }
                let t = s.allocate_tensor_for(rw, v, true)?;
                rw.modify(y, |b| b.set_operand(y, k, t));
            }
            Ok(())
        }

        fn buffer_type<'a>(&self, o: &BufferizationOptions, b: &Body<'a>, v: ValueId, stack: &mut Vec<ValueId>) -> Result<Type<'a>, Error> {
            let op = b.owner_of(v);
            match b[v].def {
                Def::Result(_, k) => {
                    let arg = b[body_of(b, op, 0)].args[k as usize + 1];
                    crate::buffer_type_in(o, b, arg, stack)
                }
                Def::Arg(_, a) => Self::iter_arg_type(o, b, op, a as usize - 1, stack),
            }
        }

        fn bufferize(&self, rw: &mut Rewriter<'_, '_>, o: &BufferizationOptions, op: OpId) -> Result<(), Error> {
            let old_body = body_of(rw.body, op, 0);
            let operands = rw.body[op].operands.to_vec();
            let results = rw.body[op].results.to_vec();
            let mut inits = Vec::new();
            for (k, v) in operands[3..].iter().enumerate() {
                if !is_tensor(&rw.body[*v].ty) {
                    inits.push(*v);
                    continue;
                }
                let b = buffer_of(rw, o, *v)?;
                let ty = buffer_type(o, rw.body, results[k])?;
                inits.push(cast_buffer(rw, b, &ty));
            }
            let tensors: Vec<bool> = operands[3..].iter().map(|v| is_tensor(&rw.body[*v].ty)).collect();
            let types: Vec<Type<'_>> = inits.iter().map(|v| rw.body[*v].ty.clone()).collect();
            let mut new_operands = operands[..3].to_vec();
            new_operands.extend(&inits);
            let old = rw.body[op].clone();
            let mut data = OpData::named(old.name.clone()).operands(&new_operands);
            data.properties.clone_from(&old.properties);
            data.attributes.clone_from(&old.attributes);
            let old_args = rw.body[old_body].args.to_vec();
            let mut arg_types = vec![(rw.body[old_args[0]].ty.clone(), rw.body[old_args[0]].loc.clone())];
            arg_types.extend(types.iter().zip(&old_args[1..]).map(|(t, a)| (t.clone(), rw.body[*a].loc.clone())));
            let n = rw.create_with(data, &types, |b, o| {
                let r = b.add_region(o);
                b.add_block(r, &arg_types);
            });
            let new_body = body_of(rw.body, n, 0);
            let new_args = rw.body[new_body].args.to_vec();
            rw.set_start(new_body);
            let mut repl = vec![new_args[0]];
            for (k, a) in new_args[1..].iter().enumerate() {
                if tensors[k] {
                    let ty = rw.body[old_args[k + 1]].ty.clone();
                    let t = rw.create(OpData::build("bufferization.to_tensor").operands(&[*a]), &[ty]);
                    repl.push(rw.body[t].results[0]);
                } else {
                    repl.push(*a);
                }
            }
            rw.merge_blocks(old_body, new_body, &repl);
            let new_results = rw.body[n].results.to_vec();
            replace_with_buffers(rw, op, &new_results);
            Ok(())
        }

        /// `verifyAnalysis`: without `allow-return-allocs-from-loops`, every yield equivalent.
        fn verify(&self, s: &AnalysisState<'_>, b: &Body<'_>, op: OpId) -> Result<(), Error> {
            if s.options.allow_return_allocs_from_loops {
                return Ok(());
            }
            for (k, r) in b[op].results.iter().enumerate() {
                if is_tensor(&b[*r].ty) && Self::relation(s, b, op, k) != BufferRelation::Equivalent {
                    return Err(Error(format!("Yield operand #{k} is not equivalent to the corresponding iter bbArg")));
                }
            }
            Ok(())
        }
    }

    impl Bufferizable for If {
        fn aliasing_operands(&self, _: &AnalysisState<'_>, b: &Body<'_>, v: ValueId) -> Vec<AliasingOperand> {
            let Def::Result(op, k) = b[v].def else { return Vec::new() };
            (0..2).map(|r| AliasingOperand { operand: (yield_of(b, op, r), k as usize), relation: BufferRelation::Equivalent, definite: false }).collect()
        }

        fn buffer_type<'a>(&self, o: &BufferizationOptions, b: &Body<'a>, v: ValueId, stack: &mut Vec<ValueId>) -> Result<Type<'a>, Error> {
            let Def::Result(op, k) = b[v].def else { return Err(Error("expected a result".into())) };
            let mut types = Vec::new();
            for r in 0..2 {
                let yv = b[yield_of(b, op, r)].operands[k as usize];
                types.push(if is_tensor(&b[yv].ty) { crate::buffer_type_in(o, b, yv, stack)? } else { b[yv].ty.clone() });
            }
            if types[0] == types[1] {
                return Ok(types.swap_remove(0));
            }
            let space = |t: &Type<'a>| match t {
                Type::Shaped(m) => m.extras.iter().find(|a| !a.is_layout()).cloned(),
                _ => None,
            };
            if space(&types[0]) != space(&types[1]) {
                return Err(Error(format!("'{}' op inconsistent memory space on then/else branches", b[op].name)));
            }
            let Type::Shaped(t) = &b[v].ty else { return Err(Error("expected a tensor".into())) };
            Ok(BufferizationOptions::fully_dynamic(&Shaped { kind: ShapedKind::Tensor, ..t.clone() }, space(&types[0])))
        }

        fn bufferize(&self, rw: &mut Rewriter<'_, '_>, o: &BufferizationOptions, op: OpId) -> Result<(), Error> {
            let results = rw.body[op].results.to_vec();
            let mut types = Vec::new();
            for r in &results {
                types.push(if is_tensor(&rw.body[*r].ty) { buffer_type(o, rw.body, *r)? } else { rw.body[*r].ty.clone() });
            }
            let old = rw.body[op].clone();
            let mut data = OpData::named(old.name.clone()).operands(&old.operands);
            data.properties.clone_from(&old.properties);
            data.attributes.clone_from(&old.attributes);
            let n = rw.create_with(data, &types, |b, o| {
                for _ in 0..2 {
                    let r = b.add_region(o);
                    b.add_block(r, &[]);
                }
            });
            for r in 0..2 {
                let (from, to) = (body_of(rw.body, op, r), body_of(rw.body, n, r));
                rw.merge_blocks(from, to, &[]);
            }
            let new_results = rw.body[n].results.to_vec();
            replace_with_buffers(rw, op, &new_results);
            Ok(())
        }
    }

    impl ExecuteRegion {
        /// `getUniqueYieldOp`: the only `scf.yield` terminating a block of the region.
        fn unique_yield(b: &Body<'_>, op: OpId) -> Option<OpId> {
            let mut yields = b[b[op].regions[0]].blocks.iter().filter_map(|blk| b[*blk].ops.last().copied().filter(|t| &*b[*t].name == "scf.yield"));
            let y = yields.next()?;
            yields.next().is_none().then_some(y)
        }
    }

    impl Bufferizable for ExecuteRegion {
        fn unstructured_control_flow(&self, _: &Body<'_>, _: OpId) -> bool {
            true
        }

        fn writable(&self, _: &AnalysisState<'_>, _: &Body<'_>, _: ValueId) -> bool {
            true
        }

        fn buffer_type<'a>(&self, o: &BufferizationOptions, b: &Body<'a>, v: ValueId, stack: &mut Vec<ValueId>) -> Result<Type<'a>, Error> {
            AnalysisState::unstructured_buffer_type(o, b, v, stack)
        }

        fn verify(&self, _: &AnalysisState<'_>, b: &Body<'_>, op: OpId) -> Result<(), Error> {
            match Self::unique_yield(b, op) {
                Some(_) => Ok(()),
                None => Err(Error(format!("'{}' op op without unique scf.yield is not supported", b[op].name))),
            }
        }

        /// A result aliases (is equivalent to) the operand the unique yield gives it.
        fn aliasing_operands(&self, s: &AnalysisState<'_>, b: &Body<'_>, v: ValueId) -> Vec<AliasingOperand> {
            match b[v].def {
                Def::Result(op, k) => Self::unique_yield(b, op).map_or_else(Vec::new, |y| vec![AliasingOperand { operand: (y, k as usize), relation: BufferRelation::Equivalent, definite: true }]),
                Def::Arg(..) => s.default_aliasing_operands(b, v),
            }
        }

        /// The region moved into a new op whose results take the yielded buffers' types.
        fn bufferize(&self, rw: &mut Rewriter<'_, '_>, o: &BufferizationOptions, op: OpId) -> Result<(), Error> {
            let y = Self::unique_yield(rw.body, op).ok_or_else(|| Error("op without unique scf.yield is not supported".into()))?;
            let mut types = Vec::new();
            for v in rw.body[y].operands.to_vec() {
                types.push(if is_tensor(&rw.body[v].ty) { buffer_type(o, rw.body, v)? } else { rw.body[v].ty.clone() });
            }
            let old = rw.body[op].clone();
            let mut data = OpData::named(old.name.clone());
            data.properties.clone_from(&old.properties);
            data.attributes.clone_from(&old.attributes);
            let n = rw.create_with(data, &types, |b, o| {
                b.add_region(o);
            });
            let (from, to) = (rw.body[op].regions[0], rw.body[n].regions[0]);
            rw.inline_region_before(from, to, None);
            for blk in rw.body[to].blocks.to_vec() {
                crate::bufferize_block_signature(rw, o, blk)?;
            }
            let new_results = rw.body[n].results.to_vec();
            replace_with_buffers(rw, op, &new_results);
            Ok(())
        }
    }

    impl Bufferizable for Yield {
        fn writes(&self, _: &AnalysisState<'_>, _: &Body<'_>, _: Operand) -> bool {
            false
        }

        fn aliasing_values(&self, _: &AnalysisState<'_>, b: &Body<'_>, (op, i): Operand) -> Vec<AliasingValue> {
            let Some(p) = b.parent_op(op) else { return Vec::new() };
            match &*b[p].name {
                "scf.if" => vec![AliasingValue { value: b[p].results[i], relation: BufferRelation::Equivalent, definite: false }],
                "scf.execute_region" => vec![AliasingValue::equivalent(b[p].results[i])],
                _ => Vec::new(),
            }
        }

        fn must_in_place(&self, _: &AnalysisState<'_>, _: &Body<'_>, _: Operand) -> bool {
            true
        }

        fn bufferize(&self, rw: &mut Rewriter<'_, '_>, o: &BufferizationOptions, op: OpId) -> Result<(), Error> {
            let Some(p) = rw.body.parent_op(op) else { return Err(Error("unsupported scf::YieldOp parent".into())) };
            let parent = rw.body[p].name.clone();
            if !matches!(&*parent, "scf.execute_region" | "scf.if" | "scf.index_switch" | "scf.for" | "scf.while") {
                return Err(Error("unsupported scf::YieldOp parent".into()));
            }
            let operands = rw.body[op].operands.to_vec();
            let mut new = Vec::new();
            for (k, v) in operands.iter().enumerate() {
                if !is_tensor(&rw.body[*v].ty) {
                    new.push(*v);
                    continue;
                }
                let mut buffer = buffer_of(rw, o, *v)?;
                if matches!(&*parent, "scf.for" | "scf.if" | "scf.index_switch") {
                    let r = rw.body[p].results[k];
                    let ty = buffer_type(o, rw.body, r)?;
                    buffer = cast_buffer(rw, buffer, &ty);
                } else if &*parent == "scf.while" {
                    let arg = rw.body[body_of(rw.body, p, 0)].args[k];
                    let ty = buffer_type(o, rw.body, arg)?;
                    buffer = cast_buffer(rw, buffer, &ty);
                }
                new.push(buffer);
            }
            rw.replace_with(op, OpData::named(rw.body[op].name.clone()).operands(&new), &[]);
            Ok(())
        }
    }
}
