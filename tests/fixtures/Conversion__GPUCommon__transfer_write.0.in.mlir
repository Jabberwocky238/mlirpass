#map = affine_map<(d0, d1) -> (d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, memref<1024x1024xf32>, vector<1xf32>) -> (), sym_name = "warp_extract"}> ({
  ^bb0(%arg0: index, %arg1: memref<1024x1024xf32>, %arg2: vector<1xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    "gpu.warp_execute_on_lane_0"(%arg0) <{warp_size = 32 : i64}> ({
      "vector.transfer_write"(%arg2, %arg1, %0, %0) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<1xf32>, memref<1024x1024xf32>, index, index) -> ()
      "gpu.yield"() : () -> ()
    }) : (index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

