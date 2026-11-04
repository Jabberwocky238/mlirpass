"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32, index) -> tensor<3xf32, 1 : i64>, sym_name = "from_elements"}> ({
  ^bb0(%arg0: f32, %arg1: f32, %arg2: index):
    %0 = "tensor.from_elements"(%arg0, %arg0, %arg0) : (f32, f32, f32) -> tensor<3xf32, 1 : i64>
    %1 = "tensor.insert"(%arg1, %0, %arg2) : (f32, tensor<3xf32, 1 : i64>, index) -> tensor<3xf32, 1 : i64>
    "func.return"(%1) : (tensor<3xf32, 1 : i64>) -> ()
  }) : () -> ()
}) : () -> ()

