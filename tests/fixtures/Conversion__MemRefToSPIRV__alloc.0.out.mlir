module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} {
  spirv.GlobalVariable @__workgroup_mem__0 : !spirv.ptr<!spirv.struct<(!spirv.array<20 x f32>)>, Workgroup>
  func.func @alloc_dealloc_workgroup_mem_shader_f32(%arg0: index, %arg1: index) {
    %cst5_i32 = spirv.Constant 5 : i32
    %cst0_i32 = spirv.Constant 0 : i32
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i32
    %1 = builtin.unrealized_conversion_cast %arg0 : index to i32
    %__workgroup_mem__0_addr = spirv.mlir.addressof @__workgroup_mem__0 : !spirv.ptr<!spirv.struct<(!spirv.array<20 x f32>)>, Workgroup>
    %2 = spirv.IMul %1, %cst5_i32 : i32
    %3 = spirv.IAdd %0, %2 : i32
    %4 = spirv.AccessChain %__workgroup_mem__0_addr[%cst0_i32, %3] : !spirv.ptr<!spirv.struct<(!spirv.array<20 x f32>)>, Workgroup>, i32, i32 -> !spirv.ptr<f32, Workgroup>
    %5 = spirv.Load "Workgroup" %4 : f32
    %6 = spirv.IMul %1, %cst5_i32 : i32
    %7 = spirv.IAdd %0, %6 : i32
    %8 = spirv.AccessChain %__workgroup_mem__0_addr[%cst0_i32, %7] : !spirv.ptr<!spirv.struct<(!spirv.array<20 x f32>)>, Workgroup>, i32, i32 -> !spirv.ptr<f32, Workgroup>
    spirv.Store "Workgroup" %8, %5 : f32
    return
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} {
  spirv.GlobalVariable @__workgroup_mem__0 : !spirv.ptr<!spirv.struct<(!spirv.array<10 x i32>)>, Workgroup>
  func.func @alloc_dealloc_workgroup_mem_shader_i16(%arg0: index, %arg1: index) {
    %cst65535_i32 = spirv.Constant 65535 : i32
    %cst16_i32 = spirv.Constant 16 : i32
    %cst2_i32 = spirv.Constant 2 : i32
    %cst5_i32 = spirv.Constant 5 : i32
    %cst0_i32 = spirv.Constant 0 : i32
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i32
    %1 = builtin.unrealized_conversion_cast %arg0 : index to i32
    %__workgroup_mem__0_addr = spirv.mlir.addressof @__workgroup_mem__0 : !spirv.ptr<!spirv.struct<(!spirv.array<10 x i32>)>, Workgroup>
    %2 = spirv.IMul %1, %cst5_i32 : i32
    %3 = spirv.IAdd %0, %2 : i32
    %4 = spirv.SDiv %3, %cst2_i32 : i32
    %5 = spirv.AccessChain %__workgroup_mem__0_addr[%cst0_i32, %4] : !spirv.ptr<!spirv.struct<(!spirv.array<10 x i32>)>, Workgroup>, i32, i32 -> !spirv.ptr<i32, Workgroup>
    %6 = spirv.Load "Workgroup" %5 : i32
    %7 = spirv.UMod %3, %cst2_i32 : i32
    %8 = spirv.IMul %7, %cst16_i32 : i32
    %9 = spirv.ShiftRightArithmetic %6, %8 : i32, i32
    %10 = spirv.BitwiseAnd %9, %cst65535_i32 : i32
    %11 = spirv.ShiftLeftLogical %10, %cst16_i32 : i32, i32
    %12 = spirv.ShiftRightArithmetic %11, %cst16_i32 : i32, i32
    %13 = spirv.IMul %1, %cst5_i32 : i32
    %14 = spirv.IAdd %0, %13 : i32
    %15 = spirv.UMod %14, %cst2_i32 : i32
    %16 = spirv.IMul %15, %cst16_i32 : i32
    %17 = spirv.ShiftLeftLogical %cst65535_i32, %16 : i32, i32
    %18 = spirv.Not %17 : i32
    %19 = spirv.BitwiseAnd %12, %cst65535_i32 : i32
    %20 = spirv.ShiftLeftLogical %19, %16 : i32, i32
    %21 = spirv.SDiv %14, %cst2_i32 : i32
    %22 = spirv.AccessChain %__workgroup_mem__0_addr[%cst0_i32, %21] : !spirv.ptr<!spirv.struct<(!spirv.array<10 x i32>)>, Workgroup>, i32, i32 -> !spirv.ptr<i32, Workgroup>
    %23 = spirv.AtomicAnd <Workgroup> <AcquireRelease> %22, %18 : !spirv.ptr<i32, Workgroup>
    %24 = spirv.AtomicOr <Workgroup> <AcquireRelease> %22, %20 : !spirv.ptr<i32, Workgroup>
    return
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} {
  spirv.GlobalVariable @__workgroup_mem__1 : !spirv.ptr<!spirv.struct<(!spirv.array<6 x i32>)>, Workgroup>
  spirv.GlobalVariable @__workgroup_mem__0 : !spirv.ptr<!spirv.struct<(!spirv.array<20 x f32>)>, Workgroup>
  func.func @two_allocs() {
    return
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} {
  spirv.GlobalVariable @__workgroup_mem__1 : !spirv.ptr<!spirv.struct<(!spirv.array<2 x vector<2xi32>>)>, Workgroup>
  spirv.GlobalVariable @__workgroup_mem__0 : !spirv.ptr<!spirv.struct<(!spirv.array<4 x vector<4xf32>>)>, Workgroup>
  func.func @two_allocs_vector() {
    return
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} {
  func.func @alloc_dynamic_size(%arg0: index) -> f32 {
    %alloc = memref.alloc(%arg0) : memref<4x?xf32, #spirv.storage_class<Workgroup>>
    %0 = memref.load %alloc[%arg0, %arg0] : memref<4x?xf32, #spirv.storage_class<Workgroup>>
    return %0 : f32
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} {
  func.func @alloc_unsupported_memory_space(%arg0: index) -> f32 {
    %cst5_i32 = spirv.Constant 5 : i32
    %cst0_i32 = spirv.Constant 0 : i32
    %0 = builtin.unrealized_conversion_cast %arg0 : index to i32
    %alloc = memref.alloc() : memref<4x5xf32, #spirv.storage_class<StorageBuffer>>
    %1 = builtin.unrealized_conversion_cast %alloc : memref<4x5xf32, #spirv.storage_class<StorageBuffer>> to !spirv.ptr<!spirv.struct<(!spirv.array<20 x f32, stride=4> [0])>, StorageBuffer>
    %2 = spirv.IMul %0, %cst5_i32 : i32
    %3 = spirv.IAdd %0, %2 : i32
    %4 = spirv.AccessChain %1[%cst0_i32, %3] : !spirv.ptr<!spirv.struct<(!spirv.array<20 x f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
    %5 = spirv.Load "StorageBuffer" %4 : f32
    return %5 : f32
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} {
  func.func @dealloc_dynamic_size(%arg0: memref<4x?xf32, #spirv.storage_class<Workgroup>>) {
    memref.dealloc %arg0 : memref<4x?xf32, #spirv.storage_class<Workgroup>>
    return
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} {
  func.func @dealloc_unsupported_memory_space(%arg0: memref<4x5xf32, #spirv.storage_class<StorageBuffer>>) {
    memref.dealloc %arg0 : memref<4x5xf32, #spirv.storage_class<StorageBuffer>>
    return
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Kernel], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} {
  spirv.GlobalVariable @__workgroup_mem__0 : !spirv.ptr<!spirv.array<20 x f32>, Workgroup>
  func.func @alloc_dealloc_workgroup_mem_kernel(%arg0: index, %arg1: index) {
    %cst5_i32 = spirv.Constant 5 : i32
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i32
    %1 = builtin.unrealized_conversion_cast %arg0 : index to i32
    %__workgroup_mem__0_addr = spirv.mlir.addressof @__workgroup_mem__0 : !spirv.ptr<!spirv.array<20 x f32>, Workgroup>
    %2 = spirv.IMul %1, %cst5_i32 : i32
    %3 = spirv.IAdd %0, %2 : i32
    %4 = spirv.AccessChain %__workgroup_mem__0_addr[%3] : !spirv.ptr<!spirv.array<20 x f32>, Workgroup>, i32 -> !spirv.ptr<f32, Workgroup>
    %5 = spirv.Load "Workgroup" %4 : f32
    %6 = spirv.IMul %1, %cst5_i32 : i32
    %7 = spirv.IAdd %0, %6 : i32
    %8 = spirv.AccessChain %__workgroup_mem__0_addr[%7] : !spirv.ptr<!spirv.array<20 x f32>, Workgroup>, i32 -> !spirv.ptr<f32, Workgroup>
    spirv.Store "Workgroup" %8, %5 : f32
    return
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} {
  func.func @zero_size() {
    return
  }
}

