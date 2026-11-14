use alloc::format;
use alloc::boxed::Box;
use alloc::collections::BTreeMap;
use alloc::string::String;
use alloc::vec::Vec;
use core::fmt;
use mlirformat::{Error, Item};
use crate::{Body, OpId, OpData, Shift, Trait, ValueId, Ctx};

pub trait PassDecl {
    const NAME: &'static str;
    const ANCHOR: Option<&'static str>;
}

pub trait Run {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error>;

    fn run_in<'a>(&self, body: &mut Body<'a>, op: OpId, _exec: &crate::Exec<'_>) -> Result<(), Error> {
        self.run(body, op)
    }

    fn options(&self) -> String {
        String::new()
    }
}

impl<T: PassDecl + Run + Send + Sync> Pass for T {
    fn name(&self) -> &str {
        T::NAME
    }

    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        Run::run(self, body, op)
    }

    fn run_in<'a>(&self, body: &mut Body<'a>, op: OpId, exec: &crate::Exec<'_>) -> Result<(), Error> {
        Run::run_in(self, body, op, exec)
    }

    fn options(&self) -> String {
        Run::options(self)
    }
}

pub trait OptionValue: Sized {
    fn read(o: &Options<'_>, key: &str, default: Self) -> Result<Self, Error>;
}

impl OptionValue for bool {
    fn read(o: &Options<'_>, key: &str, default: Self) -> Result<Self, Error> {
        o.flag(key, default)
    }
}

impl OptionValue for Option<bool> {
    fn read(o: &Options<'_>, key: &str, default: Self) -> Result<Self, Error> {
        match o.get(key) {
            Some(_) => o.flag(key, false).map(Some),
            None => Ok(default),
        }
    }
}

impl OptionValue for Vec<String> {
    fn read(o: &Options<'_>, key: &str, default: Self) -> Result<Self, Error> {
        Ok(o.get(key).map_or(default, |_| o.list(key).into_iter().map(String::from).collect()))
    }
}

macro_rules! option_from_str {
    ($($t:ty),*) => {$(
        impl OptionValue for $t {
            fn read(o: &Options<'_>, key: &str, default: Self) -> Result<Self, Error> {
                o.value(key, default)
            }
        }
    )*};
}

option_from_str!(String, u32, u64, i64, usize);

pub trait Pass: Send + Sync {
    fn name(&self) -> &str;

    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error>;

    fn run_in<'a>(&self, body: &mut Body<'a>, op: OpId, _exec: &crate::Exec<'_>) -> Result<(), Error> {
        self.run(body, op)
    }

    fn options(&self) -> String {
        String::new()
    }
}

#[derive(Debug, Clone, Default, PartialEq, Eq)]
pub struct Options<'s> {
    pairs: Vec<(&'s str, &'s str)>,
}

impl<'s> TryFrom<&'s str> for Options<'s> {
    type Error = Error;

    fn try_from(s: &'s str) -> Result<Self, Error> {
        let mut pairs = Vec::new();
        let mut rest = s.trim();
        while !rest.is_empty() {
            let key_end = rest.find(|c: char| c == '=' || c.is_whitespace()).unwrap_or(rest.len());
            let key = &rest[..key_end];
            rest = &rest[key_end..];
            let value = if let Some(after) = rest.strip_prefix('=') {
                let end = Self::value_end(after).ok_or_else(|| Error(format!("unbalanced value for option `{key}`")))?;
                let raw = &after[..end];
                rest = &after[end..];
                Self::unwrap(raw)
            } else {
                "true"
            };
            pairs.push((key, value));
            rest = rest.trim_start();
        }
        Ok(Self { pairs })
    }
}

impl<'s> Options<'s> {
    fn value_end(s: &str) -> Option<usize> {
        let (mut depth, mut quote) = (0i32, false);
        for (i, c) in s.char_indices() {
            match c {
                '"' => quote = !quote,
                _ if quote => {}
                '{' | '(' | '[' => depth += 1,
                '}' | ')' | ']' => depth -= 1,
                c if c.is_whitespace() && depth == 0 => return Some(i),
                _ => {}
            }
        }
        (depth == 0 && !quote).then_some(s.len())
    }

    fn unwrap(raw: &str) -> &str {
        raw.strip_prefix('"').and_then(|r| r.strip_suffix('"')).or_else(|| raw.strip_prefix('{').and_then(|r| r.strip_suffix('}'))).unwrap_or(raw)
    }

    pub fn only(&self, pass: &str, known: &[&str]) -> Result<&Self, Error> {
        match self.pairs.iter().find(|(k, _)| !known.contains(k)) {
            Some((k, _)) => Err(Error(format!("pass `{pass}`: no option `{k}`"))),
            None => Ok(self),
        }
    }

    pub fn get(&self, key: &str) -> Option<&'s str> {
        self.pairs.iter().rev().find(|(k, _)| *k == key).map(|(_, v)| *v)
    }

    pub fn flag(&self, key: &str, default: bool) -> Result<bool, Error> {
        match self.get(key) {
            None => Ok(default),
            Some("true" | "1") => Ok(true),
            Some("false" | "0") => Ok(false),
            Some(v) => Err(Error(format!("option `{key}`: `{v}` is not a boolean"))),
        }
    }

    pub fn value<T: core::str::FromStr>(&self, key: &str, default: T) -> Result<T, Error> {
        self.get(key).map_or(Ok(default), |v| v.parse().map_err(|_| Error(format!("option `{key}`: bad value `{v}`"))))
    }

    pub fn list(&self, key: &str) -> Vec<&'s str> {
        let Some(v) = self.get(key) else { return Vec::new() };
        let mut out = Vec::new();
        let (mut depth, mut start) = (0i32, 0);
        for (i, c) in v.char_indices() {
            match c {
                '(' | '{' | '[' => depth += 1,
                ')' | '}' | ']' => depth -= 1,
                ',' if depth == 0 => {
                    out.push(v[start..i].trim());
                    start = i + 1;
                }
                _ => {}
            }
        }
        out.push(v[start..].trim());
        out.retain(|s| !s.is_empty());
        out
    }
}

enum Entry {
    Pass(Box<dyn Pass>),
    Adaptor(Vec<PassManager>),
}

pub struct PassManager {
    pub anchor: Option<String>,
    entries: Vec<Entry>,
    pub verify_each: bool,
}

impl PassManager {
    pub fn on(anchor: &str) -> Self {
        Self { anchor: (anchor != "any").then(|| anchor.into()), entries: Vec::new(), verify_each: true }
    }

    pub fn set_verify_each(&mut self, on: bool) {
        self.verify_each = on;
        for e in &mut self.entries {
            if let Entry::Adaptor(mgrs) = e {
                mgrs.iter_mut().for_each(|m| m.set_verify_each(on));
            }
        }
    }

    fn nest(&mut self, pm: PassManager) {
        if let Some(Entry::Adaptor(mgrs)) = self.entries.last_mut() {
            match mgrs.iter_mut().find(|m| m.anchor == pm.anchor) {
                Some(m) => pm.entries.into_iter().for_each(|e| m.push(e)),
                None => mgrs.push(pm),
            }
            return;
        }
        self.entries.push(Entry::Adaptor(alloc::vec![pm]));
    }

    fn push(&mut self, e: Entry) {
        match e {
            Entry::Adaptor(mgrs) => mgrs.into_iter().for_each(|m| self.nest(m)),
            e => self.entries.push(e),
        }
    }

    pub fn add(&mut self, info: &PassInfo, options: &Options<'_>) -> Result<&mut Self, Error> {
        let pass = (info.make)(options)?;
        match (info.anchor, &self.anchor) {
            (Some(on), Some(mine)) if on != mine => {
                let mut pm = PassManager::on(on);
                pm.entries.push(Entry::Pass(pass));
                self.nest(pm);
            }
            _ => self.entries.push(Entry::Pass(pass)),
        }
        Ok(self)
    }

    pub fn add_named(&mut self, reg: &dyn PassRegistry, name: &str, options: &str) -> Result<&mut Self, Error> {
        let info = reg.pass(name).ok_or_else(|| Error(format!("unknown pass `{name}`")))?;
        self.add(info, &Options::try_from(options)?)
    }

    pub fn run(&self, body: &mut Body<'_>, op: OpId) -> Result<(), Error> {
        #[cfg(feature = "std")]
        return self.run_on(body, op, &moremath::ThreadMulti::default());
        #[cfg(not(feature = "std"))]
        self.run_on(body, op, &moremath::ThreadSingle)
    }

    pub fn run_on<X: moremath::Executor + Sync>(&self, body: &mut Body<'_>, op: OpId, exec: &X) -> Result<(), Error> {
        self.run_exec(body, op, &crate::Exec::from(exec))
    }

    fn run_exec(&self, body: &mut Body<'_>, op: OpId, exec: &crate::Exec<'_>) -> Result<(), Error> {
        if let Some(anchor) = &self.anchor
            && body[op].name != **anchor
        {
            return Err(Error(format!("can't run '{anchor}' pass manager on '{}' op", body[op].name)));
        }
        for e in &self.entries {
            match e {
                Entry::Pass(p) => {
                    if body.is_symbol_table(op) {
                        body.index_symbols(op);
                    }
                    p.run_in(body, op, exec)?;
                    if self.verify_each {
                        body.verify_in(op, exec)?;
                    }
                }
                Entry::Adaptor(mgrs) => {
                    let work: Vec<(OpId, &PassManager)> = body[op]
                        .regions
                        .iter()
                        .flat_map(|r| &body[*r].blocks)
                        .flat_map(|b| body.ops(*b))
                        .filter_map(|c| {
                            let name = &body[c].name;
                            mgrs.iter().find(|m| m.anchor.as_deref() == Some(&**name)).or_else(|| mgrs.iter().find(|m| m.anchor.is_none())).map(|m| (c, m))
                        })
                        .collect();
                    if moremath::Executor::threads(exec) < 2 || work.len() < 2 || !work.iter().all(|(c, ..)| body.isolated(*c)) {
                        for (c, m) in work {
                            m.run_exec(body, c, exec)?;
                        }
                        continue;
                    }
                    let first = if work.iter().all(|(c, ..)| body.lendable(*c)) {
                        0
                    } else {
                        let Some(first) = Self::calibrate(body, &work, exec)? else { continue };
                        first
                    };
                    let work = &work[first..];
                    let lent: Vec<_> = work.iter().map(|(c, ..)| body.lend(*c)).collect();
                    let mut done: Vec<Option<(Result<(), Error>, Body<'_>, OpId, Option<crate::Lent>)>> = work.iter().map(|_| None).collect();
                    let shared: &Body<'_> = body;
                    let tasks = done
                        .iter_mut()
                        .zip(work)
                        .zip(lent)
                        .map(|((slot, (c, m)), lent)| {
                            Box::new(move || {
                                let (mut sub, at, parent) = match lent {
                                    Some((sub, parent)) => (sub, *c, Some(parent)),
                                    None => {
                                        let (sub, at) = shared.split_off(*c);
                                        (sub, at, None)
                                    }
                                };
                                *slot = Some((m.run_exec(&mut sub, at, exec), sub, at, parent));
                            }) as crate::Task<'_>
                        })
                        .collect();
                    moremath::Executor::execute(exec, tasks);
                    let done: Vec<_> = done.into_iter().map(|d| d.expect("every task ran")).collect();
                    let failed = done.iter().find_map(|(r, ..)| r.as_ref().err()).cloned();
                    let mut grafts = Vec::new();
                    for ((c, _), (_, sub, with, parent)) in work.iter().zip(done) {
                        match parent {
                            Some(parent) => body.unlend(*c, sub, parent),
                            None if failed.is_none() => grafts.push((*c, sub, with)),
                            None => {}
                        }
                    }
                    for (c, sub, with) in grafts {
                        body.graft(c, sub, with);
                    }
                    if let Some(e) = failed {
                        return Err(e);
                    }
                }
            }
        }
        Ok(())
    }

    #[cfg(feature = "std")]
    fn calibrate(body: &mut Body<'_>, work: &[(OpId, &PassManager)], exec: &crate::Exec<'_>) -> Result<Option<usize>, Error> {
        let sizes: Vec<usize> = work.iter().map(|(c, ..)| body.op_count(*c)).collect();
        let total: usize = sizes.iter().sum();
        let (t, mut ran, mut first) = (std::time::Instant::now(), 0, 0);
        while first < work.len() && ran * 32 < total {
            let (c, m) = work[first];
            m.run_exec(body, c, exec)?;
            ran += sizes[first];
            first += 1;
        }
        let per_op = t.elapsed().as_nanos() as f64 / ran.max(1) as f64;
        let w = moremath::Executor::threads(exec) as f64;
        if work.len() - first < 2 || per_op * (w - 1.0) / w < MOVE_NS_PER_OP {
            for &(c, m) in &work[first..] {
                m.run_exec(body, c, exec)?;
            }
            return Ok(None);
        }
        Ok(Some(first))
    }

    #[cfg(not(feature = "std"))]
    fn calibrate(_: &mut Body<'_>, _: &[(OpId, &PassManager)], _: &crate::Exec<'_>) -> Result<Option<usize>, Error> {
        Ok(Some(0))
    }

    fn elements<'s>(&mut self, reg: &dyn PassRegistry, mut s: &'s str) -> Result<&'s str, Error> {
        loop {
            s = s.trim_start();
            let end = s.find(|c: char| matches!(c, '{' | '(' | ',' | ')') || c.is_whitespace()).unwrap_or(s.len());
            let name = &s[..end];
            if name.is_empty() {
                return Err(Error(format!("expected a pass or pass manager name at `{s}`")));
            }
            s = s[end..].trim_start();
            let mut options = "";
            if let Some(after) = s.strip_prefix('{') {
                let close = Self::closing(after, '{', '}').ok_or_else(|| Error(format!("`{name}{{` without its `}}`")))?;
                options = &after[..close];
                s = after[close + 1..].trim_start();
            }
            if let Some(after) = s.strip_prefix('(') {
                let mut pm = PassManager::on(name);
                s = pm.elements(reg, after)?.trim_start();
                s = s.strip_prefix(')').ok_or_else(|| Error(format!("`{name}(` without its `)`")))?;
                self.nest(pm);
            } else {
                self.add_named(reg, name, options)?;
            }
            s = s.trim_start();
            match s.strip_prefix(',') {
                Some(rest) => s = rest,
                None => return Ok(s),
            }
        }
    }

    fn closing(s: &str, open: char, close: char) -> Option<usize> {
        let (mut depth, mut quote) = (0i32, false);
        for (i, c) in s.char_indices() {
            match c {
                '"' => quote = !quote,
                _ if quote => {}
                c if c == open => depth += 1,
                c if c == close && depth == 0 => return Some(i),
                c if c == close => depth -= 1,
                _ => {}
            }
        }
        None
    }

    fn anchor_name(&self) -> &str {
        self.anchor.as_deref().unwrap_or("any")
    }
}

impl PassManager {
    pub fn parse(reg: &dyn PassRegistry, s: &str) -> Result<Self, Error> {
        let s = s.trim();
        let open = s.find('(').ok_or_else(|| Error(format!("pipeline `{s}` names no anchor, e.g. `builtin.module(...)`")))?;
        let mut pm = PassManager::on(s[..open].trim());
        let rest = pm.elements(reg, &s[open + 1..])?;
        match rest.trim_start().strip_prefix(')') {
            Some(tail) if tail.trim().is_empty() => Ok(pm),
            _ => Err(Error(format!("unexpected `{rest}` at the end of the pipeline"))),
        }
    }
}

impl fmt::Display for PassManager {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "{}(", self.anchor_name())?;
        for (i, e) in self.entries.iter().enumerate() {
            if i > 0 {
                f.write_str(", ")?;
            }
            match e {
                Entry::Pass(p) => write!(f, "{}{}", p.name(), p.options())?,
                Entry::Adaptor(mgrs) => {
                    for (j, m) in mgrs.iter().enumerate() {
                        if j > 0 {
                            f.write_str(", ")?;
                        }
                        write!(f, "{m}")?;
                    }
                }
            }
        }
        f.write_str(")")
    }
}

#[cfg(feature = "std")]
const MOVE_NS_PER_OP: f64 = 300.0;

impl Body<'_> {
    pub fn op_count(&self, op: OpId) -> usize {
        1 + self[op].regions.iter().flat_map(|r| &self[*r].blocks).flat_map(|b| self.ops(*b)).map(|o| self.op_count(o)).sum::<usize>()
    }

    pub fn children(&self, op: OpId) -> Vec<OpId> {
        self[op].regions.iter().flat_map(|r| &self[*r].blocks).flat_map(|b| self.ops(*b)).collect()
    }
}

pub struct PassInfo {
    pub name: &'static str,
    pub anchor: Option<&'static str>,
    pub make: fn(&Options<'_>) -> Result<Box<dyn Pass>, Error>,
}

pub trait PassRegistry {
    fn pass(&self, name: &str) -> Option<&PassInfo>;
}

#[derive(Default)]
pub struct Passes {
    by_name: BTreeMap<&'static str, PassInfo>,
}

impl Passes {
    pub fn new() -> Self {
        Self::default()
    }

    pub fn register<T>(&mut self) -> &mut Self
    where
        T: PassDecl + Pass + for<'o, 's> TryFrom<&'o Options<'s>, Error = Error> + 'static,
    {
        fn make<T: Pass + for<'o, 's> TryFrom<&'o Options<'s>, Error = Error> + 'static>(o: &Options<'_>) -> Result<Box<dyn Pass>, Error> {
            Ok(Box::new(T::try_from(o)?))
        }
        self.by_name.insert(T::NAME, PassInfo { name: T::NAME, anchor: T::ANCHOR, make: make::<T> });
        self
    }

    pub fn with(&mut self, add: impl FnOnce(&mut Self)) -> &mut Self {
        add(self);
        self
    }
}

impl PassRegistry for Passes {
    fn pass(&self, name: &str) -> Option<&PassInfo> {
        self.by_name.get(name)
    }
}

pub type Task<'s> = Box<dyn FnOnce() + Send + 's>;

#[derive(Clone, Copy)]
pub struct Exec<'x>(&'x dyn Fork);

trait Fork: Sync {
    fn threads(&self) -> usize;

    fn run<'s>(&self, tasks: Vec<Task<'s>>);
}

impl<X: moremath::Executor + Sync> Fork for X {
    #[inline]
    fn threads(&self) -> usize {
        moremath::Executor::threads(self)
    }

    #[inline]
    fn run<'s>(&self, tasks: Vec<Task<'s>>) {
        self.execute(tasks);
    }
}

impl<'x, X: moremath::Executor + Sync> From<&'x X> for Exec<'x> {
    #[inline]
    fn from(x: &'x X) -> Self {
        Exec(x)
    }
}

impl moremath::Executor for Exec<'_> {
    #[inline]
    fn threads(&self) -> usize {
        self.0.threads()
    }

    fn execute<'x, 't, E: moremath::Execute<'t>>(&'x self, tasks: Vec<E>) -> Vec<E::Output> {
        let mut out: Vec<Option<E::Output>> = tasks.iter().map(|_| None).collect();
        let boxed: Vec<Task<'_>> = out.iter_mut().zip(tasks).map(|(slot, t)| Box::new(move || *slot = Some(t.execute())) as Task<'_>).collect();
        self.0.run(boxed);
        out.into_iter().map(|o| o.expect("every task ran")).collect()
    }
}

pub type LocalRun<'f> = dyn for<'x> Fn(&mut Body<'x>, OpId) -> Result<(), Error> + Sync + 'f;

impl<'a> Body<'a> {
    pub fn isolated(&self, op: OpId) -> bool {
        self.has(op, Trait::IsIsolatedFromAbove)
    }

    pub fn split_off(&self, op: OpId) -> (Self, OpId) {
        let mut sub = Body::new(self.ctx);
        let mut ancestors = Vec::new();
        let mut at = self.parent_op(op);
        while let Some(a) = at {
            ancestors.push(a);
            at = self.parent_op(a);
        }
        for a in ancestors.into_iter().rev() {
            for n in &self[a].attributes {
                let root = sub.root;
                sub[root].set(&n.name, n.value.clone().unwrap_or(mlirformat::Attribute::Unit));
            }
        }
        sub.home = sub.new_seg(crate::Seg::default());
        let moved = sub.transplant(self, op);
        sub.home = crate::Id::seg(sub.root);
        let block = sub.top_block(sub.root);
        sub.insert(moved, block, None);
        (sub, moved)
    }

    pub fn graft(&mut self, op: OpId, from: Body<'a>, with: OpId) {
        let new = with.shift(&self.absorb(from));
        self.detach(new);
        let results = self[new].results.clone();
        self.swap_in(op, new);
        if !self[op].operands.is_empty() {
            self.set_operands(op, Vec::new());
        }
        if !results.is_empty() {
            for (r, w) in self[op].results.clone().into_iter().zip(&results) {
                self.replace_all_uses(r, *w);
            }
        }
    }

    fn transplant(&mut self, from: &Body<'a>, op: OpId) -> OpId {
        let mut values: Vec<(ValueId, ValueId)> = Vec::new();
        let mut blocks = Vec::new();
        let mut made = Vec::new();
        let new = self.shell(from, op, &mut values, &mut blocks, &mut made);
        values.sort_unstable();
        blocks.sort_unstable();
        let value = |v: ValueId| values.binary_search_by_key(&v, |p| p.0).map(|i| values[i].1).expect("an isolated op uses only its own values");
        for (old, new) in made {
            let operands: crate::Ids<_> = from[old].operands.iter().map(|v| value(*v)).collect();
            self.set_operands(new, operands);
            self[new].successors = from[old].successors.iter().map(|b| blocks[blocks.binary_search_by_key(b, |p| p.0).expect("a successor in the op")].1).collect();
        }
        new
    }

    fn shell(&mut self, from: &Body<'a>, op: OpId, values: &mut Vec<(ValueId, ValueId)>, blocks: &mut Vec<(crate::BlockId, crate::BlockId)>, made: &mut Vec<(OpId, OpId)>) -> OpId {
        let d = &from[op];
        let data = OpData { operands: crate::Ids::new(), results: crate::Ids::new(), successors: crate::Ids::new(), regions: crate::Ids::new(), parent: None, defaults: false, ..d.clone() };
        let new = self.push_op(data, &from.types(&d.results));
        for (a, b) in d.results.iter().zip(self[new].results.clone()) {
            self[b].loc = from[*a].loc.clone();
            values.push((*a, b));
        }
        made.push((op, new));
        for r in &d.regions {
            let nr = self.add_region(new);
            for b in &from[*r].blocks {
                let args: Vec<_> = from[*b].args.iter().map(|a| (from[*a].ty.clone(), from[*a].loc.clone())).collect();
                let nb = self.add_block(nr, &args);
                values.extend(from[*b].args.iter().copied().zip(self[nb].args.clone()));
                blocks.push((*b, nb));
                for o in &from.block_ops(*b) {
                    let c = self.shell(from, *o, values, blocks, made);
                    self.insert(c, nb, None);
                }
            }
        }
        new
    }
}

pub const SPLIT_MARKER: &str = "// -----";

pub struct Invocation {
    pub pipeline: PassManager,
    pub split: Option<String>,
    pub generic: bool,
    pub debuginfo: bool,
    pub local_scope: bool,
    pub verify_diagnostics: bool,
    pub input: Option<String>,
    pub output: Option<String>,
    pub threading: bool,
    #[cfg(feature = "std")]
    pub workers: std::sync::OnceLock<moremath::ThreadMulti>,
    #[cfg(feature = "std")]
    pub one: moremath::ThreadMulti,
}

const IGNORED: &[&str] = &["allow-unregistered-dialect", "mlir-print-value-users", "mlir-print-elementsattrs-with-hex-if-larger", "mlir-elide-elementsattrs-if-larger", "mlir-print-unique-ssa-ids", "mlir-very-unsafe-disable-verifier-on-parsing", "mlir-print-assume-verified", "mlir-print-skip-regions"];

impl Invocation {
    pub fn parse<S: AsRef<str>>(reg: &dyn crate::PassRegistry, args: &[S]) -> Result<Self, Error> {
        let mut inv = Invocation { pipeline: PassManager::on("builtin.module"), split: None, generic: false, debuginfo: false, local_scope: false, verify_diagnostics: false, input: None, output: None, threading: true, #[cfg(feature = "std")] workers: std::sync::OnceLock::new(), #[cfg(feature = "std")] one: moremath::ThreadMulti::from(core::num::NonZeroUsize::MIN) };
        let mut verify_each = true;
        let mut it = args.iter().map(AsRef::as_ref);
        while let Some(arg) = it.next() {
            let Some(flag) = arg.strip_prefix('-').filter(|f| !f.is_empty()) else {
                inv.input = Some(arg.into());
                continue;
            };
            let flag = flag.strip_prefix('-').unwrap_or(flag);
            let (name, value) = flag.split_once('=').map_or((flag, None), |(n, v)| (n, Some(v)));
            match name {
                "o" => inv.output = Some(value.or_else(|| it.next()).ok_or("`-o` needs a file")?.into()),
                "split-input-file" => inv.split = Some(value.unwrap_or(SPLIT_MARKER).into()),
                "mlir-print-op-generic" => inv.generic = true,
                "mlir-print-debuginfo" => inv.debuginfo = true,
                "mlir-print-local-scope" => inv.local_scope = true,
                "verify-diagnostics" => inv.verify_diagnostics = true,
                "mlir-disable-threading" => inv.threading = false,
                "verify-each" => verify_each = !matches!(value, Some("false" | "0")),
                "pass-pipeline" | "p" => {
                    let text = value.or_else(|| it.next()).ok_or("`--pass-pipeline` needs a pipeline")?;
                    inv.pipeline = PassManager::parse(reg, text)?;
                }
                n if IGNORED.contains(&n) => {}
                n => {
                    inv.pipeline.add_named(reg, n, value.unwrap_or(""))?;
                }
            }
        }
        inv.pipeline.set_verify_each(verify_each);
        Ok(inv)
    }
}

impl Invocation {
    pub fn chunks<'s>(&self, src: &'s str) -> Vec<&'s str> {
        let Some(marker) = &self.split else { return alloc::vec![src] };
        let mut out = Vec::new();
        let mut start = 0;
        for (at, line) in Self::lines(src) {
            if line.trim_end() == marker {
                out.push(&src[start..at]);
                start = at + line.len();
            }
        }
        out.push(&src[start..]);
        out
    }

    fn lines(src: &str) -> impl Iterator<Item = (usize, &str)> {
        src.split_inclusive('\n').scan(0, |at, l| {
            let here = *at;
            *at += l.len();
            Some((here, l))
        })
    }

    pub fn run_chunk(&self, ctx: Ctx<'_>, chunk: &str) -> Result<String, Error> {
        let mut body = self.read(ctx, chunk)?;
        let root = body.root;
        match self.pipeline.run_on(&mut body, root, &self.executor()) {
            Ok(()) => Ok(self.print(&mut body)),
            Err(_) if self.verify_diagnostics && chunk.contains("expected-error") => Ok(String::new()),
            Err(e) => {
                let mut text: String = body.take_diagnostics().iter().map(|d| format!("{d}\n")).collect();
                text.push_str(&e.0);
                Err(Error(text))
            }
        }
    }

    pub fn read<'a>(&self, ctx: Ctx<'a>, chunk: &'a str) -> Result<Body<'a>, Error> {
        #[cfg(feature = "std")]
        if self.threading && chunk.len() >= mlirformat::MlirOpt::PARALLEL_BYTES {
            return Body::parse_in(ctx, chunk, self.threads());
        }
        Body::parse(ctx, chunk)
    }

    pub fn executor(&self) -> crate::Exec<'_> {
        #[cfg(feature = "std")]
        return crate::Exec::from(if self.threading { self.threads() } else { &self.one });
        #[cfg(not(feature = "std"))]
        crate::Exec::from(&moremath::ThreadSingle)
    }

    #[cfg(feature = "std")]
    fn threads(&self) -> &moremath::ThreadMulti {
        self.workers.get_or_init(moremath::ThreadMulti::default)
    }

    pub fn print(&self, body: &mut Body<'_>) -> String {
        let mut text = self.print_op(body);
        if !self.local_scope {
            text.push('\n');
        }
        text
    }

    fn print_op(&self, body: &mut Body<'_>) -> String {
        if !self.debuginfo {
            match self.workers(body) {
                #[cfg(feature = "std")]
                Some(x) => body.clear_locs_in(x),
                _ => body.set_locs(body.root, None),
            }
        }
        let loc = |i: &Item<'_>| matches!(i, Item::AttrAlias { value: mlirformat::Attribute::Builtin { name, .. }, .. } if name == "loc");
        let kept = |i: &Item<'_>| self.debuginfo || !loc(i);
        let alias = |i: &Item<'_>| matches!(i, Item::AttrAlias { .. } | Item::TypeAlias { .. });
        let show = |keep: &dyn Fn(&Item<'_>) -> bool| self.show(body, self.local_scope, |i| kept(i) && keep(i));
        if !body.items.iter().any(|i| kept(i) && alias(i)) {
            return show(&|_| true);
        }
        let text = self.show(body, true, |i| kept(i) && !alias(i));
        let named = |sigil: char, name: &str| {
            let pat = format!("{sigil}{name}");
            text.match_indices(&pat).any(|(i, _)| !text[i + pat.len()..].starts_with(|c: char| c.is_ascii_alphanumeric() || "_$.-".contains(c)))
        };
        show(&|i| match i {
            Item::AttrAlias { name, .. } => named('#', name),
            Item::TypeAlias { name, .. } => named('!', name),
            _ => true,
        })
    }

    fn show(&self, body: &Body<'_>, local_scope: bool, keep: impl Fn(&Item<'_>) -> bool) -> String {
        let opt = body.ctx.opt;
        #[cfg(feature = "std")]
        if let Some(x) = self.workers(body) {
            return if local_scope { body.show_local_scope_in(opt, self.generic, keep, x) } else { body.show_in(opt, self.generic, keep, x) };
        }
        if local_scope { body.show_local_scope(opt, self.generic, keep) } else { body.show(opt, self.generic, keep) }
    }

    #[cfg(feature = "std")]
    fn workers(&self, body: &Body<'_>) -> Option<&moremath::ThreadMulti> {
        (self.threading && body.ops_count() >= Self::PARALLEL_OPS).then(|| self.threads())
    }

    #[cfg(not(feature = "std"))]
    fn workers(&self, _: &Body<'_>) -> Option<&moremath::ThreadSingle> {
        None
    }

    #[cfg(feature = "std")]
    const PARALLEL_OPS: usize = 1 << 14;

    pub fn run(&self, ctx: Ctx<'_>, src: &str) -> Result<String, Error> {
        let outs = self.chunks(src).into_iter().map(|c| self.run_chunk(ctx, c)).collect::<Result<Vec<_>, _>>()?;
        Ok(outs.join(&format!("{SPLIT_MARKER}\n")))
    }
}

impl crate::Interfaces<'_> {
    #[allow(unused_imports, unused_mut)]
    pub fn upstream() -> Self {
        use crate::*;
        let mut i = Self::new();
        #[cfg(feature = "dialect.affine")]
        i.register(&AffineDialect);
        #[cfg(feature = "dialect.arith")]
        i.register(&ArithDialect);
        #[cfg(feature = "dialect.bufferization")]
        i.register(&BufferizationDialect);
        #[cfg(feature = "dialect.cf")]
        i.register(&CfDialect);
        #[cfg(feature = "dialect.complex")]
        i.register(&ComplexDialect);
        #[cfg(feature = "dialect.acc")]
        i.register(&AccDialect);
        #[cfg(feature = "dialect.emitc")]
        i.register(&EmitcDialect);
        #[cfg(feature = "dialect.func")]
        i.register(&FuncDialect);
        #[cfg(feature = "dialect.gpu")]
        i.register(&GpuDialect);
        #[cfg(feature = "dialect.index")]
        i.register(&IndexDialect);
        #[cfg(feature = "dialect.linalg")]
        i.register(&LinalgDialect);
        #[cfg(feature = "dialect.llvm")]
        i.register(&LlvmDialect);
        #[cfg(feature = "dialect.math")]
        i.register(&MathDialect);
        #[cfg(feature = "dialect.memref")]
        i.register(&MemrefDialect);
        #[cfg(feature = "dialect.ml_program")]
        i.register(&MlProgramDialect);
        #[cfg(feature = "dialect.scf")]
        i.register(&ScfDialect);
        #[cfg(feature = "dialect.shape")]
        i.register(&ShapeDialect);
        #[cfg(feature = "dialect.spirv")]
        i.register(&SpirvDialect);
        #[cfg(feature = "dialect.tensor")]
        i.register(&TensorDialect);
        #[cfg(feature = "dialect.test")]
        i.register(&TestDialect);
        #[cfg(feature = "dialect.tosa")]
        i.register(&TosaDialect);
        #[cfg(feature = "dialect.ub")]
        i.register(&UbDialect);
        #[cfg(feature = "dialect.vector")]
        i.register(&VectorDialect);
        i
    }
}

impl Body<'_> {
    pub fn verify_branches(&self, root: OpId) -> Result<(), mlirformat::Error> {
        let mut out = Ok(());
        self.walk(root, &mut |op| {
            if out.is_ok() {
                out = self.verify_branch_op(op);
            }
        });
        out
    }

    fn verify_branch_op(&self, op: OpId) -> Result<(), mlirformat::Error> {
        for (i, succ) in self[op].successors.iter().enumerate() {
            let Some(range) = self.successor_operands(op, i) else { continue };
            let args = &self[*succ].args;
            if let Some(j) = self[op].operands[range].iter().zip(args).position(|(v, a)| self[*v].ty != self[*a].ty) {
                return Err(mlirformat::Error(format!("'{}' op type mismatch for bb argument #{j} of successor #{i}", self[op].name)));
            }
        }
        Ok(())
    }

    fn verify_affines(&self, root: OpId) -> Result<(), Error> {
        #[cfg(feature = "dialect.affine")]
        {
            let mut out = Ok(());
            self.walk(root, &mut |op| {
                if out.is_ok() {
                    out = self.verify_affine(op);
                }
            });
            out
        }
        #[cfg(not(feature = "dialect.affine"))]
        {
            let _ = root;
            Ok(())
        }
    }

    pub fn verify(&self, root: OpId) -> Result<(), Error> {
        self.verify_branches(root)?;
        self.verify_affines(root)
    }

    pub fn verify_in<X: moremath::Executor + Sync>(&self, root: OpId, exec: &X) -> Result<(), Error> {
        let children = self.children(root);
        if moremath::Executor::threads(exec) < 2 || children.len() < 2 {
            return self.verify(root);
        }
        let step = children.len().div_ceil(moremath::Executor::threads(exec) * 4).max(1);
        let runs: Vec<_> = children
            .chunks(step)
            .map(|run| {
                move || {
                    let branch = run.iter().find_map(|c| self.verify_branches(*c).err());
                    let affine = run.iter().find_map(|c| self.verify_affines(*c).err());
                    (branch, affine)
                }
            })
            .collect();
        let found = moremath::Executor::execute(exec, runs);
        self.verify_branch_op(root)?;
        if let Some(e) = found.iter().find_map(|(b, _)| b.clone()) {
            return Err(e);
        }
        #[cfg(feature = "dialect.affine")]
        self.verify_affine(root)?;
        found.into_iter().find_map(|(_, a)| a).map_or(Ok(()), Err)
    }

    #[cfg(feature = "dialect.affine")]
    fn verify_identifiers(&self, op: OpId, operands: &[ValueId], dims: usize) -> Result<(), Error> {
        let scope = self.affine_scope(op);
        for (i, v) in operands.iter().enumerate() {
            if i < dims && !self.is_valid_dim_in(*v, scope) {
                return Err(Error(format!("'{}' op operand cannot be used as a dimension id", self[op].name)));
            }
            if i >= dims && !self.is_valid_symbol_in(*v, scope) {
                return Err(Error(format!("'{}' op operand cannot be used as a symbol", self[op].name)));
            }
        }
        Ok(())
    }

    #[cfg(feature = "dialect.affine")]
    fn verify_affine(&self, op: OpId) -> Result<(), Error> {
        let d = &self[op];
        let dims = |name: &str| self.affine_map(op, name).map_or(0, |m| m.dims as usize);
        match &*d.name {
            "affine.load" | "affine.vector_load" => self.verify_identifiers(op, &d.operands[1..], dims("map")),
            "affine.store" | "affine.vector_store" => self.verify_identifiers(op, &d.operands[2..], dims("map")),
            "affine.if" => self.verify_identifiers(op, &d.operands, self.integer_set(op, "condition").map_or(0, |s| s.dims as usize)),
            "affine.for" => {
                let Some(sizes) = self.segments(op, "operandSegmentSizes") else { return Ok(()) };
                let (lb, ub) = (&d.operands[..sizes[0]], &d.operands[sizes[0]..sizes[0] + sizes[1]]);
                self.verify_identifiers(op, lb, dims("lowerBoundMap"))?;
                self.verify_identifiers(op, ub, dims("upperBoundMap"))
            }
            "affine.apply" => {
                let scope = self.affine_scope(op);
                let misplaced = d.operands.iter().skip(dims("map")).any(|v| self.is_valid_dim_in(*v, scope) && !self.is_valid_symbol_in(*v, scope));
                if misplaced { Err(Error(String::from("'affine.apply' op dimensional operand cannot be used as a symbol"))) } else { Ok(()) }
            }
            _ => Ok(()),
        }
    }
}
