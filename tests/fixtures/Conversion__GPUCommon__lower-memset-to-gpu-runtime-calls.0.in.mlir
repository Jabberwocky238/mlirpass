"builtin.module"() ({
  "builtin.module"() ({
    "func.func"() <{function_type = (memref<7xf32, 1>, f32) -> (), sym_name = "foo"}> ({
    ^bb0(%arg2: memref<7xf32, 1>, %arg3: f32):
      %2 = "gpu.wait"() : () -> !gpu.async.token
      %3 = "gpu.memset"(%2, %arg2, %arg3) : (!gpu.async.token, memref<7xf32, 1>, f32) -> !gpu.async.token
      "gpu.wait"(%3) : (!gpu.async.token) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
  }) {gpu.container_module} : () -> ()
  "builtin.module"() ({
    "func.func"() <{function_type = (memref<7xf16, 1>, f16) -> (), sym_name = "foo16"}> ({
    ^bb0(%arg0: memref<7xf16, 1>, %arg1: f16):
      %0 = "gpu.wait"() : () -> !gpu.async.token
      %1 = "gpu.memset"(%0, %arg0, %arg1) : (!gpu.async.token, memref<7xf16, 1>, f16) -> !gpu.async.token
      "gpu.wait"(%1) : (!gpu.async.token) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
  }) {gpu.container_module} : () -> ()
}) : () -> ()

