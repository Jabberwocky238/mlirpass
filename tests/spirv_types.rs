//! Every SPIR-V dialect type `mlir-opt` 22.1.8 printed in the fixtures reads back into a
//! `SpirvType` and prints the same.

mod common;

use std::collections::BTreeSet;
use std::fs;

use common::Fixtures;
use mlirpass::mlirformat::spirv_types::SpirvType;
use mlirpass::mlirformat::{MlirOpt, Parser, Type};

#[test]
fn spirv_types_print_as_mlir_opt() {
    let opt = MlirOpt::new();
    let mut seen = BTreeSet::new();
    let mut bad = Vec::new();
    for e in fs::read_dir(Fixtures::dir()).unwrap() {
        let path = e.unwrap().path();
        // What mlir-opt printed (not the upstream inputs, written by hand).
        let name = path.file_name().unwrap().to_string_lossy().into_owned();
        if ![".in.mlir", ".out.mlir", ".generic.mlir"].iter().any(|x| name.ends_with(x)) {
            continue;
        }
        let text = fs::read_to_string(&path).unwrap();
        for (at, _) in text.match_indices("!spirv.") {
            let mut p = Parser::new(&text[at..], &opt);
            let Ok(ty) = p.ty() else { continue };
            let src = &text[at..at + p.pos()];
            if !seen.insert(src.to_owned()) {
                continue;
            }
            match SpirvType::try_from(&ty) {
                Ok(s) => {
                    let back = format!("{}", Type::from(s));
                    if back != src {
                        bad.push(format!("{src} prints {back}"));
                    }
                }
                Err(()) => bad.push(format!("{src} does not read")),
            }
        }
    }
    eprintln!("{} distinct spirv types, {} differ", seen.len(), bad.len());
    for b in bad.iter().take(20) {
        eprintln!("  {b}");
    }
    assert!(bad.is_empty());
}
