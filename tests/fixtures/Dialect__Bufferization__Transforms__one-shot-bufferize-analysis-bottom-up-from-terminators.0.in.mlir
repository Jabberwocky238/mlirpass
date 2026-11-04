#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index, f32, f32) -> (tensor<5xf32>, tensor<5xf32>), sym_name = "simple_test"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: f32, %arg4: f32):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "tensor.empty"() : () -> tensor<5xf32>
    %3 = "scf.for"(%arg0, %arg1, %arg2, %2) ({
    ^bb0(%arg11: index, %arg12: tensor<5xf32>):
      %9 = "linalg.fill"(%arg3, %arg12) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg15: f32, %arg16: f32):
        "linalg.yield"(%arg15) : (f32) -> ()
      }) : (f32, tensor<5xf32>) -> tensor<5xf32>
      %10 = "linalg.fill"(%arg4, %arg12) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg13: f32, %arg14: f32):
        "linalg.yield"(%arg13) : (f32) -> ()
      }) : (f32, tensor<5xf32>) -> tensor<5xf32>
      %11 = "vector.transfer_read"(%9, %0, %1) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (tensor<5xf32>, index, f32) -> vector<5xf32>
      "vector.print"(%11) <{punctuation = #vector.punctuation<newline>}> : (vector<5xf32>) -> ()
      "scf.yield"(%10) : (tensor<5xf32>) -> ()
    }) : (index, index, index, tensor<5xf32>) -> tensor<5xf32>
    %4 = "tensor.empty"() : () -> tensor<5xf32>
    %5 = "scf.for"(%arg0, %arg1, %arg2, %2) ({
    ^bb0(%arg5: index, %arg6: tensor<5xf32>):
      %6 = "linalg.fill"(%arg3, %arg6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg9: f32, %arg10: f32):
        "linalg.yield"(%arg9) : (f32) -> ()
      }) : (f32, tensor<5xf32>) -> tensor<5xf32>
      %7 = "linalg.fill"(%arg4, %arg6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg7: f32, %arg8: f32):
        "linalg.yield"(%arg7) : (f32) -> ()
      }) : (f32, tensor<5xf32>) -> tensor<5xf32>
      %8 = "vector.transfer_read"(%7, %0, %1) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (tensor<5xf32>, index, f32) -> vector<5xf32>
      "vector.print"(%8) <{punctuation = #vector.punctuation<newline>}> : (vector<5xf32>) -> ()
      "scf.yield"(%6) : (tensor<5xf32>) -> ()
    }) : (index, index, index, tensor<5xf32>) -> tensor<5xf32>
    "func.return"(%3, %5) : (tensor<5xf32>, tensor<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

