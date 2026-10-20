//! ⭐ One `mlir-opt` command line: which passes, how the input is split, how the output prints.
//!
//! ```text
//! mlirpass in.mlir -allow-unregistered-dialect -split-input-file -cse --convert-to-llvm="filter-dialects=arith" -o -
//! ```
//!
//! Pass flags build the pipeline on the root `builtin.module`, nesting implicitly as `mlir-opt`
//! does; `--pass-pipeline=` (or `-p`) gives it as text instead.

use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;

use mlirformat::{Error, Item, MlirOpt, Module};

use crate::{Body, PassManager};

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
    /// `-verify-diagnostics`: a chunk that expects an error may fail, and then prints nothing.
    pub verify_diagnostics: bool,
    pub input: Option<String>,
    pub output: Option<String>,
}

/// Flags that change nothing this crate does.
const IGNORED: &[&str] = &["allow-unregistered-dialect", "mlir-disable-threading", "verify-each", "mlir-print-local-scope", "mlir-print-value-users", "mlir-print-elementsattrs-with-hex-if-larger", "mlir-elide-elementsattrs-if-larger", "mlir-print-unique-ssa-ids", "mlir-very-unsafe-disable-verifier-on-parsing", "mlir-print-assume-verified", "mlir-print-skip-regions"];

impl Invocation {
    /// The `mlir-opt` arguments `args`, the passes named from `reg`.
    pub fn parse<S: AsRef<str>>(reg: &dyn crate::PassRegistry, args: &[S]) -> Result<Self, Error> {
        let mut inv = Invocation { pipeline: PassManager::on("builtin.module"), split: None, generic: false, debuginfo: false, verify_diagnostics: false, input: None, output: None };
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
                "verify-diagnostics" => inv.verify_diagnostics = true,
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
    pub fn run_chunk(&self, opt: &MlirOpt, chunk: &str) -> Result<String, Error> {
        let mut body = Body::parse(opt, chunk)?;
        let root = body.root;
        match self.pipeline.run(&mut body, root) {
            Ok(()) => Ok(self.print(opt, &mut body)),
            Err(_) if self.verify_diagnostics && chunk.contains("expected-error") => Ok(String::new()),
            Err(e) => Err(e),
        }
    }

    /// The body as `mlir-opt` prints it under these flags.
    pub fn print(&self, opt: &MlirOpt, body: &mut Body<'_>) -> String {
        if !self.debuginfo {
            body.set_locs(body.root, None);
        }
        let mut m = Module::from(&*body);
        if !self.debuginfo {
            m.items.retain(|i| !matches!(i, Item::AttrAlias { value: mlirformat::Attribute::Builtin { name, .. }, .. } if name == "loc"));
        }
        // Aliases are inlined on import; keep only those raw dialect text still names.
        let show = |m: &Module<'_>| if self.generic { format!("{}", MlirOpt::new().show(m)) } else { format!("{}", opt.show(m)) };
        let bare = Module { items: m.items.iter().filter(|i| !matches!(i, Item::AttrAlias { .. } | Item::TypeAlias { .. })).cloned().collect() };
        let text = show(&bare);
        let named = |sigil: char, name: &str| {
            let pat = format!("{sigil}{name}");
            text.match_indices(&pat).any(|(i, _)| !text[i + pat.len()..].starts_with(|c: char| c.is_ascii_alphanumeric() || "_$.-".contains(c)))
        };
        m.items.retain(|i| match i {
            Item::AttrAlias { name, .. } => named('#', name),
            Item::TypeAlias { name, .. } => named('!', name),
            _ => true,
        });
        show(&m)
    }

    /// The whole input, chunk by chunk, joined as `mlir-opt` joins them.
    pub fn run(&self, opt: &MlirOpt, src: &str) -> Result<String, Error> {
        let outs = self.chunks(src).into_iter().map(|c| self.run_chunk(opt, c)).collect::<Result<Vec<_>, _>>()?;
        Ok(outs.join(&format!("{SPLIT_MARKER}\n")))
    }
}
