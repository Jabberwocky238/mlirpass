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

/// `src` (a module of compute kernels in upstream dialects) through acgpu's frontend passes (inlined, canonicalize, cse)
/// and the Xe3 backend up to the padding: each kernel's head and its bytes (its instructions, then its padding), as
/// acgpu printed them.
#[cfg(feature = "target.xe3")]
fn kernels(src: &str) -> String {
    use mlirformat::Op;
    use mlirpass::{Heads, ImageTarget, Kernels, PassManager, Passes, Symbol, Xe3Image, Xe3Kernel};
    let mut opt = MlirOpt::upstream();
    opt.load(Xe3Dialect);
    let interfaces = Interfaces::upstream();
    let passes = Passes::upstream();
    let mut body = Body::parse(Ctx::new(&opt, &interfaces), src).unwrap();
    let pm = PassManager::parse(&passes, "builtin.module(gpu-inline-calls, canonicalize, cse, convert-gpu-to-xe3, xe3-regalloc, xe3-control, xe3-swsb, xe3-branches, xe3-pad)").unwrap();
    let root = body.root;
    pm.run(&mut body, root).unwrap_or_else(|e| panic!("{e}"));
    let mut out = String::new();
    for k in Kernels::all(&body, root, Xe3Kernel::NAME) {
        let h = body.head::<Xe3Kernel>(k).unwrap();
        out += &format!(
            "kernel {} stage={:?} simd={:?} payload={:?} inputs={:?} varyings={:?} targets={:?} omask={:?} imask={:?} bindings={:?} buffers={:?} push={:?} reserve={:?} threads={:?} shared={:?} params={:?} pad={:?} align={:?}\n",
            Symbol::defined(&h.sym_name).unwrap(), h.stage, h.simd, h.payload, h.inputs, h.varyings, h.targets, h.omask, h.imask, h.bindings, h.buffers, h.push, h.reserve, h.threads, h.shared, h.params, h.pad, h.align
        );
        let bytes = Xe3Image.item(&body, k).unwrap();
        out += &bytes.chunks(32).map(|c| c.iter().map(|b| format!("{b:02x}")).collect::<String>() + "\n").collect::<String>();
    }
    out
}

/// acgpu's compute shaders (its examples, its 2D rasterizer's and filters' kernels), in upstream dialects
/// (tests/xe3/kernels/*.mlir): each kernel's head and bytes as acgpu's own Xe3 backend made them before it moved here
/// (tests/xe3/kernels/*.expected; acgpu at 4a0ead0 on mlirpass 0.8.3 with the dialect features, its `acgpu.*` ops).
///
/// Twelve are acgpu's bytes exactly. Seven differ only by what the upstream ops let canonicalize do before the
/// lowering, their expected bytes this lowering's: a load nothing uses is gone (`llvm.load` only reads, `acgpu.load`'s
/// effects were unknown: paths_cells, paths_events, paths_pairs, paths_layers; with `volatile` loads they are acgpu's
/// bytes exactly), and constants hoisted in another order, `x + -1` as `x - 1`, a compare and an `scf.if` folded
/// (fine, paths_flatten, paths_runs; the IR before the lowering differs so already). Those seven have not run on an
/// Xe3 since.
#[cfg(feature = "target.xe3")]
#[test]
fn kernels_as_acgpu() {
    macro_rules! cases {
        ($($name:literal),* $(,)?) => { [$(($name, include_str!(concat!("xe3/kernels/", $name, ".mlir")), include_str!(concat!("xe3/kernels/", $name, ".expected")))),*] };
    }
    let cases = cases!["ints", "atomics", "loops", "math64", "workgroups", "copy", "blur", "shadow", "fine", "paths_bins", "paths_cells", "paths_events", "paths_flatten", "paths_glue", "paths_pairs", "paths_scan", "paths_tiles", "paths_runs", "paths_layers"];
    let mut bad = Vec::new();
    for (name, src, want) in cases {
        let got = std::panic::catch_unwind(|| kernels(src)).unwrap_or_else(|e| format!("panicked: {:?}\n", e.downcast_ref::<String>().cloned().or_else(|| e.downcast_ref::<&str>().map(|s| s.to_string()))));
        if got != want {
            let first = got.lines().zip(want.lines()).position(|(g, w)| g != w).unwrap_or(got.lines().count().min(want.lines().count()));
            bad.push(format!("{name}: first difference at line {first}\n  got  {}\n  want {}", got.lines().nth(first).unwrap_or("(end)"), want.lines().nth(first).unwrap_or("(end)")));
        }
    }
    assert!(bad.is_empty(), "{} of {} differ:\n{}", bad.len(), cases.len(), bad.join("\n"));
}

/// `gpu-module-to-binary` of a module of xe3 kernels: one `#gpu.object` whose bytes are the kernel (its instructions,
/// then its padding) and whose properties say where it is and how to run it.
#[cfg(feature = "target.xe3")]
#[test]
fn module_to_binary() {
    use mlirpass::{PassManager, Passes, unescape};
    let mut opt = MlirOpt::upstream();
    opt.load(Xe3Dialect);
    let interfaces = Interfaces::upstream();
    let passes = Passes::upstream();
    let mut body = Body::parse(Ctx::new(&opt, &interfaces), include_str!("xe3/kernels/ints.mlir")).unwrap();
    let pm = PassManager::parse(&passes, "builtin.module(gpu-inline-calls, canonicalize, cse, convert-gpu-to-xe3, xe3-regalloc, xe3-control, xe3-swsb, xe3-branches, xe3-pad, gpu-module-to-binary)").unwrap();
    let root = body.root;
    pm.run(&mut body, root).unwrap_or_else(|e| panic!("{e}"));
    let printed = opt.show(&Module::from(&body)).to_string();
    let want: String = include_str!("xe3/kernels/ints.expected").lines().skip(1).collect();
    let quoted = printed.split("bin = \"").nth(1).or_else(|| printed.split(", \"").last()).unwrap();
    let bytes = unescape(&quoted[..quoted.find("\">").unwrap()]);
    assert_eq!(bytes.iter().map(|b| format!("{b:02x}")).collect::<String>(), want, "\n{printed}");
    assert!(printed.contains("ints = {offset = 0 : i64, size = ") && printed.contains("simd = 16 : i64, inputs = 2 : i64, threads = 1 : i64, shared = 0 : i64"), "{printed}");
}
