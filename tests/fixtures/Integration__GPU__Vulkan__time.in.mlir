"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (memref<16384xf32>, memref<16384xf32>, memref<16384xf32>) -> ()}> ({
    ^bb0(%arg0: memref<16384xf32>, %arg1: memref<16384xf32>, %arg2: memref<16384xf32>):
      %15 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
      %16 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %17 = "arith.constant"() <{value = 128 : index}> : () -> index
      %18 = "arith.muli"(%15, %17) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %19 = "arith.addi"(%18, %16) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %20 = "memref.load"(%arg0, %19) : (memref<16384xf32>, index) -> f32
      %21 = "memref.load"(%arg1, %19) : (memref<16384xf32>, index) -> f32
      %22 = "arith.addf"(%20, %21) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "memref.store"(%22, %arg2, %19) : (f32, memref<16384xf32>, index) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [128, 1, 1]>, sym_name = "kernel_add", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<16384xf32>
    %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<16384xf32>
    %2 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<16384xf32>
    %3 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %4 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %5 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %6 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %7 = "arith.constant"() <{value = 1.100000e+00 : f32}> : () -> f32
    %8 = "arith.constant"() <{value = 2.200000e+00 : f32}> : () -> f32
    %9 = "memref.cast"(%0) : (memref<16384xf32>) -> memref<?xf32>
    %10 = "memref.cast"(%1) : (memref<16384xf32>) -> memref<?xf32>
    %11 = "memref.cast"(%2) : (memref<16384xf32>) -> memref<?xf32>
    "func.call"(%9, %7) <{callee = @fillResource1DFloat}> : (memref<?xf32>, f32) -> ()
    "func.call"(%10, %8) <{callee = @fillResource1DFloat}> : (memref<?xf32>, f32) -> ()
    "func.call"(%11, %6) <{callee = @fillResource1DFloat}> : (memref<?xf32>, f32) -> ()
    %12 = "arith.constant"() <{value = 1 : index}> : () -> index
    %13 = "arith.constant"() <{value = 128 : index}> : () -> index
    "gpu.launch_func"(%13, %12, %12, %13, %12, %12, %0, %1, %2) <{kernel = @kernels::@kernel_add, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 3, 0>}> : (index, index, index, index, index, index, memref<16384xf32>, memref<16384xf32>, memref<16384xf32>) -> ()
    %14 = "memref.cast"(%11) : (memref<?xf32>) -> memref<*xf32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32>, f32) -> (), sym_name = "fillResource1DFloat", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (memref<*xf32>) -> (), sym_name = "printMemrefF32", sym_visibility = "private"}> ({
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

