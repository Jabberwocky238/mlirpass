"builtin.module"() ({
  "func.func"() <{function_type = (index) -> (), sym_name = "main"}> ({
  ^bb0(%arg1: index):
    %3 = "gpu.wait"() : () -> !gpu.async.token
    %4:2 = "gpu.alloc"(%3, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (!gpu.async.token, index) -> (memref<?xf32>, !gpu.async.token)
    %5 = "gpu.dealloc"(%4#1, %4#0) : (!gpu.async.token, memref<?xf32>) -> !gpu.async.token
    "gpu.wait"(%5) : (!gpu.async.token) -> ()
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

