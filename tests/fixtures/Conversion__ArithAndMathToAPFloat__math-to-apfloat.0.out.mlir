module {
  func.func private @_mlir_apfloat_isfinite(i32, i64) -> i1
  func.func private @_mlir_apfloat_isnormal(i32, i64) -> i1
  func.func private @_mlir_apfloat_isnan(i32, i64) -> i1
  func.func private @_mlir_apfloat_isinfinite(i32, i64) -> i1
  func.func private @_mlir_apfloat_fused_multiply_add(i32, i64, i64, i64) -> i64
  func.func private @_mlir_apfloat_abs(i32, i64) -> i64
  func.func @full_example() {
    %cst = arith.constant -1.375000e+00 : f8E4M3FN
    %0 = arith.bitcast %cst : f8E4M3FN to i8
    %1 = arith.extui %0 : i8 to i64
    %c10_i32 = arith.constant 10 : i32
    %2 = call @_mlir_apfloat_abs(%c10_i32, %1) : (i32, i64) -> i64
    %3 = arith.trunci %2 : i64 to i8
    %4 = arith.bitcast %3 : i8 to f8E4M3FN
    %cst_0 = arith.constant 2.000000e+00 : f8E8M0FNU
    %cst_1 = arith.constant 4.000000e+00 : f8E8M0FNU
    %cst_2 = arith.constant 8.000000e+00 : f8E8M0FNU
    %5 = arith.bitcast %cst_1 : f8E8M0FNU to i8
    %6 = arith.extui %5 : i8 to i64
    %7 = arith.bitcast %cst_0 : f8E8M0FNU to i8
    %8 = arith.extui %7 : i8 to i64
    %9 = arith.bitcast %cst_2 : f8E8M0FNU to i8
    %10 = arith.extui %9 : i8 to i64
    %c15_i32 = arith.constant 15 : i32
    %11 = call @_mlir_apfloat_fused_multiply_add(%c15_i32, %6, %8, %10) : (i32, i64, i64, i64) -> i64
    %12 = arith.trunci %11 : i64 to i8
    %13 = arith.bitcast %12 : i8 to f8E8M0FNU
    %14 = arith.bitcast %cst : f8E4M3FN to i8
    %15 = arith.extui %14 : i8 to i64
    %c10_i32_3 = arith.constant 10 : i32
    %16 = call @_mlir_apfloat_isinfinite(%c10_i32_3, %15) : (i32, i64) -> i1
    %17 = arith.bitcast %cst : f8E4M3FN to i8
    %18 = arith.extui %17 : i8 to i64
    %c10_i32_4 = arith.constant 10 : i32
    %19 = call @_mlir_apfloat_isnan(%c10_i32_4, %18) : (i32, i64) -> i1
    %20 = arith.bitcast %cst : f8E4M3FN to i8
    %21 = arith.extui %20 : i8 to i64
    %c10_i32_5 = arith.constant 10 : i32
    %22 = call @_mlir_apfloat_isnormal(%c10_i32_5, %21) : (i32, i64) -> i1
    %23 = arith.bitcast %cst : f8E4M3FN to i8
    %24 = arith.extui %23 : i8 to i64
    %c10_i32_6 = arith.constant 10 : i32
    %25 = call @_mlir_apfloat_isfinite(%c10_i32_6, %24) : (i32, i64) -> i1
    return
  }
}

// -----
module {
  func.func private @_mlir_apfloat_fused_multiply_add(i32, i64, i64, i64) -> i64
  func.func @test_vector() {
    %cst = arith.constant dense<2.000000e+00> : vector<4xf8E4M3FN>
    %cst_0 = arith.constant dense<4.000000e+00> : vector<4xf8E4M3FN>
    %cst_1 = arith.constant dense<8.000000e+00> : vector<4xf8E4M3FN>
    %0:4 = vector.to_elements %cst : vector<4xf8E4M3FN>
    %1:4 = vector.to_elements %cst_0 : vector<4xf8E4M3FN>
    %2:4 = vector.to_elements %cst_1 : vector<4xf8E4M3FN>
    %3 = arith.bitcast %0#0 : f8E4M3FN to i8
    %4 = arith.extui %3 : i8 to i64
    %5 = arith.bitcast %1#0 : f8E4M3FN to i8
    %6 = arith.extui %5 : i8 to i64
    %7 = arith.bitcast %2#0 : f8E4M3FN to i8
    %8 = arith.extui %7 : i8 to i64
    %c10_i32 = arith.constant 10 : i32
    %9 = call @_mlir_apfloat_fused_multiply_add(%c10_i32, %4, %6, %8) : (i32, i64, i64, i64) -> i64
    %10 = arith.trunci %9 : i64 to i8
    %11 = arith.bitcast %10 : i8 to f8E4M3FN
    %12 = arith.bitcast %0#1 : f8E4M3FN to i8
    %13 = arith.extui %12 : i8 to i64
    %14 = arith.bitcast %1#1 : f8E4M3FN to i8
    %15 = arith.extui %14 : i8 to i64
    %16 = arith.bitcast %2#1 : f8E4M3FN to i8
    %17 = arith.extui %16 : i8 to i64
    %c10_i32_2 = arith.constant 10 : i32
    %18 = call @_mlir_apfloat_fused_multiply_add(%c10_i32_2, %13, %15, %17) : (i32, i64, i64, i64) -> i64
    %19 = arith.trunci %18 : i64 to i8
    %20 = arith.bitcast %19 : i8 to f8E4M3FN
    %21 = arith.bitcast %0#2 : f8E4M3FN to i8
    %22 = arith.extui %21 : i8 to i64
    %23 = arith.bitcast %1#2 : f8E4M3FN to i8
    %24 = arith.extui %23 : i8 to i64
    %25 = arith.bitcast %2#2 : f8E4M3FN to i8
    %26 = arith.extui %25 : i8 to i64
    %c10_i32_3 = arith.constant 10 : i32
    %27 = call @_mlir_apfloat_fused_multiply_add(%c10_i32_3, %22, %24, %26) : (i32, i64, i64, i64) -> i64
    %28 = arith.trunci %27 : i64 to i8
    %29 = arith.bitcast %28 : i8 to f8E4M3FN
    %30 = arith.bitcast %0#3 : f8E4M3FN to i8
    %31 = arith.extui %30 : i8 to i64
    %32 = arith.bitcast %1#3 : f8E4M3FN to i8
    %33 = arith.extui %32 : i8 to i64
    %34 = arith.bitcast %2#3 : f8E4M3FN to i8
    %35 = arith.extui %34 : i8 to i64
    %c10_i32_4 = arith.constant 10 : i32
    %36 = call @_mlir_apfloat_fused_multiply_add(%c10_i32_4, %31, %33, %35) : (i32, i64, i64, i64) -> i64
    %37 = arith.trunci %36 : i64 to i8
    %38 = arith.bitcast %37 : i8 to f8E4M3FN
    %39 = vector.from_elements %11, %20, %29, %38 : vector<4xf8E4M3FN>
    return
  }
}

