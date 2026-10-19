module {
  func.func private @_mlir_apfloat_add(i32, i64, i64) -> i64
  func.func @foo() -> f8E4M3FN {
    %cst = arith.constant 2.250000e+00 : f8E4M3FN
    return %cst : f8E4M3FN
  }
  func.func @bar() -> f6E3M2FN {
    %cst = arith.constant 3.000000e+00 : f6E3M2FN
    return %cst : f6E3M2FN
  }
  func.func @full_example() {
    %cst = arith.constant 1.375000e+00 : f8E4M3FN
    %0 = call @foo() : () -> f8E4M3FN
    %1 = arith.bitcast %cst : f8E4M3FN to i8
    %2 = arith.extui %1 : i8 to i64
    %3 = arith.bitcast %0 : f8E4M3FN to i8
    %4 = arith.extui %3 : i8 to i64
    %c10_i32 = arith.constant 10 : i32
    %5 = call @_mlir_apfloat_add(%c10_i32, %2, %4) : (i32, i64, i64) -> i64
    %6 = arith.trunci %5 : i64 to i8
    %7 = arith.bitcast %6 : i8 to f8E4M3FN
    vector.print %7 : f8E4M3FN
    %cst_0 = arith.constant 2.500000e+00 : f6E3M2FN
    %8 = call @bar() : () -> f6E3M2FN
    %9 = arith.bitcast %cst_0 : f6E3M2FN to i6
    %10 = arith.extui %9 : i6 to i64
    %11 = arith.bitcast %8 : f6E3M2FN to i6
    %12 = arith.extui %11 : i6 to i64
    %c16_i32 = arith.constant 16 : i32
    %13 = call @_mlir_apfloat_add(%c16_i32, %10, %12) : (i32, i64, i64) -> i64
    %14 = arith.trunci %13 : i64 to i6
    %15 = arith.bitcast %14 : i6 to f6E3M2FN
    vector.print %15 : f6E3M2FN
    return
  }
}

// -----
module {
  func.func private @_mlir_apfloat_add(i32, i64, i64) -> i64
  func.func @addf(%arg0: f4E2M1FN, %arg1: f4E2M1FN) {
    %0 = arith.bitcast %arg0 : f4E2M1FN to i4
    %1 = arith.extui %0 : i4 to i64
    %2 = arith.bitcast %arg1 : f4E2M1FN to i4
    %3 = arith.extui %2 : i4 to i64
    %c18_i32 = arith.constant 18 : i32
    %4 = call @_mlir_apfloat_add(%c18_i32, %1, %3) : (i32, i64, i64) -> i64
    %5 = arith.trunci %4 : i64 to i4
    %6 = arith.bitcast %5 : i4 to f4E2M1FN
    return
  }
}

// -----
// -----
module {
  func.func private @_mlir_apfloat_subtract(i32, i64, i64) -> i64
  func.func @subf(%arg0: f4E2M1FN, %arg1: f4E2M1FN) {
    %0 = arith.bitcast %arg0 : f4E2M1FN to i4
    %1 = arith.extui %0 : i4 to i64
    %2 = arith.bitcast %arg1 : f4E2M1FN to i4
    %3 = arith.extui %2 : i4 to i64
    %c18_i32 = arith.constant 18 : i32
    %4 = call @_mlir_apfloat_subtract(%c18_i32, %1, %3) : (i32, i64, i64) -> i64
    %5 = arith.trunci %4 : i64 to i4
    %6 = arith.bitcast %5 : i4 to f4E2M1FN
    return
  }
}

// -----
module {
  func.func private @_mlir_apfloat_multiply(i32, i64, i64) -> i64
  func.func @subf(%arg0: f4E2M1FN, %arg1: f4E2M1FN) {
    %0 = arith.bitcast %arg0 : f4E2M1FN to i4
    %1 = arith.extui %0 : i4 to i64
    %2 = arith.bitcast %arg1 : f4E2M1FN to i4
    %3 = arith.extui %2 : i4 to i64
    %c18_i32 = arith.constant 18 : i32
    %4 = call @_mlir_apfloat_multiply(%c18_i32, %1, %3) : (i32, i64, i64) -> i64
    %5 = arith.trunci %4 : i64 to i4
    %6 = arith.bitcast %5 : i4 to f4E2M1FN
    return
  }
}

// -----
module {
  func.func private @_mlir_apfloat_divide(i32, i64, i64) -> i64
  func.func @subf(%arg0: f4E2M1FN, %arg1: f4E2M1FN) {
    %0 = arith.bitcast %arg0 : f4E2M1FN to i4
    %1 = arith.extui %0 : i4 to i64
    %2 = arith.bitcast %arg1 : f4E2M1FN to i4
    %3 = arith.extui %2 : i4 to i64
    %c18_i32 = arith.constant 18 : i32
    %4 = call @_mlir_apfloat_divide(%c18_i32, %1, %3) : (i32, i64, i64) -> i64
    %5 = arith.trunci %4 : i64 to i4
    %6 = arith.bitcast %5 : i4 to f4E2M1FN
    return
  }
}

// -----
module {
  func.func private @_mlir_apfloat_remainder(i32, i64, i64) -> i64
  func.func @remf(%arg0: f4E2M1FN, %arg1: f4E2M1FN) {
    %0 = arith.bitcast %arg0 : f4E2M1FN to i4
    %1 = arith.extui %0 : i4 to i64
    %2 = arith.bitcast %arg1 : f4E2M1FN to i4
    %3 = arith.extui %2 : i4 to i64
    %c18_i32 = arith.constant 18 : i32
    %4 = call @_mlir_apfloat_remainder(%c18_i32, %1, %3) : (i32, i64, i64) -> i64
    %5 = arith.trunci %4 : i64 to i4
    %6 = arith.bitcast %5 : i4 to f4E2M1FN
    return
  }
}

// -----
module {
  func.func private @_mlir_apfloat_convert(i32, i32, i64) -> i64
  func.func @extf(%arg0: f4E2M1FN) {
    %0 = arith.bitcast %arg0 : f4E2M1FN to i4
    %1 = arith.extui %0 : i4 to i64
    %c18_i32 = arith.constant 18 : i32
    %c2_i32 = arith.constant 2 : i32
    %2 = call @_mlir_apfloat_convert(%c18_i32, %c2_i32, %1) : (i32, i32, i64) -> i64
    %3 = arith.trunci %2 : i64 to i32
    %4 = arith.bitcast %3 : i32 to f32
    return
  }
}

// -----
module {
  func.func private @_mlir_apfloat_convert(i32, i32, i64) -> i64
  func.func @truncf(%arg0: bf16) {
    %0 = arith.bitcast %arg0 : bf16 to i16
    %1 = arith.extui %0 : i16 to i64
    %c1_i32 = arith.constant 1 : i32
    %c18_i32 = arith.constant 18 : i32
    %2 = call @_mlir_apfloat_convert(%c1_i32, %c18_i32, %1) : (i32, i32, i64) -> i64
    %3 = arith.trunci %2 : i64 to i4
    %4 = arith.bitcast %3 : i4 to f4E2M1FN
    return
  }
}

// -----
module {
  func.func private @_mlir_apfloat_convert_to_int(i32, i32, i1, i64) -> i64
  func.func @fptosi(%arg0: f16) {
    %0 = arith.bitcast %arg0 : f16 to i16
    %1 = arith.extui %0 : i16 to i64
    %c0_i32 = arith.constant 0 : i32
    %c4_i32 = arith.constant 4 : i32
    %false = arith.constant false
    %2 = call @_mlir_apfloat_convert_to_int(%c0_i32, %c4_i32, %false, %1) : (i32, i32, i1, i64) -> i64
    %3 = arith.trunci %2 : i64 to i4
    return
  }
}

// -----
module {
  func.func private @_mlir_apfloat_convert_to_int(i32, i32, i1, i64) -> i64
  func.func @fptoui(%arg0: f16) {
    %0 = arith.bitcast %arg0 : f16 to i16
    %1 = arith.extui %0 : i16 to i64
    %c0_i32 = arith.constant 0 : i32
    %c4_i32 = arith.constant 4 : i32
    %true = arith.constant true
    %2 = call @_mlir_apfloat_convert_to_int(%c0_i32, %c4_i32, %true, %1) : (i32, i32, i1, i64) -> i64
    %3 = arith.trunci %2 : i64 to i4
    return
  }
}

// -----
module {
  func.func private @_mlir_apfloat_convert_from_int(i32, i32, i1, i64) -> i64
  func.func @sitofp(%arg0: i32) {
    %0 = arith.extsi %arg0 : i32 to i64
    %c18_i32 = arith.constant 18 : i32
    %c32_i32 = arith.constant 32 : i32
    %false = arith.constant false
    %1 = call @_mlir_apfloat_convert_from_int(%c18_i32, %c32_i32, %false, %0) : (i32, i32, i1, i64) -> i64
    %2 = arith.trunci %1 : i64 to i4
    %3 = arith.bitcast %2 : i4 to f4E2M1FN
    return
  }
}

// -----
module {
  func.func private @_mlir_apfloat_convert_from_int(i32, i32, i1, i64) -> i64
  func.func @uitofp(%arg0: i32) {
    %0 = arith.extui %arg0 : i32 to i64
    %c18_i32 = arith.constant 18 : i32
    %c32_i32 = arith.constant 32 : i32
    %true = arith.constant true
    %1 = call @_mlir_apfloat_convert_from_int(%c18_i32, %c32_i32, %true, %0) : (i32, i32, i1, i64) -> i64
    %2 = arith.trunci %1 : i64 to i4
    %3 = arith.bitcast %2 : i4 to f4E2M1FN
    return
  }
}

// -----
module {
  func.func private @_mlir_apfloat_compare(i32, i64, i64) -> i8
  func.func @cmpf(%arg0: f4E2M1FN, %arg1: f4E2M1FN) {
    %0 = arith.bitcast %arg0 : f4E2M1FN to i4
    %1 = arith.extui %0 : i4 to i64
    %2 = arith.bitcast %arg1 : f4E2M1FN to i4
    %3 = arith.extui %2 : i4 to i64
    %c18_i32 = arith.constant 18 : i32
    %4 = call @_mlir_apfloat_compare(%c18_i32, %1, %3) : (i32, i64, i64) -> i8
    %c3_i8 = arith.constant 3 : i8
    %5 = arith.cmpi eq, %4, %c3_i8 : i8
    %c0_i8 = arith.constant 0 : i8
    %6 = arith.cmpi eq, %4, %c0_i8 : i8
    %7 = arith.ori %5, %6 : i1
    return
  }
}

// -----
module {
  func.func private @_mlir_apfloat_neg(i32, i64) -> i64
  func.func @negf(%arg0: f32) {
    %0 = arith.bitcast %arg0 : f32 to i32
    %1 = arith.extui %0 : i32 to i64
    %c2_i32 = arith.constant 2 : i32
    %2 = call @_mlir_apfloat_neg(%c2_i32, %1) : (i32, i64) -> i64
    %3 = arith.trunci %2 : i64 to i32
    %4 = arith.bitcast %3 : i32 to f32
    return
  }
}

// -----
module {
  func.func private @_mlir_apfloat_minimum(i32, i64, i64) -> i64
  func.func @minimumf(%arg0: f32, %arg1: f32) {
    %0 = arith.bitcast %arg0 : f32 to i32
    %1 = arith.extui %0 : i32 to i64
    %2 = arith.bitcast %arg1 : f32 to i32
    %3 = arith.extui %2 : i32 to i64
    %c2_i32 = arith.constant 2 : i32
    %4 = call @_mlir_apfloat_minimum(%c2_i32, %1, %3) : (i32, i64, i64) -> i64
    %5 = arith.trunci %4 : i64 to i32
    %6 = arith.bitcast %5 : i32 to f32
    return
  }
}

// -----
module {
  func.func private @_mlir_apfloat_maximum(i32, i64, i64) -> i64
  func.func @maximumf(%arg0: f32, %arg1: f32) {
    %0 = arith.bitcast %arg0 : f32 to i32
    %1 = arith.extui %0 : i32 to i64
    %2 = arith.bitcast %arg1 : f32 to i32
    %3 = arith.extui %2 : i32 to i64
    %c2_i32 = arith.constant 2 : i32
    %4 = call @_mlir_apfloat_maximum(%c2_i32, %1, %3) : (i32, i64, i64) -> i64
    %5 = arith.trunci %4 : i64 to i32
    %6 = arith.bitcast %5 : i32 to f32
    return
  }
}

// -----
module {
  func.func private @_mlir_apfloat_minnum(i32, i64, i64) -> i64
  func.func @minnumf(%arg0: f32, %arg1: f32) {
    %0 = arith.bitcast %arg0 : f32 to i32
    %1 = arith.extui %0 : i32 to i64
    %2 = arith.bitcast %arg1 : f32 to i32
    %3 = arith.extui %2 : i32 to i64
    %c2_i32 = arith.constant 2 : i32
    %4 = call @_mlir_apfloat_minnum(%c2_i32, %1, %3) : (i32, i64, i64) -> i64
    %5 = arith.trunci %4 : i64 to i32
    %6 = arith.bitcast %5 : i32 to f32
    return
  }
}

// -----
module {
  func.func private @_mlir_apfloat_maxnum(i32, i64, i64) -> i64
  func.func @maxnumf(%arg0: f32, %arg1: f32) {
    %0 = arith.bitcast %arg0 : f32 to i32
    %1 = arith.extui %0 : i32 to i64
    %2 = arith.bitcast %arg1 : f32 to i32
    %3 = arith.extui %2 : i32 to i64
    %c2_i32 = arith.constant 2 : i32
    %4 = call @_mlir_apfloat_maxnum(%c2_i32, %1, %3) : (i32, i64, i64) -> i64
    %5 = arith.trunci %4 : i64 to i32
    %6 = arith.bitcast %5 : i32 to f32
    return
  }
}

// -----
module {
  func.func @unsupported_bitwidth(%arg0: f128, %arg1: f128, %arg2: f32) {
    %0 = arith.addf %arg0, %arg1 : f128
    %1 = arith.negf %arg0 : f128
    %2 = arith.cmpf ult, %arg0, %arg1 : f128
    %3 = arith.extf %arg2 : f32 to f128
    %4 = arith.truncf %arg0 : f128 to f32
    %5 = arith.fptosi %arg0 : f128 to i32
    %6 = arith.fptosi %arg2 : f32 to i92
    %7 = arith.sitofp %2 : i1 to f128
    %8 = arith.sitofp %6 : i92 to f32
    return
  }
}

// -----
module {
  func.func private @_mlir_apfloat_add(i32, i64, i64) -> i64
  func.func @addf_vector(%arg0: vector<4xf4E2M1FN>, %arg1: vector<4xf4E2M1FN>) {
    %0:4 = vector.to_elements %arg0 : vector<4xf4E2M1FN>
    %1:4 = vector.to_elements %arg1 : vector<4xf4E2M1FN>
    %2 = arith.bitcast %0#0 : f4E2M1FN to i4
    %3 = arith.extui %2 : i4 to i64
    %4 = arith.bitcast %1#0 : f4E2M1FN to i4
    %5 = arith.extui %4 : i4 to i64
    %c18_i32 = arith.constant 18 : i32
    %6 = call @_mlir_apfloat_add(%c18_i32, %3, %5) : (i32, i64, i64) -> i64
    %7 = arith.trunci %6 : i64 to i4
    %8 = arith.bitcast %7 : i4 to f4E2M1FN
    %9 = arith.bitcast %0#1 : f4E2M1FN to i4
    %10 = arith.extui %9 : i4 to i64
    %11 = arith.bitcast %1#1 : f4E2M1FN to i4
    %12 = arith.extui %11 : i4 to i64
    %c18_i32_0 = arith.constant 18 : i32
    %13 = call @_mlir_apfloat_add(%c18_i32_0, %10, %12) : (i32, i64, i64) -> i64
    %14 = arith.trunci %13 : i64 to i4
    %15 = arith.bitcast %14 : i4 to f4E2M1FN
    %16 = arith.bitcast %0#2 : f4E2M1FN to i4
    %17 = arith.extui %16 : i4 to i64
    %18 = arith.bitcast %1#2 : f4E2M1FN to i4
    %19 = arith.extui %18 : i4 to i64
    %c18_i32_1 = arith.constant 18 : i32
    %20 = call @_mlir_apfloat_add(%c18_i32_1, %17, %19) : (i32, i64, i64) -> i64
    %21 = arith.trunci %20 : i64 to i4
    %22 = arith.bitcast %21 : i4 to f4E2M1FN
    %23 = arith.bitcast %0#3 : f4E2M1FN to i4
    %24 = arith.extui %23 : i4 to i64
    %25 = arith.bitcast %1#3 : f4E2M1FN to i4
    %26 = arith.extui %25 : i4 to i64
    %c18_i32_2 = arith.constant 18 : i32
    %27 = call @_mlir_apfloat_add(%c18_i32_2, %24, %26) : (i32, i64, i64) -> i64
    %28 = arith.trunci %27 : i64 to i4
    %29 = arith.bitcast %28 : i4 to f4E2M1FN
    %30 = vector.from_elements %8, %15, %22, %29 : vector<4xf4E2M1FN>
    return
  }
}

