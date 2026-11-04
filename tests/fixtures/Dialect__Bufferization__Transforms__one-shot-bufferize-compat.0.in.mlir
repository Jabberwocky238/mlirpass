"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>) -> (f32, f32), sym_name = "out_of_place_bufferization"}> ({
  ^bb0(%arg0: tensor<?xf32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 5 : index}> : () -> index
    %2 = "tensor.insert"(%0, %arg0, %1) : (f32, tensor<?xf32>, index) -> tensor<?xf32>
    %3 = "tensor.extract"(%arg0, %1) : (tensor<?xf32>, index) -> f32
    %4 = "tensor.extract"(%2, %1) : (tensor<?xf32>, index) -> f32
    "func.return"(%3, %4) : (f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

