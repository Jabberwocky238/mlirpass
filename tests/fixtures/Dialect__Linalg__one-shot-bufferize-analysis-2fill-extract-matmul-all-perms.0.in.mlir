"builtin.module"() ({
^bb0:
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map3 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.buffer_layout = #map3, bufferization.writable = false}, {bufferization.buffer_layout = #map3, bufferization.writable = false}, {bufferization.buffer_layout = #map3, bufferization.writable = true}], function_type = (tensor<518x518xf32>, tensor<518x518xf32>, tensor<256x256xf32>) -> tensor<256x256xf32>, sym_name = "fill_extract_matmul_1234"}> ({
  ^bb0(%arg0: tensor<518x518xf32>, %arg1: tensor<518x518xf32>, %arg2: tensor<256x256xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %3 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<256x256xf32>
    %4 = "linalg.fill"(%1, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      "linalg.yield"(%arg8) : (f32) -> ()
    }) : (f32, tensor<256x256xf32>) -> tensor<256x256xf32>
    %5 = "linalg.fill"(%2, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<256x256xf32>) -> tensor<256x256xf32>
    %6 = "tensor.extract_slice"(%4) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 256, 16>, static_strides = array<i64: 1, 1>}> : (tensor<256x256xf32>) -> tensor<256x16xf32>
    %7 = "tensor.extract_slice"(%5) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 16, 256>, static_strides = array<i64: 1, 1>}> : (tensor<256x256xf32>) -> tensor<16x256xf32>
    %8 = "linalg.matmul"(%6, %7, %arg2) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %9 = "arith.mulf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %10 = "arith.addf"(%arg5, %9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%10) : (f32) -> ()
    }) : (tensor<256x16xf32>, tensor<16x256xf32>, tensor<256x256xf32>) -> tensor<256x256xf32>
    "func.return"(%8) : (tensor<256x256xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map3 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.buffer_layout = #map3, bufferization.writable = false}, {bufferization.buffer_layout = #map3, bufferization.writable = false}, {bufferization.buffer_layout = #map3, bufferization.writable = true}], function_type = (tensor<518x518xf32>, tensor<518x518xf32>, tensor<256x256xf32>) -> tensor<256x256xf32>, sym_name = "fill_extract_matmul_1243"}> ({
  ^bb0(%arg0: tensor<518x518xf32>, %arg1: tensor<518x518xf32>, %arg2: tensor<256x256xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %3 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<256x256xf32>
    %4 = "linalg.fill"(%1, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      "linalg.yield"(%arg8) : (f32) -> ()
    }) : (f32, tensor<256x256xf32>) -> tensor<256x256xf32>
    %5 = "linalg.fill"(%2, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<256x256xf32>) -> tensor<256x256xf32>
    %6 = "tensor.extract_slice"(%5) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 16, 256>, static_strides = array<i64: 1, 1>}> : (tensor<256x256xf32>) -> tensor<16x256xf32>
    %7 = "tensor.extract_slice"(%4) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 256, 16>, static_strides = array<i64: 1, 1>}> : (tensor<256x256xf32>) -> tensor<256x16xf32>
    %8 = "linalg.matmul"(%7, %6, %arg2) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %9 = "arith.mulf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %10 = "arith.addf"(%arg5, %9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%10) : (f32) -> ()
    }) : (tensor<256x16xf32>, tensor<16x256xf32>, tensor<256x256xf32>) -> tensor<256x256xf32>
    "func.return"(%8) : (tensor<256x256xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map3 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.buffer_layout = #map3, bufferization.writable = false}, {bufferization.buffer_layout = #map3, bufferization.writable = false}, {bufferization.buffer_layout = #map3, bufferization.writable = true}], function_type = (tensor<518x518xf32>, tensor<518x518xf32>, tensor<256x256xf32>) -> tensor<256x256xf32>, sym_name = "fill_extract_matmul_1324"}> ({
  ^bb0(%arg0: tensor<518x518xf32>, %arg1: tensor<518x518xf32>, %arg2: tensor<256x256xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %3 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<256x256xf32>
    %4 = "linalg.fill"(%1, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      "linalg.yield"(%arg8) : (f32) -> ()
    }) : (f32, tensor<256x256xf32>) -> tensor<256x256xf32>
    %5 = "tensor.extract_slice"(%4) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 256, 16>, static_strides = array<i64: 1, 1>}> : (tensor<256x256xf32>) -> tensor<256x16xf32>
    %6 = "linalg.fill"(%2, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<256x256xf32>) -> tensor<256x256xf32>
    %7 = "tensor.extract_slice"(%6) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 16, 256>, static_strides = array<i64: 1, 1>}> : (tensor<256x256xf32>) -> tensor<16x256xf32>
    %8 = "linalg.matmul"(%5, %7, %arg2) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %9 = "arith.mulf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %10 = "arith.addf"(%arg5, %9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%10) : (f32) -> ()
    }) : (tensor<256x16xf32>, tensor<16x256xf32>, tensor<256x256xf32>) -> tensor<256x256xf32>
    "func.return"(%8) : (tensor<256x256xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map3 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.buffer_layout = #map3, bufferization.writable = false}, {bufferization.buffer_layout = #map3, bufferization.writable = false}, {bufferization.buffer_layout = #map3, bufferization.writable = true}], function_type = (tensor<518x518xf32>, tensor<518x518xf32>, tensor<256x256xf32>) -> tensor<256x256xf32>, sym_name = "fill_extract_matmul_1342"}> ({
  ^bb0(%arg0: tensor<518x518xf32>, %arg1: tensor<518x518xf32>, %arg2: tensor<256x256xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %3 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<256x256xf32>
    %4 = "linalg.fill"(%1, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      "linalg.yield"(%arg8) : (f32) -> ()
    }) : (f32, tensor<256x256xf32>) -> tensor<256x256xf32>
    %5 = "tensor.extract_slice"(%4) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 256, 16>, static_strides = array<i64: 1, 1>}> : (tensor<256x256xf32>) -> tensor<256x16xf32>
    %6 = "tensor.extract_slice"(%3) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 16, 256>, static_strides = array<i64: 1, 1>}> : (tensor<256x256xf32>) -> tensor<16x256xf32>
    %7 = "linalg.fill"(%2, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<16x256xf32>) -> tensor<16x256xf32>
    %8 = "linalg.matmul"(%5, %7, %arg2) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %9 = "arith.mulf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %10 = "arith.addf"(%arg5, %9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%10) : (f32) -> ()
    }) : (tensor<256x16xf32>, tensor<16x256xf32>, tensor<256x256xf32>) -> tensor<256x256xf32>
    "func.return"(%8) : (tensor<256x256xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map3 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.buffer_layout = #map3, bufferization.writable = false}, {bufferization.buffer_layout = #map3, bufferization.writable = false}, {bufferization.buffer_layout = #map3, bufferization.writable = true}], function_type = (tensor<518x518xf32>, tensor<518x518xf32>, tensor<256x256xf32>) -> tensor<256x256xf32>, sym_name = "fill_extract_matmul_1423"}> ({
  ^bb0(%arg0: tensor<518x518xf32>, %arg1: tensor<518x518xf32>, %arg2: tensor<256x256xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %3 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<256x256xf32>
    %4 = "linalg.fill"(%1, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      "linalg.yield"(%arg8) : (f32) -> ()
    }) : (f32, tensor<256x256xf32>) -> tensor<256x256xf32>
    %5 = "tensor.extract_slice"(%3) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 16, 256>, static_strides = array<i64: 1, 1>}> : (tensor<256x256xf32>) -> tensor<16x256xf32>
    %6 = "linalg.fill"(%2, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<16x256xf32>) -> tensor<16x256xf32>
    %7 = "tensor.extract_slice"(%4) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 256, 16>, static_strides = array<i64: 1, 1>}> : (tensor<256x256xf32>) -> tensor<256x16xf32>
    %8 = "linalg.matmul"(%7, %6, %arg2) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %9 = "arith.mulf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %10 = "arith.addf"(%arg5, %9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%10) : (f32) -> ()
    }) : (tensor<256x16xf32>, tensor<16x256xf32>, tensor<256x256xf32>) -> tensor<256x256xf32>
    "func.return"(%8) : (tensor<256x256xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map3 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.buffer_layout = #map3, bufferization.writable = false}, {bufferization.buffer_layout = #map3, bufferization.writable = false}, {bufferization.buffer_layout = #map3, bufferization.writable = true}], function_type = (tensor<518x518xf32>, tensor<518x518xf32>, tensor<256x256xf32>) -> tensor<256x256xf32>, sym_name = "fill_extract_matmul_1432"}> ({
  ^bb0(%arg0: tensor<518x518xf32>, %arg1: tensor<518x518xf32>, %arg2: tensor<256x256xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %3 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<256x256xf32>
    %4 = "linalg.fill"(%1, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      "linalg.yield"(%arg8) : (f32) -> ()
    }) : (f32, tensor<256x256xf32>) -> tensor<256x256xf32>
    %5 = "tensor.extract_slice"(%3) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 16, 256>, static_strides = array<i64: 1, 1>}> : (tensor<256x256xf32>) -> tensor<16x256xf32>
    %6 = "tensor.extract_slice"(%4) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 256, 16>, static_strides = array<i64: 1, 1>}> : (tensor<256x256xf32>) -> tensor<256x16xf32>
    %7 = "linalg.fill"(%2, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<16x256xf32>) -> tensor<16x256xf32>
    %8 = "linalg.matmul"(%6, %7, %arg2) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %9 = "arith.mulf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %10 = "arith.addf"(%arg5, %9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%10) : (f32) -> ()
    }) : (tensor<256x16xf32>, tensor<16x256xf32>, tensor<256x256xf32>) -> tensor<256x256xf32>
    "func.return"(%8) : (tensor<256x256xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map3 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.buffer_layout = #map3, bufferization.writable = false}, {bufferization.buffer_layout = #map3, bufferization.writable = false}, {bufferization.buffer_layout = #map3, bufferization.writable = true}], function_type = (tensor<518x518xf32>, tensor<518x518xf32>, tensor<256x256xf32>) -> tensor<256x256xf32>, sym_name = "fill_extract_matmul_2134"}> ({
  ^bb0(%arg0: tensor<518x518xf32>, %arg1: tensor<518x518xf32>, %arg2: tensor<256x256xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %3 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<256x256xf32>
    %4 = "linalg.fill"(%2, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      "linalg.yield"(%arg8) : (f32) -> ()
    }) : (f32, tensor<256x256xf32>) -> tensor<256x256xf32>
    %5 = "linalg.fill"(%1, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<256x256xf32>) -> tensor<256x256xf32>
    %6 = "tensor.extract_slice"(%5) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 256, 16>, static_strides = array<i64: 1, 1>}> : (tensor<256x256xf32>) -> tensor<256x16xf32>
    %7 = "tensor.extract_slice"(%4) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 16, 256>, static_strides = array<i64: 1, 1>}> : (tensor<256x256xf32>) -> tensor<16x256xf32>
    %8 = "linalg.matmul"(%6, %7, %arg2) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %9 = "arith.mulf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %10 = "arith.addf"(%arg5, %9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%10) : (f32) -> ()
    }) : (tensor<256x16xf32>, tensor<16x256xf32>, tensor<256x256xf32>) -> tensor<256x256xf32>
    "func.return"(%8) : (tensor<256x256xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map3 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.buffer_layout = #map3, bufferization.writable = false}, {bufferization.buffer_layout = #map3, bufferization.writable = false}, {bufferization.buffer_layout = #map3, bufferization.writable = true}], function_type = (tensor<518x518xf32>, tensor<518x518xf32>, tensor<256x256xf32>) -> tensor<256x256xf32>, sym_name = "fill_extract_matmul_2143"}> ({
  ^bb0(%arg0: tensor<518x518xf32>, %arg1: tensor<518x518xf32>, %arg2: tensor<256x256xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %3 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<256x256xf32>
    %4 = "linalg.fill"(%2, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      "linalg.yield"(%arg8) : (f32) -> ()
    }) : (f32, tensor<256x256xf32>) -> tensor<256x256xf32>
    %5 = "linalg.fill"(%1, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<256x256xf32>) -> tensor<256x256xf32>
    %6 = "tensor.extract_slice"(%4) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 16, 256>, static_strides = array<i64: 1, 1>}> : (tensor<256x256xf32>) -> tensor<16x256xf32>
    %7 = "tensor.extract_slice"(%5) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 256, 16>, static_strides = array<i64: 1, 1>}> : (tensor<256x256xf32>) -> tensor<256x16xf32>
    %8 = "linalg.matmul"(%7, %6, %arg2) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %9 = "arith.mulf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %10 = "arith.addf"(%arg5, %9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%10) : (f32) -> ()
    }) : (tensor<256x16xf32>, tensor<16x256xf32>, tensor<256x256xf32>) -> tensor<256x256xf32>
    "func.return"(%8) : (tensor<256x256xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map3 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.buffer_layout = #map3, bufferization.writable = false}, {bufferization.buffer_layout = #map3, bufferization.writable = false}, {bufferization.buffer_layout = #map3, bufferization.writable = true}], function_type = (tensor<518x518xf32>, tensor<518x518xf32>, tensor<256x256xf32>) -> tensor<256x256xf32>, sym_name = "fill_extract_matmul_2314"}> ({
  ^bb0(%arg0: tensor<518x518xf32>, %arg1: tensor<518x518xf32>, %arg2: tensor<256x256xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %3 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<256x256xf32>
    %4 = "linalg.fill"(%2, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      "linalg.yield"(%arg8) : (f32) -> ()
    }) : (f32, tensor<256x256xf32>) -> tensor<256x256xf32>
    %5 = "tensor.extract_slice"(%3) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 256, 16>, static_strides = array<i64: 1, 1>}> : (tensor<256x256xf32>) -> tensor<256x16xf32>
    %6 = "linalg.fill"(%1, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<256x16xf32>) -> tensor<256x16xf32>
    %7 = "tensor.extract_slice"(%4) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 16, 256>, static_strides = array<i64: 1, 1>}> : (tensor<256x256xf32>) -> tensor<16x256xf32>
    %8 = "linalg.matmul"(%6, %7, %arg2) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %9 = "arith.mulf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %10 = "arith.addf"(%arg5, %9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%10) : (f32) -> ()
    }) : (tensor<256x16xf32>, tensor<16x256xf32>, tensor<256x256xf32>) -> tensor<256x256xf32>
    "func.return"(%8) : (tensor<256x256xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map3 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.buffer_layout = #map3, bufferization.writable = false}, {bufferization.buffer_layout = #map3, bufferization.writable = false}, {bufferization.buffer_layout = #map3, bufferization.writable = true}], function_type = (tensor<518x518xf32>, tensor<518x518xf32>, tensor<256x256xf32>) -> tensor<256x256xf32>, sym_name = "fill_extract_matmul_2341"}> ({
  ^bb0(%arg0: tensor<518x518xf32>, %arg1: tensor<518x518xf32>, %arg2: tensor<256x256xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %3 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<256x256xf32>
    %4 = "linalg.fill"(%2, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      "linalg.yield"(%arg8) : (f32) -> ()
    }) : (f32, tensor<256x256xf32>) -> tensor<256x256xf32>
    %5 = "tensor.extract_slice"(%3) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 256, 16>, static_strides = array<i64: 1, 1>}> : (tensor<256x256xf32>) -> tensor<256x16xf32>
    %6 = "tensor.extract_slice"(%4) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 16, 256>, static_strides = array<i64: 1, 1>}> : (tensor<256x256xf32>) -> tensor<16x256xf32>
    %7 = "linalg.fill"(%1, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<256x16xf32>) -> tensor<256x16xf32>
    %8 = "linalg.matmul"(%7, %6, %arg2) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %9 = "arith.mulf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %10 = "arith.addf"(%arg5, %9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%10) : (f32) -> ()
    }) : (tensor<256x16xf32>, tensor<16x256xf32>, tensor<256x256xf32>) -> tensor<256x256xf32>
    "func.return"(%8) : (tensor<256x256xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map3 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.buffer_layout = #map3, bufferization.writable = false}, {bufferization.buffer_layout = #map3, bufferization.writable = false}, {bufferization.buffer_layout = #map3, bufferization.writable = true}], function_type = (tensor<518x518xf32>, tensor<518x518xf32>, tensor<256x256xf32>) -> tensor<256x256xf32>, sym_name = "fill_extract_matmul_2413"}> ({
  ^bb0(%arg0: tensor<518x518xf32>, %arg1: tensor<518x518xf32>, %arg2: tensor<256x256xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %3 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<256x256xf32>
    %4 = "linalg.fill"(%2, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      "linalg.yield"(%arg8) : (f32) -> ()
    }) : (f32, tensor<256x256xf32>) -> tensor<256x256xf32>
    %5 = "tensor.extract_slice"(%4) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 16, 256>, static_strides = array<i64: 1, 1>}> : (tensor<256x256xf32>) -> tensor<16x256xf32>
    %6 = "linalg.fill"(%1, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<256x256xf32>) -> tensor<256x256xf32>
    %7 = "tensor.extract_slice"(%6) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 256, 16>, static_strides = array<i64: 1, 1>}> : (tensor<256x256xf32>) -> tensor<256x16xf32>
    %8 = "linalg.matmul"(%7, %5, %arg2) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %9 = "arith.mulf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %10 = "arith.addf"(%arg5, %9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%10) : (f32) -> ()
    }) : (tensor<256x16xf32>, tensor<16x256xf32>, tensor<256x256xf32>) -> tensor<256x256xf32>
    "func.return"(%8) : (tensor<256x256xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map3 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.buffer_layout = #map3, bufferization.writable = false}, {bufferization.buffer_layout = #map3, bufferization.writable = false}, {bufferization.buffer_layout = #map3, bufferization.writable = true}], function_type = (tensor<518x518xf32>, tensor<518x518xf32>, tensor<256x256xf32>) -> tensor<256x256xf32>, sym_name = "fill_extract_matmul_2431"}> ({
  ^bb0(%arg0: tensor<518x518xf32>, %arg1: tensor<518x518xf32>, %arg2: tensor<256x256xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %3 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<256x256xf32>
    %4 = "linalg.fill"(%2, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      "linalg.yield"(%arg8) : (f32) -> ()
    }) : (f32, tensor<256x256xf32>) -> tensor<256x256xf32>
    %5 = "tensor.extract_slice"(%4) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 16, 256>, static_strides = array<i64: 1, 1>}> : (tensor<256x256xf32>) -> tensor<16x256xf32>
    %6 = "tensor.extract_slice"(%3) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 256, 16>, static_strides = array<i64: 1, 1>}> : (tensor<256x256xf32>) -> tensor<256x16xf32>
    %7 = "linalg.fill"(%1, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<256x16xf32>) -> tensor<256x16xf32>
    %8 = "linalg.matmul"(%7, %5, %arg2) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %9 = "arith.mulf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %10 = "arith.addf"(%arg5, %9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%10) : (f32) -> ()
    }) : (tensor<256x16xf32>, tensor<16x256xf32>, tensor<256x256xf32>) -> tensor<256x256xf32>
    "func.return"(%8) : (tensor<256x256xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map3 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.buffer_layout = #map3, bufferization.writable = false}, {bufferization.buffer_layout = #map3, bufferization.writable = false}, {bufferization.buffer_layout = #map3, bufferization.writable = true}], function_type = (tensor<518x518xf32>, tensor<518x518xf32>, tensor<256x256xf32>) -> tensor<256x256xf32>, sym_name = "fill_extract_matmul_3124"}> ({
  ^bb0(%arg0: tensor<518x518xf32>, %arg1: tensor<518x518xf32>, %arg2: tensor<256x256xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %3 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<256x256xf32>
    %4 = "tensor.extract_slice"(%3) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 256, 16>, static_strides = array<i64: 1, 1>}> : (tensor<256x256xf32>) -> tensor<256x16xf32>
    %5 = "linalg.fill"(%1, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      "linalg.yield"(%arg8) : (f32) -> ()
    }) : (f32, tensor<256x16xf32>) -> tensor<256x16xf32>
    %6 = "linalg.fill"(%2, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<256x256xf32>) -> tensor<256x256xf32>
    %7 = "tensor.extract_slice"(%6) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 16, 256>, static_strides = array<i64: 1, 1>}> : (tensor<256x256xf32>) -> tensor<16x256xf32>
    %8 = "linalg.matmul"(%5, %7, %arg2) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %9 = "arith.mulf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %10 = "arith.addf"(%arg5, %9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%10) : (f32) -> ()
    }) : (tensor<256x16xf32>, tensor<16x256xf32>, tensor<256x256xf32>) -> tensor<256x256xf32>
    "func.return"(%8) : (tensor<256x256xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map3 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.buffer_layout = #map3, bufferization.writable = false}, {bufferization.buffer_layout = #map3, bufferization.writable = false}, {bufferization.buffer_layout = #map3, bufferization.writable = true}], function_type = (tensor<518x518xf32>, tensor<518x518xf32>, tensor<256x256xf32>) -> tensor<256x256xf32>, sym_name = "fill_extract_matmul_3142"}> ({
  ^bb0(%arg0: tensor<518x518xf32>, %arg1: tensor<518x518xf32>, %arg2: tensor<256x256xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %3 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<256x256xf32>
    %4 = "tensor.extract_slice"(%3) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 256, 16>, static_strides = array<i64: 1, 1>}> : (tensor<256x256xf32>) -> tensor<256x16xf32>
    %5 = "linalg.fill"(%1, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      "linalg.yield"(%arg8) : (f32) -> ()
    }) : (f32, tensor<256x16xf32>) -> tensor<256x16xf32>
    %6 = "tensor.extract_slice"(%3) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 16, 256>, static_strides = array<i64: 1, 1>}> : (tensor<256x256xf32>) -> tensor<16x256xf32>
    %7 = "linalg.fill"(%2, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<16x256xf32>) -> tensor<16x256xf32>
    %8 = "linalg.matmul"(%5, %7, %arg2) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %9 = "arith.mulf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %10 = "arith.addf"(%arg5, %9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%10) : (f32) -> ()
    }) : (tensor<256x16xf32>, tensor<16x256xf32>, tensor<256x256xf32>) -> tensor<256x256xf32>
    "func.return"(%8) : (tensor<256x256xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map3 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.buffer_layout = #map3, bufferization.writable = false}, {bufferization.buffer_layout = #map3, bufferization.writable = false}, {bufferization.buffer_layout = #map3, bufferization.writable = true}], function_type = (tensor<518x518xf32>, tensor<518x518xf32>, tensor<256x256xf32>) -> tensor<256x256xf32>, sym_name = "fill_extract_matmul_3214"}> ({
  ^bb0(%arg0: tensor<518x518xf32>, %arg1: tensor<518x518xf32>, %arg2: tensor<256x256xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %3 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<256x256xf32>
    %4 = "tensor.extract_slice"(%3) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 256, 16>, static_strides = array<i64: 1, 1>}> : (tensor<256x256xf32>) -> tensor<256x16xf32>
    %5 = "linalg.fill"(%2, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      "linalg.yield"(%arg8) : (f32) -> ()
    }) : (f32, tensor<256x256xf32>) -> tensor<256x256xf32>
    %6 = "linalg.fill"(%1, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<256x16xf32>) -> tensor<256x16xf32>
    %7 = "tensor.extract_slice"(%5) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 16, 256>, static_strides = array<i64: 1, 1>}> : (tensor<256x256xf32>) -> tensor<16x256xf32>
    %8 = "linalg.matmul"(%6, %7, %arg2) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %9 = "arith.mulf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %10 = "arith.addf"(%arg5, %9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%10) : (f32) -> ()
    }) : (tensor<256x16xf32>, tensor<16x256xf32>, tensor<256x256xf32>) -> tensor<256x256xf32>
    "func.return"(%8) : (tensor<256x256xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map3 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.buffer_layout = #map3, bufferization.writable = false}, {bufferization.buffer_layout = #map3, bufferization.writable = false}, {bufferization.buffer_layout = #map3, bufferization.writable = true}], function_type = (tensor<518x518xf32>, tensor<518x518xf32>, tensor<256x256xf32>) -> tensor<256x256xf32>, sym_name = "fill_extract_matmul_3241"}> ({
  ^bb0(%arg0: tensor<518x518xf32>, %arg1: tensor<518x518xf32>, %arg2: tensor<256x256xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %3 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<256x256xf32>
    %4 = "tensor.extract_slice"(%3) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 256, 16>, static_strides = array<i64: 1, 1>}> : (tensor<256x256xf32>) -> tensor<256x16xf32>
    %5 = "linalg.fill"(%2, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      "linalg.yield"(%arg8) : (f32) -> ()
    }) : (f32, tensor<256x256xf32>) -> tensor<256x256xf32>
    %6 = "tensor.extract_slice"(%5) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 16, 256>, static_strides = array<i64: 1, 1>}> : (tensor<256x256xf32>) -> tensor<16x256xf32>
    %7 = "linalg.fill"(%1, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<256x16xf32>) -> tensor<256x16xf32>
    %8 = "linalg.matmul"(%7, %6, %arg2) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %9 = "arith.mulf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %10 = "arith.addf"(%arg5, %9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%10) : (f32) -> ()
    }) : (tensor<256x16xf32>, tensor<16x256xf32>, tensor<256x256xf32>) -> tensor<256x256xf32>
    "func.return"(%8) : (tensor<256x256xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map3 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.buffer_layout = #map3, bufferization.writable = false}, {bufferization.buffer_layout = #map3, bufferization.writable = false}, {bufferization.buffer_layout = #map3, bufferization.writable = true}], function_type = (tensor<518x518xf32>, tensor<518x518xf32>, tensor<256x256xf32>) -> tensor<256x256xf32>, sym_name = "fill_extract_matmul_3412"}> ({
  ^bb0(%arg0: tensor<518x518xf32>, %arg1: tensor<518x518xf32>, %arg2: tensor<256x256xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %3 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<256x256xf32>
    %4 = "tensor.extract_slice"(%3) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 256, 16>, static_strides = array<i64: 1, 1>}> : (tensor<256x256xf32>) -> tensor<256x16xf32>
    %5 = "tensor.extract_slice"(%3) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 16, 256>, static_strides = array<i64: 1, 1>}> : (tensor<256x256xf32>) -> tensor<16x256xf32>
    %6 = "linalg.fill"(%1, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      "linalg.yield"(%arg8) : (f32) -> ()
    }) : (f32, tensor<256x16xf32>) -> tensor<256x16xf32>
    %7 = "linalg.fill"(%2, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<16x256xf32>) -> tensor<16x256xf32>
    %8 = "linalg.matmul"(%6, %7, %arg2) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %9 = "arith.mulf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %10 = "arith.addf"(%arg5, %9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%10) : (f32) -> ()
    }) : (tensor<256x16xf32>, tensor<16x256xf32>, tensor<256x256xf32>) -> tensor<256x256xf32>
    "func.return"(%8) : (tensor<256x256xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map3 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.buffer_layout = #map3, bufferization.writable = false}, {bufferization.buffer_layout = #map3, bufferization.writable = false}, {bufferization.buffer_layout = #map3, bufferization.writable = true}], function_type = (tensor<518x518xf32>, tensor<518x518xf32>, tensor<256x256xf32>) -> tensor<256x256xf32>, sym_name = "fill_extract_matmul_3421"}> ({
  ^bb0(%arg0: tensor<518x518xf32>, %arg1: tensor<518x518xf32>, %arg2: tensor<256x256xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %3 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<256x256xf32>
    %4 = "tensor.extract_slice"(%3) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 256, 16>, static_strides = array<i64: 1, 1>}> : (tensor<256x256xf32>) -> tensor<256x16xf32>
    %5 = "tensor.extract_slice"(%3) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 16, 256>, static_strides = array<i64: 1, 1>}> : (tensor<256x256xf32>) -> tensor<16x256xf32>
    %6 = "linalg.fill"(%2, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      "linalg.yield"(%arg8) : (f32) -> ()
    }) : (f32, tensor<16x256xf32>) -> tensor<16x256xf32>
    %7 = "linalg.fill"(%1, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<256x16xf32>) -> tensor<256x16xf32>
    %8 = "linalg.matmul"(%7, %6, %arg2) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %9 = "arith.mulf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %10 = "arith.addf"(%arg5, %9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%10) : (f32) -> ()
    }) : (tensor<256x16xf32>, tensor<16x256xf32>, tensor<256x256xf32>) -> tensor<256x256xf32>
    "func.return"(%8) : (tensor<256x256xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map3 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.buffer_layout = #map3, bufferization.writable = false}, {bufferization.buffer_layout = #map3, bufferization.writable = false}, {bufferization.buffer_layout = #map3, bufferization.writable = true}], function_type = (tensor<518x518xf32>, tensor<518x518xf32>, tensor<256x256xf32>) -> tensor<256x256xf32>, sym_name = "fill_extract_matmul_4123"}> ({
  ^bb0(%arg0: tensor<518x518xf32>, %arg1: tensor<518x518xf32>, %arg2: tensor<256x256xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %3 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<256x256xf32>
    %4 = "tensor.extract_slice"(%3) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 16, 256>, static_strides = array<i64: 1, 1>}> : (tensor<256x256xf32>) -> tensor<16x256xf32>
    %5 = "linalg.fill"(%1, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      "linalg.yield"(%arg8) : (f32) -> ()
    }) : (f32, tensor<256x256xf32>) -> tensor<256x256xf32>
    %6 = "linalg.fill"(%2, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<16x256xf32>) -> tensor<16x256xf32>
    %7 = "tensor.extract_slice"(%5) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 256, 16>, static_strides = array<i64: 1, 1>}> : (tensor<256x256xf32>) -> tensor<256x16xf32>
    %8 = "linalg.matmul"(%7, %6, %arg2) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %9 = "arith.mulf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %10 = "arith.addf"(%arg5, %9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%10) : (f32) -> ()
    }) : (tensor<256x16xf32>, tensor<16x256xf32>, tensor<256x256xf32>) -> tensor<256x256xf32>
    "func.return"(%8) : (tensor<256x256xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map3 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.buffer_layout = #map3, bufferization.writable = false}, {bufferization.buffer_layout = #map3, bufferization.writable = false}, {bufferization.buffer_layout = #map3, bufferization.writable = true}], function_type = (tensor<518x518xf32>, tensor<518x518xf32>, tensor<256x256xf32>) -> tensor<256x256xf32>, sym_name = "fill_extract_matmul_4132"}> ({
  ^bb0(%arg0: tensor<518x518xf32>, %arg1: tensor<518x518xf32>, %arg2: tensor<256x256xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %3 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<256x256xf32>
    %4 = "tensor.extract_slice"(%3) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 16, 256>, static_strides = array<i64: 1, 1>}> : (tensor<256x256xf32>) -> tensor<16x256xf32>
    %5 = "linalg.fill"(%1, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      "linalg.yield"(%arg8) : (f32) -> ()
    }) : (f32, tensor<256x256xf32>) -> tensor<256x256xf32>
    %6 = "tensor.extract_slice"(%5) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 256, 16>, static_strides = array<i64: 1, 1>}> : (tensor<256x256xf32>) -> tensor<256x16xf32>
    %7 = "linalg.fill"(%2, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<16x256xf32>) -> tensor<16x256xf32>
    %8 = "linalg.matmul"(%6, %7, %arg2) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %9 = "arith.mulf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %10 = "arith.addf"(%arg5, %9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%10) : (f32) -> ()
    }) : (tensor<256x16xf32>, tensor<16x256xf32>, tensor<256x256xf32>) -> tensor<256x256xf32>
    "func.return"(%8) : (tensor<256x256xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map3 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.buffer_layout = #map3, bufferization.writable = false}, {bufferization.buffer_layout = #map3, bufferization.writable = false}, {bufferization.buffer_layout = #map3, bufferization.writable = true}], function_type = (tensor<518x518xf32>, tensor<518x518xf32>, tensor<256x256xf32>) -> tensor<256x256xf32>, sym_name = "fill_extract_matmul_4213"}> ({
  ^bb0(%arg0: tensor<518x518xf32>, %arg1: tensor<518x518xf32>, %arg2: tensor<256x256xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %3 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<256x256xf32>
    %4 = "tensor.extract_slice"(%3) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 16, 256>, static_strides = array<i64: 1, 1>}> : (tensor<256x256xf32>) -> tensor<16x256xf32>
    %5 = "linalg.fill"(%2, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      "linalg.yield"(%arg8) : (f32) -> ()
    }) : (f32, tensor<16x256xf32>) -> tensor<16x256xf32>
    %6 = "linalg.fill"(%1, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<256x256xf32>) -> tensor<256x256xf32>
    %7 = "tensor.extract_slice"(%6) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 256, 16>, static_strides = array<i64: 1, 1>}> : (tensor<256x256xf32>) -> tensor<256x16xf32>
    %8 = "linalg.matmul"(%7, %5, %arg2) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %9 = "arith.mulf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %10 = "arith.addf"(%arg5, %9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%10) : (f32) -> ()
    }) : (tensor<256x16xf32>, tensor<16x256xf32>, tensor<256x256xf32>) -> tensor<256x256xf32>
    "func.return"(%8) : (tensor<256x256xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map3 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.buffer_layout = #map3, bufferization.writable = false}, {bufferization.buffer_layout = #map3, bufferization.writable = false}, {bufferization.buffer_layout = #map3, bufferization.writable = true}], function_type = (tensor<518x518xf32>, tensor<518x518xf32>, tensor<256x256xf32>) -> tensor<256x256xf32>, sym_name = "fill_extract_matmul_4231"}> ({
  ^bb0(%arg0: tensor<518x518xf32>, %arg1: tensor<518x518xf32>, %arg2: tensor<256x256xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %3 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<256x256xf32>
    %4 = "tensor.extract_slice"(%3) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 16, 256>, static_strides = array<i64: 1, 1>}> : (tensor<256x256xf32>) -> tensor<16x256xf32>
    %5 = "linalg.fill"(%2, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      "linalg.yield"(%arg8) : (f32) -> ()
    }) : (f32, tensor<16x256xf32>) -> tensor<16x256xf32>
    %6 = "tensor.extract_slice"(%3) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 256, 16>, static_strides = array<i64: 1, 1>}> : (tensor<256x256xf32>) -> tensor<256x16xf32>
    %7 = "linalg.fill"(%1, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<256x16xf32>) -> tensor<256x16xf32>
    %8 = "linalg.matmul"(%7, %5, %arg2) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %9 = "arith.mulf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %10 = "arith.addf"(%arg5, %9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%10) : (f32) -> ()
    }) : (tensor<256x16xf32>, tensor<16x256xf32>, tensor<256x256xf32>) -> tensor<256x256xf32>
    "func.return"(%8) : (tensor<256x256xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map3 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.buffer_layout = #map3, bufferization.writable = false}, {bufferization.buffer_layout = #map3, bufferization.writable = false}, {bufferization.buffer_layout = #map3, bufferization.writable = true}], function_type = (tensor<518x518xf32>, tensor<518x518xf32>, tensor<256x256xf32>) -> tensor<256x256xf32>, sym_name = "fill_extract_matmul_4312"}> ({
  ^bb0(%arg0: tensor<518x518xf32>, %arg1: tensor<518x518xf32>, %arg2: tensor<256x256xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %3 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<256x256xf32>
    %4 = "tensor.extract_slice"(%3) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 16, 256>, static_strides = array<i64: 1, 1>}> : (tensor<256x256xf32>) -> tensor<16x256xf32>
    %5 = "tensor.extract_slice"(%3) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 256, 16>, static_strides = array<i64: 1, 1>}> : (tensor<256x256xf32>) -> tensor<256x16xf32>
    %6 = "linalg.fill"(%1, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      "linalg.yield"(%arg8) : (f32) -> ()
    }) : (f32, tensor<256x16xf32>) -> tensor<256x16xf32>
    %7 = "linalg.fill"(%2, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<16x256xf32>) -> tensor<16x256xf32>
    %8 = "linalg.matmul"(%6, %7, %arg2) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %9 = "arith.mulf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %10 = "arith.addf"(%arg5, %9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%10) : (f32) -> ()
    }) : (tensor<256x16xf32>, tensor<16x256xf32>, tensor<256x256xf32>) -> tensor<256x256xf32>
    "func.return"(%8) : (tensor<256x256xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map3 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.buffer_layout = #map3, bufferization.writable = false}, {bufferization.buffer_layout = #map3, bufferization.writable = false}, {bufferization.buffer_layout = #map3, bufferization.writable = true}], function_type = (tensor<518x518xf32>, tensor<518x518xf32>, tensor<256x256xf32>) -> tensor<256x256xf32>, sym_name = "fill_extract_matmul_4321"}> ({
  ^bb0(%arg0: tensor<518x518xf32>, %arg1: tensor<518x518xf32>, %arg2: tensor<256x256xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %3 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<256x256xf32>
    %4 = "tensor.extract_slice"(%3) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 16, 256>, static_strides = array<i64: 1, 1>}> : (tensor<256x256xf32>) -> tensor<16x256xf32>
    %5 = "tensor.extract_slice"(%3) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 256, 16>, static_strides = array<i64: 1, 1>}> : (tensor<256x256xf32>) -> tensor<256x16xf32>
    %6 = "linalg.fill"(%2, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      "linalg.yield"(%arg8) : (f32) -> ()
    }) : (f32, tensor<16x256xf32>) -> tensor<16x256xf32>
    %7 = "linalg.fill"(%1, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<256x16xf32>) -> tensor<256x16xf32>
    %8 = "linalg.matmul"(%7, %6, %arg2) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %9 = "arith.mulf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %10 = "arith.addf"(%arg5, %9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%10) : (f32) -> ()
    }) : (tensor<256x16xf32>, tensor<16x256xf32>, tensor<256x256xf32>) -> tensor<256x256xf32>
    "func.return"(%8) : (tensor<256x256xf32>) -> ()
  }) : () -> ()
}) : () -> ()

