//! ⭐ Every fixture RUN line through mlirpass, chunk by chunk, against what `mlir-opt` 22.1.8
//! printed for it. Both sides go through `Body` and print generic, so only the IR is compared:
//!
//! ```text
//! exact        the same IR (or both failed, where -verify-diagnostics expected it)
//! mismatch     different IR
//! error        mlirpass failed where mlir-opt did not
//! unsupported  the pipeline names a pass mlirpass does not have
//! ```
//!
//! `--nocapture` prints the tally per test directory; `FILTER=<substring>` limits the runs and
//! `SHOW=1` prints each failure's first differing line (`SHOW=full`: both sides whole). `FLOOR` only ever goes up.

mod common;

use std::collections::BTreeMap;

use common::Fixtures;
use mlirpass::mlirformat::MlirOpt;
use mlirpass::{Body, Invocation};

/// Chunks matching exactly; raise it whenever a change makes more match.
const FLOOR: usize = 849;

#[derive(Default, Clone, Copy)]
struct Tally {
    exact: usize,
    mismatch: usize,
    error: usize,
    unsupported: usize,
}

impl Tally {
    fn add(&mut self, o: &Tally) {
        self.exact += o.exact;
        self.mismatch += o.mismatch;
        self.error += o.error;
        self.unsupported += o.unsupported;
    }
}

/// `Conversion__ArithToLLVM__x` ⇒ `Conversion/ArithToLLVM`; `Transforms__cse` ⇒ `Transforms/cse`.
fn group(stem: &str) -> String {
    let parts: Vec<_> = stem.split("__").collect();
    match parts.as_slice() {
        ["Transforms", file, ..] => format!("Transforms/{}", file.split('.').next().unwrap()),
        [a, b, ..] => format!("{a}/{b}"),
        _ => stem.into(),
    }
}

/// The first line where two printings differ.
fn first_diff(a: &str, b: &str) -> String {
    a.lines().zip(b.lines()).find(|(x, y)| x != y).map(|(x, y)| format!("\n      mlir-opt: {}\n      mlirpass: {}", x.trim(), y.trim())).unwrap_or_else(|| "\n      (one is a prefix of the other)".into())
}

#[test]
fn passes() {
    let opt = MlirOpt::new();
    let filter = std::env::var("FILTER").ok();
    let show = std::env::var_os("SHOW").is_some();
    let full = std::env::var("SHOW").is_ok_and(|s| s == "full");
    let mut groups: BTreeMap<String, Tally> = BTreeMap::new();
    let mut unsupported: BTreeMap<String, usize> = BTreeMap::new();
    for run in Fixtures::runs() {
        if filter.as_deref().is_some_and(|f| !run.stem.contains(f)) {
            continue;
        }
        let input = Fixtures::read(&run.stem, "in");
        let expected = Fixtures::read(&run.stem, "generic");
        let t = groups.entry(group(&run.stem)).or_default();
        let mut inv = match Invocation::try_from(run.args.as_slice()) {
            Ok(inv) => inv,
            Err(e) => {
                let n = Invocation { split: Some("// -----".into()), ..Invocation::try_from(&[] as &[&str]).unwrap() }.chunks(&input).len();
                t.unsupported += n;
                *unsupported.entry(e.0).or_default() += n;
                continue;
            }
        };
        inv.generic = true;
        let (ins, outs) = (inv.chunks(&input), inv.chunks(&expected));
        assert_eq!(ins.len(), outs.len(), "{}: chunk counts differ", run.stem);
        for (i, (chunk, want)) in ins.into_iter().zip(outs).enumerate() {
            let want = if want.trim().is_empty() { String::new() } else { inv.print(&opt, &mut Body::parse(&opt, want).unwrap()) };
            match inv.run_chunk(&opt, chunk) {
                Ok(got) if got == want => t.exact += 1,
                Err(_) if want.is_empty() => t.exact += 1,
                Ok(got) => {
                    t.mismatch += 1;
                    if show {
                        eprintln!("  mismatch {} #{i}:{}", run.stem, first_diff(&want, &got));
                        if full {
                            eprintln!("--- mlir-opt\n{want}--- mlirpass\n{got}---");
                        }
                    }
                }
                Err(e) => {
                    t.error += 1;
                    if show {
                        eprintln!("  error {} #{i}: {e}", run.stem);
                    }
                }
            }
        }
    }
    let mut total = Tally::default();
    eprintln!("{:<44} {:>6} {:>8} {:>6} {:>11}", "", "exact", "mismatch", "error", "unsupported");
    for (g, t) in &groups {
        total.add(t);
        if t.exact + t.mismatch + t.error > 0 {
            eprintln!("{g:<44} {:>6} {:>8} {:>6} {:>11}", t.exact, t.mismatch, t.error, t.unsupported);
        }
    }
    eprintln!("{:<44} {:>6} {:>8} {:>6} {:>11}", "total", total.exact, total.mismatch, total.error, total.unsupported);
    let mut missing: Vec<_> = unsupported.into_iter().collect();
    missing.sort_by(|a, b| b.1.cmp(&a.1));
    eprintln!("most wanted: {}", missing.iter().take(12).map(|(e, n)| format!("{e} ({n})")).collect::<Vec<_>>().join(", "));
    assert!(total.exact >= FLOOR, "exact {} fell below the floor {FLOOR}", total.exact);
}
