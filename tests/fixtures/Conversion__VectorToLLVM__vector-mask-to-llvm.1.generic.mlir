"builtin.module"() ({
  "func.func"() <{function_type = (index) -> vector<11xi1>, sym_name = "genbool_var_1d"}> ({
  ^bb0(%arg1: index):
    %7 = "arith.constant"() <{value = dense<[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]> : vector<11xi64>}> : () -> vector<11xi64>
    %8 = "arith.index_cast"(%arg1) : (index) -> i64
    %9 = "llvm.mlir.poison"() : () -> vector<11xi64>
    %10 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %11 = "llvm.insertelement"(%9, %8, %10) : (vector<11xi64>, i64, i32) -> vector<11xi64>
    %12 = "llvm.shufflevector"(%11, %9) <{mask = array<i32: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>}> : (vector<11xi64>, vector<11xi64>) -> vector<11xi64>
    %13 = "arith.cmpi"(%12, %7) <{predicate = 4 : i64}> : (vector<11xi64>, vector<11xi64>) -> vector<11xi1>
    "func.return"(%13) : (vector<11xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> vector<[11]xi1>, sym_name = "genbool_var_1d_scalable"}> ({
  ^bb0(%arg0: index):
    %0 = "llvm.intr.stepvector"() : () -> vector<[11]xi64>
    %1 = "arith.index_cast"(%arg0) : (index) -> i64
    %2 = "llvm.mlir.poison"() : () -> vector<[11]xi64>
    %3 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %4 = "llvm.insertelement"(%2, %1, %3) : (vector<[11]xi64>, i64, i32) -> vector<[11]xi64>
    %5 = "llvm.shufflevector"(%4, %2) <{mask = array<i32: 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>}> : (vector<[11]xi64>, vector<[11]xi64>) -> vector<[11]xi64>
    %6 = "arith.cmpi"(%0, %5) <{predicate = 2 : i64}> : (vector<[11]xi64>, vector<[11]xi64>) -> vector<[11]xi1>
    "func.return"(%6) : (vector<[11]xi1>) -> ()
  }) : () -> ()
}) : () -> ()

