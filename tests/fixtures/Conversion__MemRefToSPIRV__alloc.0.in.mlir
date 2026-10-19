"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> (), sym_name = "alloc_dealloc_workgroup_mem_shader_f32"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4x5xf32, #spirv.storage_class<Workgroup>>
    %1 = "memref.load"(%0, %arg0, %arg1) : (memref<4x5xf32, #spirv.storage_class<Workgroup>>, index, index) -> f32
    "memref.store"(%1, %0, %arg0, %arg1) : (f32, memref<4x5xf32, #spirv.storage_class<Workgroup>>, index, index) -> ()
    "memref.dealloc"(%0) : (memref<4x5xf32, #spirv.storage_class<Workgroup>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> (), sym_name = "alloc_dealloc_workgroup_mem_shader_i16"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4x5xi16, #spirv.storage_class<Workgroup>>
    %1 = "memref.load"(%0, %arg0, %arg1) : (memref<4x5xi16, #spirv.storage_class<Workgroup>>, index, index) -> i16
    "memref.store"(%1, %0, %arg0, %arg1) : (i16, memref<4x5xi16, #spirv.storage_class<Workgroup>>, index, index) -> ()
    "memref.dealloc"(%0) : (memref<4x5xi16, #spirv.storage_class<Workgroup>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "two_allocs"}> ({
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4x5xf32, #spirv.storage_class<Workgroup>>
    %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2x3xi32, #spirv.storage_class<Workgroup>>
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "two_allocs_vector"}> ({
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4xvector<4xf32>, #spirv.storage_class<Workgroup>>
    %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2xvector<2xi32>, #spirv.storage_class<Workgroup>>
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> f32, sym_name = "alloc_dynamic_size"}> ({
  ^bb0(%arg0: index):
    %0 = "memref.alloc"(%arg0) <{operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<4x?xf32, #spirv.storage_class<Workgroup>>
    %1 = "memref.load"(%0, %arg0, %arg0) : (memref<4x?xf32, #spirv.storage_class<Workgroup>>, index, index) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> f32, sym_name = "alloc_unsupported_memory_space"}> ({
  ^bb0(%arg0: index):
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4x5xf32, #spirv.storage_class<StorageBuffer>>
    %1 = "memref.load"(%0, %arg0, %arg0) : (memref<4x5xf32, #spirv.storage_class<StorageBuffer>>, index, index) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x?xf32, #spirv.storage_class<Workgroup>>) -> (), sym_name = "dealloc_dynamic_size"}> ({
  ^bb0(%arg0: memref<4x?xf32, #spirv.storage_class<Workgroup>>):
    "memref.dealloc"(%arg0) : (memref<4x?xf32, #spirv.storage_class<Workgroup>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x5xf32, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "dealloc_unsupported_memory_space"}> ({
  ^bb0(%arg0: memref<4x5xf32, #spirv.storage_class<StorageBuffer>>):
    "memref.dealloc"(%arg0) : (memref<4x5xf32, #spirv.storage_class<StorageBuffer>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> (), sym_name = "alloc_dealloc_workgroup_mem_kernel"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4x5xf32, #spirv.storage_class<Workgroup>>
    %1 = "memref.load"(%0, %arg0, %arg1) : (memref<4x5xf32, #spirv.storage_class<Workgroup>>, index, index) -> f32
    "memref.store"(%1, %0, %arg0, %arg1) : (f32, memref<4x5xf32, #spirv.storage_class<Workgroup>>, index, index) -> ()
    "memref.dealloc"(%0) : (memref<4x5xf32, #spirv.storage_class<Workgroup>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Kernel], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "zero_size"}> ({
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<0xf32, #spirv.storage_class<Workgroup>>
    %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<0xi1, #spirv.storage_class<Workgroup>>
    %2 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<0xi4, #spirv.storage_class<Workgroup>>
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

