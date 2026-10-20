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

