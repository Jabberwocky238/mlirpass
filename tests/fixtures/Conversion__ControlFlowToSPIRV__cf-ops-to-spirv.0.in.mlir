"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32, i32) -> (), sym_name = "simple_loop"}> ({
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i32):
    "cf.br"()[^bb1] : () -> ()
  ^bb1:  // pred: ^bb0
    "cf.br"(%arg0)[^bb2] : (i32) -> ()
  ^bb2(%0: i32):  // 2 preds: ^bb1, ^bb3
    %1 = "arith.cmpi"(%0, %arg1) <{predicate = 2 : i64}> : (i32, i32) -> i1
    "cf.cond_br"(%1)[^bb3, ^bb4] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb3:  // pred: ^bb2
    %2 = "arith.addi"(%0, %arg2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "cf.br"(%2)[^bb2] : (i32) -> ()
  ^bb4:  // pred: ^bb2
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> (), sym_name = "main_graph"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    "cf.br"(%arg0)[^bb1] : (index) -> ()
  ^bb1(%1: index):  // 2 preds: ^bb0, ^bb2
    %2 = "arith.cmpi"(%1, %0) <{predicate = 2 : i64}> : (index, index) -> i1
    "cf.cond_br"(%2)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb2:  // pred: ^bb1
    "cf.br"(%0)[^bb1] : (index) -> ()
  ^bb3:  // pred: ^bb1
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

