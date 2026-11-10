"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (memref<32x32xf16, #spirv.storage_class<StorageBuffer>>) -> (), kernel}> ({
    ^bb0(%arg25: memref<32x32xf16, #spirv.storage_class<StorageBuffer>>):
      %27 = "arith.constant"() <{value = 16 : index}> : () -> index
      %28 = "arith.constant"() <{value = 16 : index}> : () -> index
      %29 = "gpu.subgroup_mma_load_matrix"(%arg25, %27, %28) <{leadDimension = 32 : index}> : (memref<32x32xf16, #spirv.storage_class<StorageBuffer>>, index, index) -> !gpu.mma_matrix<16x16xf16, "COp">
      %30 = "gpu.subgroup_mma_load_matrix"(%arg25, %27, %28) <{leadDimension = 32 : index, transpose}> : (memref<32x32xf16, #spirv.storage_class<StorageBuffer>>, index, index) -> !gpu.mma_matrix<16x16xf16, "COp">
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, sym_name = "gpu_wmma_load_op"} : () -> ()
    "gpu.func"() <{function_type = (memref<32x32xf16, #spirv.storage_class<StorageBuffer>>, !gpu.mma_matrix<16x16xf16, "COp">) -> (), kernel}> ({
    ^bb0(%arg23: memref<32x32xf16, #spirv.storage_class<StorageBuffer>>, %arg24: !gpu.mma_matrix<16x16xf16, "COp">):
      %25 = "arith.constant"() <{value = 16 : index}> : () -> index
      %26 = "arith.constant"() <{value = 16 : index}> : () -> index
      "gpu.subgroup_mma_store_matrix"(%arg24, %arg23, %25, %26) <{leadDimension = 32 : index}> : (!gpu.mma_matrix<16x16xf16, "COp">, memref<32x32xf16, #spirv.storage_class<StorageBuffer>>, index, index) -> ()
      "gpu.subgroup_mma_store_matrix"(%arg24, %arg23, %25, %26) <{leadDimension = 32 : index, transpose}> : (!gpu.mma_matrix<16x16xf16, "COp">, memref<32x32xf16, #spirv.storage_class<StorageBuffer>>, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, sym_name = "gpu_wmma_store_op"} : () -> ()
    "gpu.func"() <{function_type = (!gpu.mma_matrix<16x16xf16, "AOp">, !gpu.mma_matrix<16x16xf16, "BOp">, !gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf16, #spirv.storage_class<StorageBuffer>>) -> (), kernel}> ({
    ^bb0(%arg19: !gpu.mma_matrix<16x16xf16, "AOp">, %arg20: !gpu.mma_matrix<16x16xf16, "BOp">, %arg21: !gpu.mma_matrix<16x16xf16, "COp">, %arg22: memref<16x16xf16, #spirv.storage_class<StorageBuffer>>):
      %23 = "gpu.subgroup_mma_compute"(%arg19, %arg20, %arg21) : (!gpu.mma_matrix<16x16xf16, "AOp">, !gpu.mma_matrix<16x16xf16, "BOp">, !gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
      %24 = "arith.constant"() <{value = 0 : index}> : () -> index
      "gpu.subgroup_mma_store_matrix"(%23, %arg22, %24, %24) <{leadDimension = 32 : index}> : (!gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf16, #spirv.storage_class<StorageBuffer>>, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, sym_name = "gpu_wmma_mma_op"} : () -> ()
    "gpu.func"() <{function_type = (!gpu.mma_matrix<16x16xsi8, "AOp">, !gpu.mma_matrix<16x16xsi8, "BOp">, !gpu.mma_matrix<16x16xi32, "COp">, memref<16x16xi32, #spirv.storage_class<StorageBuffer>>) -> (), kernel}> ({
    ^bb0(%arg15: !gpu.mma_matrix<16x16xsi8, "AOp">, %arg16: !gpu.mma_matrix<16x16xsi8, "BOp">, %arg17: !gpu.mma_matrix<16x16xi32, "COp">, %arg18: memref<16x16xi32, #spirv.storage_class<StorageBuffer>>):
      %21 = "gpu.subgroup_mma_compute"(%arg15, %arg16, %arg17) : (!gpu.mma_matrix<16x16xsi8, "AOp">, !gpu.mma_matrix<16x16xsi8, "BOp">, !gpu.mma_matrix<16x16xi32, "COp">) -> !gpu.mma_matrix<16x16xi32, "COp">
      %22 = "arith.constant"() <{value = 0 : index}> : () -> index
      "gpu.subgroup_mma_store_matrix"(%21, %arg18, %22, %22) <{leadDimension = 32 : index}> : (!gpu.mma_matrix<16x16xi32, "COp">, memref<16x16xi32, #spirv.storage_class<StorageBuffer>>, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, sym_name = "gpu_wmma_signed_i8_mma_op"} : () -> ()
    "gpu.func"() <{function_type = (memref<16x16xf16, #spirv.storage_class<StorageBuffer>>) -> (), kernel}> ({
    ^bb0(%arg14: memref<16x16xf16, #spirv.storage_class<StorageBuffer>>):
      %18 = "arith.constant"() <{value = 1.000000e+00 : f16}> : () -> f16
      %19 = "gpu.subgroup_mma_constant_matrix"(%18) : (f16) -> !gpu.mma_matrix<16x16xf16, "COp">
      %20 = "arith.constant"() <{value = 0 : index}> : () -> index
      "gpu.subgroup_mma_store_matrix"(%19, %arg14, %20, %20) <{leadDimension = 32 : index}> : (!gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf16, #spirv.storage_class<StorageBuffer>>, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, sym_name = "gpu_wmma_constant_op"} : () -> ()
    "gpu.func"() <{function_type = (!gpu.mma_matrix<16x16xf32, "AOp">, memref<16x16xf32, #spirv.storage_class<StorageBuffer>>) -> (), kernel}> ({
    ^bb0(%arg12: !gpu.mma_matrix<16x16xf32, "AOp">, %arg13: memref<16x16xf32, #spirv.storage_class<StorageBuffer>>):
      %16 = "arith.constant"() <{value = 0 : index}> : () -> index
      %17 = "gpu.subgroup_mma_extract_thread_local"(%arg12, %16) : (!gpu.mma_matrix<16x16xf32, "AOp">, index) -> f32
      "memref.store"(%17, %arg13, %16, %16) : (f32, memref<16x16xf32, #spirv.storage_class<StorageBuffer>>, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, sym_name = "gpu_wmma_extract_thread_local_op"} : () -> ()
    "gpu.func"() <{function_type = (f16, !gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf16, #spirv.storage_class<StorageBuffer>>) -> (), kernel}> ({
    ^bb0(%arg9: f16, %arg10: !gpu.mma_matrix<16x16xf16, "COp">, %arg11: memref<16x16xf16, #spirv.storage_class<StorageBuffer>>):
      %14 = "arith.constant"() <{value = 0 : index}> : () -> index
      %15 = "gpu.subgroup_mma_insert_thread_local"(%arg9, %arg10, %14) : (f16, !gpu.mma_matrix<16x16xf16, "COp">, index) -> !gpu.mma_matrix<16x16xf16, "COp">
      "gpu.subgroup_mma_store_matrix"(%15, %arg11, %14, %14) <{leadDimension = 16 : index}> : (!gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf16, #spirv.storage_class<StorageBuffer>>, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, sym_name = "gpu_wmma_insert_thread_local_op"} : () -> ()
    "gpu.func"() <{function_type = (!gpu.mma_matrix<16x16xf16, "COp">, !gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf16, #spirv.storage_class<StorageBuffer>>) -> (), kernel}> ({
    ^bb0(%arg6: !gpu.mma_matrix<16x16xf16, "COp">, %arg7: !gpu.mma_matrix<16x16xf16, "COp">, %arg8: memref<16x16xf16, #spirv.storage_class<StorageBuffer>>):
      %7 = "gpu.subgroup_mma_elementwise"(%arg6, %arg7) <{opType = #gpu<mma_element_wise addf>}> : (!gpu.mma_matrix<16x16xf16, "COp">, !gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
      %8 = "gpu.subgroup_mma_elementwise"(%7) <{opType = #gpu<mma_element_wise negatef>}> : (!gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
      %9 = "gpu.subgroup_mma_elementwise"(%8, %arg6) <{opType = #gpu<mma_element_wise divf>}> : (!gpu.mma_matrix<16x16xf16, "COp">, !gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
      %10 = "gpu.subgroup_mma_elementwise"(%9, %arg6) <{opType = #gpu<mma_element_wise mulf>}> : (!gpu.mma_matrix<16x16xf16, "COp">, !gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
      %11 = "gpu.subgroup_mma_elementwise"(%10) <{opType = #gpu<mma_element_wise extf>}> : (!gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf32, "COp">
      %12 = "gpu.subgroup_mma_elementwise"(%11) <{opType = #gpu<mma_element_wise truncf>}> : (!gpu.mma_matrix<16x16xf32, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
      %13 = "arith.constant"() <{value = 0 : index}> : () -> index
      "gpu.subgroup_mma_store_matrix"(%12, %arg8, %13, %13) <{leadDimension = 32 : index}> : (!gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf16, #spirv.storage_class<StorageBuffer>>, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, sym_name = "gpu_wmma_elementwise_op_default"} : () -> ()
    "gpu.func"() <{function_type = (!gpu.mma_matrix<16x16xf16, "COp">, f16, memref<16x16xf16, #spirv.storage_class<StorageBuffer>>) -> (), kernel}> ({
    ^bb0(%arg3: !gpu.mma_matrix<16x16xf16, "COp">, %arg4: f16, %arg5: memref<16x16xf16, #spirv.storage_class<StorageBuffer>>):
      %3 = "arith.constant"() <{value = 0 : index}> : () -> index
      %4 = "gpu.subgroup_mma_constant_matrix"(%arg4) : (f16) -> !gpu.mma_matrix<16x16xf16, "COp">
      %5 = "gpu.subgroup_mma_elementwise"(%arg3, %4) <{opType = #gpu<mma_element_wise mulf>}> : (!gpu.mma_matrix<16x16xf16, "COp">, !gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
      "gpu.subgroup_mma_store_matrix"(%5, %arg5, %3, %3) <{leadDimension = 32 : index}> : (!gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf16, #spirv.storage_class<StorageBuffer>>, index, index) -> ()
      %6 = "gpu.subgroup_mma_elementwise"(%4, %5) <{opType = #gpu<mma_element_wise mulf>}> : (!gpu.mma_matrix<16x16xf16, "COp">, !gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
      "gpu.subgroup_mma_store_matrix"(%6, %arg5, %3, %3) <{leadDimension = 32 : index}> : (!gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf16, #spirv.storage_class<StorageBuffer>>, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, sym_name = "gpu_wmma_elementwise_op_matrix_times_scalar"} : () -> ()
    "gpu.func"() <{function_type = (!gpu.mma_matrix<16x16xf16, "COp">, f16, memref<16x16xf16, #spirv.storage_class<StorageBuffer>>) -> (), kernel}> ({
    ^bb0(%arg0: !gpu.mma_matrix<16x16xf16, "COp">, %arg1: f16, %arg2: memref<16x16xf16, #spirv.storage_class<StorageBuffer>>):
      %0 = "arith.constant"() <{value = 0 : index}> : () -> index
      %1 = "gpu.subgroup_mma_constant_matrix"(%arg1) : (f16) -> !gpu.mma_matrix<16x16xf16, "COp">
      %2 = "gpu.subgroup_mma_elementwise"(%arg0, %1) <{opType = #gpu<mma_element_wise addf>}> : (!gpu.mma_matrix<16x16xf16, "COp">, !gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
      "gpu.subgroup_mma_store_matrix"(%2, %arg2, %0, %0) <{leadDimension = 32 : index}> : (!gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf16, #spirv.storage_class<StorageBuffer>>, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, sym_name = "gpu_wmma_elementwise_op_matrix_plus_scalar"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.6, [Shader, CooperativeMatrixKHR, Float16, Int8], [SPV_KHR_storage_buffer_storage_class, SPV_KHR_cooperative_matrix]>, #spirv.resource_limits<>>} : () -> ()

