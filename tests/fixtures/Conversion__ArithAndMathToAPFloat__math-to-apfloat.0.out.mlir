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

