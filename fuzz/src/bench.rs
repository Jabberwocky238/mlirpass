//! ⭐ `bench`: one big generated module through each pipeline, timed.
//!
//! Both tools read the module as mlir-opt prints it back (`--raw yes`: as generated).
//! mlirpass runs in process, phase by phase (parse, run, print), on one thread and on the thread
//! pool; mlir-opt runs as a process (its wall time: parse, run, print and start-up), with and
//! without `--mlir-disable-threading`. Each figure is the best of `--reps` runs, and the outputs
//! are checked: mlirpass serial against threaded, and against mlir-opt.

use std::time::{Duration, Instant};

use mlirpass::Body;

use crate::irgen::{Gen, Shape};
use crate::oracle::{Mlirpass, MlirOptTool};
use crate::rng::Rng;
use crate::Args;

/// Best-of times of mlirpass's phases.
#[derive(Clone, Copy)]
struct Phases {
    parse: Duration,
    run: Duration,
    print: Duration,
}

impl Phases {
    const NONE: Phases = Phases { parse: Duration::MAX, run: Duration::MAX, print: Duration::MAX };

    fn total(&self) -> Duration {
        self.parse + self.run + self.print
    }

    fn best(&mut self, o: Phases) {
        self.parse = self.parse.min(o.parse);
        self.run = self.run.min(o.run);
        self.print = self.print.min(o.print);
    }
}

pub struct Bench<'a> {
    shape: Shape,
    seed: u64,
    pipelines: Vec<&'a str>,
    reps: usize,
    /// The module as generated (custom form), not as mlir-opt prints it back.
    raw: bool,
}

/// Milliseconds, for the table.
struct Ms(Duration);

impl core::fmt::Display for Ms {
    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
        write!(f, "{:>9.1}", self.0.as_secs_f64() * 1e3)
    }
}

impl<'a> Bench<'a> {
    pub fn from_args(a: &'a Args) -> Result<Self, String> {
        let shape = Shape { funcs: a.get("funcs", 2000)?, ops: a.get("ops", 40)?, depth: a.get("depth", 2)? };
        Ok(Self { shape, seed: a.get("seed", 1)?, pipelines: a.pipelines(), reps: a.get("reps", 3)?, raw: a.get("raw", String::from("no"))? == "yes" })
    }

    /// One mlirpass run of `src`, phase by phase, and what it printed.
    fn once(pass: &Mlirpass, inv: &mlirpass::Invocation, src: &str) -> Result<(Phases, String), String> {
        let t = Instant::now();
        let mut body = Body::parse(pass.ctx(), src).map_err(|e| e.0)?;
        let parse = t.elapsed();
        let t = Instant::now();
        let root = body.root;
        inv.pipeline.run_on(&mut body, root, inv.executor()).map_err(|e| e.0)?;
        let run = t.elapsed();
        let t = Instant::now();
        let out = inv.print(&mut body);
        Ok((Phases { parse, run, print: t.elapsed() }, out))
    }

    /// Best of `reps` mlirpass runs, threaded or not.
    fn mlirpass(&self, pass: &Mlirpass, pipeline: &str, src: &str, threading: bool) -> Result<(Phases, String), String> {
        let inv = pass.invocation(pipeline, threading)?;
        let mut best = Phases::NONE;
        let mut out = String::new();
        for _ in 0..self.reps {
            let (p, o) = Self::once(pass, &inv, src)?;
            best.best(p);
            out = o;
        }
        Ok((best, out))
    }

    fn mlir_opt(&self, tool: &MlirOptTool, pipeline: &str, src: &str, extra: &[&str]) -> (Duration, Result<String, String>) {
        let mut best = Duration::MAX;
        let mut out = Err(String::new());
        for _ in 0..self.reps {
            let (o, t) = tool.run(src, pipeline, extra);
            best = best.min(t);
            out = o;
        }
        (best, out)
    }

    pub fn run(&self) -> Result<(), String> {
        let (pass, tool) = (Mlirpass::default(), MlirOptTool::default());
        let src = Gen::new(&mut Rng::from(self.seed), self.shape).module();
        // Both tools read the same text: as mlir-opt prints it back (generic), as `diff` does.
        let src = if self.raw { src } else { tool.run(&src, "builtin.module()", &[]).0? };
        let threads = std::thread::available_parallelism().map_or(1, |n| n.get());
        println!("module: seed {}, {} funcs, {} lines, {:.1} MB; {threads} threads; best of {}", self.seed, self.shape.funcs, src.lines().count(), src.len() as f64 / 1e6, self.reps);
        println!("{:<64} {:>9} {:>9} {:>9} {:>9} {:>9} {:>7} | {:>9} {:>9} {:>7}  same", "ms", "parse", "run 1t", "run Nt", "print", "total Nt", "run x", "opt 1t", "opt Nt", "opt x");
        for p in &self.pipelines {
            let (serial, s_out) = self.mlirpass(&pass, p, &src, false)?;
            let (threaded, t_out) = self.mlirpass(&pass, p, &src, true)?;
            if s_out != t_out {
                return Err(format!("{p}: threaded output differs from serial"));
            }
            let (opt1, _) = self.mlir_opt(&tool, p, &src, &["--mlir-disable-threading"]);
            let (optn, want) = self.mlir_opt(&tool, p, &src, &[]);
            let inv = pass.invocation(p, false)?;
            let same = match want.and_then(|w| pass.normalize(&inv, &w)) {
                Ok(w) if w == s_out => "yes",
                Ok(_) => "no",
                Err(_) => "error",
            };
            println!(
                "{p:<64} {} {} {} {} {} {:>6.2}x | {} {} {:>6.2}x  {same}",
                Ms(threaded.parse),
                Ms(serial.run),
                Ms(threaded.run),
                Ms(threaded.print),
                Ms(threaded.total()),
                serial.run.as_secs_f64() / threaded.run.as_secs_f64(),
                Ms(opt1),
                Ms(optn),
                opt1.as_secs_f64() / optn.as_secs_f64(),
            );
        }
        Ok(())
    }
}
