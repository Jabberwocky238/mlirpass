//! ⭐ `mlirpass-fuzz`: random valid MLIR through mlirpass and `mlir-opt` 22.1.8 side by side.
//!
//! ```text
//! gen    --seed N [shape]                       print one generated module
//! diff   [--seeds A..B] [-p PIPELINE]... [shape] [--out DIR] [--jobs N] [--raw yes]
//!                                               each seed's module through every pipeline on both
//!                                               tools; a tally per pipeline, every non-exact case
//!                                               saved under DIR/<verdict>/; both read the module
//!                                               as mlir-opt prints it back, as the fixtures do
//!                                               (`--raw yes`: as generated, to test reading too)
//! bench  [--seed N] [-p PIPELINE]... [shape] [--reps N] [--raw yes]
//!                                               one big module: mlirpass (parse / run / print,
//!                                               serial and threaded) against mlir-opt (both ways)
//! shape: --funcs N --ops N --depth N
//! ```
//!
//! `mlir-opt` is `$MLIR_OPT`, else the one on `PATH`.

mod bench;
mod irgen;
mod oracle;
mod rng;

use std::collections::BTreeMap;
use std::sync::Mutex;
use std::sync::atomic::{AtomicUsize, Ordering};

use irgen::{Gen, Shape};
use oracle::{Mlirpass, MlirOptTool, Verdict};
use rng::Rng;

/// What `diff` and `bench` run when no `-p` is given.
const PIPELINES: &[&str] = &[
    "builtin.module(func.func(canonicalize))",
    "builtin.module(func.func(cse))",
    "builtin.module(func.func(canonicalize,cse))",
    "builtin.module(sccp)",
    "builtin.module(func.func(loop-invariant-code-motion))",
    "builtin.module(func.func(mem2reg))",
    "builtin.module(convert-scf-to-cf)",
    "builtin.module(remove-dead-values)",
    "builtin.module(convert-scf-to-cf,convert-to-llvm,reconcile-unrealized-casts)",
];

/// The command line: `--key value` pairs (a key may repeat), in order.
struct Args(Vec<(String, String)>);

impl Args {
    fn parse(args: &[String]) -> Result<Self, String> {
        let mut out = Vec::new();
        let mut it = args.iter();
        while let Some(a) = it.next() {
            let key = a.strip_prefix("--").or_else(|| a.strip_prefix('-')).ok_or_else(|| format!("unexpected `{a}`"))?;
            let value = it.next().ok_or_else(|| format!("`{a}` needs a value"))?;
            out.push((key.into(), value.clone()));
        }
        Ok(Self(out))
    }

    fn all(&self, key: &str) -> Vec<&str> {
        self.0.iter().filter(|(k, _)| k == key).map(|(_, v)| v.as_str()).collect()
    }

    fn get<T: std::str::FromStr>(&self, key: &str, default: T) -> Result<T, String> {
        match self.all(key).last() {
            Some(v) => v.parse().map_err(|_| format!("bad `--{key} {v}`")),
            None => Ok(default),
        }
    }

    fn shape(&self) -> Result<Shape, String> {
        let d = Shape::default();
        Ok(Shape { funcs: self.get("funcs", d.funcs)?, ops: self.get("ops", d.ops)?, depth: self.get("depth", d.depth)? })
    }

    fn pipelines(&self) -> Vec<&str> {
        let given = [self.all("p"), self.all("pipeline")].concat();
        if given.is_empty() { PIPELINES.to_vec() } else { given }
    }

    /// `A..B`.
    fn seeds(&self) -> Result<core::ops::Range<u64>, String> {
        let s = self.get("seeds", String::from("0..200"))?;
        let (a, b) = s.split_once("..").ok_or_else(|| format!("`--seeds {s}`: want A..B"))?;
        Ok(a.parse().map_err(|_| "bad seed")?..b.parse().map_err(|_| "bad seed")?)
    }
}

/// One saved case: a module, the pipeline, what went wrong.
struct Case {
    seed: u64,
    pipeline: String,
    verdict: Verdict,
    detail: String,
}

impl Case {
    /// `DIR/<verdict>/<seed>-<pipeline>.mlir`, the source with the case in a comment on top.
    fn save(&self, dir: &str, src: &str) -> std::io::Result<String> {
        let sub = format!("{dir}/{}", self.verdict.name());
        std::fs::create_dir_all(&sub)?;
        let slug: String = self.pipeline.trim_start_matches("builtin.module(").chars().map(|c| if c.is_ascii_alphanumeric() { c } else { '_' }).collect();
        let path = format!("{sub}/{:06}-{}.mlir", self.seed, slug.trim_end_matches('_'));
        let detail: String = self.detail.lines().map(|l| format!("//   {l}\n")).collect();
        std::fs::write(&path, format!("// seed {}\n// mlir-opt -p '{}' --mlir-print-op-generic\n// {}:\n{detail}{src}", self.seed, self.pipeline, self.verdict.name()))?;
        Ok(path)
    }
}

/// ⭐ `diff`: every seed through every pipeline, on as many threads as asked.
fn diff(args: &Args) -> Result<(), String> {
    let (shape, pipelines, seeds) = (args.shape()?, args.pipelines(), args.seeds()?);
    let out = args.get("out", String::from(concat!(env!("CARGO_MANIFEST_DIR"), "/out")))?;
    let raw_text = args.get("raw", String::from("no"))? == "yes";
    let jobs = args.get("jobs", std::thread::available_parallelism().map_or(1, |n| n.get()))?;
    let (pass, tool) = (Mlirpass::default(), MlirOptTool::default());
    // Panics are verdicts here, reported with their message: not printed as they happen.
    std::panic::set_hook(Box::new(|_| {}));
    let next = AtomicUsize::new(0);
    let found: Mutex<Vec<Case>> = Mutex::new(Vec::new());
    let tally: Mutex<BTreeMap<(usize, Verdict), usize>> = Mutex::new(BTreeMap::new());
    std::thread::scope(|s| {
        for _ in 0..jobs {
            s.spawn(|| {
                while let Some(seed) = Some(seeds.start + next.fetch_add(1, Ordering::Relaxed) as u64).filter(|s| seeds.contains(s)) {
                    let raw = Gen::new(&mut Rng::from(seed), shape).module();
                    // As the fixtures are: what mlir-opt reads it as (literals spelled its way),
                    // unless `--raw yes` asks for the text as generated.
                    let src = match raw_text {
                        true => Ok(raw.clone()),
                        false => tool.run(&raw, "builtin.module()", &[]).0,
                    };
                    let src = match src {
                        Ok(src) => src,
                        Err(e) => {
                            for (i, p) in pipelines.iter().enumerate() {
                                *tally.lock().unwrap().entry((i, Verdict::Invalid)).or_default() += 1;
                                let case = Case { seed, pipeline: (*p).into(), verdict: Verdict::Invalid, detail: e.clone() };
                                let _ = case.save(&out, &raw);
                            }
                            continue;
                        }
                    };
                    for (i, p) in pipelines.iter().enumerate() {
                        let o = pass.judge(&tool, &src, p);
                        *tally.lock().unwrap().entry((i, o.verdict)).or_default() += 1;
                        if o.verdict != Verdict::Exact {
                            let case = Case { seed, pipeline: (*p).into(), verdict: o.verdict, detail: o.detail };
                            let _ = case.save(&out, &src);
                            found.lock().unwrap().push(case);
                        }
                    }
                }
            });
        }
    });
    let tally = tally.into_inner().unwrap();
    print!("{:<72}", "");
    Verdict::ALL.iter().for_each(|v| print!(" {:>8}", v.name()));
    println!();
    for (i, p) in pipelines.iter().enumerate() {
        print!("{p:<72}");
        Verdict::ALL.iter().for_each(|v| print!(" {:>8}", tally.get(&(i, *v)).copied().unwrap_or(0)));
        println!();
    }
    let mut found = found.into_inner().unwrap();
    found.sort_by(|a, b| (a.verdict, a.seed, &a.pipeline).cmp(&(b.verdict, b.seed, &b.pipeline)));
    for c in found.iter().filter(|c| c.verdict != Verdict::Invalid).take(args.get("show", 12)?) {
        println!("\n{} seed {} {}:\n  {}", c.verdict.name(), c.seed, c.pipeline, c.detail.replace('\n', "\n  "));
    }
    if !found.is_empty() {
        println!("\n{} non-exact cases saved under {out}/", found.len());
    }
    Ok(())
}

fn run(args: &[String]) -> Result<(), String> {
    let (cmd, rest) = args.split_first().ok_or("usage: mlirpass-fuzz gen|diff|bench [options]")?;
    let a = Args::parse(rest)?;
    match cmd.as_str() {
        "gen" => Ok(print!("{}", Gen::new(&mut Rng::from(a.get("seed", 0u64)?), a.shape()?).module())),
        "diff" => diff(&a),
        "bench" => bench::Bench::from_args(&a)?.run(),
        other => Err(format!("unknown command `{other}`")),
    }
}

fn main() -> std::process::ExitCode {
    let args: Vec<String> = std::env::args().skip(1).collect();
    match run(&args) {
        Ok(()) => std::process::ExitCode::SUCCESS,
        Err(e) => {
            eprintln!("error: {e}");
            std::process::ExitCode::FAILURE
        }
    }
}
