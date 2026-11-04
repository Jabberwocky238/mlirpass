#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>) -> tensor<?xf32>, sym_name = "foo"}> ({
  ^bb0(%arg2: tensor<?xf32>):
    %3 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %4 = "arith.constant"() <{value = 0 : index}> : () -> index
    %5 = "tensor.insert"(%3, %arg2, %4) : (f32, tensor<?xf32>, index) -> tensor<?xf32>
    "func.return"(%5) : (tensor<?xf32>) -> ()
  }) : () -> ()
  "func.func"() <{arg_attrs = [{bufferization.writable = true}, {}], function_type = (tensor<?xf32>, index) -> vector<5xf32>, sym_name = "contains_to_buffer_op"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: index):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<?xf32>) -> memref<?xf32>
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "vector.transfer_read"(%0, %arg1, %1) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (memref<?xf32>, index, f32) -> vector<5xf32>
    "func.return"(%2) : (vector<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

