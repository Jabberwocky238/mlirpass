"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (memref<8xi8>, memref<8x8xi8>, memref<8x8x8xi32>) -> ()}> ({
    ^bb0(%arg0: memref<8xi8>, %arg1: memref<8x8xi8>, %arg2: memref<8x8x8xi32>):
      %12 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
      %13 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
      %14 = "gpu.block_id"() <{dimension = #gpu<dim z>}> : () -> index
      %15 = "memref.load"(%arg0, %12) : (memref<8xi8>, index) -> i8
      %16 = "memref.load"(%arg1, %13, %12) : (memref<8x8xi8>, index, index) -> i8
      %17 = "arith.addi"(%15, %16) <{overflowFlags = #arith.overflow<none>}> : (i8, i8) -> i8
      %18 = "arith.extui"(%17) : (i8) -> i32
      "memref.store"(%18, %arg2, %14, %13, %12) : (i32, memref<8x8x8xi32>, index, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [1, 1, 1]>, sym_name = "kernel_addi", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<8xi8>
    %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<8x8xi8>
    %2 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<8x8x8xi32>
    %3 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %4 = "arith.constant"() <{value = 1 : i8}> : () -> i8
    %5 = "arith.constant"() <{value = 2 : i8}> : () -> i8
    %6 = "memref.cast"(%0) : (memref<8xi8>) -> memref<?xi8>
    %7 = "memref.cast"(%1) : (memref<8x8xi8>) -> memref<?x?xi8>
    %8 = "memref.cast"(%2) : (memref<8x8x8xi32>) -> memref<?x?x?xi32>
    "func.call"(%6, %4) <{callee = @fillResource1DInt8}> : (memref<?xi8>, i8) -> ()
    "func.call"(%7, %5) <{callee = @fillResource2DInt8}> : (memref<?x?xi8>, i8) -> ()
    "func.call"(%8, %3) <{callee = @fillResource3DInt}> : (memref<?x?x?xi32>, i32) -> ()
    %9 = "arith.constant"() <{value = 1 : index}> : () -> index
    %10 = "arith.constant"() <{value = 8 : index}> : () -> index
    "gpu.launch_func"(%10, %10, %10, %9, %9, %9, %0, %1, %2) <{kernel = @kernels::@kernel_addi, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 3, 0>}> : (index, index, index, index, index, index, memref<8xi8>, memref<8x8xi8>, memref<8x8x8xi32>) -> ()
    %11 = "memref.cast"(%8) : (memref<?x?x?xi32>) -> memref<*xi32>
    "func.call"(%11) <{callee = @printMemrefI32}> : (memref<*xi32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xi8>, i8) -> (), sym_name = "fillResource1DInt8", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (memref<?x?xi8>, i8) -> (), sym_name = "fillResource2DInt8", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (memref<?x?x?xi32>, i32) -> (), sym_name = "fillResource3DInt", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (memref<*xi32>) -> (), sym_name = "printMemrefI32", sym_visibility = "private"}> ({
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class, SPV_KHR_8bit_storage]>, #spirv.resource_limits<>>} : () -> ()

