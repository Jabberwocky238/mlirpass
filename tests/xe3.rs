use mlirformat::{Item, MlirOpt, Module, NamedAttr, Operation};
use mlirpass::{Body, Ctx, Inst, Interfaces, XE3, Xe3Dialect, Xe3Genxml};

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

#[test]
fn genxml_packs_as_mesa() {
    let mut opt = MlirOpt::upstream();
    opt.load(Xe3Dialect);
    let interfaces = Interfaces::upstream();
    let body = Body::parse(Ctx::new(&opt, &interfaces), include_str!("xe3/oracle.mlir")).unwrap();
    let printed = opt.show(&Module::from(&body)).to_string();
    let again = Body::parse(Ctx::new(&opt, &interfaces), &printed).unwrap();
    let expected: Vec<&str> = include_str!("xe3/oracle.expected").lines().collect();
    let ops: Vec<Operation<'_>> = body.ops(body.top_block(body.root)).map(|o| body.operation(o)).collect();
    let reread: Vec<Operation<'_>> = again.ops(again.top_block(again.root)).map(|o| again.operation(o)).collect();
    assert_eq!(ops.len(), expected.len());
    let mut bad = Vec::new();
    for ((op, re), want) in ops.iter().zip(&reread).zip(&expected) {
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

fn all<'a>(op: &Operation<'a>) -> Vec<NamedAttr<'a>> {
    let mut a = match &op.properties {
        Some(mlirformat::Attribute::Dict(p)) => p.clone(),
        _ => Vec::new(),
    };
    a.extend(op.attributes.iter().cloned());
    a
}

#[cfg(feature = "target.xe3")]
#[test]
fn kernels_as_acgpu() {
    use std::fmt::Write as _;

    use mlirformat::Op;
    use mlirpass::{Heads, ImageTarget, Kernels, PassManager, Passes, ShaderStage, Symbol, Xe3Image, Xe3Kernel};
    let mut opt = MlirOpt::upstream();
    opt.load(Xe3Dialect);
    let interfaces = Interfaces::upstream();
    let passes = Passes::upstream();
    let pm = PassManager::parse(&passes, "builtin.module(convert-spirv-entry-points, gpu-inline-calls, canonicalize, cse, convert-gpu-to-xe3, xe3-regalloc, xe3-control, xe3-swsb, xe3-branches, xe3-pad)").unwrap();
    let cases = [
        ("ints", include_str!("xe3/kernels/ints.mlir"), include_str!("xe3/kernels/ints.expected")),
        ("atomics", include_str!("xe3/kernels/atomics.mlir"), include_str!("xe3/kernels/atomics.expected")),
        ("loops", include_str!("xe3/kernels/loops.mlir"), include_str!("xe3/kernels/loops.expected")),
        ("math64", include_str!("xe3/kernels/math64.mlir"), include_str!("xe3/kernels/math64.expected")),
        ("workgroups", include_str!("xe3/kernels/workgroups.mlir"), include_str!("xe3/kernels/workgroups.expected")),
        ("copy", include_str!("xe3/kernels/copy.mlir"), include_str!("xe3/kernels/copy.expected")),
        ("triangle", include_str!("xe3/kernels/triangle.mlir"), include_str!("xe3/kernels/triangle.expected")),
        ("texture", include_str!("xe3/kernels/texture.mlir"), include_str!("xe3/kernels/texture.expected")),
        ("push", include_str!("xe3/kernels/push.mlir"), include_str!("xe3/kernels/push.expected")),
        ("push_mixed", include_str!("xe3/kernels/push_mixed.mlir"), include_str!("xe3/kernels/push_mixed.expected")),
        ("uniform", include_str!("xe3/kernels/uniform.mlir"), include_str!("xe3/kernels/uniform.expected")),
        ("resolve", include_str!("xe3/kernels/resolve.mlir"), include_str!("xe3/kernels/resolve.expected")),
        ("mrt", include_str!("xe3/kernels/mrt.mlir"), include_str!("xe3/kernels/mrt.expected")),
        ("math", include_str!("xe3/kernels/math.mlir"), include_str!("xe3/kernels/math.expected")),
    ];
    let mut bad = Vec::new();
    for (name, src, want) in cases {
        let mut body = Body::parse(Ctx::new(&opt, &interfaces), src).unwrap();
        let root = body.root;
        pm.run(&mut body, root).unwrap_or_else(|e| panic!("{name}: {e}"));
        let mut got = String::new();
        for k in Kernels::all(&body, root, Xe3Kernel::NAME) {
            let h = body.head::<Xe3Kernel>(k).unwrap();
            let stage = h.stage.map(|s| match s {
                ShaderStage::Compute => "Compute",
                ShaderStage::Vertex => "Vertex",
                ShaderStage::Fragment => "Fragment",
            });
            let stage = stage.map_or("None".to_owned(), |s| format!("Some({s})"));
            writeln!(got, "kernel {} stage={stage} simd={:?} payload={:?} inputs={:?} varyings={:?} targets={:?} omask={:?} imask={:?} bindings={:?} buffers={:?} push={:?} reserve={:?} threads={:?} shared={:?} params={:?} pad={:?} align={:?}",
                Symbol::defined(&h.sym_name).unwrap(), h.simd, h.payload, h.inputs, h.varyings, h.targets, h.omask, h.imask, h.bindings, h.buffers, h.push, h.reserve, h.threads, h.shared, h.params, h.pad, h.align).unwrap();
            for line in Xe3Image.item(&body, k).unwrap().chunks(32) {
                writeln!(got, "  {}", line.iter().map(|b| format!("{b:02x}")).collect::<String>()).unwrap();
            }
        }
        if got != want {
            bad.push(name);
        }
    }
    assert!(bad.is_empty(), "differ from acgpu's kernels: {bad:?}");
}
