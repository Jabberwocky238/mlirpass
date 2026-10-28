"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (memref<8xi32>, memref<8xi32>, memref<8xi32>, memref<8xi32>) -> ()}> ({
    ^bb0(%arg0: memref<8xi32>, %arg1: memref<8xi32>, %arg2: memref<8xi32>, %arg3: memref<8xi32>):
      %14 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
      %15 = "memref.load"(%arg0, %14) : (memref<8xi32>, index) -> i32
      %16 = "memref.load"(%arg1, %14) : (memref<8xi32>, index) -> i32
      %17:2 = "arith.mulsi_extended"(%15, %16) : (i32, i32) -> (i32, i32)
      "memref.store"(%17#0, %arg2, %14) : (i32, memref<8xi32>, index) -> ()
      "memref.store"(%17#1, %arg3, %14) : (i32, memref<8xi32>, index) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [1, 1, 1]>, sym_name = "kernel_add", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<8xi32>
    %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<8xi32>
    %2 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<8xi32>
    %3 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<8xi32>
    %4 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %5 = "memref.cast"(%2) : (memref<8xi32>) -> memref<?xi32>
    %6 = "memref.cast"(%3) : (memref<8xi32>) -> memref<?xi32>
    "func.call"(%5, %4) <{callee = @fillResource1DInt}> : (memref<?xi32>, i32) -> ()
    "func.call"(%6, %4) <{callee = @fillResource1DInt}> : (memref<?xi32>, i32) -> ()
    %7 = "arith.constant"() <{value = 0 : index}> : () -> index
    %8 = "arith.constant"() <{value = 1 : index}> : () -> index
    %9 = "arith.constant"() <{value = 8 : index}> : () -> index
    %10 = "arith.constant"() <{value = dense<[0, 1, -1, -1, 65535, 65535, -65535, 2088183954]> : vector<8xi32>}> : () -> vector<8xi32>
    %11 = "arith.constant"() <{value = dense<[0, 1, 2, -1, 16, -1337, -65535, -1028001427]> : vector<8xi32>}> : () -> vector<8xi32>
    "vector.store"(%10, %0, %7) : (vector<8xi32>, memref<8xi32>, index) -> ()
    "vector.store"(%11, %1, %7) : (vector<8xi32>, memref<8xi32>, index) -> ()
    "gpu.launch_func"(%9, %8, %8, %8, %8, %8, %0, %1, %2, %3) <{kernel = @kernels::@kernel_add, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 4, 0>}> : (index, index, index, index, index, index, memref<8xi32>, memref<8xi32>, memref<8xi32>, memref<8xi32>) -> ()
    %12 = "memref.cast"(%5) : (memref<?xi32>) -> memref<*xi32>
    %13 = "memref.cast"(%6) : (memref<?xi32>) -> memref<*xi32>
    "func.call"(%12) <{callee = @printMemrefI32}> : (memref<*xi32>) -> ()
    "func.call"(%13) <{callee = @printMemrefI32}> : (memref<*xi32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xi32>, i32) -> (), sym_name = "fillResource1DInt", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (memref<*xi32>) -> (), sym_name = "printMemrefI32", sym_visibility = "private"}> ({
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.4, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

