module {
}

// -----
module {
  func.func @ipowi(%arg0: i64, %arg1: i64) {
    %0 = call @__mlir_math_ipowi_i64(%arg0, %arg1) : (i64, i64) -> i64
    return
  }
  func.func private @__mlir_math_ipowi_i64(%arg0: i64, %arg1: i64) -> i64 attributes {llvm.linkage = #llvm.linkage<linkonce_odr>} {
    %c0_i64 = arith.constant 0 : i64
    %c1_i64 = arith.constant 1 : i64
    %c-1_i64 = arith.constant -1 : i64
    %0 = arith.cmpi eq, %arg1, %c0_i64 : i64
    cf.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    return %c1_i64 : i64
  ^bb2:  // pred: ^bb0
    %1 = arith.cmpi sle, %arg1, %c0_i64 : i64
    cf.cond_br %1, ^bb3, ^bb12(%c1_i64, %arg0, %arg1 : i64, i64, i64)
  ^bb3:  // pred: ^bb2
    %2 = arith.cmpi eq, %arg0, %c0_i64 : i64
    cf.cond_br %2, ^bb4, ^bb5
  ^bb4:  // pred: ^bb3
    %3 = arith.divsi %c1_i64, %c0_i64 : i64
    return %3 : i64
  ^bb5:  // pred: ^bb3
    %4 = arith.cmpi eq, %arg0, %c1_i64 : i64
    cf.cond_br %4, ^bb6, ^bb7
  ^bb6:  // pred: ^bb5
    return %c1_i64 : i64
  ^bb7:  // pred: ^bb5
    %5 = arith.cmpi eq, %arg0, %c-1_i64 : i64
    cf.cond_br %5, ^bb8, ^bb11
  ^bb8:  // pred: ^bb7
    %6 = arith.andi %arg1, %c1_i64 : i64
    %7 = arith.cmpi ne, %6, %c0_i64 : i64
    cf.cond_br %7, ^bb9, ^bb10
  ^bb9:  // pred: ^bb8
    return %c-1_i64 : i64
  ^bb10:  // pred: ^bb8
    return %c1_i64 : i64
  ^bb11:  // pred: ^bb7
    return %c0_i64 : i64
  ^bb12(%8: i64, %9: i64, %10: i64):  // 2 preds: ^bb2, ^bb16
    %11 = arith.andi %10, %c1_i64 : i64
    %12 = arith.cmpi ne, %11, %c0_i64 : i64
    cf.cond_br %12, ^bb13, ^bb14(%8 : i64)
  ^bb13:  // pred: ^bb12
    %13 = arith.muli %8, %9 : i64
    cf.br ^bb14(%13 : i64)
  ^bb14(%14: i64):  // 2 preds: ^bb12, ^bb13
    %15 = arith.shrui %10, %c1_i64 : i64
    %16 = arith.cmpi eq, %15, %c0_i64 : i64
    cf.cond_br %16, ^bb15, ^bb16
  ^bb15:  // pred: ^bb14
    return %14 : i64
  ^bb16:  // pred: ^bb14
    %17 = arith.muli %9, %9 : i64
    cf.br ^bb12(%14, %17, %15 : i64, i64, i64)
  }
}

// -----
module {
  func.func @ipowi(%arg0: i8, %arg1: i8) {
    %0 = call @__mlir_math_ipowi_i8(%arg0, %arg1) : (i8, i8) -> i8
    return
  }
  func.func private @__mlir_math_ipowi_i8(%arg0: i8, %arg1: i8) -> i8 attributes {llvm.linkage = #llvm.linkage<linkonce_odr>} {
    %c0_i8 = arith.constant 0 : i8
    %c1_i8 = arith.constant 1 : i8
    %c-1_i8 = arith.constant -1 : i8
    %0 = arith.cmpi eq, %arg1, %c0_i8 : i8
    cf.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    return %c1_i8 : i8
  ^bb2:  // pred: ^bb0
    %1 = arith.cmpi sle, %arg1, %c0_i8 : i8
    cf.cond_br %1, ^bb3, ^bb12(%c1_i8, %arg0, %arg1 : i8, i8, i8)
  ^bb3:  // pred: ^bb2
    %2 = arith.cmpi eq, %arg0, %c0_i8 : i8
    cf.cond_br %2, ^bb4, ^bb5
  ^bb4:  // pred: ^bb3
    %3 = arith.divsi %c1_i8, %c0_i8 : i8
    return %3 : i8
  ^bb5:  // pred: ^bb3
    %4 = arith.cmpi eq, %arg0, %c1_i8 : i8
    cf.cond_br %4, ^bb6, ^bb7
  ^bb6:  // pred: ^bb5
    return %c1_i8 : i8
  ^bb7:  // pred: ^bb5
    %5 = arith.cmpi eq, %arg0, %c-1_i8 : i8
    cf.cond_br %5, ^bb8, ^bb11
  ^bb8:  // pred: ^bb7
    %6 = arith.andi %arg1, %c1_i8 : i8
    %7 = arith.cmpi ne, %6, %c0_i8 : i8
    cf.cond_br %7, ^bb9, ^bb10
  ^bb9:  // pred: ^bb8
    return %c-1_i8 : i8
  ^bb10:  // pred: ^bb8
    return %c1_i8 : i8
  ^bb11:  // pred: ^bb7
    return %c0_i8 : i8
  ^bb12(%8: i8, %9: i8, %10: i8):  // 2 preds: ^bb2, ^bb16
    %11 = arith.andi %10, %c1_i8 : i8
    %12 = arith.cmpi ne, %11, %c0_i8 : i8
    cf.cond_br %12, ^bb13, ^bb14(%8 : i8)
  ^bb13:  // pred: ^bb12
    %13 = arith.muli %8, %9 : i8
    cf.br ^bb14(%13 : i8)
  ^bb14(%14: i8):  // 2 preds: ^bb12, ^bb13
    %15 = arith.shrui %10, %c1_i8 : i8
    %16 = arith.cmpi eq, %15, %c0_i8 : i8
    cf.cond_br %16, ^bb15, ^bb16
  ^bb15:  // pred: ^bb14
    return %14 : i8
  ^bb16:  // pred: ^bb14
    %17 = arith.muli %9, %9 : i8
    cf.br ^bb12(%14, %17, %15 : i8, i8, i8)
  }
}

// -----
module {
  func.func @ipowi_vec(%arg0: vector<2x3xi64>, %arg1: vector<2x3xi64>) {
    %cst = arith.constant dense<0> : vector<2x3xi64>
    %0 = vector.extract %arg0[0, 0] : i64 from vector<2x3xi64>
    %1 = vector.extract %arg1[0, 0] : i64 from vector<2x3xi64>
    %2 = call @__mlir_math_ipowi_i64(%0, %1) : (i64, i64) -> i64
    %3 = vector.insert %2, %cst [0, 0] : i64 into vector<2x3xi64>
    %4 = vector.extract %arg0[0, 1] : i64 from vector<2x3xi64>
    %5 = vector.extract %arg1[0, 1] : i64 from vector<2x3xi64>
    %6 = call @__mlir_math_ipowi_i64(%4, %5) : (i64, i64) -> i64
    %7 = vector.insert %6, %3 [0, 1] : i64 into vector<2x3xi64>
    %8 = vector.extract %arg0[0, 2] : i64 from vector<2x3xi64>
    %9 = vector.extract %arg1[0, 2] : i64 from vector<2x3xi64>
    %10 = call @__mlir_math_ipowi_i64(%8, %9) : (i64, i64) -> i64
    %11 = vector.insert %10, %7 [0, 2] : i64 into vector<2x3xi64>
    %12 = vector.extract %arg0[1, 0] : i64 from vector<2x3xi64>
    %13 = vector.extract %arg1[1, 0] : i64 from vector<2x3xi64>
    %14 = call @__mlir_math_ipowi_i64(%12, %13) : (i64, i64) -> i64
    %15 = vector.insert %14, %11 [1, 0] : i64 into vector<2x3xi64>
    %16 = vector.extract %arg0[1, 1] : i64 from vector<2x3xi64>
    %17 = vector.extract %arg1[1, 1] : i64 from vector<2x3xi64>
    %18 = call @__mlir_math_ipowi_i64(%16, %17) : (i64, i64) -> i64
    %19 = vector.insert %18, %15 [1, 1] : i64 into vector<2x3xi64>
    %20 = vector.extract %arg0[1, 2] : i64 from vector<2x3xi64>
    %21 = vector.extract %arg1[1, 2] : i64 from vector<2x3xi64>
    %22 = call @__mlir_math_ipowi_i64(%20, %21) : (i64, i64) -> i64
    %23 = vector.insert %22, %19 [1, 2] : i64 into vector<2x3xi64>
    return
  }
  func.func private @__mlir_math_ipowi_i64(%arg0: i64, %arg1: i64) -> i64 attributes {llvm.linkage = #llvm.linkage<linkonce_odr>} {
    %c0_i64 = arith.constant 0 : i64
    %c1_i64 = arith.constant 1 : i64
    %c-1_i64 = arith.constant -1 : i64
    %0 = arith.cmpi eq, %arg1, %c0_i64 : i64
    cf.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    return %c1_i64 : i64
  ^bb2:  // pred: ^bb0
    %1 = arith.cmpi sle, %arg1, %c0_i64 : i64
    cf.cond_br %1, ^bb3, ^bb12(%c1_i64, %arg0, %arg1 : i64, i64, i64)
  ^bb3:  // pred: ^bb2
    %2 = arith.cmpi eq, %arg0, %c0_i64 : i64
    cf.cond_br %2, ^bb4, ^bb5
  ^bb4:  // pred: ^bb3
    %3 = arith.divsi %c1_i64, %c0_i64 : i64
    return %3 : i64
  ^bb5:  // pred: ^bb3
    %4 = arith.cmpi eq, %arg0, %c1_i64 : i64
    cf.cond_br %4, ^bb6, ^bb7
  ^bb6:  // pred: ^bb5
    return %c1_i64 : i64
  ^bb7:  // pred: ^bb5
    %5 = arith.cmpi eq, %arg0, %c-1_i64 : i64
    cf.cond_br %5, ^bb8, ^bb11
  ^bb8:  // pred: ^bb7
    %6 = arith.andi %arg1, %c1_i64 : i64
    %7 = arith.cmpi ne, %6, %c0_i64 : i64
    cf.cond_br %7, ^bb9, ^bb10
  ^bb9:  // pred: ^bb8
    return %c-1_i64 : i64
  ^bb10:  // pred: ^bb8
    return %c1_i64 : i64
  ^bb11:  // pred: ^bb7
    return %c0_i64 : i64
  ^bb12(%8: i64, %9: i64, %10: i64):  // 2 preds: ^bb2, ^bb16
    %11 = arith.andi %10, %c1_i64 : i64
    %12 = arith.cmpi ne, %11, %c0_i64 : i64
    cf.cond_br %12, ^bb13, ^bb14(%8 : i64)
  ^bb13:  // pred: ^bb12
    %13 = arith.muli %8, %9 : i64
    cf.br ^bb14(%13 : i64)
  ^bb14(%14: i64):  // 2 preds: ^bb12, ^bb13
    %15 = arith.shrui %10, %c1_i64 : i64
    %16 = arith.cmpi eq, %15, %c0_i64 : i64
    cf.cond_br %16, ^bb15, ^bb16
  ^bb15:  // pred: ^bb14
    return %14 : i64
  ^bb16:  // pred: ^bb14
    %17 = arith.muli %9, %9 : i64
    cf.br ^bb12(%14, %17, %15 : i64, i64, i64)
  }
}

// -----
module {
  func.func @ipowi_index(%arg0: index, %arg1: index) {
    %0 = math.ipowi %arg0, %arg1 : index
    return
  }
}

