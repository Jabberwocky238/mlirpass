//! RDNA2 lowering and images: kernels as acgpu runs them, an IB as Mesa writes one (encoding and
//! register packing are mlirbinary's tests)

use mlirpass::Rdna2Dialect;
use mlirformat::{MlirOpt, Module};
use mlirpass::{Body, Ctx, Interfaces};

fn kernels(src: &str) -> String {
    use mlirpass::{Emit, PassManager, Passes, Rdna2Emit};
    let mut opt = MlirOpt::upstream();
    opt.load(Rdna2Dialect);
    let interfaces = Interfaces::upstream();
    let passes = Passes::upstream();
    let mut body = Body::parse(Ctx::new(&opt, &interfaces), src).unwrap();
    let pm = PassManager::parse(&passes, "builtin.module(gpu-inline-calls, canonicalize, cse, convert-gpu-to-rdna2, rdna2-regalloc, rdna2-waitcnt)").unwrap();
    let root = body.root;
    pm.run(&mut body, root).unwrap();
    let mut out = String::new();
    for k in Rdna2Emit.emit(&body, root).unwrap() {
        let name = if src.contains("@ints") { String::new() } else { format!("{} ", k.name) };
        out += &format!("{name}params={} sgprs={} vgprs={} pad={} align={}\n", k.params, k.sgprs, k.vgprs, k.pad, k.align);
        out += &k.bytes.chunks(32).map(|c| c.iter().map(|b| format!("{b:02x}")).collect::<String>() + "\n").collect::<String>();
    }
    out
}

#[test]
fn kernels_as_acgpu() {
    assert_eq!(kernels(include_str!("rdna2/ints.mlir")), include_str!("rdna2/ints.expected"));
    assert_eq!(kernels(include_str!("rdna2/copy.mlir")), include_str!("rdna2/copy.expected"));
}

#[test]
fn ib_as_mesa() {
    use mlirpass::{Emit, ImageDialect, PassManager, Passes, RDNA2_IMAGE, Rdna2Packets};
    let mut opt = MlirOpt::upstream();
    opt.load(Rdna2Dialect);
    opt.load(ImageDialect);
    let interfaces = Interfaces::upstream();
    let passes = Passes::upstream();
    let mut body = Body::parse(Ctx::new(&opt, &interfaces), include_str!("rdna2/pm4.mlir")).unwrap();
    let root = body.root;
    PassManager::parse(&passes, "builtin.module(rdna2-pm4, rdna2-pad, rdna2-layout)").unwrap().run(&mut body, root).unwrap();
    let mut packets = Vec::new();
    body.walk(body.root, &mut |o| packets.extend(Rdna2Packets::verify(&body.operation(o)).map(|r| (o, r))));
    assert!(packets.len() >= 3, "the stream's packets: write_data, dispatch_direct, the padding's NOP");
    for (o, r) in packets {
        r.unwrap_or_else(|e| panic!("{}: {e}", body[o].name));
    }
    let show = || opt.show(&Module::from(&body)).to_string();
    let image = RDNA2_IMAGE.emit(&body, body.root).unwrap_or_else(|e| panic!("{e}\n{}", show()));
    let code = image.segment("code").unwrap();
    let at = (image.stream - code.addr) as usize;
    let want: Vec<u32> = include_str!("rdna2/pm4.expected").lines().map(|l| u32::from_str_radix(l, 16).unwrap()).collect();
    let got: Vec<u32> = code.bytes[at..at + want.len() * 4].as_chunks::<4>().0.iter().map(|b| u32::from_le_bytes(*b)).collect();
    assert_eq!(got.iter().map(|d| format!("{d:08x}")).collect::<Vec<_>>(), want.iter().map(|d| format!("{d:08x}")).collect::<Vec<_>>(), "\n{}", show());
}
