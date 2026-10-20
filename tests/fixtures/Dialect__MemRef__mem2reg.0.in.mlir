"builtin.module"() ({
  "func.func"() <{function_type = () -> i32, sym_name = "basic"}> ({
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %1 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%0, %1) : (i32, memref<i32>) -> ()
    %2 = "memref.load"(%1) : (memref<i32>) -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> i32, sym_name = "basic_default"}> ({
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %1 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    %2 = "memref.load"(%1) : (memref<i32>) -> i32
    "memref.store"(%0, %1) : (i32, memref<i32>) -> ()
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> f32, sym_name = "basic_float"}> ({
    %0 = "arith.constant"() <{value = 5.200000e+00 : f32}> : () -> f32
    %1 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f32>
    "memref.store"(%0, %1) : (f32, memref<f32>) -> ()
    %2 = "memref.load"(%1) : (memref<f32>) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> i32, sym_name = "basic_ranked"}> ({
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %2 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1x1xi32>
    "memref.store"(%1, %2, %0, %0) : (i32, memref<1x1xi32>, index, index) -> ()
    %3 = "memref.load"(%2, %0, %0) : (memref<1x1xi32>, index, index) -> i32
    "func.return"(%3) : (i32) -> ()
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
    %0 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i64>
    "memref.store"(%arg3, %0) : (i64, memref<i64>) -> ()
    "cf.cond_br"(%arg2)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // 2 preds: ^bb0, ^bb2
    %1 = "memref.load"(%0) : (memref<i64>) -> i64
    "func.call"(%1) <{callee = @use}> : (i64) -> ()
    "memref.store"(%arg1, %0) : (i64, memref<i64>) -> ()
    "cf.br"()[^bb2] : () -> ()
  ^bb2:  // 2 preds: ^bb0, ^bb1
    "cf.br"()[^bb1] : () -> ()
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
    %0 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<memref<memref<i64>>>
    %1 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<memref<i64>>
    %2 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i64>
    "memref.store"(%arg0, %2) : (i64, memref<i64>) -> ()
    "memref.store"(%2, %1) : (memref<i64>, memref<memref<i64>>) -> ()
    "memref.store"(%1, %0) : (memref<memref<i64>>, memref<memref<memref<i64>>>) -> ()
    %3 = "memref.load"(%0) : (memref<memref<memref<i64>>>) -> memref<memref<i64>>
    %4 = "memref.load"(%3) : (memref<memref<i64>>) -> memref<i64>
    %5 = "memref.load"(%4) : (memref<i64>) -> i64
    "func.return"(%5) : (i64) -> ()
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
    %1 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<memref<i32>>
    "memref.store"(%0, %1) : (memref<i32>, memref<memref<i32>>) -> ()
    %2 = "memref.load"(%1) : (memref<memref<i32>>) -> memref<i32>
    "func.call"(%0) <{callee = @use}> : (memref<i32>) -> ()
    %3 = "memref.load"(%0) : (memref<i32>) -> i32
    "func.return"(%3) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<i32>) -> (), sym_name = "use"}> ({
  ^bb0(%arg0: memref<i32>):
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

