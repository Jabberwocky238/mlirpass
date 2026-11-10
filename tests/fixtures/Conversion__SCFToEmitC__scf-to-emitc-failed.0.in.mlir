"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> vector<3xindex>, sym_name = "unsupported_type_vector"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = dense<0> : vector<3xindex>}> : () -> vector<3xindex>
    %1 = "scf.for"(%arg0, %arg1, %arg2, %0) ({
    ^bb0(%arg3: index, %arg4: vector<3xindex>):
      "scf.yield"(%arg4) : (vector<3xindex>) -> ()
    }) : (index, index, index, vector<3xindex>) -> vector<3xindex>
    "func.return"(%1) : (vector<3xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> (), sym_name = "while_with_memref_carried"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f64}> : () -> f64
    %2 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1xf64>
    "memref.store"(%1, %2, %0) : (f64, memref<1xf64>, index) -> ()
    %3:2 = "scf.while"(%0, %2) ({
    ^bb0(%arg3: index, %arg4: memref<1xf64>):
      %6 = "arith.cmpi"(%arg3, %arg0) <{predicate = 2 : i64}> : (index, index) -> i1
      "scf.condition"(%6, %arg3, %arg4) : (i1, index, memref<1xf64>) -> ()
    }, {
    ^bb0(%arg1: index, %arg2: memref<1xf64>):
      %4 = "arith.constant"() <{value = 1 : index}> : () -> index
      %5 = "arith.addi"(%arg1, %4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "scf.yield"(%5, %arg2) : (index, memref<1xf64>) -> ()
    }) : (index, memref<1xf64>) -> (index, memref<1xf64>)
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

