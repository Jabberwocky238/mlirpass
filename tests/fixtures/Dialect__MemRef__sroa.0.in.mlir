"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "basic"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2xi32>
    "memref.store"(%arg0, %2, %0) : (i32, memref<2xi32>, index) -> ()
    "memref.store"(%arg1, %2, %1) : (i32, memref<2xi32>, index) -> ()
    %3 = "memref.load"(%2, %0) : (memref<2xi32>, index) -> i32
    "func.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32, i32) -> i32, sym_name = "basic_high_dimensions"}> ({
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i32):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2x2xi32>
    "memref.store"(%arg0, %2, %0, %0) : (i32, memref<2x2xi32>, index, index) -> ()
    "memref.store"(%arg1, %2, %0, %1) : (i32, memref<2x2xi32>, index, index) -> ()
    "memref.store"(%arg2, %2, %1, %0) : (i32, memref<2x2xi32>, index, index) -> ()
    %3 = "memref.load"(%2, %0, %1) : (memref<2x2xi32>, index, index) -> i32
    "func.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "resolve_alias"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2xi32>
    "memref.store"(%arg0, %1, %0) : (i32, memref<2xi32>, index) -> ()
    "memref.store"(%arg1, %1, %0) : (i32, memref<2xi32>, index) -> ()
    %2 = "memref.load"(%1, %0) : (memref<2xi32>, index) -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "no_direct_use"}> ({
  ^bb0(%arg1: i32, %arg2: i32):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2xi32>
    "memref.store"(%arg1, %2, %0) : (i32, memref<2xi32>, index) -> ()
    "memref.store"(%arg2, %2, %1) : (i32, memref<2xi32>, index) -> ()
    %3 = "memref.load"(%2, %0) : (memref<2xi32>, index) -> i32
    "func.call"(%2) <{callee = @use}> : (memref<2xi32>) -> ()
    "func.return"(%3) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<2xi32>) -> (), sym_name = "use"}> ({
  ^bb0(%arg0: memref<2xi32>):
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32, index) -> i32, sym_name = "no_dynamic_indexing"}> ({
  ^bb0(%arg0: i32, %arg1: i32, %arg2: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2xi32>
    "memref.store"(%arg0, %1, %0) : (i32, memref<2xi32>, index) -> ()
    "memref.store"(%arg1, %1, %arg2) : (i32, memref<2xi32>, index) -> ()
    %2 = "memref.load"(%1, %0) : (memref<2xi32>, index) -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "no_dynamic_shape"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "memref.alloca"(%1) <{operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?x2xi32>
    "memref.store"(%arg0, %2, %0, %0) : (i32, memref<?x2xi32>, index, index) -> ()
    %3 = "memref.load"(%2, %0, %0) : (memref<?x2xi32>, index, index) -> i32
    "func.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "no_out_of_bound_write"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 100 : index}> : () -> index
    %2 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2xi32>
    "memref.store"(%arg0, %2, %0) : (i32, memref<2xi32>, index) -> ()
    "memref.store"(%arg1, %2, %1) : (i32, memref<2xi32>, index) -> ()
    %3 = "memref.load"(%2, %0) : (memref<2xi32>, index) -> i32
    "func.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "no_out_of_bound_load"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 100 : index}> : () -> index
    %2 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2xi32>
    "memref.store"(%arg0, %2, %0) : (i32, memref<2xi32>, index) -> ()
    %3 = "memref.load"(%2, %1) : (memref<2xi32>, index) -> i32
    "func.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

