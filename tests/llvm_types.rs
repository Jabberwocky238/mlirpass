//! Every LLVM dialect type `mlir-opt` 22.1.8 printed in the fixtures reads back into an
//! `LlvmType` and prints the same.

mod common;

use std::collections::BTreeSet;

use common::Fixtures;
use mlirpass::mlirformat::llvm_types::LlvmType;
use mlirpass::mlirformat::{MlirOpt, Parser, Type};

#[test]
fn llvm_types_print_as_mlir_opt() {
    let opt = MlirOpt::new();
    let mut seen = BTreeSet::new();
    let mut bad = Vec::new();
    for run in Fixtures::runs() {
        let text = Fixtures::read(&run.stem, "generic");
        for (at, _) in text.match_indices("!llvm.") {
            let mut p = Parser::new(&text[at..], &opt);
            let Ok(ty) = p.ty() else { continue };
            let src = &text[at..at + p.pos()];
            if !seen.insert(src.to_owned()) {
                continue;
            }
            match LlvmType::try_from(&ty) {
                Ok(l) => {
                    let back = format!("{}", Type::from(l));
                    if back != src {
                        bad.push(format!("{src} prints {back}"));
                    }
                }
                Err(()) => bad.push(format!("{src} does not read")),
            }
        }
    }
    eprintln!("{} distinct llvm types, {} differ", seen.len(), bad.len());
    for b in bad.iter().take(20) {
        eprintln!("  {b}");
    }
    assert!(bad.is_empty());
}
