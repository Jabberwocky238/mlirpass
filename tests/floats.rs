//! Every float literal `mlir-opt` 22.1.8 printed in the fixtures reads back and prints the same:
//! `ApFloat::print` is `printFloatValue`.

mod common;

use std::collections::BTreeSet;

use common::Fixtures;
use mlirpass::ApFloat;
use mlirpass::mlirformat::FloatKind;

#[test]
fn floats_print_as_mlir_opt() {
    let kinds = [("f16", FloatKind::F16), ("bf16", FloatKind::BF16), ("f32", FloatKind::F32), ("f64", FloatKind::F64)];
    let mut seen = BTreeSet::new();
    let mut bad = Vec::new();
    for run in Fixtures::runs() {
        let text = Fixtures::read(&run.stem, "generic");
        for (at, _) in text.match_indices(" : ") {
            let before = &text[..at];
            let start = before.rfind(|c: char| !(c.is_ascii_alphanumeric() || matches!(c, '.' | '-' | '+'))).map_or(0, |i| i + 1);
            let lit = &before[start..];
            let after = &text[at + 3..];
            let Some((name, kind)) = kinds.iter().find(|(n, _)| after.starts_with(n) && !after[n.len()..].starts_with(|c: char| c.is_ascii_alphanumeric())) else { continue };
            let float = lit.contains('.') || lit.contains('e') || lit.starts_with("0x");
            if !float || lit.is_empty() || !seen.insert((lit.to_owned(), *name)) {
                continue;
            }
            match ApFloat::parse(*kind, lit) {
                Some(f) if f.print() == lit => {}
                Some(f) => bad.push(format!("{lit} : {name} prints {}", f.print())),
                None => bad.push(format!("{lit} : {name} does not parse")),
            }
        }
    }
    eprintln!("{} distinct float literals, {} differ", seen.len(), bad.len());
    for b in bad.iter().take(20) {
        eprintln!("  {b}");
    }
    assert!(bad.is_empty());
}
