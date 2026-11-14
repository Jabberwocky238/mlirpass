use mlirpass::{Heads, Rdna2Dialect, Rdna2Format as Format, Rdna2Isa as Isa, Rdna2Valu as Valu};
use mlirformat::{MlirOpt, Module};
use mlirpass::{Body, Ctx, Interfaces};

#[test]
fn encodes_as_llvm_mc() {
    let mut opt = MlirOpt::upstream();
    opt.load(Rdna2Dialect);
    let interfaces = Interfaces::upstream();
    let src = include_str!("rdna2/isa.mlir");
    let body = Body::parse(Ctx::new(&opt, &interfaces), src).unwrap();
    let printed = opt.show(&Module::from(&body)).to_string();
    let again = Body::parse(Ctx::new(&opt, &interfaces), &printed).unwrap();
    let asm: Vec<&str> = src.lines().filter_map(|l| l.strip_prefix("// ")).filter(|l| l.starts_with(|c: char| c.is_ascii_lowercase())).collect();
    let expected: Vec<&str> = include_str!("rdna2/isa.expected").lines().collect();
    let ops = body.block_ops(body.top_block(body.root));
    let reread = again.block_ops(again.top_block(again.root));
    assert_eq!(ops.len(), expected.len());
    let mut bad = Vec::new();
    for (((op, re), want), asm) in ops.iter().zip(&reread).zip(&expected).zip(&asm) {
        let unused: u32 = match body.head::<Valu>(*op) {
            Ok(v) if v.vop3 || v.op.format() == Format::Vop3 => [(v.src1, 0x1ff << 9), (v.src2, 0x1ff << 18)].iter().filter(|(s, _)| s.is_none()).map(|(_, m)| m).sum(),
            _ => 0,
        };
        let clear = |mut dw: Vec<u32>| {
            if dw.len() > 1 {
                dw[1] &= !unused;
            }
            dw.iter().flat_map(|d| d.to_le_bytes()).map(|b| format!("{b:02x}")).collect::<Vec<_>>().join(" ")
        };
        let want = &clear(want.split(' ').collect::<Vec<_>>().chunks(4).map(|b| u32::from_le_bytes(std::array::from_fn(|i| u8::from_str_radix(b[i], 16).unwrap()))).collect());
        let encode = |b: &Body<'_>, o| Isa::encode(b, o).map_or_else(|e| e.to_string(), clear);
        let (got, got_again) = (encode(&body, *op), encode(&again, *re));
        if got != *want || got_again != got {
            bad.push(format!("{asm}\n want {want}\n  got {got}\n printed and read again {got_again}"));
        }
    }
    assert!(bad.is_empty(), "{} of {} differ:\n{}", bad.len(), expected.len(), bad.join("\n"));
}

#[cfg(feature = "target.rdna2")]
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

#[cfg(feature = "target.rdna2")]
#[test]
fn kernels_as_acgpu() {
    assert_eq!(kernels(include_str!("rdna2/ints.mlir")), include_str!("rdna2/ints.expected"));
    assert_eq!(kernels(include_str!("rdna2/copy.mlir")), include_str!("rdna2/copy.expected"));
}

#[test]
fn registers_pack_as_mesa() {
    use mlirpass::{OpId, RDNA2, Rdna2Regs};
    let mut opt = MlirOpt::upstream();
    opt.load(Rdna2Dialect);
    let interfaces = Interfaces::upstream();
    let body = Body::parse(Ctx::new(&opt, &interfaces), include_str!("rdna2/oracle.mlir")).unwrap();
    let printed = opt.show(&Module::from(&body)).to_string();
    let again = Body::parse(Ctx::new(&opt, &interfaces), &printed).unwrap();
    let expected: Vec<&str> = include_str!("rdna2/oracle.expected").lines().collect();
    let ops = |b: &Body<'_>| b.block_ops(b.top_block(b.root));
    let (ops, reread) = (ops(&body), ops(&again));
    assert_eq!(ops.len(), expected.len());
    let pack = |b: &Body<'_>, o: OpId| {
        let name = &b[o].name;
        let item = RDNA2.get(name).unwrap();
        let dw = RDNA2.pack(name, &b[o].all_attrs()).unwrap_or_else(|e| panic!("{e}"));
        format!("{} {:08x}", item.name, dw[0])
    };
    let mut bad = Vec::new();
    for ((op, re), want) in ops.iter().zip(&reread).zip(&expected) {
        let (got, got_again) = (pack(&body, *op), pack(&again, *re));
        let typed = Rdna2Regs::verify(&body, *op).map(|r| r.map_err(|e| e.to_string()));
        if got != *want || got_again != got || !matches!(typed, Some(Ok(()))) {
            bad.push(format!("want {want}\n got {got}\n printed and read again {got_again}\n typed {typed:?}"));
        }
    }
    assert!(bad.is_empty(), "{} of {} differ:\n{}", bad.len(), expected.len(), bad.join("\n"));
}

#[cfg(feature = "target.rdna2")]
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
    body.walk(body.root, &mut |o| packets.extend(Rdna2Packets::verify(&body, o).map(|r| (o, r))));
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
