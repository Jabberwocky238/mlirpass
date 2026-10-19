"builtin.module"() ({
  "func.func"() <{function_type = (index, memref<?xf32>) -> (), sym_name = "single_alloc", sym_visibility = "private"}> ({
  ^bb0(%arg1: index, %arg2: memref<?xf32>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "single_alloc_test"}> ({
  ^bb0(%arg0: index):
    %0 = "memref.alloc"(%arg0) <{operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    "func.call"(%arg0, %0) <{callee = @single_alloc}> : (index, memref<?xf32>) -> ()
    "test.sink"(%0) : (memref<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, memref<?x?xf32>, memref<?xf32>) -> (), sym_name = "mult_alloc", sym_visibility = "private"}> ({
  ^bb0(%arg2: index, %arg3: index, %arg4: memref<?x?xf32>, %arg5: memref<?xf32>):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> (), sym_name = "mult_alloc_test"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "memref.alloc"(%arg0, %arg1) <{operandSegmentSizes = array<i32: 2, 0>}> : (index, index) -> memref<?x?xf32>
    %1 = "memref.alloc"(%arg1) <{operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    "func.call"(%arg0, %arg1, %0, %1) <{callee = @mult_alloc}> : (index, index, memref<?x?xf32>, memref<?xf32>) -> ()
    "test.sink"(%0, %1) : (memref<?x?xf32>, memref<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, memref<?x?xf32>, memref<4xf32>, memref<?xf32>) -> (), sym_name = "complex_alloc", sym_visibility = "private"}> ({
  ^bb0(%arg2: index, %arg3: index, %arg4: memref<?x?xf32>, %arg5: memref<4xf32>, %arg6: memref<?xf32>):
    %3 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4xf32>
    "memref.copy"(%3, %arg5) : (memref<4xf32>, memref<4xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> (), sym_name = "complex_alloc_test"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "memref.alloc"(%arg0, %arg1) <{operandSegmentSizes = array<i32: 2, 0>}> : (index, index) -> memref<?x?xf32>
    %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4xf32>
    %2 = "memref.alloc"(%arg1) <{operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    "func.call"(%arg0, %arg1, %0, %1, %2) <{callee = @complex_alloc}> : (index, index, memref<?x?xf32>, memref<4xf32>, memref<?xf32>) -> ()
    "test.sink"(%0, %1, %2) : (memref<?x?xf32>, memref<4xf32>, memref<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

