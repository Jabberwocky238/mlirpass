use mlirformat::{MlirOpt, Module};
use mlirpass::{Apple9Dialect, Apple9Emit, Body, Ctx, Emit, Interfaces, PassManager, Passes};

fn kernels(src: &str) -> String {
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
