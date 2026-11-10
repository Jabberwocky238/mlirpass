"builtin.module"() ({
  "func.func"() <{function_type = (index) -> (), sym_name = "main"}> ({
  ^bb0(%arg2: index):
    %4 = "gpu.wait"() : () -> !gpu.async.token
    %5:2 = "gpu.alloc"(%4, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (!gpu.async.token, index) -> (memref<?xf32>, !gpu.async.token)
    %6 = "gpu.dealloc"(%5#1, %5#0) : (!gpu.async.token, memref<?xf32>) -> !gpu.async.token
    "gpu.wait"(%6) : (!gpu.async.token) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "alloc_dealloc_sync"}> ({
  ^bb0(%arg1: index):
    %3 = "gpu.alloc"(%arg1) <{operandSegmentSizes = array<i32: 0, 1, 0>}> : (index) -> memref<?xf32>
    "gpu.dealloc"(%3) : (memref<?xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "alloc_sync"}> ({
  ^bb0(%arg0: index):
    %0 = "gpu.alloc"(%arg0) <{hostShared, operandSegmentSizes = array<i32: 0, 1, 0>}> : (index) -> memref<?xf32>
    %1 = "gpu.wait"() : () -> !gpu.async.token
    %2 = "gpu.dealloc"(%1, %0) : (!gpu.async.token, memref<?xf32>) -> !gpu.async.token
    "gpu.wait"(%2) : (!gpu.async.token) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> (), sym_name = "multi_dep_unsupported"}> ({
  ^bb0(%arg0: index):
    %0 = "gpu.wait"() : () -> !gpu.async.token
    %1 = "gpu.wait"() : () -> !gpu.async.token
    %2:2 = "gpu.alloc"(%0, %1, %arg0) <{operandSegmentSizes = array<i32: 2, 1, 0>}> : (!gpu.async.token, !gpu.async.token, index) -> (memref<?xf32>, !gpu.async.token)
    %3 = "gpu.dealloc"(%2#1, %0, %2#0) : (!gpu.async.token, !gpu.async.token, memref<?xf32>) -> !gpu.async.token
    "gpu.wait"(%3) : (!gpu.async.token) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()

