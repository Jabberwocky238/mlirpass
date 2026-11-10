"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (memref<16xf32, #gpu.address_space<constant>>) -> (), kernel}> ({
    ^bb0(%arg4: memref<16xf32, #gpu.address_space<constant>>):
      %0 = "arith.constant"() <{value = 0 : index}> : () -> index
      %1 = "memref.load"(%arg4, %0) : (memref<16xf32, #gpu.address_space<constant>>, index) -> f32
      "gpu.return"() : () -> ()
    }) {sym_name = "constant_load"} : () -> ()
    "gpu.func"() <{function_type = (memref<f32, #gpu.address_space<global>>, memref<f32, #gpu.address_space<workgroup>>, memref<f32, #gpu.address_space<private>>, memref<f32, #gpu.address_space<constant>>) -> ()}> ({
    ^bb0(%arg0: memref<f32, #gpu.address_space<global>>, %arg1: memref<f32, #gpu.address_space<workgroup>>, %arg2: memref<f32, #gpu.address_space<private>>, %arg3: memref<f32, #gpu.address_space<constant>>):
      "gpu.return"() : () -> ()
    }) {sym_name = "all_address_spaces"} : () -> ()
  }) : () -> ()
}) : () -> ()

