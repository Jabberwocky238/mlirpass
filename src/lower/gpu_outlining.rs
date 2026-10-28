//! `gpu.launch` out into kernels, as `KernelOutlining.cpp`: `gpu-launch-sink-index-computations`
//! (cheap index computations cloned into the launch) and `gpu-kernel-outlining` (each launch's
//! body a `gpu.func` in a `gpu.module`, the launch a `gpu.launch_func`).

use alloc::format;
use alloc::string::String;
use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{Attribute, Error, FunctionType, Type};

use crate::{Body, Mapping, OpData, OpId, RegionId, Trait, ValueId};

/// `gpu.launch`'s operand groups: their first segment (`operandSegmentSizes`) and how many.
const ASYNC: (usize, usize) = (0, 1);
const GRID: (usize, usize) = (1, 3);
const BLOCK: (usize, usize) = (4, 3);
const CLUSTER: (usize, usize) = (7, 3);
const SHMEM: (usize, usize) = (10, 1);

impl<'a> Body<'a> {
    /// Whether region `r` is `of` or nested in it.
    fn region_within(&self, mut r: RegionId, of: RegionId) -> bool {
        loop {
            if r == of {
                return true;
            }
            match self[self[r].parent].parent.and_then(|b| self[b].parent) {
                Some(up) => r = up,
                None => return false,
            }
        }
    }

    /// `getUsedValuesDefinedAbove`: operands of the ops in `region` (post-order) defined
    /// outside it, each once, in first-use order.
    pub fn used_values_defined_above(&self, region: RegionId) -> Vec<ValueId> {
        let mut out = Vec::new();
        for b in &self[region].blocks {
            for o in &self[*b].ops {
                self.walk_post(*o, &mut |op| {
                    for v in &self[op].operands {
                        let inside = self.value_block(*v).and_then(|b| self[b].parent).is_some_and(|r| self.region_within(r, region));
                        if !inside && !out.contains(v) {
                            out.push(*v);
                        }
                    }
                });
            }
        }
        out
    }

    /// An operand group of a launch.
    fn launch_group(&self, launch: OpId, (first, n): (usize, usize)) -> Vec<ValueId> {
        let sizes = self.segments(launch, "operandSegmentSizes").unwrap_or_default();
        let start: usize = sizes[..first].iter().sum();
        let len: usize = sizes[first..first + n].iter().sum();
        self[launch].operands[start..start + len].to_vec()
    }

    /// `isLikelyAnIndexComputation`.
    fn index_computation(&self, op: OpId) -> bool {
        self.constant_value(op).is_some() || matches!(&*self[op].name, "memref.dim" | "arith.select" | "arith.cmpi")
    }

    /// `extractBeneficiaryOps`: whether `op` (and what it needs) can be sunk.
    fn beneficiary(&self, op: OpId, deps: &[ValueId], sunk: &mut Vec<OpId>, available: &mut Vec<ValueId>) -> bool {
        if sunk.contains(&op) {
            return true;
        }
        if !self.index_computation(op) {
            return false;
        }
        for v in self[op].operands.clone() {
            if available.contains(&v) {
                continue;
            }
            let ok = self.def_op(v).is_some_and(|d| self.beneficiary(d, deps, sunk, available));
            if !ok && !deps.contains(&v) {
                return false;
            }
        }
        sunk.push(op);
        available.extend(self[op].results.iter().copied());
        true
    }

    /// `sinkOperationsIntoLaunchOp` with `isLikelyAnIndexComputation`.
    fn sink_into_launch(&mut self, launch: OpId) {
        let region = self[launch].regions[0];
        let candidates = self.used_values_defined_above(region);
        let (mut sunk, mut available) = (Vec::new(), Vec::new());
        for v in &candidates {
            if let Some(d) = self.def_op(*v) {
                self.beneficiary(d, &candidates, &mut sunk, &mut available);
            }
        }
        let entry = self[region].blocks[0];
        let first = self[entry].ops.first().copied();
        let mut map = Mapping::default();
        for op in sunk {
            let c = self.clone_op(op, &mut map);
            match first {
                Some(f) => self.insert_before(c, f),
                None => self.insert(c, entry, None),
            }
            for (from, to) in self[op].results.clone().into_iter().zip(self[c].results.clone()) {
                for u in self[from].uses.clone() {
                    if self[u.op].parent.and_then(|b| self[b].parent).is_some_and(|r| self.region_within(r, region)) {
                        self.set_operand(u.op, u.index as usize, to);
                    }
                }
            }
        }
    }

    /// `maybeConstantDimsAttr`: the three sizes as a `DenseI32ArrayAttr`, when constant.
    fn constant_dims(&self, vals: &[ValueId]) -> Option<Attribute<'a>> {
        let ints = vals.iter().map(|v| self.int_constant(*v).filter(|i| (0..=i128::from(u32::MAX)).contains(i)).map(|i| i as u32 as i32)).collect::<Option<Vec<_>>>()?;
        (ints.len() == 3).then(|| Attribute::dense_i32(&ints))
    }

    /// `injectGpuIndexOperations`: the ids and dims the launch's leading arguments stood for.
    fn index_ops(&mut self, block: crate::BlockId, cluster: bool) -> Vec<ValueId> {
        let mut kinds = vec!["gpu.block_id", "gpu.thread_id", "gpu.grid_dim", "gpu.block_dim"];
        if cluster {
            kinds.extend(["gpu.cluster_id", "gpu.cluster_dim"]);
        }
        let mut out = Vec::new();
        for (i, k) in kinds.iter().flat_map(|k| ["x", "y", "z"].map(|d| (*k, d))).enumerate() {
            let o = self.create(OpData::build(k.0).with("dimension", Attribute::dialect("gpu", &format!("<dim {}>", k.1))), &[Type::Index]);
            self.insert(o, block, Some(i));
            out.push(self[o].results[0]);
        }
        out
    }

    /// `outlineKernelFuncImpl`: the launch body as a detached kernel `gpu.func` named `name`,
    /// and the values it takes.
    fn outline_kernel(&mut self, launch: OpId, name: &str) -> (OpId, Vec<ValueId>) {
        let region = self[launch].regions[0];
        let operands = self.used_values_defined_above(region);
        let cluster = !self.launch_group(launch, CLUSTER).is_empty();
        let entry = self[region].blocks[0];
        let args = self[entry].args.clone();
        let fixed = if cluster { 18 } else { 12 };
        let workgroup = self[launch].get("workgroup_attributions").and_then(|a| mlirformat::Const::try_from(a).ok()?.as_int()).map_or(0, |i| i.signed() as usize);
        let attributions = &args[fixed..];
        let inputs = self.types(&operands);
        let mut data = OpData::build("gpu.func").with("function_type", Attribute::Type(Type::Function(FunctionType { inputs: inputs.clone(), results: Vec::new() })));
        if let Some(b) = self.constant_dims(&self.launch_group(launch, BLOCK)) {
            data.set("known_block_size", b);
        }
        if let Some(g) = self.constant_dims(&self.launch_group(launch, GRID)) {
            data.set("known_grid_size", g);
        }
        data.attributes.push(mlirformat::NamedAttr { name: "gpu.kernel".into(), value: None });
        data.set("sym_name", Attribute::str(name));
        data.set("workgroup_attributions", Attribute::integer(workgroup as i128, Type::int(64)));
        data.loc = self[launch].loc.clone();
        let func = self.create(data, &[]);
        let body = self.add_region(func);
        let block_args: Vec<_> = inputs.into_iter().chain(self.types(attributions)).map(|t| (t, None)).collect();
        let fentry = self.add_block(body, &block_args);
        let mut map = Mapping::default();
        for (a, v) in args.iter().zip(self.index_ops(fentry, cluster)) {
            map.map(*a, v);
        }
        let fargs = self[fentry].args.clone();
        for (a, f) in attributions.iter().zip(&fargs[operands.len()..]) {
            map.map(*a, *f);
        }
        for (v, f) in operands.iter().zip(&fargs) {
            map.map(*v, *f);
        }
        let cloned = self.clone_region_into(region, body, None, &mut map);
        for b in &cloned {
            let Some(&t) = self[*b].ops.last() else { continue };
            if self[t].name == "gpu.terminator" {
                let mut ret = OpData::build("gpu.return");
                ret.loc = self[t].loc.clone();
                let r = self.create(ret, &[]);
                self.insert_before(r, t);
                self.erase(t);
            }
        }
        let centry = cloned[0];
        let n = self[centry].ops.len();
        self.splice(centry, 0..n, fentry, None);
        self[body].blocks.retain(|b| *b != centry);
        (func, operands)
    }

    /// A name for `name` unused in `table` (`SymbolTable::insert`'s `name_<n>`).
    fn unique_symbol(&self, table: OpId, name: &str, taken: Option<OpId>) -> String {
        if self.lookup(table, name).is_none_or(|o| Some(o) == taken) {
            return String::from(name);
        }
        (0..).map(|i| format!("{name}_{i}")).find(|n| self.lookup(table, n).is_none()).expect("a free name")
    }

    /// `convertToLaunchFuncOp`.
    fn launch_func(&mut self, launch: OpId, module: &str, func: &str, operands: &[ValueId]) {
        let g = |i| self.launch_group(launch, i);
        let groups = [g(ASYNC), g(GRID), g(BLOCK), g(CLUSTER), g(SHMEM)];
        let mut ops = Vec::new();
        let mut sizes = vec![groups[0].len()];
        ops.extend(groups[0].iter().copied());
        for grp in &groups[1..4] {
            for v in grp.iter().copied().map(Some).chain(core::iter::repeat(None)).take(3) {
                sizes.push(usize::from(v.is_some()));
                ops.extend(v);
            }
        }
        sizes.push(groups[4].len());
        ops.extend(groups[4].iter().copied());
        sizes.extend([operands.len(), 0]);
        ops.extend(operands.iter().copied());
        let seg: Vec<i32> = sizes.iter().map(|n| *n as i32).collect();
        let mut data = OpData::build("gpu.launch_func").operands(&ops).with("kernel", Attribute::SymbolRef(vec![String::from(module).into(), String::from(func).into()])).with("operandSegmentSizes", Attribute::dense_i32(&seg));
        data.loc = self[launch].loc.clone();
        let types = self.types(&self[launch].results);
        let lf = self.create(data, &types);
        self.insert_before(lf, launch);
        for (a, b) in self[launch].results.clone().into_iter().zip(self[lf].results.clone()) {
            self.replace_all_uses(a, b);
        }
        self.erase(launch);
    }
}

/// `gpu-launch-sink-index-computations`.
#[crate::pass("gpu-launch-sink-index-computations")]
pub fn gpu_launch_sink_index_computations<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let mut launches = Vec::new();
    body.walk_post(op, &mut |o| {
        if body[o].name == "gpu.launch" {
            launches.push(o);
        }
    });
    for l in launches {
        body.sink_into_launch(l);
    }
    Ok(())
}

/// `gpu-kernel-outlining`.
#[crate::pass("gpu-kernel-outlining", on = "builtin.module")]
pub struct GpuKernelOutlining {
    #[opt("data-layout-str")]
    data_layout: String,
}

impl GpuKernelOutlining {
    /// A `#dlti.dl_spec` as MLIR prints it: each `#dlti.dl_entry<key, value>` as
    /// `key = value`, the value printed back.
    fn canonical_dl_spec(text: &str) -> String {
        let Some(inner) = text.trim().strip_prefix("#dlti.dl_spec<").and_then(|t| t.strip_suffix('>')) else { return String::from(text) };
        let mut entries = Vec::new();
        let mut rest = inner.trim();
        while let Some(e) = rest.strip_prefix("#dlti.dl_entry<") {
            let (mut depth, mut end) = (1, e.len());
            for (i, c) in e.char_indices() {
                depth += match c {
                    '<' | '(' | '[' => 1,
                    '>' | ')' | ']' => -1,
                    _ => 0,
                };
                if depth == 0 {
                    end = i;
                    break;
                }
            }
            let Some((k, v)) = e[..end].split_once(',') else { return String::from(text) };
            let value = mlirformat::Parser::read(v.trim(), |p| p.attr()).map(|a| format!("{a}")).unwrap_or_else(|_| String::from(v.trim()));
            entries.push(format!("{} = {value}", k.trim()));
            rest = e[(end + 1).min(e.len())..].trim_start_matches([',', ' ']);
        }
        if !rest.is_empty() || entries.is_empty() {
            return String::from(text);
        }
        format!("#dlti.dl_spec<{}>", entries.join(", "))
    }
}

impl crate::Run for GpuKernelOutlining {
    fn run<'a>(&self, body: &mut Body<'a>, module: OpId) -> Result<(), Error> {
        let layout = if self.data_layout.is_empty() {
            None
        } else {
            let text = Self::canonical_dl_spec(&self.data_layout);
            Some(mlirformat::Parser::read(&text, |p| p.attr()).map_err(|e| Error(format!("{e}")))?.owned())
        };
        let top = body.top_block(module);
        let mut modified = false;
        for f in body[top].ops.clone() {
            if !body.has(f, Trait::SymbolOpInterface) {
                continue;
            }
            let at = body[top].ops.get(body.position(f) + 1).copied();
            let mut launches = Vec::new();
            body.walk_post(f, &mut |o| {
                if body[o].name == "gpu.launch" {
                    launches.push(o);
                }
            });
            for l in launches {
                let sym = |a: Option<&Attribute<'_>>| match a {
                    Some(Attribute::SymbolRef(p)) => p.last().map(|s| String::from(&**s)),
                    _ => None,
                };
                let name = sym(body[l].get("function")).unwrap_or_else(|| {
                    let mut p = body.parent_op(l);
                    while let Some(o) = p.filter(|o| !body.has(*o, Trait::SymbolOpInterface)) {
                        p = body.parent_op(o);
                    }
                    format!("{}_kernel", p.and_then(|o| body.sym_name(o)).unwrap_or(""))
                });
                let (func, operands) = body.outline_kernel(l, &name);
                // `createKernelModule`: an existing module of the launch's `module`, else a new
                // one named after the kernel; with the symbols the kernel references.
                let wanted = sym(body[l].get("module"));
                let existing = wanted.as_deref().and_then(|m| body.lookup(module, m)).filter(|o| body[*o].name == "gpu.module");
                let kmod = existing.unwrap_or_else(|| {
                    let mut d = OpData::build("gpu.module").with("sym_name", Attribute::str(wanted.as_deref().unwrap_or(&name)));
                    d.loc = body[func].loc.clone();
                    let m = body.create(d, &[]);
                    let r = body.add_region(m);
                    body.add_block(r, &[]);
                    m
                });
                if let Some(dl) = &layout {
                    body[kmod].set("dlti.dl_spec", dl.clone());
                }
                let fname = body.unique_symbol(kmod, &name, None);
                body[func].set("sym_name", Attribute::str(&fname));
                let kblock = body.top_block(kmod);
                body.insert(func, kblock, None);
                let mut work = vec![func];
                while let Some(o) = work.pop() {
                    for u in body.symbol_uses(o).unwrap_or_default() {
                        let Some(leaf) = u.path.last().map(|s| String::from(&**s)) else { continue };
                        if body.lookup(kmod, &leaf).is_some() {
                            continue;
                        }
                        let Some(def) = body.lookup(module, &leaf) else { continue };
                        let c = body.clone_op(def, &mut Mapping::default());
                        body.insert(c, kblock, None);
                        work.push(c);
                    }
                }
                if existing.is_none() {
                    let mname = body.unique_symbol(module, &String::from(body.sym_name(kmod).unwrap_or_default()), Some(kmod));
                    body[kmod].set("sym_name", Attribute::str(&mname));
                    match at {
                        Some(a) => body.insert_before(kmod, a),
                        None => body.insert(kmod, top, None),
                    }
                }
                let mname = String::from(body.sym_name(kmod).unwrap_or_default());
                body.launch_func(l, &mname, &fname, &operands);
                modified = true;
            }
        }
        if modified {
            body[module].attributes.retain(|a| a.name != "gpu.container_module");
            body[module].attributes.push(mlirformat::NamedAttr { name: "gpu.container_module".into(), value: None });
        }
        Ok(())
    }
}
