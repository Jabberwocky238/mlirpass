//! `inline`, as `InlinerPass.cpp` / `Inliner.cpp` / `InliningUtils.cpp` over `CallGraph.cpp`:
//! the call graph's SCCs bottom-up (LLVM's `scc_iterator`), each optimized with the op
//! pipelines and then its calls inlined, up to `max-iterations` times; callables left without
//! uses are erased at the end.

use alloc::collections::{BTreeMap, BTreeSet};
use alloc::format;
use alloc::string::String;
use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{Attribute, Error, Str, Type};

use crate::{BlockId, Body, DialectInliner, InsertPoint, Mapping, OpId, PassManager, RegionId, Trait, ValueId};

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum Edge {
    Abstract,
    Call,
    Child,
}

/// A call graph node: a callable region (`None`: the external caller / unknown callee).
struct Node {
    region: Option<RegionId>,
    edges: Vec<(usize, Edge)>,
}

/// `CallGraph`: node 0 is the external caller, node 1 the unknown callee, then the callable
/// regions in discovery order.
struct CallGraph {
    nodes: Vec<Node>,
    by_region: BTreeMap<RegionId, usize>,
}

const EXTERNAL: usize = 0;
const UNKNOWN: usize = 1;

impl<'a> Body<'a> {
    /// `CallableOpInterface::getCallableRegion`: a callable's body, when it has one.
    pub fn callable_region(&self, op: OpId) -> Option<RegionId> {
        if !self.has(op, Trait::CallableOpInterface) {
            return None;
        }
        self[op].regions.first().copied().filter(|r| !self[*r].blocks.is_empty())
    }

    /// `CallOpInterface::resolveCallable`: the callee value's defining op, or the symbol
    /// looked up from the nearest symbol table.
    pub fn resolve_call(&self, call: OpId) -> Option<OpId> {
        if let Some(callee) = self.interfaces(call).and_then(|i| i.indirect_callee(self, call)) {
            return self.def_op(callee);
        }
        let Some(Attribute::SymbolRef(path)) = self[call].get("callee") else { return None };
        self.lookup_nearest(call, path)
    }

    /// `SymbolTable::lookupNearestSymbolFrom(from, path)`.
    fn lookup_nearest(&self, from: OpId, path: &[Str<'_>]) -> Option<OpId> {
        let mut t = Some(from);
        while let Some(o) = t {
            if self.is_symbol_table(o) {
                return self.lookup_path(o, path)?.last().copied();
            }
            t = self.parent_op(o);
        }
        None
    }

    fn is_call(&self, op: OpId) -> bool {
        self.has(op, Trait::CallOpInterface)
    }

    /// The inliner interface of `op`'s dialect (borrowed from the context, not the body).
    fn inliner_of(&self, op: OpId) -> Option<&'a dyn DialectInliner> {
        let interfaces: &'a crate::Interfaces<'a> = self.ctx.interfaces;
        interfaces.of(&self[op].name).and_then(|i| i.inliner())
    }
}

impl CallGraph {
    fn new(body: &Body<'_>, root: OpId) -> Self {
        let mut cg = Self { nodes: vec![Node { region: None, edges: Vec::new() }, Node { region: None, edges: Vec::new() }], by_region: BTreeMap::new() };
        cg.compute(body, root, None, false);
        cg.compute(body, root, None, true);
        cg
    }

    fn add_edge(&mut self, from: usize, to: usize, kind: Edge) {
        if !self.nodes[from].edges.contains(&(to, kind)) {
            self.nodes[from].edges.push((to, kind));
        }
    }

    /// `getOrAddNode`.
    fn node_for(&mut self, region: RegionId, parent: Option<usize>) -> usize {
        if let Some(n) = self.by_region.get(&region) {
            return *n;
        }
        let n = self.nodes.len();
        self.nodes.push(Node { region: Some(region), edges: Vec::new() });
        self.by_region.insert(region, n);
        match parent {
            Some(p) => self.add_edge(p, n, Edge::Child),
            None => self.add_edge(EXTERNAL, n, Edge::Abstract),
        }
        n
    }

    /// `computeCallGraph`.
    fn compute(&mut self, body: &Body<'_>, op: OpId, mut parent: Option<usize>, resolve: bool) {
        if body.is_call(op) {
            if resolve && let Some(p) = parent {
                let target = self.resolve(body, op);
                self.add_edge(p, target, Edge::Call);
            }
            return;
        }
        if body.has(op, Trait::CallableOpInterface) {
            match body.callable_region(op) {
                Some(r) => parent = Some(self.node_for(r, parent)),
                None => return,
            }
        }
        for r in &body[op].regions {
            for b in &body[*r].blocks {
                for o in &body[*b].ops {
                    self.compute(body, *o, parent, resolve);
                }
            }
        }
    }

    /// `resolveCallable`: the callee's node, else the unknown callee.
    fn resolve(&self, body: &Body<'_>, call: OpId) -> usize {
        body.resolve_call(call).and_then(|c| body.callable_region(c)).and_then(|r| self.by_region.get(&r).copied()).unwrap_or(UNKNOWN)
    }

    fn external(&self, n: usize) -> bool {
        self.nodes[n].region.is_none()
    }
}

/// LLVM's `scc_iterator` (Tarjan, iterative) from the external caller.
struct SccIter {
    visit_num: u32,
    numbers: BTreeMap<usize, u32>,
    scc_stack: Vec<usize>,
    /// (node, next child, minimum visit number reached).
    visit_stack: Vec<(usize, usize, u32)>,
    current: Vec<usize>,
}

impl SccIter {
    fn new(cg: &CallGraph) -> Self {
        let mut it = Self { visit_num: 0, numbers: BTreeMap::new(), scc_stack: Vec::new(), visit_stack: Vec::new(), current: Vec::new() };
        it.visit_one(EXTERNAL);
        it.next_scc(cg);
        it
    }

    fn visit_one(&mut self, n: usize) {
        self.visit_num += 1;
        self.numbers.insert(n, self.visit_num);
        self.scc_stack.push(n);
        self.visit_stack.push((n, 0, self.visit_num));
    }

    fn visit_children(&mut self, cg: &CallGraph) {
        loop {
            let top = self.visit_stack.len() - 1;
            let (n, next, _) = self.visit_stack[top];
            let Some(&(child, _)) = cg.nodes[n].edges.get(next) else { return };
            self.visit_stack[top].1 += 1;
            match self.numbers.get(&child) {
                None => self.visit_one(child),
                Some(&num) => {
                    if self.visit_stack[top].2 > num {
                        self.visit_stack[top].2 = num;
                    }
                }
            }
        }
    }

    /// `GetNextSCC`.
    fn next_scc(&mut self, cg: &CallGraph) {
        self.current.clear();
        while !self.visit_stack.is_empty() {
            self.visit_children(cg);
            let (n, _, min) = self.visit_stack.pop().expect("a node");
            if let Some(top) = self.visit_stack.last_mut()
                && top.2 > min
            {
                top.2 = min;
            }
            if Some(&min) != self.numbers.get(&n) {
                continue;
            }
            loop {
                let m = self.scc_stack.pop().expect("an SCC node");
                self.numbers.insert(m, u32::MAX);
                self.current.push(m);
                if m == n {
                    return;
                }
            }
        }
    }

    fn at_end(&self) -> bool {
        self.current.is_empty()
    }

    /// `ReplaceNode(node, nullptr)`: the node counts as unvisited again.
    fn forget(&mut self, n: usize) {
        self.numbers.remove(&n);
    }
}

/// `CGUseList`: how often each discardable callable is referenced.
#[derive(Default)]
struct UseList {
    discardable: BTreeMap<usize, i64>,
    /// Per node: the nodes its op references itself, and those its body references.
    uses: BTreeMap<usize, (BTreeSet<usize>, BTreeMap<usize, i64>)>,
}

/// `walkReferencedSymbolNodes`: each symbol use in `op` resolving to a call graph node.
fn referenced_nodes(body: &Body<'_>, cg: &CallGraph, op: OpId, resolved: &mut BTreeMap<Vec<String>, Option<usize>>, f: &mut dyn FnMut(usize, OpId)) {
    let Some(uses) = body.symbol_uses(op) else { return };
    let table = body.parent_op(op);
    for u in uses {
        let key: Vec<String> = u.path.iter().map(|s| String::from(&**s)).collect();
        let node = *resolved.entry(key).or_insert_with(|| {
            let sym = table.and_then(|t| body.lookup_nearest(t, &u.path))?;
            body.callable_region(sym).and_then(|r| cg.by_region.get(&r).copied())
        });
        if let Some(n) = node {
            f(n, u.user);
        }
    }
}

impl UseList {
    fn new(body: &Body<'_>, cg: &CallGraph, root: OpId) -> Self {
        let mut ul = Self::default();
        let mut live = BTreeMap::new();
        let mut tables = Vec::new();
        Self::symbol_tables(body, root, body[root].parent.is_none(), &mut tables);
        for (table, visible) in tables {
            for op in body.children(table) {
                if let Some(n) = body.callable_region(op).and_then(|r| cg.by_region.get(&r).copied()) {
                    let symbol = body.has(op, Trait::SymbolOpInterface);
                    let private = body.visibility(op) == crate::Visibility::Private;
                    if symbol && (visible || private) && body.visibility(op) != crate::Visibility::Public {
                        ul.discardable.entry(n).or_insert(0);
                    }
                    continue;
                }
                referenced_nodes(body, cg, op, &mut live, &mut |_, _| {});
            }
        }
        for n in live.into_values().flatten() {
            ul.discardable.remove(&n);
        }
        for n in 2..cg.nodes.len() {
            ul.recompute(body, cg, n);
        }
        ul
    }

    /// `SymbolTable::walkSymbolTables`: nested tables first, with whether all their symbols'
    /// uses are visible.
    fn symbol_tables(body: &Body<'_>, op: OpId, mut visible: bool, out: &mut Vec<(OpId, bool)>) {
        let table = body.is_symbol_table(op);
        if table {
            visible |= !body.has(op, Trait::SymbolOpInterface) || body.visibility(op) == crate::Visibility::Private;
        } else {
            visible = true;
        }
        for c in body.children(op) {
            Self::symbol_tables(body, c, visible, out);
        }
        if table {
            out.push((op, visible));
        }
    }

    fn decrement(&mut self, n: usize) {
        if let Some((top, inner)) = self.uses.get(&n) {
            for t in top.clone() {
                *self.discardable.entry(t).or_default() -= 1;
            }
            for (t, c) in inner.clone() {
                *self.discardable.entry(t).or_default() -= c;
            }
        }
    }

    /// `recomputeUses`.
    fn recompute(&mut self, body: &Body<'_>, cg: &CallGraph, n: usize) {
        let Some(region) = cg.nodes[n].region else { return };
        let op = body[region].parent;
        self.decrement(n);
        let (mut top, mut inner) = (BTreeSet::new(), BTreeMap::new());
        let discardable = &mut self.discardable;
        referenced_nodes(body, cg, op, &mut BTreeMap::new(), &mut |r, user| {
            let Some(c) = discardable.get_mut(&r) else { return };
            if user != op {
                *inner.entry(r).or_insert(0) += 1;
            } else if !top.insert(r) {
                return;
            }
            *c += 1;
        });
        self.uses.insert(n, (top, inner));
    }

    /// `dropCallUses`.
    fn drop_call(&mut self, body: &Body<'_>, cg: &CallGraph, user: usize, call: OpId) {
        let (uses, discardable) = (&mut self.uses, &mut self.discardable);
        let inner = &mut uses.entry(user).or_default().1;
        referenced_nodes(body, cg, call, &mut BTreeMap::new(), &mut |r, _| {
            if let Some(c) = inner.get_mut(&r) {
                *c -= 1;
                *discardable.entry(r).or_default() -= 1;
            }
        });
    }

    /// `eraseNode`.
    fn erase(&mut self, cg: &CallGraph, n: usize) {
        for (c, k) in &cg.nodes[n].edges {
            if *k == Edge::Child {
                self.erase(cg, *c);
            }
        }
        self.decrement(n);
        self.uses.remove(&n);
        self.discardable.remove(&n);
    }

    /// `mergeUsesAfterInlining`.
    fn merge(&mut self, from: usize, into: usize) {
        let inner = self.uses.entry(from).or_default().1.clone();
        for (t, c) in inner {
            *self.uses.entry(into).or_default().1.entry(t).or_insert(0) += c;
            *self.discardable.entry(t).or_default() += c;
        }
    }

    /// `isDead` (`hasOneUseAndDiscardable` with `uses = 1`).
    fn has_uses(&self, body: &Body<'_>, cg: &CallGraph, n: usize, uses: i64) -> bool {
        let op = body[cg.nodes[n].region.expect("internal node")].parent;
        if !body.has(op, Trait::SymbolOpInterface) {
            let count = body[op].results.iter().map(|r| body[*r].uses.len()).sum::<usize>();
            return body.is_memory_effect_free(op) && count as i64 == uses;
        }
        self.discardable.get(&n) == Some(&uses)
    }
}

/// `ResolvedCall`.
#[derive(Clone, Copy)]
struct Call {
    call: OpId,
    source: usize,
    target: usize,
}

/// The inliner's options and pipelines.
struct Inliner {
    max_iterations: u64,
    threshold: u64,
}

impl Inliner {
    /// `collectCallOps`: the calls in `blocks` (a stack: last block first) to internal nodes.
    fn collect_calls(body: &Body<'_>, cg: &CallGraph, blocks: &[BlockId], source: usize, nested: bool, calls: &mut Vec<Call>) {
        let mut work: Vec<(BlockId, usize)> = blocks.iter().map(|b| (*b, source)).collect();
        while let Some((b, source)) = work.pop() {
            for &op in &body[b].ops {
                if body.is_call(op) {
                    if let Some(Attribute::SymbolRef(p)) = body[op].get("callee")
                        && p.len() != 1
                    {
                        continue;
                    }
                    let target = cg.resolve(body, op);
                    if !cg.external(target) {
                        calls.push(Call { call: op, source, target });
                    }
                    continue;
                }
                for r in &body[op].regions {
                    let node = cg.by_region.get(r).copied();
                    if nested || node.is_none() {
                        let n = node.unwrap_or(source);
                        work.extend(body[*r].blocks.iter().map(|b| (*b, n)));
                    }
                }
            }
        }
    }

    /// `shouldInline`.
    fn should_inline(&self, body: &Body<'_>, cg: &CallGraph, c: Call) -> bool {
        if body.has(c.call, Trait::IsTerminator) {
            return false;
        }
        if cg.nodes[c.target].edges.iter().any(|(t, _)| *t == c.target || *t == c.source) {
            return false;
        }
        let region = cg.nodes[c.target].region.expect("internal");
        let mut at = body[c.call].parent.and_then(|b| body[b].parent);
        while let Some(r) = at {
            if r == region {
                return false;
            }
            at = body[body[r].parent].parent.and_then(|b| body[b].parent);
        }
        let callee = body[region].parent;
        let caller = body.parent_op(c.call).expect("a placed call");
        if body[region].blocks.len() > 1 && body[callee].name != body[caller].name && body.might_have(caller, Trait::SingleBlock) {
            return false;
        }
        self.profitable(body, cg, c)
    }

    /// `isProfitableToInline`: the callee / caller op count ratio, in percent, within the
    /// threshold.
    fn profitable(&self, body: &Body<'_>, cg: &CallGraph, c: Call) -> bool {
        if self.threshold == 0 {
            return false;
        }
        if self.threshold == u64::from(u32::MAX) {
            return true;
        }
        let count = |n: usize| {
            let r = cg.nodes[n].region.expect("internal");
            body[r].blocks.iter().flat_map(|b| &body[*b].ops).map(|o| body.ops_in(*o).len() as u64).sum::<u64>()
        };
        let caller = count(c.source);
        caller == 0 || count(c.target) * 100 / caller <= self.threshold
    }

    /// `inlineCallsInSCC`: whether anything was inlined.
    fn inline_calls(&self, body: &mut Body<'_>, cg: &CallGraph, uses: &mut UseList, scc: &mut Vec<usize>, iter: &mut SccIter, dead: &mut Vec<usize>) -> bool {
        let mut calls = Vec::new();
        let mut dead_here: Vec<usize> = Vec::new();
        for &n in scc.iter() {
            let Some(region) = cg.nodes[n].region else { continue };
            if uses.has_uses(body, cg, n, 0) {
                if !dead_here.contains(&n) {
                    dead_here.push(n);
                }
            } else {
                let blocks = body[region].blocks.clone();
                Self::collect_calls(body, cg, &blocks, n, false, &mut calls);
            }
        }
        let mut history: Vec<(usize, Option<usize>)> = Vec::new();
        let mut call_history: Vec<Option<usize>> = vec![None; calls.len()];
        let mut any = false;
        let mut i = 0;
        while i < calls.len() {
            let c = calls[i];
            let hid = call_history[i];
            i += 1;
            if dead_here.contains(&c.source) {
                continue;
            }
            let mut h = hid;
            let mut in_history = false;
            while let Some(k) = h {
                if history[k].0 == c.target {
                    in_history = true;
                    break;
                }
                h = history[k].1;
            }
            if in_history || !self.should_inline(body, cg, c) {
                continue;
            }
            let in_place = uses.has_uses(body, cg, c.target, 1);
            if !inline_call(body, cg, c, !in_place, &mut calls) {
                continue;
            }
            any = true;
            let new_id = history.len();
            history.push((c.target, hid));
            call_history.resize(calls.len(), Some(new_id));
            uses.drop_call(body, cg, c.source, c.call);
            uses.merge(c.target, c.source);
            body.erase(c.call);
            if in_place {
                uses.erase(cg, c.target);
                if !dead_here.contains(&c.target) {
                    dead_here.push(c.target);
                }
            }
        }
        for n in dead_here {
            if let Some(p) = scc.iter().position(|x| *x == n) {
                scc.remove(p);
                iter.forget(n);
            }
            if !dead.contains(&n) {
                dead.push(n);
            }
        }
        any
    }
}

/// `stackLocations`: `callee` inlined at `caller`, as `callsite(callee at caller)`, a callee
/// that is a call site itself stacked onto the caller.
fn stack_location(callee: &str, caller: &str) -> String {
    let mut stack = Vec::new();
    let mut last = String::from(callee);
    while let Some((c, rest)) = split_callsite(&last) {
        stack.push(c);
        last = rest;
    }
    let mut loc = format!("callsite({last} at {caller})");
    for c in stack.into_iter().rev() {
        loc = format!("callsite({c} at {loc})");
    }
    loc
}

/// `callsite(callee at caller)` taken apart.
fn split_callsite(loc: &str) -> Option<(String, String)> {
    let inner = loc.strip_prefix("callsite(")?.strip_suffix(')')?;
    let (mut depth, mut quote) = (0i32, false);
    let bytes = inner.as_bytes();
    for i in 0..bytes.len() {
        match bytes[i] {
            b'"' => quote = !quote,
            b'(' | b'<' | b'[' if !quote => depth += 1,
            b')' | b'>' | b']' if !quote => depth -= 1,
            b' ' if !quote && depth == 0 && inner[i..].starts_with(" at ") => return Some((String::from(&inner[..i]), String::from(&inner[i + 4..]))),
            _ => {}
        }
    }
    None
}

/// The result types a callable promises (`getResultTypes`).
fn callable_results<'a>(body: &Body<'a>, callable: OpId) -> Option<Vec<Type<'a>>> {
    match body[callable].get("function_type") {
        Some(Attribute::Type(Type::Function(f))) => Some(f.results.clone()),
        _ => match body[callable].results.first().map(|r| &body[*r].ty) {
            Some(Type::Function(f)) => Some(f.results.clone()),
            _ => None,
        },
    }
}

/// `isLegalToInline` over `src`'s ops (recursively where the dialect says).
fn legal_ops(body: &Body<'_>, src: RegionId) -> bool {
    body[src].blocks.iter().flat_map(|b| &body[*b].ops).all(|&op| {
        if body[op].name == "builtin.unrealized_conversion_cast" {
            return true;
        }
        let Some(i) = body.inliner_of(op) else { return false };
        i.legal_op(body, op) && (!i.analyze_recursively(body, op) || body[op].regions.iter().all(|r| legal_ops(body, *r)))
    })
}

/// `inlineCall` + `inlineRegionImpl`: `c`'s callee inlined in place of the call (the call
/// itself left for the caller to erase); the calls of the inlined blocks added to `calls`.
fn inline_call<'a>(body: &mut Body<'a>, cg: &CallGraph, c: Call, clone: bool, calls: &mut Vec<Call>) -> bool {
    let call = c.call;
    let src = cg.nodes[c.target].region.expect("internal");
    let callable = body[src].parent;
    let entry = body[src].blocks[0];
    let Some(result_types) = callable_results(body, callable) else { return false };
    let range = body.call_arg_range(call);
    let operands = body[call].operands[range].to_vec();
    let results = body[call].results.clone();
    if operands.len() != body[entry].args.len() || results.len() != result_types.len() {
        return false;
    }
    let block = body[call].parent.expect("a placed call");
    let call_iface = body.inliner_of(call);
    let loc = body[call].loc.clone();
    let mut casts: Vec<OpId> = Vec::new();
    let cleanup = |body: &mut Body<'a>, casts: &[OpId]| {
        for &c in casts {
            let (r, o) = (body[c].results[0], body[c].operands[0]);
            body.replace_all_uses(r, o);
            body.erase(c);
        }
        false
    };
    let mut map = Mapping::default();
    for (arg, mut v) in body[entry].args.clone().into_iter().zip(operands) {
        let ty = body[arg].ty.clone();
        if body[v].ty != ty {
            let at = InsertPoint { block, before: Some(call) };
            match call_iface.and_then(|i| i.call_conversion(body, v, &ty, at, loc.clone())) {
                Some(cast) => {
                    casts.push(cast);
                    v = body[cast].results[0];
                }
                None => return cleanup(body, &casts),
            }
        }
        map.map(arg, v);
    }
    let after_call = body[block].ops.get(body.position(call) + 1).copied();
    for (r, ty) in results.iter().zip(&result_types) {
        if body[*r].ty == *ty {
            continue;
        }
        let rty = body[*r].ty.clone();
        let at = InsertPoint { block, before: after_call };
        let Some(cast) = call_iface.and_then(|i| i.call_conversion(body, *r, &rty, at, loc.clone())) else { return cleanup(body, &casts) };
        casts.push(cast);
        let cr = body[cast].results[0];
        body.replace_all_uses(*r, cr);
        body.set_operand(cast, 0, *r);
    }
    if !call_iface.is_some_and(|i| i.legal_call(body, call, callable)) {
        return cleanup(body, &casts);
    }
    // `inlineRegionImpl`.
    let region = body[block].parent.expect("a placed block");
    let dest_ok = body.inliner_of(body[region].parent).is_some_and(|i| i.legal_region(body, region));
    if !dest_ok || !legal_ops(body, src) {
        return cleanup(body, &casts);
    }
    let callable_iface = body.inliner_of(callable);
    // The builder's point: before what followed the call (iterator-stable, as in C++).
    let next = body[block].ops.get(body.position(call) + 1).copied();
    let at = InsertPoint { block, before: next };
    if let Some(i) = callable_iface {
        let arg_attrs = match body[callable].get("arg_attrs") {
            Some(Attribute::Array(a)) => a.clone(),
            _ => Vec::new(),
        };
        for (k, arg) in body[entry].args.clone().into_iter().enumerate() {
            let v = map.get(arg);
            let nv = i.handle_value(body, call, v, arg_attrs.get(k), false, at);
            map.map(arg, nv);
        }
    }
    // `splitBlock` at the point: what follows goes to a new block right after.
    let post = body.add_block(region, &[]);
    body[region].blocks.pop();
    let pos = body[region].blocks.iter().position(|b| *b == block).expect("block in region");
    body[region].blocks.insert(pos + 1, post);
    if let Some(nx) = next {
        let from = body.position(nx);
        let n = body[block].ops.len();
        body.splice(block, from..n, post, None);
    }
    // The clone callback: copy or move `src`'s blocks before `post`.
    let new_blocks: Vec<BlockId> = if clone {
        body.clone_region_into(src, region, Some(post), &mut map)
    } else {
        let blocks = body[src].blocks.clone();
        body[src].blocks.clear();
        let at = body[region].blocks.iter().position(|b| *b == post).expect("post block");
        for (k, b) in blocks.iter().enumerate() {
            body[*b].parent = Some(region);
            body[region].blocks.insert(at + k, *b);
        }
        blocks
    };
    if let Some(call_loc) = loc.as_deref().filter(|l| *l != "unknown") {
        let mut seen: BTreeMap<String, String> = BTreeMap::new();
        let mut remap = |l: Option<&str>| -> String {
            let l = String::from(l.unwrap_or("unknown"));
            seen.entry(l.clone()).or_insert_with(|| stack_location(&l, call_loc)).clone()
        };
        for b in &new_blocks {
            for a in body[*b].args.clone() {
                let nl = remap(body[a].loc.as_deref());
                body[a].loc = Some(nl.into());
            }
            let mut ops = Vec::new();
            for o in &body[*b].ops {
                body.walk(*o, &mut |x| ops.push(x));
            }
            for o in ops {
                let nl = remap(body[o].loc.as_deref());
                body[o].loc = Some(nl.into());
                for r in body[o].regions.clone() {
                    for blk in body[r].blocks.clone() {
                        for a in body[blk].args.clone() {
                            let al = remap(body[a].loc.as_deref());
                            body[a].loc = Some(al.into());
                        }
                    }
                }
            }
        }
    }
    if !clone {
        let mut ops = Vec::new();
        for b in &new_blocks {
            for o in &body[*b].ops {
                body.walk(*o, &mut |x| ops.push(x));
            }
        }
        for o in ops {
            for k in 0..body[o].operands.len() {
                let v = body[o].operands[k];
                if map.values.contains_key(&v) {
                    body.set_operand(o, k, map.get(v));
                }
            }
        }
    }
    if let Some(i) = call_iface {
        i.process_inlined(body, call, &new_blocks);
    }
    // `processInlinedBlocks`: the calls the inlined code makes, from the node it now sits in.
    let mut r = Some(region);
    let mut node = None;
    while let Some(rr) = r {
        if let Some(n) = cg.by_region.get(&rr) {
            node = Some(*n);
            break;
        }
        r = body[body[rr].parent].parent.and_then(|b| body[b].parent);
    }
    if let Some(n) = node {
        Inliner::collect_calls(body, cg, &new_blocks, n, true, calls);
    }
    let first = new_blocks[0];
    let res_attrs = match body[callable].get("res_attrs") {
        Some(Attribute::Array(a)) => a.clone(),
        _ => Vec::new(),
    };
    let handle_results = |body: &mut Body<'a>, vals: &[ValueId], at: InsertPoint| {
        let Some(i) = callable_iface else { return };
        for (k, v) in vals.iter().enumerate() {
            let users: Vec<OpId> = body[*v].uses.iter().map(|u| u.op).collect();
            let nv = i.handle_value(body, call, *v, res_attrs.get(k), true, at);
            if nv != *v {
                for u in body[*v].uses.clone() {
                    if users.contains(&u.op) {
                        body.set_operand(u.op, u.index as usize, nv);
                    }
                }
            }
        }
    };
    if new_blocks.len() == 1 {
        let term = *body[first].ops.last().expect("a terminator");
        let ops = body[term].operands.clone();
        handle_results(body, &ops, InsertPoint { block: first, before: Some(term) });
        if let Some(i) = body.inliner_of(term) {
            i.replace_with_terminator(body, term, &results);
        }
        body.erase(term);
        let n = body[post].ops.len();
        body.splice(post, 0..n, first, None);
        body.remove_block(post);
    } else {
        for (r, ty) in results.iter().zip(&result_types) {
            let a = body.add_arg(post, ty.clone());
            body[a].loc = body[call].loc.clone();
            body.replace_all_uses(*r, a);
        }
        let args = body[post].args.clone();
        let first_post = body[post].ops.first().copied();
        handle_results(body, &args, InsertPoint { block: post, before: first_post });
        for b in &new_blocks {
            let term = *body[*b].ops.last().expect("a terminator");
            if let Some(i) = body.inliner_of(term) {
                i.branch_terminator(body, term, post);
            }
        }
    }
    let n = body[first].ops.len();
    body.splice(first, 0..n, block, None);
    body.remove_block(first);
    true
}

/// `inline`.
#[crate::pass("inline")]
pub struct Inline {
    #[opt("default-pipeline", default = String::from("canonicalize"))]
    default_pipeline: String,
    #[opt("op-pipelines")]
    op_pipelines: Vec<String>,
    #[opt("max-iterations", default = 4)]
    max_iterations: u64,
    #[opt("inlining-threshold", default = 4294967295)]
    threshold: u64,
}

impl crate::Run for Inline {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        if !body.is_symbol_table(op) {
            return Err(Error(format!("'{}' op  was scheduled to run under the inliner, but does not define a symbol table", body[op].name)));
        }
        let reg = crate::Passes::upstream();
        let op_pipelines = self.op_pipelines.iter().map(|p| PassManager::parse(&reg, p)).collect::<Result<Vec<_>, _>>()?;
        let inliner = Inliner { max_iterations: self.max_iterations, threshold: self.threshold };
        let default_text = self.default_pipeline.clone();
        let cg = CallGraph::new(body, op);
        let mut uses = UseList::new(body, &cg, op);
        let mut iter = SccIter::new(&cg);
        let mut dead = Vec::new();
        while !iter.at_end() {
            let mut scc = iter.current.clone();
            iter.next_scc(&cg);
            for k in 0..inliner.max_iterations.max(1) {
                let _ = k;
                // `optimizeSCC`: the pipeline for each callable, by its op name.
                let mut visited = Vec::new();
                for &n in &scc {
                    let Some(region) = cg.nodes[n].region else { continue };
                    if cg.nodes[n].edges.iter().any(|(_, e)| *e == Edge::Child) {
                        continue;
                    }
                    let callable = body[region].parent;
                    if body.has(callable, Trait::IsIsolatedFromAbove) {
                        visited.push((n, callable));
                    }
                }
                for &(_, callable) in &visited {
                    let name = String::from(&*body[callable].name);
                    if let Some(pm) = op_pipelines.iter().find(|p| p.anchor.as_deref() == Some(&*name)) {
                        pm.run(body, callable)?;
                    } else if !default_text.is_empty() {
                        let pm = PassManager::parse(&reg, &format!("{name}({default_text})"))?;
                        pm.run(body, callable)?;
                    }
                }
                for (n, _) in visited {
                    uses.recompute(body, &cg, n);
                }
                if !inliner.inline_calls(body, &cg, &mut uses, &mut scc, &mut iter, &mut dead) {
                    break;
                }
                if k + 1 >= inliner.max_iterations {
                    break;
                }
            }
        }
        for n in dead {
            let callable = body[cg.nodes[n].region.expect("internal")].parent;
            if body[callable].parent.is_some() {
                body.erase(callable);
            }
        }
        Ok(())
    }
}
