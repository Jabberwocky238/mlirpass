"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = true}], function_type = (tensor<?xf32>) -> tensor<?xf32>, sym_name = "fill_inplace", sym_visibility = "private"}> ({
  ^bb0(%arg0: tensor<?xf32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "linalg.fill"(%0, %arg0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      "linalg.yield"(%arg1) : (f32) -> ()
    }) : (f32, tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%1) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = false}], function_type = (tensor<?xf32>) -> tensor<?xf32>, sym_name = "not_inplace"}> ({
  ^bb0(%arg0: tensor<?xf32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "linalg.fill"(%0, %arg0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      "linalg.yield"(%arg1) : (f32) -> ()
    }) : (f32, tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%1) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = true}], function_type = (tensor<?x?xf32>) -> tensor<?x?xf32>, sym_name = "not_inplace", sym_visibility = "private"}> ({
  ^bb0(%arg0: tensor<?x?xf32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "linalg.fill"(%0, %arg0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg4: f32, %arg5: f32):
      "linalg.yield"(%arg4) : (f32) -> ()
    }) : (f32, tensor<?x?xf32>) -> tensor<?x?xf32>
    %2 = "linalg.matmul"(%1, %1, %arg0) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %3 = "arith.mulf"(%arg1, %arg2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %4 = "arith.addf"(%arg3, %3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%4) : (f32) -> ()
    }) : (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>
    "func.return"(%2) : (tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = true}], function_type = (tensor<?x?xf32>) -> tensor<?x?xf32>, sym_name = "not_inplace"}> ({
  ^bb0(%arg0: tensor<?x?xf32>):
    %0 = "linalg.matmul"(%arg0, %arg0, %arg0) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %1 = "arith.mulf"(%arg1, %arg2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %2 = "arith.addf"(%arg3, %1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%2) : (f32) -> ()
    }) : (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>
    "func.return"(%0) : (tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = true}, {}], function_type = (tensor<?xf32>, vector<4xf32>) -> tensor<?xf32>, sym_name = "vec_inplace"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: vector<4xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "vector.transfer_write"(%arg1, %arg0, %0) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<4xf32>, tensor<?xf32>, index) -> tensor<?xf32>
    "func.return"(%1) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = true}, {}], function_type = (tensor<?xf32>, vector<4xf32>) -> (tensor<?xf32>, tensor<?xf32>), sym_name = "vec_not_inplace"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: vector<4xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "vector.transfer_write"(%arg1, %arg0, %0) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<4xf32>, tensor<?xf32>, index) -> tensor<?xf32>
    %3 = "vector.transfer_write"(%arg1, %arg0, %1) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<4xf32>, tensor<?xf32>, index) -> tensor<?xf32>
    "func.return"(%2, %3) : (tensor<?xf32>, tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map3 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.buffer_layout = #map3, bufferization.writable = false}, {bufferization.buffer_layout = #map3, bufferization.writable = false}, {bufferization.buffer_layout = #map3, bufferization.writable = true}], function_type = (tensor<128x256xf32>, tensor<256x192xf32>, tensor<128x192xf32>) -> tensor<128x192xf32>, sym_name = "matmul"}> ({
  ^bb0(%arg0: tensor<128x256xf32>, %arg1: tensor<256x192xf32>, %arg2: tensor<128x192xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 256 : index}> : () -> index
    %2 = "arith.constant"() <{value = 32 : index}> : () -> index
    %3 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %4 = "arith.constant"() <{value = 128 : index}> : () -> index
    %5 = "arith.constant"() <{value = 192 : index}> : () -> index
    %6 = "arith.constant"() <{value = 8 : index}> : () -> index
    %7 = "arith.constant"() <{value = 16 : index}> : () -> index
    %8 = "scf.for"(%0, %4, %6, %arg2) ({
    ^bb0(%arg3: index, %arg4: tensor<128x192xf32>):
      %9 = "tensor.extract_slice"(%arg0, %arg3) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808, 0>, static_sizes = array<i64: 8, 256>, static_strides = array<i64: 1, 1>}> : (tensor<128x256xf32>, index) -> tensor<8x256xf32>
      %10 = "scf.for"(%0, %5, %7, %arg4) ({
      ^bb0(%arg5: index, %arg6: tensor<128x192xf32>):
        %11 = "tensor.extract_slice"(%arg1, %arg5) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: 0, -9223372036854775808>, static_sizes = array<i64: 256, 16>, static_strides = array<i64: 1, 1>}> : (tensor<256x192xf32>, index) -> tensor<256x16xf32>
        %12 = "tensor.extract_slice"(%arg2, %arg3, %arg5) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 8, 16>, static_strides = array<i64: 1, 1>}> : (tensor<128x192xf32>, index, index) -> tensor<8x16xf32>
        %13 = "linalg.fill"(%3, %12) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg12: f32, %arg13: f32):
          "linalg.yield"(%arg12) : (f32) -> ()
        }) : (f32, tensor<8x16xf32>) -> tensor<8x16xf32>
        %14 = "scf.for"(%0, %1, %2, %13) ({
        ^bb0(%arg7: index, %arg8: tensor<8x16xf32>):
          %16 = "tensor.extract_slice"(%9, %arg7) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: 0, -9223372036854775808>, static_sizes = array<i64: 8, 32>, static_strides = array<i64: 1, 1>}> : (tensor<8x256xf32>, index) -> tensor<8x32xf32>
          %17 = "tensor.extract_slice"(%11, %arg7) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808, 0>, static_sizes = array<i64: 32, 16>, static_strides = array<i64: 1, 1>}> : (tensor<256x16xf32>, index) -> tensor<32x16xf32>
          %18 = "linalg.matmul"(%16, %17, %arg8) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
          ^bb0(%arg9: f32, %arg10: f32, %arg11: f32):
            %19 = "arith.mulf"(%arg9, %arg10) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
            %20 = "arith.addf"(%arg11, %19) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
            "linalg.yield"(%20) : (f32) -> ()
          }) : (tensor<8x32xf32>, tensor<32x16xf32>, tensor<8x16xf32>) -> tensor<8x16xf32>
          "scf.yield"(%18) : (tensor<8x16xf32>) -> ()
        }) : (index, index, index, tensor<8x16xf32>) -> tensor<8x16xf32>
        %15 = "tensor.insert_slice"(%14, %arg6, %arg3, %arg5) <{operandSegmentSizes = array<i32: 1, 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 8, 16>, static_strides = array<i64: 1, 1>}> : (tensor<8x16xf32>, tensor<128x192xf32>, index, index) -> tensor<128x192xf32>
        "scf.yield"(%15) : (tensor<128x192xf32>) -> ()
      }) : (index, index, index, tensor<128x192xf32>) -> tensor<128x192xf32>
      "scf.yield"(%10) : (tensor<128x192xf32>) -> ()
    }) : (index, index, index, tensor<128x192xf32>) -> tensor<128x192xf32>
    "func.return"(%8) : (tensor<128x192xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = false}, {}], function_type = (tensor<?x?xf32>, index) -> tensor<?x?xf32>, sym_name = "dominance_violation_bug_1"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: index):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "tensor.extract_slice"(%arg0, %arg1, %arg1) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
    %2 = "tensor.extract_slice"(%1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 4, 4>, static_strides = array<i64: 1, 1>}> : (tensor<?x?xf32>) -> tensor<4x4xf32>
    %3 = "linalg.fill"(%0, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (f32, tensor<4x4xf32>) -> tensor<4x4xf32>
    %4 = "tensor.insert_slice"(%3, %1) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 4, 4>, static_strides = array<i64: 1, 1>}> : (tensor<4x4xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>
    %5 = "tensor.insert_slice"(%4, %arg0, %arg1, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (tensor<?x?xf32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
    "func.return"(%5) : (tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = false}, {bufferization.writable = false}, {bufferization.writable = true}], function_type = (tensor<?x?xf32>, tensor<?xi32>, tensor<?x?xf32>) -> tensor<?x?xf32>, sym_name = "gather_like", sym_visibility = "private"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: tensor<?xi32>, %arg2: tensor<?x?xf32>):
    %0 = "linalg.generic"(%arg1, %arg2) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: i32, %arg4: f32):
      %1 = "linalg.index"() <{dim = 1 : i64}> : () -> index
      %2 = "arith.index_cast"(%arg3) : (i32) -> index
      %3 = "tensor.extract"(%arg0, %2, %1) : (tensor<?x?xf32>, index, index) -> f32
      "linalg.yield"(%3) : (f32) -> ()
    }) : (tensor<?xi32>, tensor<?x?xf32>) -> tensor<?x?xf32>
    "func.return"(%0) : (tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d1)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = true}, {bufferization.writable = true}, {bufferization.writable = true}, {}, {}, {}], function_type = (tensor<?x?xf32>, tensor<?xf32>, tensor<?x?xf32>, index, index, f32) -> tensor<?x?xf32>, sym_name = "linalg_op_bufferizes_inplace_with_input"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: tensor<?xf32>, %arg2: tensor<?x?xf32>, %arg3: index, %arg4: index, %arg5: f32):
    %0 = "linalg.generic"(%arg0, %arg1, %arg2) <{indexing_maps = [#map, #map1, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32, %arg8: f32):
      %1 = "arith.addf"(%arg6, %arg7) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%1) : (f32) -> ()
    }) : (tensor<?x?xf32>, tensor<?xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>
    "func.return"(%0) : (tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferization.writable = false}, {}], function_type = (tensor<?xf32>, f32) -> tensor<?xf32>, sym_name = "op_is_reading_but_following_ops_are_not"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: f32):
    %0 = "linalg.generic"(%arg0) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg3: f32):
      %2 = "arith.addf"(%arg1, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%2) : (f32) -> ()
    }) : (tensor<?xf32>) -> tensor<?xf32>
    %1 = "linalg.generic"(%0) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg2: f32):
      "linalg.yield"(%arg1) : (f32) -> ()
    }) : (tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%1) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<64xf32>, tensor<64xf32>, tensor<64xf32>) -> tensor<64xf32>, sym_name = "map_binary"}> ({
  ^bb0(%arg0: tensor<64xf32>, %arg1: tensor<64xf32>, %arg2: tensor<64xf32>):
    %0 = "linalg.map"(%arg0, %arg1, %arg2) ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %1 = "arith.addf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%1) : (f32) -> ()
    }) : (tensor<64xf32>, tensor<64xf32>, tensor<64xf32>) -> tensor<64xf32>
    "func.return"(%0) : (tensor<64xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<16x32x64xf32>, tensor<16x64xf32>) -> tensor<16x64xf32>, sym_name = "reduce"}> ({
  ^bb0(%arg0: tensor<16x32x64xf32>, %arg1: tensor<16x64xf32>):
    %0 = "linalg.reduce"(%arg0, %arg1) <{dimensions = array<i64: 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      %1 = "arith.addf"(%arg3, %arg2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%1) : (f32) -> ()
    }) : (tensor<16x32x64xf32>, tensor<16x64xf32>) -> tensor<16x64xf32>
    "func.return"(%0) : (tensor<16x64xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<16x32x64xf32>, tensor<32x64x16xf32>) -> tensor<32x64x16xf32>, sym_name = "transpose"}> ({
  ^bb0(%arg0: tensor<16x32x64xf32>, %arg1: tensor<32x64x16xf32>):
    %0 = "linalg.transpose"(%arg0, %arg1) <{permutation = array<i64: 1, 2, 0>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (tensor<16x32x64xf32>, tensor<32x64x16xf32>) -> tensor<32x64x16xf32>
    "func.return"(%0) : (tensor<32x64x16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<8x32xf32>, tensor<8x16x32xf32>) -> tensor<8x16x32xf32>, sym_name = "broadcast"}> ({
  ^bb0(%arg0: tensor<8x32xf32>, %arg1: tensor<8x16x32xf32>):
    %0 = "linalg.broadcast"(%arg0, %arg1) <{dimensions = array<i64: 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (tensor<8x32xf32>, tensor<8x16x32xf32>) -> tensor<8x16x32xf32>
    "func.return"(%0) : (tensor<8x16x32xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0 ceildiv 8)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, tensor<8x18x32xf32>) -> tensor<?x1x6x8xf32>, sym_name = "depthwise_conv_1d_nwc_wc"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: tensor<8x18x32xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 32 : index}> : () -> index
    %2 = "arith.constant"() <{value = 8 : index}> : () -> index
    %3 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<4x1x6x8xf32>
    %4 = "tensor.cast"(%3) : (tensor<4x1x6x8xf32>) -> tensor<?x1x6x8xf32>
    %5 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<1x6x8xf32>
    %6 = "scf.for"(%0, %1, %2, %4) ({
    ^bb0(%arg3: index, %arg4: tensor<?x1x6x8xf32>):
      %7 = "affine.apply"(%arg3) <{map = #map}> : (index) -> index
      %8 = "tensor.insert_slice"(%5, %arg4, %7) <{operandSegmentSizes = array<i32: 1, 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808, 0, 0, 0>, static_sizes = array<i64: 1, 1, 6, 8>, static_strides = array<i64: 1, 1, 1, 1>}> : (tensor<1x6x8xf32>, tensor<?x1x6x8xf32>, index) -> tensor<?x1x6x8xf32>
      "scf.yield"(%8) : (tensor<?x1x6x8xf32>) -> ()
    }) : (index, index, index, tensor<?x1x6x8xf32>) -> tensor<?x1x6x8xf32>
    "func.return"(%6) : (tensor<?x1x6x8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32, index) -> (tensor<5xf32>, tensor<5xf32>), sym_name = "do_not_copy_alloc_tensors"}> ({
  ^bb0(%arg0: f32, %arg1: f32, %arg2: index):
    %0 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<5xf32>
    %1 = "tensor.insert"(%arg0, %0, %arg2) : (f32, tensor<5xf32>, index) -> tensor<5xf32>
    %2 = "tensor.insert"(%arg1, %0, %arg2) : (f32, tensor<5xf32>, index) -> tensor<5xf32>
    "func.return"(%1, %2) : (tensor<5xf32>, tensor<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

