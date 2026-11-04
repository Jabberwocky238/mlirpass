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

use mlirformat::{Error, Item};

use crate::{Body, Ctx, PassManager};

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
    /// Not `-mlir-disable-threading`: nested pipelines run on [`Invocation::pool`].
    pub threading: bool,
    /// Made once: sizing it asks the OS (cgroups, affinity), too slow to repeat per chunk.
    #[cfg(feature = "std")]
    pub pool: crate::ThreadPool,
}

/// Flags that change nothing this crate does.
const IGNORED: &[&str] = &["allow-unregistered-dialect", "verify-each", "mlir-print-local-scope", "mlir-print-value-users", "mlir-print-elementsattrs-with-hex-if-larger", "mlir-elide-elementsattrs-if-larger", "mlir-print-unique-ssa-ids", "mlir-very-unsafe-disable-verifier-on-parsing", "mlir-print-assume-verified", "mlir-print-skip-regions"];

impl Invocation {
    /// The `mlir-opt` arguments `args`, the passes named from `reg`.
    pub fn parse<S: AsRef<str>>(reg: &dyn crate::PassRegistry, args: &[S]) -> Result<Self, Error> {
        let mut inv = Invocation { pipeline: PassManager::on("builtin.module"), split: None, generic: false, debuginfo: false, verify_diagnostics: false, input: None, output: None, threading: true, #[cfg(feature = "std")] pool: crate::ThreadPool::default() };
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
                "mlir-disable-threading" => inv.threading = false,
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
    pub fn run_chunk(&self, ctx: Ctx<'_>, chunk: &str) -> Result<String, Error> {
        let mut body = Body::parse(ctx, chunk)?;
        let root = body.root;
        match self.pipeline.run_on(&mut body, root, self.executor()) {
            Ok(()) => Ok(self.print(&mut body)),
            Err(_) if self.verify_diagnostics && chunk.contains("expected-error") => Ok(String::new()),
            Err(e) => Err(e),
        }
    }

    /// What runs nested pipelines: a thread pool unless threading is off (or there is no `std`).
    pub fn executor(&self) -> &dyn crate::Executor {
        #[cfg(feature = "std")]
        if self.threading {
            return &self.pool;
        }
        &crate::Serial
    }

    /// The body as `mlir-opt` prints it under these flags.
    pub fn print(&self, body: &mut Body<'_>) -> String {
        let opt = body.ctx.opt;
        if !self.debuginfo {
            body.set_locs(body.root, None);
        }
        let loc = |i: &Item<'_>| matches!(i, Item::AttrAlias { value: mlirformat::Attribute::Builtin { name, .. }, .. } if name == "loc");
        let kept = |i: &Item<'_>| self.debuginfo || !loc(i);
        let alias = |i: &Item<'_>| matches!(i, Item::AttrAlias { .. } | Item::TypeAlias { .. });
        let show = |keep: &dyn Fn(&Item<'_>) -> bool| body.show(opt, self.generic, |i| kept(i) && keep(i));
        if !body.items.iter().any(|i| kept(i) && alias(i)) {
            return show(&|_| true);
        }
        // Aliases are inlined on import; keep only those raw dialect text still names.
        let text = show(&|i| !alias(i));
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

impl crate::Passes {
    /// Every pass this crate implements.
    pub fn upstream() -> Self {
        let mut p = Self::new();
        p.with::<crate::ConversionPasses>();
        #[cfg(feature = "dialect.affine")]
        p.with::<crate::AffinePasses>();
        #[cfg(all(feature = "dialect.arith", any(feature = "target.emitc", feature = "target.llvm", feature = "target.spirv")))]
        p.with::<crate::ArithPasses>();
        #[cfg(feature = "dialect.bufferization")]
        p.with::<crate::BufferizationPasses>();
        #[cfg(all(feature = "dialect.cf", any(feature = "target.llvm", feature = "target.spirv")))]
        p.with::<crate::CfPasses>();
        #[cfg(feature = "dialect.complex")]
        p.with::<crate::ComplexPasses>();
        #[cfg(feature = "target.emitc")]
        p.with::<crate::EmitcPasses>();
        #[cfg(all(feature = "dialect.func", any(feature = "target.emitc", feature = "target.llvm", feature = "target.spirv")))]
        p.with::<crate::FuncPasses>();
        #[cfg(feature = "dialect.gpu")]
        p.with::<crate::GpuPasses>();
        #[cfg(all(feature = "dialect.index", any(feature = "target.llvm", feature = "target.spirv")))]
        p.with::<crate::IndexPasses>();
        #[cfg(feature = "dialect.linalg")]
        p.with::<crate::LinalgPasses>();
        #[cfg(feature = "target.llvm")]
        p.with::<crate::LlvmPasses>();
        #[cfg(feature = "dialect.math")]
        p.with::<crate::MathPasses>();
        #[cfg(feature = "dialect.memref")]
        p.with::<crate::MemrefPasses>();
        #[cfg(feature = "dialect.scf")]
        p.with::<crate::ScfPasses>();
        #[cfg(feature = "dialect.shape")]
        p.with::<crate::ShapePasses>();
        #[cfg(feature = "target.spirv")]
        p.with::<crate::SpirvPasses>();
        #[cfg(feature = "dialect.tensor")]
        p.with::<crate::TensorPasses>();
        #[cfg(feature = "dialect.tosa")]
        p.with::<crate::TosaPasses>();
        p.with::<crate::TransformPasses>();
        #[cfg(all(feature = "dialect.ub", any(feature = "target.llvm", feature = "target.spirv")))]
        p.with::<crate::UbPasses>();
        #[cfg(feature = "dialect.vector")]
        p.with::<crate::VectorPasses>();
        #[cfg(all(feature = "dialect.xevm", feature = "target.llvm"))]
        p.with::<crate::XevmPasses>();
        p
    }
}
