#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4xf32>) -> tensor<4xf32>, sym_name = "basic"}> ({
  ^bb0(%arg0: tensor<4xf32>):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<4xf32>) -> memref<4xf32>
    %1 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4xf32>
    "linalg.generic"(%0, %1) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      %3 = "math.exp"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%3) : (f32) -> ()
    }) : (memref<4xf32>, memref<4xf32>) -> ()
    %2 = "bufferization.to_tensor"(%1) : (memref<4xf32>) -> tensor<4xf32>
    "func.return"(%2) : (tensor<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>, index) -> tensor<?xf32>, sym_name = "empty_tensor"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: index):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<?xf32>) -> memref<?xf32>
    %1 = "memref.alloc"(%arg1) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    "linalg.generic"(%0, %1) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      %3 = "math.exp"(%arg2) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%3) : (f32) -> ()
    }) : (memref<?xf32>, memref<?xf32>) -> ()
    %2 = "bufferization.to_tensor"(%1) : (memref<?xf32>) -> tensor<?xf32>
    "func.return"(%2) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4xf32>) -> (tensor<4xf32>, tensor<4xf32>), sym_name = "multiple_results"}> ({
  ^bb0(%arg0: tensor<4xf32>):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<4xf32>) -> memref<4xf32>
    %1 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4xf32>
    %2 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4xf32>
    "linalg.generic"(%0, %1, %2) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 2>}> ({
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %5 = "math.exp"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%5, %5) : (f32, f32) -> ()
    }) : (memref<4xf32>, memref<4xf32>, memref<4xf32>) -> ()
    %3 = "bufferization.to_tensor"(%2) : (memref<4xf32>) -> tensor<4xf32>
    %4 = "bufferization.to_tensor"(%1) : (memref<4xf32>) -> tensor<4xf32>
    "func.return"(%4, %3) : (tensor<4xf32>, tensor<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>) -> (tensor<?x?xf32>, tensor<?x?xf32>), sym_name = "dynamic_results"}> ({
  ^bb0(%arg0: tensor<?x?xf32>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "bufferization.to_buffer"(%arg0) : (tensor<?x?xf32>) -> memref<?x?xf32>
    %3 = "tensor.dim"(%arg0, %1) : (tensor<?x?xf32>, index) -> index
    %4 = "tensor.dim"(%arg0, %0) : (tensor<?x?xf32>, index) -> index
    %5 = "memref.alloc"(%3, %4) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 2, 0>}> : (index, index) -> memref<?x?xf32>
    %6 = "memref.alloc"(%3, %4) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 2, 0>}> : (index, index) -> memref<?x?xf32>
    "linalg.generic"(%2, %5, %6) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 2>}> ({
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %9 = "math.exp"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%9, %9) : (f32, f32) -> ()
    }) : (memref<?x?xf32>, memref<?x?xf32>, memref<?x?xf32>) -> ()
    %7 = "bufferization.to_tensor"(%6) : (memref<?x?xf32>) -> tensor<?x?xf32>
    %8 = "bufferization.to_tensor"(%5) : (memref<?x?xf32>) -> tensor<?x?xf32>
    "func.return"(%8, %7) : (tensor<?x?xf32>, tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d1, d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x3x4xvector<3x4xi4>>, tensor<3x2xf32>) -> tensor<3x2xf32>, sym_name = "generic_with_init_tensor"}> ({
  ^bb0(%arg0: tensor<2x3x4xvector<3x4xi4>>, %arg1: tensor<3x2xf32>):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<2x3x4xvector<3x4xi4>>) -> memref<2x3x4xvector<3x4xi4>>
    %1 = "bufferization.to_buffer"(%arg1) : (tensor<3x2xf32>) -> memref<3x2xf32>
    %2 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<3x2xf32>
    "memref.copy"(%1, %2) : (memref<3x2xf32>, memref<3x2xf32>) -> ()
    "linalg.generic"(%0, %2) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<reduction>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: vector<3x4xi4>, %arg3: f32):
      "linalg.yield"(%arg3) : (f32) -> ()
    }) : (memref<2x3x4xvector<3x4xi4>>, memref<3x2xf32>) -> ()
    %3 = "bufferization.to_tensor"(%2) : (memref<3x2xf32>) -> tensor<3x2xf32>
    "func.return"(%3) : (tensor<3x2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>) -> tensor<?xf32>, sym_name = "bufferize_fill"}> ({
  ^bb0(%arg0: tensor<?xf32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "tensor.dim"(%arg0, %1) : (tensor<?xf32>, index) -> index
    %3 = "memref.alloc"(%2) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    "linalg.fill"(%0, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      "linalg.yield"(%arg1) : (f32) -> ()
    }) : (f32, memref<?xf32>) -> ()
    %4 = "bufferization.to_tensor"(%3) : (memref<?xf32>) -> tensor<?xf32>
    "func.return"(%4) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0) -> ()>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4xf32>, tensor<f32>) -> tensor<f32>, sym_name = "bufferize_dot"}> ({
  ^bb0(%arg0: tensor<4xf32>, %arg1: tensor<f32>):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<4xf32>) -> memref<4xf32>
    %1 = "bufferization.to_buffer"(%arg1) : (tensor<f32>) -> memref<f32>
    %2 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f32>
    "memref.copy"(%1, %2) : (memref<f32>, memref<f32>) -> ()
    "linalg.dot"(%0, %0, %2) <{operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %4 = "arith.mulf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %5 = "arith.addf"(%arg4, %4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%5) : (f32) -> ()
    }) {linalg.memoized_indexing_maps = [#map, #map, #map1]} : (memref<4xf32>, memref<4xf32>, memref<f32>) -> ()
    %3 = "bufferization.to_tensor"(%2) : (memref<f32>) -> tensor<f32>
    "func.return"(%3) : (tensor<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x16x32xf32>, tensor<2x16x32xf32>) -> tensor<2x16x32xf32>, sym_name = "bufferize_softmax"}> ({
  ^bb0(%arg0: tensor<2x16x32xf32>, %arg1: tensor<2x16x32xf32>):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<2x16x32xf32>) -> memref<2x16x32xf32>
    %1 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2x16x32xf32>
    "linalg.softmax"(%0, %1) <{dimension = 2 : i64}> : (memref<2x16x32xf32>, memref<2x16x32xf32>) -> ()
    %2 = "bufferization.to_tensor"(%1) : (memref<2x16x32xf32>) -> tensor<2x16x32xf32>
    "func.return"(%2) : (tensor<2x16x32xf32>) -> ()
  }) : () -> ()
}) : () -> ()

