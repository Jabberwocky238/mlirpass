module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} {
  func.func @load_store(%arg0: memref<12x4xf32, #spirv.storage_class<StorageBuffer>>, %arg1: memref<12x4xf32, #spirv.storage_class<StorageBuffer>>, %arg2: memref<12x4xf32, #spirv.storage_class<StorageBuffer>>) {
    %c0 = arith.constant 0 : index
    %c12 = arith.constant 12 : index
    %0 = arith.subi %c12, %c0 : index
    %c1 = arith.constant 1 : index
    %c0_0 = arith.constant 0 : index
    %c4 = arith.constant 4 : index
    %1 = arith.subi %c4, %c0_0 : index
    %c1_1 = arith.constant 1 : index
    %c1_2 = arith.constant 1 : index
    gpu.launch_func  @kernels::@load_store_kernel blocks in (%0, %c1_2, %c1_2) threads in (%1, %c1_2, %c1_2)  args(%arg0 : memref<12x4xf32, #spirv.storage_class<StorageBuffer>>, %arg1 : memref<12x4xf32, #spirv.storage_class<StorageBuffer>>, %arg2 : memref<12x4xf32, #spirv.storage_class<StorageBuffer>>, %c0 : index, %c0_0 : index, %c1 : index, %c1_1 : index)
    return
  }
  spirv.module @__spv__kernels Logical GLSL450 {
    spirv.GlobalVariable @__builtin__NumWorkgroups__ built_in("NumWorkgroups") : !spirv.ptr<vector<3xi32>, Input>
    spirv.GlobalVariable @__builtin__LocalInvocationId__ built_in("LocalInvocationId") : !spirv.ptr<vector<3xi32>, Input>
    spirv.GlobalVariable @__builtin__WorkgroupId__ built_in("WorkgroupId") : !spirv.ptr<vector<3xi32>, Input>
    spirv.func @load_store_kernel(%arg0: !spirv.ptr<!spirv.struct<(!spirv.array<48 x f32, stride=4> [0])>, StorageBuffer> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, %arg1: !spirv.ptr<!spirv.struct<(!spirv.array<48 x f32, stride=4> [0])>, StorageBuffer> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}, %arg2: !spirv.ptr<!spirv.struct<(!spirv.array<48 x f32, stride=4> [0])>, StorageBuffer> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}, %arg3: i32 {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 3), StorageBuffer>}, %arg4: i32 {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 4), StorageBuffer>}, %arg5: i32 {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 5), StorageBuffer>}, %arg6: i32 {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 6), StorageBuffer>}) "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} {
      %__builtin__WorkgroupId___addr = spirv.mlir.addressof @__builtin__WorkgroupId__ : !spirv.ptr<vector<3xi32>, Input>
      %0 = spirv.Load "Input" %__builtin__WorkgroupId___addr : vector<3xi32>
      %1 = spirv.CompositeExtract %0[0 : i32] : vector<3xi32>
      %__builtin__WorkgroupId___addr_0 = spirv.mlir.addressof @__builtin__WorkgroupId__ : !spirv.ptr<vector<3xi32>, Input>
      %2 = spirv.Load "Input" %__builtin__WorkgroupId___addr_0 : vector<3xi32>
      %3 = spirv.CompositeExtract %2[1 : i32] : vector<3xi32>
      %__builtin__WorkgroupId___addr_1 = spirv.mlir.addressof @__builtin__WorkgroupId__ : !spirv.ptr<vector<3xi32>, Input>
      %4 = spirv.Load "Input" %__builtin__WorkgroupId___addr_1 : vector<3xi32>
      %5 = spirv.CompositeExtract %4[2 : i32] : vector<3xi32>
      %__builtin__LocalInvocationId___addr = spirv.mlir.addressof @__builtin__LocalInvocationId__ : !spirv.ptr<vector<3xi32>, Input>
      %6 = spirv.Load "Input" %__builtin__LocalInvocationId___addr : vector<3xi32>
      %7 = spirv.CompositeExtract %6[0 : i32] : vector<3xi32>
      %__builtin__LocalInvocationId___addr_2 = spirv.mlir.addressof @__builtin__LocalInvocationId__ : !spirv.ptr<vector<3xi32>, Input>
      %8 = spirv.Load "Input" %__builtin__LocalInvocationId___addr_2 : vector<3xi32>
      %9 = spirv.CompositeExtract %8[1 : i32] : vector<3xi32>
      %__builtin__LocalInvocationId___addr_3 = spirv.mlir.addressof @__builtin__LocalInvocationId__ : !spirv.ptr<vector<3xi32>, Input>
      %10 = spirv.Load "Input" %__builtin__LocalInvocationId___addr_3 : vector<3xi32>
      %11 = spirv.CompositeExtract %10[2 : i32] : vector<3xi32>
      %__builtin__NumWorkgroups___addr = spirv.mlir.addressof @__builtin__NumWorkgroups__ : !spirv.ptr<vector<3xi32>, Input>
      %12 = spirv.Load "Input" %__builtin__NumWorkgroups___addr : vector<3xi32>
      %13 = spirv.CompositeExtract %12[0 : i32] : vector<3xi32>
      %__builtin__NumWorkgroups___addr_4 = spirv.mlir.addressof @__builtin__NumWorkgroups__ : !spirv.ptr<vector<3xi32>, Input>
      %14 = spirv.Load "Input" %__builtin__NumWorkgroups___addr_4 : vector<3xi32>
      %15 = spirv.CompositeExtract %14[1 : i32] : vector<3xi32>
      %__builtin__NumWorkgroups___addr_5 = spirv.mlir.addressof @__builtin__NumWorkgroups__ : !spirv.ptr<vector<3xi32>, Input>
      %16 = spirv.Load "Input" %__builtin__NumWorkgroups___addr_5 : vector<3xi32>
      %17 = spirv.CompositeExtract %16[2 : i32] : vector<3xi32>
      %cst16_i32 = spirv.Constant 16 : i32
      %cst1_i32 = spirv.Constant 1 : i32
      %cst1_i32_6 = spirv.Constant 1 : i32
      %18 = spirv.IAdd %arg3, %1 : i32
      %19 = spirv.IAdd %arg4, %7 : i32
      %cst0_i32 = spirv.Constant 0 : i32
      %cst0_i32_7 = spirv.Constant 0 : i32
      %cst4_i32 = spirv.Constant 4 : i32
      %20 = spirv.IMul %18, %cst4_i32 : i32
      %cst1_i32_8 = spirv.Constant 1 : i32
      %21 = spirv.IAdd %19, %20 : i32
      %22 = spirv.AccessChain %arg0[%cst0_i32, %21] : !spirv.ptr<!spirv.struct<(!spirv.array<48 x f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
      %23 = spirv.Load "StorageBuffer" %22 : f32
      %cst0_i32_9 = spirv.Constant 0 : i32
      %cst0_i32_10 = spirv.Constant 0 : i32
      %cst4_i32_11 = spirv.Constant 4 : i32
      %24 = spirv.IMul %18, %cst4_i32_11 : i32
      %cst1_i32_12 = spirv.Constant 1 : i32
      %25 = spirv.IAdd %19, %24 : i32
      %26 = spirv.AccessChain %arg1[%cst0_i32_9, %25] : !spirv.ptr<!spirv.struct<(!spirv.array<48 x f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
      %27 = spirv.Load "StorageBuffer" %26 : f32
      %28 = spirv.FAdd %23, %27 : f32
      %cst0_i32_13 = spirv.Constant 0 : i32
      %cst0_i32_14 = spirv.Constant 0 : i32
      %cst4_i32_15 = spirv.Constant 4 : i32
      %29 = spirv.IMul %18, %cst4_i32_15 : i32
      %cst1_i32_16 = spirv.Constant 1 : i32
      %30 = spirv.IAdd %19, %29 : i32
      %31 = spirv.AccessChain %arg2[%cst0_i32_13, %30] : !spirv.ptr<!spirv.struct<(!spirv.array<48 x f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
      spirv.Store "StorageBuffer" %31, %28 : f32
      spirv.Return
    }
  }
  gpu.module @kernels {
    gpu.func @load_store_kernel(%arg0: memref<12x4xf32, #spirv.storage_class<StorageBuffer>>, %arg1: memref<12x4xf32, #spirv.storage_class<StorageBuffer>>, %arg2: memref<12x4xf32, #spirv.storage_class<StorageBuffer>>, %arg3: index, %arg4: index, %arg5: index, %arg6: index) kernel attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>} {
      %block_id_x = gpu.block_id  x
      %block_id_y = gpu.block_id  y
      %block_id_z = gpu.block_id  z
      %thread_id_x = gpu.thread_id  x
      %thread_id_y = gpu.thread_id  y
      %thread_id_z = gpu.thread_id  z
      %grid_dim_x = gpu.grid_dim  x
      %grid_dim_y = gpu.grid_dim  y
      %grid_dim_z = gpu.grid_dim  z
      %block_dim_x = gpu.block_dim  x
      %block_dim_y = gpu.block_dim  y
      %block_dim_z = gpu.block_dim  z
      %0 = arith.addi %arg3, %block_id_x : index
      %1 = arith.addi %arg4, %thread_id_x : index
      %2 = memref.load %arg0[%0, %1] : memref<12x4xf32, #spirv.storage_class<StorageBuffer>>
      %3 = memref.load %arg1[%0, %1] : memref<12x4xf32, #spirv.storage_class<StorageBuffer>>
      %4 = arith.addf %2, %3 : f32
      memref.store %4, %arg2[%0, %1] : memref<12x4xf32, #spirv.storage_class<StorageBuffer>>
      gpu.return
    }
  }
}

