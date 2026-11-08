//! The Apple9 target (Apple M3 / M4) against what an M4 ran: no Mesa model of this instruction set exists, so the
//! oracle is the hardware (scripts/apple9_metal.swift runs code through Metal and reads it back).

use mlirformat::{MlirOpt, Module};
use mlirpass::{Apple9Dialect, Apple9Isa, Body, Ctx, Interfaces, OpId};

/// tests/apple9/isa.mlir is acgpu's `ints` kernel in Apple9 instructions, as an M4 ran it through Metal (160 of 160
/// results right, 2026-11-08); each encodes to its bytes there (tests/apple9/isa.expected), printed and read again the same.
#[test]
fn encodes_as_the_m4_ran_it() {
    let mut opt = MlirOpt::upstream();
    opt.load(Apple9Dialect);
    let interfaces = Interfaces::upstream();
    let src = include_str!("apple9/isa.mlir");
    let body = Body::parse(Ctx::new(&opt, &interfaces), src).unwrap();
    let printed = opt.show(&Module::from(&body)).to_string();
    let again = Body::parse(Ctx::new(&opt, &interfaces), &printed).unwrap();
    let expected: Vec<&str> = include_str!("apple9/isa.expected").lines().collect();
    let ops = |b: &Body<'_>| b.block_ops(b.top_block(b.root));
    let (ops, reread) = (ops(&body), ops(&again));
    assert_eq!(ops.len(), expected.len());
    let encode = |b: &Body<'_>, o: OpId| match Apple9Isa::encode(&b[o].name, &b[o].all_attrs()) {
        Ok(bytes) => bytes.iter().map(|x| format!("{x:02x}")).collect::<String>(),
        Err(e) => e.to_string(),
    };
    let mut bad = Vec::new();
    for ((op, re), want) in ops.iter().zip(&reread).zip(&expected) {
        let (got, got_again) = (encode(&body, *op), encode(&again, *re));
        if got != *want || got_again != got {
            bad.push(format!("{}\n want {want}\n  got {got}\n printed and read again {got_again}", body[*op].name));
        }
    }
    assert!(bad.is_empty(), "{} of {} differ:\n{}", bad.len(), expected.len(), bad.join("\n"));
}

/// `src` (a module of compute kernels in upstream dialects) through the frontend passes acgpu runs (inlined, canonicalize,
/// cse) and the Apple9 backend: each kernel's params, GPRs and bytes.
#[cfg(feature = "target.apple9")]
fn kernels(src: &str) -> String {
    use mlirpass::{Apple9Emit, Emit, PassManager, Passes};
    let mut opt = MlirOpt::upstream();
    opt.load(Apple9Dialect);
    let interfaces = Interfaces::upstream();
    let passes = Passes::upstream();
    let mut body = Body::parse(Ctx::new(&opt, &interfaces), src).unwrap();
    let pm = PassManager::parse(&passes, "builtin.module(gpu-inline-calls, canonicalize, cse, convert-gpu-to-apple9, apple9-regalloc, apple9-wait)").unwrap();
    let root = body.root;
    pm.run(&mut body, root).unwrap_or_else(|e| panic!("{e}"));
    if std::env::var("APPLE9_SHOW").is_ok() {
        eprintln!("{}", opt.show(&Module::from(&body)));
    }
    let mut out = String::new();
    for k in Apple9Emit.emit(&body, root).unwrap() {
        out += &format!("{} params={} gprs={}\n", k.name, k.params, k.gprs);
        out += &k.bytes.chunks(32).map(|c| c.iter().map(|b| format!("{b:02x}")).collect::<String>() + "\n").collect::<String>();
    }
    out
}

/// acgpu's `ints` kernel (tests/apple9/ints.mlir) through the Apple9 backend: its bytes as the M4 ran them right
/// (tests/apple9/ints.expected; scripts/apple9_check.py runs it).
#[cfg(feature = "target.apple9")]
#[test]
fn ints_as_the_m4_ran_it() {
    let got = kernels(include_str!("apple9/ints.mlir"));
    if let Ok(path) = std::env::var("APPLE9_WRITE") {
        std::fs::write(path, &got).unwrap();
    }
    assert_eq!(got, include_str!("apple9/ints.expected"));
}
