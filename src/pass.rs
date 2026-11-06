//! ⭐ Passes and the pass manager, as `mlir/Pass`.
//!
//! ```text
//! builtin.module(func.func(cse, canonicalize{max-iterations=3}), symbol-dce)
//! └ PassManager on builtin.module
//!   ├ Adaptor: the children of the module, each to the manager for its name
//!   │ └ PassManager on func.func: cse, canonicalize
//!   └ symbol-dce
//! ```
//!
//! Adding a pass anchored on another op than the manager's nests it implicitly, and adjacent
//! adaptors merge (managers for the same op name concatenate), exactly as `OpPassManager` does:
//! `func.func(a), func.func(b)` runs `a` then `b` on each function, not `a` on all of them first.

use alloc::format;
use alloc::boxed::Box;
use alloc::collections::BTreeMap;
use alloc::string::String;
use alloc::vec::Vec;
use core::fmt;
use mlirformat::{Error, Item};
use crate::{Body, OpId, OpData, Shift, Trait, ValueId, Ctx};


/// A pass's `mlir-opt` name and anchor op (`Passes.td`'s `Pass<"name", "op">`); `#[pass]`
/// declares it.
pub trait PassDecl {
    const NAME: &'static str;
    /// `None`: any op.
    const ANCHOR: Option<&'static str>;
}

/// What a pass does; with its `PassDecl`, it is a [`Pass`].
pub trait Run {
    /// Runs on `op`; an error is the pass failing (`signalPassFailure`).
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error>;

    /// [`run`](Self::run), with threads to split the work over (`#[pass(.., local)]`).
    fn run_in<'a>(&self, body: &mut Body<'a>, op: OpId, _exec: &crate::Exec<'_>) -> Result<(), Error> {
        self.run(body, op)
    }

    /// The options as a textual pipeline prints them (`{a=1 b=true}`), empty when none differ.
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

/// A value a `#[opt]` field reads from the pass options.
pub trait OptionValue: Sized {
    fn read(o: &Options<'_>, key: &str, default: Self) -> Result<Self, Error>;
}

impl OptionValue for bool {
    fn read(o: &Options<'_>, key: &str, default: Self) -> Result<Self, Error> {
        o.flag(key, default)
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

/// ⭐ One pass. It runs on one op at a time (its anchor), and may change anything inside it.
pub trait Pass: Send + Sync {
    /// The `mlir-opt` argument, e.g. `"cse"`.
    fn name(&self) -> &str;

    /// Runs on `op`; an error is the pass failing (`signalPassFailure`).
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error>;

    /// [`run`](Self::run), with threads to split the work over.
    fn run_in<'a>(&self, body: &mut Body<'a>, op: OpId, _exec: &crate::Exec<'_>) -> Result<(), Error> {
        self.run(body, op)
    }

    /// The options as a textual pipeline prints them (`{a=1 b=true}`), empty when none differ.
    fn options(&self) -> String {
        String::new()
    }
}

/// `key=value` pairs of a pass option string (`max-iterations=3 region-simplify=aggressive`).
#[derive(Debug, Clone, Default, PartialEq, Eq)]
pub struct Options<'s> {
    pairs: Vec<(&'s str, &'s str)>,
}

impl<'s> TryFrom<&'s str> for Options<'s> {
    type Error = Error;

    /// Whitespace separates options; a value may be quoted or braced (both kept out).
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
                // A bare key is a flag.
                "true"
            };
            pairs.push((key, value));
            rest = rest.trim_start();
        }
        Ok(Self { pairs })
    }
}

impl<'s> Options<'s> {
    /// Where an option value ends: the first top-level whitespace.
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

    /// Fails on a key outside `known`, as `mlir-opt` does.
    pub fn only(&self, pass: &str, known: &[&str]) -> Result<&Self, Error> {
        match self.pairs.iter().find(|(k, _)| !known.contains(k)) {
            Some((k, _)) => Err(Error(format!("pass `{pass}`: no option `{k}`"))),
            None => Ok(self),
        }
    }

    pub fn get(&self, key: &str) -> Option<&'s str> {
        self.pairs.iter().rev().find(|(k, _)| *k == key).map(|(_, v)| *v)
    }

    /// A boolean option (`true`/`false`/`1`/`0`), `default` when absent.
    pub fn flag(&self, key: &str, default: bool) -> Result<bool, Error> {
        match self.get(key) {
            None => Ok(default),
            Some("true" | "1") => Ok(true),
            Some("false" | "0") => Ok(false),
            Some(v) => Err(Error(format!("option `{key}`: `{v}` is not a boolean"))),
        }
    }

    /// A parsed option, `default` when absent.
    pub fn value<T: core::str::FromStr>(&self, key: &str, default: T) -> Result<T, Error> {
        self.get(key).map_or(Ok(default), |v| v.parse().map_err(|_| Error(format!("option `{key}`: bad value `{v}`"))))
    }

    /// A comma-separated list option.
    pub fn list(&self, key: &str) -> Vec<&'s str> {
        let Some(v) = self.get(key) else { return Vec::new() };
        // Commas inside `(...)` / `{...}` belong to the element (`op-pipelines=func.func(a,b)`).
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

/// One step of a manager.
enum Entry {
    Pass(Box<dyn Pass>),
    /// Runs each child op of the anchor through the manager for its name.
    Adaptor(Vec<PassManager>),
}

/// ⭐ A pass pipeline anchored on one op name (`None`: any op).
pub struct PassManager {
    pub anchor: Option<String>,
    entries: Vec<Entry>,
    /// The verifiers run after each pass (`-verify-each`, on by default as in `mlir-opt`).
    pub verify_each: bool,
}

impl PassManager {
    /// A manager for ops named `anchor` (`"any"`: every op).
    pub fn on(anchor: &str) -> Self {
        Self { anchor: (anchor != "any").then(|| anchor.into()), entries: Vec::new(), verify_each: true }
    }

    /// `-verify-each`, for this manager and every one nested in it.
    pub fn set_verify_each(&mut self, on: bool) {
        self.verify_each = on;
        for e in &mut self.entries {
            if let Entry::Adaptor(mgrs) = e {
                mgrs.iter_mut().for_each(|m| m.set_verify_each(on));
            }
        }
    }

    fn nest(&mut self, pm: PassManager) {
        // Adjacent adaptors merge; managers for the same name concatenate.
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

    /// Adds registered pass `info` with `options`, nesting implicitly when it is anchored elsewhere.
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

    /// Adds pass `name` from registry `reg`.
    pub fn add_named(&mut self, reg: &dyn PassRegistry, name: &str, options: &str) -> Result<&mut Self, Error> {
        let info = reg.pass(name).ok_or_else(|| Error(format!("unknown pass `{name}`")))?;
        self.add(info, &Options::try_from(options)?)
    }

    /// ⭐ Runs the pipeline on `op`, nested pipelines one op after the other.
    pub fn run(&self, body: &mut Body<'_>, op: OpId) -> Result<(), Error> {
        #[cfg(feature = "std")]
        return self.run_on(body, op, &moremath::ThreadMulti::default());
        #[cfg(not(feature = "std"))]
        self.run_on(body, op, &moremath::ThreadSingle)
    }

    /// ⭐ Runs the pipeline on `op`; a nested pipeline's ops, when they are all isolated from
    /// above, each in a body of its own, as `exec`'s tasks (nested deeper: serially).
    pub fn run_on<X: moremath::Executor + Sync>(&self, body: &mut Body<'_>, op: OpId, exec: &X) -> Result<(), Error> {
        self.run_exec(body, op, &crate::Exec::from(exec))
    }

    /// [`run_on`](Self::run_on), the executor erased.
    fn run_exec(&self, body: &mut Body<'_>, op: OpId, exec: &crate::Exec<'_>) -> Result<(), Error> {
        if let Some(anchor) = &self.anchor
            && body[op].name != **anchor
        {
            return Err(Error(format!("can't run '{anchor}' pass manager on '{}' op", body[op].name)));
        }
        for e in &self.entries {
            match e {
                Entry::Pass(p) => {
                    p.run_in(body, op, exec)?;
                    if self.verify_each {
                        body.verify_in(op, exec)?;
                    }
                }
                Entry::Adaptor(mgrs) => {
                    // Each op the managers anchor on, with its place in its block (for the graft).
                    let work: Vec<(OpId, usize, &PassManager)> = body[op]
                        .regions
                        .iter()
                        .flat_map(|r| &body[*r].blocks)
                        .flat_map(|b| body[*b].ops.iter().enumerate())
                        .filter_map(|(at, &c)| {
                            let name = &body[c].name;
                            mgrs.iter().find(|m| m.anchor.as_deref() == Some(&**name)).or_else(|| mgrs.iter().find(|m| m.anchor.is_none())).map(|m| (c, at, m))
                        })
                        .collect();
                    if moremath::Executor::threads(exec) < 2 || work.len() < 2 || !work.iter().all(|(c, ..)| body.isolated(*c)) {
                        for (c, _, m) in work {
                            m.run_exec(body, c, exec)?;
                        }
                        continue;
                    }
                    // A function in a seg of its own moves out and back for free; only the others
                    // are copied out, which has to pay for itself (`calibrate`).
                    let first = if work.iter().all(|(c, ..)| body.lendable(*c)) {
                        0
                    } else {
                        let Some(first) = Self::calibrate(body, &work, exec)? else { continue };
                        first
                    };
                    let work = &work[first..];
                    let lent: Vec<_> = work.iter().map(|(c, ..)| body.lend(*c)).collect();
                    // A task runs on its lent body, or splits its op off the shared body itself
                    // (reading only), so the copying out runs in parallel too.
                    let mut done: Vec<Option<(Result<(), Error>, Body<'_>, OpId, Option<Option<crate::BlockId>>)>> = work.iter().map(|_| None).collect();
                    let shared: &Body<'_> = body;
                    let tasks = done
                        .iter_mut()
                        .zip(work)
                        .zip(lent)
                        .map(|((slot, (c, _, m)), lent)| {
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
                    // Every lent seg goes back, whatever happened; copies only when all went well.
                    let failed = done.iter().find_map(|(r, ..)| r.as_ref().err()).cloned();
                    for ((c, at, _), (_, sub, with, parent)) in work.iter().zip(done) {
                        match parent {
                            Some(parent) => body.unlend(*c, sub, parent),
                            None if failed.is_none() => body.graft(*c, *at, sub, with),
                            None => {}
                        }
                    }
                    if let Some(e) = failed {
                        return Err(e);
                    }
                }
            }
        }
        Ok(())
    }

    /// ⭐ Whether moving the ops out to threads pays: runs the nested pipelines in place, one op
    /// after the other, until a 32nd of the ops' IR has run, and times it. Moving an op out
    /// and back costs about [`MOVE_NS_PER_OP`] per op inside it, whatever the pipeline; running
    /// it costs what was measured, and the threads share that. `None`: not worth it, so every op
    /// has run here; else how many did (the rest go to the threads).
    #[cfg(feature = "std")]
    fn calibrate(body: &mut Body<'_>, work: &[(OpId, usize, &PassManager)], exec: &crate::Exec<'_>) -> Result<Option<usize>, Error> {
        let sizes: Vec<usize> = work.iter().map(|(c, ..)| body.op_count(*c)).collect();
        let total: usize = sizes.iter().sum();
        let (t, mut ran, mut first) = (std::time::Instant::now(), 0, 0);
        while first < work.len() && ran * 32 < total {
            let (c, _, m) = work[first];
            m.run_exec(body, c, exec)?;
            ran += sizes[first];
            first += 1;
        }
        let per_op = t.elapsed().as_nanos() as f64 / ran.max(1) as f64;
        let w = moremath::Executor::threads(exec) as f64;
        if work.len() - first < 2 || per_op * (w - 1.0) / w < MOVE_NS_PER_OP {
            for &(c, _, m) in &work[first..] {
                m.run_exec(body, c, exec)?;
            }
            return Ok(None);
        }
        Ok(Some(first))
    }

    #[cfg(not(feature = "std"))]
    fn calibrate(_: &mut Body<'_>, _: &[(OpId, usize, &PassManager)], _: &crate::Exec<'_>) -> Result<Option<usize>, Error> {
        Ok(Some(0))
    }

    /// Parses the elements of a textual pipeline into this manager: `a, b{x=1}, func.func(c)`.
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

    /// Where the bracket closing an opened one sits.
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

    /// The anchor as a textual pipeline names it.
    fn anchor_name(&self) -> &str {
        self.anchor.as_deref().unwrap_or("any")
    }
}

impl PassManager {
    /// `--pass-pipeline` text: `anchor(elements)`, the passes named from `reg`.
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
    /// The textual pipeline, as `mlir-opt --dump-pass-pipeline` prints it.
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

/// What moving an op into a body of its own and back costs, per op inside it (split, graft):
/// measured on generated modules of a thousand functions (`fuzz`, `bench`).
#[cfg(feature = "std")]
const MOVE_NS_PER_OP: f64 = 300.0;

impl Body<'_> {
    /// How many ops `op` holds, itself included.
    pub fn op_count(&self, op: OpId) -> usize {
        1 + self[op].regions.iter().flat_map(|r| &self[*r].blocks).flat_map(|b| &self[*b].ops).map(|o| self.op_count(*o)).sum::<usize>()
    }

    /// The ops directly inside `op`'s regions, in order.
    pub fn children(&self, op: OpId) -> Vec<OpId> {
        self[op].regions.iter().flat_map(|r| &self[*r].blocks).flat_map(|b| self[*b].ops.iter().copied()).collect()
    }
}

// The passes a pipeline can name, with the op each is anchored on (`Passes.td`'s
// `Pass<"name", "op">`). Nothing is global: a [`PassRegistry`] is handed to whoever parses a
// pipeline; [`Passes`] is the default one, filled by registration functions cascaded with [`Passes::with`]
// (`Passes::upstream()`: every pass compiled in, `src/registry.gen.rs`).

/// A registered pass.
pub struct PassInfo {
    pub name: &'static str,
    /// The op it runs on; `None`: any op.
    pub anchor: Option<&'static str>,
    pub make: fn(&Options<'_>) -> Result<Box<dyn Pass>, Error>,
}

/// ⭐ What a pipeline can name.
pub trait PassRegistry {
    /// The pass named `name`, if registered.
    fn pass(&self, name: &str) -> Option<&PassInfo>;
}

/// The default [`PassRegistry`]: passes by name.
#[derive(Default)]
pub struct Passes {
    by_name: BTreeMap<&'static str, PassInfo>,
}

impl Passes {
    /// Knows no pass.
    pub fn new() -> Self {
        Self::default()
    }

    /// Registers pass `T` under its `#[pass]` name and anchor.
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

    /// Registers what `add` registers, cascading: `Passes::new().with(Passes::add_upstream).with(my_passes)`.
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

// ============================================================================================
// ⭐ Running passes in parallel, as MLIR's `OpToOpPassAdaptor` over a thread pool: the ops a nested
// pipeline runs on that are `IsolatedFromAbove` (functions) are independent, so each is moved into
// a body of its own, run as a [`Task`] by an [`Executor`], and moved back in its place.
//
// ```text
// Task       one unit of work: a closure, run once, on any thread
// Executor   runs a batch of tasks to completion: moremath's `ThreadMulti` (a lock-free pool;
// calls nest, so a nested pipeline's tasks split further), or any other, as an `Exec`
// ```
//
// ```text
// calibrate  the first ops' pipelines run in place, timed; the rest go to the threads only when
// running an op costs more than moving it out and back (`PassManager::calibrate`)
// split_off  in each task: the op copied out of the shared body (read only, in parallel)
// graft      after the batch: each body's arenas appended whole (`Body::absorb`, ids shifted),
// the op swapped into its old slot; nothing is looked up or copied op by op
// ```
//
// Results do not depend on the executor: a task only sees its own body, and bodies go back in
// their original order.

/// ⭐ A unit of work: run once, on whichever thread the executor picks.
pub type Task<'s> = Box<dyn FnOnce() + Send + 's>;

/// ⭐ The executor a pass is handed: whichever moremath [`Executor`](moremath::Executor) the
/// pipeline runs on ([`PassManager::run_on`] takes any), its type erased — a pass is a trait
/// object. It is an `Executor` itself, to hand on (mlirformat's `parse_in`, [`Body::run_local`]).
#[derive(Clone, Copy)]
pub struct Exec<'x>(&'x dyn Fork);

/// An executor behind a reference: its tasks boxed.
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

    /// Each task boxed, its output into a slot of its own.
    fn execute<'x, 't, E: moremath::Execute<'t>>(&'x self, tasks: Vec<E>) -> Vec<E::Output> {
        let mut out: Vec<Option<E::Output>> = tasks.iter().map(|_| None).collect();
        let boxed: Vec<Task<'_>> = out.iter_mut().zip(tasks).map(|(slot, t)| Box::new(move || *slot = Some(t.execute())) as Task<'_>).collect();
        self.0.run(boxed);
        out.into_iter().map(|o| o.expect("every task ran")).collect()
    }
}

/// What a `local` pass runs on one op ([`Body::run_local`]).
pub type LocalRun<'f> = dyn for<'x> Fn(&mut Body<'x>, OpId) -> Result<(), Error> + Sync + 'f;

impl<'a> Body<'a> {
    /// Whether `op` can be run on alone: `IsolatedFromAbove` (no value from outside used in it).
    pub fn isolated(&self, op: OpId) -> bool {
        self.has(op, Trait::IsIsolatedFromAbove)
    }

    /// `op` (isolated) moved into a body of its own, under a module carrying the discardable
    /// attributes of `op`'s ancestors (the nearest wins: what `DataLayout::closest` reads); the
    /// body and the op there.
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
        // In a seg of its own, as its entry 0: back in this body, it can be lent from then on.
        sub.home = sub.new_seg(crate::Seg::default());
        let moved = sub.transplant(self, op);
        sub.home = crate::Id::seg(sub.root);
        let block = sub.top_block(sub.root);
        sub.insert(moved, block, None);
        (sub, moved)
    }

    /// `op` (at `at` in its block) replaced by `from`'s `with`, moved over whole
    /// (`split_off`'s inverse): `from`'s arenas join this body's, nothing is copied.
    pub fn graft(&mut self, op: OpId, at: usize, from: Body<'a>, with: OpId) {
        let new = with.shift(&self.absorb(from));
        self.detach(new);
        let results = self[new].results.clone();
        self.swap_in(op, at, new);
        // What `op` used and defined is now `new`'s.
        if !self[op].operands.is_empty() {
            self.set_operands(op, Vec::new());
        }
        if !results.is_empty() {
            for (r, w) in self[op].results.clone().into_iter().zip(&results) {
                self.replace_all_uses(r, *w);
            }
        }
    }

    /// A detached copy of `from`'s `op` (and everything in it) in this body. Operands are set once
    /// every value exists, so forward references (graph regions, successors) need no care.
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

    /// `from`'s `op` without its operands, its regions filled the same way; records what maps where.
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
                for o in &from[*b].ops {
                    let c = self.shell(from, *o, values, blocks, made);
                    self.insert(c, nb, None);
                }
            }
        }
        new
    }
}

// ============================================================================================
// ⭐ One `mlir-opt` command line: which passes, how the input is split, how the output prints.
//
// ```text
// mlirpass in.mlir -allow-unregistered-dialect -split-input-file -cse --convert-to-llvm="filter-dialects=arith" -o -
// ```
//
// Pass flags build the pipeline on the root `builtin.module`, nesting implicitly as `mlir-opt`
// does; `--pass-pipeline=` (or `-p`) gives it as text instead.

/// The marker `-split-input-file` splits on by default.
pub const SPLIT_MARKER: &str = "// -----";

pub struct Invocation {
    pub pipeline: PassManager,
    /// `-split-input-file[=marker]`.
    pub split: Option<String>,
    /// `-mlir-print-op-generic`.
    pub generic: bool,
    /// `-mlir-print-debuginfo`: locations are printed (else dropped).
    pub debuginfo: bool,
    /// `-mlir-print-local-scope`: no aliases.
    pub local_scope: bool,
    /// `-verify-diagnostics`: a chunk that expects an error may fail, and then prints nothing.
    pub verify_diagnostics: bool,
    pub input: Option<String>,
    pub output: Option<String>,
    /// Not `-mlir-disable-threading`: nested pipelines run on [`Invocation::pool`].
    pub threading: bool,
    /// Made once: sizing it asks the OS (cgroups, affinity), too slow to repeat per chunk.
    /// The threads (not `-mlir-disable-threading`): started the first time anything runs on them.
    #[cfg(feature = "std")]
    pub workers: std::sync::OnceLock<moremath::ThreadMulti>,
    /// `-mlir-disable-threading`: a pool of one, starting no thread.
    #[cfg(feature = "std")]
    pub one: moremath::ThreadMulti,
}

/// Flags that change nothing this crate does.
const IGNORED: &[&str] = &["allow-unregistered-dialect", "mlir-print-value-users", "mlir-print-elementsattrs-with-hex-if-larger", "mlir-elide-elementsattrs-if-larger", "mlir-print-unique-ssa-ids", "mlir-very-unsafe-disable-verifier-on-parsing", "mlir-print-assume-verified", "mlir-print-skip-regions"];

impl Invocation {
    /// The `mlir-opt` arguments `args`, the passes named from `reg`.
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
        // After the flags: `--pass-pipeline` may come after it and replace the manager.
        inv.pipeline.set_verify_each(verify_each);
        Ok(inv)
    }
}

impl Invocation {
    /// The input's chunks: split on the marker lines when `-split-input-file`, else whole.
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

    /// Lines with their offsets, line ends included.
    fn lines(src: &str) -> impl Iterator<Item = (usize, &str)> {
        src.split_inclusive('\n').scan(0, |at, l| {
            let here = *at;
            *at += l.len();
            Some((here, l))
        })
    }

    /// ⭐ One chunk: parse, run the pipeline, and print as the flags say. `Ok("")`: the chunk
    /// failed as `-verify-diagnostics` expected it to.
    pub fn run_chunk(&self, ctx: Ctx<'_>, chunk: &str) -> Result<String, Error> {
        let mut body = self.read(ctx, chunk)?;
        let root = body.root;
        match self.pipeline.run_on(&mut body, root, &self.executor()) {
            Ok(()) => Ok(self.print(&mut body)),
            Err(_) if self.verify_diagnostics && chunk.contains("expected-error") => Ok(String::new()),
            Err(e) => Err(e),
        }
    }

    /// A chunk as a body: read and imported on [`Invocation::workers`] when threading and big enough.
    pub fn read<'a>(&self, ctx: Ctx<'a>, chunk: &'a str) -> Result<Body<'a>, Error> {
        #[cfg(feature = "std")]
        if self.threading && chunk.len() >= mlirformat::MlirOpt::PARALLEL_BYTES {
            return Body::parse_in(ctx, chunk, self.threads());
        }
        Body::parse(ctx, chunk)
    }

    /// What runs nested pipelines: a thread pool unless threading is off (or there is no `std`).
    pub fn executor(&self) -> crate::Exec<'_> {
        #[cfg(feature = "std")]
        return crate::Exec::from(if self.threading { self.threads() } else { &self.one });
        #[cfg(not(feature = "std"))]
        crate::Exec::from(&moremath::ThreadSingle)
    }

    /// [`Invocation::workers`], started if they are not yet.
    #[cfg(feature = "std")]
    fn threads(&self) -> &moremath::ThreadMulti {
        self.workers.get_or_init(moremath::ThreadMulti::default)
    }

    /// The body as `mlir-opt` prints it under these flags.
    pub fn print(&self, body: &mut Body<'_>) -> String {
        let mut text = self.print_op(body);
        // `printTopLevelOperation` ends the op with a newline of its own; a local scope prints
        // the op alone.
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
        // Aliases are inlined on import; keep only those raw dialect text still names (looked
        // for before any alias is made again).
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

    /// `body` shown with or without aliases, its functions printed on [`Invocation::workers`]
    /// when threading and the body is big enough.
    fn show(&self, body: &Body<'_>, local_scope: bool, keep: impl Fn(&Item<'_>) -> bool) -> String {
        let opt = body.ctx.opt;
        #[cfg(feature = "std")]
        if let Some(x) = self.workers(body) {
            return if local_scope { body.show_local_scope_in(opt, self.generic, keep, x) } else { body.show_in(opt, self.generic, keep, x) };
        }
        if local_scope { body.show_local_scope(opt, self.generic, keep) } else { body.show(opt, self.generic, keep) }
    }

    /// The threads to print `body` on: when threading and `body` is big enough.
    #[cfg(feature = "std")]
    fn workers(&self, body: &Body<'_>) -> Option<&moremath::ThreadMulti> {
        (self.threading && body.ops_count() >= Self::PARALLEL_OPS).then(|| self.threads())
    }

    #[cfg(not(feature = "std"))]
    fn workers(&self, _: &Body<'_>) -> Option<&moremath::ThreadSingle> {
        None
    }

    /// A body with fewer ops than this prints on one thread.
    #[cfg(feature = "std")]
    const PARALLEL_OPS: usize = 1 << 14;

    /// The whole input, chunk by chunk, joined as `mlir-opt` joins them.
    pub fn run(&self, ctx: Ctx<'_>, src: &str) -> Result<String, Error> {
        let outs = self.chunks(src).into_iter().map(|c| self.run_chunk(ctx, c)).collect::<Result<Vec<_>, _>>()?;
        Ok(outs.join(&format!("{SPLIT_MARKER}\n")))
    }
}

impl crate::Interfaces<'_> {
    /// The op interfaces of every dialect this crate describes (none without a dialect feature).
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

// ============================================================================================
// ⭐ What `mlir-opt` verifies after each pass, as far as passes can break it: branch operand
// types (`BranchOpInterface`) and affine dimension / symbol identifiers (whose validity
// depends on the enclosing `AffineScope`, which a lowering may change).

impl Body<'_> {
    /// `BranchOpInterface`'s verifier over everything in `root`: forwarded operands have the
    /// types of their successor's arguments.
    pub fn verify_branches(&self, root: OpId) -> Result<(), mlirformat::Error> {
        let mut out = Ok(());
        self.walk(root, &mut |op| {
            if out.is_ok() {
                out = self.verify_branch_op(op);
            }
        });
        out
    }

    /// [`verify_branches`](Self::verify_branches) of `op` alone.
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

    /// The affine verifiers over everything in `root`.
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

    /// ⭐ The verifiers over everything in `root`.
    pub fn verify(&self, root: OpId) -> Result<(), Error> {
        self.verify_branches(root)?;
        self.verify_affines(root)
    }

    /// [`verify`](Self::verify) with `root`'s ops verified in parallel on `exec`, in runs: the
    /// error a serial walk finds first (every branch error before any affine one), the same.
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

    /// `verifyDimAndSymbolIdentifiers`.
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

    /// The affine ops' identifier checks (`verifyMemoryOpIndexing`, `AffineForOp::verify`,
    /// `AffineIfOp::verify`, `AffineApplyOp::verify`).
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
