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
            let Ok(body) = Body::import(ctx, m) else { continue };
            chunks += 1;
            let named = body.show(&opt, false, |i| !matches!(i, Item::AttrAlias { .. } | Item::TypeAlias { .. }));
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
