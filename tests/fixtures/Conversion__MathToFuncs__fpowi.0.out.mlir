module {
}

// -----
module {
  func.func @fpowi32(%arg0: f64, %arg1: i32) {
    %0 = math.fpowi %arg0, %arg1 : f64, i32
    return
  }
}

// -----
module {
  func.func @fpowi64(%arg0: f64, %arg1: i64) {
    %0 = call @__mlir_math_fpowi_f64_i64(%arg0, %arg1) : (f64, i64) -> f64
    return
  }
  func.func private @__mlir_math_fpowi_f64_i64(%arg0: f64, %arg1: i64) -> f64 attributes {llvm.linkage = #llvm.linkage<linkonce_odr>} {
    %cst = arith.constant 1.000000e+00 : f64
    %c0_i64 = arith.constant 0 : i64
    %c1_i64 = arith.constant 1 : i64
    %c-9223372036854775808_i64 = arith.constant -9223372036854775808 : i64
    %c9223372036854775807_i64 = arith.constant 9223372036854775807 : i64
    %0 = arith.cmpi eq, %arg1, %c0_i64 : i64
    cf.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    return %cst : f64
  ^bb2:  // pred: ^bb0
    %1 = arith.cmpi sle, %arg1, %c0_i64 : i64
    %2 = arith.cmpi eq, %arg1, %c-9223372036854775808_i64 : i64
    %3 = arith.subi %c0_i64, %arg1 : i64
    %4 = arith.select %1, %3, %arg1 : i64
    %5 = arith.select %2, %c9223372036854775807_i64, %4 : i64
    cf.br ^bb3(%cst, %arg0, %5 : f64, f64, i64)
  ^bb3(%6: f64, %7: f64, %8: i64):  // 2 preds: ^bb2, ^bb6
    %9 = arith.andi %8, %c1_i64 : i64
    %10 = arith.cmpi ne, %9, %c0_i64 : i64
    cf.cond_br %10, ^bb4, ^bb5(%6 : f64)
  ^bb4:  // pred: ^bb3
    %11 = arith.mulf %6, %7 : f64
    cf.br ^bb5(%11 : f64)
  ^bb5(%12: f64):  // 2 preds: ^bb3, ^bb4
    %13 = arith.shrui %8, %c1_i64 : i64
    %14 = arith.cmpi eq, %13, %c0_i64 : i64
    cf.cond_br %14, ^bb7(%12 : f64), ^bb6
  ^bb6:  // pred: ^bb5
    %15 = arith.mulf %7, %7 : f64
    cf.br ^bb3(%12, %15, %13 : f64, f64, i64)
  ^bb7(%16: f64):  // pred: ^bb5
    cf.cond_br %2, ^bb8, ^bb9(%16 : f64)
  ^bb8:  // pred: ^bb7
    %17 = arith.mulf %16, %arg0 : f64
    cf.br ^bb9(%17 : f64)
  ^bb9(%18: f64):  // 2 preds: ^bb7, ^bb8
    cf.cond_br %1, ^bb10, ^bb11(%18 : f64)
  ^bb10:  // pred: ^bb9
    %19 = arith.divf %cst, %18 : f64
    cf.br ^bb11(%19 : f64)
  ^bb11(%20: f64):  // 2 preds: ^bb9, ^bb10
    return %20 : f64
  }
}

// -----
module {
  func.func @fpowi64_vec(%arg0: vector<2x3xf32>, %arg1: vector<2x3xi64>) {
    %cst = arith.constant dense<0.000000e+00> : vector<2x3xf32>
    %0 = vector.extract %arg0[0, 0] : f32 from vector<2x3xf32>
    %1 = vector.extract %arg1[0, 0] : i64 from vector<2x3xi64>
    %2 = call @__mlir_math_fpowi_f32_i64(%0, %1) : (f32, i64) -> f32
    %3 = vector.insert %2, %cst [0, 0] : f32 into vector<2x3xf32>
    %4 = vector.extract %arg0[0, 1] : f32 from vector<2x3xf32>
    %5 = vector.extract %arg1[0, 1] : i64 from vector<2x3xi64>
    %6 = call @__mlir_math_fpowi_f32_i64(%4, %5) : (f32, i64) -> f32
    %7 = vector.insert %6, %3 [0, 1] : f32 into vector<2x3xf32>
    %8 = vector.extract %arg0[0, 2] : f32 from vector<2x3xf32>
    %9 = vector.extract %arg1[0, 2] : i64 from vector<2x3xi64>
    %10 = call @__mlir_math_fpowi_f32_i64(%8, %9) : (f32, i64) -> f32
    %11 = vector.insert %10, %7 [0, 2] : f32 into vector<2x3xf32>
    %12 = vector.extract %arg0[1, 0] : f32 from vector<2x3xf32>
    %13 = vector.extract %arg1[1, 0] : i64 from vector<2x3xi64>
    %14 = call @__mlir_math_fpowi_f32_i64(%12, %13) : (f32, i64) -> f32
    %15 = vector.insert %14, %11 [1, 0] : f32 into vector<2x3xf32>
    %16 = vector.extract %arg0[1, 1] : f32 from vector<2x3xf32>
    %17 = vector.extract %arg1[1, 1] : i64 from vector<2x3xi64>
    %18 = call @__mlir_math_fpowi_f32_i64(%16, %17) : (f32, i64) -> f32
    %19 = vector.insert %18, %15 [1, 1] : f32 into vector<2x3xf32>
    %20 = vector.extract %arg0[1, 2] : f32 from vector<2x3xf32>
    %21 = vector.extract %arg1[1, 2] : i64 from vector<2x3xi64>
    %22 = call @__mlir_math_fpowi_f32_i64(%20, %21) : (f32, i64) -> f32
    %23 = vector.insert %22, %19 [1, 2] : f32 into vector<2x3xf32>
    return
  }
  func.func private @__mlir_math_fpowi_f32_i64(%arg0: f32, %arg1: i64) -> f32 attributes {llvm.linkage = #llvm.linkage<linkonce_odr>} {
    %cst = arith.constant 1.000000e+00 : f32
    %c0_i64 = arith.constant 0 : i64
    %c1_i64 = arith.constant 1 : i64
    %c-9223372036854775808_i64 = arith.constant -9223372036854775808 : i64
    %c9223372036854775807_i64 = arith.constant 9223372036854775807 : i64
    %0 = arith.cmpi eq, %arg1, %c0_i64 : i64
    cf.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    return %cst : f32
  ^bb2:  // pred: ^bb0
    %1 = arith.cmpi sle, %arg1, %c0_i64 : i64
    %2 = arith.cmpi eq, %arg1, %c-9223372036854775808_i64 : i64
    %3 = arith.subi %c0_i64, %arg1 : i64
    %4 = arith.select %1, %3, %arg1 : i64
    %5 = arith.select %2, %c9223372036854775807_i64, %4 : i64
    cf.br ^bb3(%cst, %arg0, %5 : f32, f32, i64)
  ^bb3(%6: f32, %7: f32, %8: i64):  // 2 preds: ^bb2, ^bb6
    %9 = arith.andi %8, %c1_i64 : i64
    %10 = arith.cmpi ne, %9, %c0_i64 : i64
    cf.cond_br %10, ^bb4, ^bb5(%6 : f32)
  ^bb4:  // pred: ^bb3
    %11 = arith.mulf %6, %7 : f32
    cf.br ^bb5(%11 : f32)
  ^bb5(%12: f32):  // 2 preds: ^bb3, ^bb4
    %13 = arith.shrui %8, %c1_i64 : i64
    %14 = arith.cmpi eq, %13, %c0_i64 : i64
    cf.cond_br %14, ^bb7(%12 : f32), ^bb6
  ^bb6:  // pred: ^bb5
    %15 = arith.mulf %7, %7 : f32
    cf.br ^bb3(%12, %15, %13 : f32, f32, i64)
  ^bb7(%16: f32):  // pred: ^bb5
    cf.cond_br %2, ^bb8, ^bb9(%16 : f32)
  ^bb8:  // pred: ^bb7
    %17 = arith.mulf %16, %arg0 : f32
    cf.br ^bb9(%17 : f32)
  ^bb9(%18: f32):  // 2 preds: ^bb7, ^bb8
    cf.cond_br %1, ^bb10, ^bb11(%18 : f32)
  ^bb10:  // pred: ^bb9
    %19 = arith.divf %cst, %18 : f32
    cf.br ^bb11(%19 : f32)
  ^bb11(%20: f32):  // 2 preds: ^bb9, ^bb10
    return %20 : f32
  }
}

