#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>, index, index) -> vector<4x9xf32>, sym_name = "transfer_read_2d"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = -4.200000e+01 : f32}> : () -> f32
    %1 = "vector.transfer_read"(%arg0, %arg1, %arg2, %0) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<?x?xf32>, index, index, f32) -> vector<4x9xf32>
    "func.return"(%1) : (vector<4x9xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>, vector<2x3xf32>, index, index) -> tensor<?x?xf32>, sym_name = "transfer_write_2d"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: vector<2x3xf32>, %arg2: index, %arg3: index):
    %0 = "vector.transfer_write"(%arg1, %arg0, %arg2, %arg3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<2x3xf32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
    "func.return"(%0) : (tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x[4]xf32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>, sym_name = "scalable_transpose_store"}> ({
  ^bb0(%arg0: vector<4x[4]xf32>, %arg1: tensor<?x?xf32>, %arg2: index, %arg3: index):
    %0 = "vector.transpose"(%arg0) <{permutation = array<i64: 1, 0>}> : (vector<4x[4]xf32>) -> vector<[4]x4xf32>
    %1 = "vector.transfer_write"(%0, %arg1, %arg2, %arg3) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<[4]x4xf32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
    "func.return"(%1) : (tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

