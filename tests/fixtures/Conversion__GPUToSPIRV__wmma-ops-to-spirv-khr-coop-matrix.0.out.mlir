module attributes {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.6, [Shader, CooperativeMatrixKHR, Float16], [SPV_KHR_storage_buffer_storage_class, SPV_KHR_cooperative_matrix]>, #spirv.resource_limits<>>} {
  spirv.module @__spv__kernels Logical GLSL450 {
    spirv.func @gpu_wmma_load_op(%arg0: !spirv.ptr<!spirv.struct<(!spirv.array<512 x f32, stride=4> [0])>, StorageBuffer> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}) "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, workgroup_attributions = 0 : i64} {
      %cst0_i32 = spirv.Constant 0 : i32
      %cst528_i32 = spirv.Constant 528 : i32
      %0 = spirv.AccessChain %arg0[%cst0_i32, %cst528_i32] : !spirv.ptr<!spirv.struct<(!spirv.array<512 x f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
      %cst32_i32 = spirv.Constant 32 : i32
      %1 = spirv.KHR.CooperativeMatrixLoad %0, %cst32_i32, <RowMajor> : !spirv.ptr<f32, StorageBuffer>, i32 -> !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>
      %2 = spirv.KHR.CooperativeMatrixLoad %0, %cst32_i32, <ColumnMajor> : !spirv.ptr<f32, StorageBuffer>, i32 -> !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>
      spirv.Return
    }
    spirv.func @gpu_wmma_store_op(%arg0: !spirv.ptr<!spirv.struct<(!spirv.array<512 x f32, stride=4> [0])>, StorageBuffer> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, %arg1: !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, workgroup_attributions = 0 : i64} {
      %cst0_i32 = spirv.Constant 0 : i32
      %cst528_i32 = spirv.Constant 528 : i32
      %0 = spirv.AccessChain %arg0[%cst0_i32, %cst528_i32] : !spirv.ptr<!spirv.struct<(!spirv.array<512 x f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
      %cst32_i32 = spirv.Constant 32 : i32
      spirv.KHR.CooperativeMatrixStore %0, %arg1, %cst32_i32, <RowMajor> : !spirv.ptr<f32, StorageBuffer>, !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, i32
      spirv.KHR.CooperativeMatrixStore %0, %arg1, %cst32_i32, <ColumnMajor> : !spirv.ptr<f32, StorageBuffer>, !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, i32
      spirv.Return
    }
    spirv.func @gpu_wmma_mma_op(%arg0: !spirv.coopmatrix<16x16xf16, Subgroup, MatrixA> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, %arg1: !spirv.coopmatrix<16x16xf16, Subgroup, MatrixB> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}, %arg2: !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}, %arg3: !spirv.ptr<!spirv.struct<(!spirv.array<128 x f32, stride=4> [0])>, StorageBuffer> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 3)>}) "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, workgroup_attributions = 0 : i64} {
      %0 = spirv.KHR.CooperativeMatrixMulAdd %arg0, %arg1, %arg2 : !spirv.coopmatrix<16x16xf16, Subgroup, MatrixA>, !spirv.coopmatrix<16x16xf16, Subgroup, MatrixB> -> !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>
      %cst0_i32 = spirv.Constant 0 : i32
      %1 = spirv.AccessChain %arg3[%cst0_i32, %cst0_i32] : !spirv.ptr<!spirv.struct<(!spirv.array<128 x f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
      %cst32_i32 = spirv.Constant 32 : i32
      spirv.KHR.CooperativeMatrixStore %1, %0, %cst32_i32, <RowMajor> : !spirv.ptr<f32, StorageBuffer>, !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, i32
      spirv.Return
    }
    spirv.func @gpu_wmma_constant_op(%arg0: !spirv.ptr<!spirv.struct<(!spirv.array<128 x f32, stride=4> [0])>, StorageBuffer> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}) "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, workgroup_attributions = 0 : i64} {
      %cst_f16 = spirv.Constant 1.000000e+00 : f16
      %0 = spirv.CompositeConstruct %cst_f16 : (f16) -> !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>
      %cst0_i32 = spirv.Constant 0 : i32
      %1 = spirv.AccessChain %arg0[%cst0_i32, %cst0_i32] : !spirv.ptr<!spirv.struct<(!spirv.array<128 x f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
      %cst32_i32 = spirv.Constant 32 : i32
      spirv.KHR.CooperativeMatrixStore %1, %0, %cst32_i32, <RowMajor> : !spirv.ptr<f32, StorageBuffer>, !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, i32
      spirv.Return
    }
    spirv.func @gpu_wmma_extract_thread_local_op(%arg0: !spirv.coopmatrix<16x16xf32, Subgroup, MatrixA> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, %arg1: !spirv.ptr<!spirv.struct<(!spirv.array<256 x f32, stride=4> [0])>, StorageBuffer> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, workgroup_attributions = 0 : i64} {
      %cst0_i32 = spirv.Constant 0 : i32
      %0 = spirv.CompositeExtract %arg0[0 : i32] : !spirv.coopmatrix<16x16xf32, Subgroup, MatrixA>
      %1 = spirv.AccessChain %arg1[%cst0_i32, %cst0_i32] : !spirv.ptr<!spirv.struct<(!spirv.array<256 x f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
      spirv.Store "StorageBuffer" %1, %0 : f32
      spirv.Return
    }
    spirv.func @gpu_wmma_insert_thread_local_op(%arg0: f16 {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0), StorageBuffer>}, %arg1: !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}, %arg2: !spirv.ptr<!spirv.struct<(!spirv.array<128 x f32, stride=4> [0])>, StorageBuffer> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}) "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, workgroup_attributions = 0 : i64} {
      %cst0_i32 = spirv.Constant 0 : i32
      %0 = spirv.CompositeInsert %arg0, %arg1[0 : i32] : f16 into !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>
      %1 = spirv.AccessChain %arg2[%cst0_i32, %cst0_i32] : !spirv.ptr<!spirv.struct<(!spirv.array<128 x f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
      %cst16_i32 = spirv.Constant 16 : i32
      spirv.KHR.CooperativeMatrixStore %1, %0, %cst16_i32, <RowMajor> : !spirv.ptr<f32, StorageBuffer>, !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, i32
      spirv.Return
    }
    spirv.func @gpu_wmma_elementwise_op_default(%arg0: !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, %arg1: !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}, %arg2: !spirv.ptr<!spirv.struct<(!spirv.array<256 x f32, stride=4> [0])>, StorageBuffer> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}) "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, workgroup_attributions = 0 : i64} {
      %0 = spirv.FAdd %arg0, %arg1 : !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>
      %1 = spirv.FNegate %0 : !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>
      %2 = spirv.FDiv %1, %arg0 : !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>
      %3 = spirv.FMul %2, %arg0 : !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>
      %4 = spirv.FConvert %3 : !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc> to !spirv.coopmatrix<16x16xf32, Subgroup, MatrixAcc>
      %cst0_i32 = spirv.Constant 0 : i32
      %5 = spirv.AccessChain %arg2[%cst0_i32, %cst0_i32] : !spirv.ptr<!spirv.struct<(!spirv.array<256 x f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
      %cst32_i32 = spirv.Constant 32 : i32
      spirv.KHR.CooperativeMatrixStore %5, %4, %cst32_i32, <RowMajor> : !spirv.ptr<f32, StorageBuffer>, !spirv.coopmatrix<16x16xf32, Subgroup, MatrixAcc>, i32
      spirv.Return
    }
    spirv.func @gpu_wmma_elementwise_op_matrix_times_scalar(%arg0: !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, %arg1: f16 {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1), StorageBuffer>}, %arg2: !spirv.ptr<!spirv.struct<(!spirv.array<128 x f32, stride=4> [0])>, StorageBuffer> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}) "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, workgroup_attributions = 0 : i64} {
      %cst0_i32 = spirv.Constant 0 : i32
      %0 = spirv.MatrixTimesScalar %arg0, %arg1 : !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, f16
      %1 = spirv.AccessChain %arg2[%cst0_i32, %cst0_i32] : !spirv.ptr<!spirv.struct<(!spirv.array<128 x f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
      %cst32_i32 = spirv.Constant 32 : i32
      spirv.KHR.CooperativeMatrixStore %1, %0, %cst32_i32, <RowMajor> : !spirv.ptr<f32, StorageBuffer>, !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, i32
      %2 = spirv.MatrixTimesScalar %0, %arg1 : !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, f16
      spirv.KHR.CooperativeMatrixStore %1, %2, %cst32_i32, <RowMajor> : !spirv.ptr<f32, StorageBuffer>, !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, i32
      spirv.Return
    }
    spirv.func @gpu_wmma_elementwise_op_matrix_plus_scalar(%arg0: !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, %arg1: f16 {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1), StorageBuffer>}, %arg2: !spirv.ptr<!spirv.struct<(!spirv.array<128 x f32, stride=4> [0])>, StorageBuffer> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}) "None" attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, workgroup_attributions = 0 : i64} {
      %cst0_i32 = spirv.Constant 0 : i32
      %0 = spirv.CompositeConstruct %arg1 : (f16) -> !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>
      %1 = spirv.FAdd %arg0, %0 : !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>
      %2 = spirv.AccessChain %arg2[%cst0_i32, %cst0_i32] : !spirv.ptr<!spirv.struct<(!spirv.array<128 x f32, stride=4> [0])>, StorageBuffer>, i32, i32 -> !spirv.ptr<f32, StorageBuffer>
      %cst32_i32 = spirv.Constant 32 : i32
      spirv.KHR.CooperativeMatrixStore %2, %1, %cst32_i32, <RowMajor> : !spirv.ptr<f32, StorageBuffer>, !spirv.coopmatrix<16x16xf16, Subgroup, MatrixAcc>, i32
      spirv.Return
    }
  }
  gpu.module @kernels {
    gpu.func @gpu_wmma_load_op(%arg0: memref<32x32xf16, #spirv.storage_class<StorageBuffer>>) kernel attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>} {
      %c16 = arith.constant 16 : index
      gpu.return
    }
    gpu.func @gpu_wmma_store_op(%arg0: memref<32x32xf16, #spirv.storage_class<StorageBuffer>>, %arg1: !gpu.mma_matrix<16x16xf16, "COp">) kernel attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>} {
      %c16 = arith.constant 16 : index
      gpu.subgroup_mma_store_matrix %arg1, %arg0[%c16, %c16] {leadDimension = 32 : index} : !gpu.mma_matrix<16x16xf16, "COp">, memref<32x32xf16, #spirv.storage_class<StorageBuffer>>
      gpu.subgroup_mma_store_matrix %arg1, %arg0[%c16, %c16] {leadDimension = 32 : index, transpose} : !gpu.mma_matrix<16x16xf16, "COp">, memref<32x32xf16, #spirv.storage_class<StorageBuffer>>
      gpu.return
    }
    gpu.func @gpu_wmma_mma_op(%arg0: !gpu.mma_matrix<16x16xf16, "AOp">, %arg1: !gpu.mma_matrix<16x16xf16, "BOp">, %arg2: !gpu.mma_matrix<16x16xf16, "COp">, %arg3: memref<16x16xf16, #spirv.storage_class<StorageBuffer>>) kernel attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>} {
      %0 = gpu.subgroup_mma_compute %arg0, %arg1, %arg2 : !gpu.mma_matrix<16x16xf16, "AOp">, !gpu.mma_matrix<16x16xf16, "BOp"> -> !gpu.mma_matrix<16x16xf16, "COp">
      %c0 = arith.constant 0 : index
      gpu.subgroup_mma_store_matrix %0, %arg3[%c0, %c0] {leadDimension = 32 : index} : !gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf16, #spirv.storage_class<StorageBuffer>>
      gpu.return
    }
    gpu.func @gpu_wmma_constant_op(%arg0: memref<16x16xf16, #spirv.storage_class<StorageBuffer>>) kernel attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>} {
      %cst = arith.constant 1.000000e+00 : f16
      %0 = gpu.subgroup_mma_constant_matrix %cst : !gpu.mma_matrix<16x16xf16, "COp">
      %c0 = arith.constant 0 : index
      gpu.subgroup_mma_store_matrix %0, %arg0[%c0, %c0] {leadDimension = 32 : index} : !gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf16, #spirv.storage_class<StorageBuffer>>
      gpu.return
    }
    gpu.func @gpu_wmma_extract_thread_local_op(%arg0: !gpu.mma_matrix<16x16xf32, "AOp">, %arg1: memref<16x16xf32, #spirv.storage_class<StorageBuffer>>) kernel attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>} {
      %c0 = arith.constant 0 : index
      %0 = gpu.subgroup_mma_extract_thread_local %arg0[%c0] : !gpu.mma_matrix<16x16xf32, "AOp"> -> f32
      memref.store %0, %arg1[%c0, %c0] : memref<16x16xf32, #spirv.storage_class<StorageBuffer>>
      gpu.return
    }
    gpu.func @gpu_wmma_insert_thread_local_op(%arg0: f16, %arg1: !gpu.mma_matrix<16x16xf16, "COp">, %arg2: memref<16x16xf16, #spirv.storage_class<StorageBuffer>>) kernel attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>} {
      %c0 = arith.constant 0 : index
      %0 = gpu.subgroup_mma_insert_thread_local %arg0, %arg1[%c0] : f16, !gpu.mma_matrix<16x16xf16, "COp"> -> !gpu.mma_matrix<16x16xf16, "COp">
      gpu.subgroup_mma_store_matrix %0, %arg2[%c0, %c0] {leadDimension = 16 : index} : !gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf16, #spirv.storage_class<StorageBuffer>>
      gpu.return
    }
    gpu.func @gpu_wmma_elementwise_op_default(%arg0: !gpu.mma_matrix<16x16xf16, "COp">, %arg1: !gpu.mma_matrix<16x16xf16, "COp">, %arg2: memref<16x16xf32, #spirv.storage_class<StorageBuffer>>) kernel attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>} {
      %0 = gpu.subgroup_mma_elementwise  addf %arg0, %arg1 : (!gpu.mma_matrix<16x16xf16, "COp">, !gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
      %1 = gpu.subgroup_mma_elementwise  negatef %0 : (!gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
      %2 = gpu.subgroup_mma_elementwise  divf %1, %arg0 : (!gpu.mma_matrix<16x16xf16, "COp">, !gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
      %3 = gpu.subgroup_mma_elementwise  mulf %2, %arg0 : (!gpu.mma_matrix<16x16xf16, "COp">, !gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
      %4 = gpu.subgroup_mma_elementwise  extf %3 : (!gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf32, "COp">
      %c0 = arith.constant 0 : index
      gpu.subgroup_mma_store_matrix %4, %arg2[%c0, %c0] {leadDimension = 32 : index} : !gpu.mma_matrix<16x16xf32, "COp">, memref<16x16xf32, #spirv.storage_class<StorageBuffer>>
      gpu.return
    }
    gpu.func @gpu_wmma_elementwise_op_matrix_times_scalar(%arg0: !gpu.mma_matrix<16x16xf16, "COp">, %arg1: f16, %arg2: memref<16x16xf16, #spirv.storage_class<StorageBuffer>>) kernel attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>} {
      %c0 = arith.constant 0 : index
      %0 = gpu.subgroup_mma_constant_matrix %arg1 : !gpu.mma_matrix<16x16xf16, "COp">
      %1 = gpu.subgroup_mma_elementwise  mulf %arg0, %0 : (!gpu.mma_matrix<16x16xf16, "COp">, !gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
      gpu.subgroup_mma_store_matrix %1, %arg2[%c0, %c0] {leadDimension = 32 : index} : !gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf16, #spirv.storage_class<StorageBuffer>>
      %2 = gpu.subgroup_mma_elementwise  mulf %0, %1 : (!gpu.mma_matrix<16x16xf16, "COp">, !gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
      gpu.subgroup_mma_store_matrix %2, %arg2[%c0, %c0] {leadDimension = 32 : index} : !gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf16, #spirv.storage_class<StorageBuffer>>
      gpu.return
    }
    gpu.func @gpu_wmma_elementwise_op_matrix_plus_scalar(%arg0: !gpu.mma_matrix<16x16xf16, "COp">, %arg1: f16, %arg2: memref<16x16xf16, #spirv.storage_class<StorageBuffer>>) kernel attributes {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>} {
      %c0 = arith.constant 0 : index
      %0 = gpu.subgroup_mma_constant_matrix %arg1 : !gpu.mma_matrix<16x16xf16, "COp">
      %1 = gpu.subgroup_mma_elementwise  addf %arg0, %0 : (!gpu.mma_matrix<16x16xf16, "COp">, !gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
      gpu.subgroup_mma_store_matrix %1, %arg2[%c0, %c0] {leadDimension = 32 : index} : !gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf16, #spirv.storage_class<StorageBuffer>>
      gpu.return
    }
  }
}

