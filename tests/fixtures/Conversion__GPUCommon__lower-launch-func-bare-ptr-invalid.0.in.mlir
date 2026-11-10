"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (memref<*xi32>) -> (), kernel}> ({
    ^bb0(%arg1: memref<*xi32>):
      "gpu.return"() : () -> ()
    }) {sym_name = "kernel"} : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<*xi32>) -> (), sym_name = "main"}> ({
  ^bb0(%arg0: memref<*xi32>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "gpu.launch_func"(%0, %0, %0, %0, %0, %0, %1, %arg0) <{kernel = @kernels::@kernel, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0>}> : (index, index, index, index, index, index, i32, memref<*xi32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()

