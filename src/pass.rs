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

mod registry;

use alloc::boxed::Box;
use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;
use core::fmt;

use mlirformat::Error;

use crate::{Body, OpId};

pub use registry::{PassInfo, PassRegistry, PassSet, Passes};

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
        self.get(key).map(|v| v.split(',').map(str::trim).filter(|s| !s.is_empty()).collect()).unwrap_or_default()
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
}

impl PassManager {
    /// A manager for ops named `anchor` (`"any"`: every op).
    pub fn on(anchor: &str) -> Self {
        Self { anchor: (anchor != "any").then(|| anchor.into()), entries: Vec::new() }
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
        self.run_on(body, op, &crate::Serial)
    }

    /// ⭐ Runs the pipeline on `op`; a nested pipeline's ops, when they are all isolated from
    /// above, each in a body of its own, as `exec`'s tasks (nested deeper: serially).
    pub fn run_on(&self, body: &mut Body<'_>, op: OpId, exec: &dyn crate::Executor) -> Result<(), Error> {
        if let Some(anchor) = &self.anchor
            && body[op].name != **anchor
        {
            return Err(Error(format!("can't run '{anchor}' pass manager on '{}' op", body[op].name)));
        }
        for e in &self.entries {
            match e {
                Entry::Pass(p) => {
                    p.run(body, op)?;
                    body.verify_branches(op)?;
                }
                Entry::Adaptor(mgrs) => {
                    let work: Vec<(OpId, &PassManager)> = body
                        .children(op)
                        .into_iter()
                        .filter_map(|c| {
                            let name = &body[c].name;
                            mgrs.iter().find(|m| m.anchor.as_deref() == Some(&**name)).or_else(|| mgrs.iter().find(|m| m.anchor.is_none())).map(|m| (c, m))
                        })
                        .collect();
                    if exec.width() < 2 || work.len() < 2 || !work.iter().all(|(c, _)| body.isolated(*c)) {
                        for (c, m) in work {
                            m.run_on(body, c, exec)?;
                        }
                        continue;
                    }
                    let mut subs: Vec<_> = work.iter().map(|(c, _)| body.split_off(*c)).collect();
                    let mut results: Vec<Result<(), Error>> = work.iter().map(|_| Ok(())).collect();
                    let tasks = subs.iter_mut().zip(&work).zip(results.iter_mut()).map(|(((sub, at), (_, m)), r)| Box::new(move || *r = m.run_on(sub, *at, &crate::Serial)) as crate::Task<'_>).collect();
                    exec.execute(tasks);
                    results.into_iter().collect::<Result<(), Error>>()?;
                    for ((c, _), (sub, at)) in work.iter().zip(&subs) {
                        body.graft(*c, sub, *at);
                    }
                }
            }
        }
        Ok(())
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

impl Body<'_> {
    /// The ops directly inside `op`'s regions, in order.
    pub fn children(&self, op: OpId) -> Vec<OpId> {
        self[op].regions.iter().flat_map(|r| &self[*r].blocks).flat_map(|b| self[*b].ops.iter().copied()).collect()
    }
}
