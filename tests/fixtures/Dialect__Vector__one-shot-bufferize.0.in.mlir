#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>, vector<16xf32>, index, vector<16xi1>) -> tensor<?xf32>, sym_name = "mask"}> ({
  ^bb0(%arg4: tensor<?xf32>, %arg5: vector<16xf32>, %arg6: index, %arg7: vector<16xi1>):
    %2 = "vector.mask"(%arg7) ({
      %3 = "vector.transfer_write"(%arg5, %arg4, %arg6) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<16xf32>, tensor<?xf32>, index) -> tensor<?xf32>
      "vector.yield"(%3) : (tensor<?xf32>) -> ()
    }) : (vector<16xi1>) -> tensor<?xf32>
    "func.return"(%2) : (tensor<?xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<?xf32>, vector<[16]xf32>, index, vector<[16]xi1>) -> tensor<?xf32>, sym_name = "mask_scalable"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: vector<[16]xf32>, %arg2: index, %arg3: vector<[16]xi1>):
    %0 = "vector.mask"(%arg3) ({
      %1 = "vector.transfer_write"(%arg1, %arg0, %arg2) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<[16]xf32>, tensor<?xf32>, index) -> tensor<?xf32>
      "vector.yield"(%1) : (tensor<?xf32>) -> ()
    }) : (vector<[16]xi1>) -> tensor<?xf32>
    "func.return"(%0) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x10xf32>, vector<6x11xf32>) -> tensor<5x10xf32>, sym_name = "non_reading_xfer_write"}> ({
  ^bb0(%arg0: tensor<5x10xf32>, %arg1: vector<6x11xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "vector.transfer_write"(%arg1, %arg0, %0, %0) <{in_bounds = [false, false], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<6x11xf32>, tensor<5x10xf32>, index, index) -> tensor<5x10xf32>
    "func.return"(%1) : (tensor<5x10xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x10xf32>, vector<4x11xf32>) -> tensor<5x10xf32>, sym_name = "reading_xfer_write"}> ({
  ^bb0(%arg0: tensor<5x10xf32>, %arg1: vector<4x11xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "vector.transfer_write"(%arg1, %arg0, %0, %0) <{in_bounds = [false, false], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<4x11xf32>, tensor<5x10xf32>, index, index) -> tensor<5x10xf32>
    "func.return"(%1) : (tensor<5x10xf32>) -> ()
  }) : () -> ()
}) : () -> ()

