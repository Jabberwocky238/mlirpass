//! The CPU targets' encodings against LLVM's disassembler: every instruction a selector emits,
//! encoded with sample operands, must disassemble (`llvm-mc --disassemble --show-inst`) to the
//! same LLVM instruction. Skipped without `llvm-mc` (`LLVM_MC`, default `llvm-mc-22`).

use std::io::Write;
use std::process::{Command, Stdio};

fn disassemble(triple: &str, codes: &[(String, Vec<u8>)]) -> Option<Vec<String>> {
    let mc = std::env::var("LLVM_MC").unwrap_or_else(|_| "llvm-mc-22".into());
    let mut child = Command::new(mc).args(["--disassemble", "--show-inst", &format!("--triple={triple}")]).stdin(Stdio::piped()).stdout(Stdio::piped()).stderr(Stdio::piped()).spawn().ok()?;
    let mut input = String::new();
    for (_, bytes) in codes {
        let hex: Vec<String> = bytes.iter().map(|b| format!("0x{b:02x}")).collect();
        input.push_str(&hex.join(" "));
        input.push('\n');
    }
    child.stdin.take()?.write_all(input.as_bytes()).ok()?;
    let out = child.wait_with_output().ok()?;
    let text = String::from_utf8_lossy(&out.stdout).into_owned() + &String::from_utf8_lossy(&out.stderr);
    Some(text.lines().filter_map(|l| l.split("<MCInst #").nth(1)).map(|l| l.split_whitespace().nth(1).unwrap_or("").trim_end_matches('>').to_string()).collect())
}

fn check(triple: &str, codes: Vec<(String, Vec<u8>)>, same: &[(&str, &str)]) {
    let Some(names) = disassemble(triple, &codes) else {
        eprintln!("llvm-mc not found, skipped");
        return;
    };
    let mut bad = Vec::new();
    let mut at = 0;
    for (name, bytes) in &codes {
        let got = names.get(at).cloned().unwrap_or_default();
        at += 1;
        let ok = got == *name || same.iter().any(|&(a, b)| a == name && b == got);
        if !ok {
            bad.push(format!("{name}: {} => {got}", bytes.iter().map(|b| format!("{b:02x}")).collect::<Vec<_>>().join(" ")));
        }
    }
    assert!(bad.is_empty(), "{} of {} differ:\n{}", bad.len(), codes.len(), bad.join("\n"));
}

#[test]
#[cfg(feature = "target.x86_64")]
fn x86_64() {
    check("x86_64", mlirpass::X86_64Emit::encodings(), &[]);
}

/// Machine code in executable memory, with its calls resolved.
struct Mapped {
    at: *mut u8,
    len: usize,
}

impl Mapped {
    fn new(bytes: &[u8], relocs: &[(usize, String)], symbols: &[(&str, usize)]) -> Mapped {
        let mut bytes = bytes.to_vec();
        for (offset, symbol) in relocs {
            let (_, addr) = symbols.iter().find(|(n, _)| n == symbol).unwrap_or_else(|| panic!("no symbol {symbol}"));
            bytes[*offset..offset + 8].copy_from_slice(&(*addr as u64).to_le_bytes());
        }
        let len = bytes.len().max(1);
        unsafe {
            let at = libc::mmap(std::ptr::null_mut(), len, libc::PROT_READ | libc::PROT_WRITE, libc::MAP_PRIVATE | libc::MAP_ANONYMOUS, -1, 0);
            assert!(at != libc::MAP_FAILED, "mmap");
            let at: *mut u8 = at.cast();
            std::ptr::copy_nonoverlapping(bytes.as_ptr(), at, bytes.len());
            assert_eq!(libc::mprotect(at.cast(), len, libc::PROT_READ | libc::PROT_EXEC), 0, "mprotect");
            Mapped { at, len }
        }
    }
}

impl Drop for Mapped {
    fn drop(&mut self) {
        unsafe { libc::munmap(self.at.cast(), self.len) };
    }
}

extern "C" fn twice(x: i64) -> i64 {
    2 * x
}

extern "C" fn hypot(x: f64, y: f64) -> f64 {
    (x * x + y * y).sqrt()
}

/// Every function of `run.mlir`, compiled for this machine and mapped.
fn compiled() -> Vec<(String, Mapped)> {
    use mlirpass::{Body, Ctx, Emit, Interfaces};
    let opt = mlirpass::mlirformat::MlirOpt::upstream();
    let interfaces = Interfaces::upstream();
    let body = Body::parse(Ctx::new(&opt, &interfaces), include_str!("machine_code/run.mlir")).unwrap();
    let symbols = [("twice", twice as *const () as usize), ("hypot", hypot as *const () as usize)];
    #[cfg(target_arch = "x86_64")]
    let codes = mlirpass::X86_64Emit.emit(&body, body.root).unwrap();
    #[cfg(all(target_arch = "aarch64", feature = "target.aarch64"))]
    let codes = mlirpass::AArch64Emit.emit(&body, body.root).unwrap();
    codes
        .into_iter()
        .map(|c| {
            let relocs: Vec<(usize, String)> = c.relocs.iter().map(|r| (r.offset, r.symbol.clone())).collect();
            (c.name.clone(), Mapped::new(&c.bytes, &relocs, &symbols))
        })
        .collect()
}

#[test]
#[cfg(any(target_arch = "x86_64", target_arch = "aarch64"))]
fn runs() {
    let map = compiled();
    let f = |name: &str| map.iter().find(|(n, _)| n == name).unwrap_or_else(|| panic!("no function {name}")).1.at;
    unsafe {
        let poly: extern "C" fn(i64, i64) -> i64 = std::mem::transmute(f("poly"));
        let sum: extern "C" fn(i64) -> i64 = std::mem::transmute(f("sum"));
        let divs: extern "C" fn(i64, i64) -> i64 = std::mem::transmute(f("divs"));
        let narrow: extern "C" fn(i32, i32) -> i32 = std::mem::transmute(f("narrow"));
        let fmax: extern "C" fn(f64, f64) -> f64 = std::mem::transmute(f("fmax"));
        let unordered: extern "C" fn(f64, f64) -> i64 = std::mem::transmute(f("unordered"));
        let calls: extern "C" fn(i64, f64) -> f64 = std::mem::transmute(f("calls"));
        let memory: extern "C" fn(*mut i64, i64) -> i64 = std::mem::transmute(f("memory"));
        let bytes: extern "C" fn(*mut u8) -> i64 = std::mem::transmute(f("bytes"));
        let pressure: extern "C" fn(i64) -> i64 = std::mem::transmute(f("pressure"));
        let across: extern "C" fn(i64, f64) -> f64 = std::mem::transmute(f("across"));
        let fsum: extern "C" fn(i64, f64) -> f64 = std::mem::transmute(f("fsum"));
        for (a, b) in [(3, 4), (-7, 5), (1 << 40, -3), (0, 0)] {
            assert_eq!(poly(a, b), a.wrapping_mul(a).wrapping_add(b.wrapping_mul(3)) ^ (a - b), "poly({a}, {b})");
        }
        for n in [0, 1, 10, 1000] {
            assert_eq!(sum(n), (0..n).sum::<i64>(), "sum({n})");
        }
        for (a, b) in [(7, 2), (-7, 2), (7, -2), (-7, -2)] {
            assert_eq!(divs(a, b), (a / b) * 1000 + (a % b), "divs({a}, {b})");
        }
        for (a, b) in [(5, 3), (-5, 3), (i32::MAX, 1), (-1, -2)] {
            assert_eq!(narrow(a, b), i32::from(a < b) + (a.wrapping_add(b) >> 1), "narrow({a}, {b})");
        }
        for (a, b) in [(1.5, 2.5), (-0.5, -1.0), (3.0, 3.0)] {
            assert_eq!(fmax(a, b), if a > b { a } else { b } * 2.0, "fmax({a}, {b})");
        }
        assert_eq!(unordered(f64::NAN, 1.0), 1);
        assert_eq!(unordered(2.0, 1.0), 0);
        assert_eq!(calls(5, 4.0), (hypot(twice(5) as f64, 4.0) * 1000.0).trunc());
        let mut cells = [1i64, 2, 3, 4];
        assert_eq!(memory(cells.as_mut_ptr(), 4), 10);
        assert_eq!(cells, [2, 4, 6, 8]);
        let mut raw = [200u8, 100, 7];
        assert_eq!(bytes(raw.as_mut_ptr()), 300);
        assert_eq!(raw, [200, 100, 44]);
        for x in [1i64, -3, 1 << 33] {
            let v: Vec<i64> = (1..=20).map(|k| x.wrapping_mul(k)).collect();
            let mut acc = v[0];
            for i in 1..20 {
                acc = (acc ^ v[i]).wrapping_add(v[20 - i]);
            }
            assert_eq!(pressure(x), acc, "pressure({x})");
        }
        for (n, y) in [(3i64, 1.5f64), (-2, 0.25)] {
            let want = ((n * 7 + twice(twice(n))) as f64 + y * y) + hypot(y, y);
            assert_eq!(across(n, y), want, "across({n}, {y})");
        }
        for (n, step) in [(0i64, 1.0f64), (10, 0.5), (1000, 0.001)] {
            let want = (0..n).fold(0.0f64, |a, i| a + i as f64 * step);
            assert_eq!(fsum(n, step), want, "fsum({n}, {step})");
        }
    }
}

#[test]
#[cfg(feature = "target.aarch64")]
fn aarch64() {
    check("aarch64", mlirpass::AArch64Emit::encodings(), &[]);
}

/// Assembles `asm` with llvm-mc (`--show-encoding`).
fn assemble(triple: &str, asm: &str) -> Option<Vec<u8>> {
    let mc = std::env::var("LLVM_MC").unwrap_or_else(|_| "llvm-mc-22".into());
    let mut child = Command::new(mc).args(["--show-encoding", &format!("--triple={triple}"), "--x86-asm-syntax=intel", "--output-asm-variant=1"]).stdin(Stdio::piped()).stdout(Stdio::piped()).stderr(Stdio::piped()).spawn().ok()?;
    child.stdin.take()?.write_all(asm.as_bytes()).ok()?;
    let out = child.wait_with_output().ok()?;
    assert!(out.status.success(), "{}", String::from_utf8_lossy(&out.stderr));
    let mut bytes = Vec::new();
    for line in String::from_utf8_lossy(&out.stdout).lines() {
        let Some(enc) = line.split("encoding: [").nth(1) else { continue };
        for b in enc.trim_end_matches(']').split(',') {
            bytes.push(u8::from_str_radix(b.trim().trim_start_matches("0x"), 16).unwrap_or_else(|_| panic!("unresolved: {line}")));
        }
    }
    Some(bytes)
}

/// A stencil as a JIT stitches it: `x` in frame slot `a`, the product with constant hole 0 in
/// slot `b`, a jump to hole 0's target past the end when it is over 100.
const STENCIL: &str = r#"module {
  llvm.func @scale(%ctx: i64, %fp: i64) attributes {stencil} {
    %o = llvm.call @slot.a() : () -> i64
    %p0 = llvm.add %fp, %o : i64
    %pa = llvm.inttoptr %p0 : i64 to !llvm.ptr
    %x = llvm.load %pa : !llvm.ptr -> i64
    %k = llvm.call @hole.0() : () -> i64
    %y = llvm.mul %x, %k : i64
    %o2 = llvm.call @slot.b() : () -> i64
    %p1 = llvm.add %fp, %o2 : i64
    %pb = llvm.inttoptr %p1 : i64 to !llvm.ptr
    llvm.store %y, %pb : i64, !llvm.ptr
    %z = llvm.mlir.constant(100 : i64) : i64
    %c = llvm.icmp "sgt" %y, %z : i64
    llvm.cond_br %c, ^big, ^small
  ^big:
    llvm.call @jump.0() : () -> ()
    llvm.unreachable
  ^small:
    llvm.return
  }
}
"#;

/// Frame offsets of the harness: slots `a`, `b` and the flag the jump leaves set.
const SLOT_A: i32 = -200;
const SLOT_B: i32 = -208;

/// `harness(ctx, x) = 2 * b + (jumped)` around the stencil with hole 0 = `k`.
fn stitched(k: i64) -> Option<Mapped> {
    use mlirpass::{Ctx, HoleKind, Interfaces, PassManager, Passes, Stencil, Stencils};
    let opt = mlirpass::mlirformat::MlirOpt::upstream();
    let interfaces = Interfaces::upstream();
    let passes = Passes::upstream();
    let pipeline = PassManager::parse(&passes, "builtin.module(llvm.func(canonicalize, cse))").unwrap();
    #[cfg(target_arch = "x86_64")]
    let (triple, emit, pre, small, post) = (
        "x86_64",
        mlirpass::X86_64Emit,
        "push rbp\nmov rbp, rsp\npush rbx\npush r12\npush r13\npush r14\npush r15\nsub rsp, 256\nmov r15, rdi\nmov qword ptr [rbp - 200], rsi\nmov qword ptr [rbp - 216], 1\n",
        "mov qword ptr [rbp - 216], 0\n",
        "mov rax, qword ptr [rbp - 208]\nadd rax, rax\nadd rax, qword ptr [rbp - 216]\nlea rsp, [rbp - 40]\npop r15\npop r14\npop r13\npop r12\npop rbx\npop rbp\nret\n",
    );
    #[cfg(target_arch = "aarch64")]
    let (triple, emit, pre, small, post) = (
        "aarch64",
        mlirpass::AArch64Emit,
        "stp x29, x30, [sp, #-16]!\nmov x29, sp\nsub sp, sp, #256\nstp x19, x20, [sp]\nstp x21, x22, [sp, #16]\nstr x23, [sp, #32]\nmov x23, x0\nstur x1, [x29, #-200]\nmov x9, #1\nstur x9, [x29, #-216]\n",
        "stur xzr, [x29, #-216]\n",
        "ldur x0, [x29, #-208]\nldur x9, [x29, #-216]\nadd x0, x9, x0, lsl #1\nldp x19, x20, [sp]\nldp x21, x22, [sp, #16]\nldr x23, [sp, #32]\nmov sp, x29\nldp x29, x30, [sp], #16\nret\n",
    );
    let stencils = Stencils::compile(Ctx::new(&opt, &interfaces), STENCIL, &pipeline, &emit).unwrap();
    let s: &Stencil = stencils.get("scale").unwrap();
    let mut code = assemble(triple, pre)?;
    let start = s.stamp(&mut code);
    code.extend(assemble(triple, small)?);
    let end = code.len();
    code.extend(assemble(triple, post)?);
    for h in &s.holes {
        let at = start + h.at;
        match (h.kind, h.name.as_str()) {
            (HoleKind::Disp32, "slot.a") => Stencil::disp32(&mut code, at, SLOT_A),
            (HoleKind::Disp32, "slot.b") => Stencil::disp32(&mut code, at, SLOT_B),
            (HoleKind::Abs64, "hole.0") => Stencil::abs64(&mut code, at, k.cast_unsigned()),
            (HoleKind::Rel32, "jump.0") => Stencil::rel32(&mut code, at, end),
            (HoleKind::Branch26, "jump.0") => Stencil::branch26(&mut code, at, end),
            other => panic!("unexpected hole {other:?}"),
        }
    }
    Some(Mapped::new(&code, &[], &[]))
}

#[test]
#[cfg(any(target_arch = "x86_64", target_arch = "aarch64"))]
fn stencils() {
    for (k, x) in [(3i64, 5i64), (3, 50), (-2, -60), (7, 0)] {
        let Some(m) = stitched(k) else {
            eprintln!("llvm-mc not found, skipped");
            return;
        };
        let f: extern "C" fn(i64, i64) -> i64 = unsafe { std::mem::transmute(m.at) };
        let y = x * k;
        assert_eq!(f(0, x), 2 * y + i64::from(y > 100), "k = {k}, x = {x}");
    }
}
