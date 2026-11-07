//! The AGX target against its oracles: USC instructions as Mesa's AGX2 model encodes them, the structs and a CDM
//! stream as Mesa's agx_pack writes them, and acgpu's kernels as its own AGX backend made them before it moved here.

use mlirformat::{MlirOpt, Module};
use mlirpass::{AGX, AgxDialect, AgxStructs, Body, Ctx, Interfaces, OpId, Usc};

/// Every instruction of Mesa's AGX2 disassembler cases, as its fields (tests/agx/usc.mlir), encodes back to the
/// case's bytes (tests/agx/usc.expected); reads as its typed op; printed and read again encodes the same.
#[test]
fn usc_encodes_mesa_cases() {
    let mut opt = MlirOpt::upstream();
    opt.load(AgxDialect);
    let interfaces = Interfaces::upstream();
    let src = include_str!("agx/usc.mlir");
    let body = Body::parse(Ctx::new(&opt, &interfaces), src).unwrap();
    let printed = opt.show(&Module::from(&body)).to_string();
    let again = Body::parse(Ctx::new(&opt, &interfaces), &printed).unwrap();
    let asm: Vec<&str> = src.lines().skip(2).filter_map(|l| l.strip_prefix("// ")).collect();
    let expected: Vec<&str> = include_str!("agx/usc.expected").lines().collect();
    let ops = |b: &Body<'_>| b.block_ops(b.top_block(b.root));
    let (ops, reread) = (ops(&body), ops(&again));
    assert_eq!(ops.len(), expected.len());
    let encode = |b: &Body<'_>, o: OpId| match Usc::encode(&b[o].name, &b[o].all_attrs()) {
        Ok(bytes) => bytes.iter().map(|x| format!("{x:02x}")).collect::<String>(),
        Err(e) => e.to_string(),
    };
    let mut bad = Vec::new();
    for (((op, re), want), asm) in ops.iter().zip(&reread).zip(&expected).zip(&asm) {
        let (got, got_again) = (encode(&body, *op), encode(&again, *re));
        let typed = Usc::op(&body[*op].name).ok_or_else(|| "not a USC op".to_owned()).and_then(|o| o.verify(&body, *op).map_err(|e| e.to_string()));
        if got != *want || got_again != got || typed.is_err() {
            bad.push(format!("{asm}\n want {want}\n  got {got}\n printed and read again {got_again}\n typed {typed:?}"));
        }
    }
    assert!(bad.is_empty(), "{} of {} differ:\n{}", bad.len(), expected.len(), bad.join("\n"));
}

/// Every AGX struct packed from MLIR (tests/agx/oracle.mlir: each settable field set to the value Mesa's agx_pack was
/// given) is what Mesa packed (tests/agx/oracle.expected), dword for dword; reads as its typed op; printed and read
/// again packs the same.
#[test]
fn structs_pack_as_mesa() {
    let mut opt = MlirOpt::upstream();
    opt.load(AgxDialect);
    let interfaces = Interfaces::upstream();
    let body = Body::parse(Ctx::new(&opt, &interfaces), include_str!("agx/oracle.mlir")).unwrap();
    let printed = opt.show(&Module::from(&body)).to_string();
    let again = Body::parse(Ctx::new(&opt, &interfaces), &printed).unwrap();
    let expected: Vec<&str> = include_str!("agx/oracle.expected").lines().collect();
    let ops = |b: &Body<'_>| b.block_ops(b.top_block(b.root));
    let (ops, reread) = (ops(&body), ops(&again));
    assert_eq!(ops.len(), expected.len());
    let pack = |b: &Body<'_>, o: OpId| {
        let name = &b[o].name;
        let item = AGX.get(name).unwrap();
        let dw = AGX.pack(name, &b[o].all_attrs()).unwrap_or_else(|e| panic!("{name}: {e}"));
        std::iter::once(item.name.to_owned()).chain(dw.iter().map(|d| format!("{d:08x}"))).collect::<Vec<_>>().join(" ")
    };
    let mut bad = Vec::new();
    for ((op, re), want) in ops.iter().zip(&reread).zip(&expected) {
        let (got, got_again) = (pack(&body, *op), pack(&again, *re));
        let typed = AgxStructs::verify(&body, *op).map(|r| r.map_err(|e| e.to_string()));
        if got != *want || got_again != got || !matches!(typed, Some(Ok(()))) {
            bad.push(format!("want {want}\n got {got}\n printed and read again {got_again}\n typed {typed:?}"));
        }
    }
    assert!(bad.is_empty(), "{} of {} differ:\n{}", bad.len(), expected.len(), bad.join("\n"));
}

/// tests/agx/cdm.mlir through `agx-end, agx-layout` is the CDM stream Mesa's agx_pack writes for it
/// (tests/agx/cdm.expected), byte for byte, and `stream_end` is the address after its terminate.
#[cfg(feature = "target.agx")]
#[test]
fn cdm_stream_as_mesa() {
    use mlirpass::{AGX_IMAGE, Emit, ImageDialect, PassManager, Passes};
    let mut opt = MlirOpt::upstream();
    opt.load(AgxDialect);
    opt.load(ImageDialect);
    let interfaces = Interfaces::upstream();
    let passes = Passes::upstream();
    let mut body = Body::parse(Ctx::new(&opt, &interfaces), include_str!("agx/cdm.mlir")).unwrap();
    let root = body.root;
    PassManager::parse(&passes, "builtin.module(agx-end, agx-layout)").unwrap().run(&mut body, root).unwrap();
    let show = || opt.show(&Module::from(&body)).to_string();
    let image = AGX_IMAGE.emit(&body, root).unwrap_or_else(|e| panic!("{e}\n{}", show()));
    let code = image.segment("code").unwrap();
    let want: Vec<u8> = include_str!("agx/cdm.expected").lines().map(|l| u8::from_str_radix(l, 16).unwrap()).collect();
    let at = (image.stream - code.addr) as usize;
    assert_eq!(&code.bytes[at..at + want.len()], &want[..], "\n{}", show());
    assert_eq!(image.stream_end - image.stream, want.len() as u64);
}

/// acgpu's `ints` shader in upstream dialects (tests/agx/ints.mlir), canonicalized as acgpu's frontend did, lowered
/// and allocated: the kernel's bytes and registers exactly as acgpu's own AGX backend made them (tests/agx/ints.expected).
#[cfg(feature = "target.agx")]
#[test]
fn kernels_as_acgpu() {
    use mlirpass::{AgxEmit, Emit, PassManager, Passes};
    let mut opt = MlirOpt::upstream();
    opt.load(AgxDialect);
    let interfaces = Interfaces::upstream();
    let passes = Passes::upstream();
    let mut body = Body::parse(Ctx::new(&opt, &interfaces), include_str!("agx/ints.mlir")).unwrap();
    let root = body.root;
    PassManager::parse(&passes, "builtin.module(gpu-inline-calls, canonicalize, cse, convert-gpu-to-agx, agx-regalloc, agx-wait)").unwrap().run(&mut body, root).unwrap();
    let [k] = &AgxEmit.emit(&body, root).unwrap()[..] else { panic!("one kernel") };
    let got = format!("params={} gprs={} align={}\n", k.params, k.gprs, k.align) + &k.bytes.chunks(32).map(|c| c.iter().map(|b| format!("{b:02x}")).collect::<String>() + "\n").collect::<String>();
    assert_eq!(got, include_str!("agx/ints.expected"));
}
