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

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i64, i64, i64) -> i64, sym_name = "_mlir_apfloat_fused_multiply_add", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "test_vector"}> ({
    %0 = "arith.constant"() <{value = dense<2.000000e+00> : vector<4xf8E4M3FN>}> : () -> vector<4xf8E4M3FN>
    %1 = "arith.constant"() <{value = dense<4.000000e+00> : vector<4xf8E4M3FN>}> : () -> vector<4xf8E4M3FN>
    %2 = "arith.constant"() <{value = dense<8.000000e+00> : vector<4xf8E4M3FN>}> : () -> vector<4xf8E4M3FN>
    %3:4 = "vector.to_elements"(%0) : (vector<4xf8E4M3FN>) -> (f8E4M3FN, f8E4M3FN, f8E4M3FN, f8E4M3FN)
    %4:4 = "vector.to_elements"(%1) : (vector<4xf8E4M3FN>) -> (f8E4M3FN, f8E4M3FN, f8E4M3FN, f8E4M3FN)
    %5:4 = "vector.to_elements"(%2) : (vector<4xf8E4M3FN>) -> (f8E4M3FN, f8E4M3FN, f8E4M3FN, f8E4M3FN)
    %6 = "arith.bitcast"(%3#0) : (f8E4M3FN) -> i8
    %7 = "arith.extui"(%6) : (i8) -> i64
    %8 = "arith.bitcast"(%4#0) : (f8E4M3FN) -> i8
    %9 = "arith.extui"(%8) : (i8) -> i64
    %10 = "arith.bitcast"(%5#0) : (f8E4M3FN) -> i8
    %11 = "arith.extui"(%10) : (i8) -> i64
    %12 = "arith.constant"() <{value = 10 : i32}> : () -> i32
    %13 = "func.call"(%12, %7, %9, %11) <{callee = @_mlir_apfloat_fused_multiply_add}> : (i32, i64, i64, i64) -> i64
    %14 = "arith.trunci"(%13) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i8
    %15 = "arith.bitcast"(%14) : (i8) -> f8E4M3FN
    %16 = "arith.bitcast"(%3#1) : (f8E4M3FN) -> i8
    %17 = "arith.extui"(%16) : (i8) -> i64
    %18 = "arith.bitcast"(%4#1) : (f8E4M3FN) -> i8
    %19 = "arith.extui"(%18) : (i8) -> i64
    %20 = "arith.bitcast"(%5#1) : (f8E4M3FN) -> i8
    %21 = "arith.extui"(%20) : (i8) -> i64
    %22 = "arith.constant"() <{value = 10 : i32}> : () -> i32
    %23 = "func.call"(%22, %17, %19, %21) <{callee = @_mlir_apfloat_fused_multiply_add}> : (i32, i64, i64, i64) -> i64
    %24 = "arith.trunci"(%23) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i8
    %25 = "arith.bitcast"(%24) : (i8) -> f8E4M3FN
    %26 = "arith.bitcast"(%3#2) : (f8E4M3FN) -> i8
    %27 = "arith.extui"(%26) : (i8) -> i64
    %28 = "arith.bitcast"(%4#2) : (f8E4M3FN) -> i8
    %29 = "arith.extui"(%28) : (i8) -> i64
    %30 = "arith.bitcast"(%5#2) : (f8E4M3FN) -> i8
    %31 = "arith.extui"(%30) : (i8) -> i64
    %32 = "arith.constant"() <{value = 10 : i32}> : () -> i32
    %33 = "func.call"(%32, %27, %29, %31) <{callee = @_mlir_apfloat_fused_multiply_add}> : (i32, i64, i64, i64) -> i64
    %34 = "arith.trunci"(%33) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i8
    %35 = "arith.bitcast"(%34) : (i8) -> f8E4M3FN
    %36 = "arith.bitcast"(%3#3) : (f8E4M3FN) -> i8
    %37 = "arith.extui"(%36) : (i8) -> i64
    %38 = "arith.bitcast"(%4#3) : (f8E4M3FN) -> i8
    %39 = "arith.extui"(%38) : (i8) -> i64
    %40 = "arith.bitcast"(%5#3) : (f8E4M3FN) -> i8
    %41 = "arith.extui"(%40) : (i8) -> i64
    %42 = "arith.constant"() <{value = 10 : i32}> : () -> i32
    %43 = "func.call"(%42, %37, %39, %41) <{callee = @_mlir_apfloat_fused_multiply_add}> : (i32, i64, i64, i64) -> i64
    %44 = "arith.trunci"(%43) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i8
    %45 = "arith.bitcast"(%44) : (i8) -> f8E4M3FN
    %46 = "vector.from_elements"(%15, %25, %35, %45) : (f8E4M3FN, f8E4M3FN, f8E4M3FN, f8E4M3FN) -> vector<4xf8E4M3FN>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

