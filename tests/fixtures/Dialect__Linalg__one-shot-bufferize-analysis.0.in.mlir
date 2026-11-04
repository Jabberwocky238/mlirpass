#map = affine_map<(d0, d1) -> (d1)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x6xf32>) -> tensor<5x6xf32>, sym_name = "not_elementwise"}> ({
  ^bb0(%arg0: tensor<5x6xf32>):
    %0 = "arith.constant"() <{value = 5.000000e+00 : f32}> : () -> f32
    %1 = "tensor.extract_slice"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 1, 6>, static_strides = array<i64: 1, 1>}> : (tensor<5x6xf32>) -> tensor<6xf32>
    %2 = "linalg.generic"(%1, %arg0) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      %3 = "arith.addf"(%arg1, %arg2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%3) : (f32) -> ()
    }) : (tensor<6xf32>, tensor<5x6xf32>) -> tensor<5x6xf32>
    "func.return"(%2) : (tensor<5x6xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d3, d2)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d1, d2)>
#map3 = affine_map<(d0, d1) -> (d0, d1)>
#map4 = affine_map<(d0, d1) -> (d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<8x32x32x32xf32>, tensor<32x32x32xf32>) -> tensor<8x32x32x32xf32>, sym_name = "elementwise_no_conflict_4"}> ({
  ^bb0(%arg0: tensor<8x32x32x32xf32>, %arg1: tensor<32x32x32xf32>):
    %0 = "arith.constant"() <{value = dense<3.000000e-02> : tensor<32x32x32xf32>}> : () -> tensor<32x32x32xf32>
    %1 = "arith.constant"() <{value = dense<6.000000e-01> : tensor<32xf32>}> : () -> tensor<32xf32>
    %2 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %3 = "scf.forall"(%arg0) <{operandSegmentSizes = array<i32: 0, 0, 0, 1>, staticLowerBound = array<i64: 0, 0>, staticStep = array<i64: 1, 1>, staticUpperBound = array<i64: 8, 32>}> ({
    ^bb0(%arg2: index, %arg3: index, %arg4: tensor<8x32x32x32xf32>):
      %4 = "tensor.extract_slice"(%arg4, %arg2, %arg3) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, 0, 0>, static_sizes = array<i64: 1, 1, 32, 32>, static_strides = array<i64: 1, 1, 1, 1>}> : (tensor<8x32x32x32xf32>, index, index) -> tensor<32x32xf32>
      %5 = "linalg.fill"(%2, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg13: f32, %arg14: f32):
        "linalg.yield"(%arg13) : (f32) -> ()
      }) : (f32, tensor<32x32xf32>) -> tensor<32x32xf32>
      %6 = "linalg.batch_reduce_matmul"(%arg1, %0, %5) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg10: f32, %arg11: f32, %arg12: f32):
        %11 = "arith.mulf"(%arg10, %arg11) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %12 = "arith.addf"(%arg12, %11) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%12) : (f32) -> ()
      }) : (tensor<32x32x32xf32>, tensor<32x32x32xf32>, tensor<32x32xf32>) -> tensor<32x32xf32>
      %7 = "linalg.generic"(%6, %1, %4) <{indexing_maps = [#map3, #map4, #map3], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg7: f32, %arg8: f32, %arg9: f32):
        %10 = "arith.addf"(%arg7, %arg8) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%10) : (f32) -> ()
      }) : (tensor<32x32xf32>, tensor<32xf32>, tensor<32x32xf32>) -> tensor<32x32xf32>
      %8 = "linalg.generic"(%7, %4) <{indexing_maps = [#map3, #map3], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg5: f32, %arg6: f32):
        %9 = "arith.maximumf"(%arg5, %2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%9) : (f32) -> ()
      }) : (tensor<32x32xf32>, tensor<32x32xf32>) -> tensor<32x32xf32>
      "scf.forall.in_parallel"() ({
        "tensor.parallel_insert_slice"(%8, %arg4, %arg2, %arg3) <{operandSegmentSizes = array<i32: 1, 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, 0, 0>, static_sizes = array<i64: 1, 1, 32, 32>, static_strides = array<i64: 1, 1, 1, 1>}> : (tensor<32x32xf32>, tensor<8x32x32x32xf32>, index, index) -> ()
      }) : () -> ()
    }) : (tensor<8x32x32x32xf32>) -> tensor<8x32x32x32xf32>
    "func.return"(%3) : (tensor<8x32x32x32xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<32x1xf32>) -> (), sym_name = "f", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (i32, tensor<32x1xf32>, tensor<32x1xf32>) -> (), sym_name = "elementwise_access_regression"}> ({
  ^bb0(%arg0: i32, %arg1: tensor<32x1xf32>, %arg2: tensor<32x1xf32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %3 = "tensor.empty"() : () -> tensor<32x1xf32>
    %4 = "linalg.fill"(%0, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg10: f32, %arg11: f32):
      "linalg.yield"(%arg10) : (f32) -> ()
    }) : (f32, tensor<32x1xf32>) -> tensor<32x1xf32>
    "scf.for"(%1, %arg0, %2) ({
    ^bb0(%arg3: i32):
      %5 = "linalg.map"(%4, %arg1, %3) ({
      ^bb0(%arg7: f32, %arg8: f32, %arg9: f32):
        %9 = "arith.subf"(%arg7, %arg8) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%9) : (f32) -> ()
      }) : (tensor<32x1xf32>, tensor<32x1xf32>, tensor<32x1xf32>) -> tensor<32x1xf32>
      %6 = "tensor.empty"() : () -> tensor<32x1xf32>
      %7 = "linalg.map"(%5, %arg2, %6) ({
      ^bb0(%arg4: f32, %arg5: f32, %arg6: f32):
        %8 = "arith.subf"(%arg4, %arg5) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%8) : (f32) -> ()
      }) : (tensor<32x1xf32>, tensor<32x1xf32>, tensor<32x1xf32>) -> tensor<32x1xf32>
      "func.call"(%7) <{callee = @f}> : (tensor<32x1xf32>) -> ()
      "scf.yield"() : () -> ()
    }) : (i32, i32, i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

