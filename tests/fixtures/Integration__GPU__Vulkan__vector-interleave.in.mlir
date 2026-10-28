"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (memref<2xi32>, memref<2xi32>, memref<4xi32>) -> ()}> ({
    ^bb0(%arg0: memref<2xi32>, %arg1: memref<2xi32>, %arg2: memref<4xi32>):
      %11 = "arith.constant"() <{value = 0 : index}> : () -> index
      %12 = "arith.constant"() <{value = 1 : index}> : () -> index
      %13 = "arith.constant"() <{value = 2 : index}> : () -> index
      %14 = "arith.constant"() <{value = 3 : index}> : () -> index
      %15 = "arith.constant"() <{value = 4 : index}> : () -> index
      %16 = "arith.constant"() <{value = dense<0> : vector<2xi32>}> : () -> vector<2xi32>
      %17 = "arith.constant"() <{value = dense<0> : vector<2xi32>}> : () -> vector<2xi32>
      %18 = "memref.load"(%arg0, %11) : (memref<2xi32>, index) -> i32
      %19 = "memref.load"(%arg0, %12) : (memref<2xi32>, index) -> i32
      %20 = "memref.load"(%arg1, %11) : (memref<2xi32>, index) -> i32
      %21 = "memref.load"(%arg1, %12) : (memref<2xi32>, index) -> i32
      %22 = "vector.insert"(%18, %16, %11) <{static_position = array<i64: -9223372036854775808>}> : (i32, vector<2xi32>, index) -> vector<2xi32>
      %23 = "vector.insert"(%19, %22, %12) <{static_position = array<i64: -9223372036854775808>}> : (i32, vector<2xi32>, index) -> vector<2xi32>
      %24 = "vector.insert"(%20, %17, %11) <{static_position = array<i64: -9223372036854775808>}> : (i32, vector<2xi32>, index) -> vector<2xi32>
      %25 = "vector.insert"(%21, %24, %12) <{static_position = array<i64: -9223372036854775808>}> : (i32, vector<2xi32>, index) -> vector<2xi32>
      %26 = "vector.interleave"(%23, %25) : (vector<2xi32>, vector<2xi32>) -> vector<4xi32>
      %27 = "vector.extract"(%26, %11) <{static_position = array<i64: -9223372036854775808>}> : (vector<4xi32>, index) -> i32
      %28 = "vector.extract"(%26, %12) <{static_position = array<i64: -9223372036854775808>}> : (vector<4xi32>, index) -> i32
      %29 = "vector.extract"(%26, %13) <{static_position = array<i64: -9223372036854775808>}> : (vector<4xi32>, index) -> i32
      %30 = "vector.extract"(%26, %14) <{static_position = array<i64: -9223372036854775808>}> : (vector<4xi32>, index) -> i32
      "memref.store"(%27, %arg2, %11) : (i32, memref<4xi32>, index) -> ()
      "memref.store"(%28, %arg2, %12) : (i32, memref<4xi32>, index) -> ()
      "memref.store"(%29, %arg2, %13) : (i32, memref<4xi32>, index) -> ()
      "memref.store"(%30, %arg2, %14) : (i32, memref<4xi32>, index) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [1, 1, 1]>, sym_name = "kernel_vector_interleave", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2xi32>
    %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2xi32>
    %2 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4xi32>
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    %5 = "arith.constant"() <{value = 4 : index}> : () -> index
    %6 = "arith.constant"() <{value = dense<[0, 1]> : vector<2xi32>}> : () -> vector<2xi32>
    %7 = "arith.constant"() <{value = dense<[2, 3]> : vector<2xi32>}> : () -> vector<2xi32>
    "vector.store"(%6, %0, %3) : (vector<2xi32>, memref<2xi32>, index) -> ()
    "vector.store"(%7, %1, %3) : (vector<2xi32>, memref<2xi32>, index) -> ()
    %8 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %9 = "memref.cast"(%2) : (memref<4xi32>) -> memref<?xi32>
    "func.call"(%9, %8) <{callee = @fillResource1DInt}> : (memref<?xi32>, i32) -> ()
    "gpu.launch_func"(%5, %4, %4, %4, %4, %4, %0, %1, %2) <{kernel = @kernels::@kernel_vector_interleave, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 3, 0>}> : (index, index, index, index, index, index, memref<2xi32>, memref<2xi32>, memref<4xi32>) -> ()
    %10 = "memref.cast"(%9) : (memref<?xi32>) -> memref<*xi32>
    "func.call"(%10) <{callee = @printMemrefI32}> : (memref<*xi32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xi32>, i32) -> (), sym_name = "fillResource1DInt", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (memref<*xi32>) -> (), sym_name = "printMemrefI32", sym_visibility = "private"}> ({
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

