"builtin.module"() ({
  "func.func"() <{function_type = () -> i32, sym_name = "basic"}> ({
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> i32, sym_name = "basic_default"}> ({
    %0 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    %1 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> f32, sym_name = "basic_float"}> ({
    %0 = "arith.constant"() <{value = 5.200000e+00 : f32}> : () -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> i32, sym_name = "basic_ranked"}> ({
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> i32, sym_name = "reject_multiple_elements"}> ({
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %2 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1x2xi32>
    "memref.store"(%1, %2, %0, %0) : (i32, memref<1x2xi32>, index, index) -> ()
    %3 = "memref.load"(%2, %0, %0) : (memref<1x2xi32>, index, index) -> i32
    "func.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i64, i1, i64) -> (), sym_name = "cycle"}> ({
  ^bb0(%arg1: i64, %arg2: i1, %arg3: i64):
    "cf.cond_br"(%arg2, %arg3, %arg3)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 1, 1>}> : (i1, i64, i64) -> ()
  ^bb1(%0: i64):  // 2 preds: ^bb0, ^bb2
    "func.call"(%0) <{callee = @use}> : (i64) -> ()
    "cf.br"(%arg1)[^bb2] : (i64) -> ()
  ^bb2(%1: i64):  // 2 preds: ^bb0, ^bb1
    "cf.br"(%1)[^bb1] : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64) -> (), sym_name = "use"}> ({
  ^bb0(%arg0: i64):
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i64) -> i64, sym_name = "recursive"}> ({
  ^bb0(%arg0: i64):
    "func.return"(%arg0) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<memref<i32>>) -> i32, sym_name = "deny_store_of_alloca"}> ({
  ^bb0(%arg0: memref<memref<i32>>):
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %1 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%0, %1) : (i32, memref<i32>) -> ()
    "memref.store"(%1, %arg0) : (memref<i32>, memref<memref<i32>>) -> ()
    %2 = "memref.load"(%1) : (memref<i32>) -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> i32, sym_name = "promotable_nonpromotable_intertwined"}> ({
    %0 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "func.call"(%0) <{callee = @use}> : (memref<i32>) -> ()
    %1 = "memref.load"(%0) : (memref<i32>) -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<i32>) -> (), sym_name = "use"}> ({
  ^bb0(%arg0: memref<i32>):
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "unused_alloca_store_loop"}> ({
    %0 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    "cf.br"()[^bb1] : () -> ()
  ^bb1:  // 2 preds: ^bb0, ^bb1
    "cf.br"()[^bb1] : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> i32, sym_name = "store_back_to_alloca"}> ({
  ^bb0(%arg0: i1):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    "cf.cond_br"(%arg0)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "cf.br"(%0)[^bb3] : (i32) -> ()
  ^bb2:  // pred: ^bb0
    "cf.br"(%1)[^bb3] : (i32) -> ()
  ^bb3(%2: i32):  // 2 preds: ^bb1, ^bb2
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> i32, sym_name = "merge_point_used_by_erased_op"}> ({
  ^bb0(%arg0: i1):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    "cf.cond_br"(%arg0)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "cf.br"()[^bb3] : () -> ()
  ^bb2:  // pred: ^bb0
    "cf.br"()[^bb3] : () -> ()
  ^bb3:  // 2 preds: ^bb1, ^bb2
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, i1) -> i32, sym_name = "two_consecutive_merge_points"}> ({
  ^bb0(%arg0: i1, %arg1: i1):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    "cf.cond_br"(%arg0)[^bb2, ^bb1] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "cf.cond_br"(%arg1)[^bb3, ^bb5] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb2:  // pred: ^bb0
    "cf.br"(%0)[^bb4] : (i32) -> ()
  ^bb3:  // pred: ^bb1
    "cf.br"(%1)[^bb4] : (i32) -> ()
  ^bb4(%3: i32):  // 2 preds: ^bb2, ^bb3
    "cf.br"(%3)[^bb6] : (i32) -> ()
  ^bb5:  // pred: ^bb1
    "cf.br"(%2)[^bb6] : (i32) -> ()
  ^bb6(%4: i32):  // 2 preds: ^bb4, ^bb5
    "func.return"(%4) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

