use std::io::Write;
use std::panic::{AssertUnwindSafe, catch_unwind};
use std::process::{Command, Stdio};
use std::time::{Duration, Instant};

use mlirpass::mlirformat::MlirOpt;
use mlirpass::{Body, Ctx, Interfaces, Invocation, Passes};

#[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
pub enum Verdict {
    Exact,
    Mismatch,
    Error,
    Panic,
    Invalid,
    Extra,
}

impl Verdict {
    pub const ALL: [Verdict; 6] = [Verdict::Exact, Verdict::Mismatch, Verdict::Error, Verdict::Panic, Verdict::Invalid, Verdict::Extra];

    pub fn name(self) -> &'static str {
        match self {
            Verdict::Exact => "exact",
            Verdict::Mismatch => "mismatch",
            Verdict::Error => "error",
            Verdict::Panic => "panic",
            Verdict::Invalid => "invalid",
            Verdict::Extra => "extra",
        }
    }
}

pub struct Outcome {
    pub verdict: Verdict,
    pub detail: String,
}

pub struct MlirOptTool {
    pub path: String,
}

impl Default for MlirOptTool {
    fn default() -> Self {
        Self { path: std::env::var("MLIR_OPT").unwrap_or_else(|_| "mlir-opt".into()) }
    }
}

impl MlirOptTool {
    pub fn run(&self, src: &str, pipeline: &str, extra: &[&str]) -> (Result<String, String>, Duration) {
        let t = Instant::now();
        let mut child = match Command::new(&self.path).args(["-p", pipeline, "--mlir-print-op-generic"]).args(extra).stdin(Stdio::piped()).stdout(Stdio::piped()).stderr(Stdio::piped()).spawn() {
            Ok(c) => c,
            Err(e) => return (Err(format!("cannot run `{}`: {e}", self.path)), t.elapsed()),
        };
        let mut stdin = child.stdin.take().expect("piped");
        let out = std::thread::scope(|s| {
            s.spawn(move || stdin.write_all(src.as_bytes()));
            child.wait_with_output()
        });
        let took = t.elapsed();
        match out {
            Ok(o) if o.status.success() => (Ok(String::from_utf8_lossy(&o.stdout).into_owned()), took),
            Ok(o) => (Err(String::from_utf8_lossy(&o.stderr).lines().next().unwrap_or("failed").into()), took),
            Err(e) => (Err(e.to_string()), took),
        }
    }
}

pub struct Mlirpass {
    pub opt: MlirOpt,
    pub interfaces: Interfaces<'static>,
    pub passes: Passes,
}

impl Default for Mlirpass {
    fn default() -> Self {
        Self { opt: MlirOpt::upstream(), interfaces: Interfaces::upstream(), passes: Passes::upstream() }
    }
}

impl Mlirpass {
    pub fn ctx(&self) -> Ctx<'_> {
        Ctx::new(&self.opt, &self.interfaces)
    }

    pub fn invocation(&self, pipeline: &str, threading: bool) -> Result<Invocation, String> {
        let mut inv = Invocation::parse(&self.passes, &["-p", pipeline]).map_err(|e| e.0)?;
        inv.generic = true;
        inv.threading = threading;
        Ok(inv)
    }

    pub fn run(&self, inv: &Invocation, src: &str) -> Result<String, (bool, String)> {
        match catch_unwind(AssertUnwindSafe(|| inv.run_chunk(self.ctx(), src))) {
            Ok(Ok(out)) => Ok(out),
            Ok(Err(e)) => Err((false, e.0)),
            Err(p) => Err((true, p.downcast_ref::<String>().cloned().or_else(|| p.downcast_ref::<&str>().map(|s| (*s).into())).unwrap_or_else(|| "panic".into()))),
        }
    }

    pub fn normalize(&self, inv: &Invocation, text: &str) -> Result<String, String> {
        catch_unwind(AssertUnwindSafe(|| Body::parse(self.ctx(), text).map(|mut b| inv.print(&mut b)).map_err(|e| e.0))).unwrap_or_else(|_| Err("panic reading mlir-opt's output".into()))
    }

    pub fn judge(&self, tool: &MlirOptTool, src: &str, pipeline: &str) -> Outcome {
        let outcome = |verdict, detail: String| Outcome { verdict, detail };
        let inv = match self.invocation(pipeline, false) {
            Ok(inv) => inv,
            Err(e) => return outcome(Verdict::Error, format!("pipeline: {e}")),
        };
        let (want, _) = tool.run(src, pipeline, &[]);
        let got = self.run(&inv, src);
        if let (Ok(serial), Ok(threaded)) = (&got, self.invocation(pipeline, true).map(|t| self.run(&t, src))) {
            match threaded {
                Ok(t) if t == *serial => {}
                Ok(t) => return outcome(Verdict::Mismatch, format!("threaded differs from serial:\n{}", Self::first_diff(serial, &t))),
                Err((_, e)) => return outcome(Verdict::Error, format!("threaded failed where serial did not: {e}")),
            }
        }
        match (want, got) {
            (Err(e), Err(_)) => outcome(Verdict::Invalid, e),
            (Err(e), Ok(_)) => outcome(Verdict::Extra, e),
            (Ok(_), Err((true, e))) => outcome(Verdict::Panic, e),
            (Ok(_), Err((false, e))) => outcome(Verdict::Error, e),
            (Ok(want), Ok(got)) => match self.normalize(&inv, &want) {
                Ok(want) if want == got => outcome(Verdict::Exact, String::new()),
                Ok(want) => outcome(Verdict::Mismatch, Self::first_diff(&want, &got)),
                Err(e) => outcome(Verdict::Error, format!("reading mlir-opt's output: {e}")),
            },
        }
    }

    pub fn first_diff(want: &str, got: &str) -> String {
        want.lines()
            .zip(got.lines())
            .find(|(a, b)| a != b)
            .map(|(a, b)| format!("mlir-opt: {}\nmlirpass: {}", a.trim(), b.trim()))
            .unwrap_or_else(|| format!("one is a prefix of the other ({} vs {} lines)", want.lines().count(), got.lines().count()))
    }
}
