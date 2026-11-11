//! The x86-64 backend runs: each function of tests/x86_64/run.mlir is emitted, mapped executable and called, and its
//! result compared with the same computation in Rust.

#![cfg(target_arch = "x86_64")]

use mlirformat::MlirOpt;
use mlirpass::{Body, Ctx, Emit, Interfaces, X86_64Code, X86_64Emit};

/// Machine code mapped read-execute.
struct Mapped {
    at: *mut libc::c_void,
    len: usize,
}

impl Mapped {
    /// `code` with its calls pointed at `symbols`.
    fn new(code: &X86_64Code, symbols: &[(&str, usize)]) -> Mapped {
        let mut bytes = code.bytes.clone();
        for r in &code.relocs {
            let (_, addr) = symbols.iter().find(|(n, _)| *n == r.symbol).unwrap_or_else(|| panic!("no symbol {}", r.symbol));
            bytes[r.offset..r.offset + 8].copy_from_slice(&(*addr as u64).to_le_bytes());
        }
        let len = bytes.len().max(1);
        // SAFETY: a fresh private anonymous mapping, written while writable, then made read-execute
        unsafe {
            let at = libc::mmap(core::ptr::null_mut(), len, libc::PROT_READ | libc::PROT_WRITE, libc::MAP_PRIVATE | libc::MAP_ANONYMOUS, -1, 0);
            assert_ne!(at, libc::MAP_FAILED);
            core::ptr::copy_nonoverlapping(bytes.as_ptr(), at.cast::<u8>(), bytes.len());
            assert_eq!(libc::mprotect(at, len, libc::PROT_READ | libc::PROT_EXEC), 0);
            Mapped { at, len }
        }
    }
}

impl Drop for Mapped {
    fn drop(&mut self) {
        // SAFETY: the mapping made in `new`
        unsafe { libc::munmap(self.at, self.len) };
    }
}

extern "C" fn twice(x: i64) -> i64 {
    2 * x
}

extern "C" fn hypot(x: f64, y: f64) -> f64 {
    (x * x + y * y).sqrt()
}

fn compiled() -> Vec<X86_64Code> {
    let opt = MlirOpt::upstream();
    let interfaces = Interfaces::upstream();
    let body = Body::parse(Ctx::new(&opt, &interfaces), include_str!("x86_64/run.mlir")).unwrap();
    X86_64Emit.emit(&body, body.root).unwrap()
}

#[test]
fn runs() {
    let codes = compiled();
    let symbols = [("twice", twice as *const () as usize), ("hypot", hypot as *const () as usize)];
    let map: Vec<(String, Mapped)> = codes.iter().map(|c| (c.name.clone(), Mapped::new(c, &symbols))).collect();
    let f = |name: &str| map.iter().find(|(n, _)| n == name).unwrap_or_else(|| panic!("no function {name}")).1.at;
    // SAFETY: each function has the signature its MLIR declares (System V)
    unsafe {
        let poly: extern "C" fn(i64, i64) -> i64 = core::mem::transmute(f("poly"));
        let sum: extern "C" fn(i64) -> i64 = core::mem::transmute(f("sum"));
        let divs: extern "C" fn(i64, i64) -> i64 = core::mem::transmute(f("divs"));
        let narrow: extern "C" fn(i32, i32) -> i32 = core::mem::transmute(f("narrow"));
        let fmax: extern "C" fn(f64, f64) -> f64 = core::mem::transmute(f("fmax"));
        let unordered: extern "C" fn(f64, f64) -> i64 = core::mem::transmute(f("unordered"));
        let calls: extern "C" fn(i64, f64) -> f64 = core::mem::transmute(f("calls"));
        let memory: extern "C" fn(*mut i64, i64) -> i64 = core::mem::transmute(f("memory"));
        let bytes: extern "C" fn(*mut u8) -> i64 = core::mem::transmute(f("bytes"));
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
    }
}
