"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "test_vk_specific_memory_spaces"}> ({
    %0 = "dialect.memref_producer"() : () -> memref<4xi32, #spirv.storage_class<UniformConstant>>
    %1 = "dialect.memref_producer"() : () -> memref<4xi32, #spirv.storage_class<Input>>
    %2 = "dialect.memref_producer"() : () -> memref<4xi32, #spirv.storage_class<Output>>
    %3 = "dialect.memref_producer"() : () -> memref<4xi32, #spirv.storage_class<PhysicalStorageBuffer>>
    %4 = "dialect.memref_producer"() : () -> memref<4xi32, #spirv.storage_class<Image>>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

