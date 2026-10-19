module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Shader], []>, #spirv.resource_limits<>>} {
  func.func @alloc_function_variable(%arg0: index, %arg1: index) {
    %cst5_i32 = spirv.Constant 5 : i32
    %cst0_i32 = spirv.Constant 0 : i32
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i32
    %1 = builtin.unrealized_conversion_cast %arg0 : index to i32
    %2 = spirv.Variable : !spirv.ptr<!spirv.struct<(!spirv.array<20 x f32>)>, Function>
    %3 = spirv.IMul %1, %cst5_i32 : i32
    %4 = spirv.IAdd %0, %3 : i32
    %5 = spirv.AccessChain %2[%cst0_i32, %4] : !spirv.ptr<!spirv.struct<(!spirv.array<20 x f32>)>, Function>, i32, i32 -> !spirv.ptr<f32, Function>
    %6 = spirv.Load "Function" %5 : f32
    %7 = spirv.IMul %1, %cst5_i32 : i32
    %8 = spirv.IAdd %0, %7 : i32
    %9 = spirv.AccessChain %2[%cst0_i32, %8] : !spirv.ptr<!spirv.struct<(!spirv.array<20 x f32>)>, Function>, i32, i32 -> !spirv.ptr<f32, Function>
    spirv.Store "Function" %9, %6 : f32
    return
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Shader], []>, #spirv.resource_limits<>>} {
  func.func @two_allocs() {
    %0 = spirv.Variable : !spirv.ptr<!spirv.struct<(!spirv.array<20 x f32>)>, Function>
    %1 = spirv.Variable : !spirv.ptr<!spirv.struct<(!spirv.array<6 x i32>)>, Function>
    return
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Shader], []>, #spirv.resource_limits<>>} {
  func.func @two_allocs_vector() {
    %0 = spirv.Variable : !spirv.ptr<!spirv.struct<(!spirv.array<4 x vector<4xf32>>)>, Function>
    %1 = spirv.Variable : !spirv.ptr<!spirv.struct<(!spirv.array<2 x vector<2xi32>>)>, Function>
    return
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Shader], []>, #spirv.resource_limits<>>} {
  func.func @alloc_dynamic_size(%arg0: index) -> f32 {
    %alloca = memref.alloca(%arg0) : memref<4x?xf32, #spirv.storage_class<Function>>
    %0 = memref.load %alloca[%arg0, %arg0] : memref<4x?xf32, #spirv.storage_class<Function>>
    return %0 : f32
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Shader], []>, #spirv.resource_limits<>>} {
  func.func @alloc_unsupported_memory_space(%arg0: index) -> f32 {
    %alloca = memref.alloca() : memref<4x5xf32>
    %0 = memref.load %alloca[%arg0, %arg0] : memref<4x5xf32>
    return %0 : f32
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Shader], []>, #spirv.resource_limits<>>} {
  func.func @zero_size() {
    return
  }
}

