#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>, vector<16xf32>, index, vector<16xi1>) -> tensor<?xf32>, sym_name = "mask"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: vector<16xf32>, %arg2: index, %arg3: vector<16xi1>):
    %0 = "vector.mask"(%arg3) ({
      %1 = "vector.transfer_write"(%arg1, %arg0, %arg2) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<16xf32>, tensor<?xf32>, index) -> tensor<?xf32>
      "vector.yield"(%1) : (tensor<?xf32>) -> ()
    }) : (vector<16xi1>) -> tensor<?xf32>
    "func.return"(%0) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

