module {
  // a * a + b * 3, xor (a - b)
  llvm.func @poly(%a: i64, %b: i64) -> i64 {
    %c3 = llvm.mlir.constant(3 : i64) : i64
    %0 = llvm.mul %a, %a : i64
    %1 = llvm.mul %b, %c3 : i64
    %2 = llvm.add %0, %1 : i64
    %3 = llvm.sub %a, %b : i64
    %4 = llvm.xor %2, %3 : i64
    llvm.return %4 : i64
  }
  // 0 + 1 + ... + (n - 1), a loop with block arguments
  llvm.func @sum(%n: i64) -> i64 {
    %zero = llvm.mlir.constant(0 : i64) : i64
    %one = llvm.mlir.constant(1 : i64) : i64
    llvm.br ^head(%zero, %zero : i64, i64)
  ^head(%i: i64, %acc: i64):
    %more = llvm.icmp "slt" %i, %n : i64
    llvm.cond_br %more, ^body, ^done(%acc : i64)
  ^body:
    %acc2 = llvm.add %acc, %i : i64
    %i2 = llvm.add %i, %one : i64
    llvm.br ^head(%i2, %acc2 : i64, i64)
  ^done(%r: i64):
    llvm.return %r : i64
  }
  // (a / b) * 1000 + a % b, signed
  llvm.func @divs(%a: i64, %b: i64) -> i64 {
    %k = llvm.mlir.constant(1000 : i64) : i64
    %q = llvm.sdiv %a, %b : i64
    %r = llvm.srem %a, %b : i64
    %m = llvm.mul %q, %k : i64
    %s = llvm.add %m, %r : i64
    llvm.return %s : i64
  }
  // i32: (a < b) + ((a + b) >> 1) arithmetic, with a zext of the i1
  llvm.func @narrow(%a: i32, %b: i32) -> i32 {
    %c1 = llvm.mlir.constant(1 : i32) : i32
    %lt = llvm.icmp "slt" %a, %b : i32
    %z = llvm.zext %lt : i1 to i32
    %s = llvm.add %a, %b : i32
    %h = llvm.ashr %s, %c1 : i32
    %r = llvm.add %z, %h : i32
    llvm.return %r : i32
  }
  // max(a, b) * 2.0 through fcmp and select
  llvm.func @fmax(%a: f64, %b: f64) -> f64 {
    %two = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %gt = llvm.fcmp "ogt" %a, %b : f64
    %m = llvm.select %gt, %a, %b : i1, f64
    %r = llvm.fmul %m, %two : f64
    llvm.return %r : f64
  }
  llvm.func @unordered(%a: f64, %b: f64) -> i64 {
    %u = llvm.fcmp "uno" %a, %b : f64
    %r = llvm.zext %u : i1 to i64
    llvm.return %r : i64
  }
  llvm.func @twice(i64) -> i64
  llvm.func @hypot(f64, f64) -> f64
  // trunc(hypot(twice(n), y) * 1000)
  llvm.func @calls(%n: i64, %y: f64) -> f64 {
    %k = llvm.mlir.constant(1.000000e+03 : f64) : f64
    %t = llvm.call @twice(%n) : (i64) -> i64
    %x = llvm.sitofp %t : i64 to f64
    %h = llvm.call @hypot(%x, %y) : (f64, f64) -> f64
    %m = llvm.fmul %h, %k : f64
    %i = llvm.fptosi %m : f64 to i64
    %r = llvm.sitofp %i : i64 to f64
    llvm.return %r : f64
  }
  // doubles each of n cells in place, returns the old sum
  llvm.func @memory(%p: !llvm.ptr, %n: i64) -> i64 {
    %zero = llvm.mlir.constant(0 : i64) : i64
    %one = llvm.mlir.constant(1 : i64) : i64
    llvm.br ^head(%zero, %zero : i64, i64)
  ^head(%i: i64, %acc: i64):
    %more = llvm.icmp "slt" %i, %n : i64
    llvm.cond_br %more, ^body, ^done
  ^body:
    %q = llvm.getelementptr %p[%i] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %v = llvm.load %q : !llvm.ptr -> i64
    %acc2 = llvm.add %acc, %v : i64
    %d = llvm.add %v, %v : i64
    llvm.store %d, %q : i64, !llvm.ptr
    %i2 = llvm.add %i, %one : i64
    llvm.br ^head(%i2, %acc2 : i64, i64)
  ^done:
    llvm.return %acc : i64
  }
  // p[0] + p[1] as unsigned bytes; p[2] = p[0] + p[1] truncated to i8
  llvm.func @bytes(%p: !llvm.ptr) -> i64 {
    %q = llvm.getelementptr %p[1] : (!llvm.ptr) -> !llvm.ptr, i8
    %r = llvm.getelementptr %p[2] : (!llvm.ptr) -> !llvm.ptr, i8
    %a = llvm.load %p : !llvm.ptr -> i8
    %b = llvm.load %q : !llvm.ptr -> i8
    %wa = llvm.zext %a : i8 to i64
    %wb = llvm.zext %b : i8 to i64
    %s = llvm.add %wa, %wb : i64
    %t = llvm.trunc %s : i64 to i8
    llvm.store %t, %r : i8, !llvm.ptr
    llvm.return %s : i64
  }
  // 20 values live at once (more than the registers): some spill
  llvm.func @pressure(%x: i64) -> i64 {
    %c0 = llvm.mlir.constant(1 : i64) : i64
    %v0 = llvm.mul %x, %c0 : i64
    %c1 = llvm.mlir.constant(2 : i64) : i64
    %v1 = llvm.mul %x, %c1 : i64
    %c2 = llvm.mlir.constant(3 : i64) : i64
    %v2 = llvm.mul %x, %c2 : i64
    %c3 = llvm.mlir.constant(4 : i64) : i64
    %v3 = llvm.mul %x, %c3 : i64
    %c4 = llvm.mlir.constant(5 : i64) : i64
    %v4 = llvm.mul %x, %c4 : i64
    %c5 = llvm.mlir.constant(6 : i64) : i64
    %v5 = llvm.mul %x, %c5 : i64
    %c6 = llvm.mlir.constant(7 : i64) : i64
    %v6 = llvm.mul %x, %c6 : i64
    %c7 = llvm.mlir.constant(8 : i64) : i64
    %v7 = llvm.mul %x, %c7 : i64
    %c8 = llvm.mlir.constant(9 : i64) : i64
    %v8 = llvm.mul %x, %c8 : i64
    %c9 = llvm.mlir.constant(10 : i64) : i64
    %v9 = llvm.mul %x, %c9 : i64
    %c10 = llvm.mlir.constant(11 : i64) : i64
    %v10 = llvm.mul %x, %c10 : i64
    %c11 = llvm.mlir.constant(12 : i64) : i64
    %v11 = llvm.mul %x, %c11 : i64
    %c12 = llvm.mlir.constant(13 : i64) : i64
    %v12 = llvm.mul %x, %c12 : i64
    %c13 = llvm.mlir.constant(14 : i64) : i64
    %v13 = llvm.mul %x, %c13 : i64
    %c14 = llvm.mlir.constant(15 : i64) : i64
    %v14 = llvm.mul %x, %c14 : i64
    %c15 = llvm.mlir.constant(16 : i64) : i64
    %v15 = llvm.mul %x, %c15 : i64
    %c16 = llvm.mlir.constant(17 : i64) : i64
    %v16 = llvm.mul %x, %c16 : i64
    %c17 = llvm.mlir.constant(18 : i64) : i64
    %v17 = llvm.mul %x, %c17 : i64
    %c18 = llvm.mlir.constant(19 : i64) : i64
    %v18 = llvm.mul %x, %c18 : i64
    %c19 = llvm.mlir.constant(20 : i64) : i64
    %v19 = llvm.mul %x, %c19 : i64
    %s1 = llvm.xor %v0, %v1 : i64
    %t1 = llvm.add %s1, %v19 : i64
    %s2 = llvm.xor %t1, %v2 : i64
    %t2 = llvm.add %s2, %v18 : i64
    %s3 = llvm.xor %t2, %v3 : i64
    %t3 = llvm.add %s3, %v17 : i64
    %s4 = llvm.xor %t3, %v4 : i64
    %t4 = llvm.add %s4, %v16 : i64
    %s5 = llvm.xor %t4, %v5 : i64
    %t5 = llvm.add %s5, %v15 : i64
    %s6 = llvm.xor %t5, %v6 : i64
    %t6 = llvm.add %s6, %v14 : i64
    %s7 = llvm.xor %t6, %v7 : i64
    %t7 = llvm.add %s7, %v13 : i64
    %s8 = llvm.xor %t7, %v8 : i64
    %t8 = llvm.add %s8, %v12 : i64
    %s9 = llvm.xor %t8, %v9 : i64
    %t9 = llvm.add %s9, %v11 : i64
    %s10 = llvm.xor %t9, %v10 : i64
    %t10 = llvm.add %s10, %v10 : i64
    %s11 = llvm.xor %t10, %v11 : i64
    %t11 = llvm.add %s11, %v9 : i64
    %s12 = llvm.xor %t11, %v12 : i64
    %t12 = llvm.add %s12, %v8 : i64
    %s13 = llvm.xor %t12, %v13 : i64
    %t13 = llvm.add %s13, %v7 : i64
    %s14 = llvm.xor %t13, %v14 : i64
    %t14 = llvm.add %s14, %v6 : i64
    %s15 = llvm.xor %t14, %v15 : i64
    %t15 = llvm.add %s15, %v5 : i64
    %s16 = llvm.xor %t15, %v16 : i64
    %t16 = llvm.add %s16, %v4 : i64
    %s17 = llvm.xor %t16, %v17 : i64
    %t17 = llvm.add %s17, %v3 : i64
    %s18 = llvm.xor %t17, %v18 : i64
    %t18 = llvm.add %s18, %v2 : i64
    %s19 = llvm.xor %t18, %v19 : i64
    %t19 = llvm.add %s19, %v1 : i64
    llvm.return %t19 : i64
  }
  // an integer and a float live across calls (callee-saved / the stack, not r10 / xmm8)
  llvm.func @across(%n: i64, %y: f64) -> f64 {
    %k = llvm.mlir.constant(7 : i64) : i64
    %a = llvm.mul %n, %k : i64
    %h = llvm.fmul %y, %y : f64
    %t = llvm.call @twice(%n) : (i64) -> i64
    %u = llvm.call @twice(%t) : (i64) -> i64
    %p = llvm.call @hypot(%y, %y) : (f64, f64) -> f64
    %s = llvm.add %a, %u : i64
    %f = llvm.sitofp %s : i64 to f64
    %g = llvm.fadd %f, %h : f64
    %r = llvm.fadd %g, %p : f64
    llvm.return %r : f64
  }
  // a float accumulator around a loop
  llvm.func @fsum(%n: i64, %step: f64) -> f64 {
    %zero = llvm.mlir.constant(0 : i64) : i64
    %one = llvm.mlir.constant(1 : i64) : i64
    %fz = llvm.mlir.constant(0.000000e+00 : f64) : f64
    llvm.br ^head(%zero, %fz : i64, f64)
  ^head(%i: i64, %acc: f64):
    %more = llvm.icmp "slt" %i, %n : i64
    llvm.cond_br %more, ^body, ^done
  ^body:
    %fi = llvm.sitofp %i : i64 to f64
    %m = llvm.fmul %fi, %step : f64
    %acc2 = llvm.fadd %acc, %m : f64
    %i2 = llvm.add %i, %one : i64
    llvm.br ^head(%i2, %acc2 : i64, f64)
  ^done:
    llvm.return %acc : f64
  }
}
