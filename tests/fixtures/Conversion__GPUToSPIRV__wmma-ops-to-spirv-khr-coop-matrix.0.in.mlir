"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (memref<32x32xf16, #spirv.storage_class<StorageBuffer>>) -> ()}> ({
    ^bb0(%arg21: memref<32x32xf16, #spirv.storage_class<StorageBuffer>>):
      %24 = "arith.constant"() <{value = 16 : index}> : () -> index
      %25 = "arith.constant"() <{value = 16 : index}> : () -> index
      %26 = "gpu.subgroup_mma_load_matrix"(%arg21, %24, %25) <{leadDimension = 32 : index}> : (memref<32x32xf16, #spirv.storage_class<StorageBuffer>>, index, index) -> !gpu.mma_matrix<16x16xf16, "COp">
      %27 = "gpu.subgroup_mma_load_matrix"(%arg21, %24, %25) <{leadDimension = 32 : index, transpose}> : (memref<32x32xf16, #spirv.storage_class<StorageBuffer>>, index, index) -> !gpu.mma_matrix<16x16xf16, "COp">
      "gpu.return"() : () -> ()
    }) {gpu.kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, sym_name = "gpu_wmma_load_op", workgroup_attributions = 0 : i64} : () -> ()
    "gpu.func"() <{function_type = (memref<32x32xf16, #spirv.storage_class<StorageBuffer>>, !gpu.mma_matrix<16x16xf16, "COp">) -> ()}> ({
    ^bb0(%arg19: memref<32x32xf16, #spirv.storage_class<StorageBuffer>>, %arg20: !gpu.mma_matrix<16x16xf16, "COp">):
      %22 = "arith.constant"() <{value = 16 : index}> : () -> index
      %23 = "arith.constant"() <{value = 16 : index}> : () -> index
      "gpu.subgroup_mma_store_matrix"(%arg20, %arg19, %22, %23) <{leadDimension = 32 : index}> : (!gpu.mma_matrix<16x16xf16, "COp">, memref<32x32xf16, #spirv.storage_class<StorageBuffer>>, index, index) -> ()
      "gpu.subgroup_mma_store_matrix"(%arg20, %arg19, %22, %23) <{leadDimension = 32 : index, transpose}> : (!gpu.mma_matrix<16x16xf16, "COp">, memref<32x32xf16, #spirv.storage_class<StorageBuffer>>, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, sym_name = "gpu_wmma_store_op", workgroup_attributions = 0 : i64} : () -> ()
    "gpu.func"() <{function_type = (!gpu.mma_matrix<16x16xf16, "AOp">, !gpu.mma_matrix<16x16xf16, "BOp">, !gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf16, #spirv.storage_class<StorageBuffer>>) -> ()}> ({
    ^bb0(%arg15: !gpu.mma_matrix<16x16xf16, "AOp">, %arg16: !gpu.mma_matrix<16x16xf16, "BOp">, %arg17: !gpu.mma_matrix<16x16xf16, "COp">, %arg18: memref<16x16xf16, #spirv.storage_class<StorageBuffer>>):
      %20 = "gpu.subgroup_mma_compute"(%arg15, %arg16, %arg17) : (!gpu.mma_matrix<16x16xf16, "AOp">, !gpu.mma_matrix<16x16xf16, "BOp">, !gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
      %21 = "arith.constant"() <{value = 0 : index}> : () -> index
      "gpu.subgroup_mma_store_matrix"(%20, %arg18, %21, %21) <{leadDimension = 32 : index}> : (!gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf16, #spirv.storage_class<StorageBuffer>>, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, sym_name = "gpu_wmma_mma_op", workgroup_attributions = 0 : i64} : () -> ()
    "gpu.func"() <{function_type = (memref<16x16xf16, #spirv.storage_class<StorageBuffer>>) -> ()}> ({
    ^bb0(%arg14: memref<16x16xf16, #spirv.storage_class<StorageBuffer>>):
      %17 = "arith.constant"() <{value = 1.000000e+00 : f16}> : () -> f16
      %18 = "gpu.subgroup_mma_constant_matrix"(%17) : (f16) -> !gpu.mma_matrix<16x16xf16, "COp">
      %19 = "arith.constant"() <{value = 0 : index}> : () -> index
      "gpu.subgroup_mma_store_matrix"(%18, %arg14, %19, %19) <{leadDimension = 32 : index}> : (!gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf16, #spirv.storage_class<StorageBuffer>>, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, sym_name = "gpu_wmma_constant_op", workgroup_attributions = 0 : i64} : () -> ()
    "gpu.func"() <{function_type = (!gpu.mma_matrix<16x16xf32, "AOp">, memref<16x16xf32, #spirv.storage_class<StorageBuffer>>) -> ()}> ({
    ^bb0(%arg12: !gpu.mma_matrix<16x16xf32, "AOp">, %arg13: memref<16x16xf32, #spirv.storage_class<StorageBuffer>>):
      %15 = "arith.constant"() <{value = 0 : index}> : () -> index
      %16 = "gpu.subgroup_mma_extract_thread_local"(%arg12, %15) : (!gpu.mma_matrix<16x16xf32, "AOp">, index) -> f32
      "memref.store"(%16, %arg13, %15, %15) : (f32, memref<16x16xf32, #spirv.storage_class<StorageBuffer>>, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, sym_name = "gpu_wmma_extract_thread_local_op", workgroup_attributions = 0 : i64} : () -> ()
    "gpu.func"() <{function_type = (f16, !gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf16, #spirv.storage_class<StorageBuffer>>) -> ()}> ({
    ^bb0(%arg9: f16, %arg10: !gpu.mma_matrix<16x16xf16, "COp">, %arg11: memref<16x16xf16, #spirv.storage_class<StorageBuffer>>):
      %13 = "arith.constant"() <{value = 0 : index}> : () -> index
      %14 = "gpu.subgroup_mma_insert_thread_local"(%arg9, %arg10, %13) : (f16, !gpu.mma_matrix<16x16xf16, "COp">, index) -> !gpu.mma_matrix<16x16xf16, "COp">
      "gpu.subgroup_mma_store_matrix"(%14, %arg11, %13, %13) <{leadDimension = 16 : index}> : (!gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf16, #spirv.storage_class<StorageBuffer>>, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, sym_name = "gpu_wmma_insert_thread_local_op", workgroup_attributions = 0 : i64} : () -> ()
    "gpu.func"() <{function_type = (!gpu.mma_matrix<16x16xf16, "COp">, !gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf32, #spirv.storage_class<StorageBuffer>>) -> ()}> ({
    ^bb0(%arg6: !gpu.mma_matrix<16x16xf16, "COp">, %arg7: !gpu.mma_matrix<16x16xf16, "COp">, %arg8: memref<16x16xf32, #spirv.storage_class<StorageBuffer>>):
      %7 = "gpu.subgroup_mma_elementwise"(%arg6, %arg7) <{opType = #gpu<mma_element_wise addf>}> : (!gpu.mma_matrix<16x16xf16, "COp">, !gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
      %8 = "gpu.subgroup_mma_elementwise"(%7) <{opType = #gpu<mma_element_wise negatef>}> : (!gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
      %9 = "gpu.subgroup_mma_elementwise"(%8, %arg6) <{opType = #gpu<mma_element_wise divf>}> : (!gpu.mma_matrix<16x16xf16, "COp">, !gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
      %10 = "gpu.subgroup_mma_elementwise"(%9, %arg6) <{opType = #gpu<mma_element_wise mulf>}> : (!gpu.mma_matrix<16x16xf16, "COp">, !gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
      %11 = "gpu.subgroup_mma_elementwise"(%10) <{opType = #gpu<mma_element_wise extf>}> : (!gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf32, "COp">
      %12 = "arith.constant"() <{value = 0 : index}> : () -> index
      "gpu.subgroup_mma_store_matrix"(%11, %arg8, %12, %12) <{leadDimension = 32 : index}> : (!gpu.mma_matrix<16x16xf32, "COp">, memref<16x16xf32, #spirv.storage_class<StorageBuffer>>, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, sym_name = "gpu_wmma_elementwise_op_default", workgroup_attributions = 0 : i64} : () -> ()
    "gpu.func"() <{function_type = (!gpu.mma_matrix<16x16xf16, "COp">, f16, memref<16x16xf16, #spirv.storage_class<StorageBuffer>>) -> ()}> ({
    ^bb0(%arg3: !gpu.mma_matrix<16x16xf16, "COp">, %arg4: f16, %arg5: memref<16x16xf16, #spirv.storage_class<StorageBuffer>>):
      %3 = "arith.constant"() <{value = 0 : index}> : () -> index
      %4 = "gpu.subgroup_mma_constant_matrix"(%arg4) : (f16) -> !gpu.mma_matrix<16x16xf16, "COp">
      %5 = "gpu.subgroup_mma_elementwise"(%arg3, %4) <{opType = #gpu<mma_element_wise mulf>}> : (!gpu.mma_matrix<16x16xf16, "COp">, !gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
      "gpu.subgroup_mma_store_matrix"(%5, %arg5, %3, %3) <{leadDimension = 32 : index}> : (!gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf16, #spirv.storage_class<StorageBuffer>>, index, index) -> ()
      %6 = "gpu.subgroup_mma_elementwise"(%4, %5) <{opType = #gpu<mma_element_wise mulf>}> : (!gpu.mma_matrix<16x16xf16, "COp">, !gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
      "gpu.subgroup_mma_store_matrix"(%6, %arg5, %3, %3) <{leadDimension = 32 : index}> : (!gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf16, #spirv.storage_class<StorageBuffer>>, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, sym_name = "gpu_wmma_elementwise_op_matrix_times_scalar", workgroup_attributions = 0 : i64} : () -> ()
    "gpu.func"() <{function_type = (!gpu.mma_matrix<16x16xf16, "COp">, f16, memref<16x16xf16, #spirv.storage_class<StorageBuffer>>) -> ()}> ({
    ^bb0(%arg0: !gpu.mma_matrix<16x16xf16, "COp">, %arg1: f16, %arg2: memref<16x16xf16, #spirv.storage_class<StorageBuffer>>):
      %0 = "arith.constant"() <{value = 0 : index}> : () -> index
      %1 = "gpu.subgroup_mma_constant_matrix"(%arg1) : (f16) -> !gpu.mma_matrix<16x16xf16, "COp">
      %2 = "gpu.subgroup_mma_elementwise"(%arg0, %1) <{opType = #gpu<mma_element_wise addf>}> : (!gpu.mma_matrix<16x16xf16, "COp">, !gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
      "gpu.subgroup_mma_store_matrix"(%2, %arg2, %0, %0) <{leadDimension = 32 : index}> : (!gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf16, #spirv.storage_class<StorageBuffer>>, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, sym_name = "gpu_wmma_elementwise_op_matrix_plus_scalar", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.6, [Shader, CooperativeMatrixKHR, Float16], [SPV_KHR_storage_buffer_storage_class, SPV_KHR_cooperative_matrix]>, #spirv.resource_limits<>>} : () -> ()

