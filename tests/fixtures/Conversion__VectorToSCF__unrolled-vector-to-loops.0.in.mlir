#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?x?xf32>) -> vector<2x3x4xf32>, sym_name = "transfer_read_inbounds"}> ({
  ^bb0(%arg0: memref<?x?x?xf32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "vector.transfer_read"(%arg0, %1, %1, %1, %0) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<?x?x?xf32>, index, index, index, f32) -> vector<2x3x4xf32>
    "func.return"(%2) : (vector<2x3x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?x?xf32>) -> vector<2x3x4xf32>, sym_name = "transfer_read_out_of_bounds"}> ({
  ^bb0(%arg0: memref<?x?x?xf32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "vector.transfer_read"(%arg0, %1, %1, %1, %0) <{in_bounds = [false, false, false], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<?x?x?xf32>, index, index, index, f32) -> vector<2x3x4xf32>
    "func.return"(%2) : (vector<2x3x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?x?xf32>, vector<2x3x4xi1>) -> vector<2x3x4xf32>, sym_name = "transfer_read_mask"}> ({
  ^bb0(%arg0: memref<?x?x?xf32>, %arg1: vector<2x3x4xi1>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "vector.transfer_read"(%arg0, %1, %1, %1, %0, %arg1) <{in_bounds = [true, true, true], operandSegmentSizes = array<i32: 1, 3, 1, 1>, permutation_map = #map}> : (memref<?x?x?xf32>, index, index, index, f32, vector<2x3x4xi1>) -> vector<2x3x4xf32>
    "func.return"(%2) : (vector<2x3x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

