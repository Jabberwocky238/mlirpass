"builtin.module"() ({
  "func.func"() <{function_type = (memref<16x16xf32>, vector<8xf32>) -> vector<8xf32>, sym_name = "sink_vector_loads"}> ({
  ^bb0(%arg1: memref<16x16xf32>, %arg2: vector<8xf32>):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 8 : index}> : () -> index
    %3 = "vector.load"(%arg1, %1, %1) : (memref<16x16xf32>, index, index) -> vector<8xf32>
    %4 = "vector.load"(%arg1, %1, %2) : (memref<16x16xf32>, index, index) -> vector<8xf32>
    %5 = "vector.load"(%arg1, %2, %1) : (memref<16x16xf32>, index, index) -> vector<8xf32>
    %6 = "vector.load"(%arg1, %2, %2) : (memref<16x16xf32>, index, index) -> vector<8xf32>
    %7 = "vector.fma"(%3, %4, %arg2) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %8 = "vector.fma"(%5, %6, %7) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    "func.return"(%8) : (vector<8xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86vector.sink_vector_producer_ops"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16x16xf32>, vector<8xf32>) -> vector<8xf32>, sym_name = "sink_vector_transfer_reads"}> ({
  ^bb0(%arg1: memref<16x16xf32>, %arg2: vector<8xf32>):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 8 : index}> : () -> index
    %3 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %4 = "vector.transfer_read"(%arg1, %1, %1, %3) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<16x16xf32>, index, index, f32) -> vector<8xf32>
    %5 = "vector.transfer_read"(%arg1, %1, %2, %3) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<16x16xf32>, index, index, f32) -> vector<8xf32>
    %6 = "vector.transfer_read"(%arg1, %2, %1, %3) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<16x16xf32>, index, index, f32) -> vector<8xf32>
    %7 = "vector.transfer_read"(%arg1, %2, %2, %3) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<16x16xf32>, index, index, f32) -> vector<8xf32>
    %8 = "vector.fma"(%4, %5, %arg2) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %9 = "vector.fma"(%6, %7, %8) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    "func.return"(%9) : (vector<8xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86vector.sink_vector_producer_ops"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<16x16xf32>, vector<8xf32>) -> vector<8xf32>, sym_name = "sink_vector_transfer_reads_tensor"}> ({
  ^bb0(%arg1: tensor<16x16xf32>, %arg2: vector<8xf32>):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 8 : index}> : () -> index
    %3 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %4 = "vector.transfer_read"(%arg1, %1, %1, %3) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<16x16xf32>, index, index, f32) -> vector<8xf32>
    %5 = "vector.transfer_read"(%arg1, %1, %2, %3) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<16x16xf32>, index, index, f32) -> vector<8xf32>
    %6 = "vector.transfer_read"(%arg1, %2, %1, %3) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<16x16xf32>, index, index, f32) -> vector<8xf32>
    %7 = "vector.transfer_read"(%arg1, %2, %2, %3) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<16x16xf32>, index, index, f32) -> vector<8xf32>
    %8 = "vector.fma"(%4, %5, %arg2) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %9 = "vector.fma"(%6, %7, %8) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    "func.return"(%9) : (vector<8xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86vector.sink_vector_producer_ops"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
#map1 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d2, d4, d1)>
#map2 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d4, d3, d1)>
#map3 = affine_map<(d0, d1, d2, d3, d4) -> (d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4x64x32x2xbf16>, tensor<4x32x64x2xbf16>, vector<1x16xf32>) -> vector<1x16xf32>, sym_name = "sink_vector_transfer_reads_bf16"}> ({
  ^bb0(%arg1: tensor<4x64x32x2xbf16>, %arg2: tensor<4x32x64x2xbf16>, %arg3: vector<1x16xf32>):
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> bf16
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "arith.constant"() <{value = 1 : index}> : () -> index
    %4 = "arith.constant"() <{value = 16 : index}> : () -> index
    %5 = "tensor.extract_slice"(%arg1, %2, %2, %2) <{operandSegmentSizes = array<i32: 1, 3, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808, 0>, static_sizes = array<i64: 1, 4, 1, 2>, static_strides = array<i64: 1, 1, 1, 1>}> : (tensor<4x64x32x2xbf16>, index, index, index) -> tensor<1x4x1x2xbf16>
    %6 = "tensor.extract_slice"(%arg2, %2, %2, %2) <{operandSegmentSizes = array<i32: 1, 3, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808, 0>, static_sizes = array<i64: 1, 1, 32, 2>, static_strides = array<i64: 1, 1, 1, 1>}> : (tensor<4x32x64x2xbf16>, index, index, index) -> tensor<1x1x32x2xbf16>
    %7 = "vector.transfer_read"(%5, %2, %2, %2, %2, %1) <{in_bounds = [true, true, true, true], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (tensor<1x4x1x2xbf16>, index, index, index, index, bf16) -> vector<1x1x1x2xbf16>
    %8 = "vector.transfer_read"(%5, %2, %3, %2, %2, %1) <{in_bounds = [true, true, true, true], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (tensor<1x4x1x2xbf16>, index, index, index, index, bf16) -> vector<1x1x1x2xbf16>
    %9 = "vector.transfer_read"(%6, %2, %2, %2, %2, %1) <{in_bounds = [true, true, true, true], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (tensor<1x1x32x2xbf16>, index, index, index, index, bf16) -> vector<1x1x16x2xbf16>
    %10 = "vector.transfer_read"(%6, %2, %2, %4, %2, %1) <{in_bounds = [true, true, true, true], operandSegmentSizes = array<i32: 1, 4, 1, 0>, permutation_map = #map}> : (tensor<1x1x32x2xbf16>, index, index, index, index, bf16) -> vector<1x1x16x2xbf16>
    %11 = "vector.contract"(%7, %9, %arg3) <{indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 1, 2, 1, 16, 1>} : (vector<1x1x1x2xbf16>, vector<1x1x16x2xbf16>, vector<1x16xf32>) -> vector<1x16xf32>
    %12 = "vector.contract"(%7, %10, %11) <{indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 1, 2, 1, 16, 1>} : (vector<1x1x1x2xbf16>, vector<1x1x16x2xbf16>, vector<1x16xf32>) -> vector<1x16xf32>
    %13 = "vector.contract"(%8, %9, %12) <{indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 1, 2, 1, 16, 1>} : (vector<1x1x1x2xbf16>, vector<1x1x16x2xbf16>, vector<1x16xf32>) -> vector<1x16xf32>
    %14 = "vector.contract"(%8, %10, %13) <{indexing_maps = [#map1, #map2, #map3], iterator_types = [#vector.iterator_type<reduction>, #vector.iterator_type<reduction>, #vector.iterator_type<parallel>, #vector.iterator_type<parallel>, #vector.iterator_type<reduction>], kind = #vector.kind<add>}> {unroll_shape = array<i64: 1, 2, 1, 16, 1>} : (vector<1x1x1x2xbf16>, vector<1x1x16x2xbf16>, vector<1x16xf32>) -> vector<1x16xf32>
    "func.return"(%14) : (vector<1x16xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86vector.sink_vector_producer_ops"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16x16xf32>, vector<8xf32>) -> vector<8xf32>, sym_name = "negative_no_infinite_looping"}> ({
  ^bb0(%arg1: memref<16x16xf32>, %arg2: vector<8xf32>):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 8 : index}> : () -> index
    %3 = "vector.load"(%arg1, %1, %1) : (memref<16x16xf32>, index, index) -> vector<8xf32>
    %4 = "vector.load"(%arg1, %1, %2) : (memref<16x16xf32>, index, index) -> vector<8xf32>
    %5 = "vector.fma"(%3, %4, %arg2) : (vector<8xf32>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    "func.return"(%5) : (vector<8xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86vector.sink_vector_producer_ops"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<8x16xf32>, i1) -> vector<8xf32>, sym_name = "negative_no_sink_outside_block"}> ({
  ^bb0(%arg1: memref<8x16xf32>, %arg2: i1):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 8 : index}> : () -> index
    %3 = "vector.load"(%arg1, %1, %1) : (memref<8x16xf32>, index, index) -> vector<8xf32>
    %4 = "vector.load"(%arg1, %1, %2) : (memref<8x16xf32>, index, index) -> vector<8xf32>
    %5 = "scf.if"(%arg2) ({
      "scf.yield"(%3) : (vector<8xf32>) -> ()
    }, {
      "scf.yield"(%4) : (vector<8xf32>) -> ()
    }) : (i1) -> vector<8xf32>
    "func.return"(%5) : (vector<8xf32>) -> ()
  }) : () -> ()
  "builtin.module"() ({
    "transform.named_sequence"() <{arg_attrs = [{transform.readonly}], function_type = (!transform.any_op) -> (), sym_name = "__transform_main"}> ({
    ^bb0(%arg0: !transform.any_op):
      %0 = "transform.structured.match"(%arg0) <{ops = ["func.func"]}> : (!transform.any_op) -> !transform.any_op
      "transform.apply_patterns"(%0) <{max_iterations = -1 : i64, max_num_rewrites = -1 : i64}> ({
        "transform.apply_patterns.x86vector.sink_vector_producer_ops"() : () -> ()
      }) : (!transform.any_op) -> ()
      "transform.yield"() : () -> ()
    }) : () -> ()
  }) {transform.with_named_sequence} : () -> ()
}) : () -> ()

