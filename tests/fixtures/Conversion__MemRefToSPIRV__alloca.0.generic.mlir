"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> (), sym_name = "alloc_function_variable"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "spirv.Constant"() <{value = 5 : i32}> : () -> i32
    %1 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %2 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i32
    %3 = "builtin.unrealized_conversion_cast"(%arg0) : (index) -> i32
    %4 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<!spirv.struct<(!spirv.array<20 x f32>)>, Function>
    %5 = "spirv.IMul"(%3, %0) : (i32, i32) -> i32
    %6 = "spirv.IAdd"(%2, %5) : (i32, i32) -> i32
    %7 = "spirv.AccessChain"(%4, %1, %6) : (!spirv.ptr<!spirv.struct<(!spirv.array<20 x f32>)>, Function>, i32, i32) -> !spirv.ptr<f32, Function>
    %8 = "spirv.Load"(%7) : (!spirv.ptr<f32, Function>) -> f32
    %9 = "spirv.IMul"(%3, %0) : (i32, i32) -> i32
    %10 = "spirv.IAdd"(%2, %9) : (i32, i32) -> i32
    %11 = "spirv.AccessChain"(%4, %1, %10) : (!spirv.ptr<!spirv.struct<(!spirv.array<20 x f32>)>, Function>, i32, i32) -> !spirv.ptr<f32, Function>
    "spirv.Store"(%11, %8) : (!spirv.ptr<f32, Function>, f32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Shader], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "two_allocs"}> ({
    %0 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<!spirv.struct<(!spirv.array<20 x f32>)>, Function>
    %1 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<!spirv.struct<(!spirv.array<6 x i32>)>, Function>
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Shader], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "two_allocs_vector"}> ({
    %0 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<!spirv.struct<(!spirv.array<4 x vector<4xf32>>)>, Function>
    %1 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<!spirv.struct<(!spirv.array<2 x vector<2xi32>>)>, Function>
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
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Shader], []>, #spirv.resource_limits<>>} : () -> ()

