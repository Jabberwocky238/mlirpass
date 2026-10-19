#map = affine_map<(d0, d1) -> (d1, d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xf32>, index, index) -> vector<9x4xf32>, sym_name = "transfer_read_2d_mask_transposed"}> ({
  ^bb0(%arg0: memref<?x?xf32>, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = -4.200000e+01 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = dense<[[true, false, true, false, true, true, true, false, true], [false, false, true, true, true, true, true, false, true], [true, true, true, true, true, true, true, false, true], [false, false, true, false, true, true, true, false, true]]> : vector<4x9xi1>}> : () -> vector<4x9xi1>
    %2 = "vector.transfer_read"(%arg0, %arg1, %arg2, %0, %1) <{in_bounds = [false, false], operandSegmentSizes = array<i32: 1, 2, 1, 1>, permutation_map = #map}> : (memref<?x?xf32>, index, index, f32, vector<4x9xi1>) -> vector<9x4xf32>
    "func.return"(%2) : (vector<9x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

