"builtin.module"() ({
  "func.func"() <{function_type = (memref<128xi32, 3>) -> (), sym_name = "memory_space_cast_non_integer_addrspace"}> ({
  ^bb0(%arg0: memref<128xi32, 3>):
    %0 = "memref.memory_space_cast"(%arg0) : (memref<128xi32, 3>) -> memref<128xi32, #gpu.address_space<workgroup>>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

