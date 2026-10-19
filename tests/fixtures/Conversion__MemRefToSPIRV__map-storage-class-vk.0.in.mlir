"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "test_vk_specific_memory_spaces"}> ({
    %0 = "dialect.memref_producer"() : () -> memref<4xi32, 8>
    %1 = "dialect.memref_producer"() : () -> memref<4xi32, 9>
    %2 = "dialect.memref_producer"() : () -> memref<4xi32, 10>
    %3 = "dialect.memref_producer"() : () -> memref<4xi32, 11>
    %4 = "dialect.memref_producer"() : () -> memref<4xi32, 12>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

