"builtin.module"() ({
  "func.func"() <{function_type = (memref<12x4xf32, #spirv.storage_class<StorageBuffer>>, memref<12x4xf32, #spirv.storage_class<StorageBuffer>>, memref<12x4xf32, #spirv.storage_class<StorageBuffer>>) -> (), sym_name = "load_store"}> ({
  ^bb0(%arg7: memref<12x4xf32, #spirv.storage_class<StorageBuffer>>, %arg8: memref<12x4xf32, #spirv.storage_class<StorageBuffer>>, %arg9: memref<12x4xf32, #spirv.storage_class<StorageBuffer>>):
    %17 = "arith.constant"() <{value = 0 : index}> : () -> index
    %18 = "arith.constant"() <{value = 12 : index}> : () -> index
    %19 = "arith.subi"(%18, %17) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %20 = "arith.constant"() <{value = 1 : index}> : () -> index
    %21 = "arith.constant"() <{value = 0 : index}> : () -> index
    %22 = "arith.constant"() <{value = 4 : index}> : () -> index
    %23 = "arith.subi"(%22, %21) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %24 = "arith.constant"() <{value = 1 : index}> : () -> index
    %25 = "arith.constant"() <{value = 1 : index}> : () -> index
    "gpu.launch_func"(%19, %25, %25, %23, %25, %25, %arg7, %arg8, %arg9, %17, %21, %20, %24) <{kernel = @kernels::@load_store_kernel, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 7, 0>}> : (index, index, index, index, index, index, memref<12x4xf32, #spirv.storage_class<StorageBuffer>>, memref<12x4xf32, #spirv.storage_class<StorageBuffer>>, memref<12x4xf32, #spirv.storage_class<StorageBuffer>>, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (memref<12x4xf32, #spirv.storage_class<StorageBuffer>>, memref<12x4xf32, #spirv.storage_class<StorageBuffer>>, memref<12x4xf32, #spirv.storage_class<StorageBuffer>>, index, index, index, index) -> ()}> ({
    ^bb0(%arg0: memref<12x4xf32, #spirv.storage_class<StorageBuffer>>, %arg1: memref<12x4xf32, #spirv.storage_class<StorageBuffer>>, %arg2: memref<12x4xf32, #spirv.storage_class<StorageBuffer>>, %arg3: index, %arg4: index, %arg5: index, %arg6: index):
      %0 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
      %1 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
      %2 = "gpu.block_id"() <{dimension = #gpu<dim z>}> : () -> index
      %3 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %4 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
      %5 = "gpu.thread_id"() <{dimension = #gpu<dim z>}> : () -> index
      %6 = "gpu.grid_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %7 = "gpu.grid_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %8 = "gpu.grid_dim"() <{dimension = #gpu<dim z>}> : () -> index
      %9 = "gpu.block_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %10 = "gpu.block_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %11 = "gpu.block_dim"() <{dimension = #gpu<dim z>}> : () -> index
      %12 = "arith.addi"(%arg3, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %13 = "arith.addi"(%arg4, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %14 = "memref.load"(%arg0, %12, %13) : (memref<12x4xf32, #spirv.storage_class<StorageBuffer>>, index, index) -> f32
      %15 = "memref.load"(%arg1, %12, %13) : (memref<12x4xf32, #spirv.storage_class<StorageBuffer>>, index, index) -> f32
      %16 = "arith.addf"(%14, %15) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "memref.store"(%16, %arg2, %12, %13) : (f32, memref<12x4xf32, #spirv.storage_class<StorageBuffer>>, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "load_store_kernel", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

