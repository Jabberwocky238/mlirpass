//! ⭐ `Module → Body → Module` over every generic fixture (the inputs as mlir-opt reads them, and
//! what it prints after the passes): the IR must come back unchanged but for SSA names, and a
//! second trip must change nothing at all.

mod common;

use common::Fixtures;
use mlirpass::Body;
use mlirpass::mlirformat::{Item, MlirOpt, Module};

/// Text → body → text, generic.
fn trip(opt: &MlirOpt, src: &str) -> Result<(String, bool), String> {
    let m = opt.parse(src).map_err(|e| format!("mlirformat: {e}"))?;
    let aliased = m.items.iter().any(|i| matches!(i, Item::AttrAlias { .. } | Item::TypeAlias { .. }));
    let body = Body::try_from(&m).map_err(|e| format!("import: {e}"))?;
    Ok((opt.show(&Module::from(&body)).to_string(), aliased))
}

#[test]
fn roundtrip() {
    let opt = MlirOpt::new();
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
                let verdict = trip(&opt, chunk).and_then(|(once, aliased)| {
                    let (twice, _) = trip(&opt, &once)?;
                    if twice != once {
                        return Err("second trip changed the text".into());
                    }
                    let direct = opt.show(&opt.parse(chunk).unwrap()).to_string();
                    // With aliases inlined, only the second trip can be compared exactly.
                    if !aliased && Fixtures::anon(&direct) != Fixtures::anon(&once) {
                        let line = Fixtures::anon(&direct).lines().zip(Fixtures::anon(&once).lines()).find(|(a, b)| a != b).map(|(a, b)| format!("\n  - {a}\n  + {b}")).unwrap_or_default();
                        return Err(format!("IR changed{line}"));
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
