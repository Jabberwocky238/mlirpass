"builtin.module"() ({
  "func.func"() <{function_type = (index) -> vector<11xi1>, sym_name = "genbool_var_1d"}> ({
  ^bb0(%arg1: index):
    %9 = "arith.constant"() <{value = dense<[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]> : vector<11xi32>}> : () -> vector<11xi32>
    %10 = "arith.constant"() <{value = 2147483647 : index}> : () -> index
    %11 = "arith.minsi"(%arg1, %10) : (index, index) -> index
    %12 = "arith.index_cast"(%11) : (index) -> i32
    %13 = "llvm.mlir.poison"() : () -> vector<11xi32>
    %14 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %15 = "llvm.insertelement"(%13, %12, %14) : (vector<11xi32>, i32, i32) -> vector<11xi32>
    %16 = "llvm.shufflevector"(%15, %13) <{mask = array<i32: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>}> : (vector<11xi32>, vector<11xi32>) -> vector<11xi32>
    %17 = "arith.cmpi"(%16, %9) <{predicate = 4 : i64}> : (vector<11xi32>, vector<11xi32>) -> vector<11xi1>
    "func.return"(%17) : (vector<11xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> vector<[11]xi1>, sym_name = "genbool_var_1d_scalable"}> ({
  ^bb0(%arg0: index):
    %0 = "llvm.intr.stepvector"() : () -> vector<[11]xi32>
    %1 = "arith.constant"() <{value = 2147483647 : index}> : () -> index
    %2 = "arith.minsi"(%arg0, %1) : (index, index) -> index
    %3 = "arith.index_cast"(%2) : (index) -> i32
    %4 = "llvm.mlir.poison"() : () -> vector<[11]xi32>
    %5 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %6 = "llvm.insertelement"(%4, %3, %5) : (vector<[11]xi32>, i32, i32) -> vector<[11]xi32>
    %7 = "llvm.shufflevector"(%6, %4) <{mask = array<i32: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>}> : (vector<[11]xi32>, vector<[11]xi32>) -> vector<[11]xi32>
    %8 = "arith.cmpi"(%0, %7) <{predicate = 2 : i64}> : (vector<[11]xi32>, vector<[11]xi32>) -> vector<[11]xi1>
    "func.return"(%8) : (vector<[11]xi1>) -> ()
  }) : () -> ()
}) : () -> ()

