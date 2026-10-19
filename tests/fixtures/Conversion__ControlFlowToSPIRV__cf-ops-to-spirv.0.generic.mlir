"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32, i32) -> (), sym_name = "simple_loop"}> ({
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i32):
    "spirv.Branch"()[^bb1] : () -> ()
  ^bb1:  // pred: ^bb0
    "spirv.Branch"(%arg0)[^bb2] : (i32) -> ()
  ^bb2(%0: i32):  // 2 preds: ^bb1, ^bb3
    %1 = "arith.cmpi"(%0, %arg1) <{predicate = 2 : i64}> : (i32, i32) -> i1
    "spirv.BranchConditional"(%1)[^bb3, ^bb4] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb3:  // pred: ^bb2
    %2 = "arith.addi"(%0, %arg2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "spirv.Branch"(%2)[^bb2] : (i32) -> ()
  ^bb4:  // pred: ^bb2
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> (), sym_name = "main_graph"}> ({
  ^bb0(%arg0: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (index) -> i32
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "builtin.unrealized_conversion_cast"(%1) : (index) -> i32
    "spirv.Branch"(%0)[^bb1] : (i32) -> ()
  ^bb1(%3: i32):  // 2 preds: ^bb0, ^bb2
    %4 = "builtin.unrealized_conversion_cast"(%3) : (i32) -> index
    %5 = "arith.cmpi"(%4, %1) <{predicate = 2 : i64}> : (index, index) -> i1
    "spirv.BranchConditional"(%5)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb2:  // pred: ^bb1
    "spirv.Branch"(%2)[^bb1] : (i32) -> ()
  ^bb3:  // pred: ^bb1
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

