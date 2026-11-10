"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = () -> (), kernel}> ({
      %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<8x16xf32>
      "memref.dealloc"(%1) : (memref<8x16xf32>) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "kernel_1"} : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<8x16xf32>
    "memref.dealloc"(%0) : (memref<8x16xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()

