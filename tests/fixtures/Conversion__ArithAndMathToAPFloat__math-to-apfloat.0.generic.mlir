"builtin.module"() ({
  "func.func"() <{function_type = (i32, i64) -> i1, sym_name = "_mlir_apfloat_isfinite", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (i32, i64) -> i1, sym_name = "_mlir_apfloat_isnormal", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (i32, i64) -> i1, sym_name = "_mlir_apfloat_isnan", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (i32, i64) -> i1, sym_name = "_mlir_apfloat_isinfinite", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (i32, i64, i64, i64) -> i64, sym_name = "_mlir_apfloat_fused_multiply_add", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (i32, i64) -> i64, sym_name = "_mlir_apfloat_abs", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "full_example"}> ({
    %0 = "arith.constant"() <{value = -1.375000e+00 : f8E4M3FN}> : () -> f8E4M3FN
    %1 = "arith.bitcast"(%0) : (f8E4M3FN) -> i8
    %2 = "arith.extui"(%1) : (i8) -> i64
    %3 = "arith.constant"() <{value = 10 : i32}> : () -> i32
    %4 = "func.call"(%3, %2) <{callee = @_mlir_apfloat_abs}> : (i32, i64) -> i64
    %5 = "arith.trunci"(%4) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i8
    %6 = "arith.bitcast"(%5) : (i8) -> f8E4M3FN
    %7 = "arith.constant"() <{value = 2.000000e+00 : f8E8M0FNU}> : () -> f8E8M0FNU
    %8 = "arith.constant"() <{value = 4.000000e+00 : f8E8M0FNU}> : () -> f8E8M0FNU
    %9 = "arith.constant"() <{value = 8.000000e+00 : f8E8M0FNU}> : () -> f8E8M0FNU
    %10 = "arith.bitcast"(%8) : (f8E8M0FNU) -> i8
    %11 = "arith.extui"(%10) : (i8) -> i64
    %12 = "arith.bitcast"(%7) : (f8E8M0FNU) -> i8
    %13 = "arith.extui"(%12) : (i8) -> i64
    %14 = "arith.bitcast"(%9) : (f8E8M0FNU) -> i8
    %15 = "arith.extui"(%14) : (i8) -> i64
    %16 = "arith.constant"() <{value = 15 : i32}> : () -> i32
    %17 = "func.call"(%16, %11, %13, %15) <{callee = @_mlir_apfloat_fused_multiply_add}> : (i32, i64, i64, i64) -> i64
    %18 = "arith.trunci"(%17) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i8
    %19 = "arith.bitcast"(%18) : (i8) -> f8E8M0FNU
    %20 = "arith.bitcast"(%0) : (f8E4M3FN) -> i8
    %21 = "arith.extui"(%20) : (i8) -> i64
    %22 = "arith.constant"() <{value = 10 : i32}> : () -> i32
    %23 = "func.call"(%22, %21) <{callee = @_mlir_apfloat_isinfinite}> : (i32, i64) -> i1
    %24 = "arith.bitcast"(%0) : (f8E4M3FN) -> i8
    %25 = "arith.extui"(%24) : (i8) -> i64
    %26 = "arith.constant"() <{value = 10 : i32}> : () -> i32
    %27 = "func.call"(%26, %25) <{callee = @_mlir_apfloat_isnan}> : (i32, i64) -> i1
    %28 = "arith.bitcast"(%0) : (f8E4M3FN) -> i8
    %29 = "arith.extui"(%28) : (i8) -> i64
    %30 = "arith.constant"() <{value = 10 : i32}> : () -> i32
    %31 = "func.call"(%30, %29) <{callee = @_mlir_apfloat_isnormal}> : (i32, i64) -> i1
    %32 = "arith.bitcast"(%0) : (f8E4M3FN) -> i8
    %33 = "arith.extui"(%32) : (i8) -> i64
    %34 = "arith.constant"() <{value = 10 : i32}> : () -> i32
    %35 = "func.call"(%34, %33) <{callee = @_mlir_apfloat_isfinite}> : (i32, i64) -> i1
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

