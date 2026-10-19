"builtin.module"() ({
  "builtin.module"() ({
    "func.func"() <{function_type = (memref<7xf32, 1>, memref<7xf32>) -> (), sym_name = "foo"}> ({
    ^bb0(%arg2: memref<7xf32, 1>, %arg3: memref<7xf32>):
      %2 = "gpu.wait"() : () -> !gpu.async.token
      %3 = "gpu.memcpy"(%2, %arg2, %arg3) : (!gpu.async.token, memref<7xf32, 1>, memref<7xf32>) -> !gpu.async.token
      "gpu.wait"(%3) : (!gpu.async.token) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
  }) {gpu.container_module} : () -> ()
  "builtin.module"() ({
    "func.func"() <{function_type = (memref<?x?xf32, 1>, memref<?x?xf32>) -> (), sym_name = "dynamic"}> ({
    ^bb0(%arg0: memref<?x?xf32, 1>, %arg1: memref<?x?xf32>):
      %0 = "gpu.wait"() : () -> !gpu.async.token
      %1 = "gpu.memcpy"(%0, %arg0, %arg1) : (!gpu.async.token, memref<?x?xf32, 1>, memref<?x?xf32>) -> !gpu.async.token
      "func.return"() : () -> ()
    }) : () -> ()
  }) {gpu.container_module} : () -> ()
}) : () -> ()

