"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x16xf32>, tensor<1x16xf32>) -> tensor<1x16xf32>, sym_name = "mapped_custom"}> ({
  ^bb0(%arg0: tensor<1x16xf32>, %arg1: tensor<1x16xf32>):
    %0 = "tosa.custom"(%arg0, %arg1) <{domain_name = "my:custom", implementation_attrs = "{\22param\22:\22value\22}", operator_name = "TestOp"}> : (tensor<1x16xf32>, tensor<1x16xf32>) -> tensor<1x16xf32>
    "func.return"(%0) : (tensor<1x16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x16xf32>) -> tensor<1x16xf32>, sym_name = "other_custom"}> ({
  ^bb0(%arg0: tensor<1x16xf32>):
    %0 = "tosa.custom"(%arg0) <{domain_name = "com.example.accel", implementation_attrs = "{}", operator_name = "ExampleOp"}> : (tensor<1x16xf32>) -> tensor<1x16xf32>
    "func.return"(%0) : (tensor<1x16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x16xf32>) -> tensor<1x16xf32>, sym_name = "empty_strings"}> ({
  ^bb0(%arg0: tensor<1x16xf32>):
    %0 = "tosa.custom"(%arg0) <{domain_name = "my:custom", implementation_attrs = "", operator_name = ""}> : (tensor<1x16xf32>) -> tensor<1x16xf32>
    "func.return"(%0) : (tensor<1x16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

