"builtin.module"() ({
  "gpu.module"() <{sym_name = "test"}> ({
    "gpu.func"() <{function_type = (memref<16xf32, #gpu.address_space<constant>>) -> (), kernel}> ({
    ^bb0(%arg2: memref<16xf32, #gpu.address_space<constant>>):
      %0 = "arith.constant"() <{value = 0 : index}> : () -> index
      %1 = "memref.load"(%arg2, %0) : (memref<16xf32, #gpu.address_space<constant>>, index) -> f32
      "gpu.return"() : () -> ()
    }) {sym_name = "constant_memref_basic"} : () -> ()
    "gpu.func"() <{function_type = (memref<4x8xf32, #gpu.address_space<constant>>) -> (), kernel}> ({
    ^bb0(%arg1: memref<4x8xf32, #gpu.address_space<constant>>):
      "gpu.return"() : () -> ()
    }) {sym_name = "constant_memref_multidim"} : () -> ()
    "gpu.func"() <{function_type = (memref<?x?xf32, #gpu.address_space<constant>>) -> (), kernel}> ({
    ^bb0(%arg0: memref<?x?xf32, #gpu.address_space<constant>>):
      "gpu.return"() : () -> ()
    }) {sym_name = "constant_memref_dynamic"} : () -> ()
  }) : () -> ()
}) : () -> ()

