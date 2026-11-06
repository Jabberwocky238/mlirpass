//! Bufferizing, as `Bufferize.cpp` and `TensorCopyInsertion.cpp`: the conflicts the analysis
//! found resolved by copies, then every op with tensor semantics rewritten on buffers (its
//! tensors' buffers through `bufferization.to_buffer`, its results handed back through
//! `bufferization.to_tensor`), and the `to_buffer` / `to_tensor` pairs folded.

use alloc::format;
use alloc::vec::Vec;

use mlirformat::{Error, Type};

use super::{is_tensor, AnalysisState, BufferizationOptions};
use crate::{BlockId, Body, Def, Listener, OpData, OpId, Rewriter, ValueId};

/// `getBufferType(value, options, state, invocationStack)`: through the owner's interface,
/// else the tensor type's default buffer.
pub(crate) fn buffer_type_in<'a>(o: &BufferizationOptions, b: &Body<'a>, v: ValueId, stack: &mut Vec<ValueId>) -> Result<Type<'a>, Error> {
    stack.push(v);
    let owner = b.owner_of(v);
    let r = match o.bufferizable(b, owner) {
        Some(i) => i.buffer_type(o, b, v, stack),
        None => match &b[v].ty {
            t if BufferizationOptions::tensor_like(t).is_some() => Ok(BufferizationOptions::tensor_like(t).expect("tensor-like")),
            Type::Shaped(t) => match o.default_memory_space(t) {
                Some(space) => Ok(o.memref_type(t, None, space)),
                None => Err(Error(format!("'{}' op could not infer memory space", b[owner].name))),
            },
            _ => Err(Error("expected a tensor".into())),
        },
    };
    stack.pop();
    r
}

/// `getBufferType(value, options, state)`.
pub fn buffer_type<'a>(o: &BufferizationOptions, b: &Body<'a>, v: ValueId) -> Result<Type<'a>, Error> {
    buffer_type_in(o, b, v, &mut Vec::new())
}

/// `getBuffer`: the buffer of tensor `v`, a `to_tensor`'s operand or a new `to_buffer` right
/// after `v`'s definition.
pub fn buffer_of(rw: &mut Rewriter<'_, '_>, o: &BufferizationOptions, v: ValueId) -> Result<ValueId, Error> {
    if let Def::Result(d, _) = rw.body[v].def
        && rw.body[d].name == "bufferization.to_tensor"
    {
        return Ok(rw.body[d].operands[0]);
    }
    let saved = rw.ip;
    match rw.body[v].def {
        Def::Arg(blk, _) => rw.set_start(blk),
        Def::Result(d, _) => rw.set_after(d),
    }
    let ty = buffer_type(o, rw.body, v)?;
    let t = rw.create(OpData::build("bufferization.to_buffer").operands(&[v]), &[ty]);
    rw.ip = saved;
    Ok(rw.body[t].results[0])
}

/// `replaceOpWithBufferizedValues`: `op`'s results replaced by `values`, a tensor one through a
/// `to_tensor` of its buffer.
pub fn replace_with_buffers(rw: &mut Rewriter<'_, '_>, op: OpId, values: &[ValueId]) {
    let saved = rw.ip;
    let results = rw.body[op].results.to_vec();
    let mut with = Vec::new();
    for (r, v) in results.iter().zip(values) {
        if is_tensor(&rw.body[*r].ty) {
            rw.set_after(op);
            let ty = rw.body[*r].ty.clone();
            let t = rw.create(OpData::build("bufferization.to_tensor").operands(&[*v]), &[ty]);
            with.push(rw.body[t].results[0]);
        } else {
            with.push(*v);
        }
    }
    rw.replace_op(op, &with);
    rw.ip = saved;
}

/// `bufferizeBlockSignature`: `block`'s tensor arguments become buffers (their uses through a
/// `to_tensor`), and the branches to it pass buffers.
pub fn bufferize_block_signature(rw: &mut Rewriter<'_, '_>, o: &BufferizationOptions, block: BlockId) -> Result<(), Error> {
    let saved = rw.ip;
    let args = rw.body[block].args.to_vec();
    let mut types = Vec::new();
    for a in &args {
        types.push(if is_tensor(&rw.body[*a].ty) { buffer_type(o, rw.body, *a)? } else { rw.body[*a].ty.clone() });
    }
    for (a, ty) in args.iter().zip(&types) {
        if rw.body[*a].ty == *ty {
            continue;
        }
        let uses = rw.body.uses_of(*a);
        let tensor = core::mem::replace(&mut rw.body[*a].ty, ty.clone());
        rw.set_start(block);
        if !uses.is_empty() {
            let t = rw.create(OpData::build("bufferization.to_tensor").operands(&[*a]), &[tensor]);
            let tv = rw.body[t].results[0];
            for (user, k) in uses {
                rw.body.set_operand(user, k, tv);
            }
        }
    }
    let preds: Vec<(OpId, usize)> = rw.body.predecessors(block);
    for (br, succ) in preds {
        let Some(range) = rw.body.successor_operands(br, succ) else { return Err(Error(format!("'{}' op cannot bufferize ops with block references that do not implement BranchOpInterface", rw.body[br].name))) };
        for (k, ty) in range.clone().zip(&types) {
            let v = rw.body[br].operands[k];
            if rw.body[v].ty == *ty {
                continue;
            }
            let bty = buffer_type(o, rw.body, v)?;
            match rw.body[v].def {
                Def::Arg(blk, _) => rw.set_start(blk),
                Def::Result(d, _) => rw.set_after(d),
            }
            let mut m = rw.create(OpData::build("bufferization.to_buffer").operands(&[v]), &[bty.clone()]);
            if bty != *ty {
                let mv = rw.body[m].results[0];
                m = rw.create(OpData::build("memref.cast").operands(&[mv]), &[ty.clone()]);
            }
            let nv = rw.body[m].results[0];
            rw.body.set_operand(br, k, nv);
        }
    }
    rw.ip = saved;
    Ok(())
}

/// `castOrReallocMemRefValue`: `value` as `dest`: a `memref.cast` when that always succeeds,
/// else a new buffer it is copied into.
pub fn cast_or_realloc<'a>(rw: &mut Rewriter<'_, 'a>, o: &BufferizationOptions, value: ValueId, dest: &Type<'a>) -> Option<ValueId> {
    let (Type::Shaped(s), Type::Shaped(d)) = (&rw.body[value].ty, dest) else { return None };
    if s.elem != d.elem || s.shape.as_ref().map(Vec::len) != d.shape.as_ref().map(Vec::len) {
        return None;
    }
    let dest = dest.clone();
    let guaranteed = {
        use crate::MemrefLayout;
        match (s.strides_and_offset(), d.strides_and_offset()) {
            (Some((ss, so)), Some((ds, doff))) => {
                let dyn_to_static = |a: i64, b: i64| a == mlirformat::Dim::DYNAMIC && b != mlirformat::Dim::DYNAMIC;
                !dyn_to_static(so, doff) && !ss.iter().zip(&ds).any(|(a, b)| dyn_to_static(*a, *b))
            }
            _ => false,
        }
    };
    if crate::memref_cast_compatible(&rw.body[value].ty, &dest) && guaranteed {
        let c = rw.create(OpData::build("memref.cast").operands(&[value]), &[dest]);
        return Some(rw.body[c].results[0]);
    }
    let shape = dest.dims().unwrap_or_default();
    let mut dynamic = Vec::new();
    for (i, s) in shape.iter().enumerate() {
        if *s == mlirformat::Dim::DYNAMIC {
            let k = rw.value_of(crate::MemrefOfr::C(i as i64));
            let dim = rw.create(OpData::build("memref.dim").operands(&[value, k]), &[Type::Index]);
            dynamic.push(rw.body[dim].results[0]);
        }
    }
    let copy = o.create_alloc(rw, &dest, &dynamic);
    rw.create(OpData::build("memref.copy").operands(&[value, copy]), &[]);
    Some(copy)
}

impl BufferizationOptions {
    /// `createAlloc`: a `memref.alloc` of `ty`, aligned to `buffer_alignment` unless 0.
    pub fn create_alloc<'a>(&self, rw: &mut Rewriter<'_, 'a>, ty: &Type<'a>, dynamic: &[ValueId]) -> ValueId {
        let mut data = OpData::build("memref.alloc").operands(dynamic).segments(&[dynamic.len(), 0]);
        if self.buffer_alignment != 0 {
            data.set("alignment", mlirformat::Attribute::integer(self.buffer_alignment as i128, Type::int(64)));
        }
        let a = rw.create(data, core::slice::from_ref(ty));
        rw.body[a].results[0]
    }
}

/// `foldToBufferToTensorPair`: a `to_buffer` of a `to_tensor` is the latter's buffer (cast or
/// copied to the type asked).
pub(crate) fn fold_to_buffer_to_tensor(rw: &mut Rewriter<'_, '_>, o: &BufferizationOptions, op: OpId) -> bool {
    let Some(tt) = rw.body.def_named(rw.body[op].operands[0], "bufferization.to_tensor") else { return false };
    let src = rw.body[tt].operands[0];
    let dest = rw.body[rw.body[op].results[0]].ty.clone();
    if rw.body[src].ty == dest {
        rw.replace_op(op, &[src]);
        return true;
    }
    let ranked = |t: &Type<'_>| matches!(t, Type::Shaped(s) if s.shape.is_some());
    if ranked(&rw.body[src].ty) && ranked(&dest) {
        rw.set_before(op);
        if let Some(r) = cast_or_realloc(rw, o, src, &dest) {
            rw.replace_op(op, &[r]);
            return true;
        }
        return false;
    }
    if !ranked(&rw.body[src].ty) && ranked(&dest) {
        return false;
    }
    rw.set_before(op);
    rw.replace_with(op, OpData::build("memref.cast").operands(&[src]), &[dest]);
    true
}

/// What `bufferizeOp`'s rewriter hears (`BufferizationRewriter`): erased ops, new `to_buffer`s,
/// and new ops with tensor semantics to bufferize.
struct Tracker<'o> {
    options: &'o BufferizationOptions,
    erased: Vec<OpId>,
    to_buffers: Vec<OpId>,
    worklist: Vec<OpId>,
}

impl<'a> Listener<'a> for Tracker<'_> {
    fn erased(&mut self, _: &Body<'a>, op: OpId) {
        self.erased.push(op);
        self.to_buffers.retain(|o| *o != op);
    }

    fn inserted(&mut self, b: &Body<'a>, op: OpId) {
        self.erased.retain(|o| *o != op);
        match &*b[op].name {
            "bufferization.to_buffer" => self.to_buffers.push(op),
            "bufferization.to_tensor" => {}
            _ => {
                if b.default_tensor_semantics(op) && self.options.allowed(b, op) {
                    self.worklist.push(op);
                }
            }
        }
    }

    fn moved(&mut self, _: &Body<'a>, _: OpId) {}
}

/// ⭐ `insertTensorCopies`: every allowed op resolves its conflicts (`resolveConflicts`).
pub(crate) fn insert_copies(body: &mut Body<'_>, s: &AnalysisState<'_>, root: OpId) -> Result<(), Error> {
    // `Operation::walk`: post order, as upstream.
    let mut ops = Vec::new();
    body.walk_post(root, &mut |op| ops.push(op));
    let symbol_table = body.is_symbol_table(root);
    let mut listener = Tracker { options: s.options, erased: Vec::new(), to_buffers: Vec::new(), worklist: Vec::new() };
    let mut rw = Rewriter::new(body, &mut listener);
    for op in ops {
        if symbol_table && op != root && rw.body.nearest_symbol_table(op) != Some(root) {
            continue;
        }
        let Some(i) = s.options.bufferizable(rw.body, op) else { continue };
        rw.set_before(op);
        rw.loc = rw.body[op].loc.clone();
        i.resolve_conflicts(&mut rw, s, op)?;
    }
    Ok(())
}

/// ⭐ `bufferizeOp`: every allowed op with tensor semantics, in post order (and those created
/// meanwhile), bufferized; then the `to_buffer` / `to_tensor` pairs folded, unused `to_tensor`s
/// erased, and what did not bufferize reported.
pub(crate) fn bufferize_op(body: &mut Body<'_>, o: &BufferizationOptions, root: OpId) -> Result<(), Error> {
    if o.copy_before_write {
        let s = AnalysisState::new(o);
        insert_copies(body, &s, root)?;
    }
    let mut listener = Tracker { options: o, erased: Vec::new(), to_buffers: Vec::new(), worklist: Vec::new() };
    body.walk(root, &mut |op| {
        if body[op].name == "bufferization.to_buffer" {
            listener.to_buffers.push(op);
        }
    });
    body.walk_post(root, &mut |op| {
        if o.allowed(body, op) && AnalysisState::tensor_semantics_of(o, body, op) {
            listener.worklist.push(op);
        }
    });
    let mut i = 0;
    loop {
        let Some(&next) = listener.worklist.get(i) else { break };
        i += 1;
        if listener.erased.contains(&next) {
            continue;
        }
        let Some(iface) = o.bufferizable(body, next) else { continue };
        if !iface.tensor_semantics(body, next) {
            continue;
        }
        if !iface.unstructured_control_flow(body, next) && body[next].regions.iter().any(|r| body[*r].blocks.len() > 1) {
            return Err(Error(format!("'{}' op op or BufferizableOpInterface implementation does not support unstructured control flow, but at least one region has multiple blocks", body[next].name)));
        }
        let mut rw = Rewriter::new(body, &mut listener);
        rw.set_before(next);
        rw.loc = rw.body[next].loc.clone();
        iface.bufferize(&mut rw, o, next).map_err(|_| Error(format!("'{}' op failed to bufferize op", body[next].name)))?;
    }
    if listener.erased.contains(&root) {
        return Ok(());
    }
    let to_buffers = core::mem::take(&mut listener.to_buffers);
    {
        let mut rw = Rewriter::new(body, &mut listener);
        for op in to_buffers {
            rw.set_before(op);
            rw.loc = rw.body[op].loc.clone();
            let _ = fold_to_buffer_to_tensor(&mut rw, o, op);
        }
        let mut to_tensors = Vec::new();
        rw.body.walk_post(root, &mut |op| to_tensors.push(op));
        for op in to_tensors {
            if rw.body[op].parent.is_some() && rw.body[op].name == "bufferization.to_tensor" && rw.body[rw.body[op].results[0]].uses.is_empty() {
                rw.erase_op(op);
            }
        }
    }
    if o.allow_unknown_ops {
        return Ok(());
    }
    let worklist = core::mem::take(&mut listener.worklist);
    for op in worklist {
        if listener.erased.contains(&op) || body[op].parent.is_none() && op != root {
            continue;
        }
        if !AnalysisState::tensor_semantics_of(o, body, op) || !o.allowed(body, op) {
            continue;
        }
        if body[op].results.iter().all(|r| body[*r].uses.is_empty()) && body.is_memory_effect_free(op) {
            continue;
        }
        if matches!(&*body[op].name, "bufferization.to_tensor" | "bufferization.to_buffer") {
            continue;
        }
        return Err(Error(format!("'{}' op op was not bufferized", body[op].name)));
    }
    Ok(())
}

impl AnalysisState<'_> {
    /// `hasTensorSemantics` of `op` (its interface's, whatever the options allow).
    pub(crate) fn tensor_semantics_of(_: &BufferizationOptions, b: &Body<'_>, op: OpId) -> bool {
        match b.ctx.interfaces.of(&b[op].name).and_then(|i| i.bufferizable(&b[op].name)) {
            Some(i) => i.tensor_semantics(b, op),
            None => b.default_tensor_semantics(op),
        }
    }
}

/// ⭐ `runOneShotBufferize`: analyze, resolve the conflicts with copies, bufferize; with
/// `test-analysis-only`, annotate the analysis instead.
pub fn one_shot_bufferize(body: &mut Body<'_>, o: &BufferizationOptions, root: OpId) -> Result<(), Error> {
    if !o.copy_before_write {
        let s = AnalysisState::analyze(o, body, root)?;
        if o.test_analysis_only {
            s.annotate(body, root);
            if o.dump_alias_sets {
                s.annotate_alias_sets(body, root);
            }
            return Ok(());
        }
        insert_copies(body, &s, root)?;
    }
    bufferize_op(body, o, root)
}

impl Body<'_> {
    /// `getParentWithTrait<SymbolTable>`: the nearest op around `op` that is a symbol table.
    fn nearest_symbol_table(&self, op: OpId) -> Option<OpId> {
        let mut at = self.parent_op(op);
        while let Some(p) = at {
            if self.is_symbol_table(p) {
                return Some(p);
            }
            at = self.parent_op(p);
        }
        None
    }
}

/// `foldMemRefCasts`: a result every return yields through a `memref.cast` of one same type
/// gets that type, the casts dropped.
fn fold_memref_casts(body: &mut Body<'_>, f: OpId) {
    if body[f].regions.first().is_none_or(|r| body[*r].blocks.is_empty()) {
        return;
    }
    let returns = super::return_ops(body, f);
    let Some(&first) = returns.first() else { return };
    let unpack = |b: &Body<'_>, v: ValueId| match b[v].def {
        Def::Result(c, _) if b[c].name == "memref.cast" => b[c].operands[0],
        _ => v,
    };
    let n = body[first].operands.len();
    let mut types: Vec<Option<Type<'_>>> = Vec::new();
    for k in 0..n {
        let t = body[unpack(body, body[first].operands[k])].ty.clone();
        let same = returns.iter().all(|r| body[unpack(body, body[*r].operands[k])].ty == t);
        types.push(same.then_some(t));
    }
    for r in &returns {
        for k in 0..n {
            if types[k].is_some() {
                let v = unpack(body, body[*r].operands[k]);
                body.set_operand(*r, k, v);
            }
        }
    }
    let (inputs, results) = super::func_signature(body, f);
    let results = results.into_iter().zip(types).map(|(old, t)| t.unwrap_or(old)).collect();
    body[f].set("function_type", mlirformat::Attribute::Type(Type::Function(mlirformat::FunctionType { inputs, results })));
}

/// ⭐ `runOneShotModuleBufferize`: the module analysis, the copies, then each function callees
/// first (and the module's other ops) bufferized, the bufferization argument attributes dropped.
pub fn one_shot_module_bufferize(body: &mut Body<'_>, o: &BufferizationOptions, module: OpId) -> Result<(), Error> {
    if !o.copy_before_write {
        let mut ao = o.clone();
        ao.deny_funcs.clone_from(&o.no_analysis_func_filter);
        let s = AnalysisState::analyze_module(&ao, body, module)?;
        if o.test_analysis_only {
            s.annotate_module(body, module);
            return Ok(());
        }
        insert_copies(body, &s, module)?;
    }
    let (mut ordered, remaining) = super::analysis::funcs_by_calls(body, module);
    ordered.extend(remaining);
    for f in ordered {
        let skip = body.sym_name(f).is_some_and(|n| o.no_analysis_func_filter.iter().any(|d| d == n));
        if skip {
            let copy = BufferizationOptions { copy_before_write: true, ..o.clone() };
            bufferize_op(body, &copy, f)?;
        } else {
            bufferize_op(body, o, f)?;
        }
        if o.function_boundary_layout == super::LayoutMapOption::Infer {
            fold_memref_casts(body, f);
        }
    }
    let tops: Vec<OpId> = body[module].regions.iter().flat_map(|r| body[*r].blocks.iter()).flat_map(|blk| body.ops(*blk)).collect();
    for op in tops {
        if body[op].parent.is_none() || body[op].name == "func.func" || body.is_symbol_table(op) {
            continue;
        }
        bufferize_op(body, o, op)?;
    }
    let funcs: Vec<OpId> = body[module].regions.iter().flat_map(|r| body[*r].blocks.iter()).flat_map(|blk| body.ops(*blk)).filter(|x| body[*x].name == "func.func").collect();
    for f in funcs {
        super::analysis::remove_func_arg_attr(body, f, "bufferization.buffer_layout");
        super::analysis::remove_func_arg_attr(body, f, "bufferization.writable");
    }
    Ok(())
}
