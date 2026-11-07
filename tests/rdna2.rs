//! Every instruction of tests/rdna2/isa.mlir encodes as `llvm-mc -mcpu=gfx1036` does (tests/rdna2/isa.expected,
//! scripts/rdna2_isa_oracle.sh), byte for byte, but one field: a VOP3 source the instruction does not have. ACO sets
//! it to the inline constant 0 (128, aco_assembler.cpp emit_vop3_instruction: "RDNA: Set unused operands to inline
//! constant 0"), LLVM to 0 (s0); the hardware reads neither, so both sides compare with it cleared. The module
//! printed and read again encodes the same (the operands print as they read).

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
        // a VOP3 encoding's second dword: the source fields the op leaves out, src1 [17:9], src2 [26:18]
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

/// acgpu's `ints` compute shader, in upstream dialects (tests/rdna2/ints.mlir), canonicalized as acgpu's frontend does, lowered and allocated: the kernel's
/// bytes and registers exactly as acgpu's own RDNA2 backend made them before it moved here (tests/rdna2/ints.expected).
#[cfg(feature = "target.rdna2")]
#[test]
fn ints_as_acgpu() {
    use mlirpass::{Emit, PassManager, Passes, Rdna2Emit};
    let mut opt = MlirOpt::upstream();
    opt.load(Rdna2Dialect);
    let interfaces = Interfaces::upstream();
    let passes = Passes::upstream();
    let mut body = Body::parse(Ctx::new(&opt, &interfaces), include_str!("rdna2/ints.mlir")).unwrap();
    let pm = PassManager::parse(&passes, "builtin.module(canonicalize, cse, convert-gpu-to-rdna2, rdna2-regalloc, rdna2-waitcnt)").unwrap();
    let root = body.root;
    pm.run(&mut body, root).unwrap();
    let [k] = &Rdna2Emit.emit(&body, root).unwrap()[..] else { panic!("one kernel") };
    let got = format!("params={} sgprs={} vgprs={} pad={} align={}\n", k.params, k.sgprs, k.vgprs, k.pad, k.align)
        + &k.bytes.chunks(32).map(|c| c.iter().map(|b| format!("{b:02x}")).collect::<String>() + "\n").collect::<String>();
    assert_eq!(got, include_str!("rdna2/ints.expected"));
}
