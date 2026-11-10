"builtin.module"() ({
  "func.func"() <{function_type = (i1, i1) -> (), sym_name = "bool"}> ({
  ^bb0(%arg0: i1, %arg1: i1):
    %0 = "arith.addi"(%arg0, %arg1) <{overflowFlags = #arith.overflow<none>}> : (i1, i1) -> i1
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xi32>, vector<4xi32>) -> (), sym_name = "vector"}> ({
  ^bb0(%arg0: vector<4xi32>, %arg1: vector<4xi32>):
    %0 = "arith.addi"(%arg0, %arg1) <{overflowFlags = #arith.overflow<none>}> : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i4, i4) -> (), sym_name = "unsuppoted_emitc_type"}> ({
  ^bb0(%arg0: i4, %arg1: i4):
    %0 = "arith.addi"(%arg0, %arg1) <{overflowFlags = #arith.overflow<none>}> : (i4, i4) -> i4
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> memref<i64>, sym_name = "rank0_constant", sym_visibility = "private"}> ({
    %0 = "arith.constant"() <{value = dense<-1> : memref<i64>}> : () -> memref<i64>
    "func.return"(%0) : (memref<i64>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> memref<1xi64>, sym_name = "rank1_constant", sym_visibility = "private"}> ({
    %0 = "arith.constant"() <{value = dense<-1> : memref<1xi64>}> : () -> memref<1xi64>
    "func.return"(%0) : (memref<1xi64>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> memref<1x1xi64>, sym_name = "rank2_constant", sym_visibility = "private"}> ({
    %0 = "arith.constant"() <{value = dense<-1> : memref<1x1xi64>}> : () -> memref<1x1xi64>
    "func.return"(%0) : (memref<1x1xi64>) -> ()
  }) : () -> ()
}) : () -> ()

