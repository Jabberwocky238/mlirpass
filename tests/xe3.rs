//! The Xe3 target against its oracles: EU instructions as Mesa's assembler (gentool) encodes them, genxml items as
//! Mesa's C pack functions pack them.

use mlirformat::{Item, MlirOpt, Module, NamedAttr, Operation};
use mlirpass::{Body, Ctx, Inst, Interfaces, XE3, Xe3Dialect, Xe3Genxml};

/// tests/xe3/eu.mlir has each instruction as an `xe3.eu` op, the gentool assembly it is in a comment above it;
/// tests/xe3/eu.expected is what `gentool asm -p ptl` assembled that text into (scripts/xe3_eu_oracle.sh).
#[test]
fn eu_encodes_like_gentool() {
    let mut opt = MlirOpt::upstream();
    opt.load(Xe3Dialect);
    let module = opt.parse(include_str!("xe3/eu.mlir")).unwrap();
    let want: Vec<&str> = include_str!("xe3/eu.expected").lines().collect();
    let ops: Vec<_> = module.items.iter().filter_map(|i| if let Item::Op(op) = i { Some(op) } else { None }).collect();
    assert_eq!(ops.len(), want.len());
    let mut bad = Vec::new();
    for (op, want) in ops.iter().zip(want) {
        let inst = Inst::try_from((&*op.name, &op.attributes[..])).unwrap_or_else(|e| panic!("{e}"));
        let got = inst.encode().iter().map(|b| format!("{b:02x}")).collect::<Vec<_>>().join(" ");
        if got != want {
            bad.push(format!("{}\n  got  {got}\n  want {want}", opt.show(&Module { items: vec![Item::Op((*op).clone())] })));
        }
    }
    assert!(bad.is_empty(), "{} of {} differ from gentool:\n{}", bad.len(), ops.len(), bad.join("\n"));
}

/// Every genxml item packed from MLIR (tests/xe3/oracle.mlir: each field set to the value Mesa's C pack functions were
/// given) is what Mesa packed (tests/xe3/oracle.expected), dword for dword; reads as its typed op; and printed and
/// read again packs the same.
#[test]
fn genxml_packs_as_mesa() {
    let mut opt = MlirOpt::upstream();
    opt.load(Xe3Dialect);
    let interfaces = Interfaces::upstream();
    let body = Body::parse(Ctx::new(&opt, &interfaces), include_str!("xe3/oracle.mlir")).unwrap();
    let printed = opt.show(&Module::from(&body)).to_string();
    let again = Body::parse(Ctx::new(&opt, &interfaces), &printed).unwrap();
    let expected: Vec<&str> = include_str!("xe3/oracle.expected").lines().collect();
    // generic ops, as a body has them
    let ops: Vec<Operation<'_>> = body.ops(body.top_block(body.root)).map(|o| body.operation(o)).collect();
    let reread: Vec<Operation<'_>> = again.ops(again.top_block(again.root)).map(|o| again.operation(o)).collect();
    assert_eq!(ops.len(), expected.len());
    let mut bad = Vec::new();
    for ((op, re), want) in ops.iter().zip(&reread).zip(&expected) {
        // the C side wrote the longest form (optional trailing dwords, an empty variable group) as zeros
        let n = want.split(' ').count() - 1;
        let pack = |op: &Operation<'_>| {
            let item = XE3.get(&op.name).unwrap();
            let mut dw = XE3.pack(&op.name, &all(op)).unwrap_or_else(|e| panic!("{e}"));
            dw.resize(dw.len().max(n), 0);
            std::iter::once(item.name.to_owned()).chain(dw.iter().take(n).map(|d| format!("{d:08x}"))).collect::<Vec<_>>().join(" ")
        };
        let (got, got_again) = (pack(op), pack(re));
        let typed = Xe3Genxml::verify(op).map(|r| r.map_err(|e| e.to_string()));
        if got != *want || got_again != got || !matches!(typed, Some(Ok(()))) {
            bad.push(format!("want {want}\n got {got}\n printed and read again {got_again}\n typed {typed:?}"));
        }
    }
    assert!(bad.is_empty(), "{} of {} differ:\n{}", bad.len(), expected.len(), bad.join("\n"));
}

/// The properties and the discardable attributes together.
fn all<'a>(op: &Operation<'a>) -> Vec<NamedAttr<'a>> {
    let mut a = match &op.properties {
        Some(mlirformat::Attribute::Dict(p)) => p.clone(),
        _ => Vec::new(),
    };
    a.extend(op.attributes.iter().cloned());
    a
}
