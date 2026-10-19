"builtin.module"() ({
  "func.func"() <{function_type = (index) -> memref<?xf32>, sym_name = "single_alloc", sym_visibility = "private"}> ({
  ^bb0(%arg1: index):
    %1 = "memref.alloc"(%arg1) <{operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    "func.return"(%1) : (memref<?xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "single_alloc_test"}> ({
  ^bb0(%arg0: index):
    %0 = "func.call"(%arg0) <{callee = @single_alloc}> : (index) -> memref<?xf32>
    "test.sink"(%0) : (memref<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> (memref<?x?xf32>, memref<?xf32>), sym_name = "mult_alloc", sym_visibility = "private"}> ({
  ^bb0(%arg2: index, %arg3: index):
    %1 = "memref.alloc"(%arg2, %arg3) <{operandSegmentSizes = array<i32: 2, 0>}> : (index, index) -> memref<?x?xf32>
    %2 = "memref.alloc"(%arg3) <{operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    "func.return"(%1, %2) : (memref<?x?xf32>, memref<?xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> (), sym_name = "mult_alloc_test"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0:2 = "func.call"(%arg0, %arg1) <{callee = @mult_alloc}> : (index, index) -> (memref<?x?xf32>, memref<?xf32>)
    "test.sink"(%0#0, %0#1) : (memref<?x?xf32>, memref<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> (memref<?x?xf32>, memref<4xf32>, memref<?xf32>), sym_name = "complex_alloc", sym_visibility = "private"}> ({
  ^bb0(%arg2: index, %arg3: index):
    %1 = "memref.alloc"(%arg2, %arg3) <{operandSegmentSizes = array<i32: 2, 0>}> : (index, index) -> memref<?x?xf32>
    %2 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4xf32>
    %3 = "memref.alloc"(%arg3) <{operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    "func.return"(%1, %2, %3) : (memref<?x?xf32>, memref<4xf32>, memref<?xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> (), sym_name = "complex_alloc_test"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0:3 = "func.call"(%arg0, %arg1) <{callee = @complex_alloc}> : (index, index) -> (memref<?x?xf32>, memref<4xf32>, memref<?xf32>)
    "test.sink"(%0#0, %0#1, %0#2) : (memref<?x?xf32>, memref<4xf32>, memref<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

