#map = affine_map<(d0, d1) -> (d1)>
#map1 = affine_map<()[s0] -> (s0 + 1)>
#map2 = affine_map<()[s0] -> (s0 + 2)>
#map3 = affine_map<()[s0] -> (s0 + 3)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>, index, index) -> vector<4x9xf32>, sym_name = "transfer_read_2d"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = -4.200000e+01 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = dense<-4.200000e+01> : vector<4x9xf32>}> : () -> vector<4x9xf32>
    %2 = "vector.transfer_read"(%arg0, %arg1, %arg2, %0) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<?x?xf32>, index, index, f32) -> vector<9xf32>
    %3 = "vector.insert"(%2, %1) <{static_position = array<i64: 0>}> : (vector<9xf32>, vector<4x9xf32>) -> vector<4x9xf32>
    %4 = "affine.apply"(%arg1) <{map = #map1}> : (index) -> index
    %5 = "vector.transfer_read"(%arg0, %4, %arg2, %0) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<?x?xf32>, index, index, f32) -> vector<9xf32>
    %6 = "vector.insert"(%5, %3) <{static_position = array<i64: 1>}> : (vector<9xf32>, vector<4x9xf32>) -> vector<4x9xf32>
    %7 = "affine.apply"(%arg1) <{map = #map2}> : (index) -> index
    %8 = "vector.transfer_read"(%arg0, %7, %arg2, %0) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<?x?xf32>, index, index, f32) -> vector<9xf32>
    %9 = "vector.insert"(%8, %6) <{static_position = array<i64: 2>}> : (vector<9xf32>, vector<4x9xf32>) -> vector<4x9xf32>
    %10 = "affine.apply"(%arg1) <{map = #map3}> : (index) -> index
    %11 = "vector.transfer_read"(%arg0, %10, %arg2, %0) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<?x?xf32>, index, index, f32) -> vector<9xf32>
    %12 = "vector.insert"(%11, %9) <{static_position = array<i64: 3>}> : (vector<9xf32>, vector<4x9xf32>) -> vector<4x9xf32>
    "func.return"(%12) : (vector<4x9xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d1)>
#map1 = affine_map<()[s0] -> (s0 + 1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>, vector<2x3xf32>, index, index) -> tensor<?x?xf32>, sym_name = "transfer_write_2d"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: vector<2x3xf32>, %arg2: index, %arg3: index):
    %0 = "vector.extract"(%arg1) <{static_position = array<i64: 0>}> : (vector<2x3xf32>) -> vector<3xf32>
    %1 = "vector.transfer_write"(%0, %arg0, %arg2, %arg3) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<3xf32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
    %2 = "affine.apply"(%arg2) <{map = #map1}> : (index) -> index
    %3 = "vector.extract"(%arg1) <{static_position = array<i64: 1>}> : (vector<2x3xf32>) -> vector<3xf32>
    %4 = "vector.transfer_write"(%3, %1, %2, %arg3) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<3xf32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
    "func.return"(%4) : (tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

