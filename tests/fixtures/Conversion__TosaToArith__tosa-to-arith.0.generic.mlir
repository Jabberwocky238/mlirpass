"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<i32>, sym_name = "const_test"}> ({
    %0 = "arith.constant"() <{value = dense<3> : tensor<i32>}> : () -> tensor<i32>
    "func.return"(%0) : (tensor<i32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32, i8) -> i32, sym_name = "apply_scale_test_i32"}> ({
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i8):
    %0 = "arith.extui"(%arg2) : (i8) -> i32
    %1 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %4 = "arith.constant"() <{value = 30 : i32}> : () -> i32
    %5 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %6:2 = "arith.mulsi_extended"(%arg0, %arg1) : (i32, i32) -> (i32, i32)
    %7 = "arith.cmpi"(%0, %5) <{predicate = 5 : i64}> : (i32, i32) -> i1
    %8 = "arith.cmpi"(%0, %5) <{predicate = 4 : i64}> : (i32, i32) -> i1
    %9 = "arith.subi"(%5, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %10 = "arith.subi"(%0, %5) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %11 = "arith.select"(%7, %1, %9) : (i1, i32, i32) -> i32
    %12 = "arith.select"(%7, %10, %1) : (i1, i32, i32) -> i32
    %13 = "arith.constant"() <{value = -1 : i32}> : () -> i32
    %14 = "arith.cmpi"(%arg0, %1) <{predicate = 5 : i64}> : (i32, i32) -> i1
    %15 = "arith.select"(%14, %2, %13) : (i1, i32, i32) -> i32
    %16 = "arith.select"(%7, %15, %1) : (i1, i32, i32) -> i32
    %17 = "arith.shrui"(%6#0, %4) : (i32, i32) -> i32
    %18 = "arith.addi"(%17, %16) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %19 = "arith.shrsi"(%18, %3) : (i32, i32) -> i32
    %20 = "arith.shli"(%16, %4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %21 = "arith.addi"(%6#0, %20) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %22 = "arith.addi"(%6#1, %19) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %23 = "arith.subi"(%0, %2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %24 = "arith.shli"(%2, %23) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %25 = "arith.select"(%8, %1, %24) : (i1, i32, i32) -> i32
    %26 = "arith.addi"(%21, %25) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %27 = "arith.cmpi"(%21, %26) <{predicate = 8 : i64}> : (i32, i32) -> i1
    %28 = "arith.extui"(%27) : (i1) -> i32
    %29 = "arith.addi"(%22, %28) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %30 = "arith.subi"(%12, %2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %31 = "arith.shli"(%2, %30) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %32 = "arith.select"(%8, %31, %1) : (i1, i32, i32) -> i32
    %33 = "arith.addi"(%29, %32) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %34 = "arith.shli"(%33, %11) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %35 = "arith.shrsi"(%34, %12) : (i32, i32) -> i32
    %36 = "arith.shrui"(%26, %0) : (i32, i32) -> i32
    %37 = "arith.select"(%7, %1, %36) : (i1, i32, i32) -> i32
    %38 = "arith.addi"(%37, %35) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%38) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xi32>, vector<4xi32>, vector<4xi8>) -> vector<4xi32>, sym_name = "apply_scale_test_vector"}> ({
  ^bb0(%arg0: vector<4xi32>, %arg1: vector<4xi32>, %arg2: vector<4xi8>):
    %0 = "arith.extui"(%arg2) : (vector<4xi8>) -> vector<4xi32>
    %1 = "arith.constant"() <{value = dense<0> : vector<4xi32>}> : () -> vector<4xi32>
    %2 = "arith.constant"() <{value = dense<1> : vector<4xi32>}> : () -> vector<4xi32>
    %3 = "arith.constant"() <{value = dense<2> : vector<4xi32>}> : () -> vector<4xi32>
    %4 = "arith.constant"() <{value = dense<30> : vector<4xi32>}> : () -> vector<4xi32>
    %5 = "arith.constant"() <{value = dense<32> : vector<4xi32>}> : () -> vector<4xi32>
    %6:2 = "arith.mulsi_extended"(%arg0, %arg1) : (vector<4xi32>, vector<4xi32>) -> (vector<4xi32>, vector<4xi32>)
    %7 = "arith.cmpi"(%0, %5) <{predicate = 5 : i64}> : (vector<4xi32>, vector<4xi32>) -> vector<4xi1>
    %8 = "arith.cmpi"(%0, %5) <{predicate = 4 : i64}> : (vector<4xi32>, vector<4xi32>) -> vector<4xi1>
    %9 = "arith.subi"(%5, %0) <{overflowFlags = #arith.overflow<none>}> : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %10 = "arith.subi"(%0, %5) <{overflowFlags = #arith.overflow<none>}> : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %11 = "arith.select"(%7, %1, %9) : (vector<4xi1>, vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %12 = "arith.select"(%7, %10, %1) : (vector<4xi1>, vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %13 = "arith.constant"() <{value = dense<-1> : vector<4xi32>}> : () -> vector<4xi32>
    %14 = "arith.cmpi"(%arg0, %1) <{predicate = 5 : i64}> : (vector<4xi32>, vector<4xi32>) -> vector<4xi1>
    %15 = "arith.select"(%14, %2, %13) : (vector<4xi1>, vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %16 = "arith.select"(%7, %15, %1) : (vector<4xi1>, vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %17 = "arith.shrui"(%6#0, %4) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %18 = "arith.addi"(%17, %16) <{overflowFlags = #arith.overflow<none>}> : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %19 = "arith.shrsi"(%18, %3) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %20 = "arith.shli"(%16, %4) <{overflowFlags = #arith.overflow<none>}> : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %21 = "arith.addi"(%6#0, %20) <{overflowFlags = #arith.overflow<none>}> : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %22 = "arith.addi"(%6#1, %19) <{overflowFlags = #arith.overflow<none>}> : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %23 = "arith.subi"(%0, %2) <{overflowFlags = #arith.overflow<none>}> : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %24 = "arith.shli"(%2, %23) <{overflowFlags = #arith.overflow<none>}> : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %25 = "arith.select"(%8, %1, %24) : (vector<4xi1>, vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %26 = "arith.addi"(%21, %25) <{overflowFlags = #arith.overflow<none>}> : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %27 = "arith.cmpi"(%21, %26) <{predicate = 8 : i64}> : (vector<4xi32>, vector<4xi32>) -> vector<4xi1>
    %28 = "arith.extui"(%27) : (vector<4xi1>) -> vector<4xi32>
    %29 = "arith.addi"(%22, %28) <{overflowFlags = #arith.overflow<none>}> : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %30 = "arith.subi"(%12, %2) <{overflowFlags = #arith.overflow<none>}> : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %31 = "arith.shli"(%2, %30) <{overflowFlags = #arith.overflow<none>}> : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %32 = "arith.select"(%8, %31, %1) : (vector<4xi1>, vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %33 = "arith.addi"(%29, %32) <{overflowFlags = #arith.overflow<none>}> : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %34 = "arith.shli"(%33, %11) <{overflowFlags = #arith.overflow<none>}> : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %35 = "arith.shrsi"(%34, %12) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %36 = "arith.shrui"(%26, %0) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %37 = "arith.select"(%7, %1, %36) : (vector<4xi1>, vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %38 = "arith.addi"(%37, %35) <{overflowFlags = #arith.overflow<none>}> : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    "func.return"(%38) : (vector<4xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i48, i32, i8) -> i32, sym_name = "apply_scale_test_i48"}> ({
  ^bb0(%arg0: i48, %arg1: i32, %arg2: i8):
    %0 = "arith.constant"() <{value = 0 : i48}> : () -> i48
    %1 = "arith.constant"() <{value = 1 : i64}> : () -> i64
    %2 = "arith.constant"() <{value = 31 : i32}> : () -> i32
    %3 = "arith.extui"(%arg2) : (i8) -> i32
    %4 = "arith.extsi"(%arg0) : (i48) -> i64
    %5 = "arith.extsi"(%arg1) : (i32) -> i64
    %6 = "arith.muli"(%4, %5) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %7 = "arith.extui"(%3) : (i32) -> i64
    %8 = "arith.shli"(%1, %7) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %9 = "arith.shrui"(%8, %1) : (i64, i64) -> i64
    %10 = "arith.addi"(%6, %9) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %11 = "arith.constant"() <{value = 1073741824 : i64}> : () -> i64
    %12 = "arith.constant"() <{value = -1073741824 : i64}> : () -> i64
    %13 = "arith.cmpi"(%arg0, %0) <{predicate = 5 : i64}> : (i48, i48) -> i1
    %14 = "arith.select"(%13, %11, %12) : (i1, i64, i64) -> i64
    %15 = "arith.addi"(%14, %10) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %16 = "arith.cmpi"(%3, %2) <{predicate = 4 : i64}> : (i32, i32) -> i1
    %17 = "arith.select"(%16, %15, %10) : (i1, i64, i64) -> i64
    %18 = "arith.shrsi"(%17, %7) : (i64, i64) -> i64
    %19 = "arith.trunci"(%18) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i32
    "func.return"(%19) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i64, i32, i8) -> i32, sym_name = "apply_scale_test_i64"}> ({
  ^bb0(%arg0: i64, %arg1: i32, %arg2: i8):
    %0 = "arith.constant"() <{value = 0 : i64}> : () -> i64
    %1 = "arith.constant"() <{value = 1 : i64}> : () -> i64
    %2 = "arith.constant"() <{value = 31 : i32}> : () -> i32
    %3 = "arith.extui"(%arg2) : (i8) -> i32
    %4 = "arith.extsi"(%arg1) : (i32) -> i64
    %5 = "arith.muli"(%arg0, %4) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %6 = "arith.extui"(%3) : (i32) -> i64
    %7 = "arith.shli"(%1, %6) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %8 = "arith.shrui"(%7, %1) : (i64, i64) -> i64
    %9 = "arith.addi"(%5, %8) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %10 = "arith.constant"() <{value = 1073741824 : i64}> : () -> i64
    %11 = "arith.constant"() <{value = -1073741824 : i64}> : () -> i64
    %12 = "arith.cmpi"(%arg0, %0) <{predicate = 5 : i64}> : (i64, i64) -> i1
    %13 = "arith.select"(%12, %10, %11) : (i1, i64, i64) -> i64
    %14 = "arith.addi"(%13, %9) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %15 = "arith.cmpi"(%3, %2) <{predicate = 4 : i64}> : (i32, i32) -> i1
    %16 = "arith.select"(%15, %14, %9) : (i1, i64, i64) -> i64
    %17 = "arith.shrsi"(%16, %6) : (i64, i64) -> i64
    %18 = "arith.trunci"(%17) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i32
    "func.return"(%18) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

