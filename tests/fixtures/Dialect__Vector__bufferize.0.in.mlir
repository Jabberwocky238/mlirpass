#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>, index, index, f32) -> vector<5x6xf32>, sym_name = "transfer_read"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: index, %arg2: index, %arg3: f32):
    %0 = "vector.transfer_read"(%arg0, %arg1, %arg2, %arg3) <{in_bounds = [true, false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<?x?xf32>, index, index, f32) -> vector<5x6xf32>
    "func.return"(%0) : (vector<5x6xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>, index, index, vector<5x6xf32>, vector<5x6xi1>) -> tensor<?x?xf32>, sym_name = "transfer_write"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: index, %arg2: index, %arg3: vector<5x6xf32>, %arg4: vector<5x6xi1>):
    %0 = "vector.transfer_write"(%arg3, %arg0, %arg1, %arg2, %arg4) <{in_bounds = [true, false], operandSegmentSizes = array<i32: 1, 1, 2, 1>, permutation_map = #map}> : (vector<5x6xf32>, tensor<?x?xf32>, index, index, vector<5x6xi1>) -> tensor<?x?xf32>
    "func.return"(%0) : (tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<16x16xf32>, vector<16xi32>, vector<16xi1>, vector<16xf32>) -> tensor<16x16xf32>, sym_name = "scatter"}> ({
  ^bb0(%arg0: tensor<16x16xf32>, %arg1: vector<16xi32>, %arg2: vector<16xi1>, %arg3: vector<16xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "vector.scatter"(%arg0, %0, %0, %arg1, %arg2, %arg3) : (tensor<16x16xf32>, index, index, vector<16xi32>, vector<16xi1>, vector<16xf32>) -> tensor<16x16xf32>
    "func.return"(%1) : (tensor<16x16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>, vector<16xi32>, vector<16xi1>, vector<16xf32>) -> vector<16xf32>, sym_name = "gather"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: vector<16xi32>, %arg2: vector<16xi1>, %arg3: vector<16xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "vector.gather"(%arg0, %0, %0, %arg1, %arg2, %arg3) : (tensor<?x?xf32>, index, index, vector<16xi32>, vector<16xi1>, vector<16xf32>) -> vector<16xf32>
    "func.return"(%1) : (vector<16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

