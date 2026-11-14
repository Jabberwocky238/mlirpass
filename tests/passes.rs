mod common;

use std::collections::BTreeMap;

use common::Fixtures;
use mlirpass::mlirformat::MlirOpt;
use mlirpass::{Body, Ctx, Interfaces, Invocation, Passes};

const FLOOR: usize = 7616;

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

fn group(stem: &str) -> String {
    let parts: Vec<_> = stem.split("__").collect();
    match parts.as_slice() {
        ["Transforms", file, ..] => format!("Transforms/{}", file.split('.').next().unwrap()),
        [a, b, ..] => format!("{a}/{b}"),
        _ => stem.into(),
    }
}

fn first_diff(a: &str, b: &str) -> String {
    a.lines().zip(b.lines()).find(|(x, y)| x != y).map(|(x, y)| format!("\n      mlir-opt: {}\n      mlirpass: {}", x.trim(), y.trim())).unwrap_or_else(|| "\n      (one is a prefix of the other)".into())
}

#[test]
fn passes() {
    let (opt, interfaces) = (MlirOpt::upstream(), Interfaces::upstream());
    let ctx = Ctx::new(&opt, &interfaces);
    let passes = Passes::upstream();
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
        let mut inv = match Invocation::parse(&passes, run.args.as_slice()) {
            Ok(inv) => inv,
            Err(e) => {
                let n = Invocation { split: Some("// -----".into()), ..Invocation::parse(&passes, &[] as &[&str]).unwrap() }.chunks(&input).len();
                t.unsupported += n;
                *unsupported.entry(e.0).or_default() += n;
                continue;
            }
        };
        inv.generic = true;
        inv.threading = std::env::var_os("SERIAL").is_none();
        let discard = run.args.windows(2).any(|w| w[0] == "-o" && w[1] == "/dev/null");
        let ins = inv.chunks(&input);
        let outs = if discard { vec![""; ins.len()] } else { inv.chunks(&expected) };
        assert_eq!(ins.len(), outs.len(), "{}: chunk counts differ", run.stem);
        for (i, (chunk, want)) in ins.into_iter().zip(outs).enumerate() {
            let want = if want.trim().is_empty() { String::new() } else { inv.print(&mut Body::parse(ctx, want).unwrap()) };
            let ran = std::panic::catch_unwind(std::panic::AssertUnwindSafe(|| inv.run_chunk(ctx, chunk)));
            let Ok(ran) = ran else {
                t.error += 1;
                eprintln!("  panic {} #{i}", run.stem);
                continue;
            };
            match ran {
                Ok(_) if discard => t.exact += 1,
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
    eprintln!("most wanted: {}", missing.iter().take(std::env::var("WANTED").ok().and_then(|n| n.parse().ok()).unwrap_or(12)).map(|(e, n)| format!("{e} ({n})")).collect::<Vec<_>>().join(", "));
    assert!(total.exact >= FLOOR, "exact {} fell below the floor {FLOOR}", total.exact);
}
