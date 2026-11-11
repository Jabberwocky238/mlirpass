module {
  // llvm.func in its generic form: mlirformat keeps the custom form as raw text
  // a * a + b * 3, xor (a - b)
  "llvm.func"() <{function_type = !llvm.func<i64 (i64, i64)>, sym_name = "poly"}> ({
  ^entry(%a: i64, %b: i64):
    %c3 = llvm.mlir.constant(3 : i64) : i64
    %0 = llvm.mul %a, %a : i64
    %1 = llvm.mul %b, %c3 : i64
    %2 = llvm.add %0, %1 : i64
    %3 = llvm.sub %a, %b : i64
    %4 = llvm.xor %2, %3 : i64
    llvm.return %4 : i64
  }) : () -> ()
  // 0 + 1 + ... + (n - 1), a loop with block arguments
  "llvm.func"() <{function_type = !llvm.func<i64 (i64)>, sym_name = "sum"}> ({
  ^entry(%n: i64):
    %zero = llvm.mlir.constant(0 : i64) : i64
    %one = llvm.mlir.constant(1 : i64) : i64
    llvm.br ^head(%zero, %zero : i64, i64)
  ^head(%i: i64, %acc: i64):
    %more = "llvm.icmp"(%i, %n) <{predicate = 2 : i64}> : (i64, i64) -> i1
    llvm.cond_br %more, ^body, ^done(%acc : i64)
  ^body:
    %acc2 = llvm.add %acc, %i : i64
    %i2 = llvm.add %i, %one : i64
    llvm.br ^head(%i2, %acc2 : i64, i64)
  ^done(%r: i64):
    llvm.return %r : i64
  }) : () -> ()
  // (a / b) * 1000 + a % b, signed
  "llvm.func"() <{function_type = !llvm.func<i64 (i64, i64)>, sym_name = "divs"}> ({
  ^entry(%a: i64, %b: i64):
    %k = llvm.mlir.constant(1000 : i64) : i64
    %q = llvm.sdiv %a, %b : i64
    %r = llvm.srem %a, %b : i64
    %m = llvm.mul %q, %k : i64
    %s = llvm.add %m, %r : i64
    llvm.return %s : i64
  }) : () -> ()
  // i32: (a < b) + ((a + b) >> 1) arithmetic, with a zext of the i1
  "llvm.func"() <{function_type = !llvm.func<i32 (i32, i32)>, sym_name = "narrow"}> ({
  ^entry(%a: i32, %b: i32):
    %c1 = llvm.mlir.constant(1 : i32) : i32
    %lt = "llvm.icmp"(%a, %b) <{predicate = 2 : i64}> : (i32, i32) -> i1
    %z = llvm.zext %lt : i1 to i32
    %s = llvm.add %a, %b : i32
    %h = llvm.ashr %s, %c1 : i32
    %r = llvm.add %z, %h : i32
    llvm.return %r : i32
  }) : () -> ()
  // max(a, b) * 2.0 through fcmp and select
  "llvm.func"() <{function_type = !llvm.func<f64 (f64, f64)>, sym_name = "fmax"}> ({
  ^entry(%a: f64, %b: f64):
    %two = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %gt = "llvm.fcmp"(%a, %b) <{predicate = 2 : i64}> : (f64, f64) -> i1
    %m = llvm.select %gt, %a, %b : i1, f64
    %r = llvm.fmul %m, %two : f64
    llvm.return %r : f64
  }) : () -> ()
  "llvm.func"() <{function_type = !llvm.func<i64 (f64, f64)>, sym_name = "unordered"}> ({
  ^entry(%a: f64, %b: f64):
    %u = "llvm.fcmp"(%a, %b) <{predicate = 14 : i64}> : (f64, f64) -> i1
    %r = llvm.zext %u : i1 to i64
    llvm.return %r : i64
  }) : () -> ()
  "llvm.func"() <{function_type = !llvm.func<i64 (i64)>, sym_name = "twice"}> ({}) : () -> ()
  "llvm.func"() <{function_type = !llvm.func<f64 (f64, f64)>, sym_name = "hypot"}> ({}) : () -> ()
  // trunc(hypot(twice(n), y) * 1000)
  "llvm.func"() <{function_type = !llvm.func<f64 (i64, f64)>, sym_name = "calls"}> ({
  ^entry(%n: i64, %y: f64):
    %k = llvm.mlir.constant(1.000000e+03 : f64) : f64
    %t = "llvm.call"(%n) <{callee = @twice, operandSegmentSizes = array<i32: 1, 0>, op_bundle_sizes = array<i32>}> : (i64) -> i64
    %x = llvm.sitofp %t : i64 to f64
    %h = "llvm.call"(%x, %y) <{callee = @hypot, operandSegmentSizes = array<i32: 2, 0>, op_bundle_sizes = array<i32>}> : (f64, f64) -> f64
    %m = llvm.fmul %h, %k : f64
    %i = llvm.fptosi %m : f64 to i64
    %r = llvm.sitofp %i : i64 to f64
    llvm.return %r : f64
  }) : () -> ()
  // doubles each of n cells in place, returns the old sum
  "llvm.func"() <{function_type = !llvm.func<i64 (!llvm.ptr, i64)>, sym_name = "memory"}> ({
  ^entry(%p: !llvm.ptr, %n: i64):
    %zero = llvm.mlir.constant(0 : i64) : i64
    %one = llvm.mlir.constant(1 : i64) : i64
    llvm.br ^head(%zero, %zero : i64, i64)
  ^head(%i: i64, %acc: i64):
    %more = "llvm.icmp"(%i, %n) <{predicate = 2 : i64}> : (i64, i64) -> i1
    llvm.cond_br %more, ^body, ^done
  ^body:
    %q = "llvm.getelementptr"(%p, %i) <{elem_type = i64, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %v = llvm.load %q : !llvm.ptr -> i64
    %acc2 = llvm.add %acc, %v : i64
    %d = llvm.add %v, %v : i64
    llvm.store %d, %q : i64, !llvm.ptr
    %i2 = llvm.add %i, %one : i64
    llvm.br ^head(%i2, %acc2 : i64, i64)
  ^done:
    llvm.return %acc : i64
  }) : () -> ()
  // p[0] + p[1] as unsigned bytes; p[2] = p[0] + p[1] truncated to i8
  "llvm.func"() <{function_type = !llvm.func<i64 (!llvm.ptr)>, sym_name = "bytes"}> ({
  ^entry(%p: !llvm.ptr):
    %q = "llvm.getelementptr"(%p) <{elem_type = i8, rawConstantIndices = array<i32: 1>}> : (!llvm.ptr) -> !llvm.ptr
    %r = "llvm.getelementptr"(%p) <{elem_type = i8, rawConstantIndices = array<i32: 2>}> : (!llvm.ptr) -> !llvm.ptr
    %a = llvm.load %p : !llvm.ptr -> i8
    %b = llvm.load %q : !llvm.ptr -> i8
    %wa = llvm.zext %a : i8 to i64
    %wb = llvm.zext %b : i8 to i64
    %s = llvm.add %wa, %wb : i64
    %t = llvm.trunc %s : i64 to i8
    llvm.store %t, %r : i8, !llvm.ptr
    llvm.return %s : i64
  }) : () -> ()
}
