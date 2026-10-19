module {
  func.func @const_test() -> tensor<i32> {
    %cst = arith.constant dense<3> : tensor<i32>
    return %cst : tensor<i32>
  }
}

// -----
module {
  func.func @apply_scale_test_i32(%arg0: i32, %arg1: i32, %arg2: i8) -> i32 {
    %0 = arith.extui %arg2 : i8 to i32
    %c0_i32 = arith.constant 0 : i32
    %c1_i32 = arith.constant 1 : i32
    %c2_i32 = arith.constant 2 : i32
    %c30_i32 = arith.constant 30 : i32
    %c32_i32 = arith.constant 32 : i32
    %low, %high = arith.mulsi_extended %arg0, %arg1 : i32
    %1 = arith.cmpi sge, %0, %c32_i32 : i32
    %2 = arith.cmpi sgt, %0, %c32_i32 : i32
    %3 = arith.subi %c32_i32, %0 : i32
    %4 = arith.subi %0, %c32_i32 : i32
    %5 = arith.select %1, %c0_i32, %3 : i32
    %6 = arith.select %1, %4, %c0_i32 : i32
    %c-1_i32 = arith.constant -1 : i32
    %7 = arith.cmpi sge, %arg0, %c0_i32 : i32
    %8 = arith.select %7, %c1_i32, %c-1_i32 : i32
    %9 = arith.select %1, %8, %c0_i32 : i32
    %10 = arith.shrui %low, %c30_i32 : i32
    %11 = arith.addi %10, %9 : i32
    %12 = arith.shrsi %11, %c2_i32 : i32
    %13 = arith.shli %9, %c30_i32 : i32
    %14 = arith.addi %low, %13 : i32
    %15 = arith.addi %high, %12 : i32
    %16 = arith.subi %0, %c1_i32 : i32
    %17 = arith.shli %c1_i32, %16 : i32
    %18 = arith.select %2, %c0_i32, %17 : i32
    %19 = arith.addi %14, %18 : i32
    %20 = arith.cmpi ugt, %14, %19 : i32
    %21 = arith.extui %20 : i1 to i32
    %22 = arith.addi %15, %21 : i32
    %23 = arith.subi %6, %c1_i32 : i32
    %24 = arith.shli %c1_i32, %23 : i32
    %25 = arith.select %2, %24, %c0_i32 : i32
    %26 = arith.addi %22, %25 : i32
    %27 = arith.shli %26, %5 : i32
    %28 = arith.shrsi %27, %6 : i32
    %29 = arith.shrui %19, %0 : i32
    %30 = arith.select %1, %c0_i32, %29 : i32
    %31 = arith.addi %30, %28 : i32
    return %31 : i32
  }
}

// -----
module {
  func.func @apply_scale_test_vector(%arg0: vector<4xi32>, %arg1: vector<4xi32>, %arg2: vector<4xi8>) -> vector<4xi32> {
    %0 = arith.extui %arg2 : vector<4xi8> to vector<4xi32>
    %cst = arith.constant dense<0> : vector<4xi32>
    %cst_0 = arith.constant dense<1> : vector<4xi32>
    %cst_1 = arith.constant dense<2> : vector<4xi32>
    %cst_2 = arith.constant dense<30> : vector<4xi32>
    %cst_3 = arith.constant dense<32> : vector<4xi32>
    %low, %high = arith.mulsi_extended %arg0, %arg1 : vector<4xi32>
    %1 = arith.cmpi sge, %0, %cst_3 : vector<4xi32>
    %2 = arith.cmpi sgt, %0, %cst_3 : vector<4xi32>
    %3 = arith.subi %cst_3, %0 : vector<4xi32>
    %4 = arith.subi %0, %cst_3 : vector<4xi32>
    %5 = arith.select %1, %cst, %3 : vector<4xi1>, vector<4xi32>
    %6 = arith.select %1, %4, %cst : vector<4xi1>, vector<4xi32>
    %cst_4 = arith.constant dense<-1> : vector<4xi32>
    %7 = arith.cmpi sge, %arg0, %cst : vector<4xi32>
    %8 = arith.select %7, %cst_0, %cst_4 : vector<4xi1>, vector<4xi32>
    %9 = arith.select %1, %8, %cst : vector<4xi1>, vector<4xi32>
    %10 = arith.shrui %low, %cst_2 : vector<4xi32>
    %11 = arith.addi %10, %9 : vector<4xi32>
    %12 = arith.shrsi %11, %cst_1 : vector<4xi32>
    %13 = arith.shli %9, %cst_2 : vector<4xi32>
    %14 = arith.addi %low, %13 : vector<4xi32>
    %15 = arith.addi %high, %12 : vector<4xi32>
    %16 = arith.subi %0, %cst_0 : vector<4xi32>
    %17 = arith.shli %cst_0, %16 : vector<4xi32>
    %18 = arith.select %2, %cst, %17 : vector<4xi1>, vector<4xi32>
    %19 = arith.addi %14, %18 : vector<4xi32>
    %20 = arith.cmpi ugt, %14, %19 : vector<4xi32>
    %21 = arith.extui %20 : vector<4xi1> to vector<4xi32>
    %22 = arith.addi %15, %21 : vector<4xi32>
    %23 = arith.subi %6, %cst_0 : vector<4xi32>
    %24 = arith.shli %cst_0, %23 : vector<4xi32>
    %25 = arith.select %2, %24, %cst : vector<4xi1>, vector<4xi32>
    %26 = arith.addi %22, %25 : vector<4xi32>
    %27 = arith.shli %26, %5 : vector<4xi32>
    %28 = arith.shrsi %27, %6 : vector<4xi32>
    %29 = arith.shrui %19, %0 : vector<4xi32>
    %30 = arith.select %1, %cst, %29 : vector<4xi1>, vector<4xi32>
    %31 = arith.addi %30, %28 : vector<4xi32>
    return %31 : vector<4xi32>
  }
}

// -----
module {
  func.func @apply_scale_test_i48(%arg0: i48, %arg1: i32, %arg2: i8) -> i32 {
    %c0_i48 = arith.constant 0 : i48
    %c1_i64 = arith.constant 1 : i64
    %c31_i32 = arith.constant 31 : i32
    %0 = arith.extui %arg2 : i8 to i32
    %1 = arith.extsi %arg0 : i48 to i64
    %2 = arith.extsi %arg1 : i32 to i64
    %3 = arith.muli %1, %2 : i64
    %4 = arith.extui %0 : i32 to i64
    %5 = arith.shli %c1_i64, %4 : i64
    %6 = arith.shrui %5, %c1_i64 : i64
    %7 = arith.addi %3, %6 : i64
    %c1073741824_i64 = arith.constant 1073741824 : i64
    %c-1073741824_i64 = arith.constant -1073741824 : i64
    %8 = arith.cmpi sge, %arg0, %c0_i48 : i48
    %9 = arith.select %8, %c1073741824_i64, %c-1073741824_i64 : i64
    %10 = arith.addi %9, %7 : i64
    %11 = arith.cmpi sgt, %0, %c31_i32 : i32
    %12 = arith.select %11, %10, %7 : i64
    %13 = arith.shrsi %12, %4 : i64
    %14 = arith.trunci %13 : i64 to i32
    return %14 : i32
  }
}

// -----
module {
  func.func @apply_scale_test_i64(%arg0: i64, %arg1: i32, %arg2: i8) -> i32 {
    %c0_i64 = arith.constant 0 : i64
    %c1_i64 = arith.constant 1 : i64
    %c31_i32 = arith.constant 31 : i32
    %0 = arith.extui %arg2 : i8 to i32
    %1 = arith.extsi %arg1 : i32 to i64
    %2 = arith.muli %arg0, %1 : i64
    %3 = arith.extui %0 : i32 to i64
    %4 = arith.shli %c1_i64, %3 : i64
    %5 = arith.shrui %4, %c1_i64 : i64
    %6 = arith.addi %2, %5 : i64
    %c1073741824_i64 = arith.constant 1073741824 : i64
    %c-1073741824_i64 = arith.constant -1073741824 : i64
    %7 = arith.cmpi sge, %arg0, %c0_i64 : i64
    %8 = arith.select %7, %c1073741824_i64, %c-1073741824_i64 : i64
    %9 = arith.addi %8, %6 : i64
    %10 = arith.cmpi sgt, %0, %c31_i32 : i32
    %11 = arith.select %10, %9, %6 : i64
    %12 = arith.shrsi %11, %3 : i64
    %13 = arith.trunci %12 : i64 to i32
    return %13 : i32
  }
}

