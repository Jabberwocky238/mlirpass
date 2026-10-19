"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> (), sym_name = "alloc_function_variable"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4x5xf32, #spirv.storage_class<Function>>
    %1 = "memref.load"(%0, %arg0, %arg1) : (memref<4x5xf32, #spirv.storage_class<Function>>, index, index) -> f32
    "memref.store"(%1, %0, %arg0, %arg1) : (f32, memref<4x5xf32, #spirv.storage_class<Function>>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Shader], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "two_allocs"}> ({
    %0 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4x5xf32, #spirv.storage_class<Function>>
    %1 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2x3xi32, #spirv.storage_class<Function>>
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Shader], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "two_allocs_vector"}> ({
    %0 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4xvector<4xf32>, #spirv.storage_class<Function>>
    %1 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2xvector<2xi32>, #spirv.storage_class<Function>>
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Shader], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> f32, sym_name = "alloc_dynamic_size"}> ({
  ^bb0(%arg0: index):
    %0 = "memref.alloca"(%arg0) <{operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<4x?xf32, #spirv.storage_class<Function>>
    %1 = "memref.load"(%0, %arg0, %arg0) : (memref<4x?xf32, #spirv.storage_class<Function>>, index, index) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Shader], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> f32, sym_name = "alloc_unsupported_memory_space"}> ({
  ^bb0(%arg0: index):
    %0 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4x5xf32>
    %1 = "memref.load"(%0, %arg0, %arg0) : (memref<4x5xf32>, index, index) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Shader], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "zero_size"}> ({
    %0 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<0xf32, #spirv.storage_class<Function>>
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Shader], []>, #spirv.resource_limits<>>} : () -> ()

