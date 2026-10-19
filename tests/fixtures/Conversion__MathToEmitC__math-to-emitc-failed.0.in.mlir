"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4xf32>) -> tensor<4xf32>, sym_name = "unsupported_tensor_type"}> ({
  ^bb0(%arg0: tensor<4xf32>):
    %0 = "math.absf"(%arg0) <{fastmath = #arith.fastmath<none>}> : (tensor<4xf32>) -> tensor<4xf32>
    "func.return"(%0) : (tensor<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f16) -> f16, sym_name = "unsupported_f16_type"}> ({
  ^bb0(%arg0: f16):
    %0 = "math.absf"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
    "func.return"(%0) : (f16) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f128) -> f128, sym_name = "unsupported_f128_type"}> ({
  ^bb0(%arg0: f128):
    %0 = "math.absf"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f128) -> f128
    "func.return"(%0) : (f128) -> ()
  }) : () -> ()
}) : () -> ()

