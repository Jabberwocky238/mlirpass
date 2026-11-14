use mlirformat::{MlirOpt, Module};
use mlirpass::{Apple9Dialect, Apple9Isa, Body, Ctx, Interfaces, OpId};

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

#[cfg(feature = "target.apple9")]
fn kernels(src: &str) -> String {
    use mlirpass::{Apple9Emit, Emit, PassManager, Passes};
    let mut opt = MlirOpt::upstream();
    opt.load(Apple9Dialect);
    let interfaces = Interfaces::upstream();
    let passes = Passes::upstream();
    let mut body = Body::parse(Ctx::new(&opt, &interfaces), src).unwrap();
    let pm = PassManager::parse(&passes, "builtin.module(gpu-inline-calls, canonicalize, cse, convert-gpu-to-apple9, apple9-regalloc, apple9-control, apple9-wait)").unwrap();
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

#[cfg(feature = "target.apple9")]
#[test]
fn kernels_as_the_m4_ran_them() {
    for (name, src, want) in [("ints", include_str!("apple9/ints.mlir"), include_str!("apple9/ints.expected")), ("floats", include_str!("apple9/floats.mlir"), include_str!("apple9/floats.expected")), ("control", include_str!("apple9/control.mlir"), include_str!("apple9/control.expected")), ("memory", include_str!("apple9/memory.mlir"), include_str!("apple9/memory.expected")), ("ids", include_str!("apple9/ids.mlir"), include_str!("apple9/ids.expected")), ("special", include_str!("apple9/special.mlir"), include_str!("apple9/special.expected")), ("halves", include_str!("apple9/halves.mlir"), include_str!("apple9/halves.expected"))] {
        let got = kernels(src);
        if let Ok(dir) = std::env::var("APPLE9_WRITE") {
            std::fs::write(format!("{dir}/{name}.expected"), &got).unwrap();
        }
        assert_eq!(got, want, "{name}");
    }
}
