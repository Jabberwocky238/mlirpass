"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (memref<4xi32>, memref<2xi32>, memref<2xi32>) -> ()}> ({
    ^bb0(%arg0: memref<4xi32>, %arg1: memref<2xi32>, %arg2: memref<2xi32>):
      %12 = "arith.constant"() <{value = 0 : index}> : () -> index
      %13 = "arith.constant"() <{value = 1 : index}> : () -> index
      %14 = "arith.constant"() <{value = 2 : index}> : () -> index
      %15 = "arith.constant"() <{value = 3 : index}> : () -> index
      %16 = "arith.constant"() <{value = dense<0> : vector<4xi32>}> : () -> vector<4xi32>
      %17 = "memref.load"(%arg0, %12) : (memref<4xi32>, index) -> i32
      %18 = "memref.load"(%arg0, %13) : (memref<4xi32>, index) -> i32
      %19 = "memref.load"(%arg0, %14) : (memref<4xi32>, index) -> i32
      %20 = "memref.load"(%arg0, %15) : (memref<4xi32>, index) -> i32
      %21 = "vector.insert"(%17, %16) <{static_position = array<i64: 0>}> : (i32, vector<4xi32>) -> vector<4xi32>
      %22 = "vector.insert"(%18, %21) <{static_position = array<i64: 1>}> : (i32, vector<4xi32>) -> vector<4xi32>
      %23 = "vector.insert"(%19, %22) <{static_position = array<i64: 2>}> : (i32, vector<4xi32>) -> vector<4xi32>
      %24 = "vector.insert"(%20, %23) <{static_position = array<i64: 3>}> : (i32, vector<4xi32>) -> vector<4xi32>
      %25:2 = "vector.deinterleave"(%24) : (vector<4xi32>) -> (vector<2xi32>, vector<2xi32>)
      %26 = "vector.extract"(%25#0) <{static_position = array<i64: 0>}> : (vector<2xi32>) -> i32
      %27 = "vector.extract"(%25#0) <{static_position = array<i64: 1>}> : (vector<2xi32>) -> i32
      %28 = "vector.extract"(%25#1) <{static_position = array<i64: 0>}> : (vector<2xi32>) -> i32
      %29 = "vector.extract"(%25#1) <{static_position = array<i64: 1>}> : (vector<2xi32>) -> i32
      "memref.store"(%26, %arg1, %12) : (i32, memref<2xi32>, index) -> ()
      "memref.store"(%27, %arg1, %13) : (i32, memref<2xi32>, index) -> ()
      "memref.store"(%28, %arg2, %12) : (i32, memref<2xi32>, index) -> ()
      "memref.store"(%29, %arg2, %13) : (i32, memref<2xi32>, index) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [1, 1, 1]>, sym_name = "kernel_vector_deinterleave", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 4 : index}> : () -> index
    %3 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4xi32>
    %4 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2xi32>
    %5 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2xi32>
    %6 = "arith.constant"() <{value = dense<[0, 1, 2, 3]> : vector<4xi32>}> : () -> vector<4xi32>
    "vector.store"(%6, %3, %0) : (vector<4xi32>, memref<4xi32>, index) -> ()
    %7 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %8 = "memref.cast"(%4) : (memref<2xi32>) -> memref<?xi32>
    %9 = "memref.cast"(%5) : (memref<2xi32>) -> memref<?xi32>
    "func.call"(%8, %7) <{callee = @fillResource1DInt}> : (memref<?xi32>, i32) -> ()
    "func.call"(%9, %7) <{callee = @fillResource1DInt}> : (memref<?xi32>, i32) -> ()
    "gpu.launch_func"(%2, %1, %1, %1, %1, %1, %3, %4, %5) <{kernel = @kernels::@kernel_vector_deinterleave, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 3, 0>}> : (index, index, index, index, index, index, memref<4xi32>, memref<2xi32>, memref<2xi32>) -> ()
    %10 = "memref.cast"(%8) : (memref<?xi32>) -> memref<*xi32>
    %11 = "memref.cast"(%9) : (memref<?xi32>) -> memref<*xi32>
    "func.call"(%10) <{callee = @printMemrefI32}> : (memref<*xi32>) -> ()
    "func.call"(%11) <{callee = @printMemrefI32}> : (memref<*xi32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xi32>, i32) -> (), sym_name = "fillResource1DInt", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (memref<*xi32>) -> (), sym_name = "printMemrefI32", sym_visibility = "private"}> ({
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

