"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernel_module"}> ({
    "gpu.func"() <{function_type = (memref<16xf32, #gpu.address_space<constant>>) -> (), kernel}> ({
    ^bb0(%arg1: memref<16xf32, #gpu.address_space<constant>>):
      %3 = "arith.constant"() <{value = 0 : index}> : () -> index
      %4 = "memref.load"(%arg1, %3) : (memref<16xf32, #gpu.address_space<constant>>, index) -> f32
      "gpu.return"() : () -> ()
    }) {sym_name = "constant_load"} : () -> ()
    "gpu.func"() <{function_type = (memref<4x8xf32, #gpu.address_space<constant>>) -> (), kernel}> ({
    ^bb0(%arg0: memref<4x8xf32, #gpu.address_space<constant>>):
      %0 = "arith.constant"() <{value = 0 : index}> : () -> index
      %1 = "arith.constant"() <{value = 1 : index}> : () -> index
      %2 = "memref.load"(%arg0, %0, %1) : (memref<4x8xf32, #gpu.address_space<constant>>, index, index) -> f32
      "gpu.return"() : () -> ()
    }) {sym_name = "constant_multidim"} : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()

