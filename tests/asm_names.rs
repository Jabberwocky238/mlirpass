//! ⭐ The SSA names of the custom form: every fixture output `mlir-opt` printed in custom form
//! (`%c0`, `%cst`, `%extracted_slice`, `%in`, `%arg0`, `%3`), read into a body and printed back
//! custom, must come back with the same names. Only the chunks mlirformat prints back as they are
//! on their own count: what this checks is the naming, not the custom forms.

mod common;

use common::Fixtures;
use mlirpass::mlirformat::{Item, MlirOpt};
use mlirpass::{Body, Ctx, Interfaces};

#[test]
fn asm_names() {
    let (opt, interfaces) = (MlirOpt::upstream(), Interfaces::upstream());
    let ctx = Ctx::new(&opt, &interfaces);
    let (mut chunks, mut other, mut failed) = (0usize, 0usize, Vec::new());
    for run in Fixtures::runs() {
        let text = Fixtures::read(&run.stem, "out");
        for (i, chunk) in Fixtures::chunks(&text).into_iter().enumerate() {
            let Ok(m) = opt.parse(chunk) else { continue };
            if m.items.is_empty() || opt.show(&m).to_string().trim() != chunk.trim() {
                continue;
            }
            let Ok(body) = Body::import(ctx, &m) else { continue };
            chunks += 1;
            // The input's aliases are inlined: printing makes them again.
            let named = body.show(&opt, false, |i| !matches!(i, Item::AttrAlias { .. } | Item::TypeAlias { .. }));
            // An op printed in another form is not a naming matter.
            if Fixtures::anon(named.trim()) != Fixtures::anon(chunk.trim()) {
                other += 1;
                if std::env::var_os("SHOW").is_some() {
                    let line = chunk.lines().zip(named.lines()).find(|(a, b)| Fixtures::anon(a) != Fixtures::anon(b)).map(|(a, b)| format!("\n  - {}\n  + {}", a.trim(), b.trim())).unwrap_or_default();
                    eprintln!("  form {}.out #{i}{line}", run.stem);
                }
                continue;
            }
            if named.trim() != chunk.trim() {
                let line = chunk.lines().zip(named.lines()).find(|(a, b)| a != b).map(|(a, b)| format!("\n  - {}\n  + {}", a.trim(), b.trim())).unwrap_or_default();
                failed.push(format!("{}.out #{i}{line}", run.stem));
            }
        }
    }
    eprintln!("asm_names: {chunks} chunks, {other} printed in another form, {} named differently", failed.len());
    for f in failed.iter().take(40) {
        eprintln!("  {f}");
    }
    assert!(failed.is_empty());
}
