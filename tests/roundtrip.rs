//! ⭐ `Module → Body → Module` over every generic fixture (the inputs as mlir-opt reads them, and
//! what it prints after the passes): the IR must come back unchanged but for SSA names, and a
//! second trip must change nothing at all. Printed generic, what mlir-opt printed comes back with
//! its SSA names and its aliases too.

mod common;

use common::Fixtures;
use mlirpass::{Body, Ctx, Interfaces};
use mlirpass::mlirformat::{Attribute, Item, MlirOpt};

/// An alias definition: inlined on import, made again when printing.
fn is_alias(i: &Item<'_>) -> bool {
    matches!(i, Item::AttrAlias { .. } | Item::TypeAlias { .. })
}

/// Text → body → text, generic.
fn trip(ctx: Ctx<'_>, src: &str) -> Result<(String, bool), String> {
    let m = ctx.opt.parse(src).map_err(|e| format!("mlirformat: {e}"))?;
    let aliased = m.items.iter().any(is_alias);
    let body = Body::import(ctx, m).map_err(|e| format!("import: {e}"))?;
    Ok((body.show_local_scope(ctx.opt, true, |i| !is_alias(i)), aliased))
}

#[test]
fn roundtrip() {
    let (opt, interfaces) = (MlirOpt::new(), Interfaces::new());
    let ctx = Ctx::new(&opt, &interfaces);
    let (mut chunks, mut failed) = (0usize, Vec::new());
    for run in Fixtures::runs() {
        for kind in ["in", "generic"] {
            let text = Fixtures::read(&run.stem, kind);
            for (i, chunk) in Fixtures::chunks(&text).into_iter().enumerate() {
                // A chunk mlir-opt printed nothing for (it failed, as the test expects).
                if opt.parse(chunk).is_ok_and(|m| m.items.is_empty()) {
                    continue;
                }
                chunks += 1;
                let at = format!("{}.{kind} #{i}", run.stem);
                let verdict = trip(ctx, chunk).and_then(|(once, aliased)| {
                    let (twice, _) = trip(ctx, &once)?;
                    if twice != once {
                        return Err("second trip changed the text".into());
                    }
                    let direct = opt.show(&opt.parse(chunk).unwrap()).to_string();
                    // With aliases inlined, only the second trip can be compared exactly.
                    if !aliased && Fixtures::anon(&direct) != Fixtures::anon(&once) {
                        let line = Fixtures::anon(&direct).lines().zip(Fixtures::anon(&once).lines()).find(|(a, b)| a != b).map(|(a, b)| format!("\n  - {a}\n  + {b}")).unwrap_or_default();
                        return Err(format!("IR changed{line}"));
                    }
                    // Attribute aliases are made again, but locations' (not printed here).
                    let m = opt.parse(chunk).unwrap();
                    let builtin = m.items.iter().all(|i| match i {
                        Item::AttrAlias { value: Attribute::Builtin { name, .. }, .. } => &**name != "loc",
                        Item::AttrAlias { .. } => true,
                        i => !is_alias(i),
                    });
                    if kind == "generic" && builtin {
                        let body = Body::import(ctx, m).map_err(|e| format!("import: {e}"))?;
                        let named = match run.args.iter().any(|a| a.trim_start_matches('-') == "mlir-print-local-scope") {
                            true => body.show_local_scope(&opt, true, |i| !is_alias(i)),
                            false => body.show(&opt, true, |i| !is_alias(i)),
                        };
                        if named.trim() != direct.trim() {
                            let line = direct.lines().zip(named.lines()).find(|(a, b)| a != b).map(|(a, b)| format!("\n  - {a}\n  + {b}")).unwrap_or_default();
                            return Err(format!("names differ{line}"));
                        }
                    }
                    Ok(())
                });
                if let Err(e) = verdict {
                    failed.push(format!("{at}: {e}"));
                }
            }
        }
    }
    eprintln!("roundtrip: {chunks} chunks, {} failed", failed.len());
    for f in failed.iter().take(60) {
        eprintln!("  {f}");
    }
    assert!(failed.is_empty());
}
